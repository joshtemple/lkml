view: channel_traffic_source_a2_ycr {
  sql_table_name: youtube_channel_reports.channel_traffic_source_a2_ycr ;;

  dimension_group: _data {
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
    sql: ${TABLE}._DATA_DATE ;;
  }

  dimension_group: _latest {
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
    sql: ${TABLE}._LATEST_DATE ;;
  }

  dimension: channel_id {
    type: string
    sql: ${TABLE}.channel_id ;;
  }

  dimension: country_code {
    hidden: yes
    type: string
    sql: ${TABLE}.country_code ;;
  }


  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: live_or_on_demand {
    type: string
    sql: ${TABLE}.live_or_on_demand ;;
  }

  dimension: subscribed_status {
    type: string
    sql: ${TABLE}.subscribed_status ;;
  }

  dimension: traffic_source_detail {
    type: string
    sql: ${TABLE}.traffic_source_detail ;;
  }

  dimension: traffic_source_type {
    hidden: yes
    type: number
    sql: ${TABLE}.traffic_source_type ;;
  }
  dimension: source_type {
    drill_fields: [traffic_source_detail]
    type: string
    sql: CASE
          WHEN ${traffic_source_type}=0 THEN 'Direct'
          WHEN ${traffic_source_type}=1 THEN 'YT Advertizing'
          WHEN ${traffic_source_type}=3 THEN 'Browse'
          WHEN ${traffic_source_type}=4 THEN 'Channels'
          WHEN ${traffic_source_type}=5 THEN 'Youtube Search'
          WHEN ${traffic_source_type}=7 THEN 'Suggested Videos'
          WHEN ${traffic_source_type}=8 THEN 'Other YT Features'
          WHEN ${traffic_source_type}=9 THEN 'External'
          WHEN ${traffic_source_type}=11 THEN 'Cards'
          WHEN ${traffic_source_type}=14 THEN 'Playlists'
          WHEN ${traffic_source_type}=17 THEN 'Notifications'
          WHEN ${traffic_source_type}=18 THEN 'Playlist Page'
          WHEN ${traffic_source_type}=19 THEN 'Claimed Content'
          WHEN ${traffic_source_type}=20 THEN 'End Screen'
          END
          ;;
  }

  dimension: video_id {
    type: string
    sql: ${TABLE}.video_id ;;
    html: <p> Video Title </p> ;;
  }


  ############################
####### YouTube Metrics ##########
  ############################

  dimension: average_view_duration_percentage {
#     hidden: yes
    type: number
    sql: ${TABLE}.average_view_duration_percentage ;;
  }
  dimension: average_view_duration_percentage_tier {
  type: tier
  sql: ${average_view_duration_percentage} ;;
  tiers: [0,25,50,75,100]
  allow_fill: no
  style: relational
  }
   measure: avg_view_duration_percentage {
    label: "Average View Duration (percentage)"
    type: average
    sql: ${average_view_duration_percentage} ;;
    value_format_name: percent_1
  }

  dimension: video_length_seconds {
    hidden: yes
    type: number
    sql: ROUND(${average_view_duration_seconds}/(nullif(${average_view_duration_percentage}/100,0)) );;
  }


  dimension: average_view_duration_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.average_view_duration_seconds ;;
  }
  dimension: average_view_duration_minutes_tier {
    type: tier
    sql: ${average_view_duration_seconds}/60 ;;
    tiers: [0,0.5,1,1.5,2,3,4,5,10,30,60]
    allow_fill: no
    style: relational

  }
  measure: avg_view_duration_s {
    label: "Average View Duration (seconds)"
    type: average
    sql: ${average_view_duration_seconds} ;;
    value_format_name: decimal_1
  }

  dimension: red_views {
    type: number
    sql: ${TABLE}.red_views ;;
  }
  measure: total_red_views {
    type: sum
    sql: ${red_views} ;;
  }
  measure: average_red_views {
    type: average
    sql: ${red_views} ;;
  }

  dimension: red_watch_time_minutes {
    type: number
    sql: ${TABLE}.red_watch_time_minutes ;;
  }


  dimension: views {
    hidden: yes
    type: number
    sql: ${TABLE}.views ;;
  }
  measure: total_views {
    type: sum
    sql: ${views} ;;
  }
  measure: average_views {
    type: average
    sql: ${views} ;;
  }

  dimension: watch_time_minutes {
    type: number
    sql: ${TABLE}.watch_time_minutes ;;
  }
  measure: total_watch_time_minutes {
    type: sum
    sql: ${watch_time_minutes} ;;
  }

  measure: video_count {
    type: count_distinct
    sql: ${video_id} ;;
    drill_fields: []
  }

  set: video_detail {
    fields: [video_id, total_views,]
  }
}
