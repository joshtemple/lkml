
datagroup: facebook_ads_etl_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `@{FACEBOOK_SCHEMA}.ads_insights` ;;
  max_cache_age: "24 hours"
}

view: facebook_ads_config {
  extension: required

# Should remain hidden as it's not intended to be used as a column.
  dimension: facebook_ads_schema {
    hidden: yes
    sql: @{FACEBOOK_SCHEMA};;
  }
}


# Customize measure definitions in this view. Changes will be reflected across all projects.
view: ad_metrics_base_config {
  extends: [ad_metrics_base_template]
  extension: required

# For example, to customize measure definitions, use this template:
#   measure: total_cost {
#     type:  sum
#     sql: ${cost} ;;
#     filters: {
#       field: campaign.name
#       value: "EU - Video - Brand"
#     }
#   }

# The complete list of measures can be found in ad_metrics_base_template file in the app-marketing-common project.
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

# To edit dimensions from Ad Table, copy their definition from app-marketing-facebook-ads adapter project, Ad View, and edit in this file.
# For example, to unhide Bid Type dimension:

#   dimension: bid_type {
#     hidden: no
#     type: string
#     sql: ${TABLE}.bid_type ;;
#   }
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
  hidden: no
  group_label: "Block Facebook Ads"
  extension: required
  extends: [fb_ad_impressions_template]

# To edit the definition of Conversion for your business, include this join with the correct Action Type.
  # join: actions {
  #   from: actions_fb_custom
  #   view_label: "Impressions"
  #   type: left_outer
  #   sql_on: ${fact.ad_id} = ${actions.ad_id} AND
  #     ${fact._date} = ${actions._date} AND
  #     ${actions.action_type}  = 'test' ;;
  #   relationship: one_to_one
  # }
}

view: fb_ad_impressions_config {
  extension: required
  extends: [fb_ad_impressions_template]
}

explore: fb_ad_impressions_age_and_gender_config {
  hidden: yes
  extends: [fb_ad_impressions_age_and_gender_template]
  extension: required

#To edit the definition of Conversion for your business, include this join with the correct Action Type.
  # join: actions {
  #   from: actions_age_and_gender_fb_custom
  #   view_label: "Impressions"
  #   type: left_outer
  #   sql_on: ${fact.ad_id} = ${actions.ad_id} AND
  #     ${fact._date} = ${actions._date} AND
  #     ${actions.action_type}  = 'test' ;;
  #   relationship: one_to_many
  # }
}

view: fb_ad_impressions_age_and_gender_config {
  extension: required
  extends: [fb_ad_impressions_age_and_gender_template]
}

# Hourly Geo Aggregation
explore: fb_ad_impressions_geo_config {
  hidden: yes
  extends: [fb_ad_impressions_geo_template]
  extension: required

#To edit the definition of Conversion for your business, include this join with the correct Action Type.
  # join: actions {
  #   from: actions_region_fb_custom
  #   view_label: "Impressions"
  #   type: left_outer
  #   sql_on: ${fact.ad_id} = ${actions.ad_id} AND
  #     ${fact._date} = ${actions._date} AND
  #     ${actions.action_type}  = 'test' ;;
  #   relationship: one_to_many
  # }
}

view: fb_ad_impressions_geo_config {
  extends: [fb_ad_impressions_geo_template]
  extension: required
}

# Hourly Platform and Device Aggregation
explore: fb_ad_impressions_platform_and_device_config {
  hidden: no
  group_label: "Block Facebook Ads"
  extends: [fb_ad_impressions_platform_and_device_template]
  extension: required

  # To edit the definition of Conversion for your business, include this join with the correct Action Type.
  # join: actions {
  #   from: actions_platform_and_device_fb_custom
  #   view_label: "Impressions"
  #   type: left_outer
  #   sql_on: ${fact.ad_id} = ${actions.ad_id} AND
  #     ${fact._date} = ${actions._date} AND
  #     ${fact.breakdown} = ${actions.breakdown} AND
  #     ${actions.action_type}  = 'test' ;;
  #   relationship: one_to_many
  # }
}

view: fb_ad_impressions_platform_and_device_config {
  extends: [fb_ad_impressions_platform_and_device_template]
  extension: required
}

explore: fb_period_comparison_config {
  extends: [fb_period_fact]
  hidden: no
  group_label: "Block Facebook Ads"
  extension: required
}

view: fb_period_comparison_config {
  extends: [fb_period_fact]
  extension: required
}

view: actions_fb_custom_config {
  extends: [actions_fb_custom_template]
  extension: required
# To edit the definition of Conversions, edit this dimension to include the action type used by your business.

  # dimension: offsite_conversion_value {
  #   hidden: yes
  #   type: number
  #   sql: if(${action_type} = "test", ${value}, null) ;;
  # }

}

view: actions_age_and_gender_fb_custom_config {
  extends: [actions_age_and_gender_fb_template]
  extension: required
# To edit the definition of Conversions, edit this dimension to include the action type used by your business.

  # dimension: offsite_conversion_value {
  #   hidden: yes
  #   type: number
  #   sql: if(${action_type} = "test", ${value}, null) ;;
  # }
}

view: actions_hour_fb_custom_config {
  extends: [actions_age_and_gender_fb_template]
  extension: required
# To edit the definition of Conversions, edit this dimension to include the action type used by your business.

  # dimension: offsite_conversion_value {
  #   hidden: yes
  #   type: number
  #   sql: if(${action_type} = "test", ${value}, null) ;;
  # }
}

view: actions_platform_and_device_fb_custom_config {
  extends: [actions_platform_and_device_fb_template]
  extension: required
# To edit the definition of Conversions, edit this dimension to include the action type used by your business.

  # dimension: offsite_conversion_value {
  #   hidden: yes
  #   type: number
  #   sql: if(${action_type} = "test", ${value}, null) ;;
  # }
}

view: actions_region_fb_custom_config {
  extends: [actions_age_and_gender_fb_template]
  extension: required
# To edit the definition of Conversions, edit this dimension to include the action type used by your business.

  # dimension: offsite_conversion_value {
  #   hidden: yes
  #   type: number
  #   sql: if(${action_type} = "test", ${value}, null) ;;
  # }
}
