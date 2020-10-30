connection: "bigquery_publicdata_standard_sql"

include: "custom_functions.view"
include: "events.view"
include: "products.view"
include: "sessions.view"
include: "events_for_sessionization.view"

explore: events {
  view_name: events
  join: products {
    view_label: "Products Visited"
    sql_on: ${events.visited_product_id}=${products.id} ;;
    relationship: one_to_many
  }
}


#-----------------------------------------------------------------
#  Add some measures and dimension for sessionization.
#-----------------------------------------------------------------
#  This explore adds some aggregates for events so we can create a
#    hypertree.  You shouldn't need to (or be able to) explore from
#    here.

explore: events_for_sessionization {
  label: "events_for_sessionization: INTERNAL USE ONLY"
  hidden: yes
  from: events_for_sessionization
  extends: [events, custom_functions]
}



#---------------------------------------------------------------------
#  Explore session data
#---------------------------------------------------------------------


explore: sessions {
  extends: [custom_functions]
  join: events_fired {
    sql: LEFT JOIN UNNEST(${sessions.events_fired}) as events_fired ;;
    relationship: one_to_many
  }
  join: events_fired_2 {
    from: events_fired
    sql: LEFT JOIN UNNEST(${sessions.events_fired}) as events_fired_2 ;;
    relationship: one_to_many
  }
  join: products_visited {
    sql: LEFT JOIN UNNEST(${sessions.products_visited}) as products_visited ;;
    relationship: one_to_many
  }
  join: products {
    view_label: "Products Visited"
    sql_on: ${products_visited.product_id}=${products.id} ;;
    relationship: one_to_many
  }
  join: categories_visited {
    sql: LEFT JOIN UNNEST(${sessions.categories_visited}) as categories_visited ;;
    relationship: one_to_many
  }
}
