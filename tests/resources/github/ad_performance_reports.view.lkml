view: ad_performance_reports {
  sql_table_name: adwords.ad_performance_reports ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

#   dimension: active_view_impressions {
#     type: number
#     sql: ${TABLE}.active_view_impressions ;;
#   }
#
#   dimension: active_view_measurability {
#     type: number
#     sql: ${TABLE}.active_view_measurability ;;
#   }
#
#   dimension: active_view_measurable_cost {
#     type: number
#     sql: ${TABLE}.active_view_measurable_cost ;;
#   }
#
#   dimension: active_view_measurable_impressions {
#     type: number
#     sql: ${TABLE}.active_view_measurable_impressions ;;
#   }
#
#   dimension: active_view_viewability {
#     type: number
#     sql: ${TABLE}.active_view_viewability ;;
#   }

  dimension: ad_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ad_id ;;
  }

#   dimension: adwords_customer_id {
#     type: string
#     sql: ${TABLE}.adwords_customer_id ;;
#   }

  measure: all_conversion_rate {
    type: average_distinct
    value_format: "0.00\%"
    sql: ${TABLE}.all_conversion_rate ;;
  }

  measure: all_conversion_value {
    type: sum_distinct
    value_format: "$#,##0.00"
    sql: ${TABLE}.all_conversion_value ;;
  }

  measure: all_conversions {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.all_conversions ;;
  }

  measure: average_cost {
    type: average_distinct
    value_format: "$#,##0.00"
    sql: ${TABLE}.average_cost / 1000000 ;;
  }

  measure: average_position {
    type: average_distinct
    value_format: "#,##0.00"
    sql: ${TABLE}.average_position ;;
  }

  measure: average_time_on_site {
    type: average_distinct
    value_format: "#,##0.00"
    sql: ${TABLE}.average_time_on_site ;;
  }

  measure: bounce_rate {
    type: average_distinct
    value_format: "0.00\%"
    sql: ${TABLE}.bounce_rate ;;
  }

#   dimension: click_assisted_conversion_value {
#     type: number
#     sql: ${TABLE}.click_assisted_conversion_value ;;
#   }
#
#   dimension: click_assisted_conversions {
#     type: number
#     sql: ${TABLE}.click_assisted_conversions ;;
#   }
#
#   dimension: click_assisted_conversions_over_last_click_conversions {
#     type: number
#     sql: ${TABLE}.click_assisted_conversions_over_last_click_conversions ;;
#   }

  measure: clicks {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.clicks ;;
  }

  measure: conversion_value {
    type: sum_distinct
    value_format: "$#,##0.00"
    sql: ${TABLE}.conversion_value / 1000000 ;;
  }

  measure: conversions {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.conversions ;;
  }

  measure: cost {
    type: sum_distinct
    value_format: "$#,##0.00"
    sql: ${TABLE}.cost / 1000000 ;;
  }

  dimension_group: date {
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

#   dimension_group: date_stop {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.date_stop ;;
#   }

  measure: engagements {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.engagements ;;
  }

#   dimension: gmail_forwards {
#     type: number
#     sql: ${TABLE}.gmail_forwards ;;
#   }
#
#   dimension: gmail_saves {
#     type: number
#     sql: ${TABLE}.gmail_saves ;;
#   }
#
#   dimension: gmail_secondary_clicks {
#     type: number
#     sql: ${TABLE}.gmail_secondary_clicks ;;
#   }

  measure: impression_assisted_conversions {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.impression_assisted_conversions ;;
  }

  measure: impressions {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;;
  }

  dimension: interaction_types {
    type: string
    sql: ${TABLE}.interaction_types ;;
  }

  measure: interactions {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.interactions ;;
  }

#   dimension_group: loaded {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.loaded_at ;;
#   }

#   dimension_group: received {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.received_at ;;
#   }

#   dimension_group: uuid_ts {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.uuid_ts ;;
#   }

  measure: value_per_all_conversion {
    type: sum_distinct
    value_format: "$#,##0.00"
    sql: ${TABLE}.value_per_all_conversion / 1000000 ;;
  }

#   dimension: video_quartile_100_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_100_rate ;;
#   }
#
#   dimension: video_quartile_25_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_25_rate ;;
#   }
#
#   dimension: video_quartile_50_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_50_rate ;;
#   }
#
#   dimension: video_quartile_75_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_75_rate ;;
#   }
#
#   dimension: video_view_rate {
#     type: number
#     sql: ${TABLE}.video_view_rate ;;
#   }
#
#   dimension: video_views {
#     type: number
#     sql: ${TABLE}.video_views ;;
#   }

  measure: view_through_conversions {
    type: sum_distinct
    value_format: "#,##0"
    sql: ${TABLE}.view_through_conversions ;;
  }

  measure: cost_per_acq_multi_device_channel {
    type: number
    value_format: "$#,##0.00"
    sql: ${cost}/NULLIF(${completed_order.distinct_orders},0) ;;
  }

  measure: count {
    type: count
    drill_fields: [id, ads.id]
  }
}
