view: ad_performance_reports {
  sql_table_name: adwords.ad_performance_reports ;;

##### This table is ad performance, segmented by day #####

##### IDs, Foreign Keys & Counts #####

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    link: {
      label: "Ad Performance Dashboard"
      icon_url: "https://looker.com/favicon.ico"
      url: "https://boomerang.looker.com/dashboards/8"
    }
    link: {
      label: "Campaign Lookup Dashboard"
      icon_url: "https://looker.com/favicon.ico"
      url: "https://boomerang.looker.com/dashboards/6?Campaign%20Name={{ campaigns.name._value }}"
    }
  }

  dimension: ad_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ad_id ;;
    link: {
      label: "Ad Performance Dashboard"
      icon_url: "https://looker.com/favicon.ico"
      url: "https://boomerang.looker.com/dashboards/8"
    }
    link: {
      label: "Campaign Lookup Dashboard"
      icon_url: "https://looker.com/favicon.ico"
      url: "https://boomerang.looker.com/dashboards/6?Campaign%20Name={{ campaigns.name._value }}"
    }

  }

  dimension: adwords_customer_id {
    type: string
    sql: ${TABLE}.adwords_customer_id ;;
    hidden: yes
  }

  dimension: original_ad_id {
    type: string
    sql: ${TABLE}.original_ad_id ;;
    hidden: yes
  }

  dimension: uuid {
    type: number
    value_format_name: id
    sql: ${TABLE}.uuid ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [details*]
  }

##### Time Dimensions #####

  dimension_group: date_start {
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
    sql: ${TABLE}.date_start ;;
  }

  dimension_group: date_stop {
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
    hidden: yes
    sql: ${TABLE}.date_stop ;;
  }

  dimension_group: received {
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
    sql: ${TABLE}.received_at ;;
    hidden: yes
  }

  dimension_group: uuid_ts {
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
    sql: ${TABLE}.uuid_ts ;;
    hidden: yes
  }

##### Active View #####

  dimension: active_view_impressions {
    type: number
    sql: ${TABLE}.active_view_impressions ;;
    hidden: yes
  }

  measure: total_active_view_impressions {
    type: sum
    hidden: yes
    sql: ${active_view_impressions} ;;
    description: "How often your ad has become viewable on a Display Network site."

  }

  dimension: active_view_measurability {
    type: number
    value_format_name: percent_2
    hidden: yes
    sql: ${TABLE}.active_view_measurability ;;
  }

  measure: average_daily_active_view_measurability {
    type: average
    sql: ${active_view_measurability} ;;
    description: "The ratio of impressions that could be measured by Active View over the number of served impressions."
    hidden: yes
  }

  dimension: active_view_measurable_cost {
    type: number
    value_format_name: usd
    sql: ${TABLE}.active_view_measurable_cost/1000000 ;;
    hidden: yes
  }

  measure: total_active_view_measurable_cost {
    type: sum
    sql: ${active_view_measurable_cost} ;;
    hidden: yes
    value_format_name: usd
    description: "The cost of the impressions you received that were measurable by Active View."

  }

  dimension: active_view_measurable_impressions {
    type: number
    sql: ${TABLE}.active_view_measurable_impressions ;;
    hidden: yes
  }

  measure: total_active_view_measurable_impressions {
    type: sum
    hidden: yes
    description: "The number of times your ads are appearing on placements in positions where they can be seen."
    sql: ${active_view_measurable_impressions} ;;
  }

  dimension: active_view_viewability {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.active_view_viewability ;;
    hidden: yes
  }

  measure: average_daily_active_view_viewability {
    type: average
    value_format_name: percent_2
    sql: ${active_view_viewability} ;;
    hidden: yes
    description: "The percentage of time when your ad appeared on an Active View enabled site (measurable impressions) and was viewable (viewable impressions)."
    drill_fields: [details*]
  }

##### All Conversions #####

##### (Best estimate of the total number of conversions that AdWords drives.
##### Includes website, cross-device, and phone call conversions.

  dimension: all_conversion_rate {
    type: number
    sql: ${TABLE}.all_conversion_rate ;;
    value_format_name: percent_2
    hidden: yes
  }

  measure: average_daily_all_conversion_rate {
    type: average
    sql: ${all_conversion_rate} ;;
    value_format_name: percent_2
    description: "All Conversions divided by total clicks that can be conversion-tracked. Note: this is a best estimate performed by Google."
    drill_fields: [details*]
  }

  dimension: all_conversion_value {
    type: number
    sql: ${TABLE}.all_conversion_value ;;
    hidden: yes
  }

  measure: total_all_conversion_value {
    type: sum
    sql: ${all_conversion_value} ;;
    hidden: yes
    description: "The total value of all of your conversions, including those that are estimated. Note: this is a best estimate performed by Google."
    drill_fields: [details*]

  }

  dimension: all_conversions {
    type: number
    sql: ${TABLE}.all_conversions ;;
    hidden: yes
  }

  measure: total_all_conversions {
    type: sum
    sql: ${all_conversions} ;;
    description: "Best estimate of the total number of conversions that AdWords drives. Includes website, cross-device, and phone call conversions. Note: this is a best estimate performed by Google."
    drill_fields: [details*]
  }

  dimension: value_per_all_conversion {
    type: number
    sql: ${TABLE}.value_per_all_conversion ;;
    hidden: yes
  }

  measure: average_daily_value_per_all_conversion {
    description: "The value, on average, of all conversions. "
    type: average
    hidden: yes
    sql: ${value_per_all_conversion} ;;
    drill_fields: [details*]
  }

