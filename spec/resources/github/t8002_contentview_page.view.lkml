view: contentview_page {
  sql_table_name: public.t8002_contentview ;;

  dimension: view_type {
    description: "PAGEVIEW"
    alias: [action]
    type: string
    sql: ${TABLE}.c8002_action ;;
  }

  dimension: adid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_adid ;;
  }

  dimension: app_version {
    view_label: "2. User"
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
    view_label: "2. User"
    type: number
    sql: ${TABLE}.c8002_battery ;;
  }

  dimension: beacon_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_beacon_id ;;
  }

  dimension: beacon_loc {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_beacon_loc ;;
  }

  dimension: bluetooth {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_bluetooth ;;
  }

  dimension: user_browser {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_br ;;
  }

  #   - dimension: bv
  #     type: string
  #     sql: ${TABLE}.c8002_bv

  dimension: category {
    type: string
    sql: ${TABLE}.c8002_category ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.c8002_channel ;;
  }

  dimension: cid {
    #    hidden: true
    type: string
    sql: ${TABLE}.c8002_cid ;;
  }

  dimension: city {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_city ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.c8002_content ;;
  }

  dimension: country {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_country ;;
  }

  dimension: county {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_county ;;
  }

  dimension_group: view {
    group_label: "view date"
    type: time
    timeframes: [
      time,
      date,
      day_of_week,
      day_of_week_index,
      week,
      month,
      year,
      hour_of_day
    ]
    convert_tz: no
    sql: ${TABLE}.c8002_datetime ;;
  }

  dimension: view_date_d {
    group_label: "view date"
    sql: TO_DATE(${TABLE}.c8002_datetime) ;;
  }

  dimension: view_weekday {
    sql:
      CASE
         when ${view_day_of_week_index} = 6 then 'Weekend'
         when ${view_day_of_week_index} = 0 then 'Weekday'
         when ${view_day_of_week_index} = 1 then 'Weekday'
         when ${view_day_of_week_index} = 2 then 'Weekday'
         when ${view_day_of_week_index} = 3 then 'Weekday'
         when ${view_day_of_week_index} = 4 then 'Weekday'
         when ${view_day_of_week_index} = 5 then 'Weekend'
      END ;;
  }



  dimension: dcc_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_dcc_id ;;
  }

  dimension: depth {
    type: number
    sql: ${TABLE}.c8002_depth ;;
  }

  dimension: user_device {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_device ;;
  }

  dimension: device_id {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_did ;;
  }

  dimension: district_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_district_id ;;
  }

  dimension: dma {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_dma ;;
  }

  dimension: edm {
    type: string
    sql: ${TABLE}.c8002_edm ;;
  }

  #   - dimension: gaid
  #     view_label: User
  #     type: string
  #     sql: ${TABLE}.c8002_gaid

  #   - dimension: gigyaid
  #     view_label: User
  #     type: string
  #     sql: ${TABLE}.c8002_gigyaid

  dimension: ip {
    view_label: "3. Location"
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
    view_label: "3. Location"
    type: number
    sql: ${TABLE}.c8002_lat ;;
  }

  dimension: lon {
    hidden: yes
    view_label: "3. Location"
    type: number
    sql: ${TABLE}.c8002_lon ;;
  }

  dimension: limit_ad_track {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_limit_ad_track ;;
  }

  dimension: menu {
    type: string
    sql: ${TABLE}.c8002_menu ;;
  }

  dimension: news {
    type: string
    sql: ${TABLE}.c8002_news ;;
  }

  #   - dimension: ngsid
  #     type: string
  #     sql: ${TABLE}.c8002_ngsid
  #
  #   - dimension: nudid
  #     type: string
  #     sql: ${TABLE}.c8002_nudid

  dimension: nxtu {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_nxtu ;;
  }

  dimension: user_id {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_nxtu_or_did ;;
  }

  dimension: platform {
    #    view_label: User
    type: string
    sql: ${TABLE}.c8002_platform ;;
  }

  dimension: postcode {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_postcode ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.c8002_product ;;
  }

  dimension: referring_url {
    #    view_label: User
    alias: [ref_url]
    type: string
    sql: ${TABLE}.c8002_ref_url ;;
  }

  dimension: region {
    #    view_label: Location
    type: string
    sql: ${TABLE}.c8002_region ;;
  }

  dimension: section {
    type: string
    sql: ${TABLE}.c8002_section ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.c8002_source ;;
  }

  dimension: site {
    type: string
    sql: ${TABLE}.c8002_site ;;
  }

  dimension: state {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_state ;;
  }

  dimension: street_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_street_id ;;
  }

  dimension: subsection {
    type: string
    sql: ${TABLE}.c8002_subsection ;;
  }

  #  - dimension: subsubsection
  #    type: string
  #    sql: ${TABLE}.c8002_subsubsection

  #   - dimension: sz
  #     type: string
  #     sql: ${TABLE}.c8002_sz

  dimension: title {
    type: string
    sql: ${TABLE}.c8002_title ;;
  }

  dimension: user_agent {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_ua ;;
  }

  dimension: view_duration {
    alias: [video_duration]
    type: number
    sql: ${TABLE}.c8002_view_duration ;;
  }

  dimension: wifi {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_wifi ;;
  }

  dimension: abt {
    type: string
    sql: ${TABLE}.c8002_abt ;;
  }

  dimension: omo_accid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_omo_accid ;;
  }

  dimension: omo_pid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_omo_pid ;;
  }

  dimension: OS {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_os ;;
  }

  dimension: fbid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_fbid ;;
  }

  dimension: ads {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_ads ;;
  }

  dimension: latitude_longitude {
    alias: [view_location]
    view_label: "3. Location"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${lon} ;;
  }

  measure: count {
    type: count
#    approximate: yes
    drill_fields: []
  }

  measure: total_page_views {
    type: count
    filters: {
      field: view_type
      value: "PAGEVIEW"
    }
  }

#  measure: total_video_views {
#    type: count
#    filters: {
#      field: view_type
#      value: "VIDEOVIEW"
#    }
#  }

#  measure: average_video_duration {
#    alias: [average_duration]
#    type: average
#    sql: ${view_duration} ;;
#    filters: {
#      field: view_type
#      value: "VIDEOVIEW"
#    }
#  }

  measure: average_page_duration {
    type: average
    sql: ${view_duration} ;;
    filters: {
      field: view_type
      value: "PAGEVIEW"
    }
  }

#  measure: sum_video_duration {
#    type: sum
#    sql: ${view_duration} ;;
#    filters: {
#      field: view_type
#      value: "VIDEOVIEW"
#   }
# }

  measure: sum_page_duration {
    type: sum
    sql: ${view_duration} ;;
    filters: {
      field: view_type
      value: "PAGEVIEW"
    }
  }

  measure: distinct_users {
    view_label: "2. User"
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
