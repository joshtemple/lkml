view: t5002_ua_connect_push_body {
  sql_table_name: PUBLIC.T5002_UA_CONNECT_PUSH_BODY ;;

  dimension: c5002_event_type {
    view_label: "Push Body"
    type: string
    sql: ${TABLE}.C5002_EVENT_TYPE ;;
  }

  dimension_group: c5002_occurred {
    view_label: "Push Body"
    type: time
    timeframes: [
      raw,
      date,
      hour_of_day,
      time,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.C5002_OCCURRED_TIME ;;
  }

  dimension: c5002_payload {
    view_label: "Push Body"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD ;;
  }

  dimension_group: c5002_processed {
    view_label: "Push Body"
    type: time
    timeframes: [
      raw,
      date,
      hour_of_day,
      time,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.C5002_PROCESSED_TIME ;;
  }

  dimension: c5002_push_id {
    view_label: "Push Body"
    type: string
    sql: ${TABLE}.C5002_PUSH_ID ;;
    html: <a href="/dashboards/224?PushID={{value}}">{{value}}</a> ;;
#    html: <a href="/looks/2623?f[ua_connect_open.triggering_push_id]={{value}}">{{value}}</a> ;;
  }

  dimension: c5002_resource {
    view_label: "Push Body"
    type: string
    sql: ${TABLE}.C5002_RESOURCE ;;
  }

  dimension: audience {
    view_label: "Push Payload"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:audience::string ;;
  }

  dimension: device_types {
    view_label: "Push Payload"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:device_types::string ;;
  }

  dimension: notification_cid {
    view_label: "Push Payload"
    type: string
    sql: regexp_replace(TRIM(regexp_substr(${TABLE}.C5002_PAYLOAD:notification:actions:open:content::string,'_.*&'),'_&'),'_.+') ;;
  }

  dimension: notification_content {
    view_label: "Push Payload"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:notification:actions:open:content::string ;;
  }

  dimension: notification_type {
    view_label: "Push Payload"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:notification:actions:open:type::string ;;
  }

  dimension: notification_alert {
    view_label: "Push Payload"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:notification:alert::string ;;
  }

  dimension: notification_ios_sound {
    view_label: "Push Payload"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:notification:ios:sound::string ;;
  }

  dimension: schedule_audience {
    view_label: "Schedules"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:push:audience::string ;;
  }

  dimension: schedule_device_types {
    view_label: "Schedules"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:push:device_types::string ;;
  }

  dimension: schedule_notification_cid {
    view_label: "Schedules"
    type: string
    sql: regexp_replace(TRIM(regexp_substr(${TABLE}.C5002_PAYLOAD:push:notification:actions:open:content::string,'_.*&'),'_&'),'_.+') ;;
  }

  dimension: schedule_notification_content {
    view_label: "Schedules"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:push:notification:actions:open:content::string ;;
  }

  dimension: schedule_notification_type {
    view_label: "Schedules"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:push:notification:actions:open:type::string ;;
  }

  dimension: schedule_notification_alert {
    view_label: "Schedules"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:push:notification:alert::string ;;
  }

  dimension: schedule_push_ids {
    view_label: "Schedules"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:push_ids::string ;;
  }

  dimension_group: scheduled_time {
    view_label: "Schedules"
    type: time
    sql: CONVERT_TIMEZONE('UTC', 'Hongkong', CAST(${TABLE}.C5002_PAYLOAD:schedule:scheduled_time::timestamp AS TIMESTAMP_NTZ)) ;;
  }

  dimension: experiment_device_types {
    view_label: "Experiments"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:device_types::string ;;
  }

  dimension: experiment_audience {
    view_label: "Experiments"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:audience::string ;;
  }

  dimension_group: experiment_created {
    view_label: "Experiments"
    type: time
    sql: CONVERT_TIMEZONE('UTC', 'Hongkong', CAST(${TABLE}.C5002_PAYLOAD:created_at::timestamp AS TIMESTAMP_NTZ)) ;;
  }

  dimension: experiment_name {
    view_label: "Experiments"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:name::string ;;
  }

  dimension: experiment_variant_1 {
    view_label: "Experiments"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:variants[0]::variant ;;
  }

  dimension: experiment_variant_1_name {
    view_label: "Experiments"
    type: string
    sql: ${TABLE}.PAYLOAD:variants[0]:name::string ;;
  }

  dimension: experiment_variant_2 {
    view_label: "Experiments"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:variants[1]::variant ;;
  }

  dimension: experiment_variant_2_name {
    view_label: "Experiments"
    type: string
    sql: ${TABLE}.C5002_PAYLOAD:variants[1]:name::variant ;;
  }

  measure: count {
    view_label: "Push Body"
    type: count
    drill_fields: []
  }

  set: push_body_set {
    fields: [
      c5002_push_id,
      c5002_event_type,
      c5002_occurred_date,
      c5002_occurred_time,
      c5002_processed_date,
      c5002_processed_time,
      c5002_payload,
      c5002_resource,
      count
    ]
  }

  set: push_payload_set {
    fields: [
      audience,
      device_types,
      notification_cid,
      notification_content,
      notification_type,
      notification_alert,
      notification_ios_sound
    ]
  }


  set: schedule_set {
    fields: [
      schedule_audience,
      schedule_device_types,
      schedule_notification_cid,
      schedule_notification_content,
      schedule_notification_type,
      schedule_notification_alert,
      schedule_push_ids,
      scheduled_time_date,
      scheduled_time_time

    ]
  }

  set: experiments_set {
    fields: [
      experiment_audience,
      experiment_device_types,
      experiment_created_date,
      experiment_created_time,
      experiment_name,
      experiment_variant_1_name,
      experiment_variant_1,
      experiment_variant_2_name,
      experiment_variant_2
    ]
  }
}
