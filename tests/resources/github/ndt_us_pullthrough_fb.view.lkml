view: ndt_us_pullthrough_fb {
  derived_table: {
    explore_source: sdt_fb {
      column: publisher {field: sdt_fb_ga_view.publisher}
      column: campaign {field: sdt_fb_ga_view.sdt_campaign}
      column: market {field: sdt_fb_ga_view.sdt_market}
      column: layer {field: sdt_fb_ga_view.sdt_layer}
      column: placement {field: sdt_fb_ga_view.sdt_placement}
      column: ad_size {field: sdt_fb_ga_view.ad_size}
      column: date {field: sdt_fb_ga_view.date_start_date}
      column: week {field: sdt_fb_ga_view.date_start_week}
      column: month {field: sdt_fb_ga_view.date_start_month}
      column: quarter {field: sdt_fb_ga_view.date_start_quarter}
      column: total_impressions {field: sdt_fb_ga_view.total_impressions}
      column: total_clicks {field: sdt_fb_ga_view.total_clicks}
      column: total_cost {field: sdt_fb_ga_view.total_spend}
      column: total_sessions {field: sdt_fb_ga_view.total_sessions}
      column: total_session_duration {field: sdt_fb_ga_view.total_session_duration}
      filters: {
        field: sdt_fb_ga_view.sdt_campaign
        value: "US Pull-Through"
      }
    }
    datagroup_trigger: sdt_us_pullthrough_datagroup
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

  dimension: layer {
    type: string
  }

  dimension: placement {
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
