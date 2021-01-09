connection: "upff"

# include views
include: "ios_users.view"
include: "javascript_users.view"
include: "javascript_identifies.view"
include: "android_users.view"
include: "javascript_subscribed.view"
include: "javascript_users.view"
include: "javascript_play.view"
include: "redshift_php_get_mobile_app_installs.view"
include: "ios_authentication.view"
include: "ios_subscribetapped.view"
include: "android_subscribetapped.view"
include: "ios_signup.view"
include: "android_signup.view"
include: "ios_welcomebrowse.view"
include: "android_welcomebrowse.view"
include: "ios_conversion.view"
include: "android_conversion.view"
include: "redshift_php_get_analytics.view"
include: "redshift_android_firstplay.view"
include: "redshift_pixel_api_email_opened.view"
include: "redshift_android_application_installed.view"
include: "redshift_ios_application_installed.view"
include: "redshift_php_get_trialist_survey.view"
include: "redshift_derived_personalize.view"
include: "redshift_php_send_trialist_survey.view"
include: "redshift_php_get_churn_survey.view"
include: "redshift_python_users.view"
include: "javascript_conversion.view"
include: "redshift_get_titles.view"
include: "javascript_conversion.view"
include: "redshift_php_get_user_on_email_list.view"
include: "redshift_marketing_performance.view.lkml"
include: "redshfit_marketing_installs_1.view.lkml"
include: "redshift_javascript_conversion.view.lkml"
include: "redshift_roku_firstplay.view.lkml"
include: "redshift_javascript_upff_home_pages.view.lkml"
include: "redshift_mobile_conversions.view.lkml"
include: "redshift_marketing_performance_v2.view.lkml"
include: "amazon_personalize_recommendations.view.lkml"
include: "redshift_looker_customer_conversion_scores.view.lkml"
include: "redshift_php_get_average_predicted_conversion_score.view.lkml"
include: "redshift_php_get_referral_program_info.view.lkml"
include: "redshift_php_get_email_campaigns.view.lkml"
include: "redshift_derived_mobile_app_engagement.view.lkml"
include: "redshift_derived_added_to_watch_list.view.lkml"
include: "redshift_get_email_automation_emails.view.lkml"
include: "redshift_get_email_automations.view.lkml"
include: "redshift_data_warehouse_info.view.lkml"
include: "redshift_segment_anonymous_known_users.view.lkml"

explore: redshift_segment_anonymous_known_users {
  label: "Segment Monthly Tracked Users"
}

explore: redshift_data_warehouse_info {
  label: "Redshift DW Info"
}

explore: redshift_get_email_automation_emails {
  label: "Email Automation Emails"
}

explore: redshift_get_email_automations {
  label: "Email Automations"
}

explore: redshift_derived_added_to_watch_list{
  label: "Add Watch List"
}

explore: redshift_derived_mobile_app_engagement {
  label: "Mobile App Engagement"
}

explore: redshift_php_get_email_campaigns {
  label: "Email Campaigns"
}

explore: redshift_looker_customer_conversion_scores {
  join: redshift_php_get_average_predicted_conversion_score {
    type: left_outer
    sql_on:  ${redshift_looker_customer_conversion_scores.received_date} = ${redshift_php_get_average_predicted_conversion_score.received_date_date};;
    relationship: many_to_one
  }
}

explore: amazon_personalize_recommendations {}

explore: redshift_marketing_performance_v2 {}

explore: redshift_roku_firstplay {

}

explore: redshift_marketing_performance {
  join: redshift_javascript_conversion {
    type: left_outer
    sql_on: ${redshift_javascript_conversion.ad_id}=${redshift_marketing_performance.ad_id} and ${redshift_javascript_conversion.timestamp_date}=${redshift_marketing_performance.timestamp_date};;
    relationship: many_to_one
  }
  join: redshfit_marketing_installs_1 {
    type: left_outer
    sql_on: ${redshfit_marketing_installs_1.ad_id}=${redshift_marketing_performance.ad_id} and ${redshift_marketing_performance.timestamp_date}=${redshfit_marketing_installs_1.timestamp_date};;
    relationship: many_to_one
  }
  join: redshift_mobile_conversions {
    type: left_outer
    sql_on: upper(${redshfit_marketing_installs_1.anonymous_id})=upper(${redshift_mobile_conversions.anonymous_id});;
    relationship: many_to_one
  }
}

datagroup: upff_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "6 hour"
}

persist_with: upff_default_datagroup

explore: ios_users {
  label: "Web and iOS App Users"
  join: javascript_users {
    type:  left_outer
    sql_on: ${javascript_users.id} = ${ios_users.id} ;;
    relationship: one_to_one
  }

  join: javascript_identifies {
    type:  inner
    sql_on: ${ios_users.id} = ${javascript_identifies.user_id} ;;
    relationship: one_to_one
  }

}

