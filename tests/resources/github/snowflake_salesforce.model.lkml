connection: "snowflake_production"

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
include: "sf__certification*"
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


explore: sf__opportunities_history {
  view_label: "Opportunities Snapshot"
  label: "Opportunities Snapshot"

  join: sf__accounts_history {
    view_label: "Accounts"
    sql_on: ${sf__opportunities_history.account_id} = ${sf__accounts_history.id} ;;
    relationship: many_to_one
  }
}

explore: sf__accounts_history {
  view_label: "Accounts Snapshot"
  label: "Accounts Snapshot"
}

explore: sf__opportunities {
  persist_with: snowflake_sfdc_oppty_data
  from: sf__opportunities_extended
  # Snowflake-specific PDT referenced via include at top
  view_label: "Opportunities"
  label: "Opportunities"
  sql_always_where: NOT ${sf__opportunities.is_deleted} ;;

  join: sf__accounts {
    view_label: "Accounts"
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    sql_on: ${sf__opportunities.account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }

  join: account_owners {
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__accounts.owner_id} = ${account_owners.id} ;;
    relationship: many_to_one
  }

  join: tam {
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__accounts.tam} = ${tam.id} ;;
    relationship: many_to_one
  }

  join: opportunity_contacts {
    from: sf__opportunity_contact_role
    sql_table_name: SEGMENT.SALESFORCE.OPPORTUNITY_CONTACT_ROLE ;;
    sql_on: ${opportunity_contacts.opportunity_id} = ${sf__opportunities.id} ;;
    relationship: many_to_many
  }

  join: contacts {
    from: sf__contacts
    sql_table_name: SEGMENT.SALESFORCE.CONTACTS ;;
    sql_on: ${contacts.id} = ${opportunity_contacts.contact_id} ;;
    relationship: one_to_many
  }

  join: campaign_members {
    from:  sf__campaign_members
    sql_table_name: SEGMENT.SALESFORCE.CAMPAIGN_MEMBERS ;;
    sql_on: ${contacts.id} = ${campaign_members.contact_id} ;;
    relationship: one_to_many
  }

  join: campaigns {
    from:  sf__campaigns
    sql_table_name: SEGMENT.SALESFORCE.CAMPAIGNS ;;
    sql_on: ${campaign_members.campaign_id} = ${campaigns.id} ;;
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
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many
  }

  join: sf__deal_registrations {
    view_label: "Deal Registration"
    sql_table_name: SEGMENT.SALESFORCE.DEAL_REGISTRATIONS ;;
    sql_on: ${sf__opportunities.id} = ${sf__deal_registrations.opportunity_c} ;;
    relationship: one_to_one
  }

  join: opportunity_primary_campaign {
    view_label: "Primary Campaign"
    from:  sf__campaigns
    sql_table_name: SEGMENT.SALESFORCE.CAMPAIGNS ;;
    sql_on: ${sf__opportunities.campaign_id} = ${opportunity_primary_campaign.id} ;;
    relationship: many_to_one
  }

  #join: finance_revenue_forecast {
  #  view_label: "Bookings Forecast"
  #  sql_table_name: PRODUCTION.FINANCE.REVENUE_FORECAST ;;
  #  sql_on: ${finance_revenue_forecast.forecast_month} = ${sf__opportunities.close_month} ;;
  #  relationship: many_to_one
  #}
  join: cloud_revenue {
    from: stripe_charges
    sql_table_name: SEGMENT.STRIPE.CHARGES ;;
    sql_on: ${cloud_revenue.created_month} = ${sf__opportunities.close_month} ;;
    relationship: many_to_many
  }
  #join: docker_users {
  #  from: reghub_dockeruser
  #  sql_on: ${docker_users.domain_name} = ${sf__accounts.domain} ;;
  #  relationship: many_to_one
  #}
  #join: ucp_licenses {
  #  from: ucp_licensing
  #  sql_on: ${ucp_licenses.hub_uuid} = replace(${docker_users.uuid}, '-','') ;;
  #  required_joins: [docker_users]
  #  relationship: many_to_one
  #}
  #join: ucp_usage {
  #  from: ucp_mixpanel
  #  sql_on: ${ucp_usage.license_key} = ${ucp_licenses.license_key} ;;
  #  required_joins: [ucp_licenses]
  #  relationship: many_to_one
  #}
  join: sf__leads {
    view_label: "Converted Leads"
    sql_table_name: SEGMENT.SALESFORCE.LEADS ;;
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: one_to_one
  }
  join: sf__leads_converted {
    view_label: "Converted Leads"
    sql_table_name: SEGMENT.SALESFORCE.LEADS ;;
    sql_on: ${sf__leads_converted.id} = ${sf__leads.id} ;;
    relationship: one_to_one
    fields: [ sf__leads_converted.field_list* ]
  }
  join: sf__lead_became_suspect_date {
    sql_on: ${sf__leads.id} = ${sf__lead_became_suspect_date.id} ;;
    relationship: one_to_one
  }
}

test: test_subscription_acv {
  explore_source: sf__opportunities {
    column: subscription_acv { field: opportunity_products.total_subscription_acv_no_is_won_filter }
    column: subscription_nao_acv { field: opportunity_products.total_subscription_acv_nao_no_is_won_filter }
    column: subscription_renewal_acv { field: opportunity_products.total_subscription_acv_renewal_no_is_won_filter }
    column: subscription_debook { field: opportunity_products.total_subscription_acv_debook_no_is_won_filter }
    column: subscription_bdev { field: opportunity_products.total_subscription_acv_bizdev_no_is_won_filter }
    column: subscription_other { field: opportunity_products.total_subscription_acv_other_no_is_won_filter }
    }
  assert: subscription_acv_consistent {
    expression:
      round(${opportunity_products.total_subscription_acv_no_is_won_filter}, 2) =
      round(${opportunity_products.total_subscription_acv_nao_no_is_won_filter}
      + ${opportunity_products.total_subscription_acv_renewal_no_is_won_filter}
      + ${opportunity_products.total_subscription_acv_debook_no_is_won_filter}
      + ${opportunity_products.total_subscription_acv_bizdev_no_is_won_filter}
      + ${opportunity_products.total_subscription_acv_other_no_is_won_filter}, 2) ;;
  }
}

