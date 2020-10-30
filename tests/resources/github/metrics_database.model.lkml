connection: "data_warehouse"

include: "github*[!.][!z].view.lkml"
include: "ucp*[!.][!z].view.lkml"
include: "aggregate*[!.][!z].view.lkml"
include: "sf__accounts.view.lkml"
include: "sf__opportunit*[!.][!z].view.lkml"
include: "sf__leads.view.lkml"
include: "sf__cases.view.lkml"
include: "sf__accounts.view.lkml"
include: "sf__opportunity_products.view.lkml"
include: "reghub*[!.][!z].view.lkml"
include: "docker_user_statuses.view.lkml"
include: "docker_user_activities.view.lkml"
include: "wootric_csat.view.lkml"
include: "weekly_report.view.lkml"
include: "mobilize.view.lkml"
include: "dtr*[!.][!z].view.lkml"
include: "docker_active_hosts.view.lkml"
include: "metr*[!.][!z].view.lkml"
include: "ga_user*[!.][!.z].view.lkml"
include: "pinata_mixpanel.view.lkml"

include: "pingdom*[!.][!.z].view.lkml"
include: "meetup*[!.][!.z].view.lkml"
include: "highland*[!.][!.z].view.lkml"
include: "marketo*[!.][!.z].view.lkml"
include: "job*[!.][!.z].view.lkml"

# include all the dashboards
include: "docker_swarm.dashboard.lookml"
include: "github_metrics.dashboard.lookml"
include: "google_analytics.dashboard.lookml"
include: "meetup_dashboard.dashboard.lookml"

# Define the Fiscal Year offset
fiscal_month_offset:  -11 # starts in February

explore: aggregate_metrics {
  join: repositories {
    from: reghub_repositories
    sql_on: ${aggregate_metrics.repo_name} = ${repositories.repo_name} ;;
    relationship: many_to_one
  }
}

explore: docker_user_statuses {}

explore: wootric_csat {}

explore: mobilize {}


explore: docker_ucp {
  label: "Docker UCP Usage"
  from: ucp_usage
}

