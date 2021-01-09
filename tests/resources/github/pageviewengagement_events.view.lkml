view: pageviewengagement_events {
  sql_table_name: burda_forward.pageviewengagement_events;;

  dimension: event_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.event_id ;;
  }

  dimension: partition_date {
    type:  date
    sql: ${TABLE}._PARTITIONTIME ;;
  }

  dimension: properties__client__domain {
    view_label: "Properties"
    type: string
    sql: ${TABLE}.properties.client.domain ;;
  }

  dimension: properties__client__referrer {
    type: string
    view_label: "Properties"
    sql: ${TABLE}.properties.client.referrer ;;
  }

  dimension: properties__client__title {
    type: string
    view_label: "Properties"
    sql: ${TABLE}.properties.client.title ;;
  }

  dimension: properties__client__type {
    type: string
    view_label: "Properties"
    sql: ${TABLE}.properties.client.type ;;
  }

  dimension: properties__client__url {
    type: string
    view_label: "Properties"
    sql: ${TABLE}.properties.client.url ;;
  }

  dimension: properties__client__user_agent {
    type: string
    view_label: "Properties"
    sql: ${TABLE}.properties.client.user_agent ;;
  }

  dimension: properties__completion {
    type: number
    view_label: "Properties"
    sql: ${TABLE}.properties.completion ;;
  }

  dimension: properties__engaged_time {
    type: number
    view_label: "Properties"
    sql: ${TABLE}.properties.engaged_time ;;
  }

  dimension: properties_visit_id {
    type: string
    view_label: "Properties"
    sql: ${TABLE}.properties.visit_id ;;
  }

  dimension: segments {
    type: number
    hidden: yes
    sql: ${TABLE}.segments ;;
    fanout_on: "segments"
  }

  dimension: session_id {
    type: string
    view_label: "Sessions"
#     hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: source_id {
    type: string
    sql: ${TABLE}.source_id ;;
  }

  dimension_group: time {
    label: "Event"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      hour
    ]
    sql: ${TABLE}.time ;;
  }

  filter: date_group {
    suggestions: ["Date", "Week", "Month", "Hour"]
  }

  dimension: dynamic_date_group {
    sql:  CASE
        WHEN {% parameter date_group %} = 'Date' THEN cast(${time_date} as string)
        WHEN {% parameter date_group %} = 'Week' THEN ${time_week}
        WHEN {% parameter date_group %} = 'Month' THEN ${time_month}
        WHEN {% parameter date_group %} = 'Hour' THEN ${time_hour}
        END ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: pageviews {
    type: count_distinct
    sql: ${properties_visit_id} ;;
  }

  measure: engaged_time_event_count {
    type: count
    drill_fields: []
  }

  measure: engaged_time_seconds {
    type: number
    sql: ${engaged_time_event_count}*5 ;;
  }

  measure: engaged_time_hours {
    type: number
    sql: round((${engaged_time_event_count}*5)/3600,1) ;;
  }

  measure: uniques {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: sessions {
    type: count_distinct
    view_label: "Sessions"
    sql: ${session_id} ;;
  }

  measure: average_engaged_time_per_session {
    type: number
    sql: ${engaged_time_seconds}/(CASE WHEN ${sessions} = 0 THEN NULL ELSE ${sessions} END) ;;
    value_format_name: decimal_2
  }

  measure: average_pageviews_per_session {
    type: number
    sql: ${pageviews}/(CASE WHEN ${sessions} = 0 THEN NULL ELSE ${sessions} END) ;;
    value_format_name: decimal_1
  }

}
