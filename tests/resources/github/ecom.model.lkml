connection: "thelook"

# include: "*.view.lkml"         # include all views in this project
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
include: "orders_ndt.view"
include: "param_dt.view"
include: "random_pdt.view"
##

explore: order_items {
  sql_always_where: ${users.state} <> "California" ;;
  join: orders {
    relationship: many_to_one
    sql_on: ${orders.id} = ${order_items.order_id} ;;
  }####

#
  join: users {
    fields: [id]
    relationship: many_to_one
    sql_on: ${users.id} = ${orders.user_id} ;;
  }
}

    #and ${users.state} = "{{ _user_attributes['state'] }}"


explore: orders {
#   access_filter: {
#     field: orders.id
#     user_attribute: idd
#   }
}

  explore: orders_two {
    join: order_items {
      relationship: one_to_many
     # type: left_outer
      sql_on: ${orders_two.id} = ${order_items.order_id} AND {% condition orders_two.created_date %} ${order_items.returned_date} {% endcondition %}
      ;;
    }





  }


  explore: users_test {
    from: users
    join: users_a {
      from: users
      type: inner
      relationship: one_to_one
      sql_on: ${users_a.id} = ${users_test.id} AND ${users_a.age} = 25 ;;
      required_joins: [users_b]
    }
    join: users_b {
      from: users
      type: inner
      relationship: one_to_one
      sql_on: ${users_b.id} = ${users_test.id} AND ${users_b.city} = "San Francisco" ;;
    }
  }

  explore: random_pdt {}


  explore: users {
    fields: [ALL_FIELDS*]
#     access_filter: {
#       field: state
#       user_attribute: state
#     }
#     access_filter: {
#       field: id
#       user_attribute: idd
#     }
    join: orders {
      fields: []
      relationship: one_to_many
      #fields: [orders.created_date,orders.user_id]
      type: left_outer
      sql_on: ${users.id} = ${orders.user_id} AND {% condition users.test_filter %} ${users.state} {% endcondition %};;
    }
  }

  map_layer: zip_layer {
    property_key: "id"
    format: topojson
    file: "California.topo.json"
  }

  map_layer: state_layer {
    property_key: "NAME"
    file: "Cities2015.json"
  }

explore:ndt_test{}
explore: param_dt {}
explore: users_pdt_scratch_schem_test {}

include: "pdt_dev_mode.view"
explore: pdt_dev_mode {}

include: "liquid_madness.view"
explore: liquid_madness {}
