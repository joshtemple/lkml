connection: "bq"
label: "Power BI Reports"
include: "bda_data.view.lkml"
include: "bda_shipped_summary.view.lkml"
include: "casestopick.view.lkml"
include: "containers.view.lkml"
include: "presortdashboard.view.lkml"
include: "refresh_time.view.lkml"
include: "wavesinprogress_summary.view.lkml"
include: "wip_div_name_table.view.lkml"
include: "wip_process_area_desc.view.lkml"
include: "wip_summary.view.lkml"
include: "wip_summary_container.view.lkml"
include: "wip_summary_detail.view.lkml"

datagroup: macys_datagroup {
  ###Can be set to match your etl process
  sql_trigger: SELECT TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(),hour) ;;
  max_cache_age: "4 hours"
}

persist_with: macys_datagroup

explore: bda_data {
  label: "BDA Reports"
  join: wip_summary {
    relationship: many_to_one
    type: left_outer
    sql_on: ${bda_data.rcpt_nbr} = ${wip_summary.rcpt_nbr} ;;
  }
  join: wip_process_area_desc {
    view_label: "Process_Area_Desc"
    relationship: many_to_one
    type: left_outer
    sql_on: ${bda_data.process_area}=${wip_process_area_desc.proc_area_short_desc} ;;
  }
}

# Waves In Progress

explore: casestopick {
  label: "Waves in progress Reports"
  join: wavesinprogress_summary {
    relationship: many_to_one
    type: left_outer
    sql_on: ${casestopick.wave_number} = ${wavesinprogress_summary.wave_number} ;;
  }
}

#preSortDashboard

explore: containers {
  label: "preSortDasboard"
  join: presortdashboard {
    relationship: many_to_one
    type: left_outer
    sql_on: ${containers.wave_number} = ${presortdashboard.wave_number} ;;
  }
}
# Last Refresh time
explore: refresh_time {}

#WIP Summary

explore: wip_summary_container {
  label: "WIP Summary Dashboard"
  join: wip_summary_detail {
    relationship: many_to_one
    type: left_outer
    sql_on: ${wip_summary_container.rcpt_nbr}=${wip_summary_detail.rcpt_nbr} ;;
  }

  join: wip_process_area_desc {
    relationship: many_to_one
    type: left_outer
    sql_on: ${wip_summary_detail.process_area}=${wip_process_area_desc.proc_area_short_desc} ;;
  }

}