##### Standard Metrics #####

  dimension: average_cost {
    type: number
    sql: ${TABLE}.average_cost/1000000 ;;
    hidden: yes
  }

  measure: average_daily_cost {
    description: "The average amount you pay per interaction. This amount is the total cost of your ads divided by the total number of interactions."
    type: average
    value_format_name: usd
    sql: ${average_cost} ;;
    drill_fields: [details*]
  }

  dimension: average_position {
    type: number
    sql: ${TABLE}.average_position ;;
    hidden: yes
  }

  measure: average_daily_ad_position {
    type: average
    sql: ${average_position} ;;
    value_format_name: decimal_2
    description: "Your ad's position relative to those of other advertisers."
    drill_fields: [details*]
  }

  dimension: average_time_on_site {
    type: number
    sql: ${TABLE}.average_time_on_site ;;
    hidden: yes
  }

  measure: average_daily_time_on_site {
    type: average
    hidden: yes
    description: "Total duration of all sessions (in seconds) / number of sessions, by day."
    sql: ${average_time_on_site} ;;
    drill_fields: [details*]
  }

  dimension: bounce_rate {
    type: number
    sql: ${TABLE}.bounce_rate ;;
    value_format_name: percent_2
    hidden: yes

  }

  measure: average_daily_bounce_rate {
    type: average
    value_format_name: percent_2
    hidden: yes
    description: "Percentage of clicks where the user only visited a single page on your site."
    sql: ${bounce_rate} ;;
    drill_fields: [details*]
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
    hidden: yes
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    description: "The number of clicks."
    drill_fields: [details*]
  }

  dimension: conversion_value {
    type: number
    sql: ${TABLE}.conversion_value ;;
    hidden: yes
  }

  measure: average_daily_conversion_value {
    type: average
    sql: ${conversion_value} ;;
    hidden: yes
    description: "The sum of conversion values for all conversions."
    drill_fields: [details*]
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
    hidden: yes
  }

  measure: total_conversions {
    type: sum
    description: "The number of conversions for all conversion actions that you have opted into optimization."
    sql: ${conversions} ;;
    drill_fields: [details*]
  }

  dimension: cost_per_click {
    type: number
    sql: ${cost}/(NULLIF(${clicks},0)) ;;
  }

  measure: average_cost_per_conversion {
    type: number
    sql: ${total_cost}*1.0 / NULLIF(${total_conversions},0) ;;
    value_format_name: usd
    drill_fields: [details*]
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost/1000000;;
    value_format_name: usd
    hidden: yes
  }

  measure: total_cost {
    type: sum
    description: "The sum of your cost-per-click (CPC) and cost-per-thousand impressions (CPM) costs during this period."
    sql: ${cost} ;;
    value_format_name: usd
    drill_fields: [details*]
  }

  dimension: engagements {
    type: number
    sql: ${TABLE}.engagements ;;
    hidden: yes
  }

  measure: total_engagements {
    type: sum
    hidden: yes
    description: "The number of engagements. An engagement occurs when a viewer expands your Lightbox ad."
    sql: ${engagements} ;;
    drill_fields: [details*]
  }

  dimension: impression_assisted_conversions {
    type: number
    sql: ${TABLE}.impression_assisted_conversions ;;
    hidden: yes
  }

  measure: total_impression_assisted_conversions {
    description: "Total number of conversions for which this object triggered assist impressions prior to the last click."
    type: sum
    sql: ${impression_assisted_conversions} ;;
    drill_fields: [details*]
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
    hidden: yes
  }

  measure: total_impressions {
    type: sum
    description: "Count of how often your ad has appeared on a search results page or website on the Google Network."
    sql: ${impressions} ;;
    drill_fields: [details*]
  }

  dimension: interaction_types {
    description: "The types of interactions that are reflected in the Interactions, Interaction Rate, and Average Cost columns."
    type: string
    sql: ${TABLE}.interaction_types ;;
  }

  dimension: interactions {
    type: number
    hidden: yes
    sql: ${TABLE}.interactions ;;
    drill_fields: [details*]
  }

  measure: total_interactions {
    type: sum
    sql: ${interactions} ;;
    description: "The number of interactions. An interaction is the main user action associated with an ad format—clicks for text and shopping ads, views for video ads, and so on."
    drill_fields: [details*]
  }

  dimension: view_through_conversions {
    type: number
    sql: ${TABLE}.view_through_conversions ;;
    hidden: yes
  }

  measure: total_view_through_conversions {
    description: "The total number of view-through conversions. These happen when a customer sees a Display network ad, then later completes a conversion on your site without interacting with (e.g. clicking on) another ad."
    type: sum
    hidden: yes
    sql: ${view_through_conversions} ;;

  }

