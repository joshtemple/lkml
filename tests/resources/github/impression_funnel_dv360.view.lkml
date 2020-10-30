include: "//@{CONFIG_PROJECT_NAME}/views/dv360/*"

view: impression_pdt {
  derived_table: {
    datagroup_trigger: new_day
    sql: select TIMESTAMP_SECONDS(CAST(Event_Time/1000000 as INT64) ) as event_time
            , dbm_campaign_id as campaign_id

                , dbm_advertiser_id
                , dbm_insertion_order_id
                , dbm_line_item_id
                , dbm_site_id
                , dbm_exchange_id
                , dbm_auction_id
                , dbm_attributed_inventory_source_is_public
                --, dbm_matching_targeted_segments
                , IFNULL(dbm_designated_market_area_dma_id,'Unknown') as dbm_designated_market_area_dma_id
                , IFNULL(dbm_zip_postal_code,'Unknown') as dbm_zip_postal_code
                , IFNULL(DBM_Matching_Targeted_Segments, 'Unknown') as DBM_Matching_Targeted_Segments
                , IFNULL(DBM_Device_Type,-1) as DBM_Device_Type
                , IFNULL(DBM_Browser_Platform_ID,'Unknown') as DBM_Browser_Platform_ID
                , IFNULL(dbm_operating_system_id,'Unknown') as dbm_operating_system_id
                , SUM(dbm_revenue_usd) as total_revenue
                , count(*) as total_impressions
                -- sum(dbm_total_media_cost_usd) as total_media_cost
                -- TO DO: confirm we can use active view measureable impressions
                ,sum(active_view_viewable_impressions) as active_view_viewable_impressions
                ,sum(active_view_measurable_impressions) as active_view_measurable_impressions
                ,sum(active_view_eligible_impressions) as active_view_eligible_impression
            from ${impression.SQL_TABLE_NAME}
            where _PARTITIONTIME > TIMESTAMP(DATE_ADD(CURRENT_DATE, INTERVAL -@{HISTORICAL_DATA_DV360} DAY))
            and dbm_advertiser_id is not null

            group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
;;
  }
}

view: click_pdt {
  derived_table: {
    datagroup_trigger: new_day
    sql: select TIMESTAMP_SECONDS(CAST(Event_Time/1000000 as INT64) ) as event_time
          ,dbm_campaign_id as campaign_id
                      -- TO DO: THIS NEEDS TO CHANGE TO dbm_campaign_id
                      , dbm_advertiser_id
                      , dbm_insertion_order_id
                      , dbm_line_item_id
                      , dbm_site_id
                      , dbm_exchange_id
                      , dbm_auction_id
                      , dbm_attributed_inventory_source_is_public
                    -- , dbm_matching_targeted_segments
                      , IFNULL(dbm_designated_market_area_dma_id,'Unknown') as dbm_designated_market_area_dma_id
                      , IFNULL(dbm_zip_postal_code,'Unknown') as dbm_zip_postal_code
                      , IFNULL(DBM_Matching_Targeted_Segments, 'Unknown') as DBM_Matching_Targeted_Segments
                      , IFNULL(DBM_Device_Type,-1) as DBM_Device_Type
                      , IFNULL(DBM_Browser_Platform_ID,'Unknown') as DBM_Browser_Platform_ID
                     , IFNULL(dbm_operating_system_id,'Unknown') as dbm_operating_system_id
                      , count(*) as count_clicks
                  from ${click.SQL_TABLE_NAME}
                  where _PARTITIONTIME > TIMESTAMP(DATE_ADD(CURRENT_DATE, INTERVAL -@{HISTORICAL_DATA_DV360} DAY))
                  and dbm_advertiser_id is not null

                  group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
      ;;
  }
}

view: activity_pdt {
  derived_table: {
    datagroup_trigger: new_day
    sql: select
      TIMESTAMP_SECONDS(CAST(Event_Time/1000000 as INT64) ) as event_time
          , dbm_campaign_id as campaign_id
                      -- TO DO: THIS NEEDS TO CHANGE TO dbm_campaign_id
                      , dbm_advertiser_id
                      , dbm_insertion_order_id
                      , dbm_line_item_id
                      , dbm_site_id
                      , dbm_exchange_id
                      , dbm_auction_id
                      , dbm_attributed_inventory_source_is_public
                      --, dbm_matching_targeted_segments
                      , IFNULL(dbm_designated_market_area_dma_id,'Unknown') as dbm_designated_market_area_dma_id
                      , IFNULL(dbm_zip_postal_code,'Unknown') as dbm_zip_postal_code
                      , IFNULL(DBM_Matching_Targeted_Segments, 'Unknown') as DBM_Matching_Targeted_Segments
                      , IFNULL(DBM_Device_Type,-1) as DBM_Device_Type
                      , IFNULL(DBM_Browser_Platform_ID,'Unknown') as DBM_Browser_Platform_ID
                      , IFNULL(dbm_operating_system_id,'Unknown') as dbm_operating_system_id
                      , count(*) as count_conversions
                      from ${activity.SQL_TABLE_NAME}

                      where event_type = 'CONVERSION'
                    and _PARTITIONTIME > TIMESTAMP(DATE_ADD(CURRENT_DATE, INTERVAL -@{HISTORICAL_DATA_DV360} DAY))
                    and dbm_advertiser_id is not null

                      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
      ;;
  }
}


