view: m_data_view_iframe {
  sql_table_name: dbo.M_DATA_VIEW_IFRAME ;;

  dimension: client_id {
    type: number
    sql: ${TABLE}.CLIENT_ID ;;
  }

  dimension_group: create_dt {
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
    sql: ${TABLE}.CREATE_DT ;;
  }

  dimension: create_user {
    type: string
    sql: ${TABLE}.CREATE_USER ;;
  }

  dimension: data_view_id {
    type: number
    sql: ${TABLE}.DATA_VIEW_ID ;;
  }

  dimension: data_view_iframe_display_height {
    type: string
    sql: ${TABLE}.DATA_VIEW_IFRAME_DISPLAY_HEIGHT ;;
  }

  dimension: data_view_iframe_id {
    type: number
    sql: ${TABLE}.DATA_VIEW_IFRAME_ID ;;
  }

  dimension: data_view_iframe_url {
    type: string
    sql: ${TABLE}.DATA_VIEW_IFRAME_URL ;;
  }

  dimension_group: update_dt {
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
    sql: ${TABLE}.UPDATE_DT ;;
  }

  dimension: update_user {
    type: string
    sql: ${TABLE}.UPDATE_USER ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
