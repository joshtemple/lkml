view: sessions {
  derived_table: {
    sql: SELECT
        session_id
      , MIN(created_at) AS session_start
      , MAX(created_at) AS session_end
      , COUNT(*) AS number_of_events_in_session
      , SUM(CASE WHEN event_type IN ('Category','Brand') THEN 1 END) AS browse_events
      , SUM(CASE WHEN event_type = 'Product' THEN 1 END) AS product_events
      , SUM(CASE WHEN event_type = 'Cart' THEN 1 END) AS cart_events
      , SUM(CASE WHEN event_type = 'Purchase' THEN 1 end) AS purchase_events
      , MAX(user_id) AS session_user_id
      , MIN(id) AS landing_event_id
      , MAX(id) AS bounce_event_id
    FROM public.events
    GROUP BY session_id
    ;;
    datagroup_trigger: ecommerce_etl
    distribution: "session_id"
    sortkeys: ["session_id"]
  }

  ########## session summary ##########

  dimension: session_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: session_start {
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.session_start ;;
  }

  dimension_group: session_end {
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.session_end ;;
  }

  dimension: session_duration {
    type: number
    label: "Session duration (sec)"
    sql: datediff('seconds', ${session_start_raw}, ${session_end_raw}) ;;
  }

  dimension: session_duration_tier {
    type: tier
    tiers: [10,30,60,120,300]
    style: integer
    sql: ${session_duration} ;;
  }

  measure: average_duration {
    type: average
    label: "Average duration (sec)"
    value_format_name: decimal_2
    sql: ${session_duration} ;;
  }

  dimension: session_user_id {
    type: number
    sql: ${TABLE}.session_user_id ;;
#     hidden: yes
  }

  dimension: landing_event_id {
    type: number
    sql: ${TABLE}.landing_event_id ;;
  }

  dimension: bounce_event_id {
    type: number
    sql: ${TABLE}.bounce_event_id ;;
  }

  measure: count {
    type: count
#     hidden: yes
    drill_fields: [detail*]
  }

  ########## funnel ##########

  dimension: furthest_funnel_step {
    sql: CASE
      WHEN ${purchase_events} > 0 THEN '(5) Purchase'
      WHEN ${cart_events} > 0 THEN '(4) Add to Cart'
      WHEN ${product_events} > 0 THEN '(3) View Product'
      WHEN ${browse_events} > 0 THEN '(2) Browse'
      ELSE '(1) Land'
      END
       ;;
  }

  measure: all_sessions {
    view_label: "Funnel View"
    label: "(1) All Sessions"
    type: count
    drill_fields: [detail*]
  }

  measure: count_browse_or_later {
    view_label: "Funnel View"
    label: "(2) Browse or later"
    type: count

    filters: {
      field: furthest_funnel_step
      value: "(2) Browse,(3) View Product,(4) Add to Cart,(5) Purchase
      "
    }

    drill_fields: [detail*]
  }

  measure: count_product_or_later {
    view_label: "Funnel View"
    label: "(3) View Product or later"
    type: count

    filters: {
      field: furthest_funnel_step
      value: "(3) View Product,(4) Add to Cart,(5) Purchase
      "
    }

    drill_fields: [detail*]
  }

  measure: count_cart_or_later {
    view_label: "Funnel View"
    label: "(4) Add to Cart or later"
    type: count

    filters: {
      field: furthest_funnel_step
      value: "(4) Add to Cart,(5) Purchase
      "
    }

    drill_fields: [detail*]
  }

  measure: count_purchase {
    view_label: "Funnel View"
    label: "(5) Purchase"
    type: count

    filters: {
      field: furthest_funnel_step
      value: "(5) Purchase"
    }

    drill_fields: [detail*]
  }

  measure: cart_to_checkout_conversion {
    view_label: "Funnel View"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${count_purchase} / nullif(${count_cart_or_later},0) ;;
  }

  measure: overall_conversion {
    view_label: "Funnel View"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${count_purchase} / nullif(${count},0) ;;
  }

  ########## bounce info ##########

  dimension: is_bounce_session {
    type: yesno
    sql: ${number_of_events_in_session} = 1 ;;
  }

  measure: count_bounce_sessions {
    type: count
    filters: {
      field: is_bounce_session
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: percent_bounce_sessions {
    type: number
    value_format_name: percent_1
    sql: 1.0 * ${count_bounce_sessions}/nullif(${count},0) ;;
  }

  ########## session event statistics ##########

  dimension: number_of_events_in_session {
    type: number
    sql: ${TABLE}.number_of_events_in_session ;;
  }

  dimension: browse_events {
    label: "Number of Browse Events in Session"
    type: number
    hidden: yes
    sql: ${TABLE}.browse_events ;;
  }

  dimension: includes_browse {
    type: yesno
    sql: ${browse_events} > 0 ;;
  }

  dimension: product_events {
    label: "Number of Product Events in Session"
    type: number
    hidden: yes
    sql: ${TABLE}.product_events ;;
  }

  dimension: includes_product {
    type: yesno
    sql: ${product_events} > 0 ;;
  }

  dimension: cart_events {
    label: "Number of Cart Events in Session"
    type: number
    hidden: yes
    sql: ${TABLE}.cart_events ;;
  }

  dimension: includes_cart {
    type: yesno
    sql: ${cart_events} > 0 ;;
  }

  dimension: purchase_events {
    label: "Number of Purchase Events in Session"
    type: number
    hidden: yes
    sql: ${TABLE}.purchase_events ;;
  }

  dimension: includes_purchase {
    type: yesno
    sql: ${purchase_events} > 0 ;;
  }

  measure: count_with_cart {
    type: count
    filters: {
      field: includes_cart
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_with_purchase {
    type: count
    filters: {
      field: includes_purchase
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  ########## sets ##########

  set: detail {
    fields: [
      session_id,
      session_start_time,
      session_end_time,
      number_of_events_in_session,
      browse_events,
      product_events,
      cart_events,
      purchase_events,
      session_user_id,
      landing_event_id,
      bounce_event_id
    ]
  }
}
