include: "//app-marketing-pinterest-ads-adapter/*.view"
include: "//app-marketing-pinterest-ads/*.view"
include: "//app-marketing-pinterest-ads/*.dashboard"
include: "//@{CONFIG_PROJECT_NAME}/pinterest_ads.view"

view: pinterest_ad_metrics_base {
  extends: [pinterest_ad_metrics_base_config]
  # Customize: Add metrics or customize drills / labels / descriptions
}

# Daily Account Aggregation
explore: pinterest_ad_impressions {
  extends: [pinterest_ad_impressions_config]
}

view: pinterest_ad_impressions {
  extends: [pinterest_ad_impressions_config]
}

# Daily Campaign Aggregation
explore: pinterest_ad_impressions_campaign {
  extends: [pinterest_ad_impressions_campaign_config]
}

view: pinterest_ad_impressions_campaign {
  extends: [pinterest_ad_impressions_campaign_config]
}

# Daily Ad Group Aggregation
explore: pinterest_ad_impressions_ad_group {
  extends: [pinterest_ad_impressions_ad_group_config]
}

view: pinterest_ad_impressions_ad_group {
  extends: [pinterest_ad_impressions_ad_group_config]
}

# Daily Ad Aggregation
explore: pinterest_ad_impressions_ad {
  extends: [pinterest_ad_impressions_ad_config]
}

view: pinterest_ad_impressions_ad {
  extends: [pinterest_ad_impressions_ad_config]
}

explore: pinterest_period_comparison {
  extends: [pinterest_period_comparison_config]
}

view: pinterest_period_comparison {
  extends: [pinterest_period_comparison_config]
}
