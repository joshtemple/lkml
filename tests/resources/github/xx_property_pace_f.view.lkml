view: xx_property_pace_f {
  sql_table_name: pedw.fact.xx_property_pace_f ;;

  #-------------------------------------------------------------------------------------------
  #-- Keys
  #-------------------------------------------------------------------------------------------

  dimension: property_key {
    primary_key: yes
    sql: ${TABLE}.property_key ;;
    hidden: yes
  }

  dimension: pace_date {
    sql: ${TABLE}.pace_date ;;
    hidden: yes
  }

  dimension: pace_date_sid {
    sql: ${TABLE}.pace_date_sid ;;
    hidden: yes
  }

  #-------------------------------------------------------------------------------------------
  #-- Dimensions
  #-------------------------------------------------------------------------------------------

  dimension: market_nm {
    sql: ${TABLE}.market_name ;;
    view_label: "Pace Detail"
    label: "Reservation Segment Name"
    description: "Reservation Segment Name"
    type: string

  }

  #-------------------------------------------------------------------------------------------
  #-- Measures
  #-------------------------------------------------------------------------------------------

  measure:  room_rev{
    sql: ${TABLE}.room_rev ;;
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $"
    description: "Room Revenue"
    type: sum
  }

  measure:  room_rev_stly{
    sql: ${TABLE}.room_rev_stly ;;
    value_format_name: usd_0
    view_label: " STLY"
    label: "Rev Rms $ STLY"
    description: "Room Revenue (Same Time Last Year)"
    type: sum
  }

  measure:  room_rev_ly{
    sql: ${TABLE}.act_roomrev_ly ;;
    value_format_name: usd_0
    view_label: " LY"
    label: "Rev Rms $ LY"
    description: "Room Revenue ( Last Year)"
    type: sum
  }

  measure:  roomsold{
    sql: ${TABLE}.roomsold ;;
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd"
    description: "Room Booked"
    type: sum
  }

  measure:  roomsold_stly{
    sql: ${TABLE}.roomsold_stly ;;
    value_format_name: decimal_0
    view_label: " STLY"
    label: "Rms Bkd STLY"
    description: "Room Booked (Same Time Last Year)"
    type: sum
  }

  measure:  roomsold_ly{
    sql: ${TABLE}.act_roomssold_ly ;;
    value_format_name: decimal_0
    view_label: " LY"
    label: "Rms Bkd LY"
    description: "Room Booked (Last Year)"
    type: sum
  }

  measure:  room_adr{
    sql: utl..udf_divide(${room_rev},${roomsold}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR"
    description: "Average Daily Rate"
  }

  measure:  room_adr_stly{
    sql: utl..udf_divide(${room_rev_stly},${roomsold_stly}) ;;
    type: number
    value_format_name: usd_0
    view_label: " STLY"
    label: "ADR STLY"
    description: "ADR (Same Time Last Year)"
  }

  measure:  room_adr_ly{
    sql: utl..udf_divide(${room_rev_ly},${roomsold_ly}) ;;
    type: number
    value_format_name: usd_0
    view_label: " LY"
    label: "ADR LY"
    description: "ADR (Last Year)"
  }

  measure:  budg_roomrev{
    sql: ${TABLE}.budg_roomrev ;;
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Bdgt"
    description: "Budget Room Revenue"
    type: sum
  }

  measure:  budg_roomsold{
    sql: ${TABLE}.budg_roomsold ;;
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Bdgt"
    description: "Budget Room Sold"
    type: sum
  }

  measure:  budg_adr{
    sql: utl..udf_divide(${budg_roomrev},${budg_roomsold});;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Bdgt"
    description: "Budget ADR"
  }

  measure:  act_fcst_roomrev{
    sql: ${TABLE}.act_fcst_roomrev ;;
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Fcst"
    description: "Act/Fcst Room Revenue"
    type: sum

  }

  measure:  act_fcst_roomsold{
    sql: ${TABLE}.act_fcst_roomsold;;
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Fcst"
    description: "Act/Fcst Room Sold"
    type: sum
  }

  measure:  act_fcst_adr{
    sql: utl..udf_divide(${act_fcst_roomrev},${act_fcst_roomsold}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Fcst"
    description: "Act/Fcst ADR"
  }

  #-------------------------------------------------------------------------------------------
  #-- Prospect
  #-------------------------------------------------------------------------------------------

  measure:  prosp_roomrev{
    sql: ${TABLE}.prosp_roomrev ;;
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Prospect"
    description: "Prospect Room Revenue"
    type: sum
  }

  measure:  prosp_roomrev_stly{
    sql: ${TABLE}.prosp_roomrev_stly ;;
    value_format_name: usd_0
    view_label: " STLY"
    label: "Rev Rms $ Prospect LY"
    description: "Prospect Room Revenue (Same Time Last Year)"
    type: sum
  }

  measure:  prosp_roomrev_var_perc{
    sql: utl..udf_percent_var((${prosp_roomrev}),(${prosp_roomrev_stly})) ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "Rev Rms $ Prospect Act:LY - % var"
    description: "(TY - LY)/TY"
  }

  measure:  prosp_roomrev_var{
    sql: (${prosp_roomrev})-(${prosp_roomrev_stly}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Prospect Act:LY - var"
    description: "(TY - LY)"
  }

  measure:  prosp_roomsold{
    sql: ${TABLE}.prosp_roomsold ;;
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Prospect"
    description: "Prospect Room Booked"
    type: sum
  }

  measure:  prosp_roomsold_stly{
    sql: ${TABLE}.prosp_roomsold_stly ;;
    value_format_name: decimal_0
    view_label: " STLY"
    label: "Rms Bkd Prospect LY"
    description: "Prospect Room Booked (Same Time Last Year)"
    type: sum
  }

  measure:  prosp_roomsold_var_perc{
    sql: utl..udf_percent_var((${prosp_roomsold}),(${prosp_roomsold_stly})) ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "Rms Bkd Prospect Act:LY - % var"
    description: "(TY - LY)/TY"
  }

  measure:  prosp_roomsold_var{
    sql: (${prosp_roomsold})-(${prosp_roomsold_stly}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Prospect Act:LY - var"
    description: "(TY - LY)"
  }

  measure:  prosp_adr{
    sql: utl..udf_divide(${prosp_roomrev},${prosp_roomsold}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Prospect"
    description: "Prospect Average Daily Rate"
  }

  measure:  prosp_adr_stly{
    sql: utl..udf_divide(${prosp_roomrev_stly},${prosp_roomsold_stly}) ;;
    type: number
    value_format_name: usd_0
    view_label: " STLY"
    label: "ADR Prospect LY"
    description: "Prospect Average Daily Rate (Same Time Last Year)"
  }

  measure:  prosp_adr_var_perc{
    sql: utl..udf_percent_var(utl..udf_divide(${prosp_roomrev},${prosp_roomsold}),utl..udf_divide(${prosp_roomrev_stly},${prosp_roomsold_stly})) ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "ADR Prospect Act:LY - % var"
    description: "(TY - LY)/TY"
  }

  measure:  prosp_adr_var{
    sql: utl..udf_divide((${prosp_roomrev},${prosp_roomsold})-utl..udf_divide(${prosp_roomrev_stly},${prosp_roomsold_stly}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Prospect Act:LY - var"
    description: "(TY - LY)"
  }

  #-------------------------------------------------------------------------------------------
  #-- Tentative
  #-------------------------------------------------------------------------------------------

  measure:  tent_roomrev{
    sql: ${TABLE}.tent_roomrev ;;
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Tentative"
    description: "Tentative Room Revenue "
    type: sum
  }

  measure:  tent_roomrev_stly{
    sql: ${TABLE}.tent_roomrev_stly ;;
    value_format_name: usd_0
    view_label: " STLY"
    label: "Rev Rms $ Tentative LY"
    description: "Tentative Room (Same Time Last Year)"
    type: sum
  }

  measure:  tent_roomrev_var_perc{
    sql: utl..udf_percent_var((${tent_roomrev}),(${tent_roomrev_stly})) ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "Rev Rms $ Tentative Act:LY - % var"
    description: "(TY - LY)/TY"
  }

  measure:  tent_roomrev_var{
    sql: (${tent_roomrev})-(${tent_roomrev_stly}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Tentative Act:LY - var"
    description: "(TY - LY)"
  }

  measure:  tent_roomsold{
    sql: ${TABLE}.tent_roomsold ;;
    value_format_name: decimal_0
    view_label: " STLY"
    label: "Rms Bkd Tentative"
    description: "Tentative Room Sold"
    type: sum
  }

  measure:  tent_roomsold_stly{
    sql: ${TABLE}.tent_roomsold_stly ;;
    value_format_name: decimal_0
    view_label: " LY"
    label: "Rms Bkd Tentative LY"
    description: "Tentative Room Sold (Same Time Last Year)"
    type: sum
  }

  measure:  tent_roomsold_var_perc{
    sql: utl..udf_percent_var((${tent_roomsold}),(${tent_roomsold_stly})) ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "Rms Bkd Tentative Act:LY - % var"
    description: "(TY - LY)/TY"
  }

  measure:  tent_roomsold_var{
    sql: (${tent_roomsold})-(${tent_roomsold_stly}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Tentative Act:LY - var"
    description: "(TY - LY)"
  }

  measure:  tent_adr{
    sql: utl..udf_divide(${tent_roomrev},${tent_roomsold}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Tentative"
    description: "Tentative ADR"
  }

  measure:  tent_adr_stly{
    sql: utl..udf_divide(${tent_roomrev_stly},${tent_roomsold_stly}) ;;
    type: number
    value_format_name: usd_0
    view_label: " STLY"
    label: "ADR Tentative LY"
    description: "Tentative Average Daily Rate (Same Time Last Year)"
  }

  measure:  tent_adr_var_perc{
    sql: utl..udf_percent_var(utl..udf_divide(${tent_roomrev},${tent_roomsold}),utl..udf_divide(${tent_roomrev_stly},${tent_roomsold_stly})) ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "ADR Tentative Act:LY - % var"
    description: "(TY - LY)/TY"
  }

  measure:  tent_adr_var{
    sql: utl..udf_divide(${tent_roomrev},${tent_roomsold})-utl..udf_divide(${tent_roomrev_stly},${tent_roomsold_stly}) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Tentative Act:LY - var"
    description: "(TY - LY)"
  }



  #-------------------------------------------------------------------------------------------
  #-- % Vairance
  #-------------------------------------------------------------------------------------------

  measure:  roomrev_var_perc_ly{
    sql: utl..udf_percent_var(${room_rev},${room_rev_stly}) ;;
    view_label: "  TY"
    label: "Rev Rms $ Act:STLY - % var"
    description: "(TY - STLY)/TY"
    type: number
    value_format_name: percent_1
  }


  measure:  roomrev_var_perc_budg{
    sql: utl..udf_percent_var(${room_rev},${budg_roomrev}) ;;
    label: "Rev Rms $ Act:Bdgt - % var"
    description: "(TY - Bdgt)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }

  measure:  roomrev_var_perc_fcst{
    sql: utl..udf_percent_var(${room_rev},${act_fcst_roomrev}) ;;
    label: "Rev Rms $ Act:Fcst - % var"
    description: "(TY - Fcst)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }

  measure:  roomsold_var_perc_ly{
    sql: utl..udf_percent_var(${roomsold},${roomsold_stly}) ;;
    label: "Rms Bkd Act:STLY - % var"
    description: "(TY - STLY)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }

  measure:  roomsold_var_perc_budg{
    sql: utl..udf_percent_var(${roomsold},${budg_roomsold}) ;;
    label: "Rms Bkd Act:Bdgt - % var"
    description: "(TY - Bdgt)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }

  measure:  roomsold_var_perc_fcst{
    sql: utl..udf_percent_var(${roomsold},${act_fcst_roomsold}) ;;
    label: "Rms Bkd Act:Fcst - % var"
    description: "(TY - Fcst)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }

  measure:  adr_var_perc_ly{
    sql: utl..udf_percent_var(${room_adr},${room_adr_stly}) ;;
    label: "ADR Act:STLY - % var"
    description: "(TY - STLY)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }

  measure:  adr_var_perc_budg{
    sql: utl..udf_percent_var(${room_adr},${budg_adr}) ;;
    label: "ADR Act:Bdgt - % var"
    description: "(TY - Bdgt)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }

  measure:  adr_var_perc_fcst{
    sql: utl..udf_percent_var(${room_adr},${act_fcst_adr}) ;;
    label: "ADR Act:Fcst - % var"
    description: "(TY - Fcst)/TY"
    view_label: "  TY"
    type: number
    value_format_name: percent_1
  }


  #-------------------------------------------------------------------------------------------
  #-- # Vairance
  #-------------------------------------------------------------------------------------------
  measure:  roomrev_var_ly{
    sql: (${room_rev} - ifnull(${room_rev_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Act:STLY - var"
    description: "(TY - LY)"
  }

  measure:  roomrev_var_budg{
    sql: (${room_rev} - ifnull(${budg_roomrev},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Act:Bdgt - var"
    description: "(TY - Bdgt)"
  }

  measure:  roomrev_var_fcst{
    sql: (${room_rev} - ifnull(${act_fcst_roomrev},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Act:Fcst - var"
    description: "(TY - Fcst)"
  }

  measure:  roomsold_var_ly{
    sql: (${roomsold} - ifnull(${roomsold_stly},0)) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  roomsold_var_budg{
    sql: (${roomsold} - ifnull(${budg_roomsold},0)) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Act:Fcst - var"
    description: "(TY - Fcst)"
  }

  measure:  roomsold_var_fcst{
    sql: (${roomsold} -ifnull( ${act_fcst_roomsold},0)) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Act:Bdgt - var"
    description: "(TY - Bdgt)"
  }

  measure:  adr_var_ly{
    sql: (${room_adr} - ifnull(${room_adr_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Act:STLY - var"
    description: "(TY - STLY)"
  }

  measure:  adr_var_budg{
    sql: (${room_adr} - ifnull(${budg_adr},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Act:Fcst - var"
    description: "(TY - Fcst)"
  }

  measure:  adr_var_fcst{
    sql: (${room_adr} - ifnull(${act_fcst_adr},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Act:Bdgt - var"
    description: "(TY - Bdgt)"
  }

  #-------------------------------------------------------------------------------------------
  #-- # STLY Pickup
  #-------------------------------------------------------------------------------------------
  measure:  roomrev_pickup_stly{
    sql: (${room_rev_ly} - ifnull(${room_rev_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Pickup LY:STLY - var"
    description: "(Act:LY - STLY)"
  }

  measure:  roomsold_pickup_stly{
    sql: (${roomsold_ly} - ifnull(${roomsold_stly},0)) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Sold Pickup LY:STLY - var"
    description: "(Act:LY - STLY)"
  }

  measure:  adr_pickup_stly{
    sql: (${room_adr_ly} - ifnull(${room_adr_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Pickup LY:STLY - var"
    description: "(Act:LY - STLY)"
  }

  #-------------------------------------------------------------------------------------------
  #-- # Reach
  #-------------------------------------------------------------------------------------------
  measure:  roomrev_reach_stly{
    sql: (${roomrev_var_ly} + ifnull(${roomrev_pickup_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Reach STLY:STLY - pickup"
    description: "((Act-STLY) + STLY Pickup)"
  }

  measure:  roomrev_reach_budget{
    sql: (${roomrev_var_budg} + ifnull(${roomrev_pickup_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Reach Bdgt:STLY - pickup"
    description: "((Act -Bdgt) + STLY Pickup)"
  }

  measure:  roomrev_reach_fcst{
    sql: (${roomrev_var_fcst} + ifnull(${roomrev_pickup_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "Rev Rms $ Reach Fcst:STLY - pickup"
    description: "((Act -Fcst) + STLY Pickup)"
  }

  measure:  roomsold_reach_stly{
    sql: (${roomsold_var_ly} + ifnull(${roomsold_pickup_stly},0)) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Reach STLY:STLY - pickup"
    description: "((Act-STLY) + STLY Pickup)"
  }

  measure:  roomsold_reach_budget{
    sql: (${roomsold_var_budg} + ifnull(${roomsold_pickup_stly},0)) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Reach Bdgt:STLY - pickup"
    description: "((Act -Bdgt) + STLY Pickup)"
  }

  measure:  roomsold_reach_fcst{
    sql: (${roomsold_var_fcst} + ifnull(${roomsold_pickup_stly},0)) ;;
    type: number
    value_format_name: decimal_0
    view_label: "  TY"
    label: "Rms Bkd Reach Fcst:STLY - pickup"
    description: "((Act -Fcst) + STLY Pickup)"
  }

  measure:  adr_reach_stly{
    sql: (${adr_var_ly} + ifnull(${adr_pickup_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Reach STLY:STLY - pickup"
    description: "((Act-STLY) + STLY Pickup)"
  }

  measure:  adr_reach_budget{
    sql: (${adr_var_budg} + ifnull(${adr_pickup_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Reach Bdgt:STLY - pickup"
    description: "((Act -Bdgt) + STLY Pickup)"
  }

  measure:  adr_reach_fcst{
    sql: (${adr_var_fcst} + ifnull(${adr_pickup_stly},0)) ;;
    type: number
    value_format_name: usd_0
    view_label: "  TY"
    label: "ADR Reach Fcst:STLY - pickup"
    description: "((Act -Fcst) + STLY Pickup)"
  }

  #-------------------------------------------------------------------------------------------
  #-- # Reach Variance
  #-------------------------------------------------------------------------------------------


  measure:  roomrev_reach_fcst_perc{
    sql: utl..udf_percent_var((${roomrev_var_fcst}),${roomrev_reach_fcst}) -1   ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "Rev Rms $ Reach Fcst:STLY % - pickup"
    description: "((Act -Fcst) + STLY Pickup)"
  }

  measure:  roomrev_reach_budg_perc{
    sql: utl..udf_percent_var((${roomrev_var_budg}),${roomrev_reach_budget}) -1  ;;
    type: number
    value_format_name: percent_1
    view_label: "  TY"
    label: "Rev Rms $ Reach Budg:STLY % - pickup"
    description: "((Act -Fcst) + STLY Pickup)"
  }

}
