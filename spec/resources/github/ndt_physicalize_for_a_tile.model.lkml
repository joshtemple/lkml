connection: "thelook_events_redshift"

include: "/basic_users*.view.lkml"
include: "/order_items*.view.lkml"

datagroup: default_datagroup {sql_trigger: select count(*) from public.users ;;}

view: users__base_for_NDT_physicalize_for_a_tile {extends: [basic_users]}

view: order_items__base_for_NDT_physicalize_for_a_tile {extends: [order_items]}

explore: base_explore {from: order_items__base_for_NDT_physicalize_for_a_tile
  view_name: order_items
  join: users {from: users__base_for_NDT_physicalize_for_a_tile
    relationship: many_to_one
    sql_on: ${order_items.user_id}=${users.id} ;;
  }

}

###########
# Example 1: Bar chart for count distinct users having each stats
#### Create an optimized tile
## 1 - Create the ndt in alignment with the tile.
view: tile_example_1_ndt {
  label: "tile_example_1: Count Distinct Users by Order Status"
  derived_table: {
    explore_source: base_explore {
      column: status { field: order_items.status }
      column: count { field: users.count }
    }
    datagroup_trigger: default_datagroup
    distribution_style: "even" #not yet sure if this should be all or what for optimization in this case
    sortkeys: ["status"]

  }
  dimension: status {}
  #measures must be manually re-aggregated and watch out for name collisions
  #dimension: count {type: number}
  measure: count {
    hidden: yes
    type:sum
  } #needs to be sum, not row count
}

## 2 - Special views to realign field references to original view names
view: tile_example_1__users {
  measure: count {sql: ${order_items.count};;#always the base view
    type:number #is the type going to be a problem?
    drill_fields: [order_items.status]
    html: <a href="https://profservices.dev.looker.com{{link | replace: _explore._name,'base_explore'}}">{{rendered_value}}</a>;;
  }
}

## 3 - Make the same explore but with the alternate source
explore: tile_example_1_explore {from:tile_example_1_ndt
  view_name: order_items #must match base_explore's view_name
  view_label: "Order Items"
  join: users {from: tile_example_1__users
    sql:  ;; #bare join
    relationship: one_to_one #bare joins always one_to_one
  }
}


# explore: test_ndt_source {
#   view_name: basic_users
#   join: order_items {
#     sql_on: ${order_items.user_id}=${basic_users.id} ;;
#     relationship: one_to_many
#   }
# }

# view: test_ndt_source_ndt {
#   derived_table: {
#     explore_source: test_ndt_source {
#       column: total_sales2 { field: order_items.total_sales2 }
#       column: age { field: basic_users.age }
#     }
#   }
#   dimension: age {
#     type: number
#   }
#   measure: total_sales2 {
#     type: sum
#     # sql: ${TABLE}.total_sales2 ;;
#   }
# }
# view: order_items_fields {
#   measure: total_sales2 {
#     type: number
#     sql: ${basic_users.total_sales2} ;;
#   }
# }
# explore: test_ndt_source_ndt {
#   # from: test_ndt_source_ndt
#   # view_name: basic_users
#   # join: order_items {
#   #   from: order_items_fields
#   #   sql:  ;;
#   # }
# }

# view: test_ndt_source_ndt2 {
#   derived_table: {
#     explore_source: test_ndt_source {
#       column: total_sales2 { field: order_items.total_sales2 }
#       column: age { field: basic_users.age }
#     }
#   }
#   measure: total_sales2 {
#     value_format: "$#,##0.00"
#     type: sum
#   }
#   dimension: age {
#     type: number
#   }
# }

# explore: test_ndt_source_ndt2 {
#   view_name: basic_users
# }


# view: tile_specific_age_and_gender {

#   derived_table: {
#     explore_source: basic_users {
#       column: age {}
#       column: gender {}
#       column: count {}
# # Remove filters, add them as selected columns instead
# #       filters: {
# #         field: basic_users.age
# #         value: ">30"
# #       }
# #       filters: {
# #         field: basic_users.state
# #         value: ""
# #       }
#       column: state {}
#     }
#     # persist_for: "1 hour"
#   }
#   dimension: age {
#     type: number
#   }
#   dimension: gender {}

#   dimension: state {}
# #   dimension: count {
# #     type: number
# #   }
#   measure: count {
#     type: sum
#     sql: ${TABLE}.count ;;
#     # tags: ["{{user_attributes['name']}}"]
#   }

# }

# explore: tile_specific_age_and_gender {
#   from: tile_specific_age_and_gender
#   view_name: basic_users

# }
