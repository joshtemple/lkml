connection: "snowflake_medium"

#
# Define data groups used by view
#
datagroup: snowflake_sfdc_oppty_data {
  max_cache_age: "24 hours"
  sql_trigger:
    select DATE_PART('day',max(received_at)) || '-' || DATE_PART('hour',max(received_at)) as day_hour from segment.salesforce.opportunities ;;
}
datagroup: snowflake_sfdc_lead_and_contact_data {
  max_cache_age: "24 hours"
  sql_trigger:
    WITH leads_and_contacts as (select received_at from segment.salesforce.leads UNION select received_at from segment.salesforce.contacts )
    select DATE_PART('day',max(received_at)) || '-' || DATE_PART('hour',max(received_at)) as day_hour from leads_and_contacts ;;
}

# include extended views
include: "snowflake_sf__*history.z.view.lkml"
include: "sf__opportunities_base_pdt.z.view.lkml"   # PDT specific to Snowflake
include: "sf__opportunity_products_pdt.z.view.lkml"   # PDT specific to Snowflake
include: "sf__pipeline_ndt.z.view.lkml"  # NDT specific to Snowflake
include: "ucp_usage_pdt.z.view.lkml"  # PDT specific to Snowflake
include: "snowflake_sf__contacts_to_reghub_to_license.z.view.lkml" # PDT specific to Snowflake

# Base Explores to be extended:
include: "snowflake_explore_sf_leads.view.lkml"

# Views work for both Redshift and Snowflake (when sql_table_name overridden)
include: "sf__opportunities.view.lkml"
include: "sf__opportunities_extended.view.lkml"
include: "sf__opportunity_products_extended.view.lkml"
include: "sf__accounts.view.lkml"
include: "sf__users.view.lkml"
include: "sf__opportunity_contact_role.view.lkml"
include: "sf__opportunity_contact_role_counts.view.lkml"
include: "sf__cases.view.lkml"

include: "sf__leads_converted.view.lkml"
include: "sf__lead_history.view.lkml"
include: "sf__lead_became_suspect_date.view.lkml"
include: "sf__contacts.view.lkml"
include: "sf__campaign_members.view.lkml"
include: "sf__campaigns.view.lkml"
include: "sf__deal_registrations.view.lkml"

include: "finance_revenue_forecast.view.lkml"
include: "sf__leads.view.lkml"
include: "stripe_charges.view.lkml"
include: "ucp_usage.view.lkml"
include: "ucp_usage_sfdc.view.lkml"
include: "ucp_licensing.view.lkml"
include: "ucp_client_info.view.lkml"
include: "snowflake_reghub_dockeruser.view.lkml"
include: "dtr_server_stats.view.lkml"

# Define the Fiscal Year offset
fiscal_month_offset:  -11 # starts in February

explore: sf__product_telemetry {
  description: "Explore Docker Product telemetry joined to SFDC accounts via DockerID and UCP License Key"
  from: sf__accounts
  sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
  label: "Product Telemetry"
  view_label: "Accounts"

  join: sf__accounts{
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    sql_on: sf__accounts.id = sf__product_telemetry.id ;;
    fields: [sf__accounts.active_customer]
    relationship: one_to_one
  }
  join: sf__opportunities {
    view_label: "Opportunities"
    sql_on: ${sf__opportunities.account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }
  join: opportunity_products {
    from: sf__opportunity_products
    view_label: "Opportunitiy Products"
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many
  }
  join: docker_id_crosswalk {
    from:  sf__contacts_to_reghub_to_license
    view_label: "Contacts-Reghub Crosswalk"
    sql_on: ${docker_id_crosswalk.sfdc_account_id} = ${sf__product_telemetry.id} ;;
    relationship: one_to_many
  }
  join: snowflake_reghub_dockeruser {
    view_label: "Docker Users"
    sql_on: ${docker_id_crosswalk.standardized_uuid} = ${snowflake_reghub_dockeruser.clean_uuid} ;;
    relationship: many_to_one
    fields: [clean_uuid,date_joined_time,date_joined_date,date_joined_month,email,full_name,last_login_time,last_login_date,last_login_month,type,username,count,count_uuid]
  }
  join: ucp_licenses {
    view_label: "Docker UCP Licenses"
    from: ucp_licensing
    sql_on: ${docker_id_crosswalk.standardized_uuid} = ${ucp_licenses.hub_uuid} ;;
    relationship: many_to_one
  }
  join: ucp_usage {
    view_label: "Docker UCP Usage"
    sql_on: ${ucp_licenses.license_key} = ${ucp_usage.license_key} ;;
    relationship: one_to_many
  }
  join: ucp_client_info{
    from:  ucp_client_info
    sql_on: ${ucp_usage.user_id} = ${ucp_client_info.user_id} ;;
    relationship: many_to_one
  }
  join: ucp_usage_sfdc {
    view_label: "Usage SFDC IDs"
    sql_on: ${ucp_usage.id} = ${ucp_usage_sfdc.id} ;;
    relationship: one_to_one
    fields: [ count_unique_sfdc_accounts_last_7 ]
  }
  #oin: dtr_server_stats {
  #  view_label: "DTR Usage"
  #  sql_table_name: SEGMENT.prod_docker_dtr.server_stats ;;
  #  sql_on: ${ucp_licenses.license_key} = ${dtr_server_stats.license_key} ;;
  #  relationship: many_to_one
  #}
  join: sf__contacts {
    sql_table_name: SEGMENT.SALESFORCE.CONTACTS ;;
    view_label: "Contacts"
    sql_on: ${docker_id_crosswalk.sfdc_contact_id} = ${sf__contacts.id} ;;
    relationship: many_to_one  # May be multiple crosswalk entries w/ a given contact_id
  }
  join: tam {
    view_label: "TAM"
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__product_telemetry.tam} = ${tam.id} ;;
    relationship: one_to_one
  }
  join: sf__leads {
    view_label: "Converted Leads"
    sql_table_name: SEGMENT.SALESFORCE.LEADS ;;
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: one_to_one
  }
}
