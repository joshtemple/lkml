include: "//app-marketing-linkedin-ads-adapter/*.view"
include: "//app-marketing-linkedin-ads/*.view"
include: "//app-marketing-linkedin-ads/*.dashboard"
include: "//@{CONFIG_PROJECT_NAME}/linkedin_ads.view"

explore: li_period_comparison {
  extends: [li_period_comparison_config]
  hidden: no
}

view: li_period_comparison {
  extends: [li_period_comparison_config]
}

explore: linkedin_ad_impressions_campaign {
  extends: [linkedin_ad_impressions_campaign_config]
}

view: linkedin_ad_impressions_campaign {
  extends: [linkedin_ad_impressions_campaign_config]
}

explore: linkedin_ad_impressions_ad {
  extends: [linkedin_ad_impressions_ad_config]
}

view: linkedin_ad_impressions_ad {
  extends: [linkedin_ad_impressions_ad_config]
}