view: m_data_view_javascript {
  sql_table_name: dbo.M_DATA_VIEW_JAVASCRIPT ;;

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

  dimension: data_view_javascript_function_name {
    type: string
    sql: ${TABLE}.DATA_VIEW_JAVASCRIPT_FUNCTION_NAME ;;
  }

  dimension: data_view_javascript_id {
    type: number
    sql: ${TABLE}.DATA_VIEW_JAVASCRIPT_ID ;;
  }

  dimension: data_view_javascript_query {
    type: string
    sql: ${TABLE}.DATA_VIEW_JAVASCRIPT_QUERY ;;
  }

  dimension: data_view_javascript_query_parameters {
    type: string
    sql: ${TABLE}.DATA_VIEW_JAVASCRIPT_QUERY_PARAMETERS ;;
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
    drill_fields: [data_view_javascript_function_name]
  }
}
