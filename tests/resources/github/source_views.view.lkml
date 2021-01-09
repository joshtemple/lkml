view: source_views {
  sql_table_name: data_5b477838c366d.source_views ;;

  dimension: config {
    type: string
    sql: ${TABLE}.config ;;
  }

  dimension: converted {
    type: string
    sql: ${TABLE}.converted ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: source_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.source_id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: view_id {
    type: number
    sql: ${TABLE}.view_id ;;
  }

  dimension: view_info {
    type: string
    sql: ${TABLE}.view_info ;;
  }

  dimension: view_name {
    type: string
    sql: ${TABLE}.view_name ;;
  }

  measure: count {
    type: count
    drill_fields: [view_name, sources.source_id, sources.source_name]
  }
}
