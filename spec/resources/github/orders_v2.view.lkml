view: orders_v2 {
  view_label: "Orders"
  sql_table_name: moltin.orders_v2 ;;

  dimension: revenue_flag {
    type: yesno
    sql:${TABLE}.payment in ('paid','refunded') and (${TABLE}.discount_code not in ('SPPAhn00','SPPAHN00','CUST99EXP2018') or ${TABLE}.discount_code is null) ;;
    view_label: "Revenue"
  }

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    view_label: "Order Information"
  }

  dimension: affirm_charge_id_hidden {
    type: string
    sql: ${TABLE}.affirm_charge_id ;;
    hidden:  yes
  }

  dimension: affirm_payment {
    type:  yesno
    sql:  CASE WHEN ${affirm_charge_id_hidden} IS NOT NULL ;;
    view_label: "Customer"
  }

  dimension: bill_to_address_1 {
    type: string
    sql: ${TABLE}.bill_to_address_1 ;;
    hidden: yes
  }

  dimension: bill_to_address_2 {
    type: string
    sql: ${TABLE}.bill_to_address_2 ;;
    hidden: yes
  }

  dimension: bill_to_city {
    type: string
    sql: ${TABLE}.bill_to_city ;;
    hidden: yes
  }

  dimension: bill_to_company {
    type: string
    sql: ${TABLE}.bill_to_company ;;
    hidden: yes
  }

  dimension: bill_to_country_code {
    type: string
    sql: ${TABLE}.bill_to_country_code ;;
    hidden: yes
  }

  dimension: bill_to_county {
    type: string
    sql: ${TABLE}.bill_to_county ;;
    hidden: yes
  }

  dimension: bill_to_first_name {
    type: string
    sql: ${TABLE}.bill_to_first_name ;;
    hidden: yes
  }

  dimension: bill_to_last_name {
    type: string
    sql: ${TABLE}.bill_to_last_name ;;
    hidden: yes
  }

  dimension: bill_to_postcode {
    type: string
    sql: ${TABLE}.bill_to_postcode ;;
    hidden: yes
  }

  dimension: braintree_charge_id {
    type: string
    sql: ${TABLE}.braintree_charge_id ;;
    hidden: yes
  }

  dimension: courier_shipping {
    type: string
    sql: ${TABLE}.courier_shipping ;;
    hidden: yes
  }

  dimension_group: order {
    type: time
    convert_tz: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    view_label: "Order Information"
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.currency_code ;;
    hidden: yes
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customer_email ;;
    hidden: yes
  }

  dimension: customer_id {
    label: "Customer ID"
    type: string
    sql: ${TABLE}.customer_id ;;
    view_label: "Customer"
  }

  dimension_group: delivery {
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
    sql: ${TABLE}.delivery_date ;;
    view_label: "Shipping"
  }

  dimension: discount_amount_value_hidden {
    type: number
    sql: ${TABLE}.discount_amount_value / 100;;
    hidden: yes
    }

  measure: discount_amount_value {
    type: sum
    sql: ${discount_amount_value_hidden} ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  dimension: discount_code {
    type: string
    sql: ${TABLE}.discount_code ;;
    view_label: "Revenue"
  }

  dimension: inventory_estimate {
    type: string
    sql: ${TABLE}.inventory_estimate ;;
    hidden: yes
  }

  dimension: items {
    hidden: yes
    sql: ${TABLE}.items ;;
  }

  dimension_group: klaussner_est_delivery {
  label: "Klaussner Estimated Delivery"
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
    sql: ${TABLE}.klaussner_est_delivery_date ;;
    view_label: "Shipping"
  }

  dimension: klaussner_fulfillment_id {
    type: string
    sql: ${TABLE}.klaussner_fulfillment_id ;;
    hidden: yes
  }

  dimension: klaussner_tracking_code {
    type: string
    sql: ${TABLE}.klaussner_tracking_code ;;
    hidden: yes
  }

  dimension: order_cancelled {
    type: string
    sql: ${TABLE}.order_cancelled ;;
    hidden: yes
  }

  dimension: order_issue {
    type: string
    sql: ${TABLE}.order_issue ;;
    hidden: yes
  }

  dimension: partial_refund_amount_value_hidden {
    type: number
    sql: ${TABLE}.partial_refund_amount_value / 100 ;;
    hidden: yes
  }

  measure: partial_refund_amount {
    type: sum
    sql: ${partial_refund_amount_value_hidden} ;;
    value_format_name: usd_0
    view_label: "Returns & Refunds"
  }

  dimension: partial_refund_reason {
    type: string
    sql: ${TABLE}.partial_refund_reason ;;
    view_label: "Returns & Refunds"
  }

  dimension: payment_status {
    type: string
    sql: ${TABLE}.payment ;;
    view_label: "Revenue"
  }

  dimension: payment_id {
    type: string
    sql: ${TABLE}.payment_id ;;
    hidden: yes
  }

  dimension_group: return {
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
    sql: ${TABLE}.return_date ;;
    view_label: "Returns & Refunds"
  }

  dimension: return_reason {
    type: string
    sql: ${TABLE}.return_reason ;;
    view_label: "Returns & Refunds"
  }

  dimension: return_reason_desc {
    type: string
    sql: ${TABLE}.return_reason_desc ;;
    hidden: yes
  }

  dimension_group: ship {
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
    sql: ${TABLE}.ship_date ;;
    view_label: "Shipping"
    hidden: yes
  }

  dimension: ship_to_address_1 {
    type: string
    sql: ${TABLE}.ship_to_address_1 ;;
    hidden: yes
  }

  dimension: ship_to_address_2 {
    type: string
    sql: ${TABLE}.ship_to_address_2 ;;
    hidden: yes
  }

  dimension: ship_to_city {
    label: "City"
    type: string
    sql: ${TABLE}.ship_to_city ;;
    view_label: "Customer"
  }

  dimension: ship_to_company {
    label: "Company"
    type: string
    sql: ${TABLE}.ship_to_company ;;
    view_label: "Customer"
  }

  dimension: ship_to_country_code {
    label: "Country"
    type: string
    sql: ${TABLE}.ship_to_country_code ;;
    view_label: "Customer"
    map_layer_name: countries
  }

  dimension: ship_to_county {
    label: "State"
    type: string
    sql: ${TABLE}.ship_to_county ;;
    view_label: "Customer"
    map_layer_name: us_states
  }

  dimension: ship_to_first_name {
    type: string
    sql: ${TABLE}.ship_to_first_name ;;
    hidden: yes
  }

  dimension: ship_to_last_name {
    type: string
    sql: ${TABLE}.ship_to_last_name ;;
    hidden: yes
  }

  dimension: ship_to_phone {
    type: string
    sql: ${TABLE}.ship_to_phone ;;
    hidden: yes
  }

  dimension: ship_to_postcode {
    label: "Zip Code"
    type: string
    sql: ${TABLE}.ship_to_postcode ;;
    view_label: "Customer"
    map_layer_name: us_zipcode_tabulation_areas
  }

  dimension_group: shipbob_est_delivery {
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
    sql: ${TABLE}.shipbob_est_delivery_date ;;
    hidden: yes
  }

  dimension: shipbob_fulfillment_id {
    type: string
    sql: ${TABLE}.shipbob_fulfillment_id ;;
    hidden: yes
  }

  dimension: shipbob_tracking_code {
    type: string
    sql: ${TABLE}.shipbob_tracking_code ;;
    hidden: yes
  }

  dimension: shipping {
    label: "Fulfillment Status"
    type: string
    sql: ${TABLE}.shipping ;;
    view_label: "Shipping"
  }

  dimension_group: shipping {
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
    sql: CASE WHEN ${TABLE}.ship_date IS NOT NULL AND ${TABLE}.shipping_date IS NULL THEN ${TABLE}.ship_date WHEN ${TABLE}.shipping_date IS NOT NULL AND ${TABLE}.ship_date IS NULL THEN ${TABLE}.shipping_date ELSE END;;
    view_label: "Shipping"
  }

  dimension: shipping_order {
    type: string
    sql: ${TABLE}.shipping_order ;;
    hidden: yes
  }

  dimension: signature {
    type: yesno
    sql: ${TABLE}.signature ;;
    hidden: yes
  }

  dimension: status_value {
    label: "Order Status"
    type: string
    sql: ${TABLE}.status_value ;;
    view_label: "Order Information"
  }

  dimension: stitchlabs_id {
    type: string
    sql: ${TABLE}.stitchlabs_id ;;
    hidden: yes
  }

  dimension: subtotal_hidden {
    type: number
    sql: ${TABLE}.subtotal/100 ;;
    hidden: yes
  }

  measure: subtotal {
    type: sum
    sql: ${subtotal_hidden} ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  dimension: taxes_collected_value_hidden {
    type: number
    sql: ${TABLE}.taxes_collected_value/100 ;;
    hidden: yes
  }

  measure: taxes_collected_value {
    type: sum
    sql: ${taxes_collected_value_hidden} ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  dimension: text_updates {
    type: string
    sql: ${TABLE}.text_updates ;;
    hidden: yes
  }

  dimension: total_hidden {
    type: number
    sql: ${TABLE}.total / 100 ;;
    hidden: yes
  }

  measure: total {
    type: sum
    sql: ${total_hidden} ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  dimension: totals_raw_subtotal_hidden {
    type: number
    sql: ${TABLE}.totals_raw_subtotal/100 ;;
    hidden: yes
  }

  measure: totals_raw_subtotal {
    type: sum
    sql: ${totals_raw_subtotal_hidden} ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  dimension: totals_raw_tax_hidden {
    type: number
    sql: ${TABLE}.totals_raw_tax / 100;;
    hidden: yes
  }

  measure: totals_raw_tax {
    type: sum
    sql: ${totals_raw_tax_hidden} ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  dimension: totals_raw_total_hidden {
    type: number
    sql: ${TABLE}.totals_raw_total / 100;;
    hidden: yes
  }

  measure: totals_raw_total {
    type: sum
    sql: ${totals_raw_total_hidden} ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  measure: gross_revenue {
    type: number
    sql: (${totals_raw_total}-ifnull(${taxes_collected_value},0)-ifnull(${discount_amount_value},0)) ;;
    value_format_name: usd_0
    view_label: "Revenue"
  }

  dimension_group: order_update {
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
    sql: ${TABLE}.updated_at ;;
    view_label: "Order Information"
    }

  measure: count_orders {
  label: "Count"
  type: count
  view_label: "Order Information"
  }

  measure: count_customers {
    label: "Count"
    type: count
    view_label: "Customer"
  }

  measure: count_returns {
    label: "Count"
    type: count
    view_label: "Returns & Refunds"
  }

  measure: count_revenue {
    label: "Count"
    type: count
    view_label: "Revenue"
  }

  measure: count_shipping {
    label: "Count"
    type: count
    view_label: "Shipping"
  }

  measure: count_sku {
    label: "Count"
    type: count
    view_label: "SKU"
  }

}

view: orders_v2_items {
  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
    hidden: yes
  }
  }
