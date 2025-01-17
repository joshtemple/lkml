connection: "snowflake_segment"

datagroup: snowflake_sfdc_oppty_data {
  max_cache_age: "24 hours"
  sql_trigger:
    select DATE_PART('day',max(received_at)) || '-' || DATE_PART('hour',max(received_at)) as day_hour from segment.salesforce.opportunities ;;
}

include: "marketo*.view.lkml"
include: "sf__leads.view.lkml"
include: "sf__opportunities_base_pdt.z.view.lkml"   # PDT specific to Snowflake
include: "sf__opportunity_products_pdt.z.view.lkml"   # PDT specific to Snowflake
include: "sf__opportunities_extended.view.lkml"
include: "sf__accounts.view.lkml"
include: "sf__leads_converted.view.lkml"
include: "sf__opportunity_products.view.lkml"

fiscal_month_offset: -11


explore: marketo_leads {
  from: marketo_leads_segment
  join: marketo_activities {
    from: marketo_lead_activities
    sql_on: ${marketo_activities.lead_id} = ${marketo_leads.id} ;;
    relationship: one_to_many
  }
  join: marketo_lead_activity_attributes {
    view_label: "Activity Attributes"
    sql_on: ${marketo_lead_activity_attributes.activity_id} = ${marketo_activities.id} ;;
    relationship: one_to_many
  }
  join: marketo_lead_activity_types {
    view_label: "Activity Types"
    sql_on: ${marketo_lead_activity_types.id} = ${marketo_activities.activity_type_id} ;;
    relationship: one_to_one
  }
  join: marketo_lead_activity_type_attributes {
    view_label: "Activity Type Attributes"
    sql_on: ${marketo_lead_activity_type_attributes.activity_type_id} = ${marketo_lead_activity_types.id} ;;
    relationship: one_to_many
  }
}

explore: marketo_lead_activities {
  description: "Lead Activities coming from Marketo via Segment"
  view_label: "Lead Activities"
  join: marketo_leads_segment {
    view_label: "Marketo Leads"
    sql_on: ${marketo_lead_activities.lead_id} = ${marketo_leads_segment.id} ;;
    relationship: many_to_one
  }
  join: sf__leads {
    view_label: "SFDC Leads"
    sql_on: ${marketo_leads_segment.email} = ${sf__leads.email} ;;
    relationship: many_to_many
  }
  join: sf__accounts {
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS ;;
    view_label: "Accounts"
    sql_on: ${sf__leads.converted_account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }
  join: sf__opportunities {
    view_label: "Opportunities"
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: many_to_one
  }
  join: marketo_campaigns {
    view_label: "Campaigns"
    sql_on: ${marketo_campaigns.id} = ${marketo_lead_activities.campaign_id} ;;
    relationship: many_to_one
  }
  join: marketo_programs {
    view_label: "Programs"
    sql_on: ${marketo_campaigns.program_id} = ${marketo_programs.id} ;;
    relationship: many_to_one
  }
  join: marketo_lead_activity_attributes {
    view_label: "Activity Attributes"
    sql_on: ${marketo_lead_activity_attributes.activity_id} = ${marketo_lead_activities.id} ;;
    relationship: one_to_many
  }
  join: marketo_lead_activity_types {
    view_label: "Activity Types"
    sql_on: ${marketo_lead_activity_types.id} = ${marketo_lead_activities.activity_type_id} ;;
    relationship: one_to_one
  }
  join: marketo_lead_activity_type_attributes {
    view_label: "Activity Type Attributes"
    sql_on: ${marketo_lead_activity_type_attributes.activity_type_id} = ${marketo_lead_activity_types.id} ;;
    relationship: one_to_many
  }
  join: opportunity_products {
    from: sf__opportunity_products
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many
  }
  join: sf__leads_converted {
    sql_table_name: SEGMENT.SALESFORCE.LEADS ;;
    view_label: "Leads"
    sql_on: ${sf__leads_converted.id} = ${sf__leads.id} ;;
    relationship: one_to_one
    fields: [ sf__leads_converted.field_list_no_history* ]
  }
}

explore: marketo_lead_scoring_factors {
  hidden: yes
  always_filter: {
    filters: {
      field: snapshot_date
      value: "Most Recent Snapshot"
    }
  }
}

test: test_exist_marketo_lead_activities {
  explore_source: marketo_lead_activities {
    column: count {}
  }
  assert: marketo_lead_activities_exists {
    expression: ${marketo_lead_activities.count} > 0 ;;
  }
}
