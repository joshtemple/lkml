connection: "looker-private-demo"

include: "/sfdc_views/*.view.lkml"
include: "/sfdc_views/derived_tables/*.view.lkml"
include: "/zendesk_views/*.view.lkml"
include: "/zendesk_views/derived_tables/*.view.lkml"
include: "/usage_views/*.view.lkml"
include: "/usage_views/derived_tables/*.view.lkml"
include: "/jira_views/*.view.lkml"


datagroup: event_trigger {
  sql_trigger: select max(date(timestamp)) from ${event_logs.SQL_TABLE_NAME};;
}

explore: opportunity_line_item {
  label: "Opportunities"
  description: "Use this explore for looking at data related to Salesforce Opportunities, Accounts and Sales Representatives"
  join: opportunity {
    type: inner #only bring in line items with a valid opportunity
    relationship: many_to_one
    sql_on: ${opportunity.id} = ${opportunity_line_item.opportunity_id} ;;
  }
  join: product {
    view_label: "Opportunity Line Item"
    relationship: many_to_one
    sql_on: ${product.id} = ${opportunity_line_item.product_id} ;;
  }
  join: account {
    relationship: many_to_one
    sql_on: ${opportunity.account_id} = ${account.id} ;;
  }
  join: sales_rep {
    from: salesforce_user
    type: full_outer # Full outer here since we want to include reps regardless of whether or not they own an opp
    relationship: many_to_one
    sql_where: ${sales_rep.role_name} like '%Account Executive%' ;; #only bring in the sales reps
    sql_on: ${opportunity.owner_id} = ${sales_rep.id} ;;
  }
  join: sales_manager {
    fields: [sales_manager.team_alias, sales_manager.first_name, sales_manager.last_name, sales_manager.name, sales_manager.role_name, sales_manager.email, sales_manager.segment_region, sales_manager.sales_team, sales_manager.region]
    from: salesforce_user
    relationship: many_to_one
    sql_on: ${sales_rep.manager_id} = ${sales_manager.id} ;;
  }
  join: activity_calendar {
    #this calendar is for creating an NDT to look at daily active accounts
    fields: [activity_calendar.activity_date]
    from: calendar
    type: cross
    relationship: many_to_one
  }
  join: csm {
    fields: [csm.first_name, csm.last_name, csm.name, csm.role_name, csm.email,csm.hire_date, csm.hire_month, csm.hire_year]
    view_label: "Customer Success Manager"
    from: salesforce_user
    relationship: many_to_one
    sql_on: ${account.cs_manager_id} = ${csm.id} ;;
  }
}

explore: company_goals {
  view_name: opportunity_line_item
  label: "Company Goals"
  description: "Use this explore to see how the company is tracking towards financial "
  extends: [opportunity_line_item]

  #chose a select number of fields to include
  fields: [ALL_FIELDS*, -goals.goal_fields*]

  #add filters to always be included in the explores
  always_filter: {
    filters: [opportunity.time_period_filter: "Annual"]
    filters: [opportunity.opportunity_closed_in_period: "Current Period"]
  }
  join: calendar {
    relationship: many_to_one
    view_label: "Opportunity"
    type: full_outer # full outer join to get the goals for when we didnt have anything closed
    sql_on: ${calendar.calendar_date} = ${opportunity.close_date};;
  }
  join: opportunity {
    #uses extended view with the goal specific fields
    view_label: "Opportunity"
    from: opportunity_goals
    relationship: many_to_one
    sql_on: ${opportunity.id} = ${opportunity_line_item.opportunity_id} ;;
  }
  join: goals {
    #only join on quarterly goals
    sql_where: ${goals.quarter} != 'Annual' ;;
    view_label: "Quarterly Goals"
    type: left_outer
    sql_on: ${calendar.calendar_quarter_of_year} = ${goals.quarter} AND ${calendar.calendar_year} = ${goals.year} ;;
    relationship: many_to_one
  }
  join: annual_goals {
    #only join on annual goals
    sql_where: ${annual_goals.quarter} = 'Annual' ;;
    from: goals
    view_label: "Annual Goals"
    type: left_outer
    sql_on: ${calendar.calendar_year} = ${annual_goals.year} ;;
    relationship: many_to_one
  }
}

