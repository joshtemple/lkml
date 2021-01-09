view: pdt_foundational_fb {
derived_table: {
  explore_source: vnv_fb {
    column: campaign {field: vnv_fb_ga_view.vnv_campaign}
    column: publisher {field: vnv_fb_ga_view.publisher}
    column: placement {field: vnv_fb_ga_view.vnv_placement}
    column: creative_name {field: vnv_fb_ga_view.creative_name}
    column: date {field: vnv_fb_ga_view.date_start_date}
    column: week {field: vnv_fb_ga_view.date_start_week}
    column: month {field: vnv_fb_ga_view.date_start_month}
    column: quarter {field: vnv_fb_ga_view.date_start_quarter}
    column: total_impressions {field: vnv_fb_ga_view.total_impressions}
    column: total_clicks {field: vnv_fb_ga_view.total_clicks}
    column: total_views {field: vnv_fb_ga_view.total_thruplays}
    column: total_completes {field: vnv_fb_ga_view.total_video_completes}
    column: total_cost {field: vnv_fb_ga_view.total_spend}
    column: total_sessions {field: vnv_fb_ga_view.total_sessions}
    column: total_session_duration {field: vnv_fb_ga_view.total_session_duration}
    column: total_partner_referrals {field: vnv_fb_ga_view.total_partner_referral}
    filters: {
      field: vnv_fb_ga_view.vnv_campaign
      value: "Foundational"
    }
  }
  datagroup_trigger: vnv_foundational_datagroup
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

dimension: total_impressions {
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
