connection: "data_warehouse"

include: "ucp*[!.][!z].view.lkml"
include: "weekly*[!.][!z].view.lkml"
include: "dtr*[!.][!z].view.lkml"
include: "reghub*[!.][!z].view.lkml"
include: "sf__accounts.view.lkml"
include: "sf__cases.view.lkml"

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# - explore: order_items
#   joins:
#     - join: orders
#       sql_on: ${orders.id} = ${order_items.order_id}
#     - join: users
#       sql_on: ${users.id} = ${orders.user_id}
explore: weekly_purchased_ucp_avg_stats {}

explore: ucp_action_list {
  hidden: yes
}

explore: user_action_facts {
  from: ucp_user_action_facts
  view_label: "UI Actions"
  label: "UI Actions"

  join: user_actions {
    from: ucp_user_action
    view_label: "UI Actions"
    type: left_outer
    relationship: one_to_one
    sql_on: user_actions.uuid = user_action_facts.uuid and
      user_actions.received_at = user_action_facts.received_at
       ;;
  }

  join: session_user_actions {
    from: ucp_sessions_user_actions
    view_label: "Sessions"
    type: left_outer
    sql_on: ${user_action_facts.session_id} = ${session_user_actions.session_id} ;;
    relationship: many_to_one
  }

  join: sessions_user_action_facts {
    from: ucp_sessions_user_action_facts
    view_label: "Sessions"
    type: left_outer
    sql_on: ${user_action_facts.session_id} = ${sessions_user_action_facts.session_id} ;;
    relationship: many_to_one
  }

  join: session_facts {
    from: ucp_session_facts
    view_label: "Users"
    type: left_outer
    sql_on: ${user_action_facts.ucp_user_id} = ${session_facts.ucp_user_id} ;;
    relationship: many_to_one
  }

  join: users {
    from: ucp_users
    view_label: "Users"
    type: left_outer
    sql_on: ${session_facts.ucp_user_id} = ${users.id} ;;
    relationship: one_to_one
  }

  join: user_actions_flow {
    from: ucp_user_actions_flow
    view_label: "User Actions Flow"
    sql_on: ${user_action_facts.action_id} = ${user_actions_flow.action_id} ;;
    relationship: one_to_one
  }
}

explore: funnel_explorer {
  view_label: "UI Funnel"
  label: "UI Funnel"
  from: ucp_user_actions_funnel

  join: session_user_actions {
    from: ucp_sessions_user_actions
    view_label: "Sessions"
    foreign_key: session_id
  }

  join: sessions_user_action_facts {
    from: ucp_sessions_user_action_facts
    view_label: "Users"
    foreign_key: session_user_actions.ucp_user_id
  }

  join: session_facts {
    from: ucp_session_facts
    view_label: "Sessions"
    relationship: one_to_one
    foreign_key: session_id
  }

  join: users {
    from: ucp_users
    view_label: "Users"
    type: left_outer
    sql_on: ${session_facts.ucp_user_id} = ${users.id} ;;
    relationship: one_to_one
  }
}


explore: session_user_actions {
  description: "New sessions are created after 30 minutes of inactivity"
  from: ucp_sessions_user_actions
  label: "Session User Actions"
  join: sessions_user_action_facts {
    from: ucp_sessions_user_action_facts
    view_label: "Sessions"
    sql_on: ${session_user_actions.session_id} = ${sessions_user_action_facts.session_id} ;;
    relationship: one_to_one
  }

  join: session_facts {
    from: ucp_session_facts
    view_label: "Users"
    sql_on: ${session_user_actions.ucp_user_id} = ${session_facts.ucp_user_id} ;;
    relationship: many_to_one
  }
}

explore: ucp_licenses {
  label: "Global View"
  view_label: "UCP Licenses"
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
    view_label: "UCP Cluster Usage"
    sql_on: ${ucp_usage.license_key} = ${ucp_licenses.license_key} ;;
    relationship: many_to_one
  }

  join: ucp_api_usage {
    from: ucp_api
    view_label: "UCP API Usage"
    sql_on: ${ucp_usage.user_id} = ${ucp_api_usage.user_id} ;;
    relationship: many_to_one
  }

  join: dtr_usage {
    from: dtr_server_stats
    view_label: "DTR Usage"
    sql_on: ${dtr_usage.license_key} = ${ucp_licenses.license_key} ;;
    relationship: many_to_one
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
}
