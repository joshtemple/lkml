connection: "snowflake_db"

label: "SNOWFLAE"

# include all the views
include: "*.view"

# include all the dashboards
 include: "*.dashboard"

explore: camp_hdr {
  label: "Campaigns"
  view_label: "Campaigns"

  join: campaign_summary {
    view_label: "Campaigns"
    type: inner
    relationship: one_to_one
    sql_on: ${campaign_summary.campaign_id} =${camp_hdr.campaign_id} ;;
  }

  join: lead_hdr {
    view_label: "Leads"
    type: inner
    relationship: one_to_one
    sql_on: ${camp_hdr.campaign_id} =${lead_hdr.campaignid} ;;
  }

  join: opty_hdr1 {
    view_label: "Opportunity"
    type: inner
    relationship: one_to_one
    sql_on: ${camp_hdr.campaign_id}=${opty_hdr1.camp_id} ;;
  }

  join: pipeline {
    view_label: "Opportunity Pipeline"
    type: left_outer
    relationship: one_to_one
    sql_on: ${camp_hdr.campaign_id}=${pipeline.campid} ;;
  }

  join: order_summary {
    view_label: "Orders"
    type: inner
    relationship: one_to_one
    sql_on: ${camp_hdr.campaign_id}=${order_summary.camp_id} ;;
  }
}

explore: pipeline {
  label: "Opportunity Pipeline"
  view_label: "Opportunity Pipeline"
}

explore: orders_items {
  label: "Order items"

  join: orders {
    view_label: "Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.id}=${orders_items.order_id};;
}}
