connection: "upff"

# include all the views
# include views
include: "ios_users.view"
include: "javascript_users.view"
include: "javascript_identifies.view"
include: "android_users.view"
include: "javascript_subscribed.view"
include: "javascript_users.view"
include: "javascript_play.view"
include: "titles_id_mapping.view"
include: "daily_spend.view"
include: "app_installers.view.lkml"
include: "timeupdate.view.lkml"
include: "daily_cpa.view.lkml"
include: "mtd_free_trials.view.lkml"
include: "daily_spend_v2.view"
include: "mvpds.view.lkml"
include: "redshift_pixel_api_email_opened.view.lkml"
include: "redshift_php_get_churn_survey.view.lkml"
include: "redshift_php_get_trialist_survey.view.lkml"
include: "redshift_facebook_ads.view.lkml"
include: "redshift_facebook_campaigns.view.lkml"
include: "redshift_facebook_insights.view.lkml"
include: "redshift_google_campaign_performance_reports.view.lkml"
include: "redshift_google_campaigns.view.lkml"
include: "redshift_google_ad_performance_reports.view.lkml"
include: "redshift_google_ads.view.lkml"
include: "redshift_google_ad_groups.view.lkml"
include: "redshift_marketing_installs.view.lkml"
include: "redshift_ribbow_agency_fee.view.lkml"

explore: redshift_ribbow_agency_fee {}

explore: redshift_marketing_installs {}

explore: redshift_facebook_insights {
  join: redshift_facebook_ads {
    type: inner
    sql_on: ${redshift_facebook_insights.ad_id}=${redshift_facebook_ads.id} ;;
    relationship: many_to_one
  }
  join: redshift_facebook_campaigns {
    type: inner
    sql_on: ${redshift_facebook_ads.campaign_id}=${redshift_facebook_campaigns.id} ;;
    relationship: many_to_one
  }
}

explore: redshift_google_campaign_performance_reports {
  join: redshift_google_campaigns {
    type: inner
    sql_on: ${redshift_google_campaign_performance_reports.campaign_id}=${redshift_google_campaigns.id} ;;
    relationship: many_to_one
  }
}

explore: redshift_google_ad_performance_reports {
  join: redshift_google_ads {
    type: inner
    sql_on: ${redshift_google_ad_performance_reports.ad_id}=${redshift_google_ads.id} ;;
    relationship: many_to_one
  }
  join: redshift_google_ad_groups {
    type: inner
    sql_on: ${redshift_google_ad_groups.id}=${redshift_google_ads.ad_group_id} ;;
    relationship: one_to_one
  }
  join: redshift_google_campaigns {
    type: inner
    sql_on: ${redshift_google_ad_groups.campaign_id}=${redshift_google_campaigns.id} ;;
    relationship: one_to_one
  }
}

explore: redshift_php_get_churn_survey {
  join: http_api_purchase_event {
    type: left_outer
    sql_on: ${http_api_purchase_event.user_id}=${redshift_php_get_churn_survey.user_id} ;;
    relationship: one_to_many
}}
explore: redshift_php_get_trialist_survey {
  join: http_api_purchase_event {
    type: left_outer
    sql_on: ${http_api_purchase_event.user_id}=${redshift_php_get_trialist_survey.user_id} ;;
    relationship: one_to_many
  }
}

explore: mvpds {}
explore: daily_spend_v2 {}

explore: mtd_free_trials{}

explore: daily_cpa {}


datagroup: upff_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "6 hour"
}

persist_with: upff_default_datagroup

include: "ios_application_installed.view"
include: "ios_signupstarted.view"

explore: timeupdate {}

explore: daily_spend {}

explore: application_installed{
  join: ios_signupstarted {
    type:  left_outer
    sql_on: ${application_installed.anonymous_id} = ${ios_signupstarted.anonymous_id} ;;
    relationship: one_to_one
  }
}

include: "analytics.view"
explore: analytics{}
explore: analytics_v2 {

  join: customers_v2{
    type:  inner
    sql_on: ${analytics_v2.timestamp_date} = ${customers_v2.creation_timestamp_date};;
    relationship: one_to_many
  }

  join: all_firstplay {
    type:  inner
    sql_on: ${all_firstplay.timestamp_date} = ${analytics_v2.timestamp_date};;
    relationship: one_to_one
  }

  join: mailchimp_email_campaigns {
    type:  inner
    sql_on: ${mailchimp_email_campaigns.campaign_date} = ${analytics_v2.timestamp_date};;
    relationship: one_to_one
  }

  join: daily_spend_v2 {
    type: inner
    sql_on: ${analytics_v2.timestamp_date}=${daily_spend_v2.timestamp_date} ;;
    relationship: one_to_one}

}

include: "javascript_subscribed.view"
explore: subscribed {}

