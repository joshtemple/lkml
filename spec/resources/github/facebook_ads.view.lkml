# Facebook Ads configuration for Marketing Analytics by Looker


# TODO: Update Facebook Ads schema
datagroup: facebook_ads_etl_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `@{FACEBOOK_ADS_SCHEMA_NAME}.ads_insights` ;;
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
  group_label: "Marketing Analytics"
  hidden: no

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
  extends: [fb_ad_impressions_template]
  extension: required
}

# Hourly Age and Gender Aggregation
explore: fb_ad_impressions_age_and_gender_config {
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
  extends: [fb_ad_impressions_age_and_gender_template]
  extension: required
}

# Hourly Geo Aggregation
explore: fb_ad_impressions_geo_config {
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
  extension: required
  hidden: no
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
