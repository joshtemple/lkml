connection: "doubleclick"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"



 explore: impression_funnel {
  label: "Impression Funnel"
  view_label: "Impression Funnel"

  join: match_table_ad_unit {
    view_label: "Ad Attributes"
    sql_on: ${match_table_ad_unit.id} = ${impression_funnel.ad_unit_id} AND ${match_table_ad_unit._data_date} = ${impression_funnel.event_date};;
    relationship: many_to_one
  }
  join: match_table_line_items {
    view_label: "Line Items"
    sql_on: ${match_table_line_items.id} = ${impression_funnel.line_item_id} AND ${match_table_line_items._data_date} = ${impression_funnel.event_date} ;;
    relationship: many_to_one
  }
  join: user_order_facts {
    view_label: "User Order Attributes"
    sql_on: ${impression_funnel.order_id} = ${user_order_facts.order_id} AND ${impression_funnel.user_id} = ${user_order_facts.user_id} ;;
    relationship: many_to_one
  }
#   join: match_table_company {
#     view_label: "Advertiser"
#     sql_on: ${match_table_company.id} = ${impression_funnel.advertiser_id} AND ${match_table_company._data_date} = ${impression_funnel.event_date};;
#     relationship: many_to_one
#   }
  join: match_table_user {
    view_label: "User Attributes"
    sql_on: ${match_table_user.id} = ${impression_funnel.user_id} AND ${match_table_user._data_date} = ${impression_funnel.event_date};;
    relationship: many_to_one
  }
 }

explore: clicks {}
explore: impressions {}
explore: activity {}

explore: match_table_audience_explorer {
  label: "Audience Facts"
  view_label: "Audience Facts"

  join: match_table_audience_segment {
    view_label: "Audience Segment"
    sql_on: ${match_table_audience_explorer.id} = ${match_table_audience_segment.id} and ${match_table_audience_explorer._data_date} = ${match_table_audience_segment._data_date};;
    relationship: many_to_one
  }
}
