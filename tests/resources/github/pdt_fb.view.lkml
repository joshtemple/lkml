view: pdt_fb {
    derived_table: {
      explore_source: tds_fb{
        column: publisher {field: tds_fb_ga_view.publisher}
        column: campaign {field: tds_fb_ga_view.tds_campaign}
        column: placement {field: tds_fb_ga_view.adset_name}
        column: date {field: tds_fb_ga_view.date_start_date}
        column: week {field: tds_fb_ga_view.date_start_week}
        column: month {field: tds_fb_ga_view.date_start_month}
        column: total_impressions {field: tds_fb_ga_view.total_impressions}
        column: total_clicks {field: tds_fb_ga_view.total_clicks}
        column: total_cost {field: tds_fb_ga_view.total_spend}
        column: total_sessions {field: tds_fb_ga_view.total_sessions}
        column: total_session_duration {field: tds_fb_ga_view.total_session_duration}
        column: total_newusers {field: tds_fb_ga_view.total_new_users}
        column: total_pageviews {field: tds_fb_ga_view.total_page_views}
        column: total_users {field: tds_fb_ga_view.total_users}
        column: total_account_creates {field:tds_fb_ga_view.total_account_creates}
        column: total_checkouts {field: tds_fb_ga_view.total_checkouts}
        column: total_pdp_views {field: tds_fb_ga_view.total_pdp_views}
        column: total_revenue {field: tds_fb_ga_view.total_revenue}
        column: total_subscrpition_orders {field: tds_fb_ga_view.total_subscrpition_orders}
        column: total_transactions {field: tds_fb_ga_view.total_transactions}
      }
      datagroup_trigger: tds_datagroup
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

  dimension: total_checkouts  {
    type:  number
  }

  dimension: total_pdp_views   {
    type:  number
  }

  dimension:total_revenue   {
    type:  number
  }

  dimension: total_subscrpition_orders   {
    type:  number
  }

  dimension:  total_transactions   {
    type:  number
  }
  }
