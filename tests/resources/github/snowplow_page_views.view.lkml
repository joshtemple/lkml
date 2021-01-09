view: snowplow_page_views {
  sql_table_name: analytics.snowplow_page_views ;;

  dimension: app_cache_time_in_ms {
    type: number
    sql: ${TABLE}.app_cache_time_in_ms ;;
  }

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: browser_build_version {
    type: string
    sql: ${TABLE}.browser_build_version ;;
  }

  dimension: browser_engine {
    type: string
    sql: ${TABLE}.browser_engine ;;
  }

  dimension: browser_language {
    type: string
    sql: ${TABLE}.browser_language ;;
  }

  dimension: browser_major_version {
    type: string
    sql: ${TABLE}.browser_major_version ;;
  }

  dimension: browser_minor_version {
    type: string
    sql: ${TABLE}.browser_minor_version ;;
  }

  dimension: browser_name {
    type: string
    sql: ${TABLE}.browser_name ;;
  }

  dimension: browser_window_height {
    type: number
    sql: ${TABLE}.browser_window_height ;;
  }

  dimension: browser_window_width {
    type: number
    sql: ${TABLE}.browser_window_width ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_is_mobile {
    type: yesno
    sql: ${TABLE}.device_is_mobile ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: dns_time_in_ms {
    type: number
    sql: ${TABLE}.dns_time_in_ms ;;
  }

  dimension: dom_interactive_to_complete_time_in_ms {
    type: number
    sql: ${TABLE}.dom_interactive_to_complete_time_in_ms ;;
  }

  dimension: dom_loading_to_interactive_time_in_ms {
    type: number
    sql: ${TABLE}.dom_loading_to_interactive_time_in_ms ;;
  }

  dimension: geo_city {
    type: string
    sql: ${TABLE}.geo_city ;;
  }

  dimension: geo_country {
    type: string
    sql: ${TABLE}.geo_country ;;
  }

  dimension: geo_latitude {
    type: string
    sql: ${TABLE}.geo_latitude ;;
  }

  dimension: geo_longitude {
    type: string
    sql: ${TABLE}.geo_longitude ;;
  }

  dimension: geo_region {
    type: string
    sql: ${TABLE}.geo_region ;;
  }

  dimension: geo_region_name {
    type: string
    sql: ${TABLE}.geo_region_name ;;
  }

  dimension: geo_timezone {
    type: string
    sql: ${TABLE}.geo_timezone ;;
  }

  dimension: geo_zipcode {
    type: string
    sql: ${TABLE}.geo_zipcode ;;
  }

  dimension: horizontal_percentage_scrolled {
    type: number
    sql: ${TABLE}.horizontal_percentage_scrolled ;;
  }

  dimension: horizontal_pixels_scrolled {
    type: number
    sql: ${TABLE}.horizontal_pixels_scrolled ;;
  }

  dimension: inferred_user_id {
    type: string
    sql: ${TABLE}.inferred_user_id ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: ip_domain {
    type: string
    sql: ${TABLE}.ip_domain ;;
  }

  dimension: ip_isp {
    type: string
    sql: ${TABLE}.ip_isp ;;
  }

  dimension: ip_net_speed {
    type: string
    sql: ${TABLE}.ip_net_speed ;;
  }

  dimension: ip_organization {
    type: string
    sql: ${TABLE}.ip_organization ;;
  }

  dimension: marketing_campaign {
    type: string
    sql: ${TABLE}.marketing_campaign ;;
  }

  dimension: marketing_click_id {
    type: string
    sql: ${TABLE}.marketing_click_id ;;
  }

  dimension: marketing_content {
    type: string
    sql: ${TABLE}.marketing_content ;;
  }

  dimension: marketing_medium {
    type: string
    sql: ${TABLE}.marketing_medium ;;
  }

  dimension: marketing_network {
    type: string
    sql: ${TABLE}.marketing_network ;;
  }

  dimension: marketing_source {
    type: string
    sql: ${TABLE}.marketing_source ;;
  }

  dimension: marketing_term {
    type: string
    sql: ${TABLE}.marketing_term ;;
  }

  dimension_group: max_tstamp {
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
    sql: ${TABLE}.max_tstamp ;;
  }

  dimension_group: min_tstamp {
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
    sql: ${TABLE}.min_tstamp ;;
  }

  dimension: onload_time_in_ms {
    type: number
    sql: ${TABLE}.onload_time_in_ms ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: os_build_version {
    type: string
    sql: ${TABLE}.os_build_version ;;
  }

  dimension: os_major_version {
    type: string
    sql: ${TABLE}.os_major_version ;;
  }

  dimension: os_manufacturer {
    type: string
    sql: ${TABLE}.os_manufacturer ;;
  }

  dimension: os_minor_version {
    type: string
    sql: ${TABLE}.os_minor_version ;;
  }

  dimension: os_name {
    type: string
    sql: ${TABLE}.os_name ;;
  }

  dimension: os_timezone {
    type: string
    sql: ${TABLE}.os_timezone ;;
  }

  dimension: page_height {
    type: number
    sql: ${TABLE}.page_height ;;
  }

  dimension: page_title {
    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension: page_url {
    type: string
    sql: ${TABLE}.page_url ;;
  }

  dimension: page_url_fragment {
    type: string
    sql: ${TABLE}.page_url_fragment ;;
  }

  dimension: page_url_host {
    type: string
    sql: ${TABLE}.page_url_host ;;
  }

  dimension: page_url_path {
    type: string
    sql: ${TABLE}.page_url_path ;;
  }

  dimension: page_url_port {
    type: number
    sql: ${TABLE}.page_url_port ;;
  }

  dimension: page_url_query {
    type: string
    sql: ${TABLE}.page_url_query ;;
  }

  dimension: page_url_scheme {
    type: string
    sql: ${TABLE}.page_url_scheme ;;
  }

  dimension: page_view_date {
    type: string
    sql: ${TABLE}.page_view_date ;;
  }

  dimension_group: page_view_end {
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
    sql: ${TABLE}.page_view_end ;;
  }

  dimension_group: page_view_end_local {
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
    sql: ${TABLE}.page_view_end_local ;;
  }

  dimension: page_view_hour {
    type: string
    sql: ${TABLE}.page_view_hour ;;
  }

  dimension: page_view_id {
    type: string
    sql: ${TABLE}.page_view_id ;;
  }

  dimension: page_view_in_session_index {
    type: number
    sql: ${TABLE}.page_view_in_session_index ;;
  }

  dimension: page_view_index {
    type: number
    sql: ${TABLE}.page_view_index ;;
  }

  dimension: page_view_local_day_of_week {
    type: string
    sql: ${TABLE}.page_view_local_day_of_week ;;
  }

  dimension: page_view_local_day_of_week_index {
    type: number
    sql: ${TABLE}.page_view_local_day_of_week_index ;;
  }

  dimension: page_view_local_hour_of_day {
    type: number
    sql: ${TABLE}.page_view_local_hour_of_day ;;
  }

  dimension: page_view_local_time {
    type: string
    sql: ${TABLE}.page_view_local_time ;;
  }

  dimension: page_view_local_time_of_day {
    type: string
    sql: ${TABLE}.page_view_local_time_of_day ;;
  }

  dimension: page_view_minute {
    type: string
    sql: ${TABLE}.page_view_minute ;;
  }

  dimension: page_view_month {
    type: string
    sql: ${TABLE}.page_view_month ;;
  }

  dimension: page_view_quarter {
    type: string
    sql: ${TABLE}.page_view_quarter ;;
  }

  dimension_group: page_view_start {
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
    sql: ${TABLE}.page_view_start ;;
  }

  dimension_group: page_view_start_local {
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
    sql: ${TABLE}.page_view_start_local ;;
  }

  dimension: page_view_time {
    type: string
    sql: ${TABLE}.page_view_time ;;
  }

  dimension: page_view_week {
    type: string
    sql: ${TABLE}.page_view_week ;;
  }

  dimension: page_view_year {
    type: number
    sql: ${TABLE}.page_view_year ;;
  }

  dimension: page_width {
    type: number
    sql: ${TABLE}.page_width ;;
  }

  dimension: processing_time_in_ms {
    type: number
    sql: ${TABLE}.processing_time_in_ms ;;
  }

  dimension: redirect_time_in_ms {
    type: number
    sql: ${TABLE}.redirect_time_in_ms ;;
  }

  dimension: referer_medium {
    type: string
    sql: ${TABLE}.referer_medium ;;
  }

  dimension: referer_source {
    type: string
    sql: ${TABLE}.referer_source ;;
  }

  dimension: referer_term {
    type: string
    sql: ${TABLE}.referer_term ;;
  }

  dimension: referer_url {
    type: string
    sql: ${TABLE}.referer_url ;;
  }

  dimension: referer_url_fragment {
    type: string
    sql: ${TABLE}.referer_url_fragment ;;
  }

  dimension: referer_url_host {
    type: string
    sql: ${TABLE}.referer_url_host ;;
  }

  dimension: referer_url_path {
    type: string
    sql: ${TABLE}.referer_url_path ;;
  }

  dimension: referer_url_port {
    type: number
    sql: ${TABLE}.referer_url_port ;;
  }

  dimension: referer_url_query {
    type: string
    sql: ${TABLE}.referer_url_query ;;
  }

  dimension: referer_url_scheme {
    type: string
    sql: ${TABLE}.referer_url_scheme ;;
  }

  dimension: request_time_in_ms {
    type: number
    sql: ${TABLE}.request_time_in_ms ;;
  }

  dimension: response_time_in_ms {
    type: number
    sql: ${TABLE}.response_time_in_ms ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_index {
    type: number
    sql: ${TABLE}.session_index ;;
  }

  dimension: tcp_time_in_ms {
    type: number
    sql: ${TABLE}.tcp_time_in_ms ;;
  }

  dimension: time_engaged_in_s {
    type: number
    sql: ${TABLE}.time_engaged_in_s ;;
  }

  dimension: time_engaged_in_s_tier {
    type: string
    sql: ${TABLE}.time_engaged_in_s_tier ;;
  }

  dimension: total_time_in_ms {
    type: number
    sql: ${TABLE}.total_time_in_ms ;;
  }

  dimension: unload_time_in_ms {
    type: number
    sql: ${TABLE}.unload_time_in_ms ;;
  }

  dimension: user_bounced {
    type: yesno
    sql: ${TABLE}.user_bounced ;;
  }

  dimension: user_custom_id {
    type: string
    sql: ${TABLE}.user_custom_id ;;
  }

  dimension: user_engaged {
    type: yesno
    sql: ${TABLE}.user_engaged ;;
  }

  dimension: user_snowplow_crossdomain_id {
    type: string
    sql: ${TABLE}.user_snowplow_crossdomain_id ;;
  }

  dimension: user_snowplow_domain_id {
    type: string
    sql: ${TABLE}.user_snowplow_domain_id ;;
  }

  dimension: vertical_percentage_scrolled {
    type: number
    sql: ${TABLE}.vertical_percentage_scrolled ;;
  }

  dimension: vertical_percentage_scrolled_tier {
    type: string
    sql: ${TABLE}.vertical_percentage_scrolled_tier ;;
  }

  dimension: vertical_pixels_scrolled {
    type: number
    sql: ${TABLE}.vertical_pixels_scrolled ;;
  }

  measure: count {
    type: count
    drill_fields: [geo_region_name, browser_name, os_name]
  }
}
