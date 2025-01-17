connection: "snowflake_prod"

# ################################################ Start of DEV Explores #############################################

# ###### new explore testing#########
# explore: event_analysis {
#   label: "Event Analysis"
#   extends: [all_events_dev, learner_profile]
#   from: all_events
#   view_name: all_events

#   join: learner_profile {
#     from: learner_profile_dev
#     sql_on: ${all_events.user_sso_guid} = ${learner_profile.user_sso_guid} ;;
#     relationship: many_to_one
#   }

#   join: ipm_campaign {
#     sql_on: ${ipm_campaign.message_id} = ${all_events.campaign_msg_id};;
#     relationship: one_to_many
#   }

#   join: all_sessions {
#     from: all_sessions_dev
#     sql_on: ${all_events.session_id} = ${all_sessions.session_id} ;;
#     relationship: many_to_one
#   }

#   join: all_weeks_cu_value {
#     sql_on: ${all_sessions.user_sso_guid} = ${all_weeks_cu_value.user_sso_guid} ;;
#     relationship: many_to_many
#   }

#   join: all_weeks_cu_value_sankey {
#     sql_on: ${all_sessions.user_sso_guid} = ${all_weeks_cu_value_sankey.user_sso_guid} ;;
#     relationship: many_to_one
#   }

#   join: all_sessions_cu_value {
#     sql_on: ${all_sessions.session_id} = ${all_sessions_cu_value.session_id} ;;
#     relationship: one_to_one
#   }

#   join: ip_locations {
#     sql_on: ${all_sessions.ips} = ${ip_locations.ip_address} ;;
#     relationship: one_to_one
#   }
# }

# explore: all_events_dev {
#   label: "testing Dev"
#   required_access_grants: [can_view_CU_dev_data]
#   view_name: all_events
#   extends: [all_events]
#   from: all_events_dev

# #   join: all_events_diff {
# #     from:  all_events_diff_dev
# #   }

#   join: all_events_diff {
#     from: all_events_diff_dev
#     view_label: "Event Category Analysis"
#     sql_on: ${all_events.event_id} = ${all_events_diff.event_id} ;;
#     relationship: many_to_one
#     type: inner
#   }

# #   join: student_subscription_status {
# #     from: student_subscription_status_dev
# #   }

#   join: student_subscription_status {
#     from: student_subscription_status_dev
#     sql_on: ${all_events.user_sso_guid} = ${student_subscription_status.user_sso_guid} ;;
#     relationship: many_to_one
#   }
# }


# explore: session_analysis_dev {
#   label: "CU User Analysis Dev"
#   from: learner_profile_dev
#   view_name: learner_profile
# #   extends: [session_analysis, all_events_dev, dim_course, learner_profile]
#   required_access_grants: [can_view_CU_dev_data]
#   extends: [session_analysis]

#   join: all_sessions {
#     from: all_sessions_dev
# #     sql_on: a = b ;;
#   }

#   join: guid_cohort {
#     view_label: "Learner Cohort Analysis"
#   }

#   join: full_access_cohort {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${full_access_cohort.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: TrialAccess_cohorts {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${TrialAccess_cohorts.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: subscription_term_cost {
#     view_label: "Institution"
#     sql_on: ${learner_profile.user_sso_guid} = ${subscription_term_cost.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: subscription_term_products_value {
#     view_label: "Institution"
#     sql_on: ${learner_profile.user_sso_guid} = ${subscription_term_products_value.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: subscription_term_savings {
#     view_label: "Institution"
#     sql_on: ${learner_profile.user_sso_guid} = ${subscription_term_savings.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: subscription_term_careercenter_clicks {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${subscription_term_careercenter_clicks.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

# #   join: cohorts_base {type: cross relationship: one_to_one}
# #   join: cohorts_base_institution {type: cross relationship: one_to_one}

