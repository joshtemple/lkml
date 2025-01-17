view: user_facts {
  derived_table: {
    sql:select o.user_id, count(distinct oi.order_id) as lifetime_orders, count(distinct oi.id) as lifetime_items, min(o.created_at) as first_order, max(o.created_at) as last_order, coalesce(sum(
case when (oi.returned_at is null) then (oi.sale_price-ii.cost) else 0 end),0) as lifetime_proft, coalesce(sum(
case when (oi.returned_at is null) then (oi.sale_price) else 0 end),0)  AS  lifetime_revenue
      from users u
      left join orders o
      on o.user_id=u.id
      left join order_items oi
      on oi.order_id = o.id
      left join inventory_items ii
      on ii.id = oi.inventory_item_id
      group by 1;
 ;;
  }

  dimension: order_tiers {
    view_label: "Users"
    type: tier
    tiers: [0,1,3,4]
    sql: ${lifetime_orders} ;;
    style: integer
  }


  dimension: user_id {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}.user_id ;;
  }
  dimension: lifetime_items  {
    view_label: "Users"
    type: number
    sql: ${TABLE}.lifetime_items ;;
    description: "Total number of items a user has purchased since becoming a user"
  }
  dimension: lifetime_revenue {
    view_label: "Users"
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
    value_format: "$0.00"
    description: "Total amount of money a user has spent since becoming a user"
  }

  dimension: lifetime_orders {
    view_label: "Users"
    type: number
    sql: ${TABLE}.lifetime_orders ;;
    description: "Total number of orders a user has placed"
  }

  dimension_group: first_order {
    view_label: "Users"
    type: time
    sql: ${TABLE}.first_order ;;
    description: "The first date a user placed an order"
  }

  dimension_group: last_order {
    view_label: "Users"
    type: time
    sql: ${TABLE}.last_order ;;
    description: "The last date a user placed an order"
  }

  dimension: lifetime_proft {
    view_label: "Users"
    type: number
    sql: ${TABLE}.lifetime_proft ;;
    value_format: "$0.00"
  }

measure: average_lifetime_orders {
  view_label: "Users"
  type: average
  sql: ${lifetime_orders} ;;
  drill_fields: [order_detail*]
}

measure:  average_lifetime_items{
  view_label: "Users"
  type: average
  sql: ${lifetime_items} ;;
  drill_fields: [order_detail*]
}

measure: average_lifetime_profit {
  view_label: "Users"
  type: average
  sql: ${lifetime_proft};;
  drill_fields: [lifetime_detail*]
  value_format_name: usd_0
}


  set: lifetime_detail {
    fields: [user_id, lifetime_orders, first_order_time, last_order_time, lifetime_proft]
  }

  set: order_detail {
    fields: [user_id, users.full_name, orders.count, order_items.count]
  }
}
