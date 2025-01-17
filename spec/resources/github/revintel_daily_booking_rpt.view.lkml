view: revintel_daily_booking_rpt {
  sql_table_name: pedw.fact.revintel_daily_booking_rpt ;;

  #
  # measures
  #
  measure: cy_rooms_sold_no {
    label: "Rooms Sold"
    view_label: "1) Measures"
    group_label:"Current Year (CY)"
    description: "Rooms Sold"
    type: sum
    sql: ${TABLE}.cy_rooms_sold_no ;;
    value_format_name: decimal_0
  }

  measure: cy_rooms_rev_amt {
    label: "Rooms Rev$"
    view_label: "1) Measures"
    group_label:"Current Year (CY)"
    description: "Rooms Revenue $"
    type: sum
    sql: ${TABLE}.cy_rooms_rev_amt ;;
    value_format_name: usd_0
  }

  measure: cy_avg_daily_rate {
    label: "ADR"
    view_label: "1) Measures"
    group_label:"Current Year (CY)"
    description: "Rooms Rev$ / Rooms Sold"
    type: number
    sql: ${cy_rooms_rev_amt} / nullif( ${cy_rooms_sold_no}, 0 ) ;;
    value_format_name: usd
  }

  measure: py_rooms_sold_no {
    label: "LY Rooms Sold"
    view_label: "1) Measures"
    group_label: "Last Year (LY)"
    description: "Last Year Rooms Sold"
    type: sum
    sql: ${TABLE}.py_rooms_sold_no ;;
    value_format_name: decimal_0
  }

  measure: py_rooms_rev_amt {
    label: "LY Rooms Rev$"
    view_label: "1) Measures"
    group_label: "Last Year (LY)"
    description: "Last Year Rooms Revenue $"
    type: sum
    sql: ${TABLE}.py_rooms_rev_amt ;;
    value_format_name: usd_0
  }

  measure: py_avg_daily_rate {
    label: "LY ADR"
    view_label: "1) Measures"
    group_label: "Last Year (LY)"
    description: "LY Rooms Rev$ / LY Rooms Sold"
    type: number
    sql: ${py_rooms_rev_amt} / nullif( ${py_rooms_sold_no}, 0 ) ;;
    value_format_name: usd
  }

  # cy to py
  #
  measure: cy_rooms_sold_no_pypvar {
    label: "Rooms Sold (% Var)"
    group_label: "Variance to LY"
    description: "(Rooms Sold / LY Rooms Sold) - 1"
    type: number
    sql: ( ${cy_rooms_sold_no} / nullif( ${py_rooms_sold_no}, 0 ) ) - 1 ;;
    value_format_name: percent_1
    html:
      {% if value < 0 %}
      <font color="red">{{ rendered_value }}</font>
      {% endif %};;
  }

  measure: cy_rooms_sold_no_pynvar {
    label: "Rooms Sold (Var)"
    group_label: "Variance to LY"
    description: "Rooms Sold - LY Rooms Sold"
    type: number
    sql: ${cy_rooms_sold_no} - ${py_rooms_sold_no}  ;;
    value_format_name: decimal_0
    html:
      {% if value < 0 %}
      <font color="red">{{ rendered_value }}</font>
      {% endif %};;
  }

  measure: cy_rooms_rev_amt_pypvar {
    label: "Rooms Rev$ (% Var)"
    group_label: "Variance to LY"
    description: "(Rooms Rev$ / LY Rooms Rev$) - 1"
    type: number
    sql: ( ${cy_rooms_rev_amt} / nullif( ${py_rooms_rev_amt}, 0 ) ) - 1 ;;
    value_format_name: percent_1
    html:
      {% if value < 0 %}
      <font color="red">{{ rendered_value }}</font>
      {% endif %};;
  }

  measure: cy_rooms_rev_amt_pynvar {
    label: "Rooms Rev$ (Var)"
    group_label: "Variance to LY"
    description: "Rooms Rev$ - LY Rooms Rev$"
    type: number
    sql: ${cy_rooms_rev_amt} - ${py_rooms_rev_amt}  ;;
    value_format_name: usd_0
    html:
      {% if value < 0 %}
      <font color="red">{{ rendered_value }}</font>
      {% endif %};;
  }

  measure: cy_avg_daily_rate_pypvar {
    label: "ADR (%Var)"
    group_label: "Variance to LY"
    description: "(ADR / LY ADR) - 1"
    type: number
    sql: ${cy_avg_daily_rate} / nullif( ${py_avg_daily_rate}, 0 ) - 1 ;;
    value_format_name: percent_1
    html:
      {% if value < 0 %}
      <font color="red">{{ rendered_value }}</font>
      {% endif %};;
  }

  measure: cy_avg_daily_rate_pynvar {
    label: "ADR (Var)"
    group_label: "Variance to LY"
    description: "ADR - LY ADR"
    type: number
    sql: ${cy_avg_daily_rate} - ${py_avg_daily_rate}  ;;
    value_format_name: usd
    html:
      {% if value < 0 %}
      <font color="red">{{ rendered_value }}</font>
      {% endif %};;
  }

  # % previous
  #
  measure: cy_rooms_sold_no_prev {
    label: "Rooms Sold"
    description: "Rooms Sold"
    view_label: "1b) % Previous"
    type: percent_of_previous
    sql: ${cy_rooms_sold_no} ;;
    value_format: "0.0\%"
  }

  measure: cy_rooms_rev_amt_prev {
    label: "Rooms Rev$"
    description: "Rooms Rev$"
    view_label: "1b) % Previous"
    type: percent_of_previous
    sql: ${cy_rooms_rev_amt} ;;
    value_format: "0.0\%"
  }

  # % total
  #
  measure: cy_rooms_sold_no_pttl {
    label: "Rooms Sold"
    description: "Rooms Sold"
    view_label: "1c) % Total"
    type: percent_of_total
    sql: ${cy_rooms_sold_no} ;;
    value_format: "0.0\%"
  }

  measure: cy_rooms_rev_amt_pttl {
    label: "Rooms Rev$"
    description: "Rooms Revenue $"
    view_label: "1c) % Total"
    type: percent_of_total
    sql: ${cy_rooms_sold_no} ;;
    value_format: "0.0\%"
  }

  #
  # dimensions
  #

  dimension_group: stay {
    view_label: "2) Stay Date"
    type: time
    timeframes: [
      raw
      ,date
      ,week
      ,day_of_week
      ,day_of_week_index
      ,month
      ,month_num
      ,month_name
      ,day_of_month
      ,quarter
      ,quarter_of_year
      ,year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.stay_dt ;;
  }

  dimension: hotel_cd {
    label: "Hotel Code"
    view_label: "Room"
    type: string
    sql: ${TABLE}.hotel_cd ;;
    drill_fields: [room_ds*]
  }

  dimension: hotel_name {
    label: "Hotel Name"
    view_label: "Room"
    type: string
    sql: ${TABLE}.hotel_name ;;
    drill_fields: [room_ds*]
  }

  dimension: major_channel_name {
    label: "Major Channel"
    view_label: "Room"
    type: string
    sql: ${TABLE}.major_channel_name ;;
    drill_fields: [room_ds*]
  }

  dimension: major_market_name {
    label: "Major Market"
    view_label: "Room"
    type: string
    sql: ${TABLE}.major_market_name ;;
    drill_fields: [room_ds*]
  }

  dimension: minor_market_name {
    label: "Minor Market"
    view_label: "Room"
    type: string
    sql: ${TABLE}.minor_market_name ;;
    drill_fields: [room_ds*]
  }

  dimension: rate_cd {
    label: "Rate Code"
    view_label: "Room"
    type: string
    sql: ${TABLE}.rate_cd ;;
    drill_fields: [room_ds*]
  }

  dimension: rate_code_name {
    label: "Rate Name"
    view_label: "Room"
    type: string
    sql: ${TABLE}.rate_code_name ;;
    drill_fields: [room_ds*]
  }

  dimension: major_room_product_name {
    label: "Major Room Product"
    view_label: "Room"
    type: string
    sql: ${TABLE}.major_room_product_name ;;
    drill_fields: [room_ds*]
  }

  dimension: minor_room_product_name {
    label: "Minor Room Product"
    view_label: "Room"
    type: string
    sql: ${TABLE}.minor_room_product_name ;;
    drill_fields: [room_ds*]
  }

  dimension: room_type_name {
    label: "Room Type"
    view_label: "Room"
    type: string
    sql: ${TABLE}.room_type_name ;;
    drill_fields: [room_ds*]
  }

  dimension: business_unit_name {
    label: "Business Unit"
    view_label: "Room"
    type: string
    sql: ${TABLE}.business_unit_name ;;
    drill_fields: [room_ds*]
  }

  # ----- Sets of fields for drilling ------
  set: room_ds {
    fields: [
      business_unit_name
      ,hotel_cd
      ,hotel_name
      ,major_channel_name
      ,major_market_name
      ,minor_market_name
      ,major_room_product_name
      ,minor_room_product_name
      ,room_type_name
      ,rate_cd
      ,rate_code_name
    ]
  }

}