explore: android_users {
  label: "Web and Android App Users"
  join: javascript_users {
    type:  inner
    sql_on: ${javascript_users.id} = ${android_users.id} ;;
    relationship: one_to_one
  }

  join: javascript_identifies {
    type:  inner
    sql_on: ${android_users.id} = ${javascript_identifies.user_id} ;;
    relationship: one_to_one
  }

}

explore: web_to_ios{
  label: "Web to iOS Subscribers"
  from: subscribed

  join: javascript_users {
    sql_on: ${javascript_users.id} = ${web_to_ios.user_id};;
    relationship: one_to_one
  }


  join: ios_users {
    type: inner
    sql_on: ${javascript_users.id} = ${ios_users.id} ;;
    required_joins: [javascript_users]
    relationship: one_to_one
  }
}

explore: web_to_android{
  label: "Web to Android Subscribers"
  from: subscribed

  join: javascript_users {
    sql_on: ${javascript_users.id} = ${web_to_android.user_id};;
    relationship: one_to_one
  }

  join: android_users {
    type: inner
    sql_on: ${javascript_users.id} = ${android_users.id} ;;
    relationship: one_to_one
  }

}

# Web Suscribers
explore: javascript_subscribed {

  label: "Web Subscribers"
  from: subscribed

  join: javascript_users {
    type:  inner
    sql_on: ${javascript_subscribed.user_id} = ${javascript_users.id} ;;
    relationship: one_to_one
  }

}

# Web Suscriber Plays
include: "javascript_firstplay.view"
explore: javascript_users {

  label: "Web Subscriber Plays"

  join: javascript_play {
    type:  inner
    sql_on: ${javascript_users.id} = ${javascript_play.user_id} ;;
    relationship: one_to_one
  }


  join: javascript_firstplay {
    type:  inner
    sql_on: ${javascript_users.id} = ${javascript_firstplay.user_id} ;;
    relationship: one_to_one
  }

  join: javascript_conversion {
    type:  inner
    sql_on: ${javascript_users.id} = ${javascript_conversion.user_id};;
    relationship: one_to_one
  }

}

include: "javascript_uptv_pages.view"
explore: javascript_uptv_pages {
  label: "Cross-Domain Subs"
  join: subscribed {
    type:  left_outer
    sql_on: ${javascript_uptv_pages.context_traits_cross_domain_id} = ${subscribed.context_traits_cross_domain_id} ;;
    relationship: one_to_one
  }

  join: javascript_users {
    type:  left_outer
    sql_on: ${javascript_uptv_pages.context_traits_cross_domain_id} = ${javascript_users.context_traits_cross_domain_id} ;;
    relationship: one_to_one
  }

  join: javascript_play {
    type: left_outer
    sql_on: ${javascript_uptv_pages.context_traits_cross_domain_id} = ${javascript_play.context_traits_cross_domain_id};;
    relationship: one_to_one
  }
}

include: "analytics.view"
explore: analytics{}

include: "php_get_customers.view"
explore: php_get_customers{
  label: "Mktg Opt-In Subscribers"
  description: "Marketing Opt-In Subs"
  join: analytics {
    type: inner
    sql_on: ${analytics.timestamp_date} = ${php_get_customers.created_date};;
    relationship: one_to_one
  }
}

include: "customers.view"
include: "all_firstplay.view"
include: "delighted_survey_question_answered.view"
include: "mailchimp_email_campaigns.view"
include: "customers_customers.view"
explore: customers{

  join: javascript_users {
    type:  left_outer
    sql_on: ${customers.customer_id} = ${javascript_users.id};;
    relationship: one_to_one
  }

  join: android_users {
    type:  left_outer
    sql_on: ${customers.customer_id} = ${android_users.id};;
    relationship: one_to_one
  }

  join: ios_users {
    type:  left_outer
    sql_on: ${customers.customer_id} = ${ios_users.id};;
    relationship: one_to_one
  }

  join: http_api_purchase_event {
    type: left_outer
    sql_on: ${customers.customer_id} = ${http_api_purchase_event.user_id};;
    relationship: one_to_one
  }

  join: redshift_pixel_api_email_opened {
    type: left_outer
    sql_on: ${customers.customer_id} = ${redshift_pixel_api_email_opened.user_id};;
    relationship: one_to_one
  }

  join: all_firstplay {
    type: left_outer
    sql_on:  ${customers.customer_id} = ${all_firstplay.user_id} ;;
    relationship: one_to_many
  }

  join: delighted_survey_question_answered {
    type: left_outer
    sql_on: ${customers.customer_id} = ${delighted_survey_question_answered.user_id};;
    relationship: one_to_many
  }

  join: mailchimp_email_campaigns {
    type:  inner
    sql_on: ${mailchimp_email_campaigns.campaign_date} = ${delighted_survey_question_answered.timestamp_date};;
    relationship: one_to_one
  }

  join: customers_v2 {
    type: inner
    sql_on: ${delighted_survey_question_answered.user_id} = ${customers_v2.customer_id};;
    relationship: one_to_one
  }

}

