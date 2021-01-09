connection: "gpay"

# include all the views
include: "/views/**/*.view"

datagroup: ipsosna_v7_default_datagroup {
  sql_trigger: SELECT TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(),hour) ;;
  max_cache_age: "96 hours"
}

persist_with: ipsosna_v7_default_datagroup

explore: gpay_crosstab {
  label: "Crosstab for Google Pay"
  view_name: rldflat
  view_label: "Crosstab for Google Pay"
  sql_always_where: ${rldeav.vtype} IN ('single','multi') AND ${rldeav.response_label} NOT IN ('None of these');;

  join: rldeav {
    view_label: "Crosstab for Google Pay"
    relationship: many_to_one
    type: left_outer
    sql_on: ${rldeav.respondent_serial} = ${rldflat.respondent_serial} ;;
  }

  join: rldeav_filter1 {
    view_label: "Crosstab for Google Pay"
    relationship: many_to_one
    type: left_outer
    sql_on: ${rldeav_filter1.respondent_serial} = ${rldflat.respondent_serial} ;;
  }

  join: rldeav_filter2 {
    view_label: "Crosstab for Google Pay"
    relationship: one_to_one
    type: inner
    sql_on: ${rldeav_filter2.respondent_serial} = ${rldflat.respondent_serial} ;;
  }

  join: rldeav_filter3 {
    view_label: "Crosstab for Google Pay"
    relationship: one_to_one
    type: inner
    sql_on: ${rldeav_filter3.respondent_serial} = ${rldflat.respondent_serial} ;;
  }
}

explore: gpay_funnel {
  label: "Funnel for Google Pay"
  view_name: bases
  view_label: "Funnel for Google Pay"

  join: counts {
    view_label: "Funnel for Google Pay"
    relationship: many_to_one
    type: left_outer
    sql_on: ${counts.metric_id} = ${bases.metric_id} AND ${counts.wave_sid} = ${bases.wave_sid};;
  }

  join: wave_labels {
    view_label: "Funnel for Google Pay"
    relationship: one_to_one
    type: inner
    sql_on: ${wave_labels.response_code} = ${bases.wave_sid} ;;
  }
}

explore: gpay_crosstab_v2 {
  label: "Crosstab for GPay v2"
  view_name: bases_v2
  view_label: "Crosstab for GPay v2"

  join: counts_v2 {
    view_label: "Crosstab for GPay v2"
    relationship: many_to_one
    type: left_outer
    sql_on: ${counts_v2.metric_id} = ${bases_v2.metric_id}
        AND ${counts_v2.resp_gender} = ${bases_v2.resp_gender}
        AND ${counts_v2.QuotAgeRange} = ${bases_v2.quotagerange}
       ;;
  }

  join: rldeav_filter1 {
    view_label: "Crosstab for Google Pay"
    relationship: one_to_one
    type: inner
    required_joins: [counts_v2]
    sql_on: ${rldeav_filter1.respondent_serial} = ${bases_v2.respondent_serial};;
  }

  join: rldeav_filter2 {
    view_label: "Crosstab for Google Pay"
    relationship: one_to_one
    type: inner
    required_joins: [counts_v2]
    sql_on: ${rldeav_filter2.respondent_serial} = ${bases_v2.respondent_serial};;
  }

  join: rldeav_filter3 {
    view_label: "Crosstab for Google Pay"
    relationship: one_to_one
    type: inner
    required_joins: [counts_v2]
    sql_on: ${rldeav_filter3.respondent_serial} = ${bases_v2.respondent_serial};;
  }
}
