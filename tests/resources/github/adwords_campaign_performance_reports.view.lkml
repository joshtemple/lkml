view: campaign_performance_reports {
  sql_table_name: adwords.campaign_performance_reports ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  filter: campaign_select {
    suggest_dimension: campaigns.name
  }

  dimension: campaign_comparitor {
    type: string
    sql: CASE WHEN {% condition campaign_select %} ${campaigns.name} {% endcondition %}
      THEN ${campaigns.name}
      ELSE 'Rest Of Population'
      END ;;
  }

  dimension: adwords_customer_id {
    type: string
    sql: ${TABLE}.adwords_customer_id ;;
    hidden: yes
  }

  dimension: base_campaign_id {
    type: string
    sql: ${TABLE}.base_campaign_id ;;
    hidden: yes
  }

  dimension: budget_id {
    type: string
    sql: ${TABLE}.budget_id ;;
    hidden: yes
  }

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  measure: total_campaigns {
    type: count_distinct
    sql: ${campaign_id} ;;
    drill_fields: [campaigns.name, total_cost]
  }

  dimension: uuid {
    type: number
    value_format_name: id
    sql: ${TABLE}.uuid ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, campaigns.id, campaigns.name]
  }

##### Time Dimensions #####

  dimension_group: start {
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

  dimension_group: stop {
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


##### Campaign-Specific Metrics #####

  dimension: advertising_channel_sub_type {
    type: string
    sql: ${TABLE}.advertising_channel_sub_type ;;
    hidden: yes
  }

  dimension: daily_budget {
    value_format_name: usd
    description: "The daily budget. This column reflects the entire shared budget if the campaign draws from a shared budget."
    type: number
    sql: ${TABLE}.amount/1000000 ;;
  }

  dimension: is_active_campaign {
    type: yesno
    sql: ${TABLE}.campaign_status = 'Status_Active' ;;
  }

  dimension: campaign_trial_type {
    type: string
    sql: ${TABLE}.campaign_trial_type ;;
    hidden: yes
    #only value in test data is BASE
    description: "The type of campaign. This shows if the campaign is a trial campaign or not."
  }

  dimension: impression_reach {
    type: string
    description: "Number of unique cookies that were exposed to your ad over a given time period, or the special value < 100 if the number of cookies is less than 100."
    hidden: yes
    #only value in table is '--'
    sql: ${TABLE}.impression_reach ;;
  }

  dimension: invalid_clicks {
    type: number
    sql: ${TABLE}.invalid_clicks ;;
    hidden: yes
  }

  measure: total_invalid_clicks {
    type: sum
    sql: ${invalid_clicks} ;;
    description: "Number of clicks Google considers illegitimate and doesn't charge you for."
  }

  dimension: is_budget_explicitly_shared {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_budget_explicitly_shared = 'true' ;;
  }

  dimension: url_custom_parameters {
    type: string
    hidden: yes
    #only value is '--'
    sql: ${TABLE}.url_custom_parameters ;;
  }

##### Active View #####

  dimension: active_view_impressions {
    type: number
    sql: ${TABLE}.active_view_impressions ;;
    hidden: yes
  }

  measure: total_active_view_impressions {
    type: sum
    sql: ${active_view_impressions} ;;
    description: "How often your ad has become viewable on a Display Network site."
    hidden: yes
  }

  dimension: active_view_measurability {
    type: number
    value_format_name: percent_2
    hidden: yes
    sql: ${TABLE}.active_view_measurability ;;
  }

  measure: average_daily_active_view_measurability {
    type: average
    hidden: yes
    sql: ${active_view_measurability} ;;
    description: "The ratio of impressions that could be measured by Active View over the number of served impressions."

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
    value_format_name: usd
    hidden: yes
    description: "The cost of the impressions you received that were measurable by Active View."

  }

  dimension: active_view_measurable_impressions {
    type: number
    sql: ${TABLE}.active_view_measurable_impressions ;;
    hidden: yes
  }

  measure: total_active_view_measurable_impressions {
    type: sum
    description: "The number of times your ads are appearing on placements in positions where they can be seen."
    sql: ${active_view_measurable_impressions} ;;
    hidden: yes
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
    hidden: yes
    description: "All Conversions divided by total clicks that can be conversion-tracked. Note: this is a best estimate performed by Google."
  }

  dimension: all_conversion_value {
    type: number
    sql: ${TABLE}.all_conversion_value ;;
    hidden: yes
  }

  measure: total_all_conversion_value {
    type: sum
    sql: ${all_conversion_value} ;;
    description: "The total value of all of your conversions, including those that are estimated. Note: this is a best estimate performed by Google."
    hidden: yes
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
  }

  dimension: average_position {
    type: number
    sql: ${TABLE}.average_position ;;
    value_format_name: decimal_2
    hidden: yes
  }

  measure: average_daily_ad_position {
    type: average
    sql: ${average_position} ;;
    value_format_name: decimal_2
    description: "Your ad's position relative to those of other advertisers."
  }

  dimension: average_time_on_site {
    type: number
    sql: ${TABLE}.average_time_on_site ;;
    hidden: yes
  }

  measure: average_daily_time_on_site {
    type: average
    description: "Total duration of all sessions (in seconds) / number of sessions, by day."
    sql: ${average_time_on_site} ;;
    hidden: yes
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
    description: "Percentage of clicks where the user only visited a single page on your site."
    sql: ${bounce_rate} ;;
    hidden: yes
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
    drill_fields: [start_date, total_impressions,total_clicks,total_conversions, total_cost]
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
    drill_fields: [start_date, total_conversions, total_cost]
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost/1000000 ;;
    value_format_name: usd
    hidden: yes
  }

  measure: total_cost {
    type: sum
    description: "The sum of your cost-per-click (CPC) and cost-per-thousand impressions (CPM) costs during this period."
    sql: ${cost} ;;
    value_format_name: usd
    drill_fields: [start_date, campaigns.name, total_cost]
  }

  measure: average_cost_per_conversion {
    type: number
    sql: ${total_cost}*1.0 / NULLIF(${total_conversions},0) ;;
    value_format_name: usd
    drill_fields: [start_date, campaigns.name, total_cost]
  }

  measure: average_conversion_rate {
    type: number
    sql: ${total_conversions}*1.0 / NULLIF(${total_clicks},0) ;;
    value_format_name: percent_2
    drill_fields: [start_date,average_conversion_rate]
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
    drill_fields: [start_date, total_impressions, total_clicks,total_conversions, total_cost]
  }

  dimension: interaction_types {
    description: "The types of interactions that are reflected in the Interactions, Interaction Rate, and Average Cost columns."
    type: string
    sql: ${TABLE}.interaction_types ;;
    hidden: yes
  }

  dimension: interactions {
    type: number
    hidden: yes
    sql: ${TABLE}.interactions ;;
  }

  measure: total_interactions {
    type: sum
    sql: ${interactions} ;;
    description: "The number of interactions. An interaction is the main user action associated with an ad format—clicks for text and shopping ads, views for video ads, and so on."
  }

  measure: average_interaction_rate{
    type: number
    sql: ${total_interactions}*1.0/nullif(${total_impressions},0) ;;
    value_format_name: percent_2
    drill_fields: [campaigns.name, average_interaction_rate]
  }

  dimension: view_through_conversions {
    type: number
    sql: ${TABLE}.view_through_conversions ;;
    hidden: yes
  }

  measure: total_view_through_conversions {
    description: "The total number of view-through conversions. These happen when a customer sees a Display network ad, then later completes a conversion on your site without interacting with (e.g. clicking on) another ad."
    type: sum
    sql: ${view_through_conversions} ;;
    hidden: yes
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
    description: "The total *value* of all conversions for which this keyword, ad, ad group, or campaign triggered assist clicks."
    sql: ${click_assisted_conversion_value} ;;
    hidden: yes
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
#not populated

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


}
