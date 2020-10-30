# include: "Fair_use.Indicator_names.view.lkml"
# #X# One of the following includes is likely needed in this file:
# # include: "Fair_use.Indicator_names.view.lkml"
# # include: "learner_profile_dev.view.lkml"
# # include: "learner_profile.view.lkml"
# #X# One of the following includes is likely needed in this file:
# # include: "Fair_use.Indicator_names.view.lkml"
# # include: "learner_profile_dev.view.lkml"
# # include: "learner_profile.view.lkml"
# #X# One of the following includes is likely needed in this file:
# # include: "Fair_use.Indicator_names.view.lkml"
# # include: "learner_profile_dev.view.lkml"
# # include: "learner_profile.view.lkml"
# #X# One of the following includes is likely needed in this file:
# # include: "Fair_use.Indicator_names.view.lkml"
# # include: "learner_profile_dev.view.lkml"
# # include: "learner_profile.view.lkml"
# #X# One of the following includes is likely needed in this file:
# # include: "Fair_use.Indicator_names.view.lkml"
# # include: "learner_profile_dev.view.lkml"
# # include: "learner_profile.view.lkml"
# #X# One of the following includes is likely needed in this file:
# # include: "Fair_use.Indicator_names.view.lkml"
# # include: "learner_profile_dev.view.lkml"
# # include: "learner_profile.view.lkml"
# #X# One of the following includes is likely needed in this file:
# # include: "Fair_use.Indicator_names.view.lkml"
#
# # include: "learner_profile_2.view.lkml"
connection: "snowflake_prod"
# # include: "/cengage_unlimited/Fair_use*.view"
# include: "/cengage_unlimited/Fair_use.Device*.view"
# include: "/cengage_unlimited/Fair_use.Ind*.view"
# include: "/cengage_unlimited/Fair_use.Tracking*.view"
# include: "/cengage_unlimited/Fair_use.unique*.view"
# # include: "/cengage_unlimited/Fair_use*.view"
# include: "/cengage_unlimited/Fair_use.Vital*.view"
# include: "/cengage_unlimited/Fair_use.course*view"
# include: "/cengage_unlimited/Fair_use.week*.view"
#
#
#
#
# include: "/cengage_unlimited/raw_fair_use_login*"
# include: "/cengage_unlimited/fair_use_deviceid2.view"
# include: "/cengage_unlimited/login*"
# include: "//core/common.lkml"
# include: "//cube/dims.lkml"
# include: "//cube/dim_course.view"
# include: "//cube/ga_mobiledata.view"
# include: "/cengage_unlimited/raw_subscription_event.view"
# # include: "/cengage_unlimited/Ebook*"
#
# include: "Fair_use.Ebook_usage_aggregated_by_week.view"
#
# #include: "/cengage_unlimited/cengage_unlimited.model.lkml"
# # include: "/cengage_unlimited/cengage_unlimited.lkml"
#
#
# ##### Fair Useage #####
# explore: ebook_usage_aggregated_by_week {}
#
# explore: coursewares_activated_week {}
# explore: coursewares_activated {}
#
# explore: device_changes {}
# explore: device_changes_all_time {}
#
# explore: unique_cities_per_user_per_week{}
# explore: unique_cities_per_user {}
# explore: weeks_above_threshhold_cities {}
# explore: fair_use_weeks_above_threshhold_devices {}
#
#
#   explore: fair_use_tracking {
#     label: "Fair Use Tracking"
#   }
#
#   explore: indicators {
#     label: "Indicators"
#
#     join: fair_use_indicators {
#       sql_on: ${indicators.indicator_id} = ${fair_use_indicators.indicator_id};;
#       relationship: one_to_many
#     }
#     join: fair_use_indicators_aggregated {
#       sql_on: ${indicators.indicator_id} = ${fair_use_indicators_aggregated.indicator_count} ;;
#       relationship: one_to_many
#     }
#   }
#
#   explore: fair_use_tracking_vitalsource {}
#
#   explore: fair_use_indicators {}
#
#   explore: fair_use_indicators_aggregated {
#     label: "Fair Use Indicators agg"}
#
#   explore: ind {
#     from: indicators
#     label: "Ind"
#
#     join: fair_use_indicators {
#       sql_on: ${ind.indicator_id} = ${fair_use_indicators.indicator_id};;
#       relationship: one_to_many
#     }}
#
#   explore:raw_fair_use_logins
#   {
#     label: "CMP Dashboard"
#     join: logins_last_30_days {
#       sql_on: ${raw_fair_use_logins.user_sso_guid} = ${logins_last_30_days.user_sso_guid} ;;
#       relationship: one_to_one
#     }
#
#     join: logins_last_7_days {
#       sql_on: ${raw_fair_use_logins.user_sso_guid} = ${logins_last_7_days.user_sso_guid} ;;
#       relationship: one_to_one
#     }
#   }
#
#   explore: fair_use_device_id {}
#   explore: fair_use_deviceid2 {}
#
# #   explore: raw_subscription_event  {}
#
# ##### End Fair Useage #####
