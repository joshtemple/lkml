connection: "brandpulse1"

# include all the views
include: "/views/**/*.view"

# User Explore for Brand Pulse users
explore: f_variable_fact_flat_model {
  label: "Google Brand Pulse for Users"
  view_name: f_variable_fact_flat_model
  view_label: "Google Brand Pulse for Users"
#   sql_always_having: ${e_demographic_model.percent_weight} is not null ;;
#   sql_always_having: sum(${e_demographic_model.percent_weight}) ;;
#   always_filter: {
#     filters: {
#       field: e_demographic_model.percent_weight
#       value: "null"
#     }
#   }

  join: b_category_master {
    view_label: "Google Brand Pulse for Users"
    type: inner
    relationship: one_to_one
    sql_on: ${f_variable_fact_flat_model.category_id} = ${b_category_master.category_id};;
  }

  join: c_variable_category_map {
    view_label: "Google Brand Pulse for Users"
    type: inner
    relationship: one_to_one
    sql_on: ${f_variable_fact_flat_model.category_id} = ${c_variable_category_map.category_id};;
  }

  join: e_demographic_model {
    view_label: "Google Brand Pulse for Users"
    type: inner
    relationship: many_to_one
    sql_on: ${f_variable_fact_flat_model.unique_id} = ${e_demographic_model.unique_id};;
  }
}

#Crosstab Explore
explore: g_variable_fact_eav_model {
  label: "Google Brand Pulse Crosstab"
  view_name: g_variable_fact_eav_model
  view_label: "Google Brand Pulse Crosstab"

  sql_always_where: ${value} is not null ;;

  join: a_variable_master {
    view_label: "Google Brand Pulse Crosstab"
    type: inner
    relationship: one_to_one
    sql_on: ${g_variable_fact_eav_model.variable_id} = ${a_variable_master.variable_id};;
  }

  join: b_category_master {
    view_label: "Google Brand Pulse Crosstab"
    type: inner
    relationship: one_to_one
    sql_on: ${g_variable_fact_eav_model.category_id} = ${b_category_master.category_id};;
  }

  join: c_variable_category_map {
    view_label: "Google Brand Pulse Crosstab"
    type: inner
    relationship: one_to_one
    sql_on: ${g_variable_fact_eav_model.category_id} = ${c_variable_category_map.category_id};;
  }

  join: d_variable_value_master {
    view_label: "Google Brand Pulse Crosstab"
    type: inner
    relationship: one_to_one
    sql_on: ${g_variable_fact_eav_model.variable_id} = ${d_variable_value_master.variable_id};;
  }

  join: e_demographic_model_2 {
    view_label: "Google Brand Pulse Crosstab"
    type: inner
    relationship: many_to_one
    sql_on: ${g_variable_fact_eav_model.unique_id} = ${e_demographic_model_2.unique_id};;
  }

  join: variable_value_derived_view {
    view_label: "Google Brand Pulse Crosstab"
    type: inner
    relationship: one_to_one
    sql_on: ${g_variable_fact_eav_model.variable_id} = ${variable_value_derived_view.variableid};;
  }
}
