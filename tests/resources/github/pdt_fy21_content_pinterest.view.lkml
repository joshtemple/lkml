view: pdt_fy21_content_pinterest {
  derived_table: {
    explore_source: sdt_pinterest {
      column: publisher { field: sdt_pinterest_ga_view.publisher }
      column: campaign { field: sdt_pinterest_ga_view.sdt_campaign }
      column: market { field: sdt_pinterest_ga_view.sdt_market }
      column: layer { field: sdt_pinterest_ga_view.sdt_layer }
      column: region { field: sdt_pinterest_ga_view.sdt_region }
      column: placement { field: sdt_pinterest_ga_view.sdt_placement }
      column: creative_name { field: sdt_pinterest_ga_view.creative_name }
      column: pillar { field: sdt_pinterest_ga_view.sdt_pillar }
      column: ad_size { field: sdt_pinterest_ga_view.ad_size }
      column: date { field: sdt_pinterest_ga_view.date_date }
      column: week { field: sdt_pinterest_ga_view.date_week }
      column: month { field: sdt_pinterest_ga_view.date_month }
      column: total_impressions { field: sdt_pinterest_ga_view.total_impressions }
      column: total_clicks { field: sdt_pinterest_ga_view.total_clicks }
      column: total_cost { field: sdt_pinterest_ga_view.total_spend }
      column: total_views { field: sdt_pinterest_ga_view.content_video_views }
      column: total_completes { field: sdt_pinterest_ga_view.total_views_at_100 }
      column: total_sessions { field: sdt_pinterest_ga_view.total_sessions }
      column: total_session_duration { field: sdt_pinterest_ga_view.total_session_duration }
      filters: {
        field: sdt_pinterest_ga_view.campaign_name
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
    value_format_name: usd
  }

  dimension: total_sessions {
    type: number
  }

  dimension: total_session_duration {
    type: number
  }
}
