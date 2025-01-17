
connection: "snowflake_adw"
# include all the views
include: "/VIEW_FILES/*/**.view"

# include spec files
include: "/1_SPEC_FILES/*"

# include webhooks tests
include: "/TESTS/new_company_metrics_webhook_tests.view"

#################### MAIN EXPLORE - TEAM LEVEL #####################

explore: dates {
  fields: [ALL_FIELDS*
    , -d_date.dynamic_date_2
    , -d_date.dashboard_filter
    , -the_date.dashboard_datefilter
    ]
  extends: [mrr_team_extension]
  join: the_date {
    fields: []
    relationship: one_to_one
    sql:  ;;
}
}

explore: billing {
  fields: [ALL_FIELDS*
    , -d_date.dynamic_date_2
    , -d_date.dashboard_filter
  ]
  extends: [billing_extension]
  join: the_date {
    fields: []
    relationship: one_to_one
    sql:  ;;
}
}

explore: metrics_aov {
  fields: [ALL_FIELDS*
    , -f_aov.acv_invoice_deals_feeder
    , -f_aov.acv_invoice_icb_feeder
    , -f_aov.is_link_ds
    , -f_aov.acv_invoice
    , -f_aov.acv_q_recon
    , -f_aov.q_refresh
    , -f_aov.total_acv_q_refresh
    , -f_aov.acv_self_serve_
    , -d_date.dynamic_date_2
    , -d_date.dashboard_filter
  ]
  extends: [aov_extension]
#   join: the_date {
#     fields: []
#     relationship: one_to_one
#     sql:  ;;
#  }
}

explore: teams {
  fields: [ALL_FIELDS*
    , -d_date.dynamic_date_2
    , -d_date.dashboard_filter
  ]
  extends: [teams_extension]
  join: the_date {
    fields: []
    relationship: one_to_one
    sql:  ;;
}
}

#################### Webhook Only Explores #########################
explore: date_bizops {
  fields: [ALL_FIELDS*
    , -d_date.dynamic_date_2
    , -d_date.dashboard_filter
  ]
  view_name: d_date
  join: bizops_stats {
    type: left_outer
    sql_on: ${d_date.full_date} = ${bizops_stats.ds} ;;
    relationship: many_to_one
  }
  join: teams_by_user_geo {
    from: v_dim_all_users_v3_latest
    type: left_outer
    sql_on: ${teams_by_user_geo.team_id} = ${bizops_stats.team_id} ;;
    relationship: one_to_many
  }
  join: locations {
    view_label: "User Location"
    type: inner
    relationship: one_to_one
    sql_on: ${teams_by_user_geo.geo_id} = ${locations.geo_id} ;;
    fields: [locations.subdivision_1_iso_code, locations.country_iso_code_3, locations.country_name, locations.metro_name, locations.city_name, locations.continent_name]
  }
  join: dau_7daypeak {
    type: left_outer
    sql: right join dau_7daypeak on ${bizops_stats.ds} = ${dau_7daypeak.ds} ;;
    relationship: many_to_one
  }
  join: the_date {
    fields: []
    relationship: one_to_one
    sql:  ;;
}
}

explore: customer_revenue_metrics {
  view_name: fact_customer_revenue_metrics
  view_label: "1. Customer Revenue Facts"
  join: customer_revenue_metrics_2 {
    from: fact_customer_revenue_metrics
    view_label: "2. Customer Revenue Metrics"
    relationship: many_to_one
    sql_on:
    ${customer_revenue_metrics_2.customer_id} = ${fact_customer_revenue_metrics.customer_id}
      AND  ${fact_customer_revenue_metrics.next_date_id} = ${customer_revenue_metrics_2.date_id}
      ;;
    fields: []
    }
  join: ndr {
    view_label: "2. Customer Revenue Metrics"
    relationship: many_to_one
    sql_on:
    ${ndr.next_date_id} = ${fact_customer_revenue_metrics.date_id} ;;
    }
  join: the_date {
    fields: []
    relationship: one_to_one
    sql:  ;;
}
  }

