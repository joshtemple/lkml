view: t8002_contentview {
  sql_table_name: public.t8002_contentview ;;

  dimension: view_type {
    description: "PAGEVIEW or VIDEOVIEW"
    alias: [action]
    type: string
    sql: ${TABLE}.c8002_action ;;
  }

  dimension: c8002_adid {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_adid ;;
  }

  dimension: c8002_app_version {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_app_version ;;
  }

  dimension: c8002_artid {
    type: string
    sql: ${TABLE}.c8002_artid ;;
  }

  dimension: author {
    type: string
    sql: ${TABLE}.c8002_auth ;;
  }

  dimension: auto_play {
    type: string
    sql: ${TABLE}.c8002_auto ;;
  }

  dimension: battery_level {
    view_label: "user"
    type: number
    sql: ${TABLE}.c8002_battery ;;
  }

  dimension: c8002_beacon_id {
    view_label: "beacon"
    type: string
    sql: ${TABLE}.c8002_beacon_id ;;
  }

  dimension: c8002_beacon_loc {
    view_label: "beacon"
    type: string
    sql: ${TABLE}.c8002_beacon_loc ;;
  }

  dimension: c8002_bluetooth {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_bluetooth ;;
  }

  dimension: user_browser {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_br ;;
  }

  dimension: user_browser_version {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_bv ;;
  }

  dimension: c8002_category {
    type: string
    sql: ${TABLE}.c8002_category ;;
  }

  dimension: c8002_channel {
    type: string
    sql: ${TABLE}.c8002_channel ;;
  }

  dimension: c8002_cid {
    type: string
    sql: ${TABLE}.c8002_cid ;;
  }

  dimension: c8002_city {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_city ;;
  }

  dimension: c8002_content {
    type: string
    sql: ${TABLE}.c8002_content ;;
  }

  dimension: c8002_country {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_country ;;
  }

  dimension: c8002_county {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_county ;;
  }

  dimension_group: view_datetime {
    type: time
    timeframes: [time, date, week, month, year, hour_of_day]
    convert_tz: no
    sql: ${TABLE}.c8002_datetime ;;
  }

  dimension: c8002_dcc_id {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_dcc_id ;;
  }

  dimension: c8002_depth {
    type: number
    sql: ${TABLE}.c8002_depth ;;
  }

  dimension: user_device {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_device ;;
  }

  dimension: device_id {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_did ;;
  }

  dimension: c8002_district_id {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_district_id ;;
  }

  dimension: c8002_dma {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_dma ;;
  }

  dimension: c8002_edm {
    type: string
    sql: ${TABLE}.c8002_edm ;;
  }

  dimension: c8002_gaid {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_gaid ;;
  }

  dimension: c8002_gigyaid {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_gigyaid ;;
  }

  dimension: c8002_ip {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_ip ;;
  }

  dimension: c8002_issueid {
    type: string
    sql: ${TABLE}.c8002_issueid ;;
  }

  dimension: c8002_keyword {
    type: string
    sql: ${TABLE}.c8002_keyword ;;
  }

  dimension: c8002_language {
    type: string
    sql: ${TABLE}.c8002_language ;;
  }

  dimension: c8002_lat {
    view_label: "location"
    type: number
    sql: ${TABLE}.c8002_lat ;;
  }

  dimension: c8002_limit_ad_track {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_limit_ad_track ;;
  }

  dimension: c8002_lon {
    view_label: "location"
    type: number
    sql: ${TABLE}.c8002_lon ;;
  }

  dimension: c8002_menu {
    type: string
    sql: ${TABLE}.c8002_menu ;;
  }

  dimension: c8002_news {
    type: string
    sql: ${TABLE}.c8002_news ;;
  }

  dimension: c8002_ngsid {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_ngsid ;;
  }

  dimension: c8002_nudid {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_nudid ;;
  }

  dimension: c8002_nxtu {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_nxtu ;;
  }

  dimension: user_id {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_nxtu_or_did ;;
  }

  dimension: c8002_platform {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_platform ;;
  }

  dimension: c8002_postcode {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_postcode ;;
  }

  dimension: c8002_product {
    type: string
    sql: ${TABLE}.c8002_product ;;
  }

  dimension: c8002_ref_url {
    type: string
    sql: ${TABLE}.c8002_ref_url ;;
  }

  dimension: c8002_region {
    type: string
    sql: ${TABLE}.c8002_region ;;
  }

  dimension: c8002_section {
    type: string
    sql: ${TABLE}.c8002_section ;;
  }

  dimension: c8002_site {
    type: string
    sql: ${TABLE}.c8002_site ;;
  }

  dimension: c8002_source {
    type: string
    sql: ${TABLE}.c8002_source ;;
  }

  dimension: c8002_state {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_state ;;
  }

  dimension: c8002_street_id {
    view_label: "location"
    type: string
    sql: ${TABLE}.c8002_street_id ;;
  }

  dimension: c8002_subsection {
    type: string
    sql: ${TABLE}.c8002_subsection ;;
  }

  dimension: c8002_subsubsection {
    type: string
    sql: ${TABLE}.c8002_subsubsection ;;
  }

  dimension: screen_size {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_sz ;;
  }

  dimension: c8002_title {
    type: string
    sql: ${TABLE}.c8002_title ;;
  }

  dimension: user_agent {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_ua ;;
  }

  dimension: c8002_video_duration {
    type: number
    sql: ${TABLE}.c8002_video_duration ;;
  }

  dimension: c8002_wifi {
    view_label: "user"
    type: string
    sql: ${TABLE}.c8002_wifi ;;
  }

  dimension: latitude_longitude {
    alias: [view_location]
    view_label: "location"
    type: location
    sql_latitude: ${c8002_lat} ;;
    sql_longitude: ${c8002_lon} ;;
  }

# MEASURES

  measure: count {
    type: count
#    approximate: yes
    drill_fields: []
  }

  measure: total_page_views {
    type: count
    filters: {
      field: view_type value: "PAGEVIEW"
      }
  }

  measure: total_video_views {
    type: count
    filters: {
      field: view_type value: "VIDEOVIEW"
    }
  }

  measure: average_video_duration {
    type: average
    sql: ${c8002_video_duration} ;;
  }

  measure: distinct_users {
    type: count_distinct
    sql: ${user_id} ;;
#    approximate: yes
  }

  measure: distinct_content {
    type: count_distinct
    sql: ${c8002_cid} ;;
#    approximate: yes
  }

}
