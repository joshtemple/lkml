view: four_five_four {
  sql_table_name: moltin.`454` ;;

  dimension_group: day {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.day ;;
    view_label: "454"
  }

  dimension: date_text {
    type: string
    sql: ${day_date} ;;
    primary_key: yes
    hidden: yes
  }

  dimension: day_of_month {
    type: number
    sql: ${TABLE}.day_of_month ;;
    view_label: "454"
  }

  dimension: day_of_week {
    type: number
    sql: ${TABLE}.day_of_week ;;
    view_label: "454"
  }

  dimension: day_of_year {
    type: number
    sql: ${TABLE}.day_of_year ;;
    view_label: "454"
  }

  dimension: merge {
    type: string
    sql: ${TABLE}.``merge`` ;;
    view_label: "454"
  }

  dimension_group: month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month ;;
    view_label: "454"
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}.month_name ;;
    view_label: "454"
    hidden: yes
  }

  dimension: month_of_year {
    type: number
    sql: ${TABLE}.month_of_year ;;
    view_label: "454"
  }

  dimension: quarter {
    type: string
    sql: ${TABLE}.quarter ;;
    view_label: "454"
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    view_label: "454"
  }

  dimension_group: week {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.week ;;
    view_label: "454"
  }

  dimension: week_in_months {
    type: number
    sql: ${TABLE}.week_in_months ;;
    view_label: "454"
    hidden: yes
  }

  dimension: week_of_month {
    type: number
    sql: ${TABLE}.week_of_month ;;
    view_label: "454"
  }

  dimension: week_of_year {
    type: number
    sql: ${TABLE}.week_of_year ;;
    view_label: "454"
  }

  dimension: weekday {
    type: string
    sql: ${TABLE}.weekday ;;
    view_label: "454"
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
    view_label: "454"
  }

  measure: count {
    type: count
    drill_fields: [month_name]
    view_label: "454"
  }
}
