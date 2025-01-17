connection: "phish_thesis"
label: "Mobile Bookings Data Mart"
#{
include: "/config.lkml"
include: "/views/revenue_unused/*.view.lkml"
include: "/views/revenue_mapping/*.view.lkml"
include: "/views/adjust_derived/adjust_sessions_active_users.view.lkml"
include: "/views/finance_models/*.view.lkml"
include: "/views/kpi_sheets/*.view.lkml"
include: "/views/apple/apalon_itunes_cvr.view.lkml"
include: "/views/adjust_derived/adj_sessions_any_period.view.lkml"
include: "/views/revenue_main/*.view.lkml"
#this might belong better in engagement_data_transactional
include: "/iCVR_install_pageviews.view.lkml"
include: "/views/transactional_mapping/accounting_sku_mapping.view.lkml"
include: "/views/transactional_main/first_pmnts_avg_price.view.lkml"
include: "/views/apple/itunes_report/itunes_events.view.lkml"
include: "/views/apple/itunes_report/itunes_revenue.view.lkml"

#}

week_start_day: sunday

#Don't think this is being used
explore: trials_by_plan {}

#Don't think this is being used
explore: missing_sku_google_and_itunes {
  hidden:yes
  label: "Missing SKUs"
  group_label: "Mobile Bookings Data Mart"
}

#Don't think this is being used
explore: apalon_itunes_cvr {
  hidden:  yes
  label: "Mobile iTunes CVR"
  group_label: "Mobile Bookings Data Mart"
}

explore: adjust_sessions_active_users {
  label: "Adjust Sessions Data"
  group_label: "Mobile Bookings Data Mart"
  persist_with: daily_adj
}

explore: finance_forecast {
  always_filter: {
    filters: {
      field:Assumption_upload_time_filter
    }
    filters: {
      field:Finance_curve_upload_date_filter
    }
  }

}
explore: assumptions_versions {}
explore: finance_curves_versions {}
explore: kpi_ua {
  description: "New data definitions per mosaic model sheet, spend from cmrs table"
  label: "KPI UA"
  persist_with: daily
}

explore: kpi_subs {
  description: "Subscriptions, New data definitions per mosaic model sheet"
  label: "KPI Subs"
  persist_with: daily
}

explore: kpi_report {
  description: "[PLACEHOLDER] KPI Report V3 in Looker"
  label: "KPI Report V3"
  persist_with: kpi_report_trigger
}

explore: kpi_top_product_report {
  description: "Top products by company report, metrics from same source as kpi_report.view"
  label: "KPI Top Product Report"
  persist_with: daily
}

explore: test_curves_blended {
  always_filter: {
    filters: {
      field: metric_type
      value: "raw"
    }
  }
  description: "Finance curves"
  label: "Finance Curves"
persist_with: kpi_report_trigger
}

#not used within 90 days
explore: sub_lt_duration {}

#Being used?
explore: v_spend_actualized {
  description: "Actualized Spend from general ledger "
  label: "Actualized Spend"
}

explore: rev_cash {
  description: "Mobile Bookings - ERC_APALON Data Tables - Revenue; Consolidated Engagement Data; etc"
  label: "Mobile Bookings"
  group_label: "Mobile Bookings Data Mart"
  persist_with: daily

  #sql_always_where: application.org='apalon';;

  join: ad_network {
    relationship: many_to_one
    sql_on: ${ad_network.ad_network_id} = ${rev_cash.ad_network_id} ;;
  }

  join: ad_unit {
    relationship: many_to_one
    sql_on: ${ad_unit.adunit_id} = ${rev_cash.ad_unit_id};;
  }

  join: application {
    relationship:  many_to_one
    sql_on: ${application.id} = ${rev_cash.app_id};;
  }

  join: sku_subs_length {
    relationship: one_to_one
    #type:  left_outer
    sql_on: ${application.store_app_id}=${sku_subs_length.store_id_gp};;
  }

  join: app_lifetime_value {
    relationship: many_to_one
    sql_on: ${rev_cash.app_id} = ${app_lifetime_value.app_id} ;;
  }

  join: campaign_type {
    relationship: many_to_one
    sql_on: ${campaign_type.campaign_type_id} = ${rev_cash.campaign_type_id} ;;
  }

  join: category {
    relationship: many_to_one
    sql_on: ${category.category_id} = ${rev_cash.category_id} ;;
  }

  join: country {
    relationship: many_to_one
    sql_on: ${country.country_id} = ${rev_cash.country_id} ;;
  }

  join: currency {
    relationship: many_to_one
    sql_on: ${currency.country_code} = ${country.country_code} ;;
  }

  join: device {
    relationship: many_to_one
    sql_on: ${device.id} = ${rev_cash.device_id} ;;
  }

  join: fact_type {
    relationship: many_to_one
    sql_on: ${fact_type.fact_type_id} = ${rev_cash.fact_type_id} ;;
  }

  join: ld_track {
    relationship: many_to_one
    sql_on: ${ld_track.id} = ${rev_cash.ld_track_id} ;;
  }

  join: revenue_type {
    relationship: many_to_one
    sql_on: ${revenue_type.revenue_type_id} = ${rev_cash.revenue_type_id} ;;
  }

  join: subscription_length {
    relationship: many_to_one
    sql_on: ${subscription_length.id} = ${rev_cash.subscription_length_id} ;;
  }

  join: transaction_status {
    relationship: many_to_one
    sql_on: ${transaction_status.id} = ${transaction_status.id} ;;
  }
  join: adjust_sessions_active_users {
    relationship: many_to_one
    sql_on:   ${adjust_sessions_active_users.date_date}=${rev_cash.date_date}
              and ${adjust_sessions_active_users.Platform}=${application.Platform_Unified}
              and ${adjust_sessions_active_users.Unified_Name}=${application.name_unified}
              and ${adjust_sessions_active_users.country_code}=${country.country_code}
              and ${fact_type.fact_type_id}=26
              ;;
  }
}

