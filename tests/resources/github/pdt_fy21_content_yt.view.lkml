view: pdt_fy21_content_yt {
  derived_table: {
    explore_source: sdt_yt {
      column: publisher {field: sdt_yt_ga_view.publisher}
      column: campaign {field: sdt_yt_ga_view.sdt_campaign}
      column: market {field: sdt_yt_ga_view.sdt_market}
      column: layer {field: sdt_yt_ga_view.sdt_layer}
      column: region {field: sdt_yt_ga_view.sdt_region}
      column: placement {field: sdt_yt_ga_view.sdt_placement}
      column: creative_name {field: sdt_yt_ga_view.creative_name}
      column: pillar {field: sdt_yt_ga_view.sdt_pillar}
      column: ad_size {field: sdt_yt_ga_view.ad_size}
      column: date {field: sdt_yt_ga_view.day_date}
      column: week {field: sdt_yt_ga_view.day_week}
      column: month {field: sdt_yt_ga_view.day_month}
      column: total_impressions {field: sdt_yt_ga_view.total_impressions}
      column: total_clicks {field: sdt_yt_ga_view.total_clicks}
      column: total_cost {field: sdt_yt_ga_view.total_cost}
      column: total_views {field: sdt_yt_ga_view.total_views}
      column: total_completes {field: sdt_yt_ga_view.total_video_completes}
      column: total_sessions {field: sdt_yt_ga_view.total_sessions}
      column: total_session_duration {field: sdt_yt_ga_view.total_session_duration}
      filters: {
        field: sdt_yt_ga_view.campaign
        value: "%FY21^_SDT^_AlwaysOnContent%"
      }
    }
    datagroup_trigger: sdt_content_datagroup
    distribution_style: all
  }

  dimension: publisher {
    type: string
  }

  dimension: campaign {
    type: string
  }

  dimension: market {
    type: string
  }

  dimension: region {
    type: string
  }

  dimension: layer {
    type: string
  }

  dimension: date {
    type: date
  }

  dimension: week {
    type: date
  }

  dimension: month {
    type: date
  }

  dimension: quarter {
    type: date
  }

  dimension: total_impressions {
    type: number
  }

  dimension: total_clicks {
    type: number
  }

  dimension: total_views {
    type: number
  }

  dimension: total_completes {
    type: number
  }

  dimension: total_cost {
    type: number
  }

  dimension: total_sessions {
    type: number
  }

  dimension: total_session_duration {
    type: number
  }

  measure: count {
    type: count
  }

}
