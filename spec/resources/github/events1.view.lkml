view: events1 {
  sql_table_name: PUBLIC.EVENTS ;;

  dimension: event_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: browser {
    type: string
    view_label: "Visitors"
    sql: ${TABLE}.BROWSER ;;
  }

  dimension: city {
    type: string
    hidden: yes
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    hidden: yes
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension_group: event {
    type: time
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: event_type {
    sql: ${TABLE}.EVENT_TYPE ;;
  }

  dimension: funnel_step {
    description: "Login -> Browse -> Add to Cart -> Checkout"
    type: string
    sql: case when ${TABLE}.EVENT_TYPE = 'Home' then '(1) Land'
            when ${TABLE}.EVENT_TYPE in ('Brand', 'Category') then '(2) Browse Inventory'
            when ${TABLE}.EVENT_TYPE = 'Product' then '(3) View Product'
            when ${TABLE}.EVENT_TYPE = 'Cart' then '(4) Add Item to Cart'
            when ${TABLE}.EVENT_TYPE = 'Purchase' then '(5) Purchase'
    end;;
  }

  dimension: ip_address {
    view_label: "Visitors"
    type: string
    sql: ${TABLE}.IP_ADDRESS ;;
  }

  dimension: latitude {
    type: number
    hidden: yes
    sql: ${TABLE}.LATITUDE ;;
  }

  dimension: longitude {
    type: number
    hidden: yes
    sql: ${TABLE}.LONGITUDE ;;
  }

  dimension: approx_location {
    view_label: "Visitors"
    type: location
    sql_latitude: round(${latitude},2) ;;
    sql_longitude: round(${longitude},2) ;;
  }

  dimension: location {
    view_label: "Visitors"
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: operating_system {
    view_label: "Visitors"
    type: string
    sql: ${TABLE}.OS ;;
  }

  dimension: sequence_number {
    description: "Within a given session, what order did the events take place in? 1=First 2=Second, etc"
    type: number
    sql: ${TABLE}.SEQUENCE_NUMBER ;;
  }

  dimension: session_id {
    type: string
    hidden: yes
    sql: ${TABLE}.SESSION_ID ;;
  }

  dimension: state {
    type: string
    hidden: yes
    sql: ${TABLE}.STATE ;;
  }

  dimension: traffic_source {
    type: string
    hidden: yes
    sql: ${TABLE}.TRAFFIC_SOURCE ;;
  }

  dimension: full_page_url {
    type: string
    sql: ${TABLE}.URI ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: has_user_id {
    view_label: "Visitors"
    type: yesno
    sql: ${TABLE}.USER_ID is not null ;;
  }

  dimension: zip {
    type: zipcode
    hidden: yes
    sql: ${TABLE}.ZIP ;;
  }

  dimension: is_entry_event {
    description: "Yes indicates this was the entry point / landing page of the session"
    type: yesno
    sql: ${sequence_number} = 1 ;;
  }

  dimension: is_exit_event {
    description: "Yes indicates this was the exit point / bounce page of the session"
    label: "UTM Source"
    type: yesno
    sql: ${sequence_number} = ${sessions5.number_of_events_in_session} ;;
  }

  dimension: viewed_product_ID  {
    type: number
    value_format: "0"
    sql: case when ${event_type} = 'Product' then replace(${full_page_url}, '/product/', '') end;;
  }

  measure: count {
    type: count
    drill_fields: [event_id, users.id, users.first_name, users.last_name]
  }

  measure: sessions_count {
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: count_bounces {
    description: "Count of events where those events were the bounce page for the session"
    type: count
    filters: {field: is_exit_event value: "Yes"}
    }

  measure: bounce_rate {
    description: "Percent of events where those events were the bounce page for the sesson, out of all events"
    type: number
    value_format: "0.00%"
    sql: ${count_bounces}/NULLIF(${count},0) ;;
  }

  measure: all_sessions {
    view_label: "Funnel View"
    label: "(1) All sessions"
    type:  count_distinct
    sql: ${session_id} ;;
  }

  measure: browse_or_later {
    view_label: "Funnel View"
    label: "(2) Browse or later"
    type:count_distinct
    sql: ${session_id} ;;
    filters: {field: sessions5.browse_or_later value:"1"}
  }

  measure: view_product_or_later {
    view_label: "Funnel View"
    label: "(3) View Product or later"
    type:count_distinct
    sql: ${session_id} ;;
    filters: {field: sessions5.view_product_or_later value:"1"}
    }

  measure: add_to_cart_or_later {
    view_label: "Funnel View"
    label: "(4) Add to Cart or later"
    type:count_distinct
    sql: ${session_id} ;;
    filters: {field: sessions5.add_to_cart_or_later value:"1"}}

  measure: purchase {
    view_label: "Funnel View"
    label: "(5) Purchase"
    type: count_distinct
    sql: ${session_id} ;;
    filters: {field: sessions5.purchase value:"1"}}

  measure: cart_to_checkout_conversion {
    view_label: "Funnel View"
    type: number
    value_format: "0.00%"
    sql:  ${purchase}/nullif(${add_to_cart_or_later},0);;
  }

  measure: overall_conversion {
    view_label: "Funnel View"
    type: number
    value_format: "0.00%"
    sql:  ${purchase}/nullif(${all_sessions},0);;
  }

  measure: unique_visitors {
    view_label: "Visitors"
    description: "Uniqueness determined by IP Address and User Login"
    type: count_distinct
    sql: ${TABLE}.ip_address ;;
  }

  set: session_list {
    fields: [event_time, event_id, event_type, full_page_url, funnel_step, user_id]
  }

}
