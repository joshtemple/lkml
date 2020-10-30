connection: "@{CONNECTION_NAME}"
include: "//@{CONFIG_PROJECT_NAME}/*.view"
include: "//@{CONFIG_PROJECT_NAME}/*.dashboard"

include: "//app-marketing-common/ad_metrics_base_template.view"
include: "//app-marketing-common/date_base.view"
include: "//app-marketing-common/date_primary_key_base.view"
include: "//app-marketing-common/pdt_base.view"
include: "//app-marketing-common/period_base.view"
include: "//app-marketing-common/ad_metrics_parent_comparison_base.view"
include: "//app-marketing-common/ad_metrics_period_comparison_base.view"

include: "*.view"
include: "*.dashboard"

explore: pinterest_period_comparison {
  extends: [pinterest_period_comparison_config]
  hidden: no
  group_label: "Block Pinterest Ads"
}

# Daily Ad Aggregation
explore: pinterest_ad_impressions_ad {
  extends: [pinterest_ad_impressions_ad_config]
  hidden: no
  group_label: "Block Pinterest Ads"
}

# Daily Ad Group Aggregation
explore: pinterest_ad_impressions_ad_group {
  extends: [pinterest_ad_impressions_ad_group_config]
}

# Daily Campaign Aggregation
explore: pinterest_ad_impressions_campaign {
  extends: [pinterest_ad_impressions_campaign_config]
  hidden: no
  group_label: "Block Pinterest Ads"
}

# Daily Account Aggregation
explore: pinterest_ad_impressions {
  extends: [pinterest_ad_impressions_config]
}
