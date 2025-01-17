connection: "snowflake_adw"
# include all the views
include: "/VIEW_FILES/**/*.view"

# include spec files
include: "/1_SPEC_FILES/*"
include: "/TESTS/sales_metrics_tests.view"

############
# Sales Performance Models
############
explore: mrr_data {
  label: "Sales Performance MRR Explore"
  description: "Start here for information about MRR, BAU and ARR data"
  view_name: d_date_driver
#   hidden: yes
  join: f_mrr_date_control_view {
    view_label: "2. Company / Metrics"
    type: left_outer
    sql_on:
          ${f_mrr_date_control_view.join_date} = ${d_date_driver.date_gran}
                and ${f_mrr_date_control_view.global_region} = ${d_date_driver.region}
                and ${f_mrr_date_control_view.segment} = ${d_date_driver.segment};;
    relationship: many_to_one
  }

  join: ndt_forecast_controlView {
    fields: [
      -ndt_forecast_controlView.acv_added_forecast
      , -ndt_forecast_controlView.acv_added_plan
      , ndt_forecast_controlView.ending_arr_forecast
      , ndt_forecast_controlView.ending_arr_plan
      , ndt_forecast_controlView.arr_added_forecast
      , ndt_forecast_controlView.arr_added_plan
      , ndt_forecast_controlView.join_date
      , ndt_forecast_controlView.region
      , ndt_forecast_controlView.segment
    ]
    type: left_outer
    sql_on: ${d_date_driver.date_gran} = ${ndt_forecast_controlView.join_date}
                and ${d_date_driver.region} = ${ndt_forecast_controlView.region}
                and ${d_date_driver.segment} = ${ndt_forecast_controlView.segment} ;;
    relationship: many_to_many
  }
  join: sfdc_user {
    view_label: "6. SFDC Users"
    sql_on: ${f_mrr_date_control_view.sfdc_ae_id} = ${sfdc_user.sfid} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: salesforce_accounts {
    from: sfdc_account
    view_label: "5. SFDC Accounts"
    sql_on: ${salesforce_accounts.sfdc_id} = ${f_mrr_date_control_view.sfdc_account_id} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: country_mapping {
    from: country_mapping_ssot
    relationship: many_to_one
    sql_on: ${f_mrr_date_control_view.billing_country} = ${country_mapping.country} ;;
    type: left_outer
  }
  join: the_date {
    relationship: one_to_one
    sql:  ;;
}
}

explore: aov_data {
  hidden: yes
  label: "Sales Performance AOV Account Based Explore"
  description: "Start here for information about AOV data"
  view_name: d_date_driver
  view_label: "1. Dates"
  fields: [ALL_FIELDS*,
    -d_date_driver.link_to_ending_arr
  , -d_date_driver.link_to_acv
  , -d_date_driver.link_to_arr_added
  , -d_date_driver.link_to_billings
  , -d_date_driver.link_to_bau
  , -d_date_driver.link_to_acv_opp
  ]
  join: ndt_aov_controlview {
    type: left_outer
    sql_on:
        ${ndt_aov_controlview.join_date} = ${d_date_driver.date_gran}
                and ${ndt_aov_controlview.global_region} = ${d_date_driver.region}
                and ${ndt_aov_controlview.segment} = ${d_date_driver.segment};;
    relationship: many_to_many
  }
  join: ndt_forecast_controlView {
    fields: [
      ndt_forecast_controlView.acv_added_forecast
      , ndt_forecast_controlView.acv_added_plan
      , ndt_forecast_controlView.dynamic_acv_added_plan
      , ndt_forecast_controlView.ending_aov_forecast
      , ndt_forecast_controlView.ending_aov_plan
      , ndt_forecast_controlView.join_date
      , ndt_forecast_controlView.region
      , ndt_forecast_controlView.segment
      , ndt_forecast_controlView.dynamic_acv_added_plan
      , ndt_forecast_controlView.acv_added_plan_gross
      , -ndt_forecast_controlView.dynamic_acv_gross_net_plan
    ]
    type: left_outer
    sql_on: ${d_date_driver.date_gran} = ${ndt_forecast_controlView.join_date}
                and ${d_date_driver.region} = ${ndt_forecast_controlView.region}
                and ${d_date_driver.segment} = ${ndt_forecast_controlView.segment} ;;
    relationship: many_to_many
  }
  join: sfdc_user {
    view_label: "SFDC Users"
    sql_on: ${ndt_aov_controlview.sfdc_ae_id} = ${sfdc_user.sfid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: salesforce_accounts {
    from: sfdc_account
    view_label: "SFDC Accounts"
    sql_on: ${salesforce_accounts.sfdc_id} = ${ndt_aov_controlview.sfdc_account_id} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: country_mapping {
    from: country_mapping_ssot
    relationship: many_to_one
    sql_on: ${ndt_aov_controlview.billing_country} = ${country_mapping.country} ;;
    type: left_outer
  }
  join: the_date {
    relationship: one_to_one
    sql:  ;;
}
  join: ramped_hc {
    sql_on: ${ramped_hc.month_end_date} = ${d_date_driver.date_gran} AND ${ramped_hc.manager_name} = ${sfdc_user.l1_manager_name} ;;
    relationship: many_to_many
  }
  join: team_geo {
    from: dim_team_geo_latest
    type: left_outer
    relationship: one_to_one
    sql_on: ${team_geo.team_id} = ${ndt_aov_controlview.team_id} ;;
    fields: []
  }

  join: team_locations {
    from: locations
    type: left_outer
    relationship: many_to_one
    sql_on: ${team_locations.country_iso_code} = ${team_geo.billing_country_iso_code};;
  }
}

explore: billings_data {
  label: "Sales Performance Billing Data Explore"
  view_name: d_date_driver
  fields: [ALL_FIELDS*,
    -d_date_driver.link_to_ending_arr
    , -d_date_driver.link_to_acv
    , -d_date_driver.link_to_arr_added
    , -d_date_driver.link_to_billings
    , -d_date_driver.link_to_bau
    , -d_date_driver.link_to_acv_opp
  ]
#   hidden: yes
  join: ndt_billings_controlview {
    type: left_outer
    sql_on:
      ${ndt_billings_controlview.join_date} = ${d_date_driver.date_gran}
              and ${ndt_billings_controlview.global_region} = ${d_date_driver.region}
              and ${ndt_billings_controlview.segment} = ${d_date_driver.segment};;
    relationship: many_to_many
  }
  join: ndt_forecast_controlView {
    fields: [
      ndt_forecast_controlView.billings_forecast
      , ndt_forecast_controlView.billings_plan
      , ndt_forecast_controlView.join_date
      , ndt_forecast_controlView.region
      , ndt_forecast_controlView.segment
    ]
    type: left_outer
    sql_on: ${d_date_driver.date_gran} = ${ndt_forecast_controlView.join_date}
                and ${d_date_driver.region} = ${ndt_forecast_controlView.region}
                and ${d_date_driver.segment} = ${ndt_forecast_controlView.segment} ;;
    relationship: many_to_many
  }
  join: country_mapping {
    from: country_mapping_ssot
    relationship: many_to_one
    sql_on: ${ndt_billings_controlview.billing_country} = ${country_mapping.country} ;;
    type: left_outer
  }
  join: the_date {
    relationship: one_to_one
    sql:  ;;
  }
}

explore: aov_opportunity_data {
  hidden: yes
  view_name: d_date_driver
  fields: [ALL_FIELDS*,
    -d_date_driver.link_to_ending_arr
    , -d_date_driver.link_to_acv
    , -d_date_driver.link_to_arr_added
    , -d_date_driver.link_to_billings
    , -d_date_driver.link_to_bau
    , -d_date_driver.link_to_acv_opp
  ]
  join: ndt_aov_opportunity_controlview {
    type: left_outer
    sql_on:
      ${ndt_aov_opportunity_controlview.join_date} = ${d_date_driver.date_gran}
              and ${ndt_aov_opportunity_controlview.global_region} = ${d_date_driver.region}
              and ${ndt_aov_opportunity_controlview.segment} = ${d_date_driver.segment};;
    relationship: many_to_many
  }
  join: ndt_forecast_controlView {
    fields: [
      ndt_forecast_controlView.dynamic_acv_gross_net_plan
      , ndt_forecast_controlView.join_date
      , ndt_forecast_controlView.region
      , ndt_forecast_controlView.segment
      , -ndt_forecast_controlView.dynamic_acv_added_plan
    ]
    type: left_outer
    sql_on: ${d_date_driver.date_gran} = ${ndt_forecast_controlView.join_date}
                and ${d_date_driver.region} = ${ndt_forecast_controlView.region}
                and ${d_date_driver.segment} = ${ndt_forecast_controlView.segment} ;;
    relationship: many_to_many
  }
#   join: renewal_metrics {
#     type: left_outer
#     sql_on: ${ndt_aov_opportunity_controlview.opportunity_id} = ${renewal_metrics.opportunity_id} ;;
#     relationship: one_to_one
#   }
  join: sfdc_user {
    view_label: "SFDC Users"
    sql_on: ${ndt_aov_opportunity_controlview.ownerid} = ${sfdc_user.sfid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: country_mapping {
    from: country_mapping_ssot
    relationship: many_to_one
    sql_on: ${ndt_aov_opportunity_controlview.billing_country} = ${country_mapping.country} ;;
    type: left_outer
  }

  join: ramped_hc {
    sql_on: ${ramped_hc.month_end_date} = ${d_date_driver.date_gran} AND ${ramped_hc.manager_name} = ${sfdc_user.l1_manager_name} ;;
    relationship: many_to_many
  }
  join: the_date {
    relationship: one_to_one
    sql:  ;;
}
}

explore: the_date {
  hidden: yes
}

############
# Sales Performance Models (Opportunity Explore)
############

explore: f_sfdc_opportunity {
#   always_join: [pop_support]
label: "Sales Performance AOV Opportunity Based Explore"
  description: "Start here for information about ACV and AOV Change data"
join: d_sfdc_opportunity {
  type: inner
  sql_on: ${f_sfdc_opportunity.opportunity_key} = ${d_sfdc_opportunity.skey}
    and ${d_sfdc_opportunity.record_ind_fl} = 'Y';;
  relationship: many_to_one
}
join: d_sfdc_account {
  type: inner
  sql_on: ${f_sfdc_opportunity.account_key} = ${d_sfdc_account.skey}
    and ${d_sfdc_account.record_ind_fl} = 'Y';;
  relationship: many_to_one
}
join: d_date {
  type: inner
  sql_on: ${d_sfdc_opportunity.close_date} = ${d_date.calendar_date} ;;
  relationship: many_to_one
}
join: the_date {
  relationship: one_to_one
  sql:  ;;
}
join: forecast_planning {
  view_label: "8. ACV Plan"
  fields: [
    -forecast_planning.acv_added_forecast
      , forecast_planning.metric
      , forecast_planning.type
      , forecast_planning.is_invoice_acv
      , -forecast_planning.acv_added_plan
      , forecast_planning.region
      , forecast_planning.segment
       , -forecast_planning.acv_added_plan_gross
      , forecast_planning.dynamic_acv_gross_net_plan
  ]
  type: left_outer
  sql_on: ${forecast_planning.segment} = ${d_sfdc_account.tcl_company_segment_mapping}
            and ${forecast_planning.region} = ${d_sfdc_account.global_region}
            and ${forecast_planning.month_end_date} = ${d_date.month_end_date};;
  relationship: many_to_many
}
join: renewal_metrics {
  view_label: "7. Renewal Metrics"
  type: left_outer
  sql_on: ${f_sfdc_opportunity.opportunity_id} = ${renewal_metrics.opportunity_id} ;;
  relationship: one_to_one
}
join: sfdc_user {
  view_label: "SFDC Users"
  sql_on: ${d_sfdc_account.ownerid} = ${sfdc_user.sfid} ;;
  relationship: many_to_one
  type: left_outer
}
join: country_mapping {
  from: country_mapping_ssot
  relationship: many_to_one
  sql_on: ${d_sfdc_account.billing_country} = ${country_mapping.country} ;;
  type: left_outer
}

join: ramped_hc {
  sql_on: ${ramped_hc.month_end_date} = ${d_date.full_date} AND ${ramped_hc.manager_name} = ${sfdc_user.l1_manager_name} ;;
  relationship: many_to_many
}
}

####################################
# Base NDT Model
####################################
explore: mrr_teams_sales {
  label: "Sales Performance MRR Explore Detail"
  hidden: yes
  extends: [mrr_team_extension]
  join: sfdc_user {
    view_label: "6. SFDC Users"
    sql_on: ${team_company_segment.sfdc_ae_id} = ${sfdc_user.sfid} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: salesforce_accounts {
    from: sfdc_account
    view_label: "5. SFDC Accounts"
    sql_on: ${salesforce_accounts.sfdc_id} = ${team_company_segment.sfdc_account_id} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: country_mapping {
    from: country_mapping_ssot
    relationship: many_to_one
    sql_on: ${team_company_segment.billing_country} = ${country_mapping.country} ;;
    type: left_outer
  }
  join: the_date {
    relationship: one_to_one
    sql:  ;;
}
}

explore: aov_sales {
  hidden: yes
  label: "Sales Performance AOV Explore Detail"
  extends: [aov_extension]
  join: payments_products {
    type: left_outer
    sql_on: case when ${f_aov.product_id} = 'EKM' THEN 'inv_enterprise_y' ELSE ${f_aov.product_id} END = ${payments_products.id}
      ;;
#     --  ${payments_products.id} = ${f_aov.product_id}
      relationship: many_to_one
    }
    join: billing_association_sq {
#     fields: []
    type: left_outer
    sql_on: ${d_team.team_id} = ${billing_association_sq.team_id}
      and ${billing_association_sq.link_ds} = ${d_date.full_date};;
    relationship: many_to_one
  }
  join: q_refresh {
    fields: []
    from:d_wday_q_refresh
    sql_on: ${f_aov.team_key} = ${q_refresh.team_key} AND ${f_aov.date_key} = ${q_refresh.date_key} ;;
    relationship: many_to_many
  }
  join: sfdc_user {
    view_label: "SFDC Users"
    sql_on: ${team_company_segment_latest.sfdc_ae_id} = ${sfdc_user.sfid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: salesforce_accounts {
    from: sfdc_account
    view_label: "SFDC Accounts"
    sql_on: ${salesforce_accounts.sfdc_id} = ${team_company_segment_latest.sfdc_account_id} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: country_mapping {
    from: country_mapping_ssot
    relationship: many_to_one
    sql_on: ${team_company_segment_latest.billing_country} = ${country_mapping.country} ;;
    type: left_outer
  }
  join: the_date {
    relationship: one_to_one
    sql:  ;;
}
join: ramped_hc {
  sql_on: ${ramped_hc.month_end_date} = ${d_date.full_date} AND ${ramped_hc.manager_name} = ${sfdc_user.l1_manager_name} ;;
  relationship: many_to_many
}
join: team_geo {
  from: dim_team_geo_latest
  type: left_outer
  relationship: one_to_one
  sql_on: ${team_geo.team_id} = ${d_team.team_id} ;;
  fields: []
}

join: team_locations {
  from: locations
  type: left_outer
  relationship: many_to_one
  sql_on: ${team_locations.country_iso_code} = ${team_geo.billing_country_iso_code};;
}
}

explore: billings_sales {
  hidden: yes
  label: "Sales Performance Billings Explore Details"
  extends: [billing_extension]
  join: the_date {
    sql:  ;;
  relationship: one_to_one
}
join: country_mapping {
  from: country_mapping_ssot
  relationship: many_to_one
  sql_on: ${team_company_segment_latest.billing_country} = ${country_mapping.country} ;;
  type: left_outer
}
}

explore: team_sales {
  extends: [teams_extension]
  hidden: yes
  join: the_date {
    relationship: one_to_one
    sql:  ;;
}
}

explore: midas_team_user_stats_master {
#   persist_with: snowflake_midas_part_one
  hidden: yes
  label: "Sales WAU Over Time"
  description: "Used for Team Snapshot dashboard embeds"
  from: midas_wau_over_time
  view_name: midas_wau_over_time
  view_label: "1. User Level KPIs"

  join: midas_wau_over_time_unnest {
    sql: ,lateral flatten(input=>${midas_wau_over_time.activity_over_time}) ;;
    relationship: one_to_many
    view_label: "2. MAU/WAU"
  }

join: d_date_for_sales {
  type: inner
  sql_on: ${midas_wau_over_time_unnest.ds} = ${d_date_for_sales.f_date} ;;
  relationship: many_to_one
  view_label: "2. MAU/WAU"
}
}

############
# Renewal and Retention models
############

explore: renewal_metrics {
  label: "DEV: Renewal Metrics"
  join: d_sfdc_opportunity {
    type: inner
    relationship: one_to_one
    sql_on: ${renewal_metrics.opportunity_id} = ${d_sfdc_opportunity.sfdc_id} ;;
    fields: [renewal_status
      ,stage_name
      ,opportunity_type]
    view_label: "Opportunity Details"
  }
  join: f_sfdc_opportunity {
    fields: [
      -f_sfdc_opportunity.dynamic_acv
    ]
    type: inner
    relationship: one_to_one
    sql_on: ${f_sfdc_opportunity.opportunity_id} = ${renewal_metrics.opportunity_id} ;;
  }
  hidden: yes
}

explore: retention_metrics {
  hidden: yes
  label: "DEV: Retention Metrics"
}

explore: bau_arr_aov_account {
  label: "Sales Performance Account/Team Explore"
  hidden: yes
}
