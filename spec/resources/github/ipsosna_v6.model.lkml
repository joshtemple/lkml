connection: "brandgeist_bq_v1"

# include all the views
include: "/views/**/*.view"

 datagroup: ipsosna_v6_default_datagroup {
   sql_trigger: SELECT TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(),hour) ;;
   max_cache_age: "24 hours"
 }

 persist_with: ipsosna_v6_default_datagroup

explore: bg_rld_eav_ids_us_only {
  label: "Brandgeist Crosstab"
  view_name: bg_rld_eav_ids_us_only
  view_label: "Brandgeist Crosstab"
  sql_always_where: STRPOS(${bg_rld_flat_us_with_labels.brands_aware_of},',_1,')>0 ;;

  join: bg_rld_responses {
    view_label: "Brandgeist Crosstab"
    relationship: many_to_one
    type: left_outer
    sql_on: ${bg_rld_responses.response_id} = ${bg_rld_eav_ids_us_only.response_id} ;;
  }

  join: bg_rld_metrics {
    view_label: "Brandgeist Crosstab"
    relationship: many_to_one
    type: left_outer
    sql_on: ${bg_rld_eav_ids_us_only.metric_id} = ${bg_rld_metrics.metric_id} ;;
  }

  join: bg_rld_flat_us_with_labels {
    view_label: "Brandgeist Crosstab"
    relationship: one_to_one
    type: left_outer
    sql_on: ${bg_rld_eav_ids_us_only.respondent_uuid} = ${bg_rld_flat_us_with_labels.respondent_uuid};;
  }
}

explore: brandgeist_users {
  label: "Brandgeist for Users"
  view_name: brandgeist_rld_metric_hdata
  view_label: "Brandgeist for Users"
  sql_always_where: STRPOS(${bg_rld_flat_us_with_labels_2.brands_aware_of},',_1,')>0 ;;

  join: bg_rld_eav_labels_us_only {
    view_label: "Brandgeist for Users"
    relationship: one_to_one
    type: left_outer
    sql_on: ${bg_rld_eav_labels_us_only.respondent_uuid} = ${brandgeist_rld_metric_hdata.respondent_uuid};;
  }

  join: bg_rld_flat_us_with_labels_2 {
    view_label: "Brandgeist for Users"
    relationship: one_to_one
    type: left_outer
    sql_on: ${bg_rld_flat_us_with_labels_2.respondent_uuid} = ${brandgeist_rld_metric_hdata.respondent_uuid};;
  }
}
