connection: "thelook"

#include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "order_items.view"
include: "orders.view"
include: "products.view"
include: "users.view"
include: "events.view"
include: "inventory_items.view"
include: "schema_migrations.view"
include: "orders_extended.view"
include: "user_data.view"
include: "users_pdt.view"
include: "users_nn.view"
include: "orders_two.view"
include: "max_date_dt.view"
# # Select the views that should be a part of this model,
# and define the joins that connect them together.

explore: order_items {
  join: orders {
    relationship: many_to_one
    sql_on: {% if orders.id._in_query and orders.created_date._in_query %}
 ${orders.id} = ${order_items.order_id} AND ${orders.created_raw} = ${order_items.returned_raw}
{% elsif orders.id._in_query %}
${orders.id} = ${order_items.order_id}
{% elsif orders.created_date._in_query %}
${orders.created_raw} = ${order_items.returned_raw}
{% endif %}
    ;;
  }
}

explore: users {
  sql_always_where:{% if users.param_example._in_query %}
                    ${state} = (SELECT state from users WHERE {% parameter users.param_exampe %}
                  {% else %}
                  1=1
                  {% endif %};;


}
