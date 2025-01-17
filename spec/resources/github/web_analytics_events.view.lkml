view: events {
#   sql_table_name: events ;;
  derived_table: {
    sql: select * from events where {% condition event_date %} events.created_at {% endcondition %} ;;
  }

  dimension: event_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: session_id {
    type: number
    hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: ip {
    label: "IP Address"
    view_label: "Visitors"
    sql: ${TABLE}.ip_address ;;
  }

  dimension: user_id {
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: event {
    type: time
    timeframes: [time, date, hour, time_of_day, hour_of_day, week, day_of_week_index, day_of_week, month, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: sequence_number {
    type: number
    description: "Within a given session, what order did the events take place in? 1=First, 2=Second, etc"
    sql: ${TABLE}.sequence_number ;;
  }

  dimension: is_entry_event {
    type: yesno
    description: "Yes indicates this was the entry point / landing page of the session"
    sql: ${sequence_number} = 1 ;;
  }

  dimension: is_exit_event {
    type: yesno
    label: "UTM Source"
    sql: ${sequence_number} = ${sessions.number_of_events_in_session} ;;
    description: "Yes indicates this was the exit point / bounce page of the session"
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
    sql: ${count_bounces}*1.0 / nullif(${count}*1.0,0) ;;
  }

  dimension: full_page_url {
    sql: ${TABLE}.uri ;;
  }

  dimension: viewed_product_id {
    type: number
    sql: CASE
        WHEN ${event_type} = 'Product' THEN right(${full_page_url},len(${full_page_url})-9)
      END
       ;;
  }

  dimension: event_type {
    sql: ${TABLE}.event_type ;;
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

  measure: unique_visitors {
    type: count_distinct
    description: "Uniqueness determined by IP Address and User Login"
    view_label: "Visitors"
    sql: ${ip} ;;
    drill_fields: [visitors*]
  }

  dimension: location {
    type: location
    view_label: "Visitors"
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: approx_location {
    type: location
    view_label: "Visitors"
    sql_latitude: round(${TABLE}.latitude,1) ;;
    sql_longitude: round(${TABLE}.longitude,1) ;;
  }

  dimension: has_user_id {
    type: yesno
    view_label: "Visitors"
    description: "Did the visitor sign in as a website user?"
    sql: ${users.id} > 0 ;;
  }

  dimension: browser {
    view_label: "Visitors"
    sql: ${TABLE}.browser ;;
  }

  dimension: os {
    label: "Operating System"
    view_label: "Visitors"
    sql: ${TABLE}.os ;;
  }

  measure: count {
    type: count
    drill_fields: [simple_page_info*]
  }

  measure: user_count {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: sessions_count {
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: count_m {
    label: "Count (MM)"
    type: number
    hidden: yes
    sql: ${count}/1000000.0 ;;
    drill_fields: [simple_page_info*]
    value_format: "#.### \"M\""
  }

  measure: unique_visitors_m {
    label: "Unique Visitors (MM)"
    view_label: "Visitors"
    type: number
    sql: count (distinct ${ip}) / 1000000.0 ;;
    description: "Uniqueness determined by IP Address and User Login"
    value_format: "#.### \"M\""
    hidden: yes
    drill_fields: [visitors*]
  }

  measure: unique_visitors_k {
    label: "Unique Visitors (k)"
    view_label: "Visitors"
    type: number
    hidden: yes
    description: "Uniqueness determined by IP Address and User Login"
    sql: count (distinct ${ip}) / 1000.0 ;;
    value_format: "#.### \"k\""
    drill_fields: [visitors*]
  }

  set: simple_page_info {
    fields: [event_id, event_time, event_type,
      #       - os
      #       - browser
      full_page_url, user_id, funnel_step]
  }

  set: visitors {
    fields: [ip, os, browser, user_id, count]
  }





################################################################
# A/B Test Example
################################################################

  filter: select_a_test {
    view_label: "A/B Testing"
    suggestions: ["V1/V2","V1/V3"]
  }

  dimension: test {
    view_label: "A/B Testing"
    type: string
    sql: CASE
          WHEN {% parameter select_a_test %} = 'V1/V2' THEN 'Test: App Version 1 vs. 2'
          WHEN {% parameter select_a_test %} = 'V1/V3' THEN 'Test: App Version 1 vs. 3'
          ELSE 'Test: App Version 1 vs. 2'
        END ;;
  }

  dimension: userid {
    label: "User ID"
    view_label: "A/B Testing"
    sql: ${user_id} ;;
  }

# arbitrary split for purposes of this example
  dimension: test_group {
    view_label: "A/B Testing"
    description: "Control or Experimental Group"
    type: string
    sql:  CASE
          WHEN {% parameter select_a_test %} = 'V1/V2' THEN
            (CASE
              WHEN left(${userid},1) <= 5 THEN 'Experimental'
              WHEN left(${userid},1) > 5 AND left(${userid},1) <= 9 THEN 'Control'
              ELSE NULL
            END)
          WHEN {% parameter select_a_test %} = 'V1/V3' THEN
            (CASE
              WHEN left(${userid},1) <= 6 THEN 'Control'
              WHEN left(${userid},1) > 6 AND left(${userid},1) <= 9 THEN 'Experimental'
              ELSE NULL
            END)
          ELSE
            (CASE
              WHEN left(${userid},1) <= 5 THEN 'Experimental'
              WHEN left(${userid},1) > 5 AND left(${userid},1) <= 9 THEN 'Control'
              ELSE NULL
            END)
          END
        ;;
  }

######### test group counts #########
  measure: number_of_users_control {
    view_label: "A/B Testing"
    group_label: "1. Sample Size"
    description: "Number of users in the control group"
    type: count_distinct
    sql: ${userid} ;;
    filters: {
      field: test_group
      value: "Control"
    }
    drill_fields: [test_group, user_id, users.email, users.gender, users.age, users.state]
  }

  measure: number_of_users_experimental {
    view_label: "A/B Testing"
    group_label: "1. Sample Size"
    description: "Number of users in the experimental group"
    type: count_distinct
    sql: ${userid} ;;
    filters: {
      field: test_group
      value: "Experimental"
    }
    drill_fields: [test_group, user_id, users.email, users.gender, users.age, users.state]
  }


######### variable of interest #########
# in this example, the metric being measured is lifetime sessions of our different user groups
 measure: average_lifetime_sessions_control {
    view_label: "A/B Testing"
    group_label: "2. Outcome"
    description: "Average lifetime orders of users from the control group"
    type: average
    sql: ${user_session_facts.lifetime_sessions} ;;
    filters: {
      field: test_group
      value: "Control"
    }
    value_format_name: decimal_2
    drill_fields: [test_group, user_id, users.email, users.gender, users.age, users.state, user_session_facts.lifetime_sessions]
  }

  measure: average_lifetime_sessions_experimental {
    view_label: "A/B Testing"
    group_label: "2. Outcome"
    description: "Average lifetime orders of users from the experimental group"
    type: average
    sql: ${user_session_facts.lifetime_sessions} ;;
    filters: {
      field: test_group
      value: "Experimental"
    }
    value_format_name: decimal_2
    drill_fields: [test_group, user_id, users.email, users.gender, users.age, users.state, user_session_facts.lifetime_sessions]
  }

######### standard deviation, t score, and significance calculations #########
# t-test is used in this example because the metric being measured is a mean
# chi squared could also be used - see this example: https://discourse.looker.com/t/simplified-a-b-test-analysis-redshift-python-udf-and-p-value-measure/2635

  measure: stdev_control {
    view_label: "A/B Testing"
    group_label: "3. Stats"
    type: number
    sql: 1.0 * STDDEV_SAMP(CASE WHEN ${test_group} = 'Control' THEN ${user_order_facts.lifetime_orders} ELSE NULL END);;
    value_format_name: decimal_2
    drill_fields: [test_group, user_id, users.email, users.gender, users.age, users.state, user_session_facts.lifetime_sessions]
    }

  measure: stdev_experimental {
    view_label: "A/B Testing"
    group_label: "3. Stats"
    type: number
    sql: 1.0 * STDDEV_SAMP(CASE WHEN ${test_group} = 'Experimental' THEN ${user_order_facts.lifetime_orders} ELSE NULL END);;
    value_format_name: decimal_2
    drill_fields: [test_group, user_id, users.email, users.gender, users.age, users.state, user_session_facts.lifetime_sessions]
  }

  measure: t_score {
    view_label: "A/B Testing"
    group_label: "3. Stats"
    type: number
    sql: 1.0 * (${average_lifetime_sessions_control} - ${average_lifetime_sessions_experimental}) /
          SQRT(
            (POWER(${stdev_control},2) / ${number_of_users_control}) + (POWER(${stdev_experimental},2) / ${number_of_users_experimental})
          ) ;;
    value_format_name: decimal_2
    drill_fields: [number_of_users_control, number_of_users_experimental, average_lifetime_sessions_control, average_lifetime_sessions_experimental, stdev_control, stdev_experimental]
  }

  measure: significance_level{
    view_label: "A/B Testing"
    group_label: "3. Stats"
    sql: CASE
          WHEN (ABS(${t_score}) > 3.291) THEN '.0005'
          WHEN (ABS(${t_score}) > 3.091) THEN '.001'
          WHEN (ABS(${t_score}) > 2.576) THEN '.005'
          WHEN (ABS(${t_score}) > 2.326) THEN '.01'
          WHEN (ABS(${t_score}) > 1.960) THEN '.025'
          WHEN (ABS(${t_score}) > 1.645) THEN '.05'
          WHEN (ABS(${t_score}) > 1.282) THEN '.1'
          ELSE 'Insignificant'
        END ;;
  }

  measure: significant {
    view_label: "A/B Testing"
    group_label: "3. Stats"
    type: string
    sql: CASE
          WHEN ${significance_level} = 'Insignificant' THEN 'Insignificant'
          ELSE 'Statistically Significant'
        END ;;
  }

}
