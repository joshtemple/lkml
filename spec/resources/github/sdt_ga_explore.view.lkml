include: "/Google_Analytics/*.view"
include: "/TrueView/*.view"
include: "/Facebook/*.view"
include: "/DCM/*.view"
include: "/AdWords/*.view"
include: "/Pinterest/*.view"

datagroup: sdt_ga_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: sdt_ga {
  hidden:  yes
  view_name: sdt_ga_acq_view
  label: "Google Analytics"
  view_label: "Website Acquisiton"
  group_label: "San Diego Tourism"

  join: sdt_ga_behavior_view {
    view_label: "Pages"
    sql_on: ${sdt_ga_behavior_view.acq_join_id} = ${sdt_ga_acq_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: sdt_ga_geo_view {
    view_label: "Geo"
    sql_on: ${sdt_ga_geo_view.acq_join_id} = ${sdt_ga_acq_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: sdt_ga_events_view {
    view_label: "Events"
    sql_on: ${sdt_ga_events_view.acq_join_id} = ${sdt_ga_acq_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: sdt_ga_ads_lookup {
    view_label: "Ads Lookup"
    sql_on: ${sdt_ga_ads_lookup.ad_platform_id} = ${sdt_ga_acq_view.ga_ads_lookup_id} ;;
    fields: []
    type: inner
    relationship: many_to_one
  }

  join: sdt_ga_campaigns_lookup {
    view_label: "Campaign Lookup"
    sql_on: ${sdt_ga_campaigns_lookup.ad_id} = ${sdt_ga_acq_view.ga_ads_lookup_id} ;;
    fields: []
    type: inner
    relationship: many_to_one
  }

#   join: tna_ga_ads_lookup {
#     view_label: "Paid Traffic - Ads Information"
#     type: inner
#     fields: []
#     sql_on: ${sdt_ga_ads_lookup.ad_id} = ${sdt_ga_acquisition_view.ga_ads_lookup_id} ;;
#     relationship: one_to_many
#   }
}
