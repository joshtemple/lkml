view: content_pack_view_bridge {
  sql_table_name: public.content_pack_view_bridge ;;

  dimension: cp_key {
    type: number
    sql: ${TABLE}.cp_key ;;
  }

  dimension: cp_view_bridge_key {
    type: number
    sql: ${TABLE}.cp_view_bridge_key ;;
  }

  dimension: view_key {
    type: number
    sql: ${TABLE}.view_key ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
