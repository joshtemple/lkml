view: revintel_property_segment_pace_f {
  sql_table_name: pedw.fact.revintel_property_segment_pace_f  ;;

  #-------------------------------------------------------------------------------------------
  #-- Keys
  #-------------------------------------------------------------------------------------------

  dimension: property_key {
    primary_key: yes
    sql: ${TABLE}.property_key ;;
    hidden: yes
  }

  dimension: stay_date_sid {
    sql: ${TABLE}.stay_date_sid ;;
    hidden: yes
  }

  dimension: asof_date_sid {
    sql: ${TABLE}.asof_date_sid ;;
    hidden: yes
  }

  #-------------------------------------------------------------------------------------------
  #-- Dimensions
  #-------------------------------------------------------------------------------------------

  dimension:major_market_nm_sort_no {
    sql: case
          when ${TABLE}.major_market_name = 'Transient'            then 1
          when ${TABLE}.major_market_name = 'Group'                then 2
          when ${TABLE}.major_market_name = 'Contract'             then 3
          when ${TABLE}.major_market_name = 'Complimentary'        then 4
          when ${TABLE}.major_market_name = 'Historical'           then 5
          when ${TABLE}.major_market_name = 'No Rate'              then 6
          when ${TABLE}.major_market_name = 'Unknown'              then 7
        else 9999
      end ;;
    view_label: "Reservation Detail"
    label: "Major Market Segment Sort No"
    description: "Major Market Segment Sort Number"
    type: number
  }

  dimension: minor_market_nm_sort_no {
    sql: case
          when ${TABLE}.minor_market_name = 'Retail'               then 1
          when ${TABLE}.minor_market_name = 'Net Retail'           then 2
          when ${TABLE}.minor_market_name = 'Qualified Discounts'  then 3
          when ${TABLE}.minor_market_name = 'Government'           then 4
          when ${TABLE}.minor_market_name = 'Packages'             then 5
          when ${TABLE}.minor_market_name = 'Promotions'           then 6
          when ${TABLE}.minor_market_name = 'Opaque'               then 7
          when ${TABLE}.minor_market_name = 'Corporate Negotiated' then 8
          when ${TABLE}.minor_market_name = 'Consortia'            then 9
          when ${TABLE}.minor_market_name = 'Wholesale'            then 10
          when ${TABLE}.minor_market_name = 'Group Entertainment'  then 11
          when ${TABLE}.minor_market_name = 'Group Corporate'      then 12
          when ${TABLE}.minor_market_name = 'Group Citywide'       then 13
          when ${TABLE}.minor_market_name = 'Group Association'    then 14
          when ${TABLE}.minor_market_name = 'Group Government'     then 15
          when ${TABLE}.minor_market_name = 'Group SMERF'          then 16
          when ${TABLE}.minor_market_name = 'Group Tour/Wholesale' then 17
        else 9999
      end ;;
    view_label: "Reservation Detail"
    label: "Minor Market Segment Sort No"
    description: "Minor Market Segment Sort Number"
    type: number
  }

  dimension: major_market_nm {
    sql: ${TABLE}.major_market_name ;;
    view_label: "Reservation Detail"
    label: "Major Market Segment"
    description: "Major Market Segment Name"
    type: string
    order_by_field: major_market_nm_sort_no
  }

  dimension: minor_market_nm {
    sql: ${TABLE}.minor_market_name ;;
    view_label: "Reservation Detail"
    label: "Minor Market Segment"
    description: "Minor Market Segment Name"
    type: string
    order_by_field: minor_market_nm_sort_no
  }


  ##

  dimension: cy_record_fl {
    sql: iff( ${TABLE}.cy_rooms + ${TABLE}.cy_room_rev != 0, 1, 0 ) = 1;;
    view_label: "Reservation Detail"
    label: "CY Record"
    description: "CY Rms Bkd and Rev Rms != 0"
    type: yesno
  }

  #-------------------------------------------------------------------------------------------
  #-- Measures - Reservation Detail Stats
  #-------------------------------------------------------------------------------------------


  #-------------------------------------------------------------------------------------------
  #-- Measures
  #-------------------------------------------------------------------------------------------

  measure: cy_sp {
    view_label: "   CY"
    label: "     CY  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure: room_sp {
    view_label: "   CY"
    label: "Rms Bkd  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure:  cy_rooms{
    sql: ${TABLE}.cy_room_cnt ;;
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd"
    description: "Room Booked"
    type: sum
  }

  measure: room_rev_sp {
    view_label: "   CY"
    label: "Rev Rms  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure:  cy_room_rev{
    sql: ${TABLE}.cy_room_rev_amt ;;
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Rms $"
    description: "Room Revenue"
    type: sum
  }

  measure:  cy_food_rev{
    sql: ${TABLE}.cy_food_rev_amt ;;
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Food $"
    description: "Food Revenue"
    type: sum
  }

  measure:  cy_other_rev{
    sql: ${TABLE}.cy_other_rev_amt ;;
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Other $"
    description: "Other Revenue"
    type: sum
  }

  measure:  cy_ttl_rev{
    sql: ${TABLE}.cy_room_rev_amt + ${TABLE}.cy_food_rev_amt + ${TABLE}.cy_other_rev_amt ;;
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev $"
    description: "Room Rev + Food Rev + Other Rev"
    type: sum
  }

  measure: adr_sp {
    view_label: "   CY"
    label: " ADR  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure:  cy_room_adr{
    sql: utl..udf_divide(${cy_room_rev},${cy_rooms}) ;;
    type: number
    value_format_name: usd
    view_label: "   CY"
    label: "ADR"
    description: "Average Daily Rate"
  }

  measure: cy_room_ttl_perc {
    view_label: "   CY"
    label: "Rms Bkd - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${cy_rooms} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure: cy_rev_ttl_perc {
    view_label: "   CY"
    label: "Rev Rms $ - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${cy_room_rev} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure: cy_adr_ttl_perc {
    view_label: "   CY"
    label: "ADR - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: utl..udf_divide(${cy_room_rev},${cy_rooms}) ;;
    hidden: no
  }

  measure:  cy_rooms_bkd_pct{
    sql: utl..udf_divide(${cy_rooms}, ${dt_revintel_segment_pace_avail_rooms.dt_cy_avail_room_cnt}) ;;
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd %"
    description: "Rooms Booked / Rooms Available"
    type: number
  }

  measure:  cy_rev_par{
    sql: utl..udf_divide(${cy_room_rev}, ${dt_revintel_segment_pace_avail_rooms.dt_cy_avail_room_cnt}) ;;
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev PAR $"
    description: "Revenue per Available Room Amount"
    type: number
  }

  #measure:  cy_rooms_prior_day {
  #  sql: ${TABLE}.cy_room_cnt_prior_day ;;
  #  value_format_name: decimal_0
  #  view_label: "   CY"
  #  label: "Rms Bkd Prior Day"
  #  description: "Rms OTB in Prior Day"
  #  type: sum
  #}

  #measure:  cy_rooms_prior_day_var {
  #  sql: ${TABLE}.cy_room_cnt - ${TABLE}.cy_room_cnt_prior_day ;;
  #  value_format_name: decimal_0
  #  view_label: "   CY"
  #  label: "Rms Bkd Act:Prior Day"
  #  description: "Rms Bkd - Prior Day"
  #  type: sum
  #  html:
  #  {% if value < 0 %}
  #  <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
  #  {% endif %};;
  #}

  #measure:  cy_rooms_prior_7_day {
  #  sql: ${TABLE}.cy_room_cnt_prior_7_day ;;
  #  value_format_name: decimal_0
  #  view_label: "   CY"
  #  label: "Rms Bkd Prior 7 Days"
  #  description: "Rms OTB Prior 7 Days"
  #  type: sum
  #}

  #measure:  cy_rooms_prior_7_day_var {
  #  sql: ${TABLE}.cy_room_cnt - ${TABLE}.cy_room_cnt_prior_7_day ;;
  #  value_format_name: decimal_0
  #  view_label: "   CY"
  #  label: "Rms Bkd Act:Prior 7 Days "
  #  description: "Rooms Bkd - Prior 7 Days"
  #  type: sum
  #  html:
  #  {% if value < 0 %}
  #  <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
  #  {% endif %};;
  #}

  #measure:  cy_rooms_prior_30_day {
  #  sql: ${TABLE}.cy_room_cnt_prior_30_day ;;
  #  value_format_name: decimal_0
  #  view_label: "   CY"
  #  label: "Rms Bkd MTD"
  #  description: "Rms OTB Last 30 Day Start"
  #  type: sum
  #}

  #measure:  cy_rooms_prior_30_day_var {
  #  sql: ${TABLE}.cy_room_cnt - ${TABLE}.cy_room_cnt_prior_30_day ;;
  #  value_format_name: decimal_0
  #  view_label: "   CY"
  #  label: "Rms Bkd Act:MTD"
  #  description: "Rooms Bkd - Prior 7 Days"
  #  type: sum
  #  html:
  #  {% if value < 0 %}
  #  <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
  #  {% endif %};;
  #}

  #-------------------------------------------------------------------------------------------
  #-- Measures STLY
  #-------------------------------------------------------------------------------------------

  measure: stly_sp {
    view_label: "  STLY"
    label: "     STLY  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure:  stly_rooms{
    sql: ${TABLE}.stly_room_cnt ;;
    value_format_name: decimal_0
    view_label: "  STLY"
    label: "Rms Bkd"
    description: "STLY Room Booked"
    type: sum
  }

  measure:  stly_room_rev{
    sql: ${TABLE}.stly_room_rev_amt ;;
    value_format_name: usd_0
    view_label: "  STLY"
    label: "Rev Rms $"
    description: "STLY Room Revenue"
    type: sum
  }

  measure:  stly_food_rev{
    sql: ${TABLE}.stly_food_rev_amt ;;
    value_format_name: usd_0
    view_label: "  STLY"
    label: "Rev Food $"
    description: "STLY Food Revenue"
    type: sum
  }

  measure:  stly_other_rev{
    sql: ${TABLE}.stly_other_rev_amt ;;
    value_format_name: usd_0
    view_label: "  STLY"
    label: "Rev Other $"
    description: "STLY Other Revenue"
    type: sum
  }

  measure:  stly_ttl_rev{
    sql: ${TABLE}.stly_room_rev_amt + ${TABLE}.stly_food_rev_amt + ${TABLE}.stly_other_rev_amt ;;
    value_format_name: usd_0
    view_label: "  STLY"
    label: "Rev $"
    description: "STLY Total Revenue"
    type: sum
  }

  measure:  stly_room_adr{
    sql: utl..udf_divide(${stly_room_rev},${stly_rooms}) ;;
    type: number
    value_format_name: usd
    view_label: "  STLY"
    label: "ADR"
    description: "Average Daily Rate"
  }

  measure: stly_room_ttl_perc {
    view_label: "  STLY"
    label: "Rms Bkd - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${stly_rooms} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure: stly_rev_ttl_perc {
    view_label: "  STLY"
    label: "Rev Rms $ - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${stly_room_rev} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure: stly_adr_ttl_perc {
    view_label: "  STLY"
    label: "ADR - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: utl..udf_divide(${stly_room_rev},${stly_rooms}) ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure:  stly_rooms_bkd_pct{
    sql: utl..udf_divide(${stly_rooms}, ${dt_revintel_segment_pace_avail_rooms.dt_stly_avail_room_cnt}) ;;
    value_format_name: percent_1
    view_label: "  STLY"
    label: "Rms Bkd %"
    description: "Rooms Booked / Rooms Available"
    type: number
  }

  measure:  stly_rev_par{
    sql: utl..udf_divide(${stly_room_rev}, ${dt_revintel_segment_pace_avail_rooms.dt_stly_avail_room_cnt}) ;;
    value_format_name: usd_0
    view_label: "  STLY"
    label: "Rev PAR $"
    description: "Revenue per Available Room Amount"
    type: number
  }


  #-------------------------------------------------------------------------------------------
  #-- Measures LY
  #-------------------------------------------------------------------------------------------

  measure: ly_sp {
    view_label: "  LY"
    label: "     LY  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure:  ly_rooms{
    sql: ${TABLE}.ly_room_cnt ;;
    value_format_name: decimal_0
    view_label: "  LY"
    label: "Rms Bkd"
    description: "LY Room Booked"
    type: sum
  }

  measure:  ly_room_rev{
    sql: ${TABLE}.ly_room_rev_amt ;;
    value_format_name: usd_0
    view_label: "  LY"
    label: "Rev Rms $"
    description: "LY Room Revenue"
    type: sum
  }

  measure:  ly_food_rev{
    sql: ${TABLE}.ly_food_rev_amt ;;
    value_format_name: usd_0
    view_label: "  LY"
    label: "Rev Food $"
    description: "LY Food Revenue"
    type: sum
  }

  measure:  ly_other_rev{
    sql: ${TABLE}.ly_other_rev_amt ;;
    value_format_name: usd_0
    view_label: "  LY"
    label: "Rev Other $"
    description: "LY Other Revenue"
    type: sum
  }

  measure:  ly_ttl_rev{
    sql: ${TABLE}.ly_room_rev_amt + ${TABLE}.ly_food_rev_amt + ${TABLE}.ly_other_rev_amt ;;
    value_format_name: usd_0
    view_label: "  LY"
    label: "Rev $"
    description: "LY Total Revenue"
    type: sum
  }

  measure:  ly_room_adr{
    sql: utl..udf_divide(${ly_room_rev},${ly_rooms}) ;;
    type: number
    value_format_name: usd
    view_label: "  LY"
    label: "ADR"
    description: "Average Daily Rate"
  }

  measure: ly_room_ttl_perc {
    view_label: "  LY"
    label: "Rms Bkd - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${ly_rooms} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure: ly_rev_ttl_perc {
    view_label: "  LY"
    label: "Rev Rms $ - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${ly_room_rev} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure: ly_adr_ttl_perc {
    view_label: "  LY"
    label: "ADR - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: utl..udf_divide(${ly_room_rev},${ly_rooms}) ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure:  ly_rooms_bkd_pct{
    sql: utl..udf_divide(${ly_rooms}, ${dt_revintel_segment_pace_avail_rooms.dt_ly_avail_room_cnt}) ;;
    value_format_name: percent_1
    view_label: "  LY"
    label: "Rms Bkd %"
    description: "Rooms Booked / Rooms Available"
    type: number
  }

  measure:  ly_rev_par{
    sql: utl..udf_divide(${ly_room_rev}, ${dt_revintel_segment_pace_avail_rooms.dt_ly_avail_room_cnt}) ;;
    value_format_name: usd_0
    view_label: "  LY"
    label: "Rev PAR $"
    description: "Revenue per Available Room Amount"
    type: number
  }


  #-------------------------------------------------------------------------------------------
  #-- Measures compare to py
  #-------------------------------------------------------------------------------------------

  measure:  rooms_var_perc{
    sql: utl..udf_percent_var((${cy_rooms}),(${stly_rooms})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd Act:STLY - % var"
    description: "(TY - STLY)/STLY"
  }

  measure:  rooms_var{
    sql: (${cy_rooms})-(${stly_rooms}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  room_rev_var_perc{
    sql: utl..udf_percent_var((${cy_room_rev}),(${stly_room_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Rms $ Act:STLY - % var"
    description: "(TY - STLY)/STLY"
  }

  measure:  room_rev_var{
    sql: (${cy_room_rev})-(${stly_room_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Rms $ Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  food_rev_var_perc{
    sql: utl..udf_percent_var((${cy_food_rev}),(${stly_food_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Food $ Act:STLY - % var"
    description: "(TY - STLY)/STLY"
  }

  measure:  food_rev_var{
    sql: (${cy_food_rev})-(${stly_food_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Food $ Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  other_rev_var_perc{
    sql: utl..udf_percent_var((${cy_other_rev}),(${stly_other_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Other $ Act:STLY - % var"
    description: "(TY - STLY)/STLY"
  }

  measure:  other_rev_var{
    sql: (${cy_other_rev})-(${stly_other_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Other $ Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  ttl_rev_var_perc{
    sql: utl..udf_percent_var((${cy_ttl_rev}),(${stly_ttl_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev $ Act:STLY - % var"
    description: "(TY - STLY)/STLY"
  }

  measure:  ttl_rev_var{
    sql: (${cy_ttl_rev})-(${stly_ttl_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev $ Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  room_adr_var_perc{
    sql: utl..udf_percent_var((${cy_room_adr}),(${stly_room_adr})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "ADR Act:STLY - % var"
    description: "(TY - STLY)/STLY"
  }

  measure:  room_adr_var{
    sql: (${cy_room_adr})-(${stly_room_adr}) ;;
    type: number
    value_format_name: usd
    view_label: "   CY"
    label: "ADR Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  rooms_bkd_pct_var_perc{
    sql: utl..udf_percent_var((${cy_rooms_bkd_pct}),(${stly_rooms_bkd_pct})) ;;
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd % Act:STLY - % var"
    description: "(TY - STLY)/STLY"
    type: number
  }

  measure:  rooms_bkd_pct_var{
    sql: (${cy_rooms_bkd_pct})-(${stly_rooms_bkd_pct}) ;;
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd % Act:STLY - var"
    description: "(TY - STLY)"
    type: number
  }

  measure:  rev_par_var_perc{
    sql: utl..udf_percent_var(${cy_rev_par}, ${stly_rev_par}) ;;
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev PAR $ Act:STLY - % var"
    description: "(TY - STLY)/STLY"
    type: number
  }

  measure:  rev_par_var{
    sql: (${cy_rev_par} - ${stly_rev_par}) ;;
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev PAR $ Act:STLY - var"
    description: "(TY - STLY)"
    type: number
  }



  #-------------------------------------------------------------------------------------------
  #-- Measures compare to ly
  #-------------------------------------------------------------------------------------------

  measure:  rooms_var_perc_toly{
    sql: utl..udf_percent_var((${cy_rooms}),(${ly_rooms})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  rooms_var_toly{
    sql: (${cy_rooms})-(${ly_rooms}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  room_rev_var_perc_toly{
    sql: utl..udf_percent_var((${cy_room_rev}),(${ly_room_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Rms $ Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  room_rev_var_toly{
    sql: (${cy_room_rev})-(${ly_room_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Rms $ Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  food_rev_var_perc_toly{
    sql: utl..udf_percent_var((${cy_food_rev}),(${ly_food_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Food $ Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  food_rev_var_toly{
    sql: (${cy_food_rev})-(${ly_food_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Food $ Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  other_rev_var_perc_toly{
    sql: utl..udf_percent_var((${cy_other_rev}),(${ly_other_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Other $ Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  other_rev_var_toly{
    sql: (${cy_other_rev})-(${ly_other_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Other $ Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  ttl_rev_var_perc_toly{
    sql: utl..udf_percent_var((${cy_ttl_rev}),(${ly_ttl_rev})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev $ Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  ttl_rev_var_toly{
    sql: (${cy_ttl_rev})-(${ly_ttl_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev $ Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  room_adr_var_perc_toly{
    sql: utl..udf_percent_var((${cy_room_adr}),(${ly_room_adr})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "ADR Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  room_adr_var_toly{
    sql: (${cy_room_adr})-(${ly_room_adr}) ;;
    type: number
    value_format_name: usd
    view_label: "   CY"
    label: "ADR Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  rooms_bkd_pct_var_perc_toly{
    sql: utl..udf_percent_var((${cy_rooms_bkd_pct}),(${ly_rooms_bkd_pct})) ;;
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd % Act:LY - % var"
    description: "(TY - LY)/LY"
    type: number
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  rooms_bkd_pct_var_toly{
    sql: (${cy_rooms_bkd_pct})-(${ly_rooms_bkd_pct}) ;;
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd % Act:LY - var"
    description: "(TY - LY)"
    type: number
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  rev_par_var_perc_toly{
    sql: utl..udf_divide(${cy_rev_par}, ${ly_rev_par}) ;;
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev PAR $ Act:LY - % var"
    description: "(TY - LY)/LY"
    type: number
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  rev_par_var_toly{
    sql: (${cy_rev_par} - ${ly_rev_par}) ;;
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev PAR $ Act:LY - var"
    description: "(TY - LY)"
    type: number
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  #-------------------------------------------------------------------------------------------
  #-- Measures stly pickup
  #-------------------------------------------------------------------------------------------

  measure:  rooms_stly_pickup{
    sql: (${ly_rooms})-(${stly_rooms}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd LY:STLY - Pickup"
    description: "(LY - STLY)"
  }

  measure:  room_rev_stly_pickup{
    sql: (${ly_room_rev})-(${stly_room_rev}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Rms $ LY:STLY - Pickup"
    description: "(LY - STLY)"
  }

  measure:  room_adr_stly_pickup{
    sql: utl..udf_percent_var((${room_rev_stly_pickup}),(${rooms_stly_pickup})) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "ADR LY:STLY - Pickup"
    description: "(LY - STLY)"
  }

#-------------------------------------------------------------------------------------------
#-- Measures reach to ly
#-------------------------------------------------------------------------------------------

  measure:  rooms_stly_reach{
    sql: (${rooms_stly_pickup}) + (${rooms_var}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd LY:STLY - Reach"
    description: "(STLY pickup + Act:LY - var)"
  }

  measure:  room_rev_stly_reach{
    sql: (${room_rev_stly_pickup}) + (${room_rev_var}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Rms $ LY:STLY - Reach"
    description: "(STLY pickup + Act:LY - var)"
  }

  measure:  room_adr_stly_reach{
    sql: utl..udf_percent_var((${room_rev_stly_reach}),(${rooms_stly_reach})) ;;
    type: number
    value_format_name: usd
    view_label: "   CY"
    label: "ADR LY:STLY - Reach"
    description: "(STLY pickup + Act:LY - var)"
  }

  #-------------------------------------------------------------------------------------------
  #-- Forecast & Budget
  #-------------------------------------------------------------------------------------------

  measure: fcst_sp {
    view_label: "  FCST"
    label: "     FCST  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure:  fcst_room_cnt{
    sql: ${TABLE}.fcst_room_cnt ;;
    value_format_name: decimal_0
    view_label: "  FCST"
    label: "Rms Bkd"
    description: "Room Booked"
    type: sum
  }

  measure:  fcst_room_rev_amt{
    sql: ${TABLE}.fcst_room_rev_amt ;;
    value_format_name: usd_0
    view_label: "  FCST"
    label: "Rev Rms $"
    description: "Room Revenue"
    type: sum
  }

  measure:  fcst_room_adr{
    sql: utl..udf_divide(${fcst_room_rev_amt},${fcst_room_cnt}) ;;
    type: number
    value_format_name: usd
    view_label: "  FCST"
    label: "ADR"
    description: "Average Daily Rate"
  }

  measure: fcst_rev_ttl_perc {
    view_label: "  FCST"
    label: "Rev Rms $ - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${fcst_room_cnt} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure:  fcst_rooms_bkd_pct{
    sql: utl..udf_divide(${fcst_room_cnt}, ${dt_revintel_segment_pace_avail_rooms.dt_fcst_avail_room_cnt}) ;;
    value_format_name: percent_1
    view_label: "  FCST"
    label: "Rms Bkd %"
    description: "Rooms Booked / Rooms Available"
    type: number
  }

  measure:  fcst_rev_par{
    sql: utl..udf_divide(${fcst_room_rev_amt}, ${dt_revintel_segment_pace_avail_rooms.dt_fcst_avail_room_cnt}) ;;
    value_format_name: usd_0
    view_label: "  FCST"
    label: "Rev PAR $"
    description: "Revenue per Available Room Amount"
    type: number
  }

  measure: bdgt_sp {
    view_label: "  BDGT"
    label: "     BDGT  :"
    description: "Blank space separator."
    type: string
    sql: '-----' ;;
  }

  measure:  bdgt_room_cnt{
    sql: ${TABLE}.bdgt_room_cnt ;;
    value_format_name: decimal_0
    view_label: "  BDGT"
    label: "Rms Bkd"
    description: "Room Booked"
    type: sum
  }

  measure:  bdgt_room_rev_amt{
    sql: ${TABLE}.bdgt_room_rev_amt ;;
    value_format_name: usd_0
    view_label: "  BDGT"
    label: "Rev Rms $"
    description: "Room Revenue"
    type: sum
  }

  measure:  bdgt_room_adr{
    sql: utl..udf_divide(${bdgt_room_rev_amt},${bdgt_room_cnt}) ;;
    type: number
    value_format_name: usd
    view_label: "  BDGT"
    label: "ADR"
    description: "Average Daily Rate"
  }

  measure: bdgt_rev_ttl_perc {
    view_label: "  BDGT"
    label: "Rev Rms $ - % Mix"
    description: "Percent of total value."
    type: percent_of_total
    sql: ${bdgt_room_cnt} ;;
    value_format: "0.0\%"
    hidden: no
  }

  measure:  bdgt_rooms_bkd_pct{
    sql: utl..udf_divide(${bdgt_room_cnt}, ${dt_revintel_segment_pace_avail_rooms.dt_bdgt_avail_room_cnt}) ;;
    value_format_name: percent_1
    view_label: "  BDGT"
    label: "Rms Bkd %"
    description: "Rooms Booked / Rooms Available"
    type: number
  }

  measure:  bdgt_rev_par{
    sql: utl..udf_divide(${bdgt_room_rev_amt}, ${dt_revintel_segment_pace_avail_rooms.dt_bdgt_avail_room_cnt}) ;;
    value_format_name: usd_0
    view_label: "  BDGT"
    label: "Rev PAR $"
    description: "Revenue per Available Room Amount"
    type: number
  }

  #-------------------------------------------------------------------------------------------
  #-- Measures compare to bdgt and fcst
  #-------------------------------------------------------------------------------------------

  measure:  fcst_rooms_var_perc{
    sql: utl..udf_percent_var((${cy_rooms}),(${fcst_room_cnt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd Act:Fcst - % var"
    description: "(TY - FCST)/FCST"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_rooms_var{
    sql: (${cy_rooms})-(${fcst_room_cnt}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd Act:Fcst - var"
    description: "(TY - FCST)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_room_rev_var_perc{
    sql: utl..udf_percent_var((${cy_room_rev}),(${fcst_room_rev_amt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Rms $ Act:Fcst - % var"
    description: "(TY - FCST)/FCST"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_room_rev_var{
    sql: (${cy_room_rev})-(${fcst_room_rev_amt}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Rms $ Act:Fcst - var"
    description: "(TY - FCST)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_room_adr_var_perc{
    sql: utl..udf_percent_var((${cy_room_adr}),(${fcst_room_adr})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "ADR Act:Fcst - % var"
    description: "(TY - FCST)/FCST"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_room_adr_var{
    sql: (${cy_room_adr})-(${fcst_room_adr}) ;;
    type: number
    value_format_name: usd
    view_label: "   CY"
    label: "ADR Act:Fcst - var"
    description: "(TY - FCST)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_rev_par_var_perc{
    sql: utl..udf_percent_var((${cy_rev_par}),(${fcst_rev_par})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "ADR Act:Fcst - % var"
    description: "(TY - FCST)/FCST"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_rev_par_var{
    sql: (${cy_rev_par})-(${fcst_rev_par}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev PAR Act:Fcst - var"
    description: "(TY - FCST)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_rooms_var_perc{
    sql: utl..udf_percent_var((${cy_rooms}),(${bdgt_room_cnt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rms Bkd Act:Bdgt - % var"
    description: "(TY - BDGT)/BDGT"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_rooms_var{
    sql: (${cy_rooms})-(${bdgt_room_cnt}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd Act:Bdgt - var"
    description: "(TY - BDGT)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_room_rev_var_perc{
    sql: utl..udf_percent_var((${cy_room_rev}),(${bdgt_room_rev_amt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Rms $ Act:Bdgt - % var"
    description: "(TY - BDGT)/BDGT"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_room_rev_var{
    sql: (${cy_room_rev})-(${bdgt_room_rev_amt}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev Rms $ Act:Bdgt - var"
    description: "(TY - BDGT)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_room_adr_var_perc{
    sql: utl..udf_percent_var((${cy_room_adr}),(${bdgt_room_adr})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "ADR Act:Bdgt - % var"
    description: "(TY - BDGT)/BDGT"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_room_adr_var{
    sql: (${cy_room_adr})-(${bdgt_room_adr}) ;;
    type: number
    value_format_name: usd
    view_label: "   CY"
    label: "ADR Act:Bdgt - var"
    description: "(TY - BDGT)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_rev_par_var_perc{
    sql: utl..udf_percent_var((${cy_rev_par}),(${bdgt_rev_par})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "ADR Act:Bdgt - % var"
    description: "(TY - BDGT)/BDGT"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_rev_par_var{
    sql: (${cy_rev_par})-(${bdgt_rev_par}) ;;
    type: number
    value_format_name: usd_0
    view_label: "   CY"
    label: "Rev PAR Act:Bdgt - var"
    description: "(TY - BDGT)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }


  # Period Pickup

  measure:  cy_rooms_start{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_start_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.cy_room_cnt else 0 end )
          ;;
    view_label: "   CY"
    label: "Rms Bkd Period Start"
    description: "Rooms booked at start of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  cy_rooms_end{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_end_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.cy_room_cnt else 0 end )
          ;;
    view_label: "   CY"
    label: "Rms Bkd Period End"
    description: "Rooms booked at end of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  cy_rooms_period_pkup{
    sql: ${cy_rooms_end} - ${cy_rooms_start};;
    view_label: "   CY"
    label: "Rms Bkd Period Pickup"
    description: "Rooms booked between start and end of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  cy_room_rev_start{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_start_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.cy_room_rev_amt else 0 end )
          ;;
    view_label: "   CY"
    label: "Rev Rms Period Start"
    description: "Room revenue at start of period"
    type: number
    value_format_name: usd_0
  }

  measure:  cy_room_rev_end{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_end_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.cy_room_rev_amt else 0 end )
          ;;
    view_label: "   CY"
    label: "Rev Rms Period End"
    description: "Room revenue at end of period"
    type: number
    value_format_name: usd_0
  }

  measure:  cy_room_rev_period_pkup{
    sql: ${cy_room_rev_end} - ${cy_room_rev_start};;
    view_label: "   CY"
    label: "Rev Rms Period Pickup"
    description: "Room revenue between start and end of period"
    type: number
    value_format_name: usd_0
  }

  measure:  cy_adr_start{
    sql: utl..udf_divide( ${cy_room_rev_start}, ${cy_rooms_start} ) ;;
    view_label: "   CY"
    label: "ADR Period Start"
    description: "ADR at start of period"
    type: number
    value_format_name: usd
  }

  measure:  cy_adr_end{
    sql: utl..udf_divide( ${cy_room_rev_end}, ${cy_rooms_end} ) ;;
    view_label: "   CY"
    label: "ADR Period End"
    description: "ADR at end of period"
    type: number
    value_format_name: usd
  }

  measure:  cy_adr_period_pkup{
    sql: ${cy_adr_end} - ${cy_adr_start};;
    view_label: "   CY"
    label: "ADR Period Pickup"
    description: "ADR between start and end of period"
    type: number
    value_format_name: usd
  }

  measure:  cy_adr_period_room_pkup{
    sql: utl..udf_divide( ${cy_room_rev_period_pkup}, ${cy_rooms_period_pkup} );;
    view_label: "   CY"
    label: "ADR Period Pickup - Rooms"
    description: "ADR of rooms picked up"
    type: number
    value_format_name: usd
  }

  # fcst pickup

  measure:  fcst_rooms_start{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_start_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.fcst_room_cnt else 0 end )
          ;;
    view_label: "  FCST"
    label: "Rms Bkd Period Start"
    description: "Rooms booked at start of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  fcst_rooms_end{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_end_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.fcst_room_cnt else 0 end )
          ;;
    view_label: "  FCST"
    label: "Rms Bkd Period End"
    description: "Rooms booked at end of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  fcst_rooms_period_pkup{
    sql: ${fcst_rooms_end} - ${fcst_rooms_start};;
    view_label: "  FCST"
    label: "Rms Bkd Period Pickup"
    description: "Rooms booked between start and end of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  fcst_room_rev_start{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_start_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.fcst_room_rev_amt else 0 end )
          ;;
    view_label: "  FCST"
    label: "Rev Rms Period Start"
    description: "Room revenue at start of period"
    type: number
    value_format_name: usd_0
  }

  measure:  fcst_room_rev_end{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_end_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.fcst_room_rev_amt else 0 end )
          ;;
    view_label: "  FCST"
    label: "Rev Rms Period End"
    description: "Room revenue at end of period"
    type: number
    value_format_name: usd_0
  }

  measure:  fcst_room_rev_period_pkup{
    sql: ${fcst_room_rev_end} - ${fcst_room_rev_start};;
    view_label: "  FCST"
    label: "Rev Rms Period Pickup"
    description: "Room revenue between start and end of period"
    type: number
    value_format_name: usd_0
  }

  measure:  fcst_adr_start{
    sql: utl..udf_divide( ${fcst_room_rev_start}, ${fcst_rooms_start} ) ;;
    view_label: "  FCST"
    label: "ADR Period Start"
    description: "ADR at start of period"
    type: number
    value_format_name: usd
  }

  measure:  fcst_adr_end{
    sql: utl..udf_divide( ${fcst_room_rev_end}, ${fcst_rooms_end} ) ;;
    view_label: "  FCST"
    label: "ADR Period End"
    description: "ADR at end of period"
    type: number
    value_format_name: usd
  }

  measure:  fcst_adr_period_pkup{
    sql: ${fcst_adr_end} - ${fcst_adr_start};;
    view_label: "  FCST"
    label: "ADR Period Pickup"
    description: "ADR between start and end of period"
    type: number
    value_format_name: usd
  }

  measure:  fcst_adr_period_room_pkup{
    sql: utl..udf_divide( ${fcst_room_rev_period_pkup}, ${fcst_rooms_period_pkup} );;
    view_label: "  FCST"
    label: "ADR Period Pickup - Rooms"
    description: "ADR of rooms picked up"
    type: number
    value_format_name: usd
  }

  # bdgt pickup

  measure:  bdgt_rooms_start{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_start_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.bdgt_room_cnt else 0 end )
          ;;
    view_label: "  BDGT"
    label: "Rms Bkd Period Start"
    description: "Rooms booked at start of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  bdgt_rooms_end{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_end_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.bdgt_room_cnt else 0 end )
          ;;
    view_label: "  BDGT"
    label: "Rms Bkd Period End"
    description: "Rooms booked at end of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  bdgt_rooms_period_pkup{
    sql: ${bdgt_rooms_end} - ${bdgt_rooms_start};;
    view_label: "  BDGT"
    label: "Rms Bkd Period Pickup"
    description: "Rooms booked between start and end of period"
    type: number
    value_format_name: decimal_0
  }

  measure:  bdgt_room_rev_start{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_start_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.bdgt_room_rev_amt else 0 end )
          ;;
    view_label: "  BDGT"
    label: "Rev Rms Period Start"
    description: "Room revenue at start of period"
    type: number
    value_format_name: usd_0
  }

  measure:  bdgt_room_rev_end{
    sql: sum( case when ${dt_revintel_segment_pace_pickup_date.dt_end_asof_dt} =
          ${dt_revintel_segment_pace_pickup_date.asof_dt}
          then ${TABLE}.bdgt_room_rev_amt else 0 end )
          ;;
    view_label: "  BDGT"
    label: "Rev Rms Period End"
    description: "Room revenue at end of period"
    type: number
    value_format_name: usd_0
  }

  measure:  bdgt_room_rev_period_pkup{
    sql: ${bdgt_room_rev_end} - ${bdgt_room_rev_start};;
    view_label: "  BDGT"
    label: "Rev Rms Period Pickup"
    description: "Room revenue between start and end of period"
    type: number
    value_format_name: usd_0
  }

  measure:  bdgt_adr_start{
    sql: utl..udf_divide( ${bdgt_room_rev_start}, ${bdgt_rooms_start} ) ;;
    view_label: "  BDGT"
    label: "ADR Period Start"
    description: "ADR at start of period"
    type: number
    value_format_name: usd
  }

  measure:  bdgt_adr_end{
    sql: utl..udf_divide( ${bdgt_room_rev_end}, ${bdgt_rooms_end} ) ;;
    view_label: "  BDGT"
    label: "ADR Period End"
    description: "ADR at end of period"
    type: number
    value_format_name: usd
  }

  measure:  bdgt_adr_period_pkup{
    sql: ${bdgt_adr_end} - ${bdgt_adr_start};;
    view_label: "  BDGT"
    label: "ADR Period Pickup"
    description: "ADR between start and end of period"
    type: number
    value_format_name: usd
  }

  measure:  bdgt_adr_period_room_pkup{
    sql: utl..udf_divide( ${bdgt_room_rev_period_pkup}, ${bdgt_rooms_period_pkup} );;
    view_label: "  BDGT"
    label: "ADR Period Pickup - Rooms"
    description: "ADR of rooms picked up"
    type: number
    value_format_name: usd
  }

 # Compares period end to act

  measure:  bdgt_rooms_period_end_var{
    sql: (${cy_rooms_end})-(${bdgt_rooms_end}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd Period End Act:Bdgt - var"
    description: "(TY - BDGT)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_room_rev_period_end_var{
    sql: (${cy_room_rev_end})-(${bdgt_room_rev_end}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rev Rms Period End Act:Bdgt - var"
    description: "(TY - BDGT)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_room_rev_period_end_var_perc{
    sql: utl..udf_divide(${bdgt_room_rev_period_end_var},${bdgt_room_rev_end}) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Rms Period End Act:Bdgt - % var"
    description: "(TY - BDGT)/BDGT"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  bdgt_adr_period_end_var{
    sql: (${cy_adr_end})-(${bdgt_adr_end}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "ADR Period End Act:Bdgt - var"
    description: "(TY - BDGT)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_rooms_period_end_var{
    sql: (${cy_rooms_end})-(${fcst_rooms_end}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rms Bkd Period End Act:Fcst - var"
    description: "(TY - FCST)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_room_rev_period_end_var{
    sql: (${cy_room_rev_end})-(${fcst_room_rev_end}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "Rev Rms Period End Act:Fcst - var"
    description: "(TY - FCST)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_room_rev_period_end_var_perc{
    sql: utl..udf_divide(${fcst_room_rev_period_end_var},${fcst_room_rev_end}) ;;
    type: number
    value_format_name: percent_1
    view_label: "   CY"
    label: "Rev Rms Period End Act:Fcst - % var"
    description: "(TY - FCST)/FCST"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  fcst_adr_period_end_var{
    sql: (${cy_adr_end})-(${fcst_adr_end}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   CY"
    label: "ADR Period End Act:Fcst - var"
    description: "(TY - FCST)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }


}
