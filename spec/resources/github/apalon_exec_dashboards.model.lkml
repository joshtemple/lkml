connection: "phish_thesis"
#{
include: "/config.lkml"
include: "/views/deferred_revenue/*.view.lkml"
include: "/views/exec_dash/*.view.lkml"
include: "/views/dqm/*.view.lkml"
# }

view: process_issues {

  derived_table: {
    sql:
    select process_name, execution_end_time_last, is_job_processed_status
    from (
      select
        process_name ,
        max(execution_start_time) as execution_start_time_last,
        max(execution_end_time) as execution_end_time_last,
        Case when (process_name like 'apalon-%ldtrack_ltv' and to_date(max(execution_end_time)) = date_trunc('week', current_date))
        then True
        when (process_name like 'apalon-executive_dashboard_%monthly' and date_trunc('month',to_date(max(execution_end_time))) = date_trunc('month', current_date))
        then True
        when to_date(max(execution_end_time)) = current_date then True
        else False end is_job_processed_status
      from global.process_log as x
      where process_name like 'apalon-%' and execution_end_time > DATEADD('DAY',-1 * 10,CURRENT_DATE())
      group by 1 )
      where (is_job_processed_status = False and
      execution_end_time_last < (select max(process_date_end) from global.process_log where process_name='apalon-executive_dashboard_daily')
      )

    ;;
  }

  measure: process_list{
    type:  string
    sql:  listagg(distinct (${TABLE}.process_name || ' ran on : ' ||  ${TABLE}.execution_end_time_last || ' ; ' ) );;
  }

  dimension: process_name{
    type:  string
    sql:  ${TABLE}.process_name ;;
  }

  dimension:  last_execution_end_time{
    type:  date
    sql:  ${TABLE}.execution_end_time_last ;;
  }

  dimension: is_job_processed_status {
    type:  string
    sql:  ${TABLE}.is_job_processed_status ;;
  }
}



explore: executive_dashboard_daily {
  view_name: "executive_dashboard_daily"
  description: "Apalon daily aggregate"
  label: "Apalon daily aggregate"
  group_label: "Apalon"
  view_label: "Apalon"
  hidden:  yes

  join: process_issues {
    relationship: one_to_one
    sql_on: ${process_issues.last_execution_end_time} < ${executive_dashboard_daily.batch_date};;
  }

  join: apalon_exec_dash_report_issue {
    relationship: one_to_one
    sql_on: 1=1;;
  }
}

explore: executive_dashboard_monthly {
  view_name: "executive_dashboard_monthly"
  description: "Apalon monthly aggregate"
  label: "Apalon monthly aggregate"
  group_label: "Apalon"
  view_label: "Apalon"
  hidden:  yes
}


explore: apalon_process_logs {
  view_name: "process_log"
  description: "Apalon process logs"
  label: "Apalon process logs"
  group_label: "Apalon"
  view_label: "Apalon"
  hidden:  yes
}



explore: team_exec_dash_apalon_pivot {
  view_name: "team_exec_dash_apalon_pivot"
  description: "Apalon new dash pivot version"
  label: "Apalon team exec dash"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_with: dm_erc_refresh
  hidden:  yes
}

explore: team_exec_dash_teltech_pivot_pivot {
  view_name: "team_exec_dash_teltech_pivot"
  description: "TelTech new dash pivot version"
  label: "TelTech exec dash"
  group_label: "TelTech"
  view_label: "TelTech"
  persist_with: dm_erc_refresh
  hidden:  yes
}

explore: v_apalon_active_subscribers {
  view_name: "v_apalon_active_subscribers"
  description: "Apalon active subscribers version"
  label: "Apalon active subscribers report"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_with: fact_global_refresh
  hidden:  yes

}

explore: direct_sql_monthly_revenue_google_from_store  {
  view_name: "direct_sql_monthly_revenue_google_from_store"
  label: "Apalon monthly revenue with google detail"
  group_label: "Apalon"
  view_label: "Apalon"
  hidden:  yes
}
explore: monthly_user_subs_sessions_info  {
  view_name: "monthly_user_subs_sessions_info"
  label: "Apalon monthly info about users"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_with: monthly_fact_global_refresh
  hidden:  yes
}
explore: monthly_user_subs_convert_days  {
  view_name: "monthly_user_subs_convert_days"
  label: "Apalon monthly users conversion info"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_with: monthly_fact_global_refresh
  hidden:  yes
}

