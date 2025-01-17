# Google Ads configuration for Marketing Analytics by Looker

# TODO: Update Google Ads schema
datagroup: adwords_etl_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `@{ADWORDS_SCHEMA_NAME}.account_hourly_stats` ;;
  max_cache_age: "24 hours"
}

view: adwords_config {
  extension: required

  # TODO: Update Google Ads schema
  dimension: adwords_schema {
    hidden: yes
    sql:@{ADWORDS_SCHEMA_NAME};;
  }
}

view: ad_config {
  extends: [ad_adapter]
  extension: required
  # Customize: Add ad fields
}

view: keyword_config {
  extends: [keyword_adapter]
  extension: required
  # Customize: Add keyword fields
}

view: ad_group_config {
  extends: [ad_group_adapter]
  extension: required
  # Customize: Add ad group fields
}

view: campaign_config {
  extends: [campaign_adapter]
  extension: required
  # Customize: Add campaign fields
}

view: customer_config {
  extends: [customer_adapter]
  extension: required
  # Customize: Add customer fields
}

view: google_ad_metrics_base_config {
  extends: [google_ad_metrics_base_template]
  extension: required
  # Customize: Add metrics or customize drills / labels / descriptions
}

# Daily Account Aggregation
explore: ad_impressions_config {
  extends: [ad_impressions_template]
  hidden: yes #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

view: ad_impressions_config {
  extends: [ad_impressions_template]
  extension: required
}

# Hourly Account Aggregation
explore: ad_impressions_daily_config {
  extends: [ad_impressions_daily_template]
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

  view: ad_impressions_daily_config {
  extends: [ad_impressions_daily_template]
    extension: required
}

# Daily Campaign Aggregation
explore: ad_impressions_campaign_config {
  extends: [ad_impressions_campaign_template]
  extension: required
  group_label: "Marketing Analytics"
  hidden: no
}

view: ad_impressions_campaign_config {
  extends: [ad_impressions_campaign_template]
  extension: required
}

explore: ad_impressions_campaign_daily_config {
  extends: [ad_impressions_campaign_daily_template]
  extension: required
  hidden: yes #TODO change hidden:yes to hidden:no if you want to expose this Explore
}

view: ad_impressions_campaign_daily_config {
  extends: [ad_impressions_campaign_daily_template]
  extension: required
}

# Daily Ad Group Aggregation
explore: ad_impressions_ad_group_config {
  extends: [ad_impressions_ad_group_template]
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

view: ad_impressions_ad_group_config {
  extends: [ad_impressions_ad_group_template]
  extension: required
}

# Hourly Ad Group Aggregation
explore: ad_impressions_ad_group_hour_config {
  extends: [ad_impressions_ad_group_hour_template]
  extension: required
  hidden: yes #TODO change hidden:yes to hidden:no if you want to expose this Explore
}

view: ad_impressions_ad_group_hour_config {
  extends: [ad_impressions_ad_group_hour_template]
  extension: required
}

# Daily Keyword Aggregation
explore: ad_impressions_keyword_config {
  extends: [ad_impressions_keyword_template]
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

view: ad_impressions_keyword_config {
  extends: [ad_impressions_keyword_template]
  extension: required
}

# Daily Ad Aggregation
explore: ad_impressions_ad_config {
  group_label: "Marketing Analytics"
  hidden: no   
  extends: [ad_impressions_ad_template]
  extension: required
}

view: ad_impressions_ad_config {
  extends: [ad_impressions_ad_template]
  extension: required
}

# Daily Geo Aggregation
explore: ad_impressions_geo_config {
  extends: [ad_impressions_geo_template]
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

view: ad_impressions_geo_config {
  extends: [ad_impressions_geo_template]
  extension: required
}

# Daily Age Range Aggregation
explore: ad_impressions_age_range_config {
  extends: [ad_impressions_age_range_template]
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

view: ad_impressions_age_range_config {
  extends: [ad_impressions_age_range_template]
  extension: required
}

# Daily Gender Aggregation
explore: ad_impressions_gender_config {
  extends: [ad_impressions_gender_template]
  extension: required
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
}

view: ad_impressions_gender_config {
  extends: [ad_impressions_gender_template]
  extension: required
}

# Daily Audience Aggregation
explore: ad_impressions_audience_config {
  extends: [ad_impressions_audience_template]
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

view: ad_impressions_audience_config {
  extends: [ad_impressions_audience_template]
  extension: required
}

# Daily Parental Status Aggregation
explore: ad_impressions_parental_status_config {
  extends: [ad_impressions_parental_status_template]
  extension: required
  hidden: yes  #TODO change hidden:yes to hidden:no if you want to expose this Explore
}

view: ad_impressions_parental_status_config {
  extends: [ad_impressions_parental_status_template]
  extension: required
}

# Daily Video Aggregation
explore: ad_impressions_video_config {
  extends: [ad_impressions_video_template]
  hidden: yes     #TODO change hidden:yes to hidden:no if you want to expose this Explore
  extension: required
}

view: ad_impressions_video_config {
  extends: [ad_impressions_video_template]
  extension: required
}

explore: adwords_period_comparison_config {
  extends: [period_fact]
  hidden: no     
  group_label: "Marketing Analytics" 
  extension: required
}

view: adwords_period_comparison_config {
  extends: [period_fact]
  extension: required
}