explore: paid_customers_latest {
  fields: [ALL_FIELDS*
    , -paid_customers_latest.paid_customers_fqtd
    , -paid_customers_latest.paid_customer_over_100_k_count_fqtd
    , -paid_customers_latest.paid_customer_over_1m_count_fqtd
    , -paid_customers_latest.paid_customers_mtd
    , -paid_customers_latest.paid_customer_over_100_k_count_mtd
    , -paid_customers_latest.paid_customer_over_1m_count_mtd
    ]
  }

explore: paid_customers_ndr {
  fields: [ALL_FIELDS*
    , -d_date.dynamic_date_2
    , -d_date.dashboard_filter
  ]
  sql_always_where:

   ${d_date.full_date} = ${paid_customers_last_week.ds}
   OR ${d_date.full_date} = ${paid_customers_last_month.ds}
   OR ${d_date.full_date} = ${paid_customers_latest.ds} ;;
  view_name: d_date
  join: paid_customers_latest {
    type: left_outer
    sql_on: ${paid_customers_latest.ds} = ${d_date.full_date} ;;
    relationship: many_to_one
  }
  join: paid_customers_last_week {
    type: left_outer
    sql_on: ${paid_customers_last_week.ds} = ${d_date.full_date} ;;
    relationship: many_to_one
  }
  join: ndr {
    type: left_outer
    sql_on: ${ndr.next_date_id} = ${d_date.full_date} ;;
    relationship: many_to_one
  }
  join: paid_customers_last_month {
    type: left_outer
    sql_on: ${paid_customers_last_month.ds} = ${d_date.full_date} ;;
    relationship: many_to_one
  }
#   join: max_ds_view {
#     type: left_outer
#     sql_on: ${max_ds_view.max_ds} = ${d_date.full_date} ;;
#     relationship: many_to_one
#   }
  join: the_date {
    fields: []
    relationship: one_to_one
    sql:  ;;
}

}

#################### BASE NDT Explores #########################
explore: maximum_ds {
  view_name: fact_customer_revenue_metrics_test
  sql_always_where: ds >=( select load_ds from ADW_DB.CTRL.PDW_AIRFLOW_JOB_STATUS where object_name = 'fact_customer_revenue_metrics') ;;
  fields: [fact_customer_revenue_metrics_test.ds, fact_customer_revenue_metrics_test.mrr_ds, fact_customer_revenue_metrics_test.max_ds, fact_customer_revenue_metrics_test.max_mrr_ds]
}

explore: paid_customers {
  always_join: [max_ds_view, max_mrr_ds_view]
  view_name: fact_customer_revenue_metrics_test
  join: max_ds_view {
    type: inner
    sql_on: ${max_ds_view.max_ds} = ${fact_customer_revenue_metrics_test.ds} ;;
    relationship: many_to_one
  }
  join: max_mrr_ds_view {
    type: inner
    sql_on: ${max_mrr_ds_view.max_mrr_ds} = ${fact_customer_revenue_metrics_test.ds} ;;
    relationship: many_to_one
  }
  join: ndr {
    type: left_outer
    sql_on: ${ndr.next_date_id} = ${max_ds_view.max_ds} ;;
    relationship: many_to_one
  }
}

explore: paid_customers_1_week {
  always_join: [max_ds_view, max_mrr_ds_view]
  view_name: fact_customer_revenue_metrics_test
  join: max_ds_view {
    type: inner
    sql_on: ${max_ds_view.week_join_date} = ${fact_customer_revenue_metrics_test.ds} ;;
    relationship: many_to_one
  }
  join: max_mrr_ds_view {
    type: inner
    sql_on: ${max_mrr_ds_view.week_join_date} = ${fact_customer_revenue_metrics_test.ds} ;;
    relationship: many_to_one
  }
}

explore: paid_customers_1_month {
    always_join: [max_ds_view, max_mrr_ds_view]
    view_name: fact_customer_revenue_metrics_test
    join: max_ds_view {
      type: inner
      sql_on: ${max_ds_view.month_join_date} = ${fact_customer_revenue_metrics_test.ds} ;;
      relationship: many_to_one
    }
    join: max_mrr_ds_view {
      type: inner
      sql_on: ${max_mrr_ds_view.month_join_date} = ${fact_customer_revenue_metrics_test.ds} ;;
      relationship: many_to_one
   }
}

explore: created_works_team {
}
