include: "//@{CONFIG_PROJECT_NAME}/*.view"

# Google Ads configuration for Google Ads Block by Looker

include: "//app-marketing-google-ads-adapter/*.view"
include: "//app-marketing-google-ads/*.view"
include: "//app-marketing-common/*.view"

# Customize measure definitions in this view. Changes will be reflected across all projects.
view: ad_metrics_base {
  extends: [ad_metrics_base_config]
}

view: ad {
  extends: [ad_config]
}

view: keyword {
  extends: [keyword_config]
}

view: ad_group {
  extends: [ad_group_config]
}

view: campaign {
  extends: [campaign_config]
}

view: customer {
  extends: [customer_config]
}

view: google_ad_metrics_base {
  extends: [google_ad_metrics_base_config]
}

view: ad_impressions {
  extends: [ad_impressions_config]
}

view: ad_impressions_daily {
  extends: [ad_impressions_daily_config]
}

view: ad_impressions_campaign {
  extends: [ad_impressions_campaign_config]
}

view: ad_impressions_campaign_daily {
  extends: [ad_impressions_campaign_daily_config]
}

view: ad_impressions_ad_group_hour {
  extends: [ad_impressions_ad_group_hour_config]
}

view: ad_impressions_ad_group {
  extends: [ad_impressions_ad_group_config]
}

view: ad_impressions_keyword {
  extends: [ad_impressions_keyword_config]
}

view: ad_impressions_ad {
  extends: [ad_impressions_ad_config]
}

view: ad_impressions_geo {
  extends: [ad_impressions_geo_config]
}

view: ad_impressions_age_range {
  extends: [ad_impressions_age_range_config]
}

view: ad_impressions_gender {
  extends: [ad_impressions_gender_config]
}

view: ad_impressions_audience {
  extends: [ad_impressions_audience_config]
}

view: ad_impressions_parental_status {
  extends: [ad_impressions_parental_status_config]
}

view: ad_impressions_video {
  extends: [ad_impressions_video_config]
}

view: adwords_period_comparison {
  extends: [adwords_period_comparison_config]
}
