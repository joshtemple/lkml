view: events {
  sql_table_name: parsely.rawdata ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
    view_label: "Basic Event Properties"
  }

  dimension: apikey {
    type: string
    sql: ${TABLE}.apikey ;;
    view_label: "Basic Event Properties"
  }

  dimension: display_avail_height {
    type: number
    hidden: yes
    sql: ${TABLE}.display_avail_height ;;
  }

  dimension: display_avail_width {
    type: number
    hidden: yes
    sql: ${TABLE}.display_avail_width ;;
  }

  dimension: display_pixel_depth {
    type: number
    hidden: yes
    sql: ${TABLE}.display_pixel_depth ;;
  }

  dimension: display_total_height {
    type: number
    hidden: yes
    sql: ${TABLE}.display_total_height ;;
  }

  dimension: display_total_width {
    type: number
    hidden: yes
    sql: ${TABLE}.display_total_width ;;
  }

  dimension: engaged_time_inc {
    type: number
    hidden: yes
    sql: ${TABLE}.engaged_time_inc ;;
  }

  dimension: extra_data {
    type: string
    hidden: yes
    sql: ${TABLE}.extra_data ;;
  }

  dimension: ip_country {
    type: string
    sql: CASE WHEN ${TABLE}.ip_country = 'United States' THEN 'United States of America' ELSE ${TABLE}.ip_country END ;;
    view_label: "IP & Geo"
  }

  dimension: ip_latitude {
    type: number
    hidden: yes
    sql: ${TABLE}.ip_lat ;;
    view_label: "IP & Geo"
  }

  dimension: ip_longitude {
    type: number
    hidden: yes
    sql: ${TABLE}.ip_lon ;;
    view_label: "IP & Geo"
  }

  dimension: ip_location {
    type: location
    sql_latitude: ${ip_latitude} ;;
    sql_longitude: ${ip_longitude} ;;
    view_label: "IP & Geo"
  }

  dimension: ip_zipcode {
    type: zipcode
    sql: ${TABLE}.ip_zipcode ;;
    view_label: "IP & Geo"
  }

  dimension: meta_authors {
    type: string
    sql: ${TABLE}.meta_authors ;;
    view_label: "Page Metadata"
  }

  dimension: meta_canonical_url {
    type: string
    sql: ${TABLE}.meta_canonical_url ;;
    view_label: "Page Metadata"
  }

  dimension: meta_image_url {
    type: string
    sql: ${TABLE}.meta_image_url ;;
    view_label: "Page Metadata"
  }

  dimension_group: meta_publish {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.meta_pub_date ;;
    view_label: "Page Metadata"
  }

  dimension: meta_section {
    type: string
    sql: ${TABLE}.meta_section ;;
    view_label: "Page Metadata"
  }

  dimension: meta_tags {
    type: string
    sql: ${TABLE}.meta_tags ;;
    view_label: "Page Metadata"
  }

  dimension: meta_title {
    type: string
    sql: ${TABLE}.meta_title ;;
    view_label: "Page Metadata"
  }

  dimension: referrer_clean {
    type: string
    sql: ${TABLE}.ref_clean ;;
    view_label: "Traffic Sources (Referrers)"
  }

  dimension: referrer_category {
    type: string
    sql: ${TABLE}.ref_category ;;
    view_label: "Traffic Sources (Referrers)"
  }

  dimension: referrer_domain {
    type: string
    sql: ${TABLE}.ref_domain ;;
    view_label: "Traffic Sources (Referrers)"
  }

  dimension: referrer_path {
    type: string
    sql: ${TABLE}.ref_path ;;
    view_label: "Traffic Sources (Referrers)"
  }

  dimension: referrer {
    type: string
    sql: ${TABLE}.referrer ;;
    view_label: "Traffic Sources (Referrers)"
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    view_label: "Sessions"
  }

  dimension: session_initial_referrer {
    type: string
    sql: ${TABLE}.session_initial_referrer ;;
    view_label: "Sessions"
  }

  dimension: session_initial_url {
    type: string
    sql: ${TABLE}.session_initial_url ;;
    view_label: "Sessions"
  }

  dimension: session_last_session_timestamp {
    type: string
    sql: ${TABLE}.session_last_session_timestamp ;;
    view_label: "Sessions"
  }

  dimension: session_timestamp {
    type: string
    sql: ${TABLE}.session_timestamp ;;
    view_label: "Sessions"
  }

  dimension_group: action {
    type: time
    timeframes: [time, hour, hour_of_day, date, week, month]
    sql: ${TABLE}.ts_action ;;
    view_label: "Time"
  }

  dimension_group: session_current {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ts_session_current ;;
    view_label: "Time"
  }

  dimension_group: session_last {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ts_session_last ;;
    view_label: "Time"
  }

  dimension: days_since_last_visit {
    type: number
    sql: ${session_current_date} - ${session_last_date} ;;
    view_label: "Time"
  }

  dimension: user_agent_browser {
    type: string
    sql: ${TABLE}.ua_browser ;;
    view_label: "UA & Devices"
  }

  dimension: user_agent_devicebrand {
    type: string
    sql: ${TABLE}.ua_devicebrand ;;
    view_label: "UA & Devices"
  }

  dimension: user_agent_devicemodel {
    type: string
    sql: ${TABLE}.ua_devicemodel ;;
    view_label: "UA & Devices"
  }

  dimension: user_agent_devicetype {
    type: string
    sql: ${TABLE}.ua_devicetype ;;
    view_label: "UA & Devices"
  }

  dimension: user_agent_os {
    type: string
    sql: ${TABLE}.ua_os ;;
    view_label: "UA & Devices"
  }

  dimension: user_agent {
    type: string
    sql: ${TABLE}.user_agent ;;
    view_label: "UA & Devices"
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
    view_label: "URL"
  }

  dimension: url_clean {
    type: string
    sql: ${TABLE}.url_clean ;;
    view_label: "URL"
  }

  dimension: url_domain {
    type: string
    sql: ${TABLE}.url_domain ;;
    view_label: "URL"
  }

  dimension: url_path {
    type: string
    sql: ${TABLE}.url_path ;;
    view_label: "URL"
  }

  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
    view_label: "URL"
  }

  dimension: utm_content {
    type: string
    sql: ${TABLE}.utm_content ;;
    view_label: "URL"
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
    view_label: "URL"
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
    view_label: "URL"
  }

  dimension: utm_term {
    type: string
    sql: ${TABLE}.utm_term ;;
    view_label: "URL"
  }

  dimension: visitor_ip {
    type: string
    sql: ${TABLE}.visitor_ip ;;
    view_label: "Visitors"
  }

  dimension: visitor_network_id {
    type: string
    sql: ${TABLE}.visitor_network_id ;;
    view_label: "Visitors"
  }

  dimension: visitor_site_id {
    type: string
    sql: ${TABLE}.visitor_site_id ;;
    view_label: "Visitors"
  }

  measure: events {
    type: count
    drill_fields: []
    view_label: "Metrics"
  }

  measure: pageviews {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    view_label: "Metrics"
  }

  measure: pageviews_mobile {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: user_agent_devicetype
      value: "mobile"
    }

    view_label: "Metrics"
  }

  measure: pageviews_desktop {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: user_agent_devicetype
      value: "desktop"
    }

    view_label: "Metrics"
  }

  measure: post_count {
    type: count_distinct
    sql: ${meta_canonical_url} ;;
    view_label: "Metrics"
  }

  measure: visitors {
    type: count_distinct
    sql: ${visitor_site_id} ;;
    view_label: "Metrics"
    drill_fields: [visitor_ip]
  }

  measure: visitors_mobile {
    type: count_distinct
    sql: ${visitor_site_id} ;;

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: user_agent_devicetype
      value: "mobile"
    }

    view_label: "Metrics"
  }

  measure: visitors_desktop {
    type: count_distinct
    sql: ${visitor_site_id} ;;

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: user_agent_devicetype
      value: "desktop"
    }

    view_label: "Metrics"
  }

  measure: network_visitors {
    type: count_distinct
    sql: ${visitor_network_id} ;;
    view_label: "Metrics"
  }

  measure: total_engaged_time {
    type: sum
    sql: ${engaged_time_inc} ;;
    view_label: "Metrics"
  }

  measure: average_engaged_time_per_visitor {
    type: number
    sql: ${total_engaged_time}::float/NULLIF(${visitors},0) ;;
    view_label: "Metrics"
    value_format_name: decimal_2
  }

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ||'-' || ${visitor_site_id} ;;
    view_label: "Metrics"
  }
}
