view: m_data_view {
  sql_table_name: dbo.M_DATA_VIEW ;;

  dimension: active_flg {
    type: number
    sql: ${TABLE}.ACTIVE_FLG ;;
  }

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

  dimension: data_view_author_email {
    type: string
    sql: ${TABLE}.DATA_VIEW_AUTHOR_EMAIL ;;
  }

  dimension: data_view_author_name {
    type: string
    sql: ${TABLE}.DATA_VIEW_AUTHOR_NAME ;;
  }

  dimension: data_view_category {
    type: string
    sql: ${TABLE}.DATA_VIEW_CATEGORY ;;
  }

  dimension: data_view_description {
    type: string
    sql: ${TABLE}.DATA_VIEW_DESCRIPTION ;;
  }

  dimension: data_view_host_id {
    type: number
    sql: ${TABLE}.DATA_VIEW_HOST_ID ;;
  }

  dimension: data_view_id {
    type: number
    sql: ${TABLE}.DATA_VIEW_ID ;;
  }

  dimension: data_view_permission {
    type: string
    sql: ${TABLE}.DATA_VIEW_PERMISSION ;;
  }

  dimension: data_view_title {
    type: string
    sql: ${TABLE}.DATA_VIEW_TITLE ;;
  }

  dimension: data_view_type {
    type: string
    sql: ${TABLE}.DATA_VIEW_TYPE ;;
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
    drill_fields: [data_view_author_name]
  }
}
