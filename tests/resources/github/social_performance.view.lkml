view: social_performance {
  label: "Social Performance"
  sql_table_name: "DWH"."FACT_SOCIAL"
    ;;

# Parameters and corresponding dimensions

# This parameter is used to allow the user to toggle between different timeframe granularities
  parameter: timeframe_filter {
    description: "This parameter is used to allow the user to toggle between different timeframe granularities. Use with the 'Timeframe' dimension."
    view_label: "Parameter Fields"
    allowed_value: { value: "Day" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    default_value: "Week"
  }


# References the 'timeframe_filter' parameter above. When 'timeframe_filter' is applied, use this dimension to show the corresponding date granularity.
  dimension: timeframe {
    view_label: "Parameter Fields"
    description: "References the 'Timeframe Filter' parameter. When 'Timeframe Filter' is applied, use this dimension to show the corresponding date granularity."
    sql: CASE
          WHEN {% parameter timeframe_filter %} = 'Day' THEN ${date_date}::varchar
          WHEN {% parameter timeframe_filter %} = 'Week' THEN ${date_week}
          WHEN {% parameter timeframe_filter %} = 'Month' THEN ${date_month}
        END ;;
    label_from_parameter: timeframe_filter
  }

#  References the 'timeframe_filter' parameter above. This is used to determine how many days to look back for certain KPI tiles.
  dimension: timeframe_day_number {
    view_label: "Parameter Fields"
    description: "References the 'Timeframe Filter' parameter. When 'Timeframe Filter' is applied, use this dimension to show the corresponding days in the timeframe."
    type: number
    sql: CASE
    WHEN {% parameter timeframe_filter %} = 'Day' THEN 1
    WHEN {% parameter timeframe_filter %} = 'Week' THEN 7
    WHEN {% parameter timeframe_filter %} = 'Month' THEN 30
    END ;;
  }

# This parameter allows for users to toggle between dynamic intervals of the last N posts.
  parameter: post_interval_selector {
    view_label: "Parameter Fields"
    description: "This parameter allows for users to toggle between dynamic intervals of the last N posts. Use this with the 'Post Interval' dimension field."
    allowed_value: {
      label:"5"
      value: "5"
    }
    allowed_value: {
      label:"10"
      value: "10"
      }
    allowed_value: {
      label:"20"
      value: "20"
    }
    default_value: "10"
  }

# References the 'post_interval' parameter. This is used to apply the lookback number in table calculations based on what the user selects from the parameter filter.
  dimension:  post_interval {
    view_label: "Parameter Fields"
    type: number
    sql: CASE
          WHEN {% parameter post_interval_selector %} = '5' THEN 5
          WHEN {% parameter post_interval_selector %} = '10' THEN 10
          WHEN {% parameter post_interval_selector %} = '20' THEN 20
          END ;;
  }

  dimension: account_id {
    view_label: "Page Fields"
    type: string
    sql: ${TABLE}."ACCOUNT_ID" ;;
  }

  dimension: account_name {
    view_label: "Page Fields"
    type: string
    sql: ${TABLE}."ACCOUNT_NAME" ;;
  }

  dimension: channel {
    description: "Social channel: Facebook, Instagram, or Twitter."
    view_label: "Page Fields"
    type: string
    sql: ${TABLE}."CHANNEL" ;;
  }

  dimension: comments {
    type: number
    sql: ${TABLE}."COMMENTS" ;;
    hidden: yes
  }

  measure: comment_count {
    view_label: "Post Fields"
    description: "Post-level comment count. For Twitter data, this includes tweet replies."
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${comments} ;;
  }

  dimension_group: created {
    type: time
    description: "Create date of a post. Use when exploring metrics at the post level."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_DATE" ;;
    view_label: "Post Fields"
  }

  dimension_group: date {
    view_label: "Page Fields"
    description: "Date corresponding to page or account-level insights. Use when exploring metrics at the page or account level."
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE" ;;
  }


  dimension: engagement {
    type: number
    sql: ${TABLE}."ENGAGEMENT" ;;
    hidden: yes
  }

  measure: post_engagement {
    type: sum_distinct
    view_label: "Post Fields"
    drill_fields: [dimension_drill*]
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${engagement} ;;
  }

  measure: engagement_rate {
    view_label: "Post Fields"
    description: "Engagement / Impressions"
    type: number
    value_format_name: percent_2
    sql: ${post_engagement}/nullif(${post_impressions},0) ;;
  }

  dimension: favorite_count { # Twitter only
    type: number
    sql: ${TABLE}."FAVORITE_COUNT" ;;
    hidden: yes
  }

  measure: post_favorite_count { # Twitter only
    view_label: "Post Fields"
    description: "Tweet favorites"
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${favorite_count} ;;
  }

  dimension: ig_id {
    view_label: "Post Fields"
    type: string
    sql: ${TABLE}."IG_ID" ;;
    hidden: yes
  }

  dimension: impressions {
  type: number
  sql: ${TABLE}."IMPRESSIONS"  ;;
  hidden: yes
  }

  measure: post_impressions {
    view_label: "Post Fields"
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${impressions} ;;
  }

  dimension: is_hidden { # Facebook only
    view_label: "Post Fields"
    type: yesno
    sql: ${TABLE}."IS_HIDDEN" ;;
  }

  dimension: is_published { # Facebook only
    view_label: "Post Fields"
    type: yesno
    sql: ${TABLE}."IS_PUBLISHED" ;;
  }

  dimension: likes {
    type: number
    sql: ${TABLE}."LIKES" ;;
    hidden: yes
  }

  measure: like_count {
    view_label: "Post Fields"
    type: sum_distinct
    sql_distinct_key:${post_id} || ${account_id} ;;
    sql: ${likes} ;;
  }

  dimension: link_clicks { # Facebook only
    type: number
    sql: ${TABLE}."LINK_CLICKS" ;;
    hidden: yes
  }

  measure: facebook_link_clicks { # Facebook only
    view_label: "Post Fields"
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id}  ;;
    sql: ${link_clicks} ;;
  }

  dimension: media_type {
    view_label: "Post Fields"
    type: string
    sql: ${TABLE}."MEDIA_TYPE" ;;
  }

  dimension: media_url {
    view_label: "Post Fields"
    type: string
    sql: ${TABLE}."MEDIA_URL" ;;
  }

  dimension: other_clicks { # Facebook only
    type: number
    sql: ${TABLE}."OTHER_CLICKS" ;;
    hidden: yes
  }

  measure: facebook_other_clicks { # Facebook only
    view_label: "Post Fields"
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id}  ;;
    sql: ${other_clicks} ;;
  }

  dimension: owner_id {
    view_label: "Post Fields"
    hidden: yes
    type: number
    sql: ${TABLE}."OWNER_ID" ;;
  }

  dimension: page_consumptions { # Facebook only
    view_label: "Page Fields"
    type: number
    sql: ${TABLE}."PAGE_CONSUMPTIONS" ;;
    hidden: yes
  }

  measure: page_consumptions_daily { # Facebook only
    view_label: "Page Fields"
    description: "Number of consumptions per page per day. Facebook only."
    type: sum_distinct
    sql_distinct_key: ${account_id} || ${date_date};;
    sql: ${page_consumptions} ;;
  }

  dimension: page_engaged_users { # Facebook only
    type: number
    sql: ${TABLE}."PAGE_ENGAGED_USERS" ;;
    hidden: yes
  }

  measure: page_engaged_users_daily { # Facebook only
    view_label: "Page Fields"
    description: "Number of engaged users per page per day. Facebook only."
    type: sum_distinct
    sql_distinct_key: ${account_id} || ${date_date};;
    sql: ${page_engaged_users} ;;
  }

  measure: page_engaged_users_avg { # Facebook only
    view_label: "Page Fields"
    value_format: "0.00"
    type: average_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_engaged_users} ;;
  }

  measure: page_engagement_rate { # Facebook only
    view_label: "Page Fields"
    description: "Page engaged users / Page impressions. Facebook only."
    type: number
    value_format_name: percent_2
    sql:${page_engaged_users}/nullif(${page_impressions},0) ;;
  }

  dimension: page_fan_adds { # Facebook only
    type: number
    sql: ${TABLE}."PAGE_FAN_ADDS" ;;
    hidden: yes
  }

  measure: page_fan_adds_daily { # Facebook only
    view_label: "Page Fields"
    description: "Number of new fans per page per day. Facebook only."
    type: sum_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_fan_adds} ;;
  }

  dimension: page_fan_count { # Facebook only
    type: number
    sql:  ${TABLE}."PAGE_FAN_COUNT" ;;
    hidden: yes
  }

  measure: page_fan_count_daily { # Facebook only
    view_label: "Page Fields"
    description: "Number of total fans per page per day. Facebook only."
    drill_fields: [page_fans_drill*]
    type: sum_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_fan_count} ;;
  }


  dimension: page_fan_count_today { # Facebook only
    type:  number
    sql: ${TABLE}."PAGE_FAN_COUNT_TODAY" ;;
    hidden: yes
  }

  dimension: page_fan_removes { # Facebook only
    view_label: "Page Fields"
    type: number
    sql: ${TABLE}."PAGE_FAN_REMOVES" ;;
    hidden: yes
  }

  measure: page_fan_removes_daily { # Facebook only
    view_label: "Page Fields"
    description: "Number of removed fans per page per day. Facebook only."
    type: sum_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_fan_removes} ;;
  }

  dimension: page_impressions {
    type: number
    sql: ${TABLE}."PAGE_IMPRESSIONS";;
    hidden: yes
  }

  measure: page_impressions_daily {
    view_label: "Page Fields"
    description: "Number of impressions per page per day. Facebook and Instagram only."
    type: sum_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_impressions};;
  }

  measure: page_impressions_avg {
    view_label: "Page Fields"
    description: "Average number of impressions per page per day. Facebook and Instagram only."
    value_format: "0.00"
    drill_fields: [account_name, created_date, title_caption, post_impressions, post_reach]
    type: average_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_impressions} ;;
  }

  measure: page_impressions_current_30 {
    type: sum_distinct
    view_label: "Time Comparison Fields"
    description: "Number of impressions per page for the last 30 days. Facebook and Instagram only."
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    drill_fields: [date_drill*]
    sql: ${page_impressions};;
    filters: {
      field: date_date
      value: "30 days"
    }
  }

  measure: page_impressions_previous_30 {
    type: sum_distinct
    view_label: "Time Comparison Fields"
    description: "Number of impressions per page for the previous 30 days. Facebook and Instagram only."
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    drill_fields: [date_drill*]
    sql: ${page_impressions};;
    filters: {
      field: date_date
      value: "60 days ago for 30 days"
    }
  }

  measure: page_impressions_percent_change {
    type: number
    view_label: "Time Comparison Fields"
    description: "Percent change between impression count for the last 30 days compared to the previous 30 days. Facebook and Instagram only."
    value_format_name: percent_2
    sql: (${page_impressions_current_30}-${page_impressions_previous_30})/ NULLIF(${page_impressions_previous_30},0) ;;
  }


  dimension: page_reach {
    type: number
    sql: ${TABLE}."PAGE_REACH" ;;
    hidden: yes
  }

  measure: page_reach_daily {
    view_label: "Page Fields"
    description: "Number of unique impressions per page per day. Facebook and Instagram only."
    type: sum_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_reach} ;;
  }

  measure: page_reach_avg {
    view_label: "Page Fields"
    description: "Average number of unique impressions per page per day. Facebook and Instagram only."
    value_format: "0.00"
    type: average_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_reach} ;;
  }


  measure: page_reach_current_30 {
    type: sum_distinct
    view_label: "Time Comparison Fields"
    description: "Number of unique impressions per page for the last 30 days. Facebook and Instagram only."
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_reach} ;;
    filters: {
      field: date_date
      value: "30 days"
    }
  }

  measure: page_reach_previous_30 {
    type: sum_distinct
    view_label: "Time Comparison Fields"
    description: "Number of unique impressions per page for the previous 30 days. Facebook and Instagram only."
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_reach} ;;
    filters: {
      field: date_date
      value: "60 days ago for 30 days"
    }
  }

  measure: page_reach_percent_change {
    type: number
    view_label: "Time Comparison Fields"
    description: "Percent change between unique impression count for the last 30 days compared to the previous 30 days. Facebook and Instagram only."
    value_format_name: percent_2
    sql: (${page_reach_current_30}-${page_reach_previous_30})/ NULLIF(${page_reach_previous_30},0) ;;
  }

  dimension: page_views{ # Facebook only
    type: number
    sql: ${TABLE}."PAGE_VIEWS" ;;
    hidden: yes
  }

  measure: page_views_daily { # Facebook only
    view_label: "Page Fields"
    description: "Number of views per page per day. Facebook only."
    type: sum_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${page_views} ;;
  }

  dimension: permalink {
    view_label: "Post Fields"
    type: string
    sql: ${TABLE}."PERMALINK" ;;
  }

  dimension: photo_view { # Facebook only
    type: number
    sql: ${TABLE}."PHOTO_VIEW" ;;
    hidden: yes
  }

  measure: facebook_photo_views { # Facebook only
    view_label: "Post Fields"
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id}  ;;
    sql: ${photo_view} ;;
  }

  dimension: post_id {
    view_label: "Post Fields"
    type: string
    sql: ${TABLE}."POST_ID" ;;
  }

  dimension: post_description {
    view_label: "Post Fields"
    type: string
    sql: ${TABLE}."POST_DESCRIPTION" ;;
  }

  dimension: post_title {
    view_label: "Post Fields"
    type: string
    sql: ${TABLE}."POST_TITLE" ;;
  }

  dimension: reach {
    type: number
    sql: ${TABLE}."REACH" ;;
    hidden: yes
  }

  measure: post_reach {
    view_label: "Post Fields"
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${reach} ;;
  }

  dimension: retweets { # Twitter only
    type: number
    sql: ${TABLE}."RETWEETS" ;;
    hidden: yes
  }

  measure: retweet_count { # Twitter only
    view_label: "Post Fields"
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${TABLE}."RETWEETS" ;;
  }


  dimension: saved { # Instagram only
    type: number
    sql: ${TABLE}."SAVED" ;;
    hidden: yes
  }

  measure: saved_count { # Instagram only
    view_label: "Post Fields"
    description: "Instagram saves."
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${saved} ;;
  }

  dimension: shares {
    type: number
    sql: ${TABLE}."SHARES" ;;
    hidden: yes
  }

  measure: share_count {
    view_label: "Post Fields"
    description: "Facebook shares."
    type: sum_distinct
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${shares} ;;
  }

  dimension: title_caption {
    view_label: "Post Fields"
    description: "The main descriptive message of a post."
    type: string
    sql: ${TABLE}."TITLE_CAPTION" ;;
  }

  dimension: total_followers {
    type: number
    sql: ${TABLE}."TOTAL_FOLLOWERS" ;;
    hidden: yes
  }

  measure: total_followers_daily {
    view_label: "Page Fields"
    description: "Follower daily totals for Instagram and Twitter accounts."
    type: sum_distinct
    sql_distinct_key: ${account_id}|| ${date_date} ;;
    sql: ${total_followers} ;;
  }

  dimension: video_play_clicks { # Facebook only
    type: number
    sql: ${TABLE}."VIDEO_PLAY_CLICKS" ;;
    hidden: yes
  }

  measure: facebook_video_play_clicks { # Facebook only
    type: sum_distinct
    view_label: "Post Fields"
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${video_play_clicks} ;;
  }


  dimension: video_views {
    type: number
    sql: ${TABLE}."VIDEO_VIEWS" ;;
    hidden: yes
  }

  measure: video_view_count {
    view_label: "Post Fields"
    type: sum
    sql_distinct_key: ${post_id} || ${account_id};;
    sql: ${video_views} ;;

  }

  measure: count_distinct_posts {
    view_label: "Page Fields"
    type: count_distinct
    sql: ${post_id} ;;
  }

  measure: count_distinct_posts_current_month {
    view_label: "Time Comparison Fields"
    type: count_distinct
    sql: ${post_id} ;;
    filters: {
      field: created_date
      value: "30 days"
    }
  }


  measure: count_distinct_posts_previous_month {
    type: count_distinct
    view_label: "Time Comparison Fields"
    sql: ${post_id} ;;
    filters: {
      field: created_date
      value: "60 days ago for 30 days"
    }
  }

  measure: count_distinct_posts_monthly_change {
    view_label: "Time Comparison Fields"
    type: number
    value_format_name: percent_2
    sql: (${count_distinct_posts_current_month}-${count_distinct_posts_previous_month})/ NULLIF(${count_distinct_posts_previous_month},0) ;;
  }

  set: dimension_drill {
    fields: [channel, account_name, media_type]
  }

  set: date_drill {
    fields: [date_year, date_month, date_date]
  }


  set: detail_drill {
    fields: [channel, account_name, media_type, date_date, title_caption]
  }

  set: page_fans_drill {
    fields: [date_drill*, page_fan_adds_daily, page_fan_removes_daily]
  }


}