include: "javascript_subscribed.view"
include: "http_api_purchase_event.view"
include: "customers_info_facts.view"
explore: subscribed {}
explore: http_api_purchase_event
{
  label: "Subscribers"

  join: redshift_php_get_referral_program_info {
    type: inner
    sql_on: ${http_api_purchase_event.user_id} = ${redshift_php_get_referral_program_info.user_id};;
    relationship: one_to_one
  }


  join: redshift_php_send_trialist_survey {
    type: left_outer
    sql_on: ${http_api_purchase_event.user_id} = ${redshift_php_send_trialist_survey.user_id};;
    relationship: one_to_one
  }

  join: redshift_php_get_trialist_survey{
    type: left_outer
    sql_on: ${http_api_purchase_event.user_id} = ${redshift_php_get_trialist_survey.user_id};;
    relationship: one_to_one
  }

  join: redshift_php_get_churn_survey {
    type: left_outer
    sql_on: ${http_api_purchase_event.user_id} = ${redshift_php_get_churn_survey.user_id};;
    relationship: one_to_one
  }

  join: redshift_pixel_api_email_opened{
    type: left_outer
    sql_on: ${http_api_purchase_event.user_id} = ${redshift_pixel_api_email_opened.user_id};;
    relationship: many_to_many
  }

  join: delighted_survey_question_answered {
    type: left_outer
    view_label: "Delighted: No Surveyed"
    sql_on: ${delighted_survey_question_answered.user_id} != ${http_api_purchase_event.user_id};;
    relationship: one_to_one
  }

  join: android_users {
    type: left_outer
    sql_on: ${http_api_purchase_event.user_id} = ${android_users.id};;
    relationship: one_to_one
  }

  join: android_conversion {
    type: left_outer
    sql_on: ${android_users.context_traits_anonymous_id} = ${android_conversion.anonymous_id};;
    relationship: one_to_one
  }

  join: redshift_php_get_mobile_app_installs {
    type: left_outer
    sql_on: ${redshift_php_get_mobile_app_installs.anonymous_id} = ${android_conversion.anonymous_id};;
    relationship: one_to_one
  }

  join: redshift_php_get_user_on_email_list {
    type: left_outer
    sql_on: ${http_api_purchase_event.email} = ${redshift_php_get_user_on_email_list.email};;
    relationship: one_to_one
  }

}
explore: customers_info_facts{}

include: "analytics_v2.view"
#Delighted.com // Feedback Survey Responses
explore: delighted_survey_question_answered {
  label: "Delighted Feedback"

  join: http_api_purchase_event {
    type: left_outer
    sql_on: ${delighted_survey_question_answered.user_id} = ${http_api_purchase_event.user_id};;
    relationship: one_to_one
  }

  join: redshift_pixel_api_email_opened {
    type: left_outer
    sql_on: ${delighted_survey_question_answered.user_id} = ${redshift_pixel_api_email_opened.user_id};;
    relationship: one_to_one
  }


  join: analytics_v2 {
    type:  left_outer
    sql_on: ${http_api_purchase_event.created_date} = ${analytics_v2.timestamp_date};;
    relationship: many_to_one
  }

  join: mailchimp_email_campaigns {
    type:  inner
    sql_on: ${mailchimp_email_campaigns.campaign_date} = ${delighted_survey_question_answered.timestamp_date};;
    relationship: one_to_one
  }


}

include: "ios_firstplay.view"
#iOS // get user plays
explore: ios_users_firstplay {
  label: "iOS Subscribers Play"
  from:  ios_users

  join: ios_firstplay {
    type: inner
    sql_on: ${ios_users_firstplay.id} = ${ios_firstplay.user_id};;
    relationship: one_to_one
  }
}

include: "android_users.view"
include: "android_play.view"
#Android // get user plays
explore: android_users_play {
  label: "Android Subscribers Play"
  from:  android_users

  join: android_play {
    type: inner
    sql_on: ${android_users_play.id} = ${android_play.user_id};;
    relationship: one_to_one
  }
}

