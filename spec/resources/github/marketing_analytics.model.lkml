connection: "looker-app"

datagroup: ama_etl_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `adwords.account_hourly_stats` ;;
  max_cache_age: "24 hours"
}

include: "/app-marketing-common/*.view"
include: "adwords_config.view"
#include: "facebook_ads_config.view"
#include: "linkedin_ads_config.view"
#include: "bing_ads_config.view"
include: "cross_channel_ad_impressions.view"