explore: ucp_licenses {
  label: "Docker UCP Licenses"
  view_label: "Docker UCP Licenses"
  description: "Docker UCP licenses"
  from: ucp_licensing

  join: docker_users {
    from: reghub_dockeruser
    sql_on: ${ucp_licenses.hub_uuid} = replace(${docker_users.uuid}, '-','') ;;
    relationship: many_to_one
  }

  join: repositories {
    from: reghub_repositories
    sql_on: ${ucp_licenses.hub_uuid} = replace(${repositories.hub_user_id}, '-','') ;;
    relationship: many_to_one
  }

  join: ucp_usage {
    sql_on: ${ucp_usage.license_key} = ${ucp_licenses.license_key} ;;
    relationship: many_to_one
  }

  join: dtr_usage {
    from: dtr_server_stats
    sql_on: ${dtr_usage.license_key} = ${ucp_licenses.license_key} ;;
    relationship: many_to_one
  }

  join: sf__accounts {
    view_label: "SFDC Accounts"
    sql_on: ${docker_users.domain_name} = ${sf__accounts.domain} ;;
    relationship: many_to_one
  }

  join: sf__opportunities {
    view_label: "SFDC Opportunities"
    sql_on: ${sf__opportunities.account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }

  join: opportunity_products {
    from: sf__opportunity_products
    view_label: "Opportunitiy Products"
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many
  }

  join: support_users {
    from: sf__accounts
    sql_on: ${support_tickets.account_id} = ${support_users.id} ;;
    relationship: many_to_one
    required_joins: [support_tickets]
  }

  join: support_tickets {
    from: sf__cases
    sql_on: ${docker_users.email} = ${support_tickets.contact_email} ;;
    relationship: many_to_one
  }
  join: sf__leads {
    view_label: "Leads"
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: one_to_one
  }
}

# View supporting marketing automation.  View is derived from an explore.
view: marketo_ddc {
  derived_table: {
    explore_source: ucp_licenses {
      column: email { field: docker_users.email }
      column: expiration_date {}
      column: controller_avg_count { field: ucp_usage.controller_avg_count }
      column: node_avg_count { field: ucp_usage.node_avg_count }
      column: container_avg_count { field: ucp_usage.container_avg_count }
      column: hub_uuid {}
      filters: {
        field: ucp_licenses.tier
        value: "-Production,-Team"
      }
      filters: {
        field: docker_users.username
        value: "-NULL"
      }
    }
  }
  dimension: email {
    sql: ${TABLE}.email ;;
    tags: ["email"]
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.hub_uuid ;;
    tags: ["user_id"]
  }
  dimension: expiration_date {
    type: date
    sql: ${TABLE}.expiration_date ;;
  }
  dimension: node_avg_count {
    label: "DDC Eval Nodes (#)"
    type:  number
    sql: CAST(${TABLE}.node_avg_count AS INT) ;;
  }
  dimension: container_avg_count {
    label: "DDC Eval Containers (#)"
    type:  number
    sql: CAST(${TABLE}.container_avg_count AS INT) ;;
  }
  dimension: controller_avg_count {
    label: "DDC Eval Controllers (#)"
    type:  number
    sql: CAST(${TABLE}.controller_avg_count AS INT) ;;
  }
}

# Hidden explore for use by marketing automation.  Projects a specific set of values.
explore: marketo_ddc { hidden: yes }

explore: Pinata {
  from: pinata_mixpanel
}

explore: docker_dtr {
  label: "Docker DTR Mixpanel Usage"
  from: dtr_mixpanel
}

explore: dtr_trial_conversion_to_purchases {}

explore: docker_user_activities {}

explore: highland_metrics {}

explore: ga_user_page_views {}

explore: ga_user_page_view_sessions {}

explore: ga_user_page_view_sessions_segments {}

explore: ga_user_page_view_sessions_month {}

explore: ga_user_page_view_sessions_week {}

explore: metrics_counter {}

explore: metrics {
  hidden: yes
}

explore: metrics_searchlog {}

# - explore: garant_log

explore: highland_build_requests {
  join: repositories {
    from: reghub_repositories
    sql_on: ${highland_build_requests.docker_repo} = ${repositories.repo_name} ;;
    relationship: many_to_one
  }

  join: docker_users {
    from: reghub_dockeruser
    sql_on: ${repositories.hub_user_id} = ${docker_users.uuid} ;;
    relationship: many_to_one
  }
}

explore: highland_build_requests_bins {
  hidden: yes
}

# - explore: metrics_apilog_ipaddresses

explore: metrics_weblog {}

explore: meetup_groups {
  join: meetup_events {
    sql_on: meetup_events.group_id = meetup_groups.id ;;
    relationship: one_to_many
  }
}

explore: github_pullrequests {}

explore: github_forks {}

explore: github_issues {
}

explore: github_releases {}

explore: github_commits {}

explore: pingdom_responsetime {
  join: pingdom_probes {
    sql_on: pingdom_probes.id = pingdom_responsetime.probe_id ;;
    relationship: many_to_one
  }

  join: pingdom_checks {
    sql_on: pingdom_checks.id = pingdom_responsetime.check_id ;;
    relationship: many_to_one
  }
}

explore: meetup_events {
  join: meetup_groups {
    sql_on: meetup_events.group_id = meetup_groups.id ;;
    relationship: many_to_one
  }
}

explore: pingdom_status {
  join: pingdom_checks {
    sql_on: pingdom_checks.id = pingdom_status.check_id ;;
    relationship: many_to_one
  }
}

# - explore: metrics_current
#   joins:
#     - join: calendar
#       sql_on: cast(metrics_current.created_at as date) = calendar.created and metrics_current.name = calendar.name
#       relationship: many_to_one

explore: metrics_daily_diff {}

explore: metrics_monthly_diff {}

explore: metrics_weekly_diff {}
