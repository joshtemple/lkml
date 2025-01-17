connection: "snowflake_medium"

include: "docker_for_desk*[!.][!z].view.lkml"
include: "pinata_heartbeats.view.lkml"
include: "pinata_settings_changed.view.lkml"
include: "pinata_active_users.view.lkml"
include: "pinata_staging_active_users.view.lkml"
include: "pinata_weekly_ranked_versions.view.lkml"
include: "performance_dashboard_engineering.dashboard.lookml"

explore: active_users {
  from: pinata_active_users
}
explore: staging_active_users {
  from: pinata_staging_active_users
}

# NDT for building aggregate active user counts
view: active_users_aggregate {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE ;;
    explore_source: active_users {
      column: created_date {}
      column: created_week {}
      column: created_month {}
      column: count_users {}
      column: os {}
      filters: {
        field: active_users.created_month
        value: "18 months ago for 18 months"
      }
      filters: {
        field: active_users.os
        value: "-EMPTY"
      }
    }
  }
  dimension: created_date {
    type: date
  }
  dimension: count_users {
    type: number
  }
  dimension: os {}
  dimension: created_week {
    type: date_week
  }
  dimension: created_month {
    type: date_month
  }
  measure: max_users {
    type: max
    sql: ${TABLE}.count_users ;;
  }
}
explore: active_users_aggregate {}

explore: vm_info {
  label: "VM Info"
  from: docker_for_desktops_vm_info
}

explore: pinata_weekly_ranked_versions {
  hidden: yes
}

explore: heartbeats {
  from: pinata_heartbeats
}

explore: settings_changed {
  from: pinata_settings_changed
  description: "Setting events logged when users update Docker for desktop settings"

  join: pinata_heartbeats {
    view_label: "Heartbeats"
    relationship: many_to_one
    sql_on: ${pinata_heartbeats.distinct_id} = ${settings_changed.user_id} ;;
  }
}

explore: staging_heartbeats {
  from: pinata_heartbeats
  sql_table_name: SEGMENT.dev_docker_for_desktops_app.heartbeat ;;
}

explore: staging_settings_changed {
  from: pinata_settings_changed
  sql_table_name: SEGMENT.dev_docker_for_desktops_app.action_settings_changed ;;
  description: "Setting events logged when users update Docker for desktop settings"

  join: pinata_heartbeats {
    view_label: "Heartbeats"
    relationship: many_to_one
    sql_table_name: SEGMENT.dev_docker_for_desktops_app.heartbeat ;;
    sql_on: ${pinata_heartbeats.distinct_id} = ${staging_settings_changed.user_id} ;;
  }
}