explore: monthly_kpi_report  {
  view_name: "monthly_kpi_report"
  label: "Apalon complex monthly KPI"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_with: dm_erc_refresh
  hidden: yes


  join: dm_priority_application {
    type: inner
    relationship: one_to_one
    sql_on: ${dm_priority_application.app_platform}= ${monthly_kpi_report.app_platform};;
  }
}


explore: MARKETING_ASSUMPTIONS  {
  view_name: "marketing_assumptions"
  label: "Marketing Assumptions"
  persist_with: marketing_report_refresh
}

explore: apalon_only_spend {
  view_name: "apalon_only_spend"
  persist_for: "30 minutes"
  label: "Bookings, Spend by Months"
  hidden:  yes
}

explore: mark_dash_monthly_1 {
  view_name: "mark_dash_monthly_1"
  persist_for: "30 minutes"
  label: "Bookings, Spend by Months"
  hidden:  yes
}

explore: mark_dash_daily_1 {
  view_name: "mark_dash_daily_1"
  persist_for: "30 minutes"
  label: "Bookings, Spend by Months"
  hidden:  yes
  join: business_lvl_data_check {
    fields: []
    relationship: many_to_one
    sql_on: lower(${mark_dash_daily_1.Org})=lower(${business_lvl_data_check.business});;
  }

  join: exec_dash_date_check {
    fields: []
    relationship: many_to_one
    sql_on: lower(${mark_dash_daily_1.Org})=lower(${exec_dash_date_check.business})
      and (case when ${mark_dash_daily_1.Metric} like '%Bookings' then 'total gross bookings' else lower(${mark_dash_daily_1.Metric}) end)=lower(${exec_dash_date_check.metric});;
  }
}

explore: apalon_only_spend_daily {
  view_name: "apalon_only_spend_daily"
  persist_for: "30 minutes"
  label: "Bookings, Spend by Day for the last 17 weeks"
  hidden:  yes
  join: business_lvl_data_check {
    fields: []
    relationship: many_to_one
    sql_on: lower(${apalon_only_spend_daily.Org})=lower(${business_lvl_data_check.business});;
  }

  join: exec_dash_date_check {
    fields: []
    relationship: many_to_one
    sql_on: lower(${apalon_only_spend_daily.Org})=lower(${exec_dash_date_check.business})
      and (case when ${apalon_only_spend_daily.Metric} like '%Bookings' then 'total gross bookings' else lower(${apalon_only_spend_daily.Metric}) end)=lower(${exec_dash_date_check.metric});;
  }
}

explore: monthly_kpi_report_by_app  {
  view_name: "monthly_kpi_report_by_app"
  label: "Apalon monthly KPI by Apps"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_with: dm_erc_refresh
  hidden: yes

  join: dm_priority_application {
    type: inner
    relationship: one_to_one
    sql_on: ${dm_priority_application.app_platform}= ${monthly_kpi_report_by_app.app_platform};;
  }
}

explore: apalon_exec_dash_report_issue {
  hidden: yes
}

explore: feed_data_log {
  view_name: "feed_data_log"
  description: "Data processed by consolidation process"
  label: "Data processed by consolidation process"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  hidden:  yes
}


explore: ads_apalon_data_check {
  view_name: "ads_apalon_data_check"
  description: "ads_apalon_data_check"
  label: "ads_apalon_data_check"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  hidden:  yes
}

explore: test_alex {
  view_name: "test_alex"
  description: "testing account level data check"
  label: "testing account level data check"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  hidden:  yes
}

explore: test_dqm_impacted_reports_ {
  view_name: "test_dqm_impacted_reports_"
  description: "testing account level data check"
  label: "testing account level data check"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  hidden:  yes
}

explore: test_dqm_business_check{
  view_name: "test_dqm_business_check"
  description: "testing account level data check"
  label: "testing account level data check"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  hidden:  yes
}