##### Click-Assisted #####

##### Assist clicks occur only when more than one search ad has been clicked prior to a conversion.
##### Understanding sssist clicks can prevent optimization mistakes
##### such as the pausing of keywords that start a search which ultimately ends up in a conversion.

  dimension: click_assisted_conversions {
    type: number
    sql: ${TABLE}.click_assisted_conversions ;;
    hidden: yes
  }

  measure: total_click_assisted_conversions {
    type: sum
    description: "The total number of conversions for which this keyword, ad, ad group, or campaign contributed one or more assist clicks."
    sql: ${click_assisted_conversions} ;;
  }

  dimension: click_assisted_conversion_value {
    type: number
    sql: ${TABLE}.click_assisted_conversion_value ;;
    hidden: yes
  }

  measure: total_click_assisted_conversion_value {
    type: sum
    hidden: yes
    description: "The total *value* of all conversions for which this keyword, ad, ad group, or campaign triggered assist clicks."
    sql: ${click_assisted_conversion_value} ;;
    drill_fields: [details*]
  }

  dimension: click_assisted_conversions_over_last_click_conversions {
    type: number
    sql: ${TABLE}.click_assisted_conversions_over_last_click_conversions ;;
    hidden: yes
  }

  measure: average_daily_percent_assister_vs_closer {
    description: "Ratio of this ad being a click assisted converter to it being the last click converter. Higher ratio = assister, lower ratio = closer"
    type: average
    value_format_name: percent_2
    sql: ${click_assisted_conversions_over_last_click_conversions} ;;
    drill_fields: [details*]
  }

  measure: average_conversion_rate {
    type: number
    sql: ${total_conversions}*1.0 / NULLIF(${total_clicks},0) ;;
    value_format_name: percent_2
    drill_fields: [details*]
  }

  measure: average_interaction_rate{
    type: number
    sql: ${total_interactions}*1.0/nullif(${total_impressions},0) ;;
    value_format_name: percent_2
    drill_fields: [details*]
  }

  measure: total_cost_per_click {
    type:  sum
    sql: ${cost_per_click} ;;
    value_format_name: usd
    drill_fields: [details*]
  }

  measure: average_cost_per_click {
    type:  average
    sql: ${cost_per_click} ;;
    value_format_name: usd
    drill_fields: [details*]
  }

  set: details {
    fields: [ad_id,ad_groups.name, ad_campasigns.name, cost, cost_per_click, total_impressions, total_clicks, total_conversions]
  }

##### Gmail #####

#   dimension: gmail_forwards {
#     type: number
#     sql: ${TABLE}.gmail_forwards ;;
#     hidden: yes
#   }
#
#   measure: total_gmail_forwards {
#     type: sum
#     sql: ${gmail_forwards} ;;
#   }
#
#   dimension: gmail_saves {
#     type: number
#     sql: ${TABLE}.gmail_saves ;;
#     hidden: yes
#   }
#
#   measure: total_gmail_saves {
#     type: sum
#     sql: ${gmail_saves} ;;
#   }
#
#   dimension: gmail_secondary_clicks {
#     type: number
#     sql: ${TABLE}.gmail_secondary_clicks ;;
#     hidden: yes
#   }
#
#   measure: total_gmail_secondary_clicks {
#     type: sum
#     sql: ${gmail_secondary_clicks} ;;
#   }

##### Video #####
#Not Populated

#   dimension: video_quartile_100_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_100_rate ;;
#   }
#
#   dimension: video_quartile_25_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_25_rate ;;
#   }
#
#   dimension: video_quartile_50_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_50_rate ;;
#   }
#
#   dimension: video_quartile_75_rate {
#     type: number
#     sql: ${TABLE}.video_quartile_75_rate ;;
#   }
#
#   dimension: video_view_rate {
#     type: number
#     sql: ${TABLE}.video_view_rate ;;
#   }
#
#   dimension: video_views {
#     type: number
#     sql: ${TABLE}.video_views ;;
#   }
#

#

}