explore: staging_events{
  label: "Staging Desktop Tracked Events"
  view_label: "Tracked Events"
  from: docker_for_desktop_tracks

  join: docker_for_desktops_daily_heartbeat{
    view_label: "Daily heartbeat"
    sql_on: ${docker_for_desktops_daily_heartbeat.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }

  join: docker_for_desktop_heartbeat{
    view_label: "Heartbeat"
    sql_on: ${docker_for_desktop_heartbeat.id}= ${staging_events.id} ;;
    relationship: one_to_one
  }

  join: docker_for_desktops_action_designer_application_created {
    view_label: "action_designer_application_created"
    sql_on: ${docker_for_desktops_action_designer_application_created.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }
  join: docker_for_desktops_action_desginer_application_deleted {
    view_label: "action_designer_application_deleted"
    sql_on: ${docker_for_desktops_action_desginer_application_deleted.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }
  join: docker_for_desktops_action_designer_application_restarted {
    view_label: "action_designer_application_restarted"
    sql_on: ${docker_for_desktops_action_designer_application_restarted.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }
  join: docker_for_desktops_action_designer_application_started {
    view_label: "action_designer_application_started"
    sql_on: ${docker_for_desktops_action_designer_application_started.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }
  join: docker_for_desktops_action_designer_application_stopped {
    view_label: "action_designer_application_stopped"
    sql_on: ${docker_for_desktops_action_designer_application_stopped.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }
  join: docker_for_desktops_action_designer_open_editor {
    view_label: "action_designer_open_editor"
    sql_on: ${docker_for_desktops_action_designer_open_editor.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }

  join: docker_for_desktops_action_menu_open_enterprise_edition {
    view_label: "action_menu_open_enterprise_edition"
    sql_on: ${docker_for_desktops_action_menu_open_enterprise_edition.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }
  join: docker_for_desktops_event_expired_license_detected {
    view_label: "event_expired_license_detected"
    sql_on: ${docker_for_desktops_event_expired_license_detected.id} = ${staging_events.id} ;;
    relationship: one_to_one
  }
  join: docker_for_desktop_identifies {
    view_label: "Identifies"
    sql_on: ${docker_for_desktop_identifies.user_id} = ${staging_events.user_id} ;; # A given User may have many Identify calls
    relationship: one_to_many
  }
  join: docker_for_desktops_users {
    view_label: "Users"
    sql_on: ${docker_for_desktops_users.id} = ${staging_events.user_id} ;;
    relationship: many_to_one
  }
}


explore: production_events{
  label: "Production Desktop Tracked Events"
  view_label: "Tracked Events"
  from: docker_for_desktop_tracks
  sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."TRACKS";;

  join: docker_for_desktops_daily_heartbeat{
    view_label: "Daily heartbeat"
    sql_on: ${docker_for_desktops_daily_heartbeat.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."DAILY_HEARTBEAT";;
  }

  join: docker_for_desktop_heartbeat{
    view_label: "Heartbeat"
    sql_on: ${docker_for_desktop_heartbeat.id}= ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."HEARTBEAT";;
  }

  join: docker_for_desktops_action_designer_application_created {
    view_label: "action_designer_application_created"
    sql_on: ${docker_for_desktops_action_designer_application_created.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name:  "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."ACTION_DESIGNER_APPLICATION_CREATED";;
  }

  join: docker_for_desktops_action_desginer_application_deleted {
    view_label: "action_designer_application_deleted"
    sql_on: ${docker_for_desktops_action_desginer_application_deleted.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."ACTION_DESIGNER_APPLICATION_DELETED"  ;;
  }
  join: docker_for_desktops_action_designer_application_restarted {
    view_label: "action_designer_application_restarted"
    sql_on: ${docker_for_desktops_action_designer_application_restarted.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."ACTION_DESIGNER_APPLICATION_RESTARTED"  ;;
  }
  join: docker_for_desktops_action_designer_application_started {
    view_label: "action_designer_application_started"
    sql_on: ${docker_for_desktops_action_designer_application_started.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name:  "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."ACTION_DESIGNER_APPLICATION_STARTED" ;;
  }
  join: docker_for_desktops_action_designer_application_stopped {
    view_label: "action_designer_application_stopped"
    sql_on: ${docker_for_desktops_action_designer_application_stopped.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name:  "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."ACTION_DESIGNER_APPLICATION_STOPPED" ;;
  }
  join: docker_for_desktops_action_designer_open_editor {
    view_label: "action_designer_open_editor"
    sql_on: ${docker_for_desktops_action_designer_open_editor.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name:  "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."ACTION_DESIGNER_OPEN_EDITOR" ;;
  }

  join: docker_for_desktops_action_menu_open_enterprise_edition {
    view_label: "action_menu_open_enterprise_edition"
    sql_on: ${docker_for_desktops_action_menu_open_enterprise_edition.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name:  "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."ACTION_MENU_OPEN_ENTERPRISE_EDITION";;

  }
  join: docker_for_desktops_event_expired_license_detected {
    view_label: "event_expired_license_detected"
    sql_on: ${docker_for_desktops_event_expired_license_detected.id} = ${production_events.id} ;;
    relationship: one_to_one
    sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."EVENT_EXPIRED_LICENSE_DETECTED" ;;
  }
  join: docker_for_desktop_identifies {
    view_label: "Identifies"
    sql_on: ${docker_for_desktop_identifies.user_id} = ${production_events.user_id} ;;
    # A given User may have many Identify calls
    relationship: one_to_many
    sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."IDENTIFIES" ;;
  }
  join: docker_for_desktops_users {
    view_label: "Users"
    sql_on: ${docker_for_desktops_users.id} = ${production_events.user_id} ;;
    relationship: many_to_one
    sql_table_name: "SEGMENT"."BETA_DOCKER_FOR_DESKTOPS_APP"."USERS"  ;;
  }
}
