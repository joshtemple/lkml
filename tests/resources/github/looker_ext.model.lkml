include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/base_looker1/*.view"
include: "/base_looker1/*.model"

explore: project_status {
  hidden: yes
}

explore: content_view  {
  hidden: yes
}

explore: user_weekly_app_activity_period_over_period {
  hidden: yes
}

explore: pdt_state {}

explore: field_usage_full {
  extends: [field_usage]
  from: field_usage
  view_name: field_usage
}

explore: user_full {
  extends: [user]
  view_name: user
  from: user_extended
  join: credentials_email {
    sql_on: ${user.id} = ${credentials_email.user_id} ;;
    relationship: many_to_one
  }
  join: credentials_google {
    sql_on: ${user.id} = ${credentials_google.user_id} ;;
    relationship: many_to_one
  }
  join: credentials_ldap {
    sql_on: ${user.id} = ${credentials_ldap.user_id} ;;
    relationship: many_to_one
  }
  join: credentials_saml {
    sql_on: ${user.id} = ${credentials_saml.user_id} ;;
    relationship: many_to_one
  }
}

explore: history_full {
  extends: [history]
  view_name: history
  from: history_full
  join: user {
    from: user_extended
  }
  join: credentials_email {
    sql_on: ${user.id} = ${credentials_email.user_id} ;;
    relationship: many_to_one
    fields: []
  }
  join: credentials_google {
    sql_on: ${user.id} = ${credentials_google.user_id} ;;
    relationship: many_to_one
    fields: []
  }
  join: credentials_ldap {
    sql_on: ${user.id} = ${credentials_ldap.user_id} ;;
    relationship: many_to_one
    fields: []
  }
  join: credentials_saml {
    sql_on: ${user.id} = ${credentials_saml.user_id} ;;
    relationship: many_to_one
    fields: []
  }
  join: dashboard_filters {
    sql_on: ${history.dashboard_run_session_id} = ${dashboard_filters.run_session_id}  ;;
    relationship: many_to_one
  }
}


explore: pdt_log_full  {
  extends: [pdt_log]
  from: pdt_log
 view_name: pdt_log
}

explore: scheduled_plan_full  {
  extends: [scheduled_plan]
  from: scheduled_plan
  view_name: scheduled_plan
  join: scheduled_job {
    from: scheduled_job_extended
  }
}

explore: event_full {
  extends: [event]
  from: event_extended
  view_name: event
}

explore: look_full {
  extends: [look]
  from: look_extended
  view_name: look
}

explore: dashboard_full {
  extends: [dashboard]
  from: dashboard_layout_component
  view_name: dashboard_layout_component
  join: dashboard {
    from: dashboard_extended
  }
}

explore: dashboard_performance_full {
  from: dashboard_run_event_stats
  fields: [ALL_FIELDS*, -user.roles]
  view_label: "Dashboard Performance"
  view_name: dashboard_performance

  always_filter: {
    filters: {
      field: dashboard_performance.raw_data_timeframe
      value: "2 hours"
    }
  }

  join: dashboard_run_history_facts {
    view_label: "Dashboard Performance"
    sql_on: ${dashboard_performance.dashboard_run_session} = ${dashboard_run_history_facts.dashboard_run_session_id} ;;
    relationship: one_to_one
  }

  join: dashboard_page_event_stats {
    view_label: "Dashboard Performance"
    sql_on: ${dashboard_performance.dashboard_page_session} = ${dashboard_page_event_stats.dashboard_page_session} ;;
    relationship: many_to_one
  }

  join: dashboard_filters {
    view_label: "Dashboard Performance"
    relationship: many_to_one
    sql_on: ${dashboard_filters.run_session_id} = ${dashboard_performance.dashboard_run_session} ;;
  }

  join: user {
    relationship: many_to_one
    sql_on: ${dashboard_performance.user_id} = ${user.id} ;;
    fields: [id, email, name, count]
  }
}

explore: content_usage {
  join: dashboard {
    relationship: one_to_one
    sql_on: ${content_usage.content_id} = ${dashboard.id} and ${content_usage.content_type} = "dashboard";;
  }
  join: look {
    relationship: one_to_one
    sql_on: ${content_usage.content_id} = ${look.id} and ${content_usage.content_type} = "look";;
  }
}

explore: user_daily_query_activity {
  view_label: "Daily User Activity"
  hidden: yes
  join: user_daily_app_activity {
    relationship: one_to_many
    view_label: "Daily User Activity"
    sql_on: ${user_daily_query_activity.created_date} = ${user_daily_app_activity.created_date} and ${user_daily_query_activity.user_id} = ${user_daily_app_activity.user_id};;
  }
}
