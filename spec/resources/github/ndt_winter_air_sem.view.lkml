view: ndt_winter_air_sem {
  derived_table: {
    explore_source: mam_sem {
      column: publisher {field:mam_sem_ga_view.publisher}
      column: campaign {field:mam_sem_ga_view.mam_campaign}
      column: region {field:mam_sem_ga_view.region}
      column: placement {field:mam_sem_ga_view.mam_placement}
      column: date {field: mam_sem_ga_view.day_date}
      column: week {field: mam_sem_ga_view.day_week}
      column: month {field: mam_sem_ga_view.day_month}
      column: total_impressions {field:mam_sem_ga_view.total_impressions}
      column: total_clicks {field:mam_sem_ga_view.total_clicks}
      column: total_cost {field:mam_sem_ga_view.total_cost}
      column: total_conversions {field:mam_sem_ga_view.total_conversions}
      column: total_sessions {field:mam_sem_ga_view.total_sessions}
      column: total_session_duration {field:mam_sem_ga_view.total_session_duration}
      filters: {
        field: mam_sem_ga_view.mam_campaign
        value: "Winter Air Service"
      }
    }
    datagroup_trigger: mam_winter_air_datagroup
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
  }

  dimension: total_conversions {
    type: number
  }

  dimension: total_sessions {
    type: number
  }

  dimension: total_session_duration {
    type: number
  }
}
