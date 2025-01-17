connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: peter_whitehead_model_building_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: peter_whitehead_model_building_default_datagroup

# explore: events {
# #   hidden: yes
#   join: users {
#     view_label: "Users"
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: inventory_items {
#   join: products {
#     view_label: "Products"
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }
# }

explore: order_items {
#   hidden: yes
# sql_always_where: ${orders.created_date} <= {% date_start order_items.this_better_work %} ;;

  from: order_items
  view_name: order_items
  #This is how to define user attributes on a model basis
#   access_filter: {
#     field: users.state
#     user_attribute: state
#   }
  join: inventory_items {
    view_label: "Inventory Items"
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    view_label: "Orders"
    #Blank fields will hide the view in the explore
    # fields: []
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    view_label: "Products"
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    view_label: "Users"
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

#   join: top_10_brands {
#     type: left_outer
#     sql_on: ${top_10_brands.brand} = ${products.brand} ;;
#     relationship: one_to_many
#   }

  persist_for: "4 hours"
}

explore: orders {
  label: "Orders"

  # This is adding a where statement for age >20 ONLY if the users view is in the query
  sql_always_where:
  {% if users._in_query %}
    users.age > 20
    {% else %}
    1=1
    {% endif %};;
  join: users {
    view_label: "Users"
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    view_label: "User Facts"
    type: left_outer
    sql_on: ${orders.user_id} = ${user_facts.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  #this is to get a doesn't contains and contains filters in the same explore
  sql_always_where:
  (
  {% condition products.to_filter %} ${category} {% endcondition %}
  AND {% condition products.to_filter %} ${department} {% endcondition %}
  AND {% condition products.to_filter %} ${brand} {% endcondition %}
  ) OR
  (
  {% condition products.to_filter2 %} ${category} {% endcondition %}
  OR {% condition products.to_filter2 %} ${department} {% endcondition %}
  OR {% condition products.to_filter2 %} ${brand} {% endcondition %}
  );;
}

explore: schema_migrations {}

# explore: user_data {
#   sql_always_where: ${users.state} = "California" ;;
#   join: users {
#     view_label: "Users"
#     type: left_outer
#     sql_on: ${user_data.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }


explore: users_nn {
  always_filter: {
    filters: {
      field: users.gender
      value: "f"
    }
  }
  join: users {
    view_label: "Female Users"
    fields: [users.age, users.gender, users.city, users.email, users.state, users.zip]
    type: inner
    sql_on: ${users_nn.id} = ${users.id} ;;
    relationship: one_to_one
  }
  }

  # explore: future {
  #   join: orders {
  #     type: left_outer
  #     sql_on: ${future.future_date} = ${orders.created_date} ;;
  #     relationship: many_to_one
  #   }
  #   join: order_items {
  #     type: left_outer
  #     sql_on: ${order_items.order_id} = ${orders.id} ;;
  #     relationship: many_to_one
  #   }

  #   join: inventory_items {
  #     view_label: "Inventory Items"
  #     type: left_outer
  #     sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
  #     relationship: many_to_one
  #   }
  #   }

    # explore: templated_dt {
    #   join: users {
    #     sql_on: ${users.state} = ${templated_dt.state} ;;
    #     relationship: one_to_many
    #   }
    # }
