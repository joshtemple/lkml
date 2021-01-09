view: ad_performance_reports_view {
  sql_table_name: adwords.ad_performance_reports_view ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: active_view_impressions {
    type: number
    sql: ${TABLE}.active_view_impressions ;;
  }

  dimension: active_view_measurability {
    type: number
    sql: ${TABLE}.active_view_measurability ;;
  }

  dimension: active_view_measurable_cost {
    type: number
    sql: ${TABLE}.active_view_measurable_cost ;;
  }

  dimension: active_view_measurable_impressions {
    type: number
    sql: ${TABLE}.active_view_measurable_impressions ;;
  }

  dimension: active_view_viewability {
    type: number
    sql: ${TABLE}.active_view_viewability ;;
  }

  dimension: ad_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ad_id ;;
  }

  dimension: adwords_customer_id {
    type: string
    sql: ${TABLE}.adwords_customer_id ;;
  }

  dimension: all_conversion_rate {
    type: number
    sql: ${TABLE}.all_conversion_rate ;;
  }

  dimension: all_conversion_value {
    type: number
    sql: ${TABLE}.all_conversion_value ;;
  }

  dimension: all_conversions {
    type: number
    sql: ${TABLE}.all_conversions ;;
  }

  dimension: average_cost {
    type: number
    sql: ${TABLE}.average_cost ;;
  }

  dimension: average_position {
    type: number
    sql: ${TABLE}.average_position ;;
  }

  dimension: average_time_on_site {
    type: number
    sql: ${TABLE}.average_time_on_site ;;
  }

  dimension: bounce_rate {
    type: number
    sql: ${TABLE}.bounce_rate ;;
  }

  dimension: click_assisted_conversion_value {
    type: number
    sql: ${TABLE}.click_assisted_conversion_value ;;
  }

  dimension: click_assisted_conversions {
    type: number
    sql: ${TABLE}.click_assisted_conversions ;;
  }

  dimension: click_assisted_conversions_over_last_click_conversions {
    type: number
    sql: ${TABLE}.click_assisted_conversions_over_last_click_conversions ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversion_value {
    type: number
    sql: ${TABLE}.conversion_value ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: date_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_start ;;
  }

  dimension_group: date_stop {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_stop ;;
  }

  dimension: engagements {
    type: number
    sql: ${TABLE}.engagements ;;
  }

  dimension: gmail_forwards {
    type: number
    sql: ${TABLE}.gmail_forwards ;;
  }

  dimension: gmail_saves {
    type: number
    sql: ${TABLE}.gmail_saves ;;
  }

  dimension: gmail_secondary_clicks {
    type: number
    sql: ${TABLE}.gmail_secondary_clicks ;;
  }

  dimension: impression_assisted_conversions {
    type: number
    sql: ${TABLE}.impression_assisted_conversions ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: interaction_types {
    type: string
    sql: ${TABLE}.interaction_types ;;
  }

  dimension: interactions {
    type: number
    sql: ${TABLE}.interactions ;;
  }

  dimension_group: loaded {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.loaded_at ;;
  }

  dimension_group: received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.received_at ;;
  }

  dimension_group: uuid_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.uuid_ts ;;
  }

  dimension: value_per_all_conversion {
    type: number
    sql: ${TABLE}.value_per_all_conversion ;;
  }

  dimension: video_quartile_100_rate {
    type: number
    sql: ${TABLE}.video_quartile_100_rate ;;
  }

  dimension: video_quartile_25_rate {
    type: number
    sql: ${TABLE}.video_quartile_25_rate ;;
  }

  dimension: video_quartile_50_rate {
    type: number
    sql: ${TABLE}.video_quartile_50_rate ;;
  }

  dimension: video_quartile_75_rate {
    type: number
    sql: ${TABLE}.video_quartile_75_rate ;;
  }

  dimension: video_view_rate {
    type: number
    sql: ${TABLE}.video_view_rate ;;
  }

  dimension: video_views {
    type: number
    sql: ${TABLE}.video_views ;;
  }

  dimension: view_through_conversions {
    type: number
    sql: ${TABLE}.view_through_conversions ;;
  }

  measure: count {
    type: count
    drill_fields: [id, ads.id]
  }
}
