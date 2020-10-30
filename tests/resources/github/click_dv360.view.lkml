view: click_dv360 {
  ######################################
  ## DV360 METRICS ---> Start
  ######################################

  dimension: dbm_ad_position {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Ad_Position ;;
  }

  dimension: dbm_advertiser_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Advertiser_ID ;;
  }

  dimension: dbm_adx_page_categories {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Adx_Page_Categories ;;
  }

  dimension: dbm_attributed_inventory_source_external_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Attributed_Inventory_Source_External_ID ;;
  }

  dimension: dbm_attributed_inventory_source_is_public {
    view_label: "DV360"
    type: yesno
    sql: ${TABLE}.DBM_Attributed_Inventory_Source_Is_Public ;;
  }

  dimension: dbm_auction_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Auction_ID ;;
  }

  dimension: dbm_bid_price_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Bid_Price_Advertiser_Currency ;;
  }

  dimension: dbm_bid_price_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Bid_Price_Partner_Currency ;;
  }

  dimension: dbm_bid_price_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Bid_Price_USD ;;
  }

  dimension: dbm_billable_cost_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Billable_Cost_Advertiser_Currency ;;
  }

  dimension: dbm_billable_cost_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Billable_Cost_Partner_Currency ;;
  }

  dimension: dbm_billable_cost_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Billable_Cost_USD ;;
  }

  dimension: dbm_browser_platform_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Browser_Platform_ID ;;
  }

  dimension: dbm_browser_timezone_offset_minutes {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Browser_Timezone_Offset_Minutes ;;
  }

  dimension: dbm_city_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_City_ID ;;
  }

  dimension: dbm_country_code {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Country_Code ;;
  }

  dimension: dbm_cpm_fee_1_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_1_Advertiser_Currency ;;
  }

  dimension: dbm_cpm_fee_1_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_1_Partner_Currency ;;
  }

  dimension: dbm_cpm_fee_1_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_1_USD ;;
  }

  dimension: dbm_cpm_fee_2_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_2_Advertiser_Currency ;;
  }

  dimension: dbm_cpm_fee_2_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_2_Partner_Currency ;;
  }

  dimension: dbm_cpm_fee_2_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_2_USD ;;
  }

  dimension: dbm_cpm_fee_3_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_3_Advertiser_Currency ;;
  }

  dimension: dbm_cpm_fee_3_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_3_Partner_Currency ;;
  }

  dimension: dbm_cpm_fee_3_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_3_USD ;;
  }

  dimension: dbm_cpm_fee_4_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_4_Advertiser_Currency ;;
  }

  dimension: dbm_cpm_fee_4_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_4_Partner_Currency ;;
  }

  dimension: dbm_cpm_fee_4_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_4_USD ;;
  }

  dimension: dbm_cpm_fee_5_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_5_Advertiser_Currency ;;
  }

  dimension: dbm_cpm_fee_5_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_5_Partner_Currency ;;
  }

  dimension: dbm_cpm_fee_5_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_CPM_Fee_5_USD ;;
  }

  dimension: dbm_creative_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Creative_ID ;;
  }

  dimension: dbm_data_fees_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Data_Fees_Advertiser_Currency ;;
  }

  dimension: dbm_data_fees_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Data_Fees_Partner_Currency ;;
  }

  dimension: dbm_data_fees_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Data_Fees_USD ;;
  }

  dimension: dbm_designated_market_area_dma_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Designated_Market_Area_DMA_ID ;;
  }

  dimension: dbm_device_type {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Device_Type ;;
  }

  dimension: DBM_Device_Type_Name {
    view_label: "DV360"
    type: string
    sql: CASE
          WHEN DBM_Device_Type=0 THEN "Computer"
          WHEN DBM_Device_Type=1 THEN "Other"
          WHEN DBM_Device_Type=2 THEN "Smartphone"
          WHEN DBM_Device_Type=3 THEN "Tablet"
          WHEN DBM_Device_Type=4 THEN "Smart TV"
          ELSE 'Unknown'
         END ;;
  }

  dimension: dbm_exchange_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Exchange_ID ;;
  }

  dimension: dbm_insertion_order_id {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Insertion_Order_ID ;;
  }

  dimension: dbm_isp_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_ISP_ID ;;
  }

  dimension: dbm_language {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Language ;;
  }

  dimension: dbm_line_item_id {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Line_Item_ID ;;
  }

  dimension: dbm_matching_targeted_keywords {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Matching_Targeted_Keywords ;;
  }

  dimension: dbm_matching_targeted_segments {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Matching_Targeted_Segments ;;
  }

  dimension: dbm_media_cost_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Cost_Advertiser_Currency ;;
  }

  dimension: dbm_media_cost_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Cost_Partner_Currency ;;
  }

  dimension: dbm_media_cost_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Cost_USD ;;
  }

  dimension: dbm_media_fee_1_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_1_Advertiser_Currency ;;
  }

  dimension: dbm_media_fee_1_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_1_Partner_Currency ;;
  }

  dimension: dbm_media_fee_1_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_1_USD ;;
  }

  dimension: dbm_media_fee_2_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_2_Advertiser_Currency ;;
  }

  dimension: dbm_media_fee_2_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_2_Partner_Currency ;;
  }

  dimension: dbm_media_fee_2_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_2_USD ;;
  }

  dimension: dbm_media_fee_3_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_3_Advertiser_Currency ;;
  }

  dimension: dbm_media_fee_3_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_3_Partner_Currency ;;
  }

  dimension: dbm_media_fee_3_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_3_USD ;;
  }

  dimension: dbm_media_fee_4_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_4_Advertiser_Currency ;;
  }

  dimension: dbm_media_fee_4_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_4_Partner_Currency ;;
  }

  dimension: dbm_media_fee_4_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_4_USD ;;
  }

  dimension: dbm_media_fee_5_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_5_Advertiser_Currency ;;
  }

  dimension: dbm_media_fee_5_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_5_Partner_Currency ;;
  }

  dimension: dbm_media_fee_5_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Media_Fee_5_USD ;;
  }

  dimension: dbm_mobile_make_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Mobile_Make_ID ;;
  }

  dimension: dbm_mobile_model_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Mobile_Model_ID ;;
  }

  dimension: dbm_net_speed {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Net_Speed ;;
  }

  dimension: dbm_operating_system_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Operating_System_ID ;;
  }

  dimension: dbm_request_time {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Request_Time ;;
  }

  dimension: dbm_revenue_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Revenue_Advertiser_Currency ;;
  }

  dimension: dbm_revenue_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Revenue_Partner_Currency ;;
  }

  dimension: dbm_revenue_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Revenue_USD ;;
  }

  dimension: dbm_site_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_Site_ID ;;
  }

  dimension: dbm_state_region_id {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_State_Region_ID ;;
  }

  dimension: dbm_total_media_cost_advertiser_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Total_Media_Cost_Advertiser_Currency ;;
  }

  dimension: dbm_total_media_cost_partner_currency {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Total_Media_Cost_Partner_Currency ;;
  }

  dimension: dbm_total_media_cost_usd {
    view_label: "DV360"
    type: number
    sql: ${TABLE}.DBM_Total_Media_Cost_USD ;;
  }

  dimension: dbm_url {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_URL ;;
  }

  dimension: dbm_zip_postal_code {
    view_label: "DV360"
    type: string
    sql: ${TABLE}.DBM_ZIP_Postal_Code ;;
  }

  ######################################
  ## End <--- DV360 METRICS
  ######################################

}