#Not sure this is being used
explore: adj_sessions_any_period {
  hidden: no
  label: "Adjust Active Users"
}


#Don't think this is being used - not used within last 90 days
# explore: flurry_api_console {
#   hidden:  yes
#   view_name: "flurry_api_console"
#   description: "Flurry Raw Data"
#   label: "Flurry Console"
#   view_label: "Flurry API Console"
#
#   join: apptype_custom {
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${flurry_api_console.cobrand} = ${apptype_custom.cobrand} ;;
#   }
#
#   join: country{
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${country.country_code}=${flurry_api_console.country} ;;
#   }
# }


explore: ad_report {
  description: "Mobile Bookings - ERC_APALON Data Tables - Revenue; Consolidated Engagement Data; etc"
  label: "Ad Report"
  group_label: "Ad Report"
  persist_with: daily
  #sql_always_where: application.org='apalon';;

  join: ad_network {
    relationship: many_to_one
    sql_on: ${ad_network.ad_network_id} = ${ad_report.ad_network_id} ;;
  }

  join: ad_unit {
    relationship: many_to_one
    sql_on: ${ad_unit.adunit_id} = ${ad_report.ad_unit_id};;
  }

  join: application {
    relationship:  many_to_one
    sql_on: ${application.id} = ${ad_report.app_id} ;;
  }

  join: country {
    relationship: many_to_one
    sql_on: ${country.country_id} = ${ad_report.country_id} ;;
  }

  join: currency {
    relationship: many_to_one
    sql_on: ${currency.country_code} = ${country.country_code} ;;
  }

  join: device {
    relationship: many_to_one
    sql_on: ${device.id} = ${ad_report.device_id} ;;
  }

  join: fact_type {
    relationship: many_to_one
    sql_on: ${fact_type.fact_type_id} = ${ad_report.fact_type_id} ;;
  }

  join: revenue_type {
    relationship: many_to_one
    sql_on: ${revenue_type.revenue_type_id} = ${ad_report.revenue_type_id} ;;
  }

  join: adj_sessions_any_period{
    relationship: many_to_one
    sql_on:   ${adj_sessions_any_period.Platform}=${application.Platform_Unified}
              and ${adj_sessions_any_period.Unified_Name}=${application.name_unified}
              and  ${adj_sessions_any_period.country_code}=${country.country_code}
              and ${fact_type.fact_type_id}=26
              --and ${ad_report.start_date}=${adj_sessions_any_period.start_date}
             -- and ${ad_report.end_date}=${adj_sessions_any_period.end_date}
             -- and ${ad_report.date_breakdown}=${adj_sessions_any_period.date_breakdown}
              and ${ad_report.Date_Breakdown}=${adj_sessions_any_period.Date_Breakdown}
              --and  ${adj_sessions_any_period.date_date}=${ad_report.date_date}
              ;;
  }
}

explore: cmrs_marketing_data {
  view_label: "CMRS Marketing Data"
  hidden:yes
  join: distinct_cobrands {
    fields: [distinct_cobrands.ORG,distinct_cobrands.APP_NAME_UNIFIED,distinct_cobrands.APP_TYPE,distinct_cobrands.IS_SUBSCRIPTION]
    type: left_outer
    relationship: many_to_one
    sql_on: ${distinct_cobrands.COBRAND}=${cmrs_marketing_data.COBRAND};;
  }
}

#not used within last 90 days
#explore: distinct_cobrands {view_label: "Cobrands/Org list"  hidden:yes}
explore: application {view_label: "Application"  hidden:yes}
#not used within last 90 days
#explore: rubicon_revenue {view_label: "Rubicon Bookings" hidden: yes}
#not used within last 90 days
#explore: a9_revenue {view_label: "A9 Revenue" hidden: yes}
#not used within last 90 days
#explore: a9_sales_revenue {view_label: "A9 Sales Bookings" hidden: yes}
#not used within last 90 days
#explore: aa_ranks {view_label: "App Annie Ranks" hidden: yes}
#not used within last 90 days
#explore: aa_ratings {view_label: "App Annie Ratings" hidden: yes}
#not used within last 90 days
#explore: sku_subs_length {view_label: "Subs Length Mapping" hidden:yes}


### FOR DATA TRASNFER PURPOSES:
explore: apalon_st_data_for_itranslate {hidden: yes}

# for new iCVR dashboard 11/5
explore: iCVR_install_pageviews {view_label: "iCVR (iTunes)"}