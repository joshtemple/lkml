connection: "thelook"

include: "mysql.*.view.lkml"         # include all views in this project
include: "parameter_to_variable.view.lkml"
include: "mapping_logic.view.lkml"
include: "mapping_logic_bug.view.lkml"
## Order Items view
# explore: order_items {
#   view_name: order_items
#   extends: [users_e, orders_e]
# #   join: users {
# #     relationship: many_to_one
# #     sql_on: ${order_items.user_id} = ${users.id} ;;
# #   }
# }

#use case 1 - dynamic dates

explore: orders_brand_rank {
  label: "Orders: Parameter for Other Bucket"
}

explore: parameter_to_variable {}


## Orders view

explore: orders_e {
  view_name:  orders
  join: orders_product_facts {
    relationship: many_to_one
    sql_on: ${orders_product_facts.order_id} = ${orders.id} ;;
  }
  join: checkout_session {
    relationship: many_to_one
    sql_on: ${checkout_session.order_id} = ${orders.id} ;;
  }
}

## Users view
# explore: users_e {
#   view_name:  users
#   join: user_order_facts {
#     relationship: many_to_one
#     sql_on: ${user_order_facts.user_id} = ${users.id} ;;
#   }
#
#   join: user_profile {
#     relationship: many_to_one
#     sql_on: ${user_profile.user_id} = ${users.id} ;;
#   }
# }

explore: merge_simple {}

#
### EXPLORES ###
# Please see README.lookml for an explanation of explores and best practices

explore: orders_merge {
  join: users_merge {
    relationship: many_to_one
    sql_on: ${orders_merge.user_id} = ${users_merge.id} ;;
  }
}

# view: users {
#   dimension: id {
#     sql: 1=1 ;;
#   }
# }

view: user_profile {
  dimension: user_id {
    sql: 1=1 ;;
  }
}

# view: user_order_facts {
#   dimension: user_id {
#     sql: 1=1 ;;
#   }
# }

view: checkout_session {
  dimension: order_id {
    sql: 1=1 ;;
  }
}

view: orders_product_facts {
  dimension: order_id {
    sql: 1=1 ;;
  }
}
