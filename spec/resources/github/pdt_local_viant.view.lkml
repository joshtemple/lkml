view: pdt_local_viant {
    derived_table: {
      explore_source: vnv_dcm {
        column: campaign {field: vnv_dcm_ga_view.vnv_campaign}
        column: publisher {field: vnv_dcm_ga_view.publisher}
        column: placement {field: vnv_dcm_ga_view.vnv_placement}
        column: creative_name {field: vnv_dcm_ga_view.creative_name}
        column: date {field: vnv_dcm_ga_view.date_date}
        column: week {field: vnv_dcm_ga_view.date_week}
        column: month {field: vnv_dcm_ga_view.date_month}
        column: quarter {field: vnv_dcm_ga_view.date_quarter}
        column: total_impressions {field: vnv_fy20_local_viant.total_impressions}
        column: total_clicks {field: vnv_fy20_local_viant.total_clicks}
        column: total_views {field: vnv_fy20_local_viant.total_video_views}
        column: total_completes {field: vnv_fy20_local_viant.total_video_completes}
        column: total_cost {field: vnv_fy20_local_viant.total_media_cost}
        column: total_sessions {field: vnv_dcm_ga_view.total_sessions}
        column: total_session_duration {field: vnv_dcm_ga_view.total_session_duration}
        filters: {
          field: vnv_dcm_ga_view.campaign
          value: "VNV FY20 Objective 5"
        }
        filters: {
          field: vnv_dcm_ga_view.publisher
          value: "Viant"
        }
      }
      datagroup_trigger: vnv_local_datagroup
      distribution_style: all
    }

    dimension: publisher {
      type: string
    }

    dimension: campaign {
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
