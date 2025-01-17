connection: "db"

# include all the views
include: "*.view"

datagroup: yesterdays_evening_deliveries_default_datagroup {
  sql_trigger: SELECT count(*) FROM cc.EVENING_DELIVERIES_BASE_YESTERDAY_VIEW;;
  max_cache_age: "10 minute"
}

persist_with: yesterdays_evening_deliveries_default_datagroup



explore: evening_deliveries_base_yesterday_view {
  group_label: "Evening Deliveries"
  fields: [ALL_FIELDS*]
#,-evening_deliveries_logistics_sc_view.id, -evening_deliveries_logistics_sc_view.tracking_number
  join: evening_deliveries_sc_yesterday_view {
    type: left_outer
    relationship: one_to_one
    sql_on: ${evening_deliveries_base_yesterday_view.id} = ${evening_deliveries_sc_yesterday_view.id}
      and ${evening_deliveries_base_yesterday_view.tracking_number} = ${evening_deliveries_sc_yesterday_view.tracking_number};;


  }


}
