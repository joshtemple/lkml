include: "/Google_Analytics/*.view"
include: "/TrueView/*.view"
include: "/Facebook/*.view"
include: "/DCM/*.view"
include: "/AdWords/*.view"


explore: mam_ga {
  hidden:  yes
  view_name: mam_ga_acquisition_view
  label: "Google Analytics"
  view_label: "Website Acquisiton"
  group_label: "Mammoth Lakes Tourism"

  join: mam_ga_audience_view {
    view_label: "Users"
    sql_on: ${mam_ga_audience_view.acq_join_id} = ${mam_ga_acquisition_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: mam_ga_behavior_view {
    view_label: "Pages"
    sql_on: ${mam_ga_behavior_view.acq_join_id} = ${mam_ga_acquisition_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: mam_ga_ads_lookup {
    view_label: "Paid Traffic - Ads Information"
    type: inner
    fields: []
    sql_on: ${mam_ga_ads_lookup.ad_id} = ${mam_ga_acquisition_view.ga_ads_lookup_id} ;;
    relationship: one_to_many
  }
}
