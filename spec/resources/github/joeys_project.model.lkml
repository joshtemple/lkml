connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

# NOTE: please see https://looker.com/docs/r/sql/bigquery?version=4.20
# NOTE: for BigQuery specific considerations

explore: demo_db_orders {
  label: "Orders"
  view_label: "Orders"
  join: demo_db_order_items {
    view_label: "Orders"
    relationship: one_to_many
    sql_on: ${demo_db_orders.id} = ${demo_db_order_items.order_id};;
  }
  join: demo_db_inventory_items {
    view_label: "Orders"
    relationship: one_to_one
    sql_on: ${demo_db_order_items.inventory_item_id} = ${demo_db_inventory_items.id} ;;
  }
  join: demo_db_products {
    view_label: "Orders"
    relationship: many_to_one
    sql_on:   ${demo_db_inventory_items.product_id} = ${demo_db_products.id};;
  }
  join: derived_orders {
    view_label: "Orders"
    relationship: one_to_one
    sql_on: ${demo_db_orders.id} = ${derived_orders.id} ;;
  }
  join: derived_avg_order_prophet {
    view_label: "Orders"
    relationship: one_to_many
    type: cross
  }
  join: demo_db_users {
    view_label: "Orders"
    relationship: many_to_one
    sql_on: ${demo_db_orders.user_id} = ${demo_db_users.id} ;;
  }
}
