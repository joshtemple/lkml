view: v_site_cost_by_day {
  sql_table_name: aws_cost.v_site_cost_by_day ;;

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

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: cpm_events {
    view_label: "CPMs"
    type: average
    sql: ${TABLE}.cpm_events ;;
    value_format:"$#0.0000"
  }

  measure: cpm_messages {
    view_label: "CPMs"
    type: average
    sql: ${TABLE}.cpm_messages ;;
    value_format:"$#0.0000"
  }

  measure: cpm_recommendations {
    view_label: "CPMs"
    type: average
    sql: ${TABLE}.cpm_recommendations ;;
    value_format:"$#0.0000"
  }


  measure: cpm_identity {
    view_label: "CPMs"
    type: average
    sql: ${TABLE}.cpm_identity ;;
    value_format:"$#0.0000"
  }


  measure: cpm_recset_events {
    view_label: "CPMs"
    type: average
    sql: ${TABLE}.cpm_recset_events ;;
    value_format:"$#0.0000"
  }

  measure: all_events_count {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.all_events_count ;;

  }

  measure: messages_sent {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_sent ;;

  }

  measure: bt_person_sets {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_person_sets ;;

  }

  measure: bt_recs_served {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_recs_served ;;

  }

  measure: bt_recset_requests {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_recset_requests ;;

  }

  measure: all_events_cost {
    view_label: "Site Cost"
    type: sum
    sql: ${TABLE}.cpm_events*(${TABLE}.all_events_count/1000) ;;
    value_format_name: usd_0
  }

  measure: message_cost {
    view_label: "Site Cost"
    type: sum
    sql: ${TABLE}.cpm_messages*(${TABLE}.messages_sent/1000) ;;
    value_format_name: usd_0
  }

  measure: recommendation_cost {
    view_label: "Site Cost"
    type: sum
    sql: ${TABLE}.cpm_recommendations*(${TABLE}.bt_recs_served/1000) ;;
    value_format_name: usd_0
  }

  measure: recset_cost {
    view_label: "Site Cost"
    type: sum
    sql: ${TABLE}.cpm_recset_events*(${TABLE}.bt_recset_requests/1000) ;;
    value_format_name: usd_0
  }

  measure: identity_cost {
    view_label: "Site Cost"
    type: sum
    sql: ${TABLE}.cpm_identity*(${TABLE}.bt_person_sets/1000) ;;
    value_format_name: usd_0
  }

  measure: client_generated_cost {
    view_label: "Site Cost"
    type: sum
    sql: (
    (${TABLE}.cpm_events*(${TABLE}.all_events_count/1000)) -
    ((${TABLE}.cpm_messages*(${TABLE}.messages_sent/1000))+
    (${TABLE}.cpm_recommendations*(${TABLE}.bt_recs_served/1000))+
    (${TABLE}.cpm_recset_events*(${TABLE}.bt_recset_requests/1000))+
    (${TABLE}.cpm_identity*(${TABLE}.bt_person_sets/1000))
    )) ;;
    value_format_name: usd_0
  }
}
