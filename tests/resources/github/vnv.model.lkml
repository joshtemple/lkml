connection: "mc_panoply"

# include all the views
# include: "/AdWords/**/*.view"
# include: "/DCM/**/*.view"
# include: "/Facebook/**/*.view"
# include: "/Google_Analytics/**/*.view"
# include: "/LinkedIn/**/*.view"
# include: "/TrueView/**/*.view"



datagroup: vnv_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

label: "Visit Napa Valley"

persist_with: vnv_default_datagroup


# #### Exploring AdWords Display Data #####
#
# explore: vnv_gdn {
#   view_name: vnv_sem_gdn_view
#   always_filter: {
#     filters: {
#       field: advertising_channel
#       value: "Display"
#     }
#   }
#   label: "AdWords Display"
#   view_label: "AdWords Display"
#
#   join: vnv_ga_onsite {
#     view_label: "Google Analytics"
#     fields: []
#     type:left_outer
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.join_id} ;;
#     relationship: many_to_one
#     }
#
#   join: vnv_ga_userinfo {
#     view_label: "Google Analytics - User Info"
#     type: left_outer
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.join_id} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_pageinfo {
#     view_label: "Google Analytics - Page Info"
#     type: inner
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.join_id} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_events {
#     view_label: "Google Analytics - Events"
#     type: inner
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.join_id} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_goals {
#     view_label: "Google Analytics - Goals"
#     type: inner
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.join_id} ;;
#     relationship: many_to_one
#   }
#   }

#### Exploring AdWords SEM Data #####

