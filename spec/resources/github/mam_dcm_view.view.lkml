view: mam_dcm_view {
  sql_table_name: public.mam_dcm_view ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: fiscal_year {
    type: string
    sql:
      case
        when ${date_date} between '2017-01-01' and '2018-06-30' then 'FY 17/18'
        when ${date_date} between '2018-01-01' and '2019-06-30' then 'FY 18/19'
        when ${date_date} between '2019-01-01' and '2020-06-30' then 'FY 19/20'
        else 'Uncategorized'
        end;;
      }

  dimension: mam_campaign {
    type: string
    sql:
      case
        when ${campaign_id} = '23182329' then 'Winter'
        when ${campaign_id} = '22311158' then 'Winter'
        when ${campaign_id} = '22439071' then 'Summer'
        when ${campaign_id} = '23018327' then 'Fall'
        when ${campaign_id} = '23188164' then 'Air Service'
        else 'Uncategorized'
        end;;
  }


  dimension: ad_size {
    type:  string
    sql:
      case
        when ${creative} ilike '%300x250%' then'728x90'
        when ${creative} ilike '%160x600%' then '160x600'
        when ${creative} ilike '%300x600%' then '300x600'
        when ${creative} ilike '%320x50%' then '320x50'
        when ${creative} ilike '%728x90%' then '728x90'
        else 'Uncategorized'
      end;;
  }

  dimension: dcm_creative {
    type: string
    sql:
      case
        when ${creative} ilike '%Yeti%' then 'Yeti'
        when ${creative} ilike '%Bigfoot%' then 'Bigfoot'
        when ${creative} ilike '%Fairy%' then 'Fairy'
        when ${creative} ilike '%Eagles%' then 'Eagles'
        end;;
  }

  dimension: publisher {
    type: string
    sql:
      case
        when ${site_dcm} = 'Matador Ventures%' then 'Matador'
        when ${site_dcm} = 'Media Rhythm' then'Snowboarder.com'
        else ${site_dcm}
        end;;
  }

  dimension: dcm_package {
    type:  string
    sql:
      case
        WHEN ${placement} ilike '%\\_4ScreenVideoPackage\\_%' then '4 Screen Video'
        WHEN ${placement} ilike '%\\_AV3ScreenVideoPackage\\_%' then 'AV 3 Screen Video'
        WHEN ${placement} ilike '%\\_CCDisplay\\_%' then 'Cross-Device Display'
        WHEN ${placement} ilike '%\\_CDDisplay\\_%' then 'Cross-Device Display'
        WHEN ${placement} ilike '%\\_NativeDisplayPackage\\_%' then 'Native Display'
        WHEN ${placement} ilike '%AV Big Box%' then 'AV Big Box'
        WHEN ${placement} ilike '%AV Half Page Sticky%' then 'Half Page Sticky'
        WHEN ${placement} ilike '%AVStandard Display Banners%' then 'AV Standard Banners ROS'
        WHEN ${placement} ilike '%\\_Standard Display Banners%' then 'Standard Banners ROS'
        WHEN ${placement} ilike '%\\_Video\\_Preroll/Outstream%' then 'Video/PreRoll/Outstream'
        WHEN ${placement} ilike '%\\_Custom Mobile Unit\\_Expandable Video%' then 'Custom Mobile Unit - Expandable Video'
        WHEN ${placement} ilike '%\\_Custom Mobile Unit\\_Scroller%' then 'Custom Mobile Unit - Scroller'
        WHEN ${placement} ilike '%\\_Display\\_Roller%' then 'Roller'
        WHEN ${placement} ilike '%\\_Rich Media\\_300x600expands%' then 'Rich Media'
        WHEN ${placement} ilike '%\\_Video In-read%' then 'In-Read Video'
        WHEN ${placement} ilike '%\\_AV Display\\_%' then 'AV Standard Display'
        WHEN ${placement} ilike '%\\_Standard\\_Video Billboard\\_%' then 'Standard/Video Billboard'
        WHEN ${placement} ilike '%\\_Standard Display\\_Roadblock%' then 'Standard Display Roadblock'
        WHEN ${placement} ilike 'Opensnow.com\\_Display\\_Desktop%' then 'Standard Display'
        WHEN ${placement} ilike 'Opensnow.com\\_Display\\_Mobile%' then 'Standard Display'
        WHEN ${placement} ilike 'Opensnow.com\\_Display\\_App%' then 'Standard Display'
        WHEN ${placement} ilike 'Opensnow.com\\_Display\\_Marquee%' then 'Marquee Display'
        WHEN ${placement} ilike '%Repromo Matador Content%' then 'Matador Content Distribution'
        WHEN ${placement} ilike '%Matador Experience%' then 'Matador Experience Distribution'
        WHEN ${placement} ilike 'Amobee\\_Native Display\\_%' then 'Native Display'
        WHEN ${placement} ilike 'Amobee\\_NativeDisplay\\_%' then 'Native Display'
        WHEN ${placement} ilike 'Amobee\\_AV3ScreenDisplay\\_%' then 'AV 3 Screen Display'
        WHEN ${placement} ilike 'Sharethrough\\_Native Display\\_%' then 'Native Display'
        WHEN ${placement} ilike 'Sharethrough\\_Native Display Added Value\\_%' then 'AV Native Display'
        WHEN ${placement} ilike '\\_Pre-Roll :30\\_' then '4-Screen Video'
        WHEN ${placement} ilike 'Amobee\\_RON\\_%' then '3-Screen Display'
        WHEN ${placement} ilike 'Amobee\\_R0N%' then '3-Screen Display'
        WHEN ${placement} ilike 'ROS Big Box%' then 'ROS Big Box'
        WHEN ${placement} ilike 'Matador Experience-%' then 'Matador Experience Distribution'
        ELSE 'Uncategorized'
        end;;
  }



  dimension: dcm_region {
    type: string
    sql:
    case
      WHEN ${placement} ilike '%\\_SF\\_%' then 'San Francisco'
      WHEN ${placement} ilike '%\\_NE\\_%' then 'Northeast'
      WHEN ${placement} ilike '%\\_DEN\\_%' then 'Denver'
      WHEN ${placement} ilike '%\\_CA+NV\_%' then 'California/Nevada'
      WHEN ${placement} ilike '%\\_SF' then 'San Francisco'
      WHEN ${placement} ilike '%\\_ SF' then 'San Francisco'
      WHEN ${placement} ilike '%\\_NE' then 'Northeast'
      WHEN ${placement} ilike '%\\_DEN' then 'Denver'
      WHEN ${placement} ilike '%\\_CA+NV' then 'California/Nevada'
      WHEN ${placement} ilike '%\\_NTL\\_%' then 'National'
      WHEN ${placement} = 'Matador_Repromo Matador Content_Distribution_1x1' then 'National'
      WHEN ${placement} ilike '%Northeast%' then 'Northeast'
      WHEN ${placement} ilike '%Denver%' then 'Denver'
      WHEN ${placement} ilike '%AV3ScreenVideoPackage%' then 'National'
      WHEN ${placement} ilike '%Native Display\\_San Francisco DMA' then 'San Francisco'
      WHEN ${placement} ilike '%\\_San Francisco DMA' then 'San Francisco'
      WHEN ${placement} ilike '%Native Display\\_CA & NV%' then 'California/Nevada'
      WHEN ${placement} ilike '%Native Display Added Value\\_CA & NV%' then 'California/Nevada'
      WHEN ${placement} ilike '%CA & NV%' then 'California/Nevada'
      WHEN ${placement_id} = '252643239' then 'California/Nevada'
      WHEN ${dcm_package} = 'Matador Experience Distribution' then 'National'
      WHEN ${dcm_package} = 'ROS Big Box' then 'National'
      WHEN ${placement} ilike '%Native Display\\_ San Diego%' then 'San Diego'
      WHEN ${placement} ilike '%Native Display\\_ Los Angeles%' then 'Los Angeles'
      WHEN ${placement} ilike '%Native Display\\_ San Francisco%' then 'San Francisco'
      WHEN ${placement} ilike '%Native Display\\_ Fresno%' then 'Fresno'
      WHEN ${placement} ilike '%Native Display\\_ Sacramento%' then 'Sacramento'
      WHEN ${placement} ilike '%Native Display\\_ California & Nevada%' then 'San Diego'
        ELSE 'Uncategorized'
    END;;
  }


  dimension: __id {
    hidden: yes
    type: string
    sql: ${TABLE}.__id ;;
  }

  dimension: __report {
    hidden: yes
    type: number
    sql: ${TABLE}.__report ;;
  }

  dimension_group: __senttime {
    hidden: yes
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
    sql: ${TABLE}.__senttime ;;
  }

  dimension: __state {
    hidden: yes
    type: string
    sql: ${TABLE}.__state ;;
  }

  dimension_group: __updatetime {
    hidden: yes
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
    sql: ${TABLE}.__updatetime ;;
  }

  dimension: active_view__measurable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."active view: % measurable impressions"
      ;;
  }

  dimension: active_view__viewable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."active view: % viewable impressions"
      ;;
  }

  dimension: active_view_eligible_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."active view: eligible impressions"
      ;;
  }

  dimension: active_view_measurable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."active view: measurable impressions"
      ;;
  }

  dimension: active_view_viewable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."active view: viewable impressions"
      ;;
  }

  dimension: ad {
    type: string
    sql: ${TABLE}.ad ;;
  }

  dimension: ad_id {
    hidden: yes
    type: string
    sql: ${TABLE}."ad id" ;;
  }

  dimension: advertiser {
    hidden: yes
    type: string
    sql: ${TABLE}.advertiser ;;
  }

  dimension: booked_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}."booked clicks" ;;
  }

  dimension: booked_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."booked impressions" ;;
  }

  dimension: booked_viewable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."booked viewable impressions" ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: campaign_id {
    hidden: yes
    type: number
    sql: ${TABLE}."campaign id" ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: clickthrough_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}."click-through conversions" ;;
  }

  dimension: clickthrough_revenue {
    hidden: yes
    type: number
    sql: ${TABLE}."click-through revenue" ;;
  }

  dimension: comp_key {
    hidden: yes
    type: string
    sql: ${TABLE}.comp_key ;;
  }

  dimension: creative {
    type: string
    sql: ${TABLE}.creative ;;
  }

  dimension: creative_id {
    hidden: yes
    type: string
    sql: ${TABLE}."creative id" ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: media_cost {
    hidden: yes
    type: number
    sql: ${TABLE}."media cost" ;;
  }

  dimension: placement {
    type: string
    sql: ${TABLE}.placement ;;
  }

  dimension: placement_id {
    hidden: yes
    type: number
    sql: ${TABLE}."placement id" ;;
  }

  dimension: placement_strategy {
    type: string
    sql: ${TABLE}."placement strategy" ;;
  }

  dimension: planned_media_cost {
    hidden: yes
    type: number
    sql: ${TABLE}."planned media cost" ;;
  }

  dimension: platform_type {
    type: string
    sql: ${TABLE}."platform type" ;;
  }

  dimension: site_dcm {
    type: string
    sql: ${TABLE}."site (dcm)" ;;
  }

  dimension: total_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}."total conversions" ;;
  }

  dimension: total_revenue {
    hidden: yes
    type: number
    sql: ${TABLE}."total revenue" ;;
  }

  dimension: viewthrough_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}."view-through conversions" ;;
  }

  dimension: viewthrough_revenue {
    hidden: yes
    type: number
    sql: ${TABLE}."view-through revenue" ;;
  }