#   join: cohorts_chegg_clicked {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_chegg_clicked.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_kaplan_clicked {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_kaplan_clicked.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_quizlet_clicked {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_quizlet_clicked.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_evernote_clicked {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_evernote_clicked.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_print_clicked {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_print_clicked.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_courseware_dashboard {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_courseware_dashboard.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_testprep_dashboard {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_testprep_dashboard.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_studyguide_dashboard {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_studyguide_dashboard.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_flashcards_dashboard {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_flashcards_dashboard.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_subscription_term_savings_user {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_subscription_term_savings_user.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: subscription_term_courseware_value_users {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${subscription_term_courseware_value_users.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_term_courses {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_term_courses.user_sso_guid} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_time_in_platform {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_time_in_platform.user_sso_guid} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_number_of_logins {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_number_of_logins.user_sso_guid_merged} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_number_of_ebooks_added_dash {
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_number_of_ebooks_added_dash.user_sso_guid} ;;
#     relationship:  one_to_many
#   }

#   join: cohorts_number_of_courseware_added_to_dash{
#     view_label: "Learner Profile"
#     sql_on: ${learner_profile.user_sso_guid} = ${cohorts_number_of_courseware_added_to_dash.user_sso_guid} ;;
#     relationship:  one_to_many
#   }


#   join: all_events {
#     from: all_events_dev
#   }

#   join: user_courses {
#     from: user_courses_dev
#   }

#   join: dim_course {
#     sql_on: ${all_sessions.course_keys}[0] = ${dim_course.olr_course_key} ;;
#     relationship: many_to_many
#   }

#   join: sessions_analysis_week {
#     sql_on: ${all_sessions.user_sso_guid} = ${sessions_analysis_week.user_sso_guid} ;;
#     relationship: many_to_one
#   }

#   join: products_v {
#     view_label: "Product Added to Dashboard - info"
#     sql_on: ${all_events.iac_isbn} = ${products_v.isbn13} ;;
#     relationship: many_to_one
#   }

#   join: cu_ebook_rollup {
#     sql_on:  ${learner_profile.user_sso_guid} = ${cu_ebook_rollup.mapped_guid} ;;
#     relationship:  one_to_one
#   }



# #   join: sessions_analysis_week {
# #     sql_on: ${all_sessions_dev.user_sso_guid} = ${sessions_analysis_week.user_sso_guid} ;;
# #     relationship: many_to_one
# #   }

# }




# explore: activations_courses_products {
#   label: "CU Take Rate Analysis - Strategy"
#   view_label: "Course info"
#
#   join: raw_subscription_event {
#     view_label: "Subscription info"
#     sql_on: ${activations_courses_products.user_id} = ${raw_subscription_event.merged_guid};;
#     relationship: many_to_one
#   }
#
# }


#explore: courseware_activations_per_user {}


# explore: looker_output_test_1000_20190214_final {
#   view_label: "Discount info (test 1000)"
#   label: "Discount email campaign"
#   join: merged_cu_user_info {
#     relationship: one_to_one
#     sql_on: ${looker_output_test_1000_20190214_final.user_sso_guid} = ${merged_cu_user_info.user_sso_guid} ;;
#   }
#   join: discount_email_control_groups_test_2 {
#     relationship: one_to_one
#     sql_on: ${looker_output_test_1000_20190214_final.user_sso_guid} = ${discount_email_control_groups_test_2.discount_info_test_1000_user_sso_guid};;
#   }
# }
#
#
# explore: looker_1000_test_primary_20190215 {
#   label: "Discount email campaign (test 1000)"
#   join: merged_cu_user_info {
#     relationship: one_to_one
#     sql_on: ${looker_1000_test_primary_20190215.user_sso_guid} = ${merged_cu_user_info.user_sso_guid} ;;
#   }
#
#   join: discount_email_campaign_control_groups {
#     relationship: one_to_one
#     sql_on: ${looker_1000_test_primary_20190215.user_sso_guid} = ${discount_email_campaign_control_groups.looker_1000_test_primary_20190215_user_guid};;
#   }
# }


