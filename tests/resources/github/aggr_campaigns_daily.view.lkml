view: aggr_campaigns_daily {
  sql_table_name: campaign_aggregates.aggr_campaigns_daily ;;

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: events_count {
    type: number
    sql: ${TABLE}.events_count ;;
  }

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

  dimension: recurrence_index {
    type: string
    sql: ${TABLE}.recurrence_index ;;
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  dimension: template_id {
    type: string
    sql: ${TABLE}.template_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: all_events_count {
    description: "Sum of all events."
    type: sum
    sql: ${events_count} ;;
  }


  measure: messages_opened {
    view_label: "Nudgespot events"
    description: "Messages Opened"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "nudgespot::message_opened"
    }
  }

  measure: messages_skipped {
    view_label: "Nudgespot events"
    description: "Messages Skipped"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "nudgespot::message_skipped"
    }
  }

  measure: messages_sent {
    view_label: "Nudgespot events"
    description: "Messages Sent"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "nudgespot::message_sent"
    }
  }

  measure: messages_clicked {
    view_label: "Nudgespot events"
    description: "Messages Clicked"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "nudgespot::message_clicked"
    }
  }

  measure: messages_bounced {
    view_label: "System events"
    description: "Messages Bounced"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "system::message_bounced"
    }
  }

  measure: messages_complained {
    view_label: "System events"
    description: "Messages Complained"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "system::message_complained"
    }
  }

  measure: messages_converted {
    view_label: "System events"
    description: "Messages Converted"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "system::message_converted"
    }
  }

  measure: messages_delivered {
    view_label: "System events"
    description: "Messages Delivered"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "system::message_delivered"
    }
  }

  measure: unsubscribed {
    view_label: "System events"
    description: "Unsubscribed"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "system::unsubscribed"
    }
  }

  measure: bt_recset_requests {
    view_label: "BT events"
    description: "bt_recset_request"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "bt_recset_request"
    }
  }

  measure: bt_recs_served {
    view_label: "BT events"
    description: "bt_rec_served"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "bt_rec_served"
    }
  }

  measure: bt_rec_clicks {
    view_label: "BT events"
    description: "bt_rec_click"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "bt_rec_click"
    }
  }

  measure: bt_rec_views {
    view_label: "BT events"
    description: "bt_rec_view"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "bt_rec_view"
    }
  }

  measure: bt_person_sets {
    view_label: "BT events"
    description: "bt_person_set"
    type: sum
    sql: ${events_count} ;;
    filters: {
      field: event_type
      value: "bt_person_set"
    }
  }

}
