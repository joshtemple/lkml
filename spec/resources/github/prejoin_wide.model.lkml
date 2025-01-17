connection: "thelook_events_redshift"

include: "users.view"
include: "order_items.view"

view: new_view{
  sql_table_name: has_everything ;;
  dimension: user_id {}
  dimension: order_item_id {}
  dimension: every_field {}

}
view: +users {
  dimension: id {sql:${new_view.user_id};;}
  dimension: every_field {sql:${new_view.every_field};;}
}
view: +order_items {
  dimension: id {sql:${new_view.order_item_id};;}
}
explore: new_view {
  join: users {sql:;;relationship:one_to_one}
  join: order_items {sql:;;relationship:one_to_one}
}