# explore: student_activities_20190226 {
#   extends: [dim_course]
#
#   join: dim_course {
#     sql_on: ${student_activities_20190226.course_key} = ${dim_course.olr_course_key} ;;
#     relationship: one_to_one
#   }
# }
#
# # ----IPM ----
#
# explore: ipm_conversion {
#
# }



# ************** TEMP SUBSCRIPTION EXPLORE ********************

# explore: subscriptions_temp {
#   label: "Temp Subscription Explore"
#   join: guid_cohort {
#     sql_on: ${subscriptions_temp.merged_guid} = ${guid_cohort.guid} ;;
#     relationship: many_to_many
#   }
# }
#
# explore: savings_cann_takes {
#   label: "Savings, Cannibalization and Take Analysis (strategy)"
#   view_label: "Savings, Cannibalization and Takes"
# }


# explore: client_activity_event {
#   label: "CU Sidebar Events DEV"
#
#   join: live_subscription_status {
#     relationship: one_to_one
#     sql_on: ${client_activity_event.merged_guid} = ${live_subscription_status.user_sso_guid} ;;
#   }
#
#   join: merged_cu_user_info {
#     relationship: one_to_one
#     sql_on: ${client_activity_event.merged_guid} = ${merged_cu_user_info.user_sso_guid} ;;
#   }
#
#   join: uploads_cu_sidebar_cohort {
#     view_label: "CU sidebar cohort"
#     sql_on: ${client_activity_event.merged_guid} = ${uploads_cu_sidebar_cohort.merged} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: client_activity_event_prod {
#   view_label: "CU side bar events"
#   label: "CU Sidebar Events Prod"
#
#   join: live_subscription_status {
#     relationship: one_to_one
#     sql_on: ${client_activity_event_prod.merged_guid} = ${live_subscription_status.user_sso_guid} ;;
#   }
#
#   join: merged_cu_user_info {
#     relationship: one_to_one
#     sql_on: ${client_activity_event_prod.merged_guid} = ${merged_cu_user_info.user_sso_guid} ;;
#   }
#
#   join: uploads_cu_sidebar_cohort {
#     view_label: "CU sidebar cohort"
#   sql_on: ${client_activity_event_prod.merged_guid} = ${uploads_cu_sidebar_cohort.merged} ;;
#   relationship: many_to_one
#   }
# }


# explore: milady_temp {
#   from: client_activity_event_prod
#   view_label: "Milday events"
#   label: "Milady events Prod"
#
#   join: live_subscription_status {
#     relationship: one_to_one
#     sql_on: ${milady_temp.merged_guid} = ${live_subscription_status.user_sso_guid} ;;
#   }
#
#   join: merged_cu_user_info {
#     relationship: one_to_one
#     sql_on: ${milady_temp.merged_guid} = ${merged_cu_user_info.user_sso_guid} ;;
#   }
#
#   join: dim_course {
#     sql_on: ${milady_temp.coursekey} = ${dim_course.coursekey} ;;
#     relationship: many_to_many
#   }
#
#   join: course_section_facts {
#     sql_on: ${dim_course.courseid} = ${course_section_facts.courseid} ;;
#     relationship: one_to_one
#   }
#
#   join: dim_institution {
#     fields: [dim_institution.CU_fields*]
#   }
#
#   join: dim_filter {
#     fields: [-dim_filter.ALL_FIELDS*]
#   }
#
#   join: dim_product {
#     sql_on: ${milady_temp.isbn} = ${dim_product.isbn13} ;;
#     relationship: many_to_one
#   }
#
#   }



#-----------sso -------------------
# explore: sso_logins {
#   from: credentials_used
#
#   join: iam_user_mutation {
#     relationship:one_to_many
#     sql_on: ${iam_user_mutation.user_sso_guid} = ${sso_logins.user_sso_guid} ;;
#   }
# }