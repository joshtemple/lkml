view: view_homepage {
  sql_table_name: heap_production.view_homepage ;;

##################### Measures #######################

  measure: count_sessions {
    view_label: "(0) Measures"
    type: count_distinct
    hidden: yes
    sql: ${looker_session_id} ;;
  }

  measure: count_exited {
    type: number
    view_label: "(0) Measures"
    value_format_name: decimal_0
    description: "Number of sessions that ended on this page"
    sql: ${session_last_page_details.count_exits} ;;
  }

  measure: percent_exited {
    view_label: "(0) Measures"
    type: number
    value_format_name: percent_2
    description: "Percent of sessions that include this page that ended on this page"
    sql: 1.0*${session_last_page_details.count_exits}/nullif(${count_sessions},0) ;;
  }

################## Dimensions ####################

  dimension: looker_session_id {
    hidden: yes
    type: string
    sql:${user_id} || '-' || ${pdt_sessions_from_events.session_number} ;;
  }

  dimension: logged_in {
    hidden: yes
    type: string
    sql: ${TABLE}.logged_in ;;
  }

  dimension: vertical_horizontal_layout {
    hidden: yes
    type: string
    sql: ${TABLE}.vertical_horizontal_layout ;;
  }

  dimension: social_network {
    view_label: "(00) Marketing"
    hidden: yes
    type: string
    sql: ${TABLE}.social_network ;;
  }

  dimension: marketing_channel {
    view_label: "(00) Marketing"
#     hidden: yes
    type: string
    sql: ${TABLE}.marketing_channel ;;
  }

  dimension: page_type {
    type: string
    sql: ${TABLE}.page_type ;;
  }

  dimension: search_engine {
    view_label: "(00) Marketing"
    type: string
    sql: ${TABLE}.search_engine ;;
  }

  dimension: browser_type {
    view_label: "(00) Marketing"
    hidden: yes
    type: string
    sql: ${TABLE}.browser_type ;;
  }

  dimension: continent {
    view_label: "(00) Marketing"
    hidden: yes
    type: string
    sql: ${TABLE}.continent ;;
  }

  dimension: event_id {
    hidden: yes
    type: number
    sql: ${TABLE}.event_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: event {
    type: time
    timeframes: [raw, time]
    sql: ${TABLE}."time" ;;
  }

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: device_type {
    view_label: "(00) Marketing"
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: country {
    view_label: "(00) Marketing"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: region {
    view_label: "(00) Marketing"
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: city {
    view_label: "(00) Marketing"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: utm_content {
    view_label: "(00) Marketing"
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: path {
    type: string
    sql: ${TABLE}.path ;;
  }

    dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

}
