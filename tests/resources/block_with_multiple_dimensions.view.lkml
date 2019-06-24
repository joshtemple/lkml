view: view_name {
  sql_table_name: schema.table_name ;;

  dimension: a_dimension {
    type: string
    sql: ${TABLE}.a_dimension ;;
  }

  dimension: another_dimension {
    type: number
    sql: ${TABLE}.another_dimension ;;
  }

  dimension: yet_another_dimension {
    type: yesno
    sql: ${TABLE}.yet_another_dimension ;;
  }

  dimension_group: a_dimension_group {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.a_dimension_group ;;
  }
}
