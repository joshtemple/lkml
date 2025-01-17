view: video_facts {
  derived_table: {
    sql: SELECT
          channel_combined_a2_ycr.video_id  AS video_id,
          AVG(channel_combined_a2_ycr.average_view_duration_seconds ) AS avg_view_duration_s,
          MAX(ROUND((channel_combined_a2_ycr.average_view_duration_seconds/(nullif(channel_combined_a2_ycr.average_view_duration_percentage/100,0)) ))) AS video_length_seconds
        FROM youtube_channel_reports.channel_combined_a2_ycr  AS channel_combined_a2_ycr

        GROUP BY 1

       ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  dimension: video_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.video_id ;;
  }

  dimension: video_length_seconds {
    type: number
    sql: ${TABLE}.video_length_seconds ;;
  }

  dimension: video_length_minutes {
    type: number
    sql: ${video_length_seconds}/60 ;;
  }

  dimension: video_length_minutes_tier {
    type: tier
    style: relational
    tiers: [0,0.5,1,1.5,2,3,4,5,6,7,8,9,10,20,30,60]
    sql: ${video_length_minutes} ;;
    allow_fill: no
  }

  dimension: video_avg_view_duration_min {
    hidden:  yes
    type: number
    sql: ${TABLE}.avg_view_duration_s/60 ;;
  }
  dimension: video_avg_view_duration_minutes_tier {
    type: tier
    sql: ${video_avg_view_duration_min} ;;
    tiers: [0,0.5,1,1.5,2,3,4,5,10,30,60]
    allow_fill: no
    style: relational
}


  set: detail {
    fields: [video_id, video_length_seconds]
  }
}