include: "javascript_pages.view"
include: "ios_view.view"
include: "android_view.view"
include: "android_signin.view"
include: "ios_signin.view"
include: "signupstarted.view"
include: "customers_social_ads.view"
include: "ios_signupstarted.view"

explore: javascript_pages {label: "Web Pages Views"}
explore: ios_view {label: "iOS Views"}
explore: android_view {label: "Android Views"}
explore: android_signin {label: "Android Sign-in"}
explore: ios_signin { label: "iOS Sign-in"}
explore: android_signupstarted {
  label: "Android Signupstarted"

  join: customers_social_ads {
    type: inner
    sql_on: ${android_signupstarted.context_device_advertising_id} = ${customers_social_ads.user_data_aaid};;
    relationship: one_to_one
  }

  join: android_users {
    type: inner
    sql_on: ${android_signupstarted.context_traits_user_id} = ${android_users.id};;
    relationship: one_to_one
  }
}
explore: ios_signupstarted {
  label: "iOS Signupstarted"

  join: customers_social_ads {
    type: inner
    sql_on: ${ios_signupstarted.context_device_advertising_id} = ${customers_social_ads.user_data_idfa};;
    relationship: one_to_one
  }

  join: ios_users {
    type: inner
    sql_on: ${ios_signupstarted.user_id} = ${ios_users.id};;
    relationship: one_to_one
  }

}

include: "javascript_timeupdate.view"
include: "ios_timeupdate.view"
include: "android_timeupdate.view"
include: "javascript_authentication.view"
include: "javascript_derived_timeupdate.view"
include: "derived_marketing_attribution.view"
include: "ios_branch_install.view"
include: "ios_branch_open.view"
include: "ios_branch_reinstall.view"
include: "ios_identifies.view"
include: "android_branch_install.view"
include: "android_branch_reinstall.view"
include: "derived_subscriber_platform_total.view"

explore: javascript_timeupdate {label: "Web Timeupdate"}
explore: ios_timeupdate {label: "iOS Timeupdate"}
explore: android_timeupdate {}
explore: javascript_authentication {label: "Web Authentication"}
explore: javascript_derived_timeupdate {}
explore: derived_marketing_attribution {label: "Attribution: Cross Platform"}
explore: ios_branch_install {label: "iOS Branch Install"}
explore: ios_branch_open {label: "iOS Branch Open"}
explore: ios_branch_reinstall {label: "iOS Branch Re-Install"}
explore: ios_identifies {label: "iOS Identifies"}
explore: android_branch_install {label: "Android Branch Install"}
explore: android_branch_reinstall {label: "Android Branch Re-Install"}
explore: derived_subscriber_platform_total {label: "Subscriber Platform Total"}
explore: customers_social_ads {

  label: "Marketing Attribution"
  join: ios_signupstarted {
    type: inner
    sql_on: ${customers_social_ads.user_data_idfa} = ${ios_signupstarted.context_device_advertising_id};;
    relationship: one_to_one
  }
}

explore: redshift_php_get_mobile_app_installs {

  label: "Mobile Attribution"
  join: ios_conversion {
    type: left_outer
    sql_on: ${redshift_php_get_mobile_app_installs.anonymous_id} = ${ios_conversion.anonymous_id};;
    relationship: one_to_one
  }

  join: android_conversion {
    type: left_outer
    sql_on: ${redshift_php_get_mobile_app_installs.anonymous_id} = ${android_conversion.anonymous_id};;
    relationship: one_to_one
  }

  join: android_users {
    type: inner
    sql_on: ${android_conversion.anonymous_id} = ${android_users.context_traits_anonymous_id};;
    relationship: one_to_one
  }

  join: ios_users {
    type: inner
    sql_on: ${ios_conversion.context_ip} = ${ios_users.context_ip};;
    relationship: one_to_one
  }

  join: ios_signin {
    type: inner
    sql_on: ${ios_conversion.anonymous_id} = ${ios_signin.anonymous_id};;
    relationship: one_to_one
  }

  join: authentication {
    type: inner
    sql_on: ${ios_conversion.anonymous_id} = ${authentication.anonymous_id};;
    relationship: one_to_one
  }

}

explore: redshift_python_users {

  join: http_api_purchase_event {
    type: left_outer
    sql_on:  ${http_api_purchase_event.user_id} = ${redshift_python_users.id} ;;
    relationship: one_to_one
  }

  join: redshift_get_titles {
    type: left_outer
    sql_on:  ${redshift_python_users.recommended_title_one} = ${redshift_get_titles.video_id};;
    relationship: one_to_one
  }

}


explore: javascript_conversion {}

explore: redshift_android_firstplay {}
explore: redshift_derived_personalize {
  label: "Amazon Personalize Dataset"
}
