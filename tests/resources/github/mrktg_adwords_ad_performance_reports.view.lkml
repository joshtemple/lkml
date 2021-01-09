view: mrktg_adwords_ad_performance_reports {
  sql_table_name: adwords.ad_performance_reports ;;

  set:adwords_drillthrough {
    fields: [
      account_name,
      account_goal,
      account_vehicle_type,
      spend,
      clicks,
      impressions
    ]
  }


  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: account_currency_code {
    type: string
    hidden: yes
    sql: ${TABLE}.account_currency_code ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_descriptive_name ;;
  }

  dimension: account_goal {
    type: string
    sql: f_sql_mrktg_acct_name_goal(${TABLE}.account_descriptive_name) ;;
  }

  dimension: account_vehicle_type {
    type: string
    sql: f_sql_mrktg_acct_name_veh_type(${TABLE}.account_descriptive_name) ;;
  }

  dimension: active_view_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.active_view_impressions ;;
  }

  dimension: active_view_measurability {
    type: number
    hidden: yes
    sql: ${TABLE}.active_view_measurability ;;
  }

  dimension: active_view_measurable_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.active_view_measurable_cost ;;
  }

  dimension: active_view_measurable_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.active_view_measurable_impressions ;;
  }

  dimension: active_view_viewability {
    type: number
    hidden: yes
    sql: ${TABLE}.active_view_viewability ;;
  }

  dimension: ad_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ad_id ;;
  }

  dimension: adwords_customer_id {
    type: string
    hidden: yes
    sql: ${TABLE}.adwords_customer_id ;;
  }

  dimension: all_conversion_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.all_conversion_rate ;;
  }

  dimension: all_conversion_value {
    type: number
    hidden: yes
    sql: ${TABLE}.all_conversion_value ;;
  }

  dimension: all_conversions {
    type: number
    hidden: yes
    sql: ${TABLE}.all_conversions ;;
  }

  dimension: average_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.average_cost ;;
  }

  dimension: average_position {
    type: number
    hidden: yes
    sql: ${TABLE}.average_position ;;
  }

  dimension: average_time_on_site {
    type: number
    hidden: yes
    sql: ${TABLE}.average_time_on_site ;;
  }

  dimension: bounce_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.bounce_rate ;;
  }

  dimension: click_assisted_conversions {
    type: number
    hidden: yes
    sql: ${TABLE}.click_assisted_conversions ;;
  }

  dimension: clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversion_value {
    type: number
    hidden: yes
    sql: ${TABLE}.conversion_value ;;
  }

  dimension: conversions {
    type: number
    hidden: yes
    sql: ${TABLE}.conversions ;;
  }

  dimension: spend {
    type: number
    hidden: yes
    sql: ${TABLE}.cost ;;
  }

  dimension_group: ad_date {
    type: time
    timeframes: [
#       raw,
#       time,
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
    hidden: yes
    timeframes: [
#       raw,
#       time,
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
    hidden: yes
    sql: ${TABLE}.engagements ;;
  }

  dimension: gmail_forwards {
    type: number
    hidden: yes
    sql: ${TABLE}.gmail_forwards ;;
  }

  dimension: gmail_saves {
    type: number
    hidden: yes
    sql: ${TABLE}.gmail_saves ;;
  }

  dimension: gmail_secondary_clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.gmail_secondary_clicks ;;
  }

  dimension: impression_assisted_conversions {
    type: number
    hidden: yes
    sql: ${TABLE}.impression_assisted_conversions ;;
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.impressions ;;
  }

  dimension: interaction_types {
    type: string
    hidden: yes
    sql: ${TABLE}.interaction_types ;;
  }

  dimension: interactions {
    type: number
    hidden: yes
    sql: ${TABLE}.interactions ;;
  }

  dimension_group: received {
    type: time
    hidden: yes
    timeframes: [
#       raw,
#       time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.received_at ;;
  }

  dimension: uuid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.uuid ;;
  }

  dimension_group: uuid_ts {
    type: time
    hidden: yes
    timeframes: [
#       raw,
#       time,
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
    hidden: yes
    sql: ${TABLE}.value_per_all_conversion ;;
  }

  dimension: video_quartile_100_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.video_quartile_100_rate ;;
  }

  dimension: video_quartile_25_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.video_quartile_25_rate ;;
  }

  dimension: video_quartile_50_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.video_quartile_50_rate ;;
  }

  dimension: video_quartile_75_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.video_quartile_75_rate ;;
  }

  dimension: video_view_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.video_view_rate ;;
  }

  dimension: video_views {
    type: number
    hidden: yes
    sql: ${TABLE}.video_views ;;
  }

  dimension: view_through_conversions {
    type: number
    hidden: yes
    sql: ${TABLE}.view_through_conversions ;;
  }

  measure: count {
    type: count
    drill_fields: [adwords_drillthrough*]
  }

  measure: total_spend {
    type: sum
    value_format_name: usd_0
    sql: ${spend}/1000000 ;;
    drill_fields: [adwords_drillthrough*]
  }

  measure: total_clicks {
    type: sum
    value_format_name: decimal_0
    sql: ${clicks} ;;
    drill_fields: [adwords_drillthrough*]
  }

  measure: cost_per_click {
    type: number
    value_format_name: usd
    sql: ${total_spend} / nullif(${total_clicks},0) ;;
    drill_fields: [adwords_drillthrough*]
  }

    measure: total_impressions {
    type: sum
    value_format_name: decimal_0
    sql: ${impressions} ;;
    drill_fields: [adwords_drillthrough*]
  }

  measure: cost_per_impression {
    type: number
    value_format_name: usd
    sql: ${total_spend} / nullif(${total_impressions},0) ;;
    drill_fields: [adwords_drillthrough*]
  }
}
