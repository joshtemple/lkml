view: ndt_premium_display_travel {
  derived_table: {
    explore_source: sdt_dcm {
      column: publisher {field: sdt_dcm_ga_view.publisher}
      column: campaign {field: sdt_dcm_ga_view.sdt_campaign}
      column: placement {field: sdt_dcm_ga_view.sdt_placement}
      column: ad_size {field: sdt_dcm_ga_view.ad_size}
      column: date {field: sdt_dcm_ga_view.date_date}
      column: week {field: sdt_dcm_ga_view.date_week}
      column: month {field: sdt_dcm_ga_view.date_month}
      column: total_impressions {field: sdt_dcm_ga_view.total_impressions}
      column: total_viewable_impressions {field: sdt_dcm_ga_view.total_active_view_viewable_impressions}
      column: total_measureable_impressions {field: sdt_dcm_ga_view.total_active_view_measureable_impressions}
      column: total_clicks {field: sdt_dcm_ga_view.total_clicks}
      column: total_cost {field: sdt_dcm_ga_view.total_cost}
      column: total_sessions {field: sdt_dcm_ga_view.total_sessions}
      column: total_session_duration {field: sdt_dcm_ga_view.total_session_duration}
      filters: {
        field: sdt_dcm_ga_view.sdt_campaign
        value: "Premium Digital Display"
      }
      filters: {
        field: sdt_dcm_ga_view.publisher
        value: "Travel + Leisure"
      }
      filters: {
        field: sdt_dcm_ga_view.sdt_placement
        value: "-T+L - Social Amplification"
      }

    }
    datagroup_trigger: sdt_premium_digital_datagroup
    distribution_style: all
  }

  dimension: publisher {
    type: string
  }

  dimension: campaign {
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