explore: daily_active_accounts {
  sql_always_where: ${daily_active_accounts.calendar_date} <= current_date() ;;
  join: year_ago_daily_active_accounts {
    fields: []
    from: daily_active_accounts
    relationship: one_to_one
    sql_on: ${daily_active_accounts.year_ago_date} = ${year_ago_daily_active_accounts.calendar_date} and ${daily_active_accounts.id} = ${year_ago_daily_active_accounts.id};;
  }
  join: account {
    relationship: many_to_one
    sql_on: ${daily_active_accounts.id} = ${account.id} ;;
  }
  join: sales_rep {
    from: salesforce_user
    relationship: many_to_one
    sql_on: ${account.owner_id} = ${sales_rep.id} ;;
  }
  join: csm {
    fields: [csm.first_name, csm.last_name, csm.name, csm.role_name, csm.email,csm.hire_date, csm.hire_month, csm.hire_year]
    view_label: "Customer Success Manager"
    from: salesforce_user
    relationship: many_to_one
    sql_on: ${account.cs_manager_id} = ${csm.id} ;;
  }
}

explore: ticket {
  sql_always_where:${ticket.via_channel} != 'sample_ticket' and ${account.account_name} is not null ;;
  label: "Zendesk Tickets"
  join: tags {
    relationship: one_to_many
    sql_on: ${ticket.id}=${tags.ticket_id} ;;
  }
  join: organization {
    relationship: many_to_one
    sql_on: ${organization.id} = ${ticket.organization_id} ;;
  }
  join: account {
    view_label: "Customer Account"
    relationship: many_to_one
    sql_on:  ${account.zendesk_organization_id}=${organization.id};;
  }
  join: assignee {
    #who the ticket was assigned to
    view_label: "Ticket Assignee"
    relationship: many_to_one
    from: zendesk_user
    sql_on: ${ticket.assignee_id}=${assignee.id} ;;
  }
  join: submitter {
    #who submitted the ticket
    fields: [submitter.email, submitter.name, submitter.role, submitter.count]
    view_label: "Customer User"
    relationship: many_to_one
    from: zendesk_user
    sql_on: ${ticket.submitter_id}=${submitter.id} ;;
  }
  join: satisfaction_ratings {
    relationship: many_to_one
    sql_on: ${satisfaction_ratings.ticket_id} = ${ticket.id} ;;
  }
  join: zendesk_issue_mapping {
    fields: []
    relationship: many_to_one
    sql_on: ${ticket.id}= ${zendesk_issue_mapping.zendesk_ticket_id} ;;
  }
  join: issue {
    view_label: "JIRA Issue"
    relationship: many_to_many
    sql_on: ${zendesk_issue_mapping.jira_issue_id} = ${issue.id};;
  }
  join: jira_user {
    relationship: many_to_one
    fields: [jira_user.name]
    view_label: "JIRA Issue"
    sql_on: ${issue.assignee} = ${jira_user.id} ;;
  }
}

explore: event_logs {
  label: "Raw Event Logs (short term)"
  view_label: "Events"
  sql_always_where:
  --just past 3 months
  ${event_sessions.session_start_date} < current_date() and ${event_sessions.session_start_date} > date_add(current_date(), interval -3 MONTH) and
  ${event_logs.timestamp_date} < current_date() and ${event_logs.timestamp_date} > date_add(current_date(), interval -3 MONTH) ;;

  conditionally_filter: {
    filters: [event_logs.timestamp_date: "90 days", event_sessions.session_start_date: "90 days"]
  }

  ##unnest JSON fields
  join: event_logs__log {
    view_label: "Events"
    sql: LEFT JOIN UNNEST([${event_logs.log}]) as event_logs__log ;;
    relationship: one_to_one
  }
  join: event_logs__log__cs_uri_stem {
    view_label: "Events"
    sql: LEFT JOIN UNNEST([${event_logs__log.cs_uri_stem}]) as event_logs__log__cs_uri_stem ;;
    relationship: one_to_one
  }
  join: event_logs__log__cs_uri_query {
    view_label: "Events"
    sql: LEFT JOIN UNNEST([${event_logs__log.cs_uri_query}]) as event_logs__log__cs_uri_query ;;
    relationship: one_to_one
  }
  join: event_sessions {
    view_label: "Sessions"
    relationship: many_to_one
    sql_on: ${event_sessions.unique_session_id} = ${event_logs.session_id} ;;
  }
  join: event_session_facts {
    view_label: "Sessions"
    relationship: one_to_one
    sql_on: ${event_sessions.unique_session_id} = ${event_session_facts.unique_session_id} ;;
  }
  join: client {
    relationship: many_to_one
    fields: []
    sql_on: ${client.id} = ${event_logs.client_id} ;;
  }
  join: account {
    relationship: many_to_one
    view_label: "Account"
    sql_on: ${client.salesforce_account_id} = ${account.id} ;;
  }
  aggregate_table: event_hourly {
    query: {
      dimensions: [timestamp_hour]
      measures: [count]
      timezone: America/Los_Angeles
    }
    materialization: {
      datagroup_trigger: event_trigger
    }
  }
  aggregate_table: event_daily {
    query: {
      dimensions: [timestamp_date]
      measures: [count]
      timezone: America/Los_Angeles
    }
    materialization: {
      datagroup_trigger: event_trigger
    }
  }
}

