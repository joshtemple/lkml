view: events {
  sql_table_name: public.events ;;

  ########## event info ##########

  dimension: event_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: sequence_number {
    type: number
    description: "Within a given session, what order did the events take place in? 1=First, 2=Second, etc"
    sql: ${TABLE}.sequence_number ;;
  }

  dimension: session_id {
    type: string
#     hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: uri {
    label: "Full Page URL"
    type: string
    sql: ${TABLE}.uri ;;
  }

  dimension: user_id {
    type: number
#     hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: funnel_step {
    description: "Login -> Browse -> Add to Cart -> Checkout"
    sql: CASE
        WHEN ${event_type} IN ('Login', 'Home') THEN '(1) Land'
        WHEN ${event_type} IN ('Category', 'Brand') THEN '(2) Browse Inventory'
        WHEN ${event_type} = 'Product' THEN '(3) View Product'
        WHEN ${event_type} = 'Cart' THEN '(4) Add Item to Cart'
        WHEN ${event_type} = 'Purchase' THEN '(5) Purchase'
      END
       ;;
  }

  dimension: is_entry_event {
    type: yesno
    description: "Yes indicates this was the entry point / landing page of the session"
    sql: ${sequence_number} = 1 ;;
  }

  dimension: is_exit_event {
    type: yesno
#     label: "UTM Source"
    description: "Yes indicates this was the exit point / bounce page of the session"
    sql: ${sequence_number} = MAX(${sequence_number}) OVER (PARTITION BY ${session_id}) ;;
#     sql: ${sequence_number} = ${sessions.number_of_events_in_session} ;;
  }

  dimension: viewed_product_id {
    type: number
    sql: CASE
        WHEN ${event_type} = 'Product' THEN right(${uri},length(${uri})-9)
      END
       ;;
  }

  measure: count {
    type: count
    drill_fields: [event_id]
  }

#   measure: count_m {
#     label: "Count (MM)"
#     type: number
#     hidden: yes
#     sql: ${count}/1000000.0 ;;
#     drill_fields: [simple_page_info*]
#     value_format: "#.### \"M\""
#   }

  measure: sessions_count {
    type: count_distinct
#     hidden: yes
    sql: ${session_id} ;;
  }

  measure: count_bounces {
    type: count
    description: "Count of events where those events were the bounce page for the session"
    filters: {
      field: is_exit_event
      value: "Yes"
    }
  }

  measure: bounce_rate {
    type: number
    value_format_name: percent_2
    description: "Percent of events where those events were the bounce page for the session, out of all events"
    sql: 1.0 * ${count_bounces}/NULLIF(${count},0);;
  }

########## visitor info ##########

  dimension: browser {
    view_label: "Visitors"
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: has_user_id {
    type: yesno
    view_label: "Visitors"
    description: "Did the visitor sign in as a website user?"
    sql: ${user_id} > 0 ;;
  }

  dimension: ip_address {
    type: string
    view_label: "Visitors"
    sql: ${TABLE}.ip_address ;;
  }

  dimension: latitude {
    type: number
    hidden: yes
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    hidden: yes
    sql: ${TABLE}.longitude ;;
  }

  dimension: location {
    type: location
    view_label: "Visitors"
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: approx_location {
    type: location
    view_label: "Visitors"
    sql_latitude: round(${latitude},1) ;;
    sql_longitude: round(${longitude},1) ;;
  }

  dimension: os {
    label: "Operating System"
    view_label: "Visitors"
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: city {
    type: string
    view_label: "Visitors"
    group_label: "Address"
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    view_label: "Visitors"
    group_label: "Address"
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    type: string
    view_label: "Visitors"
    group_label: "Address"
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    view_label: "Visitors"
    group_label: "Address"
    sql: ${TABLE}.zip ;;
  }

  measure: unique_visitors {
    type: count_distinct
    description: "Uniqueness determined by IP Address and User Login"
    view_label: "Visitors"
    sql: ${ip_address} ;;
    drill_fields: [visitors*]
  }

  #   measure: unique_visitors_m {
#     label: "Unique Visitors (MM)"
#     view_label: "Visitors"
#     type: number
#     sql: count (distinct ${ip}) / 1000000.0 ;;
#     description: "Uniqueness determined by IP Address and User Login"
#     value_format: "#.### \"M\""
#     hidden: yes
#     drill_fields: [visitors*]
#   }
#
#   measure: unique_visitors_k {
#     label: "Unique Visitors (k)"
#     view_label: "Visitors"
#     type: number
#     hidden: yes
#     description: "Uniqueness determined by IP Address and User Login"
#     sql: count (distinct ${ip}) / 1000.0 ;;
#     value_format: "#.### \"k\""
#     drill_fields: [visitors*]
#   }

########## sets ##########

  set: simple_page_info {
    fields: [event_id, event_time, event_type,
      #       - os
      #       - browser
      uri, user_id, funnel_step]
  }

  set: visitors {
    fields: [ip_address, os, browser, user_id, count]
  }

}
