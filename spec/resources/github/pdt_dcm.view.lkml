view: pdt_dcm {
    derived_table: {
      explore_source: tds_dcm{
        column: publisher {field: tds_dcm_ga_view.publisher}
        column: campaign {field: tds_dcm_ga_view.campaign}
        column: placement {field: tds_dcm_ga_view.placement}
        column: date {field: tds_dcm_ga_view.date_date}
        column: week {field: tds_dcm_ga_view.date_week}
        column: month {field: tds_dcm_ga_view.date_month}
        column: total_impressions {field: tds_dcm_ga_view.total_impressions}
        column: total_clicks {field: tds_dcm_ga_view.total_clicks}
        column: total_cost {field: tds_dcm_ga_view.total_media_cost}
        column: total_sessions {field: tds_dcm_ga_view.total_sessions}
        column: total_session_duration {field: tds_dcm_ga_view.total_session_duration}
        column: total_newusers {field: tds_dcm_ga_view.total_newusers}
        column: total_pageviews {field: tds_dcm_ga_view.total_pageviews}
        column: total_users {field: tds_dcm_ga_view.total_users}
        column: total_account_creates {field:tds_dcm_ga_view.total_account_creates}
        column: total_checkouts {field: tds_dcm_ga_view.total_checkouts}
        column: total_pdp_views {field: tds_dcm_ga_view.total_pdp_views}
        column: total_revenue {field: tds_dcm_ga_view.total_revenue}
        column: total_subscrpition_orders {field: tds_dcm_ga_view.total_subscrpition_orders}
        column: total_transactions {field: tds_dcm_ga_view.total_transactions}
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
