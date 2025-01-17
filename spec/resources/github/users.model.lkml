connection: "snowflake_production"

datagroup: snowflake_sfdc_oppty_data {
  max_cache_age: "24 hours"
  sql_trigger:
    select DATE_PART('day',max(received_at)) || '-' || DATE_PART('hour',max(received_at)) as day_hour from segment.salesforce.opportunities ;;
}


include: "user*.view.lkml"
include: "sf__leads.view.lkml"
include: "sf__users.view.lkml"
include: "sf__accounts.view.lkml"
include: "sf__opportunities_base_pdt.z.view.lkml"   # PDT specific to Snowflake
include: "sf__opportunity_products_pdt.z.view.lkml"   # PDT specific to Snowflake
include: "sf__accounts.view.lkml"
include: "sf__cases.view.lkml"
include: "marketo*[!.].view.lkml"
include: "page*[!.].view.lkml"
include: "reghub*[!.].view.lkml"
include: "ucp_usage_pdt.z.view.lkml"
include: "ucp_usage.view.lkml"
include: "ucp_licensing.view.lkml"
include: "stripe_charges.view.lkml"
include: "pwd*[!.].view.lkml"
# Views work for both Redshift and Snowflake (when sql_table_name overridden)
include: "sf__opportunities.view.lkml"
include: "sf__opportunities_extended.view.lkml"
include: "sf__opportunity_products_extended.view.lkml"

fiscal_month_offset: -11

explore: page_views {
  description: "Page views across all Docker Web properties (e.g. Hub, Forums, Training, Cloud, Success, etc.)"
  join: docker_users {
    from: reghub_dockeruser
    sql_on: ${page_views.docker_id} = ${docker_users.clean_uuid}  ;;
    relationship: many_to_one
  }
}

explore: usage {
  view_name: user_emails
  view_label: "Emails"
  from: user_emails
  description: "Docker properties usage (e.g. Hub, Forums, Training, Cloud, UCP, etc.)"

  join: sf__leads {
    view_label: "Leads"
    sql_table_name: SEGMENT.SALESFORCE.LEADS ;;
    sql_on: ${sf__leads.email} = ${user_emails.email} ;;
    relationship: one_to_many
  }

  join: lead_owners {
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__leads.owner_id} = ${lead_owners.id} ;;
    relationship: many_to_one
  }

  join: sf__accounts {
    view_label: "Accounts"
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    sql_on: ${sf__leads.converted_account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }

  join: account_owners {
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__accounts.owner_id} = ${account_owners.id} ;;
    relationship: many_to_one
  }

  join: sf__opportunities {
    from: sf__opportunities_extended
    view_label: "Opportunities"
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: many_to_one
  }

  join: opportunity_owners {
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__opportunities.owner_id} = ${opportunity_owners.id} ;;
    relationship: many_to_one
  }

  join: opportunity_products {
    from: sf__opportunity_products_extended
    view_label: "Opportunitiy Products"
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many
  }

  join: docker_users {
    from: reghub_dockeruser
    sql_on: ${docker_users.email} = ${user_emails.email} ;;
    relationship: one_to_many
  }

  join: ucp_licenses {
    view_label: "UCP Licenses"
    from: ucp_licensing
    sql_on: ucp_licenses.hub_uuid = ${docker_users.clean_uuid} ;;
    required_joins: [docker_users]
    relationship: many_to_one
  }

  join: cloud_revenue {
    from: stripe_charges
    sql_table_name: SEGMENT.STRIPE.CHARGES ;;
    sql_on: ${cloud_revenue.created_month} = ${sf__opportunities.close_month} ;;
    relationship: many_to_many
  }

  join: ucp_usage {
    view_label: "UCP Usage"
    sql_on: ${ucp_usage.license_key} = ${ucp_licenses.license_key} ;;
    required_joins: [ucp_licenses]
    relationship: many_to_one
  }

  join: marketo_leads {
    from: marketo_leads_segment
    sql_table_name: SEGMENT.MARKETO.LEADS ;;
    sql_on: ${marketo_leads.email} = ${user_emails.email} ;;
    relationship: one_to_many
  }

  join: page_views {
    sql_on: ${page_views.docker_id} = ${docker_users.clean_uuid} ;;
    relationship: many_to_one
  }

  join: marketo_activities {
    from: marketo_lead_activities
    sql_table_name: SEGMENT.MARKETO.LEAD_ACTIVITIES ;;
    sql_on: ${marketo_activities.lead_id} = ${marketo_leads.id} ;;
    required_joins: [marketo_leads]
    relationship: one_to_many
  }

  join: support_users {
    from: sf__accounts
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    sql_on: ${support_tickets.account_id} = ${support_users.id} ;;
    relationship: many_to_one
    required_joins: [support_tickets]
  }

  join: support_tickets {
    from: sf__cases
    sql_table_name: SEGMENT.SALESFORCE.CASES ;;
    sql_on: ${docker_users.email} = ${support_tickets.contact_email} ;;
    relationship: one_to_many
  }

  join: pwd_pages {
    sql_table_name: SEGMENT.PLAY_WITH_DOCKER.PAGES ;;
    view_label: "Play-With-Docker Pages"
    sql_on: ${pwd_pages.user_id} = ${docker_users.uuid} ;;
    relationship: one_to_many
  }

  join: pwd_logged_page_visits {
    view_label: "Play-With-Docker First Visit by Users"
    sql_on: ${pwd_logged_page_visits.docker_id} = ${docker_users.uuid} ;;
    relationship: one_to_many
  }
}
