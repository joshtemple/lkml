# Facebook Ads configuration for Marketing Analytics by Looker


# TODO: Update Facebook Ads schema
datagroup: facebook_ads_etl_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `facebook_ads_fivetran.ads_insights` ;;
  max_cache_age: "24 hours"
}

view: facebook_ads_config {
  extension: required

  # TODO: Update Facebook Ads schema
  dimension: facebook_ads_schema {
    hidden: yes
    sql: @{FACEBOOK_ADS_SCHEMA_NAME};;
  }
}

view: fb_adcreative_config {
  extends: [adcreative_fb_adapter]
  extension: required
  # Customize: Add adcreative fields
}

view: fb_ad_config {
  extends: [ad_fb_adapter]
  extension: required
  # Customize: Add ad fields
}

view: fb_adset_config {
  extends: [adset_fb_adapter]
  extension: required
  # Customize: Add ad group fields
}

view: fb_campaign_config {
  extends: [campaign_fb_adapter]
  extension: required
  # Customize: Add campaign fields
}

view: fb_account_config {
  extends: [account_fb_adapter]
  extension: required
  # Customize: Add customer fields
}

view: fb_ad_metrics_base_config {
  extends: [fb_ad_metrics_base_template]
  extension: required
  # Customize: Add metrics or customize drills / labels / descriptions
}

# Ad Creative Aggregation
explore: fb_ad_impressions_config {
  extends: [fb_ad_impressions_template]
  extension: required
}

view: fb_ad_impressions_config {
  extends: [fb_ad_impressions_template]
  extension: required
}

# Hourly Age and Gender Aggregation
explore: fb_ad_impressions_age_and_gender_config {
  extends: [fb_ad_impressions_age_and_gender_template]
  extension: required
}

view: fb_ad_impressions_age_and_gender_config {
  extends: [fb_ad_impressions_age_and_gender_template]
  extension: required
}

# Hourly Geo Aggregation
explore: fb_ad_impressions_geo_config {
  extends: [fb_ad_impressions_geo_template]
  extension: required
}

view: fb_ad_impressions_geo_config {
  extends: [fb_ad_impressions_geo_template]
  extension: required
}

# Hourly Platform and Device Aggregation
explore: fb_ad_impressions_platform_and_device_config {
  extends: [fb_ad_impressions_platform_and_device_template]
  extension: required
}

view: fb_ad_impressions_platform_and_device_config {
  extends: [fb_ad_impressions_platform_and_device_template]
  extension: required
}

explore: fb_period_comparison_config {
  extends: [fb_period_fact]
  extension: required
  hidden: no
}

view: fb_period_comparison_config {
  extends: [fb_period_fact]
  extension: required
}
