include: "fb_ad_metrics_base.view"

explore: fb_ad_impressions_template {
  extension: required
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_fb_adapter]
  from: fb_ad_impressions
  view_name: fact
  group_label: "Facebook Ads (Marketing Analytics)"
  label: "Facebook Ad Impressions"
  view_label: "Impressions"
}

view: fb_ad_impressions_template {
  extension: required
  extends: [date_base, period_base, fb_ad_metrics_base, ad_impressions_fb_adapter]
}

explore: fb_ad_impressions_age_and_gender_template {
  extension: required
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_age_and_gender_fb_adapter]
  from: fb_ad_impressions_age_and_gender
  view_name: fact
  group_label: "Facebook Ads (Marketing Analytics)"
  label: "Facebook Ad Impressions by Age & Gender"
  view_label: "Impressions by Age & Gender"
}

view: fb_ad_impressions_age_and_gender_template {
  extension: required
  extends: [date_base, period_base, fb_ad_metrics_base, ad_impressions_age_and_gender_fb_adapter]
}

explore: fb_ad_impressions_geo_template {
  extension: required
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_geo_fb_adapter]
  from: fb_ad_impressions_geo
  view_name: fact
  group_label: "Facebook Ads (Marketing Analytics)"
  label: "Facebook Ad Impressions by Country"
  view_label: "Impressions by Country"
}

view: fb_ad_impressions_geo_template {
  extension: required
  extends: [date_base, period_base, fb_ad_metrics_base, ad_impressions_geo_fb_adapter]
}

explore: fb_ad_impressions_platform_and_device_template {
  extension: required
  persist_with: facebook_ads_etl_datagroup
  extends: [ad_impressions_platform_and_device_fb_adapter]
  from: fb_ad_impressions_platform_and_device
  view_name: fact
  group_label: "Facebook Ads (Marketing Analytics)"
  label: "Facebook Ad Impressions by Platform & Device"
  view_label: "Impressions by Platform & Device"
}

view: fb_ad_impressions_platform_and_device_template {
  extension: required
  extends: [date_base, period_base, fb_ad_metrics_base, ad_impressions_platform_and_device_fb_adapter]
}

view: actions_fb_custom_template {
  extension: required
  extends: [actions_fb_adapter]
}

view: actions_age_and_gender_fb_template {
  extension: required
  extends: [actions_age_and_gender_fb_adapter]
}

view: actions_hour_fb_template {
  extension: required
  extends: [actions_hour_fb_adapter]
}

view: actions_platform_and_device_fb_template {
  extension: required
  extends: [actions_platform_and_device_fb_adapter]
}
