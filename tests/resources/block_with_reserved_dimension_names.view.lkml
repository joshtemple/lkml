view: view_name {
  sql: select ${orders.items}, "Some SQL" as thing, 'Some Quoted Literal' from TABLE ;;
  dimension: sql {}
  dimension: sql_table_name {}
  dimension: sql_dimension_name {}
  dimension: html {}
  dimension: html_dimension_name {}
  dimension: expression_custom_filter {}
  dimension: expression_custom_filter {}
}
