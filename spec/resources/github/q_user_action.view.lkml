view: q_user_action {

  # Qubit LookML | Retail | V2
  derived_table: {
    sql: SELECT
          qp_bi_view_name,
          ts,
          property_event_ts,
          view_id,
          meta_recordDate,
          meta_trackingId,
          context_id,
          context_viewNumber,
          context_sessionNumber,
          meta_serverTs,
          meta_ts,
          user_action.meta_type AS meta_type,
          user_action.type AS type,
          user_action.name AS name,
          user_action.user_interaction_type AS user_interaction_type,
          user_action.voucher_id AS voucher_id,
          user_action.voucher_label AS voucher_label,
          user_action.voucher_entry AS voucher_entry,
          user_action.voucher_entrySuccess AS voucher_entrySuccess
        FROM 
          `qubit-client-{{q_view_v01.project._parameter_value}}.{{q_view_v01.site._parameter_value}}__v2.livetap_user_action`
        LEFT JOIN
          unnest (user_action) as user_action
        WHERE
          {% condition q_view_v01.time_data_points_date  %} property_event_ts {% endcondition %}
        ;;
  }

  dimension: view_id {
    type: string
    sql: ${TABLE}.view_id ;;
    hidden: yes
    primary_key: yes
  }

  dimension: context_session_number {
    type: number
    sql: ${TABLE}.context_sessionNumber ;;
    label: "Session Number"
    group_label: "View Meta Data"
    description: "Session number of the visitor, in a lifetime. QP fields: context_sessionNumber"
  }

  dimension: context_view_number {
    type: number
    sql: ${TABLE}.context_viewNumber ;;
    label: "View Number"
    group_label: "View Meta Data"
    description: "View number of the visitor, in a lifetime. QP fields: context_viewNumber"
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}.context_id ;;
    label: "Visitor ID"
    group_label: "Visitor"
    description: "ID unique to the visitor, created in browser. QP fields: context_id"
  }

  dimension_group: time_data_points {
    label: ""
    type: time
    timeframes:  [time, hour_of_day, date, day_of_week, week, week_of_year, month, month_name, quarter_of_year, year]
    sql:  ${TABLE}.property_event_ts ;;
    group_label: "⏰ Date & Time"
    description: "Timestamp of the user action. QP fields: property_event_ts"
    hidden: yes
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
    label: "Subtype"
    description: "Action type. QP fields: type"
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    label: "Action Name"
    description: "Action name. QP fields: name"
  }

  dimension: meta_type {
    type: string
    sql: ${TABLE}.meta_type ;;
    label: "Action Meta Type"
    description: "Action meta type. QP fields: meta_type"
  }

  dimension: voucher_label {
    type: string
    sql: ${TABLE}.voucher_label ;;
    label: "Voucher Label"
    description: "Voucher Label"
  }

  dimension: user_interaction_type {
    type: string
    sql: ${TABLE}.user_interaction_type ;;
    label: "User Interaction Type"
    description: "User interaction type. QP fields: user_interaction_type"
  }

  measure: total_visitor_views {
    type: number
    sql: COUNT(DISTINCT ${TABLE}.view_id) ;;
    group_label: "Visitor"
    description: "Number of unique views. QP fields: context_viewNumber, context_id"
  }
}
