view: property_dm {
  sql_table_name: pedw.fact.PROPERTY_DM ;;

  dimension: property_key {
    label: "Property Key PMD"
    description: "Property Code within PMD."
    primary_key: yes
    type: number
    sql: ${TABLE}.PROPERTY_KEY ;;
    hidden: no
  }

  dimension: property_name_sort {
    type: string
    sql: ${TABLE}.property_name_sort  ;;
    hidden: yes
  }

  dimension: property_name {
    label: "Property"
    description: "Name of property."
    type: string
    sql: ${TABLE}.PROPERTY_NAME ;;
    drill_fields: [property_ds*]
    order_by_field: property_name_sort

    link: {
      label: "Website"
      url: "http://www.google.com/search?q={{ value | encode_uri }}+about&btnI"
      icon_url: "http://www.google.com/s2/favicons?domain={{ value }}"
    }

#     link: {
#       label: "{{value}} Analytics Dashboard"
#       url: "/dashboards/3?Property%20Name={{ value | encode_uri }}"
#       icon_url: "http://www.looker.com/favicon.ico"
#     }

  }

  dimension: marketing_name {
    label: "Marketing Name"
    type: string
    sql: ${TABLE}.MARKETING_NAME ;;
    drill_fields: [property_ds*]
  }

  dimension: management_company_name {
    label: "Management Company"
    description: "Name of company managing the property."
    type: string
    sql: ${TABLE}.management_company_name ;;
  }

  dimension: brand_cd {
    label: "Brand Abbreviation"
    description: "Abbreviation of brand name."
    type: string
    sql: ${TABLE}.brand_cd ;;
  }

  dimension: brand_name {
    label: "Brand Name"
    description: "Property brand name."
    type: string
    sql: ${TABLE}.brand_name ;;
    drill_fields: [property_ds*]
  }

  dimension: full_address {
    label: "Full Address"
    description: "Property address includng city/state/zip."
    type: string
    sql: concat(concat(concat(concat(concat(concat(${TABLE}.ADDRESS,' '),${TABLE}.CITY_NAME),' ,'),${TABLE}.STATE_PROVINCE_CD),' '),${TABLE}.ZIP_CD) ;;
  }

  dimension: address {
    label: "Address"
    description: "Property address."
    type: string
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: city_name {
    label: "City"
    description: "Property city."
    type: string
    sql: ${TABLE}.CITY_NAME ;;
    drill_fields: [property_ds*]
  }

  dimension: state_province_cd {
    label: "State/Province Abbreviation"
    description: "Property State/Province abbreviation."
    type: string
    sql: ${TABLE}.STATE_PROVINCE_CD ;;
  }

  dimension: state_province_name {
    label: "State/Province"
    description: "Property State/Province."
    type: string
    sql: ${TABLE}.STATE_PROVINCE_NAME ;;
    drill_fields: [property_ds*]
  }

  dimension: zip_cd {
    label: "Zip Code"
    description: "Property zip code"
    type: string
    sql: ${TABLE}.ZIP_CD ;;
    drill_fields: [property_ds*]
  }

  dimension: property_lat {
    type: number
    sql: ${TABLE}.latitude ;;
    hidden: yes
  }

  dimension: property_long {
    type: number
    sql: ${TABLE}.longitude ;;
    hidden: yes
  }

  dimension: property_location {
    label: "Lat/Long"
    description: "Property location."
    type: location
    sql_latitude: ${property_lat} ;;
    sql_longitude: ${property_long} ;;
  }

  dimension: country_name {
    label: "Country"
    description: "Property country."
    type: string
    sql: ${TABLE}.COUNTRY_NAME ;;
    drill_fields: [property_ds*]
  }

  dimension: region_name {
    label: "Region"
    description: "Property region."
    type: string
    sql: ${TABLE}.REGION_NAME ;;
    drill_fields: [property_ds*]
  }

  dimension: location_type_name {
    label: "Location Type"
    description: "Type of property location."
    type: string
    sql: ${TABLE}.location_type_name ;;
  }

  dimension: ownership_group_name {
    label: "Ownership Group"
    description: "Property owner."
    type: string
    sql: ${TABLE}.ownership_group_name ;;
  }

  dimension: meeting_space_indoor_square_feet_amt {
    view_label: " Property Stats"
    label: "Meeting Spuare Feet - Indoor"
    description: "Indoor meeting space square footage."
    type: number
    sql: ${TABLE}.MEETING_SPACE_INDOOR_SQUARE_FEET_AMT ;;
  }

  dimension: meeting_space_outdoor_square_feet_amt {
    view_label: " Property Stats"
    label: "Meeting Spuare Feet - Outdoor"
    description: "Outdoor meeting space square footage."
    type: number
    sql: ${TABLE}.MEETING_SPACE_OUTDOOR_SQUARE_FEET_AMT ;;
  }

  dimension: total_meeting_space_square_feet_amt {
    view_label: " Property Stats"
    label: "Meeting Spuare Feet - Indoor/Outdoor"
    description: "Outdoor meeting space square footage."
    type: number
    sql: ${TABLE}.TOTAL_MEETING_SPACE_SQUARE_FEET_AMT ;;
  }

  dimension: room_cnt {
    view_label: " Property Stats"
    label: "Rms"
    description: "Number of rooms."
    type: number
    sql: ${TABLE}.ROOM_CNT ;;
  }

  dimension: spa_square_feet_amt {
    view_label: " Property Stats"
    label: "Spa - Square Feet "
    description: "Spa square footage."
    type: number
    sql: ${TABLE}.SPA_SQUARE_FEET_AMT ;;
  }

  dimension: treatment_rooms_cnt {
    view_label: " Property Stats"
    label: "Spa - Treatment Rms"
    description: "Number of treatment rooms."
    type: number
    sql: ${TABLE}.TREATMENT_ROOM_CNT ;;
  }

  dimension: rooftop_cnt {
    view_label: " Property Stats"
    label: "Outlet Rooftop"
    description: "Number of rooftops."
    type: number
    sql: ${TABLE}.ROOFTOP_CNT ;;
  }

  dimension: golfclubhouse_cnt {
    view_label: " Property Stats"
    label: "Golf Clubhouses"
    description: "Number of golf clubhouses."
    type: number
    sql: ${TABLE}.GOLFCLUBHOUSE_CNT ;;
  }

  dimension: golfcourse_cnt {
    view_label: " Property Stats"
    label: "Golf Courses"
    description: "Number of golf courses."
    type: number
    sql: ${TABLE}.GOLFCOURSE_CNT ;;
  }

  dimension:  restaurant_cnt {
    view_label: " Property Stats"
    label: "Outlet Restaurants"
    description: "Number of restaurants."
    type: number
    sql: ${TABLE}.RESTAURANT_CNT ;;
  }

  dimension: bar_lounge_cnt {
    view_label: " Property Stats"
    label: "Outlet Bars/Lounges"
    description: "Number of bars or lounges."
    type: number
    sql: ${TABLE}.BAR_LOUNGE_CNT ;;
  }

  dimension: poolside_cnt {
    view_label: " Property Stats"
    label: "Outlet Poolsides"
    description: "Number of poolsides."
    type: number
    sql: ${TABLE}.POOLSIDE_CNT ;;
  }

  dimension: cafe_cnt {
    view_label: " Property Stats"
    label: "Outlet Cafes"
    description: "Number of cafes."
    type: number
    sql: ${TABLE}.CAFE_CNT ;;
  }

  dimension: total_outlet_cnt {
    view_label: " Property Stats"
    label: "Outlets"
    description: "Number of total outlets."
    type: number
    sql: ${TABLE}.TOTAL_OUTLET_CNT ;;
  }

  dimension: four_diamond_amt {
    label: "Diamond Rating"
    description: "Diamond rating."
    type: number
    sql: ${TABLE}.FOUR_DIAMOND_AMT ;;
  }

  dimension: five_star_amt {
    label: "Star Rating"
    description: "Star rating."
    type: number
    sql: ${TABLE}.FIVE_STAR_AMT ;;
  }

  dimension: evp_full_last_first {
    label: "Regional Ops Leader"
    description: "Regoinal operations leader."
    type: string
    sql: ${TABLE}.regional_ops_ldr_full_name ;;
    drill_fields: [property_ds*]
  }

  dimension: regional_fnc_ldr_full_name {
    label: "Regional Fnc Leader"
    description: "Regional financial leader."
    type: string
    sql: ${TABLE}.regional_fnc_ldr_full_name ;;
    drill_fields: [property_ds*]
  }

  dimension: regional_rev_mngr_full_name {
    label: "Regional Rev Mngr"
    description: "Regional Revenue Manager."
    type: string
    sql: ${TABLE}.regional_rm_ldr_full_name ;;
    drill_fields: [property_ds*]
  }

  dimension: regional_sales_ldr_full_name {
    label: "Regional Sales Leader"
    description: "Regional Sales Leader."
    type: string
    sql: ${TABLE}.regional_sales_ldr_full_name ;;
    drill_fields: [property_ds*]
  }

  dimension: phone_no {
    label: "Phone Number"
    description: "Property phone number."
    type: string
    sql: ${TABLE}.PHONE_NO ;;
  }

  dimension: website_url {
    label: "Website URL"
    description: "Property website URL."
    type: string
    sql: ${TABLE}.WEBSITE_URL ;;
    html: <a href="{{value}}">{{value}}</a> ;;
  }

  dimension: opening_dt {
    label: "Opening Date"
    description: "Property opening date."
    type: date
    sql: ${TABLE}.opening_dt ;;
  }

  dimension: transition_dt {
    label: "Transition Date"
    description: "Property transition date."
    type: date
    sql: ${TABLE}.transition_dt ;;
  }

  dimension: disposition_dt {
    label: "Disposition Date"
    description: "Property outgoing transition date."
    type: date
    sql: ${TABLE}.disposition_dt ;;
  }

  dimension: same_store_financial_fl {
    label: "Same Store Financial"
    description: "Indication of same store financials property."
    type: yesno
    sql: ${TABLE}.same_store_financial_bt = 1 ;;
  }

  dimension: same_store_revenue_fl {
    label: "Same Store Revenue"
    description: "Indication of same store revenue property."
    type: yesno
    sql: ${TABLE}.same_store_revenue_bt = 1 ;;
  }

  dimension: closed_fl {
    label: "Closed"
    description: "Indication of closed property."
    type: yesno
    sql: ${TABLE}.closed_bt = 1 ;;
  }

  dimension: active_fl {
    label: "Active"
    description: "Indication of active property."
    type: yesno
    sql: ${TABLE}.active_bt = 1 ;;
  }

  dimension: mih_eligible_fl {
    label: "MIH Eligible"
    description: "Indication of MIH eligible property."
    type: yesno
    sql: ${TABLE}.mih_eligible_bt = 1 ;;
  }

  dimension: union_workforce_bt {
    label: "Union Workforce"
    description: "Indication of Union workforce property."
    type: yesno
    sql: ${TABLE}.union_workforce_bt = 1 ;;
  }

  dimension: gl_entity_id {
    label: "GL Entities"
    description: "GL Entity."
    type: string
    sql: ${TABLE}.oracle_entity_str ;;
  }

  dimension: rbe_rpt_applicable_bt {
    label: "RBE Reporting"
    description: "Indication of inclusion in RBE reporting."
    type: yesno
    sql: ${TABLE}.rbe_rpt_applicable_bt = 1 ;;
  }

  dimension: tripadvisor_id {
    label: "Trip Advisor ID"
    description: "Trip Advisor ID."
    type: string
    sql: ${TABLE}.tripadvisor_id_str ;;
  }

  dimension: revinate_guest_id {
    label: "Revinate Guest ID"
    description: "Revinate Guest ID."
    type: string
    sql: ${TABLE}.revinate_guest_id_str ;;
  }

  dimension: revinate_meeting_id {
    label: "Revinate Meeting ID"
    description: "Revinate Meeting ID."
    type: string
    sql: ${TABLE}.revinate_meeting_id_str ;;
  }

  dimension: str_id {
    label: "STR #"
    description: "Smith Travel Census Number."
    type: string
    sql: ${TABLE}.str_id_str ;;
  }


#-----------------------------------------------------------------------------------------
# Measures
#-----------------------------------------------------------------------------------------

  measure: m_property_cnt {
    view_label: " Property Stats"
    label: "Ttl Property Count"
    description: "Total Property Count"
    type: count_distinct
    sql: ${TABLE}.PROPERTY_KEY ;;
    hidden: no
  }

  measure: m_meeting_space_indoor_square_feet_amt {
    view_label: " Property Stats"
    label: "Ttl Meeting - Square Feet - Indoor"
    description: "Total Summed Indoor meeting space square footage."
    type: sum
    sql: ${TABLE}.MEETING_SPACE_INDOOR_SQUARE_FEET_AMT ;;
  }

  measure: m_meeting_space_outdoor_square_feet_amt {
    view_label: " Property Stats"
    label: "Ttl Meeting Square Feet  - Outdoor"
    description: "Total Summed Outdoor meeting space square footage."
    type: sum
    sql: ${TABLE}.MEETING_SPACE_OUTDOOR_SQUARE_FEET_AMT ;;
  }

  measure: m_total_meeting_space_square_feet_amt {
    view_label: " Property Stats"
    label: "Ttl Meeting Square Feet - Indoor/Outdoor"
    description: "Total Summed Outdoor meeting space square footage."
    type: sum
    sql: ${TABLE}.TOTAL_MEETING_SPACE_SQUARE_FEET_AMT ;;
  }

  measure: m_room_cnt {
    view_label: " Property Stats"
    label: "Ttl Rms"
    description: "Total Summed Number of rooms."
    type: sum
    sql: ${TABLE}.ROOM_CNT ;;
  }

  measure: m_spa_square_feet_amt {
    view_label: " Property Stats"
    label: "Ttl Spa - Square Feet "
    description: "Total Summed Spa square footage."
    type: sum
    sql: ${TABLE}.SPA_SQUARE_FEET_AMT ;;
  }

  measure: m_treatment_rooms_cnt {
    view_label: " Property Stats"
    label: "Ttl Spa - Treatment Rms"
    description: "Total Summed Number of treatment rooms."
    type: sum
    sql: ${TABLE}.TREATMENT_ROOM_CNT ;;
  }

  measure: m_rooftop_cnt {
    view_label: " Property Stats"
    label: "Ttl Outlet Rooftop"
    description: "Total Summed Number of rooftops."
    type: sum
    sql: ${TABLE}.ROOFTOP_CNT ;;
  }

  measure: m_golfclubhouse_cnt {
    view_label: " Property Stats"
    label: "Golf - Clubhouses"
    description: "Total Summed Number of golf clubhouses."
    type: sum
    sql: ${TABLE}.GOLFCLUBHOUSE_CNT ;;
  }

  measure: m_golfcourse_cnt {
    view_label: " Property Stats"
    label: "Golf - Courses"
    description: "Total Summed Number of golf courses."
    type: sum
    sql: ${TABLE}.GOLFCOURSE_CNT ;;
  }

  measure:  m_restaurant_cnt {
    view_label: " Property Stats"
    label: "Ttl Outlet Restaurants"
    description: "Total Summed Number of restaurants."
    type: sum
    sql: ${TABLE}.RESTAURANT_CNT ;;
  }

  measure: m_bar_lounge_cnt {
    view_label: " Property Stats"
    label: "Ttl Outlet Bars/Lounges"
    description: "Total Summed Number of bars or lounges."
    type: sum
    sql: ${TABLE}.BAR_LOUNGE_CNT ;;
  }

  measure: m_poolside_cnt {
    view_label: " Property Stats"
    label: "Ttl Outlet Poolsides"
    description: "Total Summed Number of poolsides."
    type: sum
    sql: ${TABLE}.POOLSIDE_CNT ;;
  }

  measure: m_cafe_cnt {
    view_label: " Property Stats"
    label: "Ttl Outlet Cafes"
    description: "Total SummedNumber of cafes."
    type: sum
    sql: ${TABLE}.CAFE_CNT ;;
  }

  measure: m_total_outlet_cnt {
    view_label: " Property Stats"
    label: "Ttl Outlets"
    description: "Total Summed Number of total outlets."
    type: sum
    sql: ${TABLE}.TOTAL_OUTLET_CNT ;;
  }



 #   filters

#   filter: same_store_financial {
#     label: "Same Store Financial"
#     type: yesno
#     sql: ${TABLE}.same_store_financial_bt = 1 ;;
#   }
#
#   filter: same_store_revenue {
#     label: "Same Store Revenue"
#     type: yesno
#     sql: ${TABLE}.same_store_revenue_bt = 1 ;;
#   }
#
#   filter: closed {
#     label: "Closed"
#     type: yesno
#     sql: ${TABLE}.closed_bt = 1 ;;
#   }
#
#   filter: active {
#     label: "Active"
#     type: yesno
#     sql: ${TABLE}.active_bt = 1 ;;
#   }
#
#   filter: mih_eligible {
#     label: "MIH Eligible"
#     type: yesno
#     sql: ${TABLE}.mih_eligible_bt = 1 ;;
#   }

  filter: gl_entity_bt {
    label: "GL Entity"
    type: yesno
    sql: ${TABLE}.gl_entity_bt = 1 ;;
    hidden: yes
  }

  filter: management_company_name_bt {
    label: "Management Company"
    type: yesno
    sql: iff( ${TABLE}.management_company_name = 'CoralTree', 1, 0 ) = 1 ;;
    hidden: yes
  }


  # ----- Sets of fields for drilling ------
  set: property_ds {
    fields: [
      brand_name,
      property_name,
      ownership_group_name,
      marketing_name,
      evp_full_last_first,
      regional_fnc_ldr_full_name,
      regional_rev_mngr_full_name,
      regional_sales_ldr_full_name,
      region_name,
      state_province_name,
      city_name
    ]
  }
}
