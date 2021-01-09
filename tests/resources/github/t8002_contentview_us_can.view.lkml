view: t8002_contentview_us_can {
  sql_table_name: public.t8002_contentview_us_can ;;

  dimension: view_type {
    description: "PAGEVIEW or VIDEOVIEW"
    alias: [action]
    type: string
    sql: ${TABLE}.c8002_action ;;
  }

  dimension: adid {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_adid ;;
  }

  dimension: app_version {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_app_version ;;
  }

  dimension: artid {
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

  dimension: battery {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_battery ;;
  }

  dimension: beacon_id {
    view_label: "Beacon"
    type: string
    sql: ${TABLE}.c8002_beacon_id ;;
  }

  dimension:beacon_loc {
    view_label: "Beacon"
    type: string
    sql: ${TABLE}.c8002_beacon_loc ;;
  }

  dimension: bluetooth {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_bluetooth ;;
  }

  dimension: user_browser {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_br ;;
  }

  dimension: browser_version {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_bv ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.c8002_category ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.c8002_channel ;;
  }

  dimension: cid {
    type: string
    sql: ${TABLE}.c8002_cid ;;
  }

  dimension: city {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_city ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.c8002_content ;;
  }

  dimension: country {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_country ;;
  }

  dimension: county {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_county ;;
  }

  dimension_group: view {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      hour_of_day
    ]
    convert_tz: no
    sql: ${TABLE}.c8002_datetime ;;
  }

  dimension: dcc_id {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_dcc_id ;;
  }

  dimension: depth {
    type: number
    sql: ${TABLE}.c8002_depth ;;
  }

  dimension: user_device {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_device ;;
  }

  dimension: device_id {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_did ;;
  }

  dimension: district_id {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_district_id ;;
  }

  dimension: dma {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_dma ;;
  }

  dimension: edm {
    type: string
    sql: ${TABLE}.c8002_edm ;;
  }

  dimension: gaid {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_gaid ;;
  }

  dimension: gigyaid {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_gigyaid ;;
  }

  dimension: ip {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_ip ;;
  }

  dimension: issueid {
    type: string
    sql: ${TABLE}.c8002_issueid ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.c8002_keyword ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.c8002_language ;;
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.c8002_lat ;;
  }

  dimension: limit_ad_track {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_limit_ad_track ;;
  }

  dimension: lon {
    hidden: yes
    type: number
    sql: ${TABLE}.c8002_lon ;;
  }

  dimension: menu {
    type: string
    sql: ${TABLE}.c8002_menu ;;
  }

  dimension: news {
    type: string
    sql: ${TABLE}.c8002_news ;;
  }

#  dimension: c8002_ngsid {
#   type: string
#    sql: ${TABLE}.c8002_ngsid ;;
#  }

#  dimension: c8002_nudid {
#    type: string
#    sql: ${TABLE}.c8002_nudid ;;
#  }

  dimension: nxtu {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_nxtu ;;
  }

  dimension: user_id {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_nxtu_or_did ;;
  }

  dimension: platform {
#    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_platform ;;
  }

  dimension: postcode {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_postcode ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.c8002_product ;;
  }

  dimension: referring_url {
    alias: [ref_url]
    type: string
    sql: ${TABLE}.c8002_ref_url ;;
  }

  dimension: region {
#    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_region ;;
  }

  dimension: section {
    type: string
    sql: ${TABLE}.c8002_section ;;
  }

  dimension: site {
    type: string
    sql: ${TABLE}.c8002_site ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.c8002_source ;;
  }

  dimension: state {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_state ;;
  }

  dimension: street_id {
    view_label: "Location"
    type: string
    sql: ${TABLE}.c8002_street_id ;;
  }

  dimension: subsection {
    type: string
    sql: ${TABLE}.c8002_subsection ;;
  }

  dimension: subsubsection {
    type: string
    sql: ${TABLE}.c8002_subsubsection ;;
  }

  dimension: screen_size {
    type: string
    sql: ${TABLE}.c8002_sz ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.c8002_title ;;
  }

  dimension: user_agent {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_ua ;;
  }

  dimension: video_duration {
    type: number
    sql: ${TABLE}.c8002_video_duration ;;
  }

  dimension: wifi {
    view_label: "User"
    type: string
    sql: ${TABLE}.c8002_wifi ;;
  }

  dimension: latitude_longitude {
    alias: [view_location]
    view_label: "Location"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${lon} ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_page_views {
    type: count
    filters: {
      field: view_type
      value: "PAGEVIEW"
      }
  }

  measure: total_video_views {
    type: count
    filters: {
      field: view_type
      value: "VIDEOVIEW"
    }
  }

  measure: average_duration {
    type: average
    sql: ${video_duration} ;;
  }

  measure: distinct_users {
    view_label: "User"
    type: count_distinct
    value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${user_id} ;;
#    approximate: yes
  }

  measure: distinct_content {
        type: count_distinct
    value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${cid} ;;
#    approximate: yes
  }
}
