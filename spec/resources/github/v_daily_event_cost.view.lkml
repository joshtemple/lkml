view: v_daily_event_cost {
  sql_table_name: aws_cost.v_daily_event_cost;;

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

  measure: count {
    type: count
    drill_fields: []
  }

  measure: lineitem_blendedcost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.lineitem_blendedcost ;;
    value_format_name: usd_0
  }

  measure: event_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.event_cost ;;
    value_format_name: usd_0
  }

  measure: identity_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.identity_cost ;;
    value_format_name: usd_0
  }

  measure: infrastructure_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.infrastructure_cost ;;
    value_format_name: usd_0
  }

  measure: other_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.other_cost ;;
    value_format_name: usd_0
  }

  measure: recommendation_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.recommendation_cost ;;
    value_format_name: usd_0
  }
  measure: resource_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.resource_cost ;;
    value_format_name: usd_0
  }
  measure: ri_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.ri_cost ;;
    value_format_name: usd_0
  }


  measure: uncategorized_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.uncategorized_cost ;;
    value_format_name: usd_0
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

  measure: cpm_resources {
    view_label: "CPMs"
    type: average
    sql: ${TABLE}.cpm_resources;;
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

  measure: resource_events {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.resource_events ;;

  }

}
