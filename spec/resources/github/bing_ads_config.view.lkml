# Bing Ads configuration for Marketing Analytics by Looker

include: "/app-marketing-bing-ads-adapter/*.view"
include: "/app-marketing-bing-ads/*.view"
include: "/app-marketing-bing-ads/*.dashboard"

# TODO: update Bing Ads schema
datagroup: bing_ads_etl_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `bingads.ad_stats` ;;
  max_cache_age: "24 hours"
}

view: bing_ads_config {
  extension: required

  dimension: bing_ads_schema {
    hidden: yes
    sql:bingads;;
  }
}

view: bing_ad_metrics_base {
  extends: [bing_ad_metrics_base_template]
  # Customize: Add metrics or customize drills / labels / descriptions
}

# Daily Account Aggregation
explore: bing_ad_impressions {
  extends: [bing_ad_impressions_template]
}

view: bing_ad_impressions {
  extends: [bing_ad_impressions_template]
}

# Daily Campaign Aggregation
explore: bing_ad_impressions_campaign {
  extends: [bing_ad_impressions_campaign_template]
}

view: bing_ad_impressions_campaign {
  extends: [bing_ad_impressions_campaign_template]
}

# Daily Ad Group Aggregation
explore: bing_ad_impressions_ad_group {
  extends: [bing_ad_impressions_ad_group_template]
}

view: bing_ad_impressions_ad_group {
  extends: [bing_ad_impressions_ad_group_template]
}

# Daily Keyword Aggregation
explore: bing_ad_impressions_keyword {
  extends: [bing_ad_impressions_keyword_template]
}

view: bing_ad_impressions_keyword {
  extends: [bing_ad_impressions_keyword_template]
}

# Daily Ad Aggregation
explore: bing_ad_impressions_ad {
  extends: [bing_ad_impressions_ad_template]
}

view: bing_ad_impressions_ad {
  extends: [bing_ad_impressions_ad_template]
}