#daily event rollups
explore: daily_user_count {
  view_label: "Daily Product Usage"
  #look at data up until yesterday
  sql_always_where: ${daily_user_count.event_date} <= date_add(current_date(), interval -1 day) ;;
  conditionally_filter: {
    filters: [daily_user_count.event_date: "30 days"]
  }
  label: "Account Health"
  join:  daily_client_usage {
    view_label: "Daily Product Usage"
    relationship: one_to_one
    sql_on: ${daily_user_count.client_id} = ${daily_client_usage.client_id} AND ${daily_user_count.event_date} = ${daily_client_usage.event_date} ;;
  }
  join: daily_client_sessions {
    relationship: one_to_one
    sql_on: ${daily_user_count.client_id} = ${daily_client_sessions.client_id} AND ${daily_user_count.event_date} = ${daily_client_sessions.event_date} ;;
  }
  join: client {
    relationship: one_to_one
    sql_on: ${client.id} = ${daily_user_count.client_id};;
  }
  join: account {
    relationship: many_to_one
    sql_on: ${client.salesforce_account_id} = ${account.id} ;;
  }
  join: daily_account_tickets {
    relationship: one_to_one
    sql_on: ${account.id} = ${daily_account_tickets.account_id} AND ${daily_user_count.event_date} = ${daily_account_tickets.date_date} ;;
  }
  join: csm {
    fields: [csm.first_name, csm.last_name, csm.name, csm.role_name, csm.email,csm.hire_date, csm.hire_month, csm.hire_year]
    view_label: "Customer Success Manager"
    from: salesforce_user
    relationship: many_to_one
    sql_on: ${account.cs_manager_id} = ${csm.id} ;;
  }
}


# explore: first_event {
#   label: "Event Affinity"
#   from: event_logs
#   #this is limited to just looking at the past week of data and only for the most common events
#   view_label: "Events"
#
#   ##first
#   join: event_logs__log {
#     view_label: "First Event"
#     sql: LEFT JOIN UNNEST([${first_event.log}]) as event_logs__log ;;
#     relationship: one_to_one
#   }
#   join: event_logs__log__cs_uri_stem {
#     view_label: "First Event"
#     sql: LEFT JOIN UNNEST([${event_logs__log.cs_uri_stem}]) as event_logs__log__cs_uri_stem ;;
#     relationship: one_to_one
#   }
#   join: events_sessionized {
#     view_label: "First Event"
#     relationship: one_to_one
#     sql_on: ${events_sessionized.event_id} = ${first_event.event_id} ;;
#   }
#   join: second_events_sessionized {
#     from: events_sessionized
#     type: inner
#     view_label: "Second Event"
#     relationship: one_to_one
#     sql_on: ${second_events_sessionized.session_id} = ${events_sessionized.session_id} AND ${second_events_sessionized.sequence} = (${events_sessionized.sequence}-1);;
#   }
#   join: second_event {
#     from: event_logs
#     view_label: "Second Event"
#     relationship: one_to_one
#     sql_on: ${second_events_sessionized.event_id} = ${second_event.event_id}  ;;
#   }
#   join: second_event_logs__log {
#     from: event_logs__log
#     view_label: "Second Event"
#     sql: LEFT JOIN UNNEST([${second_event.log}]) as second_event_logs__log ;;
#     relationship: one_to_one
#   }
#   join: second_event_logs__log__cs_uri_stem {
#     from: event_logs__log__cs_uri_stem
#     view_label: "Second Event"
#     sql: LEFT JOIN UNNEST([${second_event_logs__log.cs_uri_stem}]) as second_event_logs__log__cs_uri_stem ;;
#     relationship: one_to_one
#   }
#
#
# }
