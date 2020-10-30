connection: "db"

# include all the views
include: "*.view"

datagroup: evening_deliveries_default_datagroup {
   sql_trigger: SELECT count(*) FROM cc.evening_deliveries_logistics_base_view;;
  max_cache_age: "10 minute"
}

persist_with: evening_deliveries_default_datagroup


explore: evening_deliveries_logistics_base_view {
  group_label: "Evening Deliveries"
  fields: [ALL_FIELDS*]
#,-evening_deliveries_logistics_sc_view.id, -evening_deliveries_logistics_sc_view.tracking_number
  join: evening_deliveries_logistics_sc_view {
    type: left_outer
    relationship: one_to_one
    sql_on: ${evening_deliveries_logistics_base_view.id} = ${evening_deliveries_logistics_sc_view.id}
    and ${evening_deliveries_logistics_base_view.tracking_number} = ${evening_deliveries_logistics_sc_view.tracking_number};;


  }


}