######Measures####

  measure: total_impressions {
    type: sum_distinct
    sql_distinct_key: ${TABLE}.id ;;
    sql: ${impressions} ;;
  }

  measure: total_clicks {
    type: sum_distinct
    sql_distinct_key: ${TABLE}.id ;;
    sql: ${clicks};;
  }

  measure: click_through_rate{
    type: number
    sql: ${total_clicks}/nullif(${total_impressions},0) ;;
    value_format_name: percent_2
  }

  measure: total_active_view_measurable_impression{
    type: sum_distinct
    sql_distinct_key: ${TABLE}.id ;;
    sql: ${active_view_measurable_impressions};;
  }

  measure: total_active_view_viewable_impression{
    type: sum_distinct
    sql_distinct_key: ${TABLE}.id ;;
    sql: ${active_view__viewable_impressions};;
  }

  measure: total_viewability {
    type:  number
    sql: ${total_active_view_viewable_impression}/nullif(${total_active_view_measurable_impression},0) ;;
    value_format_name: percent_0
  }

  measure: total_media_cost {
    type:  sum_distinct
    sql_distinct_key: ${TABLE}.id;;
    sql:  ${media_cost} ;;
    value_format_name: usd
  }

  measure: cost_per_click {
    type: number
    sql: ${total_media_cost}/nullif(${total_clicks},0) ;;
    value_format_name: percent_2
  }

  measure: viewable_click_through_rate {
    type: number
    sql: ${total_clicks}/nullif(${total_active_view_viewable_impression},0) ;;
    value_format_name: percent_2
  }

  measure: viewable_cpm {
    type: number
    sql: 1.0*${total_media_cost}/nullif(${total_impressions}/100,0) ;;
    value_format_name: usd
  }

  measure: cost_per_thousand {
    type: number
    sql: 1.0*${total_media_cost}/nullif(${total_impressions}/100,0) ;;
    value_format_name: usd
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
