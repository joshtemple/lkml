view: sdt_fy20_ta_us_audext_video {
  sql_table_name: public.sdt_fy20_ta_us_audext_video ;;
  drill_fields: [id]

### Primary Key ###

  dimension: id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: passback_join { ## placement ID + date ALWAYS ##
    type: string
    hidden: yes
    sql: ${ad_id}||'_'||${date_date} ;;
  }

######## Dimensions from DCM that join to this table #######

  dimension: placement {
    type: string
    group_label: "DCM Dimensions"
    sql: ${sdt_dcm_ga_view.placement} ;;
  }

  dimension: sdt_placement {
    type: string
    group_label: "Client Dimensions"
    label: "Placement Name"
    sql: ${sdt_dcm_ga_view.sdt_placement} ;;
  }

  dimension: sdt_pillar {
    type: string
    group_label: "Client Dimensions"
    label: "Pillar"
    sql: ${sdt_dcm_ga_view.sdt_pillar} ;;
  }

  dimension: ad {
    type: string
    group_label: "DCM Dimensions"
    sql: ${sdt_dcm_ga_view.ad} ;;
  }

  dimension: publisher {
    type: string
    group_label: "DCM Dimensions"
    sql: 'TripAdvisor' ;;
  }

######## Dimensions native to passback file #######

  dimension_group: __senttime {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.__senttime ;;
  }

  dimension: __state {
    type: string
    hidden: yes
    sql: ${TABLE}.__state ;;
  }

  dimension_group: __updatetime {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.__updatetime ;;
  }

  dimension: ad_id {
    type: number
    group_label: "DCM Dimensions"
    sql: ${TABLE}.ad_id ;;
  }

  dimension: clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.clicks ;;
  }

  dimension: complete {
    type: number
    hidden: yes
    sql: ${TABLE}.complete ;;
  }

  dimension_group: date {
    type: time
    label: ""
    group_label: "Date Periods"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: first_quartile {
    type: number
    hidden: yes
    sql: ${TABLE}.first_quartile ;;
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.impressions ;;
  }

  dimension: media_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.media_cost ;;
  }

  dimension: mid_point {
    type: number
    hidden: yes
    sql: ${TABLE}.mid_point ;;
  }

  dimension: third_quartile {
    type: number
    hidden: yes
    sql: ${TABLE}.third_quartile ;;
  }

  dimension: view_time {
    type: number
    hidden: yes
    sql: ${TABLE}."total view time" ;;
  }

  dimension: video_start {
    type: number
    hidden: yes
    sql: ${TABLE}.video_start ;;
  }

### All measures go below ###

  measure: total_impressions {
    type: sum_distinct
    sql_distinct_key: ${id} ;;
    sql: ${impressions} ;;
  }

  measure: total_clicks {
    type: sum_distinct
    sql_distinct_key: ${id} ;;
    sql: ${clicks} ;;
  }

  measure: click_through_rate {
    type: number
    label: "CTR"
    sql: 1.0*${total_clicks}/nullif(${total_impressions}, 0) ;;
    value_format_name: percent_2
  }

  measure: total_cost {
    type: sum_distinct
    sql_distinct_key: ${id} ;;
    sql: ${media_cost} ;;
    value_format_name: usd
  }

  measure: cost_per_click {
    type: number
    label: "CPC"
    sql: ${total_cost}/nullif(${total_clicks}, 0) ;;
    value_format_name: usd
  }

  measure: cost_per_thousand {
    type: number
    label: "CPM"
    sql: 1.0*${total_cost}/nullif(${total_impressions}/1000, 0) ;;
    value_format_name: usd
  }

  measure: cost_per_view {
    type: number
    label: "CPV"
    sql: ${total_cost}/nullif(${total_views}, 0) ;;
    value_format_name: usd
  }

  measure: cost_per_complete {
    type: number
    label: "CPcV"
    sql: ${total_cost}/nullif(${total_completes}, 0) ;;
    value_format_name: usd
  }

  measure: total_view_time {
    type: sum_distinct
    hidden: yes
    group_label: "Video Stats"
    sql_distinct_key: ${id} ;;
    sql: ${view_time} ;;
  }

  measure: avg_view_time {
    type: number
    label: "Avg. View Time"
    sql: (${total_view_time}/nullif(${total_views}, 0))::float/86400 ;;
    value_format: "m:ss"
  }

  measure: total_views {
    type: sum_distinct
    group_label: "Video Stats"
    sql_distinct_key: ${id} ;;
    sql: ${video_start} ;;
  }

  measure: total_view_to_25 {
    type: sum_distinct
    label: "First Quartile Views"
    group_label: "Video Stats"
    sql_distinct_key: ${id} ;;
    sql: ${first_quartile} ;;
  }

  measure: total_view_to_50 {
    type: sum_distinct
    label: "Mid-Point Views"
    group_label: "Video Stats"
    sql_distinct_key: ${id} ;;
    sql: ${mid_point} ;;
  }

  measure: total_view_to_75 {
    type: sum_distinct
    label: "Third Quartile Views"
    group_label: "Video Stats"
    sql_distinct_key: ${id} ;;
    sql: ${third_quartile} ;;
  }

  measure: total_completes {
    type: sum_distinct
    label: "Completed Views"
    group_label: "Video Stats"
    sql_distinct_key: ${id} ;;
    sql: ${complete} ;;
  }

  measure: view_rate {
    type: number
    group_label: "Video Rates"
    sql: 1.0*${total_views}/nullif(${total_impressions}, 0) ;;
    value_format_name: percent_2
  }

  measure: first_quartile_rate {
    type: number
    label: "% Viewed to 25%"
    group_label: "Video Rates"
    sql: 1.0*${total_view_to_25}/nullif(${total_impressions}, 0) ;;
    value_format_name: percent_2
  }

  measure: mid_point_rate {
    type: number
    label: "% Viewed to 50%"
    group_label: "Video Rates"
    sql: 1.0*${total_view_to_50}/nullif(${total_impressions}, 0) ;;
    value_format_name: percent_2
  }

  measure: third_quartile_rate {
    type: number
    label: "% Viewed to 75%"
    group_label: "Video Rates"
    sql: 1.0*${total_view_to_75}/nullif(${total_impressions}, 0) ;;
    value_format_name: percent_2
  }

  measure: completion_rate {
    type: number
    group_label: "Video Rates"
    sql: 1.0*${total_completes}/nullif(${total_impressions}, 0) ;;
    value_format_name: percent_2
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
