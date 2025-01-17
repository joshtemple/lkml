connection: "db"

# include all the views
include: "*.view"
include: "/views/vw_credits_w_salecodes_only.view"

datagroup: credits_w_cases_w_salecodes_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hours"
}

access_grant: citysprint_access {
  user_attribute: citysprint_explore
  allowed_values: ["yes"]
}

persist_with: credits_w_cases_w_salecodes_default_datagroup

explore: vw_credits_cases_w_salecodes {
  persist_with: credits_w_cases_w_salecodes_default_datagroup
  label: "Credits Cases And Salecodes"


join: aged_debt_view {
  view_label: "Aged Debt View"
  relationship: one_to_one
  sql_on: ${aged_debt_view.cust_key} = ${vw_credits_cases_w_salecodes.customer_account_key}  ;;
}

join: vw_credits_w_salecodes_only {
  view_label: "Credits Without Case Data"
  relationship: many_to_many
  sql_on: ${vw_credits_cases_w_salecodes.customer_account_key} = ${vw_credits_w_salecodes_only.customer_account_key}  ;;

}

}