explore: test_dqm_business_alert{
  view_name: "test_dqm_business_alert"
  description: "testing account level data check"
  label: "testing account level data check"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: test_dqm_process_delay {
  view_name: "test_dqm_process_delay"
  description: "testing account level data check"
  label: "testing account level data check"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  hidden:  yes
}

explore: dqm_invalid_campaigns {
  view_name: "dqm_invalid_campaigns"
  description: "DQM: invalid campaigns"
  label: "DQM: invalid campaigns"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  case_sensitive: no
  hidden:  yes
}

explore: test_marat_widget {
  view_name: "test_marat_widget"
  description: "Color-coded DQM missing data summary widget "
  label: "DQM missing data widget"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_for: "1 hour"
  hidden:  yes
}


explore: defrev_monthly_transactions {
  view_name: "defrev_monthly_transactions"
  description: "[Defered Revenue] Monthly Transactional report (iTranslate)"
  label: "Monthly Transactional report (iTranslate)"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_monthly_transactions_all {
  view_name: "defrev_monthly_transactions_all"
  description: "[Defered Revenue] Monthly Transactional report"
  label: "Monthly Transactional report"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_deferred_revenue_all {
  view_name: "defrev_deferred_revenue_all"
  description: "Defered Revenue report"
  label: "Defered Revenue report"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_deferred_revenue_itr {
  view_name: "defrev_deferred_revenue_itr"
  description: "Defered Revenue report (iTranslate)"
  label: "Defered Revenue report (iTranslate)"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_waterfall {
  view_name: "defrev_waterfall"
  description: "Defered Revenue Waterfall"
  label: "Defered Revenue Waterfall report"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_waterfall_details {
  view_name: "defrev_waterfall_details"
  description: "Defered Revenue Waterfall Details"
  label: "Defered Revenue Waterfall report details"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_waterfall_details_v0 {
  view_name: "defrev_waterfall_details_v0"
  description: "Defered Revenue Waterfall Details"
  label: "Defered Revenue Waterfall report details"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_all_apalon_revenue {
  view_name: "defrev_all_apalon_revenue"
  description: "All Apalon Revenue"
  label: "All Apalon Revenue"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_revenue_by_geo {
  view_name: "defrev_revenue_by_geo"
  description: "Revenue recognized by GEO"
  label: "Revenue recognized by GEO"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_journal_entry {
  view_name: "defrev_journal_entry"
  description: "Journal Entry"
  label: "Journal Entry"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_journal_entry_defrelease {
  view_name: "defrev_journal_entry_defrelease"
  description: "Journal Entry Deferred Release"
  label: "Journal Entry Deferred Release"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_refunds {
  view_name: "defrev_refunds"
  description: "Total Refunds as a % of Sales"
  label: "Total Refunds as a % of Sales"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: defrev_refunds_distribution {
  view_name: "defrev_refunds_distribution"
  description: "Distribution of Refunds by Month"
  label: "Distribution of Refunds by Month"
  group_label: ""
  view_label: ""
  persist_for: "1 hour"
  hidden:  yes
}

explore: google_dcc {
  view_name: "raw_data_dc"
  description: "Google Data Consistency Check"
  label: "Google Data Consistency Check"
  persist_for: "1 hour"
#   hidden:  yes
}


explore: google_dc {
  view_name: "google_dc"
  description: "Google Data Consistency Check 2"
  label: "Google Data Consistency Check 2"
  persist_for: "1 hour"
#   hidden:  yes
}

explore: monthly_spend_report {
  view_name: "monthly_spend_report"
  description: "Monhtly Spend Report"
  label: "Monhtly Spend Report"
  persist_for: "1 hour"
}

explore: monthly_spend_report2 {
  view_name: "monthly_spend_report2"
  description: "Monhtly Spend Report with Monthly Selector"
  label: "Monhtly Spend Report w/ Monthly Selector"
  persist_for: "1 hour"
}

explore: monthly_spend_report3 {
  view_name: "monthly_spend_report3"
  description: "Monhtly Spend Report with Daily Breakout"
  label: "Monhtly Spend Report w/ Daily Breakout"
  persist_for: "1 hour"
}

explore: feed_data_log_test {
  persist_with: dm_erc_refresh
}


explore: ltv_weekly_run_check {
  persist_with: dm_erc_refresh
}

explore: process_log_report {
  persist_with: dm_erc_refresh
}

explore: delayed_apple_data_spend_revenue {
  persist_with: dm_erc_refresh
}

explore: delayed_adnetworks_with_dash {
  persist_with: dm_erc_refresh
}

explore: apple_data_is_back {
  persist_with: dm_erc_refresh
}

explore: ltv_subs_revenue_data_check {
  persist_with: dm_erc_refresh
}

explore: ltv_ads_data_check {
  persist_with: dm_erc_refresh
}

explore: daily_kpi_report_by_app  {
  view_name: "daily_kpi_report_by_app"
  label: "Apalon daily KPI by Apps"
  group_label: "Apalon"
  view_label: "Apalon"
  persist_with: dm_erc_refresh
  hidden: yes


  join: dm_priority_application {
    type: left_outer
    relationship: one_to_one
    sql_on: ${dm_priority_application.app_platform}= ${daily_kpi_report_by_app.app_platform};;
  }

}