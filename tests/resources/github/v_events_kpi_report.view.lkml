view: v_events_kpi_report {
  sql_table_name: site_event_aggregates.v_events_kpi_report ;;

  dimension_group: events {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.events_date ;;
  }

  measure: peak_emails_per_hr {
    view_label: "RPS Metrics"
    type: sum
    sql: ${TABLE}.peak_emails_per_hr;;
    value_format:"0"

  }

  measure: peak_events_per_hr {
    view_label: "RPS Metrics"
    type: sum
    sql: ${TABLE}.peak_events_per_hr;;
    value_format:"0"

  }

  measure: peak_events_per_sec {
    view_label: "RPS Metrics"
    type: sum
    sql: ${TABLE}.peak_events_per_sec;;
    value_format:"0"

  }

  measure: peak_recs_per_hr {
    view_label: "RPS Metrics"
    type: sum
    sql: ${TABLE}.peak_recs_per_hr;;
    value_format:"0"

  }

  measure: peak_recs_per_sec {
    view_label: "RPS Metrics"
    type: sum
    sql: ${TABLE}.peak_recs_per_sec;;
    value_format:"0"

  }

  measure: sms_sent {
    view_label: "Notifications"
    type: sum
    sql: ${TABLE}.sms_sent ;;

  }

  measure: emails_sent {
    view_label: "Notifications"
    type: sum
    sql: ${TABLE}.emails_sent ;;

  }

  measure: email_recs {
    view_label: "Recos"
    type: sum
    sql: ${TABLE}.email_recs ;;

  }

  measure: web_recs {
    view_label: "Recos"
    type: sum
    sql: ${TABLE}.web_recs ;;

  }

  measure: total_recs {
    view_label: "Recos"
    type: sum
    sql: ${TABLE}.total_recs ;;

  }

  measure: total_events {
    type: sum
    sql: ${TABLE}.total_events ;;

  }

}