explore: sf__product_telemetry {
  description: "Explore Docker Product telemetry joined to SFDC accounts via DockerID and UCP License Key"
  from: sf__accounts
  sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
  fields: [ALL_FIELDS*, -sf__product_telemetry.active_customer]  # Do not display duplicated column from explore joined below
  label: "Product Telemetry"
  view_label: "Accounts"

  join: sf__accounts{
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    sql_on: sf__accounts.id = sf__product_telemetry.id ;;
    fields: [sf__accounts.active_customer]  # This is to ensure that sf__accounts.active_customer is displayed in the drill through
    view_label: "Accounts"
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
  join: dtr_usage {
    from: dtr_server_stats
    view_label: "Docker DTR Usage"
    sql_on: ${dtr_usage.license_key} = ${ucp_licenses.license_key} ;;
    required_joins: [ucp_licenses]
    relationship: one_to_many
  }
  join: dtr_server_stats {
    view_label: "DTR Usage"
    sql_table_name: SEGMENT.prod_docker_dtr.server_stats ;;
    sql_on: ${dtr_server_stats.license_key} = ${ucp_licenses.license_key} ;;
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

explore: ucp_licenses {
  label: "Docker UCP Licenses"
  view_label: "Docker UCP Licenses"
  description: "Docker UCP licenses"
  from: ucp_licensing

  join: snowflake_reghub_dockeruser {
    view_label: "User Lookup"
    sql_on: ${ucp_licenses.hub_uuid} = replace(${snowflake_reghub_dockeruser.uuid}, '-','') ;;
    relationship: many_to_one
  }

  join: ucp_usage {
    sql_on: ${ucp_usage.license_key} = ${ucp_licenses.license_key} ;;
    relationship: many_to_one
  }

  join: ucp_client_info{
    from:  ucp_client_info
    sql_on: ${ucp_usage.user_id} = ${ucp_client_info.user_id} ;;
    relationship: many_to_one
  }

  join: dtr_server_stats {
    view_label: "DTR Usage"
    sql_table_name: SEGMENT.prod_docker_dtr.server_stats ;;
    sql_on: ${dtr_server_stats.license_key} = ${ucp_licenses.license_key} ;;
    relationship: many_to_one
  }

  join: sf__accounts {
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    view_label: "Accounts"
    sql_on: ${snowflake_reghub_dockeruser.domain_name} = ${sf__accounts.domain} ;;
    relationship: many_to_one
  }

  join: sf__opportunities {
    view_label: "Opportunities"
    sql_on: ${sf__opportunities.account_id} = ${sf__accounts.id} ;;
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
    sql_on: ${snowflake_reghub_dockeruser.email} = ${support_tickets.contact_email} ;;
    relationship: many_to_one
  }

  join: opportunity_products {
    from: sf__opportunity_products
    view_label: "Opportunitiy Products"
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many
  }

  join: sf__leads {
    view_label: "Leads"
    sql_table_name: SEGMENT.SALESFORCE.LEADS ;;
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: one_to_one
  }
}

explore: sf__leads {
  # Extending makes this explore visible
  extends: [sf__leads_base]
  join: lead_owners {
    from: sf__users
    sql_on: ${sf__leads.owner_id} = ${lead_owners.id} ;;
    relationship: one_to_one
  }
}

explore: sf__pipeline_ndt {
  persist_with: snowflake_sfdc_oppty_data
  label: "Pipeline"
  view_label: "Pipeline"
}

explore: sf__opportunity_contact_role_counts {
  label: "Opportunity Contact Role Counts"
  description: "Explore number of contacts associated with an opportunity"
}

explore: ucp_usage {}

explore: sf__certifications {
  sql_table_name: SEGMENT.SALESFORCE.CERTIFICATIONS ;;
  always_filter: {filters:{field:is_deleted value:"no"}}
  label: "Certifications"
  join: sf__certification_account {
    view_label: "Certification Accounts"
    sql_table_name: SEGMENT.SALESFORCE.CERTIFICATION_ACCOUNT_ASSOCIATIONS ;;
    sql_on: ${sf__certifications.id} = ${sf__certification_account.certification} ;;
    relationship: many_to_many
  }
  join: sf__certification_oppty {
    view_label: "Certification Opportunities"
    sql_table_name: SEGMENT.SALESFORCE.CERTIFICATION_OPPTY_ASSOCIATIONS ;;
    sql_on: ${sf__certifications.id} = ${sf__certification_oppty.certification} ;;
    relationship: many_to_many
  }
  join: sf__accounts {
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    sql_on: ${sf__certification_account.account} =  ${sf__accounts.id}  ;;
    relationship: many_to_one
  }
  join: sf__opportunities {
    sql_table_name: SEGMENT.SALESFORCE.OPPORTUNITIES ;;
    sql_on: ${sf__certification_oppty.opportunity} =  ${sf__opportunities.id}  ;;
    relationship: many_to_one
  }

  # join subsequent views to allow filters and dimensions referenced in oppties view
  join: opportunity_products {
    from: sf__opportunity_products
    view_label: "Opportunitiy Products"
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many

  }  join: sf__leads {
    view_label: "Converted Leads"
    sql_table_name: SEGMENT.SALESFORCE.LEADS ;;
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: one_to_one
  }
}
