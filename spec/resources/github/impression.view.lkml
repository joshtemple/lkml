include: "date_comparison.view.lkml"
include: "/views/dv360/impression_dv360.view"
include: "//@{CONFIG_PROJECT_NAME}/views/impression.view"

########### PRESENTATION LAYER ###########
view:  impression {
  extends: [impression_config, impression_dv360]
}


########### CORE LAYER ###########
view: impression_core {
  sql_table_name: `@{PROJECT_NAME}.@{DATASET_NAME}.p_impression_@{CAMPAIGN_MANAGER_ID}` ;;
  extends: [date_comparison, impression_dv360]

  dimension_group: impression {
    type: time
    timeframes: [raw, date, week, day_of_week, month, month_name, quarter, year]
    sql: ${TABLE}._PARTITIONTIME ;;
  }

  measure: active_view_eligible_impressions {
    type: sum
    sql: ${TABLE}.Active_View_Eligible_Impressions ;;
  }

  dimension: pk {
    type: string
    sql: concat(${ad_id}, ${advertiser_id}, ${user_id}, cast(${TABLE}.Event_Time as string), ${event_type}, ${rendering_id}) ;;
    hidden: yes
    primary_key: yes
  }

  #match_table_ads
  dimension: ad_id {
    type: string
    view_label: "Ads"
    sql: ${TABLE}.Ad_ID ;;
  }

  #match_table_advertisers
  dimension: advertiser_id {
    view_label: "Advertisers"
    type: string
    sql: ${TABLE}.Advertiser_ID ;;
    link: {
      label: "View in Campaign Manager"
      icon_url: "https://seeklogo.com/images/G/google-campaign-manager-logo-03026740FA-seeklogo.com.png"
      url: "https://www.google.com/dfa/trafficking/#/accounts/@{CAMPAIGN_MANAGER_ID}/advertisers/{{value}}/explorer?"
    }
  }

  dimension: browser_platform_id {
    type: string
    sql: ${TABLE}.Browser_Platform_ID ;;
  }

  dimension: browser_platform_version {
    type: string
    sql: ${TABLE}.Browser_Platform_Version ;;
  }

  #match_table_campaigns
  dimension: campaign_id {
    view_label: "Campaigns"
    type: string
    sql: ${TABLE}.Campaign_ID ;;
    link: {
      label: "Campaign Performance Dashboard"
      url: "/dashboards-next/campaign_manager::3_campaign_overview?Campaign%20ID={{value}}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    link: {
      label: "View in Campaign Manager"
      icon_url: "https://seeklogo.com/images/G/google-campaign-manager-logo-03026740FA-seeklogo.com.png"
      url: "https://www.google.com/dfa/trafficking/#/accounts/@{CAMPAIGN_MANAGER_ID}/campaigns/{{value}}/explorer?"
    }
  }

  #match_table_cities
  dimension: city_id {
    type: string
    sql: ${TABLE}.City_ID ;;
  }

  dimension: country_code {
    map_layer_name: countries
    sql: CASE WHEN ${TABLE}.Country_Code = 'UK' THEN 'GB' ELSE ${TABLE}.Country_Code END ;;
    drill_fields: [state_region,zip_postal_code]
  }

  dimension: creative_version {
    type: number
    sql: ${TABLE}.Creative_Version ;;
  }

  dimension: designated_market_area_dma_id {
    type: string
    sql: ${TABLE}.Designated_Market_Area_DMA_ID ;;
  }

  dimension: event_sub_type {
    type: string
    sql: ${TABLE}.Event_Sub_Type ;;
  }

  dimension_group: event {
    type: time
    timeframes: [raw, date, hour,week, day_of_week, month, month_name, quarter, year]
    datatype: epoch
    sql: CAST(${TABLE}.Event_Time/1000000 as INT64) ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.Event_Type ;;
  }

  dimension: operating_system_id {
    type: string
    sql: ${TABLE}.Operating_System_ID ;;
  }

  dimension: operating_system_id_key {
    type: number
    sql: IF(CAST(${operating_system_id} AS INT64) > 22,
       CAST(${operating_system_id} AS INT64),
       POWER(2,CAST(${operating_system_id} AS INT64))) ;;

    }

    dimension: partner1_id {
      type: string
      sql: ${TABLE}.Partner1_ID ;;
    }

    dimension: partner2_id {
      type: string
      sql: ${TABLE}.Partner2_ID ;;
    }

    dimension: placement_id {
      type: string
      sql: ${TABLE}.Placement_ID ;;
    }

    dimension: rendering_id {
      type: string
      sql: ${TABLE}.Rendering_ID ;;
    }

    dimension: site_id_dcm {
      type: string
      sql: ${TABLE}.Site_ID_DCM ;;
    }

    dimension: state_region {
      map_layer_name: us_states
      sql: ${TABLE}.State_Region ;;
      drill_fields: [zip_postal_code]
    }

    dimension: u_value {
      type: string
      sql: ${TABLE}.U_Value ;;
    }

    dimension: user_id {
      type: string
      sql: ${TABLE}.User_ID ;;
    }

    dimension: zip_postal_code {
      type: zipcode
      sql: ${TABLE}.ZIP_Postal_Code ;;
      map_layer_name: us_zipcode_tabulation_areas
    }


    ### MEASURES

    measure: count_impressions {
      type: count_distinct
      sql: ${pk} ;;
      drill_fields: [campaign_id, site_id_dcm]
      value_format:"[<1000]0.00;[<1000000]0.00,\" K\";0.00,,\" M\""
    }

    measure: active_view_measurable_impressions {
      type: sum
      sql: ${TABLE}.Active_View_Measurable_Impressions ;;
      value_format:"[<1000]0.00;[<1000000]0.00,\" K\";0.00,,\" M\""
    }

    measure: active_view_viewable_impressions {
      type: sum
      sql: ${TABLE}.Active_View_Viewable_Impressions ;;
      value_format:"[<1000]0.00;[<1000000]0.00,\" K\";0.00,,\" M\""
    }

    measure: count {
      type: count
      drill_fields: [match_table_campaigns.campaign_name, site_id_dcm, impressions_per_user]
      value_format:"[<1000]0.00;[<1000000]0.00,\" K\";0.00,,\" M\""
    }

    measure: distinct_users {
      label: "Reach Count"
      type: count_distinct
      sql: ${user_id} ;;
      drill_fields: [match_table_campaigns.campaign_name, site_id_dcm, impressions_per_user]
      value_format:"[<1000]0.00;[<1000000]0.00,\" K\";0.00,,\" M\""
    }

    measure: reach_percentage {
      type: number
      sql: 1.0*${distinct_users}/NULLIF(${count},0) ;;
      value_format_name: percent_2
    }

    measure: average_frequency {
      type: number
      sql: 1.0*${count}/${distinct_users} ;;
      value_format_name: decimal_2
    }

    measure: campaign_count {
      type: count_distinct
      sql: ${campaign_id} ;;
      drill_fields: [match_table_campaigns.campaign_name, count, distinct_users, impressions_per_user]
      value_format:"[<1000]0.00;[<1000000]0.00,\" K\";0.00,,\" M\""
    }

    measure: impressions_per_user {
      type: number
      sql: ${count_impressions}/NULLIF(${distinct_users},0) ;;
      value_format_name: decimal_1
      drill_fields: [match_table_campaigns.campaign_name, site_id_dcm]
    }

    measure: ad_count {
      type: count_distinct
      sql: ${ad_id} ;;
      drill_fields: [match_table_ads.ad_name, match_table_ads.ad_type, count, distinct_users]
      value_format:"[<1000]0.00;[<1000000]0.00,\" K\";0.00,,\" M\""
    }

  }