# explore: vnv_sem {
#   view_name: vnv_sem_gdn_view
#   always_filter: {
#     filters: {
#       field: advertising_channel
#       value: "Search"
#     }
#   }
#   label: "AdWords Search"
#   view_label: "AdWords Search"
#   group_label: "Visit Napa Valley"
#
#   join: vnv_ga_onsite {
#     view_label: "Google Analytics"
#     fields: []
#     type:left_outer
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.comp_key} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_userinfo {
#     view_label: "Google Analytics - User Info"
#     type: left_outer
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.comp_key} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_pageinfo {
#     view_label: "Google Analytics - Page Info"
#     type: inner
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.comp_key} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_events {
#     view_label: "Google Analytics - Events"
#     type: inner
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.comp_key} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_goals {
#     view_label: "Google Analytics - Goals"
#     type: inner
#     sql_on: ${vnv_ga_onsite.adwords_join_id} = ${vnv_sem_gdn_view.comp_key} ;;
#     relationship: many_to_one
#   }
# }

#### Exploring DCM Data #####

# explore: vnv_dcm_view {
#   label: "DoubleClick"
#   view_label: "DoubleClick"
#   group_label: "Visit Napa Valley"
#
#   join: vnv_mc_ga_view {
#     view_label: "Google Analytics"
#     fields: []
#     type: left_outer
#     sql_on: ${vnv_dcm_view.comp_key} = ${vnv_mc_ga_view.comp_key} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_userinfo {
#     view_label: "Google Analytics - User Info"
#     type: left_outer
#     sql_on: ${vnv_dcm_view.comp_key} = ${vnv_ga_userinfo.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: vnv_ga_pageinfo {
#     view_label: "Google Analytics - Page Info"
#     type: inner
#     sql_on: ${vnv_dcm_view.comp_key} = ${vnv_ga_pageinfo.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: vnv_ga_events {
#     view_label: "Google Analytics - Events"
#     type: inner
#     sql_on: ${vnv_dcm_view.comp_key} = ${vnv_ga_events.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: vnv_ga_goals {
#     view_label: "Google Analytics - Goals"
#     type: inner
#     sql_on: ${vnv_dcm_view.comp_key} = ${vnv_ga_goals.join_id} ;;
#     relationship: one_to_many
#   }
# }

#### Exploring Facebook Data #####

# explore: vnv_fb_view {
#   label: "Facebook"
#   view_label: "Facebook"
#   group_label: "Visit Napa Valley"
#
#   join: facebookads__visit_napa_valley_actions {
#     view_label: "Facebook Actions"
#     type: left_outer
#     fields: []
#     sql_on: ${facebookads__visit_napa_valley_actions.facebookads__visit_napa_valley_id} = ${vnv_fb_view.id} ;;
#     relationship: many_to_one
#   }
#
#   join: facebookads__visit_napa_valley_video_p100_watched_actions {
#     view_label: "Vid Completes"
#     type: left_outer
#     fields: []
#     sql_on: ${facebookads__visit_napa_valley_video_p100_watched_actions.facebookads__visit_napa_valley_id} = ${vnv_fb_view.id} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_mc_ga_view {
#     view_label: "Google Analytics"
#     type: left_outer
#     fields: []
#     sql_on: ${vnv_fb_view.comp_key} = ${vnv_mc_ga_view.comp_key} ;;
#     relationship: many_to_one
#   }
#
#   join: vnv_ga_userinfo {
#     view_label: "Google Analytics - User Info"
#     type: left_outer
#     sql_on: ${vnv_fb_view.comp_key} = ${vnv_ga_userinfo.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: vnv_ga_pageinfo {
#     view_label: "Google Analytics - Page Info"
#     type: left_outer
#     sql_on: ${vnv_fb_view.comp_key} = ${vnv_ga_pageinfo.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: vnv_ga_events {
#     view_label: "Google Analytics - Events"
#     type: left_outer
#     sql_on: ${vnv_fb_view.comp_key} = ${vnv_ga_events.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: vnv_ga_goals {
#     view_label: "Google Analytics - Goals"
#     type: left_outer
#     sql_on: ${vnv_fb_view.comp_key} = ${vnv_ga_goals.join_id} ;;
#     relationship: one_to_many
#   }
#
#
# }

# ###### Exploring TrueView Data #######
#
# explore: vnv_us_trueview {
#   label: "YouTube"
#   group_label: "Visit Napa Valley"
#   view_label: "AdWords"
# }



#### Exploring LinkedIn Data #####

# explore: vnv_linkedin_campaign  {
#   label: "LinkedIn"
#   group_label: "Visit Napa Valley"
#   view_label: "LinkedIn"
# }

################ Exploring Google Analytics Data ###########

# explore: vnv_googleAnalytics{
#   view_name: vnv_ga_onsite
#   label: "Google Analytics"
#   group_label: "Visit Napa Valley"
#   view_label: "Google Analytics"
# }


# explore: adwords_ad_performance_report {}

# explore: adwords_adgroup_performance_report {}

# explore: adwords_criteria_performance_report {}

# explore: adwords_display_keyword_performance_report {}

# explore: adwords_geo_performance_report {}

# explore: adwords_search_query_performance_report {}

# explore: bay_region_community_colleges_cabccd_dcm_639114947 {}

# explore: california_grown_dcm_639114947 {}

# explore: cte_career_education_dcm_639114947 {}

# explore: customers {}

# explore: facebookads {}

# explore: facebookads__mc_tdsc {}

# explore: facebookads__mc_tdsc_action_values {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_action_values.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_actions {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_actions.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_cost_per_action_type {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_cost_per_action_type.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_video_avg_percent_watched_actions {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_video_avg_percent_watched_actions.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_video_p100_watched_actions {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_video_p100_watched_actions.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_video_p25_watched_actions {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_video_p25_watched_actions.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_video_p50_watched_actions {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_video_p50_watched_actions.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_video_p75_watched_actions {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_video_p75_watched_actions.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_tdsc_video_p95_watched_actions {
#   join: facebookads__mc_tdsc {
#     type: left_outer
#     sql_on: ${facebookads__mc_tdsc_video_p95_watched_actions.facebookads__mc_tdsc_id} = ${facebookads__mc_tdsc.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_california {}

# explore: facebookads__mc_visit_california_actions {
#   join: facebookads__mc_visit_california {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_california_actions.facebookads__mc_visit_california_id} = ${facebookads__mc_visit_california.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_california_cost_per_action_type {
#   join: facebookads__mc_visit_california {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_california_cost_per_action_type.facebookads__mc_visit_california_id} = ${facebookads__mc_visit_california.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego {}

# explore: facebookads__mc_visit_san_diego_action_values {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_action_values.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_actions {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_actions.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_cost_per_action_type {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_cost_per_action_type.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_video_avg_percent_watched_actions {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_video_avg_percent_watched_actions.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_video_p100_watched_actions {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_video_p100_watched_actions.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_video_p25_watched_actions {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_video_p25_watched_actions.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_video_p50_watched_actions {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_video_p50_watched_actions.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_video_p75_watched_actions {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_video_p75_watched_actions.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads__mc_visit_san_diego_video_p95_watched_actions {
#   join: facebookads__mc_visit_san_diego {
#     type: left_outer
#     sql_on: ${facebookads__mc_visit_san_diego_video_p95_watched_actions.facebookads__mc_visit_san_diego_id} = ${facebookads__mc_visit_san_diego.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_actions {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_actions.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_cost_per_action_type {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_cost_per_action_type.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_video_avg_percent_watched_actions {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_video_avg_percent_watched_actions.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_video_p100_watched_actions {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_video_p100_watched_actions.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_video_p25_watched_actions {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_video_p25_watched_actions.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_video_p50_watched_actions {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_video_p50_watched_actions.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_video_p75_watched_actions {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_video_p75_watched_actions.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: facebookads_video_p95_watched_actions {
#   join: facebookads {
#     type: left_outer
#     sql_on: ${facebookads_video_p95_watched_actions.facebookads_id} = ${facebookads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: jetsuitex_dcm_639114947 {}

# explore: jj_transformation_test {}

# explore: linkedin_ads_ {}

# explore: linkedin_ads__pivotvalues {
#   join: linkedin_ads_ {
#     type: left_outer
#     sql_on: ${linkedin_ads__pivotvalues.linkedin_ads__id} = ${linkedin_ads_.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: lodi_wines_dcm_639114947 {}

# explore: mam_us_360_trueview_adgroup_performance_report {}

# explore: mam_us_airservice_sem_adgroup_performance_report {}

# explore: mam_us_gdn_adgroup_performance_report {}

# explore: mam_us_sem_adgroup_performance_report {}

# explore: mam_us_trueview_adgroup_performance_report {}

# explore: mam_us_winterblitz_gdn_adgroup_performance_report {}

# explore: mammoth_lakes_tourism_dcm_639114947 {}

# explore: monarch_beach_resort_dcm_639114947 {}

# explore: orderitems {}

# explore: orders {}

# explore: products {}

# explore: salesforce_account {}

# explore: salesforce_account_attributes {
#   join: salesforce_account {
#     type: left_outer
#     sql_on: ${salesforce_account_attributes.salesforce_account_id} = ${salesforce_account.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_account_billingaddress {
#   join: salesforce_account {
#     type: left_outer
#     sql_on: ${salesforce_account_billingaddress.salesforce_account_id} = ${salesforce_account.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_account_shippingaddress {
#   join: salesforce_account {
#     type: left_outer
#     sql_on: ${salesforce_account_shippingaddress.salesforce_account_id} = ${salesforce_account.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_accountfeed {}

# explore: salesforce_accountfeed_attributes {
#   join: salesforce_accountfeed {
#     type: left_outer
#     sql_on: ${salesforce_accountfeed_attributes.salesforce_accountfeed_id} = ${salesforce_accountfeed.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_acton__accountinfo__c {}

# explore: salesforce_acton__accountinfo__c_attributes {
#   join: salesforce_acton__accountinfo__c {
#     type: left_outer
#     sql_on: ${salesforce_acton__accountinfo__c_attributes.salesforce_acton__accountinfo__c_id} = ${salesforce_acton__accountinfo__c.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_acton__serverinformation__c {}

# explore: salesforce_acton__serverinformation__c_attributes {
#   join: salesforce_acton__serverinformation__c {
#     type: left_outer
#     sql_on: ${salesforce_acton__serverinformation__c_attributes.salesforce_acton__serverinformation__c_id} = ${salesforce_acton__serverinformation__c.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_apexclass {}

# explore: salesforce_apexclass_attributes {
#   join: salesforce_apexclass {
#     type: left_outer
#     sql_on: ${salesforce_apexclass_attributes.salesforce_apexclass_id} = ${salesforce_apexclass.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_apexcomponent {}

# explore: salesforce_apexcomponent_attributes {
#   join: salesforce_apexcomponent {
#     type: left_outer
#     sql_on: ${salesforce_apexcomponent_attributes.salesforce_apexcomponent_id} = ${salesforce_apexcomponent.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_apexpage {}

# explore: salesforce_apexpage_attributes {
#   join: salesforce_apexpage {
#     type: left_outer
#     sql_on: ${salesforce_apexpage_attributes.salesforce_apexpage_id} = ${salesforce_apexpage.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_apextrigger {}

# explore: salesforce_apextrigger_attributes {
#   join: salesforce_apextrigger {
#     type: left_outer
#     sql_on: ${salesforce_apextrigger_attributes.salesforce_apextrigger_id} = ${salesforce_apextrigger.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_attachment {}

# explore: salesforce_attachment_attributes {
#   join: salesforce_attachment {
#     type: left_outer
#     sql_on: ${salesforce_attachment_attributes.salesforce_attachment_id} = ${salesforce_attachment.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_businesshours {}

# explore: salesforce_businesshours_attributes {
#   join: salesforce_businesshours {
#     type: left_outer
#     sql_on: ${salesforce_businesshours_attributes.salesforce_businesshours_id} = ${salesforce_businesshours.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_campaign {}

# explore: salesforce_campaign_attributes {
#   join: salesforce_campaign {
#     type: left_outer
#     sql_on: ${salesforce_campaign_attributes.salesforce_campaign_id} = ${salesforce_campaign.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_campaignmember {}

# explore: salesforce_campaignmember_attributes {
#   join: salesforce_campaignmember {
#     type: left_outer
#     sql_on: ${salesforce_campaignmember_attributes.salesforce_campaignmember_id} = ${salesforce_campaignmember.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_campaignmemberstatus {}

# explore: salesforce_campaignmemberstatus_attributes {
#   join: salesforce_campaignmemberstatus {
#     type: left_outer
#     sql_on: ${salesforce_campaignmemberstatus_attributes.salesforce_campaignmemberstatus_id} = ${salesforce_campaignmemberstatus.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_case {}

# explore: salesforce_case_attributes {
#   join: salesforce_case {
#     type: left_outer
#     sql_on: ${salesforce_case_attributes.salesforce_case_id} = ${salesforce_case.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_casefeed {}

# explore: salesforce_casefeed_attributes {
#   join: salesforce_casefeed {
#     type: left_outer
#     sql_on: ${salesforce_casefeed_attributes.salesforce_casefeed_id} = ${salesforce_casefeed.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_casehistory {}

# explore: salesforce_casehistory_attributes {
#   join: salesforce_casehistory {
#     type: left_outer
#     sql_on: ${salesforce_casehistory_attributes.salesforce_casehistory_id} = ${salesforce_casehistory.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_chatteractivity {}

# explore: salesforce_chatteractivity_attributes {
#   join: salesforce_chatteractivity {
#     type: left_outer
#     sql_on: ${salesforce_chatteractivity_attributes.salesforce_chatteractivity_id} = ${salesforce_chatteractivity.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_contact {}

# explore: salesforce_contact_attributes {
#   join: salesforce_contact {
#     type: left_outer
#     sql_on: ${salesforce_contact_attributes.salesforce_contact_id} = ${salesforce_contact.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_contact_mailingaddress {
#   join: salesforce_contact {
#     type: left_outer
#     sql_on: ${salesforce_contact_mailingaddress.salesforce_contact_id} = ${salesforce_contact.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_document {}

# explore: salesforce_document_attributes {
#   join: salesforce_document {
#     type: left_outer
#     sql_on: ${salesforce_document_attributes.salesforce_document_id} = ${salesforce_document.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_emailservicesaddress {}

# explore: salesforce_emailservicesaddress_attributes {
#   join: salesforce_emailservicesaddress {
#     type: left_outer
#     sql_on: ${salesforce_emailservicesaddress_attributes.salesforce_emailservicesaddress_id} = ${salesforce_emailservicesaddress.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_emailservicesfunction {}

# explore: salesforce_emailservicesfunction_attributes {
#   join: salesforce_emailservicesfunction {
#     type: left_outer
#     sql_on: ${salesforce_emailservicesfunction_attributes.salesforce_emailservicesfunction_id} = ${salesforce_emailservicesfunction.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_emailtemplate {}

# explore: salesforce_emailtemplate_attributes {
#   join: salesforce_emailtemplate {
#     type: left_outer
#     sql_on: ${salesforce_emailtemplate_attributes.salesforce_emailtemplate_id} = ${salesforce_emailtemplate.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_entitysubscription {}

# explore: salesforce_entitysubscription_attributes {
#   join: salesforce_entitysubscription {
#     type: left_outer
#     sql_on: ${salesforce_entitysubscription_attributes.salesforce_entitysubscription_id} = ${salesforce_entitysubscription.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_event {}

# explore: salesforce_event_attributes {
#   join: salesforce_event {
#     type: left_outer
#     sql_on: ${salesforce_event_attributes.salesforce_event_id} = ${salesforce_event.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_eventfeed {}

# explore: salesforce_eventfeed_attributes {
#   join: salesforce_eventfeed {
#     type: left_outer
#     sql_on: ${salesforce_eventfeed_attributes.salesforce_eventfeed_id} = ${salesforce_eventfeed.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_eventrelation {}

# explore: salesforce_eventrelation_attributes {
#   join: salesforce_eventrelation {
#     type: left_outer
#     sql_on: ${salesforce_eventrelation_attributes.salesforce_eventrelation_id} = ${salesforce_eventrelation.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_feeditem {}

# explore: salesforce_feeditem_attributes {
#   join: salesforce_feeditem {
#     type: left_outer
#     sql_on: ${salesforce_feeditem_attributes.salesforce_feeditem_id} = ${salesforce_feeditem.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_filesearchactivity {}

# explore: salesforce_filesearchactivity_attributes {
#   join: salesforce_filesearchactivity {
#     type: left_outer
#     sql_on: ${salesforce_filesearchactivity_attributes.salesforce_filesearchactivity_id} = ${salesforce_filesearchactivity.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_fiscalyearsettings {}

# explore: salesforce_fiscalyearsettings_attributes {
#   join: salesforce_fiscalyearsettings {
#     type: left_outer
#     sql_on: ${salesforce_fiscalyearsettings_attributes.salesforce_fiscalyearsettings_id} = ${salesforce_fiscalyearsettings.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_folder {}

# explore: salesforce_folder_attributes {
#   join: salesforce_folder {
#     type: left_outer
#     sql_on: ${salesforce_folder_attributes.salesforce_folder_id} = ${salesforce_folder.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_group {}

# explore: salesforce_group_attributes {
#   join: salesforce_group {
#     type: left_outer
#     sql_on: ${salesforce_group_attributes.salesforce_group_id} = ${salesforce_group.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_lacton__serverinformation__c {}

# explore: salesforce_lacton__serverinformation__c_attributes {
#   join: salesforce_lacton__serverinformation__c {
#     type: left_outer
#     sql_on: ${salesforce_lacton__serverinformation__c_attributes.salesforce_lacton__serverinformation__c_id} = ${salesforce_lacton__serverinformation__c.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_lead {}

# explore: salesforce_lead_address {
#   join: salesforce_lead {
#     type: left_outer
#     sql_on: ${salesforce_lead_address.salesforce_lead_id} = ${salesforce_lead.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_lead_attributes {
#   join: salesforce_lead {
#     type: left_outer
#     sql_on: ${salesforce_lead_attributes.salesforce_lead_id} = ${salesforce_lead.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_leadfeed {}

# explore: salesforce_leadfeed_attributes {
#   join: salesforce_leadfeed {
#     type: left_outer
#     sql_on: ${salesforce_leadfeed_attributes.salesforce_leadfeed_id} = ${salesforce_leadfeed.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_note {}

# explore: salesforce_note_attributes {
#   join: salesforce_note {
#     type: left_outer
#     sql_on: ${salesforce_note_attributes.salesforce_note_id} = ${salesforce_note.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_opportunity {}

# explore: salesforce_opportunity_attributes {
#   join: salesforce_opportunity {
#     type: left_outer
#     sql_on: ${salesforce_opportunity_attributes.salesforce_opportunity_id} = ${salesforce_opportunity.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_opportunitycontactrole {}

# explore: salesforce_opportunitycontactrole_attributes {
#   join: salesforce_opportunitycontactrole {
#     type: left_outer
#     sql_on: ${salesforce_opportunitycontactrole_attributes.salesforce_opportunitycontactrole_id} = ${salesforce_opportunitycontactrole.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_opportunityhistory {}

# explore: salesforce_opportunityhistory_attributes {
#   join: salesforce_opportunityhistory {
#     type: left_outer
#     sql_on: ${salesforce_opportunityhistory_attributes.salesforce_opportunityhistory_id} = ${salesforce_opportunityhistory.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_organization {}

# explore: salesforce_organization_address {
#   join: salesforce_organization {
#     type: left_outer
#     sql_on: ${salesforce_organization_address.salesforce_organization_id} = ${salesforce_organization.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_organization_attributes {
#   join: salesforce_organization {
#     type: left_outer
#     sql_on: ${salesforce_organization_attributes.salesforce_organization_id} = ${salesforce_organization.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_period {}

# explore: salesforce_period_attributes {
#   join: salesforce_period {
#     type: left_outer
#     sql_on: ${salesforce_period_attributes.salesforce_period_id} = ${salesforce_period.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_pricebook2 {}

# explore: salesforce_pricebook2_attributes {
#   join: salesforce_pricebook2 {
#     type: left_outer
#     sql_on: ${salesforce_pricebook2_attributes.salesforce_pricebook2_id} = ${salesforce_pricebook2.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_profile {}

# explore: salesforce_profile_attributes {
#   join: salesforce_profile {
#     type: left_outer
#     sql_on: ${salesforce_profile_attributes.salesforce_profile_id} = ${salesforce_profile.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_scontrol {}

# explore: salesforce_scontrol_attributes {
#   join: salesforce_scontrol {
#     type: left_outer
#     sql_on: ${salesforce_scontrol_attributes.salesforce_scontrol_id} = ${salesforce_scontrol.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_socialpersona {}

# explore: salesforce_socialpersona_attributes {
#   join: salesforce_socialpersona {
#     type: left_outer
#     sql_on: ${salesforce_socialpersona_attributes.salesforce_socialpersona_id} = ${salesforce_socialpersona.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_staticresource {}

# explore: salesforce_staticresource_attributes {
#   join: salesforce_staticresource {
#     type: left_outer
#     sql_on: ${salesforce_staticresource_attributes.salesforce_staticresource_id} = ${salesforce_staticresource.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_task {}

# explore: salesforce_task_attributes {
#   join: salesforce_task {
#     type: left_outer
#     sql_on: ${salesforce_task_attributes.salesforce_task_id} = ${salesforce_task.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_taskfeed {}

# explore: salesforce_taskfeed_attributes {
#   join: salesforce_taskfeed {
#     type: left_outer
#     sql_on: ${salesforce_taskfeed_attributes.salesforce_taskfeed_id} = ${salesforce_taskfeed.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_taskrelation {}

# explore: salesforce_taskrelation_attributes {
#   join: salesforce_taskrelation {
#     type: left_outer
#     sql_on: ${salesforce_taskrelation_attributes.salesforce_taskrelation_id} = ${salesforce_taskrelation.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_topic {}

# explore: salesforce_topic_attributes {
#   join: salesforce_topic {
#     type: left_outer
#     sql_on: ${salesforce_topic_attributes.salesforce_topic_id} = ${salesforce_topic.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_user {}

# explore: salesforce_user_address {
#   join: salesforce_user {
#     type: left_outer
#     sql_on: ${salesforce_user_address.salesforce_user_id} = ${salesforce_user.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_user_attributes {
#   join: salesforce_user {
#     type: left_outer
#     sql_on: ${salesforce_user_attributes.salesforce_user_id} = ${salesforce_user.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_userappinfo {}

# explore: salesforce_userappinfo_attributes {
#   join: salesforce_userappinfo {
#     type: left_outer
#     sql_on: ${salesforce_userappinfo_attributes.salesforce_userappinfo_id} = ${salesforce_userappinfo.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: salesforce_weblink {}

# explore: salesforce_weblink_attributes {
#   join: salesforce_weblink {
#     type: left_outer
#     sql_on: ${salesforce_weblink_attributes.salesforce_weblink_id} = ${salesforce_weblink.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: san_diego_tourism_dcm_639114947 {}

# explore: seven_mile_casino_dcm_639114947 {}

# explore: stones_gambling_hall_dcm_639114947 {}

# explore: tahiti_tourisme_dcm_639114947 {}

# explore: tdsc_523251920 {}

# explore: tdsc_adwords_gdn_adgroup_performance_report {}

# explore: tdsc_adwords_sem_adgroup_performance_report {}

# explore: tdsc_ga {}

# explore: tdsc_ga_adwords {}

# explore: tdsc_ga_overall {}

# explore: tdsc_ga_source {
#   join: tdsc_ga {
#     type: left_outer
#     sql_on: ${tdsc_ga_source.tdsc_ga_id} = ${tdsc_ga.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: test_advertiser_dcm_639114947 {}

# explore: test_trueview_us_d365_geo_report {}

# explore: the_dentists_supply_company_dcm_636297245 {}

# explore: the_dentists_supply_company_dcm_639114947 {}

# explore: ttus_leads {}

# explore: ttus_leads_eventaction {
#   join: ttus_leads {
#     type: left_outer
#     sql_on: ${ttus_leads_eventaction.ttus_leads_id} = ${ttus_leads.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: vca_air_canada_foundational_gdn_adgroup_performance_report {}

# explore: vca_aus_foundational_gdn_adgroup_performance_report {}

# explore: vca_aus_foundational_sem_adgroup_performance_report {}

# explore: vca_aus_foundational_semadgroup_performance_report {}

# explore: vca_bra_foundational_sem_adgroup_performance_report {}

# explore: vca_can_crisisrecovery_gdn_adgroup_performance_report {}

# explore: vca_can_foundational_gdn_adgroup_performance_report {}

# explore: vca_can_foundational_sem_adgroup_performance_report {}

# explore: vca_foundational_sem_gdn {}

# explore: vca_foundational_sem_gdn_backup {}

# explore: vca_foundational_sem_gdn_view {}

# explore: vca_fra_foundational_sem_adgroup_performance_report {}

# explore: vca_ga {}

# explore: vca_ga_adwords {}

# explore: vca_ga_adwords_jj {}

# explore: vca_ga_adwords_view {}

# explore: vca_ger_foudnational_sem_adgroup_performance_report {}

# explore: vca_ind_foudnational_sem_adgroup_performance_report {}

# explore: vca_japan_foundational_gdn_adgroup_performance_report {}

# explore: vca_jpn_foundational_gdn_adgroup_performance_report {}

# explore: vca_jpn_foundational_sem_adgroup_performance_report {}

# explore: vca_mex_foundational_gdn_adgroup_performance_report {}

# explore: vca_mex_foundational_sem_adgroup_performance_report {}

# explore: vca_mex_kidifornia_gdn_adgroup_performance_report {}

# explore: vca_skor_foudnational_sem_adgroup_performance_report {}

# explore: vca_skor_foundational_gdn_adgroup_performance_report {}

# explore: vca_skor_foundational_sem_adgroup_performance_report {}

# explore: vca_south_korea_foundational_gdn_adgroup_performance_report {}

# explore: vca_uk_foundational_gdn_adgroup_performance_report {}

# explore: vca_uk_foundational_sem_adgroup_performance_report {}

# explore: vca_us_crisisrecovery_gdn_adgroup_performance_report {}

# explore: vca_us_foundational_gdn_adgroup_performance_report {}

# explore: vca_us_foundational_sem_adgroup_performance_report {}

# explore: vendors {}

# explore: visit_california_dcm_639114947 {}

# explore: visit_napa_valley_dcm_639114947 {}

# explore: vnv_sem_gdn {}
