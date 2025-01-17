include: "/GA/*.view"
include: "/Facebook/*.view"
include: "/DCM/*.view"
include: "/Adwords/*.view"
include: "/LinkedIn/*.view"

explore: tds_ga {
  hidden:  yes
  view_name: tds_ga_acquisition_view
  label: "Google Analytics"
  view_label: "Website Acquisiton"
  group_label: "The Dentists Supply Company"

  join: tds_ga_audience_view {
    view_label: "Users"
    sql_on: ${tds_ga_audience_view.acq_join_id} = ${tds_ga_acquisition_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: tds_ga_behavior_view {
    view_label: "Pages"
    sql_on: ${tds_ga_behavior_view.acq_join_id} = ${tds_ga_acquisition_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: tds_ga_transactions_view {
    view_label: "Transactions"
    sql_on: ${tds_ga_transactions_view.acq_join_id} = ${tds_ga_acquisition_view.acq_join_id} ;;
    relationship: many_to_one
  }

  join: tds_ga_ecommerce_view {
    view_label: "Products"
    sql_on: ${tds_ga_ecommerce_view.ecommerce_join_id} = ${tds_ga_transactions_view.ecommerce_join_id} ;;
    relationship: one_to_many
  }

  join: tds_ga_ads_lookup {
    view_label: "Paid Traffic - Ads Information"
    type: inner
    fields: []
    sql_on: ${tds_ga_ads_lookup.ad_id} = ${tds_ga_acquisition_view.ga_ads_lookup_id} ;;
    relationship: one_to_many
  }

#   join: tds_fb_ga_view {
#     view_label: "Paid Traffic - Ads Information"
#     fields: [tds_fb_ga_view.ga_fb_info*]
#     type: inner
#     sql_on: ${tds_fb_ga_view.ad_id} = ${tds_ga_ads_lookup.ad_id} ;;
#     relationship: many_to_one
#   }

#   join: tds_dcm_ga_view {
#     view_label: "DoubleClick Campaigns"
#     fields: [tds_dcm_ga_view.ga_dcm_info*]
#     type: inner
#     sql_on: ${tds_fb_dcm_view.ad_id} = ${tds_ga_acquisition_view.keyword} ;;
#     relationship: one_to_many
#   }

#   join: tds_sem_ga_view {
#     view_label: "AdWords Search Campaigns"
#     fields: [tds_sem_ga_view.ga_sem_info*]
#     type: inner
#     sql_on: ${tds_sem_ga_view.ad_group_id} = ${tds_ga_acquisition_view.adwordsadgroupid} ;;
#     relationship: one_to_many
#   }

#   join: tds_gdn_ga_view {
#     view_label: "AdWords Display Campaigns"
#     fields: [tds_gdn_ga_view.ga_gdn_info*]
#     type: inner
#     sql_on: ${tds_gdn_ga_view.ad_group_id} = ${tds_ga_acquisition_view.adwordsadgroupid} ;;
#     relationship: one_to_many
#   }

}
