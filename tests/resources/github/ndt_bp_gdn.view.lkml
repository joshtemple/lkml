view: ndt_bp_gdn {
  derived_table: {
    explore_source: sdt_gdn {
      column: publisher {field: sdt_gdn_ga_view.publisher}
      column: campaign {field: sdt_gdn_ga_view.sdt_campaign}
      column: placement {field: sdt_gdn_ga_view.sdt_placement}
      column: ad_size {field: sdt_gdn_ga_view.ad_size}
      column: date {field: sdt_gdn_ga_view.day_date}
      column: week {field: sdt_gdn_ga_view.day_week}
      column: month {field: sdt_gdn_ga_view.day_month}
      column: total_impressions {field: sdt_gdn_ga_view.total_impressions}
      column: total_clicks {field: sdt_gdn_ga_view.total_clicks}
      column: total_cost {field: sdt_gdn_ga_view.total_cost}
      column: total_sessions {field: sdt_gdn_ga_view.total_sessions}
      column: total_session_duration {field: sdt_gdn_ga_view.total_session_duration}
      filters: {
        field: sdt_gdn_ga_view.sdt_campaign
        value: "Balboa Park Digital"
      }
    }
    datagroup_trigger: sdt_bp_datagroup
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
