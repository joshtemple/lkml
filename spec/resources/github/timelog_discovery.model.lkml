connection: "istime"

include: "*.view"

explore: time_log {
  label: "Time Log Analytics"
  view_label: "Time Log"
  group_label: "Time Log Analytics"  #Grouping in the EXPLORE Dropdown
  from: time_log
  view_name: time_log
  sql_table_name: dbo.timelog ;;

  join: services {
    view_label: "Service"
    relationship: one_to_many
    type: inner
    sql_on: ${services.services_id} = ${time_log.services_id} ;;
  }

  join: service_category {
    view_label: "Service"
    relationship: one_to_many
    type: inner
    sql_on: ${service_category.service_category_id} = ${services.service_category_id} ;;
  }

#   join: status_code {
#     view_label: "Service"
#     relationship: one_to_many
#     type: inner
#     sql_on: ${status_code.statuscode_id} = ${services.statuscode_id} ;;
#   }

  join: company {
    view_label: "Company"
    relationship: one_to_many
    type: inner
    sql_on: ${company.company_id} = ${time_log.company_id} ;;
  }

  join: users {
    view_label: "User"
    relationship: one_to_many
    type: inner
    sql_on: ${users.users_id} = ${time_log.users_id} ;;
  }
}