view: impression_funnel_dv360 {
  extends: [impression_funnel_dv360_config]
}

view: impression_funnel_dv360_core {
  extension: required
  derived_table: {
    datagroup_trigger: new_day
    partition_keys: ["event_time"]
    cluster_keys: ["event_type"]
    sql: SELECT *, GENERATE_UUID() as primary_key from (SELECT
          event_time
                  , campaign_id

                      , dbm_advertiser_id
                      , dbm_insertion_order_id
                      , dbm_line_item_id
                      , dbm_site_id
                      , dbm_exchange_id
                      , dbm_auction_id
                      , dbm_attributed_inventory_source_is_public
                      --, dbm_matching_targeted_segments
                      ,dbm_designated_market_area_dma_id
                      , dbm_zip_postal_code
                      ,DBM_Matching_Targeted_Segments
                      ,DBM_Device_Type
                      ,DBM_Browser_Platform_ID
                      ,dbm_operating_system_id
                      ,total_revenue
                      ,total_impressions
                      -- sum(dbm_total_media_cost_usd) as total_media_cost
                      -- TO DO: confirm we can use active view measureable impressions
                      , active_view_viewable_impressions
                      , active_view_measurable_impressions
                      , active_view_eligible_impression
                      , 'Impression' as event_type
                      , null as count_clicks
                      , null as count_conversions from ${impression_pdt.SQL_TABLE_NAME}
          UNION ALL
          SELECT  event_time
                  , campaign_id

                      , dbm_advertiser_id
                      , dbm_insertion_order_id
                      , dbm_line_item_id
                      , dbm_site_id
                      , dbm_exchange_id
                      , dbm_auction_id
                      , dbm_attributed_inventory_source_is_public
                      --, dbm_matching_targeted_segments
                      ,dbm_designated_market_area_dma_id
                      , dbm_zip_postal_code
                      ,DBM_Matching_Targeted_Segments
                      ,DBM_Device_Type
                      ,DBM_Browser_Platform_ID
                      ,dbm_operating_system_id
                      ,null as total_revenue
                      ,null as total_impressions
                      -- sum(dbm_total_media_cost_usd) as total_media_cost
                      -- TO DO: confirm we can use active view measureable impressions
                      , null as active_view_viewable_impressions
                      , null as active_view_measurable_impressions
                      , null as active_view_eligible_impression
                      ,'Click' as event_type
                      , count_clicks as count_clicks
                      , null as count_conversions
                      from ${click_pdt.SQL_TABLE_NAME}
          UNION ALL
          SELECT event_time
                  , campaign_id

                      , dbm_advertiser_id
                      , dbm_insertion_order_id
                      , dbm_line_item_id
                      , dbm_site_id
                      , dbm_exchange_id
                      , dbm_auction_id
                      , dbm_attributed_inventory_source_is_public
                      --, dbm_matching_targeted_segments
                      ,dbm_designated_market_area_dma_id
                      , dbm_zip_postal_code
                      ,DBM_Matching_Targeted_Segments
                      ,DBM_Device_Type
                      ,DBM_Browser_Platform_ID
                      ,dbm_operating_system_id
                      ,null as total_revenue
                      ,null as total_impressions
                      -- sum(dbm_total_media_cost_usd) as total_media_cost
                      -- TO DO: confirm we can use active view measureable impressions
                      , null as active_view_viewable_impressions
                      , null as active_view_measurable_impressions
                      , null as active_view_eligible_impression
                      ,'Conversion' as event_type
                      , null as count_clicks
                      , count_conversions as count_conversions
                      from ${activity_pdt.SQL_TABLE_NAME});;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.primary_key ;;
  }

  parameter: comparison_type {
    label: "Date Range"
    view_label: "Date Comparison"
    type: unquoted
    allowed_value: {
      label: "Last 7 Days"
      value: "seven"
    }
    allowed_value: {
      label: "Last 14 Days"
      value: "fourteen"
    }
    allowed_value: {
      label: "Last 30 Days"
      value: "thirty"
    }
    default_value: "seven"
  }

  dimension: selected_comparison {
    view_label: "Date Comparison"
    sql: {% if comparison_type._parameter_value == "seven" %}
          ${last_7_days_vs_previous_7_days}
          {% elsif comparison_type._parameter_value == "fourteen" %}
          ${last_14_days_vs_previous_14_days}
          {% elsif comparison_type._parameter_value == "thirty" %}
          ${last_30_days_vs_previous_30_days}
          {% else %}
          0
          {% endif %};;
  }

  dimension: no_comparison {
    view_label: "Date Comparison"
    type: yesno
    sql: ${selected_comparison} LIKE '%Last%'  ;;
  }


  dimension: last_7_days_vs_previous_7_days {
    view_label: "Date Comparison"
    type: string
    sql: CASE
        WHEN (( ${impression_raw} >= (TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ${impression_raw} < (TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))
        THEN 'Last 7 Days'

        WHEN (( ${impression_raw} >= (TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -13 DAY))) AND ${impression_raw} < (TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -13 DAY), INTERVAL 7 DAY)))
        THEN 'Prior 7 Days'
      END
      ;;
  }


  dimension: last_14_days_vs_previous_14_days {
    view_label: "Date Comparison"
    type: string
    sql: CASE
        WHEN (( ${impression_raw} >= (TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -13 DAY))) AND ${impression_raw} < (TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -13 DAY), INTERVAL 14 DAY)))
        THEN 'Last 14 Days'

        WHEN (( ${impression_raw} >= (TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -27 DAY))) AND ${impression_raw} < (TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -27 DAY), INTERVAL 14 DAY)))
        THEN 'Prior 14 Days'
      END
      ;;
  }


  dimension: last_30_days_vs_previous_30_days {
    view_label: "Date Comparison"
    type: string
    sql: CASE
        WHEN (( ${impression_raw} >= (TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY))) AND ${impression_raw} < (TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -29 DAY), INTERVAL 30 DAY)))
        THEN 'Last 30 Days'

        WHEN (( ${impression_raw} >= (TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -59 DAY))) AND ${impression_raw} < (TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -59 DAY), INTERVAL 30 DAY)))
        THEN 'Prior 30 Days'
      END
      ;;
  }

  dimension_group: impression {
    view_label: "Event Attributes"
    label: "Event"
    type: time
    timeframes: [raw, time, hour_of_day, date, day_of_week, week, month, year]
    sql:${TABLE}.event_time ;;
  }

  dimension: dbm_advertiser_id {
    view_label: "Event Attributes"
    label: "Advertiser ID"
    type: string
    sql: ${TABLE}.dbm_advertiser_id ;;
  }

  dimension: dbm_device_type {
    hidden: yes
    type: number
    sql: ${TABLE}.DBM_Device_Type ;;
  }

  dimension: DBM_Device_Type_Name {
    view_label: "Event Attributes"
    label: "Device Type"
    type: string
    sql: CASE
          WHEN DBM_Device_Type=0 THEN "Computer"
          WHEN DBM_Device_Type=1 THEN "Other"
          WHEN DBM_Device_Type=2 THEN "Smartphone"
          WHEN DBM_Device_Type=3 THEN "Tablet"
          WHEN DBM_Device_Type=4 THEN "Smart TV"
          ELSE 'Unknown'
         END ;;
    drill_fields: [dbm_browser_platform_id,dbm_operating_system_id]
  }

  dimension: dbm_browser_platform_id {
    view_label: "Event Attributes"
    label: "Browser Platform ID"
    type: string
    drill_fields: [dbm_operating_system_id, DBM_Device_Type_Name]
    sql: ${TABLE}.DBM_Browser_Platform_ID ;;
  }

  dimension: dbm_operating_system_id {
    view_label: "Event Attributes"
    label: "Operating System ID"
    type: string
    drill_fields: [DBM_Device_Type_Name,dbm_browser_platform_id]
    sql: ${TABLE}.dbm_operating_system_id ;;
  }

  dimension: dbm_site_id {
    view_label: "Event Attributes"
    label: "Site ID"
    type: string
    drill_fields: [dbm_exchange_id]
    sql: ${TABLE}.dbm_site_id ;;
  }

  dimension: dbm_exchange_id {
    view_label: "Event Attributes"
    label: "Exchange ID"
    type: string
    drill_fields: [is_public,dbm_site_id]
    sql: ${TABLE}.dbm_exchange_id ;;
  }

  dimension: dbm_auction_id {
    view_label: "Event Attributes"
    label: "Auction ID"
    type: string
    drill_fields: [is_public,dbm_exchange_id,dbm_site_id]
    sql: ${TABLE}.dbm_auction_id ;;
  }

  dimension: dbm_attributed_inventory_source_is_public {
    hidden: yes
    type: string
    sql: ${TABLE}.dbm_attributed_inventory_source_is_public ;;
  }

  dimension: dbm_matching_targeted_segments {
    hidden: yes
    type: string
    sql: ${TABLE}.dbm_matching_targeted_segments ;;
  }

  dimension: dbm_matching_targeted_segments_array {
    type: string
    hidden: yes
    sql:  SPLIT(${dbm_matching_targeted_segments},' ');;
  }

  dimension: dbm_zip_postal_code {
    view_label: "Event Attributes"
    label: "Zip Code"
    type: string
    sql: ${TABLE}.dbm_zip_postal_code ;;
  }
  dimension: count_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}.count_conversions ;;
  }

  dimension: count_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.count_clicks ;;
  }

  dimension: count_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.total_impressions ;;
  }

  dimension: active_view_viewable_impressions_d {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_viewable_impressions ;;
  }

  dimension: active_view_measurable_impressions_d {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_measurable_impressions ;;
  }

  dimension: active_view_eligible_impressions_d {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_eligible_impression ;;
  }

  dimension: total_revenue {
    type: number
    hidden: yes
    sql: ${TABLE}.total_revenue/1000000000 ;;
  }

  ### Impression measures

  measure: total_impressions {
    view_label: "Overall Metrics"
    type: sum
    sql: ${count_impressions} ;;
  }

  measure: total_conversions {
    view_label: "Overall Metrics"
    type: sum
    sql: ${count_conversions} ;;
  }

  measure: total_clicks {
    view_label: "Overall Metrics"
    type: sum
    sql: ${count_clicks} ;;
  }

  measure: active_view_viewable_impressions {
    view_label: "Overall Metrics"
    label: "Viewable Impressions"
    description: "The number of impressions on the site that were viewable out of all measurable impressions"
    type: sum
    sql: ${active_view_viewable_impressions_d} ;;
  }

  measure: active_view_measurable_impressions {
    view_label: "Overall Metrics"
    label: "Measureable Impressions"
    description: "The total number of impressions that were measurable with Active View. An ad is measurable when the Active View tag is able to capture viewability data about the impression."
    type: sum
    sql: ${active_view_measurable_impressions_d} ;;
  }

  measure: active_view_eligible_impressions {
    view_label: "Overall Metrics"
    label: "Eligible Impressions"
    description: "The total number of impressions that were eligible to measure viewability. An impression is eligible if the ad unit has a supported creative format and tag type."
    type: sum
    sql: ${active_view_eligible_impressions_d} ;;
  }


  ### copied over

  dimension: dbm_insertion_order_id {
    view_label: "Event Attributes"
    label: "Insertion Order ID"
    type: string
    value_format_name: id
    sql: CAST(${TABLE}.DBM_Insertion_Order_ID as string) ;;
    link: {
      label: "IO Lookup Dashboard"
      url: "/dashboards-next/campaign_manager::io_lookup?Insertion%20Order={{ value | encode_uri }}&Performance%20Metric={{ _filters['metric_selector'] | url_encode }}&Impression%20Date={{ _filters['impression_funnel_dv360.impression_date'] | url_encode }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    link: {
      label: "Link to DV360 for IO {{value}}"
      url: "https://displayvideo.google.com/#ng_nav/p/@{DV360_PARTNER_ID}/a/{{dbm_advertiser_id._value}}/c/{{campaign_id._value}}/io/{{value}}/lis"
      icon_url: "https://www.searchlaboratory.com/wp-content/uploads/2019/02/DV360-1.png"
    }
    drill_fields: [dbm_line_item_id]
  }

  dimension: dbm_insertion_order_id_label {
    view_label: "Event Attributes"
    label: "Insertion Order ID Label"
    type: string
    sql: CONCAT(CAST(${dynamic_io_rank.rank} as string),'.) ',CAST(${TABLE}.DBM_Insertion_Order_ID as string)) ;;
    link: {
      label: "IO Lookup Dashboard"
      # url: "/dashboards/20?Insertion%20Order={{ dbm_insertion_order_id._value | encode_uri }}"
      url: "/dashboards-next/campaign_manager::io_lookup?Insertion%20Order={{ dbm_insertion_order_id._value | encode_uri }}&Performance%20Metric={{ _filters['metric_selector'] | url_encode }}&Impression%20Date={{ _filters['impression_funnel_dv360.impression_date'] | url_encode }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    link: {
      label: "Link to DV360 for IO {{dbm_insertion_order_id._value}}"
      url: "https://displayvideo.google.com/#ng_nav/p/@{DV360_PARTNER_ID}/a/{{dbm_advertiser_id._value}}/c/{{campaign_id._value}}/io/{{dbm_insertion_order_id._value}}/lis"
      icon_url: "https://www.searchlaboratory.com/wp-content/uploads/2019/02/DV360-1.png"
    }
  }

  dimension: dbm_line_item_id {
    view_label: "Event Attributes"
    label: "Line Item ID"
    type: number
    sql: ${TABLE}.DBM_Line_Item_ID ;;
    link: {
      label: "Line Item Lookup Dashboard"
      url: "/dashboards-next/campaign_manager::line_item_lookup?Performance%20Metric={{ _filters['metric_selector'] | url_encode }}&Impression%20Date={{ _filters['impression_funnel_dv360.impression_date'] | url_encode }}&Line+Item+ID={{ dbm_line_item_id._value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
    link: {
      label: "Link to DV360 for Line Item {{value}}"
      url: "https://displayvideo.google.com/#ng_nav/p/@{DV360_PARTNER_ID}/a/{{dbm_advertiser_id._value}}/c/{{campaign_id._value}}/io/{{dbm_insertion_order_id._value}}/li/{{value}}/details"
      icon_url: "https://www.searchlaboratory.com/wp-content/uploads/2019/02/DV360-1.png"
    }
  }

  dimension: dbm_designated_market_area_dma_id {
    view_label: "Event Attributes"
    label: "DMA ID"
    type: string
    map_layer_name: dma
    sql: ${TABLE}.DBM_Designated_Market_Area_DMA_ID ;;
    drill_fields: [dbm_zip_postal_code]
  }

  dimension: campaign_id {
    view_label: "Event Attributes"
    label: "Campaign ID"
    link: {
      label: "Link to DV360 for Campaign {{value}}"
      url: "https://displayvideo.google.com/#ng_nav/p/@{DV360_PARTNER_ID}/a/{{dbm_advertiser_id._value}}/c/{{value}}/explorer?"
      icon_url: "https://www.searchlaboratory.com/wp-content/uploads/2019/02/DV360-1.png"
    }
    link: {
      label: "DV360 Campaign Overview Dashboard"
      # url: "/dashboards/20?Insertion%20Order={{ dbm_insertion_order_id._value | encode_uri }}"
      url: "/dashboards-next/campaign_manager::campaign_overview__dv360?Campaign+ID={{ value }}&Performance%20Metric={{ _filters['metric_selector'] | url_encode }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }

#     html:
#     <html>
# <center>
# <button style="background-color: #4285F4; border: none; text-align: center; color: white; padding: 10px 25px; font-size: 12px;">
# <a style="text-decoration: none; color: white;" href="https://displayvideo.google.com/#ng_nav/p/@{DV360_PARTNER_ID}/a/{{dbm_advertiser_id._value}}/c/{{value}}/explorer?">
# <b>Go to DV360 for<br>Selected Campaign</b></a></button>
# </center>
# </html>
# ;;
  }

  dimension: campaign_id_button {
    view_label: "Event Attributes"
    hidden: yes
    link: {
      url: "Link to DV360 for Campaign {{value}}"
      icon_url: "https://displayvideo.google.com/#ng_nav/p/@{DV360_PARTNER_ID}/a/{{dbm_advertiser_id._value}}/c/{{value}}/explorer?"
    }
    sql: ${TABLE}.campaign_id ;;
    html:
    <html>
<center>
<button style="background-color: #4285F4; border: none; text-align: center; color: white; padding: 10px 25px; font-size: 12px;">
<a style="text-decoration: none; color: white;" href="https://displayvideo.google.com/#ng_nav/p/@{DV360_PARTNER_ID}/a/{{dbm_advertiser_id._value}}/c/{{value}}/explorer?">
<b>Go to DV360 for<br>Selected Campaign</b></a></button>
</center>
</html>
;;
  }

  dimension: cluster_dashboards {
    view_label: "Event Attributes"
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
    html:
    <html>
<center>
<button style="background-color: #4285F4; border: none; text-align: center; color: white; padding: 10px 25px; font-size: 12px;">
<a style="text-decoration: none; color: white;" href="/dashboards-next/campaign_manager::cluster_lookup?Centroid%20ID={{cluster_predict.centroid_id._value}}&Performance%20Metric={{ _filters['impression_funnel_dv360.metric_selector'] | url_encode }}&Impression%20Date={{ _filters['impression_funnel_dv360.impression_date'] | url_encode }}">
<b>Go to Clustering Overview for<br>Selected Campaign</b></a></button>
</center>
</html>
;;
  }



  dimension: is_public {
    view_label: "Event Attributes"
    label: "Inventory Source Public vs Private"
    type: string
    sql: CASE
          WHEN CAST(${dbm_attributed_inventory_source_is_public} AS STRING) = 'true' THEN 'Public'
          WHEN CAST(${dbm_attributed_inventory_source_is_public} AS STRING) = 'false' THEN 'Private'
          ELSE NULL
          END ;;
    drill_fields: [dbm_exchange_id,dbm_site_id]
  }

  ### Line Item Metrics

  measure: line_item_count {
    view_label: "Overall Metrics"
    label: "Total Line Items"
    description: "Count of Distinct Line Items"
    type: count_distinct
    sql: ${dbm_line_item_id} ;;
    drill_fields: []
  }

  measure: line_item_count_label {
    hidden: yes
    type: count_distinct
    sql: ${dbm_line_item_id} ;;
    drill_fields: [dbm_line_item_id, ctr, cr, cpm, percent_impressions_measurable, percent_impressions_viewed]
    value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    html:  <a href="#drillmenu" target="_self">
          {{rendered_value}} Line Items
          </a>
          ;;
  }

  measure: insertion_order_count {
    view_label: "Overall Metrics"
    label: "Total Insertion Orders"
    description: "Count of Distinct Insertion Orders"
    type: count_distinct
    sql: ${dbm_insertion_order_id} ;;
    drill_fields: [dbm_insertion_order_id]
  }

  ## Cost Metrics

  measure: dbm_revenue {
    view_label: "Overall Metrics"
    label: "Total Spend"
    description: "The total amount in USD made by the partner account for the event"
    type: sum
    value_format_name: usd
    sql: ${total_revenue} ;;
  }

  ## CPA Performance

  measure: cpa {
    view_label: "Performance Metrics"
    label: "CPA"
    description: "Cost per Acquisition"
    type:  number
    value_format_name: usd
    sql: 1.0 * ${dbm_revenue}/nullif(${total_conversions},0) ;;
  }

  measure: cpa_without_campaign_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${campaign_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${campaign_facts.total_conversions} - ${total_conversions}),0) ;;
  }

  measure: cpa_without_io_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${io_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${io_facts.total_conversions} - ${total_conversions}),0) ;;
  }

  measure: cpa_without_line_item_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${line_item_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${line_item_facts.total_conversions} - ${total_conversions}),0) ;;
  }

  measure: contribution_to_campaign_cpa_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall campaign CPA performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpa_without_campaign_level} - ${cpa}) / nullif(${cpa},0) ;;
  }

  measure: contribution_to_io_cpa_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall insertion order CPA performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpa_without_io_level} - ${cpa}) / nullif(${cpa},0) ;;
  }

  measure: contribution_to_line_item_cpa_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall line item CPA performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpa_without_line_item_level} - ${cpa}) / nullif(${cpa},0) ;;
  }

  ## CPC

  measure: cpc {
    view_label: "Performance Metrics"
    label: "CPC"
    description: "Cost Per Click"
    type: number
    value_format_name: usd
    sql: 1.0 * ${dbm_revenue}/nullif(${total_clicks},0) ;;
  }

  measure: cpc_without_campaign_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${campaign_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${campaign_facts.total_clicks} - ${total_clicks}),0) ;;
  }

  measure: cpc_without_io_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${io_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${io_facts.total_clicks} - ${total_clicks}),0) ;;
  }

  measure: cpc_without_line_item_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${line_item_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${line_item_facts.total_clicks} - ${total_clicks}),0) ;;
  }

  measure: contribution_to_campaign_cpc_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall campaign CPC performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpc_without_campaign_level} - ${cpc}) / nullif(${cpc},0) ;;
  }

  measure: contribution_to_io_cpc_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall insertion order CPC performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpc_without_io_level} - ${cpc}) / nullif(${cpc},0) ;;
  }

  measure: contribution_to_line_item_cpc_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall line item CPC performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpc_without_line_item_level} - ${cpc}) / nullif(${cpc},0) ;;
  }

  ## CPM

  measure: cpm {
    view_label: "Performance Metrics"
    description: "Cost Per 1000 Impressions"
    label: "CPM"
    type: number
    value_format: "$0.00"
    sql:  1.0 * ${dbm_revenue}/nullif(${total_impressions},0)*1000;;
  }

  measure: cpm_without_campaign_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${campaign_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${campaign_facts.total_impressions} - ${total_impressions}),0)*1000 ;;
  }

  measure: cpm_without_io_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${io_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${io_facts.total_impressions} - ${total_impressions}),0)*1000 ;;
  }

  measure: cpm_without_line_item_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${line_item_facts.dbm_revenue} - ${dbm_revenue}) / nullif((${line_item_facts.total_impressions} - ${total_impressions}),0)*1000 ;;
  }

  measure: contribution_to_campaign_cpm_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall campaign CPM performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpm_without_campaign_level} - ${cpm}) / nullif(${cpm},0) ;;
  }

  measure: contribution_to_io_cpm_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall insertion order CPM performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpm_without_io_level} - ${cpm}) / nullif(${cpm},0) ;;
  }

  measure: contribution_to_line_item_cpm_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall line item CPM performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cpm_without_line_item_level} - ${cpm}) / nullif(${cpm},0) ;;
  }

  ### Custom Rate Metrics ###

  ## Click Through Rate

  measure: ctr {
    view_label: "Performance Metrics"
    description: "Click Through Rate"
    label: "CTR"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_clicks}/nullif(${total_impressions},0) ;;
  }

  measure: ctr_without_campaign_level {
    hidden: yes
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${campaign_facts.total_clicks} - ${total_clicks}) / nullif((${campaign_facts.total_impressions} - ${total_impressions}),0) ;;
  }

  measure: ctr_without_io_level {
    hidden: yes
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${io_facts.total_clicks} - ${total_clicks}) / nullif((${io_facts.total_impressions} - ${total_impressions}),0) ;;
  }

  measure: ctr_without_line_item_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${line_item_facts.total_clicks} - ${total_clicks}) / nullif((${line_item_facts.total_impressions} - ${total_impressions}),0) ;;
  }

  measure: contribution_to_campaign_ctr_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall campaign CTR performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${ctr_without_campaign_level} - ${ctr}) / nullif(${ctr},0) ;;
  }

  measure: contribution_to_io_ctr_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall insertion order CTR performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${ctr_without_io_level} - ${ctr}) / nullif(${ctr},0) ;;
  }

  measure: contribution_to_line_item_ctr_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall line item CTR performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${ctr_without_line_item_level} - ${ctr}) / nullif(${ctr},0) ;;
  }

  ## Conversion Rate

  measure: cr {
    view_label: "Performance Metrics"
    description: "Conversion Rate"
    label: "CR"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_conversions}/nullif(${total_impressions},0) ;;
  }

  measure: cr_without_campaign_level {
    hidden: yes
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${campaign_facts.total_conversions} - ${total_conversions}) / nullif((${campaign_facts.total_impressions} - ${total_impressions}),0) ;;
  }

  measure: cr_without_io_level {
    hidden: yes
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${io_facts.total_conversions} - ${total_conversions}) / nullif((${io_facts.total_impressions} - ${total_impressions}),0) ;;
  }

  measure: cr_without_line_item_level {
    hidden: yes
    type: number
    value_format_name: usd
    sql: 1.0 * (${line_item_facts.total_conversions} - ${total_conversions}) / nullif((${line_item_facts.total_impressions} - ${total_impressions}),0) ;;
  }

  measure: contribution_to_campaign_cr_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall campaign CR performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${ctr_without_campaign_level} - ${cr}) / nullif(${cr},0) ;;
  }

  measure: contribution_to_io_cr_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall insertion order CR performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cr_without_io_level} - ${cr}) / nullif(${cr},0) ;;
  }

  measure: contribution_to_line_item_cr_performance {
    view_label: "Performance Metrics"
    group_label: "Contribution to Performance"
    description: "The % change to overall line item CR performance if the chosen attribute had never been included"
    type: number
    value_format_name: percent_2
    sql: 1.0 * (${cr_without_line_item_level} - ${cr}) / nullif(${cr},0) ;;
  }

  measure: percent_impressions_viewed {
    view_label: "Performance Metrics"
    label: "% of Impressions Viewed"
    description: "Viewable Impressions/Measurable Impressions"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${active_view_viewable_impressions}/nullif(${active_view_measurable_impressions},0) ;;
  }

  measure: percent_impressions_measurable {
    view_label: "Performance Metrics"
    label: "% of Measurable Impressions"
    description: "Measurable Impressions/Eligible Impressions"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${active_view_measurable_impressions}/nullif(${active_view_eligible_impressions},0) ;;
  }

  ### Metric Selector

  parameter:  metric_selector {
    view_label: "Event Attributes"
    allowed_value: {
      label: "CPA"
      value: "Cost Per Acquisition"
    }
    allowed_value: {
      label: "CPC"
      value: "Cost Per Click"
    }
    allowed_value: {
      label: "CTR"
      value: "Click Through Rate"
    }
    allowed_value: {
      label: "CPM"
      value: "Cost Per 1000 Impressions"
    }
    allowed_value: {
      label: "CR"
      value: "Conversion Rate"
    }
  }

  measure: dynamic_measure {
    view_label: "Event Attributes"
    description: "Use this as your measure when utilizing the Metric Selector parameter"
    label_from_parameter: metric_selector
    type: number
    sql:  {% if metric_selector._parameter_value == "'Cost Per Acquisition'" %} ${cpa}
          {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} ${cpc}
            {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} ${ctr}*100
            {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} ${cpm}
            {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} ${cr}*100
            {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} ${percent_impressions_viewed}*100
            {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} ${percent_impressions_measurable}*100
            {% else %} null
          {% endif %};;
#     sql: 1 ;;
  # value_format_name: "[>=0.01]0.00;[>0]0.0000;0.00"
      value_format_name: decimal_4
      html: <a href="#drillmenu" target="_self">
            {% if metric_selector._parameter_value == "'Cost Per Acquisition'" %} ${{rendered_value}}
                  {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} ${{rendered_value}}
                    {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} {{rendered_value}}%
                    {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} ${{rendered_value}}
                    {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} {{rendered_value }}%
                    {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} {{rendered_value }}%
                    {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} {{rendered_value}}%
                    {% else %} {{rendered_value}}
                  {% endif %}
                  </a>;;
            # html: <a href="#drillmenu" target="_self">
            # {% if metric_selector._parameter_value == "'Cost Per Aquisition'" %} {{cpa._rendered_value}}
            # {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} {{cpc._rendered_value}}
            # {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} {{ctr._rendered_value }}
            # {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} {{cpm._rendered_value}}
            # {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} {{cr._rendered_value}}
            # {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} {{percent_impressions_viewed._rendered_value}}
            # {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} {{percent_impressions_viewed._rendered_value}}
            # {% else %} {{rendered_value}}
            # {% endif %}
            # </a>;;
      }

      measure: dynamic_measure_label {
        label_from_parameter: metric_selector
        type: number
        hidden: yes
        sql:  {% if metric_selector._parameter_value == "'Cost Per Acquisition'" %} ${cpa}
            {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} ${cpc}
              {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} ${ctr}
              {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} ${cpm}
              {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} ${cr}
              {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} ${percent_impressions_viewed}
              {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} ${percent_impressions_measurable}
              {% else %} null
            {% endif %};;
        # value_format_name: "[>=0.01]0.00;[>-0.01]0.0000;0.00"
          value_format_name: decimal_4
          html: <a href="#drillmenu" target="_self">
                    {% if metric_selector._parameter_value == "'Cost Per Acquisition'" %} ${{rendered_value}} CPA
                    {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} ${{rendered_value}} CPC
                    {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} {{rendered_value | times:100 }}% CTR
                    {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} ${{rendered_value}} CPM
                    {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} {{rendered_value | times:100 }}% CR
                    {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} {{rendered_value | times:100 }}% VIR
                    {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} {{rendered_value | times:100 }}% MIR
                    {% else %} {{rendered_value}}
                    {% endif %}
                                </a>;;
                          # html: <a href="#drillmenu" target="_self">
                          # {% if metric_selector._parameter_value == "'Cost Per Aquisition'" %} {{cpa._rendered_value}}
                          # {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} {{cpc._rendered_value}}
                          # {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} {{ctr._rendered_value }}
                          # {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} {{cpm._rendered_value}}
                          # {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} {{cr._rendered_value}}
                          # {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} {{percent_impressions_viewed._rendered_value}}
                          # {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} {{percent_impressions_viewed._rendered_value}}
                          # {% else %} {{rendered_value}}
                          # {% endif %}
                          # </a>;;
          }

          measure: dynamic_measure_for_ranking_io_contribution_to_performance {
            label: "Dynamic Contribution to Campaign Performance"
            description: "Use this as your measure when utilizing the Metric Selector parameter"
            view_label: "Performance Metrics"
            # hidden: yes
            value_format_name: percent_2
            type: number
            sql: {% if metric_selector._parameter_value == "'Cost Per Acquisition'" %} ${contribution_to_campaign_cpa_performance}
                        {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} ${contribution_to_campaign_cpc_performance}
                          {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} ${contribution_to_campaign_ctr_performance}
                          {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} ${contribution_to_campaign_cpm_performance}
                          {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} ${contribution_to_campaign_cr_performance}
                          {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} ${percent_impressions_viewed}
                          {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} ${percent_impressions_measurable}
                          {% else %} null
                        {% endif %} ;;
          }

          measure: dynamic_measure_io_contribution_to_performance {
            label: "Dynamic Contribution to IO Performance"
            description: "Use this as your measure when utilizing the Metric Selector parameter"
            view_label: "Performance Metrics"
            # hidden: yes
            value_format_name: percent_2
            type: number
            sql: {% if metric_selector._parameter_value == "'Cost Per Acquisition'" %} ${contribution_to_io_cpa_performance}
                        {% elsif metric_selector._parameter_value == "'Cost Per Click'" %} ${contribution_to_io_cpc_performance}
                          {% elsif metric_selector._parameter_value == "'Click Through Rate'" %} ${contribution_to_io_ctr_performance}
                          {% elsif metric_selector._parameter_value == "'Cost Per 1000 Impressions'" %} ${contribution_to_io_cpm_performance}
                          {% elsif metric_selector._parameter_value == "'Conversion Rate'" %} ${contribution_to_io_cr_performance}
                          {% elsif metric_selector._parameter_value == "'Viewable Impression Rate'" %} ${percent_impressions_viewed}
                          {% elsif metric_selector._parameter_value == "'Measureable Impression Rate'" %} ${percent_impressions_measurable}
                          {% else %} null
                        {% endif %} ;;
          }






          ### Campaign Benchmarking

          filter: campaign_input {
            view_label: "Event Attributes"
            type: string
            suggest_dimension: campaign_id
          }

          filter: io_input {
            view_label: "Event Attributes"
            type: string
            suggest_dimension: dbm_insertion_order_id
          }

          dimension: is_io {
            type: yesno
            sql: {% condition io_input %} ${dbm_insertion_order_id} {% endcondition %} ;;
          }

          dimension: is_same_campaign {
            type: yesno
            sql: ${campaign_id} = (SELECT max(campaign_id) from ${impression_funnel_dv360.SQL_TABLE_NAME} where {% condition io_input %} ${dbm_insertion_order_id} {% endcondition %}) ;;
          }

          dimension: campaign_comparison {
            view_label: "Event Attributes"
            type: string
            sql: CASE WHEN {% condition campaign_input %} ${campaign_id} {% endcondition %}
                        THEN CONCAT('1. ',cast(${campaign_id} as string))
                        WHEN ${cluster_predict.centroid_id} = (SELECT centroid_id from ${cluster_predict.SQL_TABLE_NAME} cp inner join ${clustering_dataset.SQL_TABLE_NAME} cd on cp.row_num=cd.row_num where {% condition campaign_input %} cd.campaign_id {% endcondition %})
                        THEN '2. Rest of Cluster' ELSE '3. Rest of Campaigns' END;;
          }

          ### Comparion vs. priod period

          filter: previous_period_filter {
            view_label: "Event Attributes"
            type: date
            description: "Use this filter for period analysis"
          }

          dimension: previous_period {
            view_label: "Event Attributes"
            type: string
            description: "The reporting period as selected by the Previous Period Filter"
            sql:
                      CASE
                        WHEN {% date_start previous_period_filter %} is not null AND {% date_end previous_period_filter %} is not null /* date ranges or in the past x days */
                          THEN
                            CASE
                              WHEN ${impression_raw} >=  {% date_start previous_period_filter %}
                                AND ${impression_raw} <= {% date_end previous_period_filter %}
                                THEN 'This Period'
                              WHEN ${impression_raw} >=
                              TIMESTAMP_ADD(TIMESTAMP_ADD({% date_start previous_period_filter %}, INTERVAL -1 DAY ), INTERVAL
                                -1*DATE_DIFF(DATE({% date_end previous_period_filter %}), DATE({% date_start previous_period_filter %}), DAY) + 1 DAY)
                                AND ${impression_raw} <=
                                TIMESTAMP_ADD({% date_start previous_period_filter %}, INTERVAL -1 DAY )
                                THEN 'Previous Period'
                            END
                          END ;;
          }



          set: detail {
            fields: [
              campaign_id,
              dbm_advertiser_id,
              dbm_insertion_order_id,
              dbm_line_item_id,
              dbm_site_id,
              dbm_exchange_id,
              dbm_auction_id,
              dbm_attributed_inventory_source_is_public,
              dbm_matching_targeted_segments,
              dbm_designated_market_area_dma_id,
              dbm_zip_postal_code,
              total_revenue,
              count_impressions
            ]
          }
        }

view: dbm_matching_targeted_segments_array {
  dimension: dbm_matching_targeted_segments {
    view_label: "Event Attributes"
    label: "Targeted Segment ID"
    description: "The ID of targeted user lists that match the visitor"
    type: string
    drill_fields: [impression_funnel_dv360.dbm_insertion_order_id]
    sql: ${TABLE} ;;
  }
}
