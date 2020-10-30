view: inntopia_res_property_f {
  sql_table_name: pedw.dev.inntopia_res_property_f ;;

  #-------------------------------------------------------------------------------------------
  #-- Keys
  #-------------------------------------------------------------------------------------------

  dimension: primary_key {
    primary_key: yes
    sql: ${TABLE}.primary_key ;;
    hidden: yes
  }

  dimension: reservation_key {
    sql: ${TABLE}.reservation_key ;;
    hidden: yes
  }

  dimension: stay_date_key {
    sql: ${TABLE}.stay_date_key ;;
    hidden: yes
  }

  dimension: propertykey{
    type: number
    sql: ${TABLE}.propertykey ;;
    hidden: yes
  }

  dimension: booking_date_sid {
    type: number
    sql: ${TABLE}.bookingdate_sid ;;
    hidden: yes
  }

  dimension: arrival_date_sid {
    type: number
    sql: ${TABLE}.arrivaldate_sid ;;
    hidden: yes
  }

  dimension: departure_date_sid {
    type: number
    sql: ${TABLE}.departuredate_sid ;;
    hidden: yes
  }

  dimension: stay_date_sid {
    type: number
    sql: ${TABLE}.stay_dt_sid ;;
    hidden: yes
    }

  dimension: cancellation_date_sid {
    type: number
    sql: ${TABLE}.cancellationdate_sid ;;
    hidden: yes
  }

  #-------------------------------------------------------------------------------------------
  #-- dimensions
  #-------------------------------------------------------------------------------------------

  dimension: booking_dt {
    type: date
    sql: ${TABLE}.booking_dt ;;
    hidden: yes
  }

  dimension: arrival_dt {
    type: date
    sql: ${TABLE}.arrival_dt ;;
    hidden: yes
  }

  dimension: departure_dt {
    type: date
    sql: ${TABLE}.departure_dt ;;
    hidden: yes
  }

  dimension: ty_bt {
    type: number
    sql: ${TABLE}.ty_bt ;;
    hidden: yes
  }

  dimension: ly_bt {
    type: number
    sql: ${TABLE}.ly_bt ;;
    hidden: yes
  }

  dimension: customerkey {
    type: number
    sql: ${TABLE}.customer_key ;;
    hidden: yes
  }

  dimension: market_segment_name {
    view_label: "Room"
    label: "Macro Market Segment Name"
    description: "Report Market Segment"
    type: string
    sql: ${TABLE}.report_marketsegment ;;
  }

  dimension: micro_market_segment_name {
    view_label: "Room"
    label: "Micro Market Segment Name"
    description: "Market Segment Description"
    type: string
    sql: ${TABLE}.market_segment_description ;;
  }

  dimension: sub_source_channel_name {
    view_label: "Room"
    label: "Source Channel Description"
    description: "Source of Business Description"
    type: string
    sql: ${TABLE}.source_of_business_description ;;
  }
  dimension: source_channel_name {
    view_label: "Room"
    label: "Source Channel Group"
    description: "Source of Business Group"
    type: string
    sql: ${TABLE}.source_of_business_group ;;
  }

  dimension: room_type_name {
    view_label: "Room"
    label: "Room Type"
    description: "Unit Type"
    type: string
    sql: ${TABLE}.unit_type ;;
  }

  dimension: room_to_charge_name {
    view_label: "Room"
    label: "Room To Charge"
    description: "Room Type to Charge"
    type: string
    sql: ${TABLE}.price_basis ;;
  }

  dimension: rate_plan_description {
    view_label: "Room"
    label: "Rate Code"
    description: "Rate Plan Description"
    type: string
    sql: ${TABLE}.rate_plan_description ;;
  }

  dimension: agency_name {
    view_label: "Room"
    label: "Agency Name"
    description: "Agency Name"
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: group_name {
    view_label: "Room"
    label: "Company Name"
    description: "Group Name"
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: iata_no{
    view_label: "Room"
    label: "Iata Number"
    description: "Iata Number"
    type: string
    sql: ${TABLE}.iata_number ;;
  }
  dimension: avg_daily_rate {
    type: number
    sql: ${TABLE}.avg_daily_rate ;;
    hidden: yes
  }

  dimension: room_number{
    view_label: "Room"
    label: "Room Number"
    description: "Room Number"
    type: string
    sql: ${TABLE}.room_number ;;
  }

  dimension: reservation_status{
    view_label: "Room"
    label: "Reservation Status"
    description: "Reservation Status"
    type: string
    sql: ${TABLE}.level ;;
  }

  dimension: agency_location{
    view_label: "Room"
    label: "Agency Location"
    description: "Agency Location"
    type: string
    sql: ${TABLE}.agency_location ;;
  }


}
