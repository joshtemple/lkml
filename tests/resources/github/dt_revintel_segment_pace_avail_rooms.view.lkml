view: dt_revintel_segment_pace_avail_rooms {
  derived_table: {
    sql:
      select
         property_key
        ,stay_date_sid              as date_sid
        ,max( cy_avail_room_cnt)    as dt_cy_avail_room_cnt
        ,max( stly_avail_room_cnt)  as dt_stly_avail_room_cnt
        ,max( ly_avail_room_cnt)    as dt_ly_avail_room_cnt
        ,max( fcst_avail_room_cnt)  as dt_fcst_avail_room_cnt
        ,max( bdgt_avail_room_cnt)  as dt_bdgt_avail_room_cnt
        --
        ,sum( cy_room_cnt )         as dt_cy_room_cnt
      from
        pedw.fact.revintel_property_segment_pace_f
      group by
         property_key
        ,stay_date_sid
      ;;
  }
  dimension: unique_identifier {
    type: number
    primary_key: yes
    sql: ${TABLE}.property_key || ${date_sid}  ;;
    hidden:  yes
  }
  dimension: property_key {
    sql: ${TABLE}.property_key ;;
    hidden: yes
  }
  dimension: date_sid {
    type:  number
    primary_key:  no
    sql: ${TABLE}.date_sid ;;
    hidden:  yes
  }
  measure: dt_cy_avail_room_cnt {
    type: sum
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Avail"
    description: "Rooms Available"
    sql: ${TABLE}.dt_cy_avail_room_cnt ;;
    hidden: no
  }
  measure: dt_stly_avail_room_cnt {
    type: sum
    value_format_name: decimal_0
    view_label: "  STLY"
    label: "Rms Avail"
    description: "Rooms Available"
    sql: ${TABLE}.dt_stly_avail_room_cnt ;;
    hidden: no
  }
  measure: dt_ly_avail_room_cnt {
    type: sum
    value_format_name: decimal_0
    view_label: "  LY"
    label: "Rms Avail"
    description: "Rooms Available"
    sql: ${TABLE}.dt_ly_avail_room_cnt ;;
    hidden: no
  }

  measure: dt_fcst_avail_room_cnt {
    type: sum
    value_format_name: decimal_0
    view_label: "  FCST"
    label: "Rms Avail"
    description: "Rooms Available"
    sql: ${TABLE}.dt_fcst_avail_room_cnt ;;
    hidden: no
  }

  measure: dt_bdgt_avail_room_cnt {
    type: sum
    value_format_name: decimal_0
    view_label: "  BDGT"
    label: "Rms Avail"
    description: "Rooms Available"
    sql: ${TABLE}.dt_bdgt_avail_room_cnt ;;
    hidden: no
  }

  #-- Compare to STLY and LY
  measure:  dt_cy_avail_rooms_var_perc{
    sql: utl..udf_percent_var((${dt_cy_avail_room_cnt}),(${dt_stly_avail_room_cnt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Avail Act:STLY - % var"
    description: "(TY - STLY)/STLY"
  }

  measure:  dt_cy_avail_rooms_var{
    sql: (${dt_cy_avail_room_cnt})-(${dt_stly_avail_room_cnt}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Avail Act:STLY - var"
    description: "(TY - STLY)"
  }
}
