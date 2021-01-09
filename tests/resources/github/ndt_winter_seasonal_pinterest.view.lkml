view: ndt_winter_seasonal_pinterest {
  derived_table: {
    explore_source: mam_pinterest {
      column: publisher {field: mam_pinterest_ga_view.publisher}
      column: campaign {field: mam_pinterest_ga_view.mam_campaign}
      column: region {field: mam_pinterest_ga_view.mam_region}
      column: placement {field: mam_pinterest_ga_view.mam_placement}
      column: date {field: mam_pinterest_ga_view.date_date}
      column: week {field: mam_pinterest_ga_view.date_week}
      column: month {field: mam_pinterest_ga_view.date_month}
      column: total_impressions {field: mam_pinterest_ga_view.total_impressions}
      column: total_clicks {field: mam_pinterest_ga_view.total_clicks}
      column: total_cost {field: mam_pinterest_ga_view.total_spend}
      column: total_sessions {field: mam_pinterest_ga_view.total_sessions}
      column: total_session_duration {field: mam_pinterest_ga_view.total_session_duration}
      column: total_views {field: mam_pinterest_ga_view.total_video_views}
      column: total_completes {field: mam_pinterest_ga_view.total_views_at_100}
      filters: {
        field: mam_pinterest_ga_view.mam_campaign
        value: "Winter Seasonal"
      }
    }
    datagroup_trigger: mam_winter_seasonal_datagroup
    distribution_style: all
  }

  dimension: publisher {
    type: string
  }

  dimension: campaign {
    type: string
  }

  dimension: region {
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

  dimension: total_views{
    type: number
  }
}
