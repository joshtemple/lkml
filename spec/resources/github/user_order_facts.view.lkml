include: "looker_training_maddie.model.lkml"

view: user_order_fact {

  derived_table: {
      explore_source: order_items1 {
        column: user_id {}
        column: lifetime_orders {field: order_items1.order_count}
        column: lifetime_revenue {field: order_items1.total_sale_price}
        column: first_order {}
        column: latest_order {}
        column: number_of_distinct_months_with_orders {field: order_items1.month_count}
      }
  }

  dimension: user_id {
    hidden: yes
    primary_key: yes
    sql:  ${TABLE}.user_id ;;
  }

  dimension_group: first_order_date {
    view_label: "Users"
    type: time
    timeframes: [date, month, week, year, raw]
    sql:  ${TABLE}.first_order_date ;;
  }

  dimension_group: last_order_date {
    view_label: "Users"
    type: time
    timeframes: [date, month, week, year, raw]
    sql:  ${TABLE}.last_order_date ;;
  }

  dimension: lifetime_orders {
    view_label: "Users"
    type: number
    sql:  ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    view_label: "Users"
    type: number
    sql:  ${TABLE}.lifetime_revenue ;;
  }

  dimension: days_as_customer {
    view_label: "Users"
    description: "Days between first and last order"
    sql: datediff('days', ${TABLE}.first_order_date, ${TABLE}.last_order_date);;
  }

  dimension: days_as_customer_tier {
    view_label: "Users"
    type: tier
    style: integer
    tiers: [0,1,7,14,21,28,29,30,60,90,120]
    sql: datediff('days', ${TABLE}.first_order_date, ${TABLE}.last_order_date);;
  }

  dimension: lifetime_orders_tier {
    view_label: "Users"
    type: tier
    style: integer
    tiers: [0,1,2,3,5,10]
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenues_tier {
    view_label: "Users"
    type: tier
    style: integer
    tiers: [0,25,50,100,200,500,1000]
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: repeat_customer {
    view_label: "Users"
    type: yesno
    sql: ${TABLE}.lifetime_orders > 1 ;;
  }

  dimension: distinct_months_with_orders {
    view_label: "Users"
    type: number
    sql: ${TABLE}.number_of_distinct_months_with_orders ;;
  }

  measure: average_lifetime_orders {
    view_label: "Users"
    type: average
    value_format: "0.00"
    sql: ${TABLE}.lifetime_orders ;;
  }

  measure: average_lifetime_revenue {
    view_label: "Users"
    type: average
    value_format: "\"£\"#,##0.00"
    sql: ${TABLE}.lifetime_revenue ;;
  }
}
