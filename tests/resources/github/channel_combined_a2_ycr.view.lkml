view: channel_combined_a2_ycr {
  sql_table_name: youtube_channel_reports.channel_combined_a2_ycr ;;

  ###########################
#######YouTube Dimensions#######
  ###########################

  dimension: block_name {
    type: string
    sql: "YouTube" ;;
    link: {
      url: "https://googlecloud.looker.com/dashboards/62"
      label: "YouTube Dashboard"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }


  dimension_group: _data {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: TIMESTAMP(${TABLE}._DATA_DATE) ;;
  }

  dimension_group: _latest {
    hidden: yes
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
    sql: TIMESTAMP(${TABLE}._LATEST_DATE) ;;
  }

  dimension: channel_id {
    type: string
    sql: ${TABLE}.channel_id ;;
  }

  dimension: country_code {
    map_layer_name: countries
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: date {
    hidden: yes
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: device_type {
    hidden: yes
    type: number
    sql: ${TABLE}.device_type ;;
  }
  dimension: device {
    type: string
    sql: CASE WHEN ${device_type}=100 THEN 'Unknown'
              WHEN ${device_type}=101 THEN 'Computer'
              WHEN ${device_type}=102 THEN 'TV'
              WHEN ${device_type}=103 THEN 'Game Console'
              WHEN ${device_type}=104 THEN 'Mobile Phone'
              WHEN ${device_type}=105 THEN 'Tablet'
          END;;
  }

  dimension: live_or_on_demand {
    type: string
    sql: ${TABLE}.live_or_on_demand ;;
  }

  dimension: operating_system_code {
    hidden: yes
    type: number
    sql: ${TABLE}.operating_system ;;
  }
  dimension: operating_system {
    sql: CASE WHEN ${operating_system_code}=1 THEN 'Other'
              WHEN ${operating_system_code}=2 THEN 'Windows'
              WHEN ${operating_system_code}=3 THEN 'Windows Mobile'
              WHEN ${operating_system_code}=4 THEN 'Android'
              WHEN ${operating_system_code}=5 THEN 'iOS'
              WHEN ${operating_system_code}=6 THEN 'Symbian'
              WHEN ${operating_system_code}=7 THEN 'Blackberry'
              WHEN ${operating_system_code}=9 THEN 'Macintosh'
              WHEN ${operating_system_code}=10 THEN 'Playstation'
              WHEN ${operating_system_code}=11 THEN 'Bada'
              WHEN ${operating_system_code}=12 THEN 'WebOS'
              WHEN ${operating_system_code}=13 THEN 'Linux'
              WHEN ${operating_system_code}=14 THEN 'Hiptop'
              WHEN ${operating_system_code}=15 THEN 'MeeGo'
              WHEN ${operating_system_code}=16 THEN 'Wii'
              WHEN ${operating_system_code}=17 THEN 'Xbox'
              WHEN ${operating_system_code}=18 THEN 'PlayStation Vita'
              WHEN ${operating_system_code}=19 THEN 'Smart TV'
              WHEN ${operating_system_code}=20 THEN 'Nintendo 3DS'
              WHEN ${operating_system_code}=21 THEN 'Chromecast'
            ELSE NULL END;;
  }

  dimension: playback_location_type {
    hidden: yes
    type: number
    sql: ${TABLE}.playback_location_type ;;
  }
  dimension: playback_location {
    description: "This dimension identifies the type of page or application where user activity occurred"
    type: string
    sql: CASE WHEN ${playback_location_type}=0 THEN 'YT Page or App'
              WHEN ${playback_location_type}=1 THEN 'iframe embed'
              WHEN ${playback_location_type}=2 THEN 'YT Channel'
              WHEN ${playback_location_type}=5 THEN 'Unknown'
              WHEN ${playback_location_type}=7 THEN "YT User Home Page"
              WHEN ${playback_location_type}=8 THEN "YT Search Page"
          END    ;;
  }

  dimension: subscribed_status {
    description: "Is the user subscribed to the channel"
    type: string
    sql: ${TABLE}.subscribed_status ;;
  }

  dimension: traffic_source_type {
    hidden: yes
    type: number
    sql: ${TABLE}.traffic_source_type ;;
  }
  dimension: traffic_source {
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
    link: {
      label: "Watch Video"
      url: "http://youtube.com/watch?v={{ value }}"
      icon_url: "http://youtube.com/favicon.ico"
    }
    link: {
      label: "Video Dashboard"
      url: "/dashboards/?video%20id={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }



    ######################
#######You Tube Metrics#########
    ######################
  dimension: average_view_duration_percentage {
    hidden: yes
    type: number
    sql: ${TABLE}.average_view_duration_percentage ;;
  }

  measure: avg_view_duration_percentage {
    label: "Average View Duration (percentage)"
    type: average
    sql: ${average_view_duration_percentage} ;;
    value_format: "0.0\%"
    drill_fields: [video_detail*,avg_view_duration_percentage,-avg_view_duration_s]
  }

  dimension: average_view_duration_seconds {
    hidden: yes
    type: number
    sql: ${TABLE}.average_view_duration_seconds ;;
  }

  measure: avg_view_duration_s {
    label: "Average View Duration (seconds)"
    type: average
    sql: ${average_view_duration_seconds} ;;
    value_format_name: decimal_1
    drill_fields: [video_detail*]
  }

  dimension: red_views {
    hidden: yes
    type: number
    sql: ${TABLE}.red_views ;;
  }
  measure: total_red_views {
    type: sum
    sql: ${red_views} ;;
    drill_fields: [video_detail*]
  }
  measure: average_red_views {
    type: average
    sql: ${red_views} ;;
    drill_fields: [video_id,average_red_views]
  }

  dimension: red_watch_time_minutes {
    hidden: yes
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
    drill_fields: [video_id, video_facts.video_length_seconds,total_views,avg_view_duration_s]
  }
  measure: average_views {
    type: average
    sql: ${views} ;;
    drill_fields: [video_id,average_views]
  }

  dimension: watch_time_minutes {
    hidden: yes
    type: number
    sql: ${TABLE}.watch_time_minutes ;;
  }
  measure: total_watch_time_minutes {
    type: sum
    sql: ${watch_time_minutes} ;;
    drill_fields: [video_detail*,total_watch_time_minutes,-avg_view_duration_s]
  }

  measure: video_count {
    type: count_distinct
    sql: ${video_id} ;;
    drill_fields: [video_detail*]
  }

  measure:  count_sources {
    type: count_distinct
    sql: ${traffic_source_type} ;;
  }

  set: video_detail {
    fields: [video_id, video_facts.video_length_seconds,avg_view_duration_s,total_views]
  }

}
