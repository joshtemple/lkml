connection: "data_warehouse"

include: "pwd*[!.][!z].view.lkml"
include: "marketo*[!.][!z].view.lkml"
include: "mta_report.view.lkml"
include: "sf__accounts.view.lkml"
include: "docker_www_roi_calculator_success.view.lkml"
include: "reghub*[!.][!z].view.lkml"
include: "website*[!.][!z].view.lkml"
include: "account_tam_healthcheck_20181210.view.lkml"

explore: account_tam_healthcheck_20181210 {
  hidden: yes
}

explore: pwd_pages {
  hidden:  yes
  label: "Play-With-Docker Page Calls"

  join: docker_users {
    from: reghub_dockeruser
    sql_on: ${pwd_pages.user_id} =  ${docker_users.uuid};;
    relationship: many_to_one
  }
}

explore: mta_report {
  hidden:  yes
  view_label: "MTA Report"
  label: "MTA Report"
  description: "DataSource: spreadsheet"

  join: sf__accounts {
    sql_on: ${sf__accounts.account_id} =  ${mta_report.sfdc_account_id};;
    relationship: many_to_one
  }
}

explore: pwd_identifies {
  hidden:  yes
  label: "Play-With-Docker Identify Calls"
}
explore: pwd_users {
  hidden:  yes
  label: "Play-With-Docker Users"
}

explore: pwd_logged_page_visits {
  hidden: no
  label: "First Play-With-Docker Visits by Users"
}

explore: website_performance_timing {
  hidden:  yes
  label: "Looker Performance Monitoring"
}

explore: roi_calculator_success {
  from: docker_www_roi_calculator_success
  hidden:  yes
  label: "Docker ROI Calculator Success"
  description: "Successful submissions from the Docker ROI Calculator"
}
