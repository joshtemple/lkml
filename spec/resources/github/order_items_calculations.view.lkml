include: "/views/auto_generated/order_items.view"
view: +order_items {
  view_label: "ORDER ITEMS - STANDARD CALCULATIONS - PRE UI"
  #This version automatically exposes fields, if you regenerate the base table lookml, new fields will show up under this view label.

## copied 5/14 for reference {
  # sql_table_name: "PUBLIC"."ORDER_ITEMS";;
  # drill_fields: [id]

  # dimension: id {
  #   primary_key: yes
  #   type: number
  #   sql: ${TABLE}."ID" ;;
  # }

  # dimension_group: created {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}."CREATED_AT" ;;
  # }

  # dimension_group: delivered {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}."DELIVERED_AT" ;;
  # }

  # dimension: inventory_item_id {
  #   type: number
  #   # hidden: yes
  #   sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  # }

  # dimension: order_id {
  #   type: number
  #   sql: ${TABLE}."ORDER_ID" ;;
  # }

  # dimension_group: returned {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}."RETURNED_AT" ;;
  # }

  # dimension: sale_price {
  #   type: number
  #   sql: ${TABLE}."SALE_PRICE" ;;
  # }

  # dimension_group: shipped {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}."SHIPPED_AT" ;;
  # }

  # dimension: status {
  #   type: string
  #   sql: ${TABLE}."STATUS" ;;
  # }

  # dimension: user_id {
  #   type: number
  #   # hidden: yes
  #   sql: ${TABLE}."USER_ID" ;;
  # }

  # measure: count {
  #   type: count
  #   drill_fields: [detail*]
  # }

  # # ----- Sets of fields for drilling ------
  # set: detail {
  #   fields: [
  #     id,
  #     users.first_name,
  #     users.id,
  #     users.last_name,
  #     inventory_items.id,
  #     inventory_items.product_name
  #   ]
  # }
## } end copied 5/14 for reference

#overrides
  dimension: id {primary_key:no}

# primary key and count adjustment
  dimension: primary_key {
    primary_key:yes
    sql:${id};;
  }
  measure: count {
    type: count
    filters: [primary_key: "-NULL"]
  }


#calculated fields using only fields within this view
  dimension: is_active {
    type: yesno
    sql: ${status} in ('Shipped','Processing');;
  }

  dimension_group: created_to_delivered {
    type: duration
    intervals: [day,week]
    sql_start: ${created_raw} ;;
    sql_end: ${delivered_raw} ;;
  }
  dimension: sale_price_tier {
    type: tier
    tiers: [10,20,50,100]
    sql: ${sale_price} ;;
  }

#new measures
  measure: order_count {
    type: count_distinct
    sql: ${order_id} ;;
  }
  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }
}

#Standard UI Overrides
view: +order_items {
  view_label: "Order Items (Standard)"
  # drill_fields: [id]
  dimension: id {hidden: yes}
  dimension: primary_key {hidden:yes}
  dimension: inventory_item_id {hidden:yes}
  dimension: order_id {hidden:yes}
  dimension: user_id {hidden:yes}


  dimension_group: created {view_label:"Order_Item_dates"}
  dimension_group: delivered {view_label:"Order_Item_dates"}
  dimension_group: returned {view_label:"Order_Item_dates"}
  dimension_group: shipped {view_label:"Order_Item_dates"}
  dimension_group: created_to_delivered {view_label:"Order_Item_dates"}

  dimension: is_active {}
  dimension: sale_price_tier {}
  dimension: sale_price {}
  dimension: status {}

  measure: order_count {}
  measure: count {label: "Count Order Items"}


  # # ----- Sets of fields for drilling ------
  # set: detail {
  #   fields: [
  #     id,
  #     users.first_name,
  #     users.id,
  #     users.last_name,
  #     inventory_items.id,
  #     inventory_items.product_name
  #   ]
  # }


}