include: "customers.view"
include: "customers_analytics.view"
explore: customers {

  join: customers_analytics {
    type:  inner
    sql_on: ${customers.customer_created_at} = ${customers_analytics.timestamp_date};;
    relationship: many_to_one
  }

  join: android_users {
    type:  inner
    sql_on: ${customers.customer_id} = ${android_users.id};;
    relationship: one_to_one
  }

  join: ios_users {
    type:  inner
    sql_on: ${customers.customer_id} = ${ios_users.id};;
    relationship: one_to_one
  }

  join: all_play {
    type:  inner
    sql_on: ${all_play.user_id} = ${customers.customer_id};;
    relationship: one_to_one
  }

}

explore: customers_v2 {
  label: "Subscribers"

  join: analytics_v2 {
    type:  inner
    sql_on: ${customers_v2.event_created_at} = ${analytics_v2.timestamp_date};;
    relationship: many_to_one
  }

  join: all_firstplay {
    type:  inner
    sql_on: ${all_firstplay.user_id} = ${customers_v2.customer_id};;
    relationship: one_to_one
  }

  join: all_play {
    type:  inner
    sql_on: ${all_play.user_id} = ${customers_v2.customer_id};;
    relationship: one_to_one
  }

  join: mailchimp_email_campaigns {
    type:  inner
    sql_on: ${mailchimp_email_campaigns.userid} = ${customers_v2.customer_id};;
    relationship: one_to_one
  }

}

include: "customers_churn_reasons_aggregated.view"
include: "customers_churn_custom_reasons.view"
include: "afinn_lexicon.view"
include: "http_api_purchase_event.view"
include: "http_api_users.view"
include: "heartlandia.view"
include: "Viewership.view"
include: "ads_compare.view"
include: "Lifetime_Value.view"
include: "churn_texts.view"
include: "LTV_CPA.view"
include: "customer_churn_percent.view"
include: "android_play.view"
include:  "ios_play.view"

explore: churn_reasons_aggregated {}
explore: churn_custom_reasons {}
explore: afinn_lexicon {}
explore: http_api_purchase_event {}
explore: http_api_users {}
explore: ios_identifies {}
explore: heartlandia {}
explore: viewership {}
explore: ads_compare {}
explore: lifetime_value {}
explore: churn_texts {}
explore: ltv_cpa {}
explore: customer_churn_percent {}
explore: android_play {}
explore: ios_play {}
explore: javascript_play {}
explore: all_play {

  join: analytics {
    type:  inner
    sql_on: ${analytics.timestamp_date} = ${all_play.timestamp_date} ;;
    relationship: one_to_one
  }

}

include: "all_firstplay.view"
include: "customers_customers.view"
include: "analytics_v2.view"
include: "mailchimp_email_campaigns.view"
include: "delighted_survey_question_answered.view"
explore: all_firstplay {

  join: http_api_purchase_event {
    type: left_outer
    sql_on: ${all_firstplay.user_id} = ${http_api_purchase_event.user_id};;
    relationship: one_to_one
  }

  join: redshift_pixel_api_email_opened {
    type: left_outer
    sql_on: ${all_firstplay.user_id} = ${redshift_pixel_api_email_opened.user_id};;
    relationship: one_to_one
  }

  join: customers_v2 {
    type:  inner
    sql_on: ${customers_v2.customer_id} = ${all_firstplay.user_id} ;;
    relationship: one_to_many
  }

  join: analytics_v2 {
    type:  inner
    sql_on: ${customers_v2.event_created_at} = ${analytics_v2.timestamp_date};;
    relationship: many_to_one
  }

  join: mailchimp_email_campaigns {
    type: left_outer
    sql_on: ${mailchimp_email_campaigns.userid} = ${customers_v2.customer_id};;
    relationship: one_to_one
  }

  join: delighted_survey_question_answered {
    type: inner
    sql_on: ${delighted_survey_question_answered.user_id} = ${customers_v2.customer_id};;
    relationship: one_to_one
  }

}

include: "javascript_users.view"
include: "all_play.view"
# Web Suscriber Plays
explore: javascript_users {
  label: "Web Subscriber Video ID"

  join: javascript_play {
    type:  inner
    sql_on: ${javascript_users.id} = ${javascript_play.user_id} ;;
    relationship: one_to_one
  }

  join: all_play {
    type:  inner
    sql_on: ${all_play.user_id} = ${javascript_users.id} ;;
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
include: "mvpd_subs.view"
include: "mtd_revenue.view"
include: "upff_linear_ratings.view"
include: "uptv_daily_day_part.view"
include: "uptv_daily_key_demo.view"
include: "top_play.view"
include: "campaign_wicket_export.view"
include: "svod_titles.view"

explore: titles {}
explore: mvpd_subs {}
explore: mtd_revenue {}
explore: upff_linear_ratings {}
explore: uptv_daily_key_demo {}
explore: uptv_daily_day_part {}
explore: top_play {}
explore: campaign_wicket_export {}
