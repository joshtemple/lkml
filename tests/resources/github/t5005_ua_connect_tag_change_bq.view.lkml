view: t5005_ua_connect_tag_change_bq {
  sql_table_name: UA_CONNECT.t5005_ua_connect_tag_change ;;

  dimension: c5005_added_device_tags {
    view_label: "Device Tags"
    type: string
    sql: ${TABLE}.c5005_added_device_tags ;;
  }

  dimension: c5005_added_tags {
    view_label: "All Tags"
    type: string
    sql: ${TABLE}.c5005_added_tags ;;
  }

  dimension: c5005_adid {
    view_label: "Device User"
    type: string
    sql: ${TABLE}.c5005_ADID ;;
  }

  dimension: c5005_current_device_tags {
    view_label: "Device Tags"
    type: string
    sql: ${TABLE}.c5005_current_device_tags ;;
  }

  dimension: c5005_current_tags {
    view_label: "All Tags"
    type: string
    sql: ${TABLE}.c5005_current_tags ;;
  }

  dimension: c5005_device_type {
    type: string
    sql: ${TABLE}.c5005_device_type ;;
  }

  dimension: c5005_event_type {
    type: string
    sql: ${TABLE}.c5005_event_type ;;
  }

  dimension: c5005_limited_ad_tracking {
    type: string
    sql: ${TABLE}.c5005_limited_ad_tracking ;;
  }

  dimension_group: c5005_occurred {
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
    convert_tz: no
    datatype: date
    sql: CAST(${TABLE}.c5005_occurred_time AS TIMESTAMP) ;;
  }

  dimension_group: c5005_processed {
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
    convert_tz: no
    datatype: date
    sql: CAST(${TABLE}.c5005_processed_time AS TIMESTAMP) ;;
  }

  dimension: c5005_removed_device_tags {
    view_label: "Device Tags"
    type: string
    sql: ${TABLE}.c5005_removed_device_tags ;;
  }

  dimension: c5005_removed_tags {
    view_label: "All Tags"
    type: string
    sql: ${TABLE}.c5005_removed_tags ;;
  }

  dimension: c5005_ua_device_attributes {
    type: string
    sql: ${TABLE}.c5005_ua_device_attributes ;;
  }

  dimension: c5005_ua_device_channel {
    view_label: "Device User"
    type: string
    sql: ${TABLE}.c5005_ua_device_channel ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }


  measure: distinct_channel_id {
    view_label: "Device User"
    type: count_distinct
    value_format: "#,##0"
    #  value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${c5005_ua_device_channel} ;;
  }

  measure: distinct_adid {
    view_label: "Device User"
    type: count_distinct
    value_format: "#,##0"
    #  value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${c5005_adid} ;;
  }

}
