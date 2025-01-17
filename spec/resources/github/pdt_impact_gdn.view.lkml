view: pdt_impact_gdn {
  derived_table: {
    explore_source: vnv_gdn {
      column: publisher { field: vnv_gdn_ga_view.publisher }
      column: campaign { field: vnv_gdn_ga_view.vnv_campaign }
      column: placement { field: vnv_gdn_ga_view.vnv_placement }
      column: creative_name { field: vnv_gdn_ga_view.creative_name }
      column: ad_size { field: vnv_gdn_ga_view.ad_size }
      column: date { field: vnv_gdn_ga_view.day_date }
      column: week { field: vnv_gdn_ga_view.day_week }
      column: month { field: vnv_gdn_ga_view.day_month }
      column: quarter { field: vnv_gdn_ga_view.day_quarter }
      column: total_impressions { field: vnv_gdn_ga_view.total_impressions }
      column: total_clicks { field: vnv_gdn_ga_view.total_clicks }
      column: total_views { field: vnv_gdn_ga_view.total_views }
      column: total_completes { field: vnv_gdn_ga_view.total_completes }
      column: total_cost { field: vnv_gdn_ga_view.total_cost }
      column: total_sessions { field: vnv_gdn_ga_view.total_sessions }
      column: total_session_duration { field: vnv_gdn_ga_view.total_session_duration }
      filters: {
        field: vnv_gdn_ga_view.vnv_campaign
        value: "Impact"
      }
    }
    datagroup_trigger: vnv_impact_datagroup
    distribution_style: all
  }

  dimension: campaign {
    type: string
  }

  dimension: publisher {
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

  dimension: impressions {
    type: number
  }

  dimension: total_clicks {
    type: number
  }

  dimension: total_views {
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
}
