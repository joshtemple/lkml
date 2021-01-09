view: users {
  sql_table_name: website.users_view ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: context_library_name {
    type: string
    sql: ${TABLE}.context_library_name ;;
  }

  dimension: context_library_version {
    type: string
    sql: ${TABLE}.context_library_version ;;
  }

  dimension_group: loaded {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.loaded_at ;;
  }

  dimension: plan {
    type: string
    sql: ${TABLE}.plan ;;
  }

  dimension_group: received {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at ;;
  }

  dimension_group: uuid_ts {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.uuid_ts ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      context_library_name,
      identifies.count,
      identifies_view.count,
      pages.count,
      pages_view.count,
      signup.count,
      signup_view.count,
      tracks.count,
      tracks_view.count,
      viewed_product.count,
      viewed_product_view.count
    ]
  }
}
