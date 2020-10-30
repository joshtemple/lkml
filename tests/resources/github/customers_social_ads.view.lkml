view: customers_social_ads {
  sql_table_name: customers.social_ads ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: custom_data {
    type: string
    sql: ${TABLE}.custom_data ;;
  }

  dimension: days_from_last_attributed_touch_to_event {
    type: string
    sql: ${TABLE}.days_from_last_attributed_touch_to_event ;;
  }

  dimension: deep_linked {
    type: string
    sql: ${TABLE}.deep_linked ;;
  }

  dimension: di_match_click_token {
    type: string
    sql: ${TABLE}.di_match_click_token ;;
  }

  dimension: event_data_affiliation {
    type: string
    sql: ${TABLE}.event_data_affiliation ;;
  }

  dimension: event_data_coupon {
    type: string
    sql: ${TABLE}.event_data_coupon ;;
  }

  dimension: event_data_currency {
    type: string
    sql: ${TABLE}.event_data_currency ;;
  }

  dimension: event_data_description {
    type: string
    sql: ${TABLE}.event_data_description ;;
  }

  dimension: event_data_exchange_rate {
    type: string
    sql: ${TABLE}.event_data_exchange_rate ;;
  }

  dimension: event_data_revenue {
    type: string
    sql: ${TABLE}.event_data_revenue ;;
  }

  dimension: event_data_revenue_in_usd {
    type: string
    sql: ${TABLE}.event_data_revenue_in_usd ;;
  }

  dimension: event_data_search_query {
    type: string
    sql: ${TABLE}.event_data_search_query ;;
  }

  dimension: event_data_shipping {
    type: string
    sql: ${TABLE}.event_data_shipping ;;
  }

  dimension: event_data_tax {
    type: string
    sql: ${TABLE}.event_data_tax ;;
  }

  dimension: event_data_transaction_id {
    type: string
    sql: ${TABLE}.event_data_transaction_id ;;
  }

  dimension: first_event_for_user {
    type: string
    sql: ${TABLE}.first_event_for_user ;;
  }

  dimension: hash_version {
    type: string
    sql: ${TABLE}.hash_version ;;
  }

  dimension: hours_from_last_attributed_touch_to_event {
    type: string
    sql: ${TABLE}.hours_from_last_attributed_touch_to_event ;;
  }

  dimension: last_attributed_touch_data_custom_fields {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_custom_fields ;;
  }

  dimension: last_attributed_touch_data_dollar_3p {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_dollar_3p ;;
  }

  dimension: last_attributed_touch_data_plus_current_feature {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_plus_current_feature ;;
  }

  dimension: last_attributed_touch_data_plus_via_features {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_plus_via_features ;;
  }

  dimension: last_attributed_touch_data_plus_web_format {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_plus_web_format ;;
  }

  dimension: last_attributed_touch_data_tilde_ad_id {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_ad_id ;;
  }

  dimension: last_attributed_touch_data_tilde_ad_name {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_ad_name ;;
  }

  dimension: last_attributed_touch_data_tilde_ad_set_id {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_ad_set_id ;;
  }

  dimension: last_attributed_touch_data_tilde_ad_set_name {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_ad_set_name ;;
  }

  dimension: last_attributed_touch_data_tilde_advertising_partner_name {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_advertising_partner_name ;;
  }

  dimension: last_attributed_touch_data_tilde_agency {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_agency ;;
  }

  dimension: last_attributed_touch_data_tilde_banner_dimensions {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_banner_dimensions ;;
  }

  dimension: last_attributed_touch_data_tilde_branch_ad_format {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_branch_ad_format ;;
  }

  dimension: last_attributed_touch_data_tilde_campaign {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_campaign ;;
  }

  dimension: last_attributed_touch_data_tilde_campaign_id {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_campaign_id ;;
  }

  dimension: last_attributed_touch_data_tilde_channel {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_channel ;;
  }

  dimension: last_attributed_touch_data_tilde_creative_id {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_creative_id ;;
  }

  dimension: last_attributed_touch_data_tilde_creative_name {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_creative_name ;;
  }

  dimension: last_attributed_touch_data_tilde_feature {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_feature ;;
  }

  dimension: last_attributed_touch_data_tilde_id {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_id ;;
  }

  dimension: last_attributed_touch_data_tilde_keyword {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_keyword ;;
  }

  dimension: last_attributed_touch_data_tilde_keyword_id {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_keyword_id ;;
  }

  dimension: last_attributed_touch_data_tilde_optimization_model {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_optimization_model ;;
  }

  dimension: last_attributed_touch_data_tilde_placement {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_placement ;;
  }

  dimension: last_attributed_touch_data_tilde_secondary_ad_format {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_secondary_ad_format ;;
  }

  dimension: last_attributed_touch_data_tilde_secondary_publisher {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_secondary_publisher ;;
  }

  dimension: last_attributed_touch_data_tilde_stage {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_stage ;;
  }

  dimension: last_attributed_touch_data_tilde_tags {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_tags ;;
  }

  dimension: last_attributed_touch_data_tilde_technology_partner {
    type: string
    sql: ${TABLE}.last_attributed_touch_data_tilde_technology_partner ;;
  }

  dimension: last_attributed_touch_timestamp {
    type: string
    sql: ${TABLE}.last_attributed_touch_timestamp ;;
  }

  dimension: last_attributed_touch_timestamp_iso {
    type: string
    sql: ${TABLE}.last_attributed_touch_timestamp_iso ;;
  }

  dimension: last_attributed_touch_type {
    type: string
    sql: ${TABLE}.last_attributed_touch_type ;;
  }

  dimension: last_cta_view_data_custom_fields {
    type: string
    sql: ${TABLE}.last_cta_view_data_custom_fields ;;
  }

  dimension: last_cta_view_data_dollar_3p {
    type: string
    sql: ${TABLE}.last_cta_view_data_dollar_3p ;;
  }

  dimension: last_cta_view_data_plus_via_features {
    type: string
    sql: ${TABLE}.last_cta_view_data_plus_via_features ;;
  }

  dimension: last_cta_view_data_plus_web_format {
    type: string
    sql: ${TABLE}.last_cta_view_data_plus_web_format ;;
  }

  dimension: last_cta_view_data_tilde_ad_id {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_ad_id ;;
  }

  dimension: last_cta_view_data_tilde_ad_name {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_ad_name ;;
  }

  dimension: last_cta_view_data_tilde_ad_set_id {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_ad_set_id ;;
  }

  dimension: last_cta_view_data_tilde_ad_set_name {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_ad_set_name ;;
  }

  dimension: last_cta_view_data_tilde_advertising_partner_name {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_advertising_partner_name ;;
  }

  dimension: last_cta_view_data_tilde_agency {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_agency ;;
  }

  dimension: last_cta_view_data_tilde_banner_dimensions {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_banner_dimensions ;;
  }

  dimension: last_cta_view_data_tilde_branch_ad_format {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_branch_ad_format ;;
  }

  dimension: last_cta_view_data_tilde_campaign {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_campaign ;;
  }

  dimension: last_cta_view_data_tilde_campaign_id {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_campaign_id ;;
  }

  dimension: last_cta_view_data_tilde_channel {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_channel ;;
  }

  dimension: last_cta_view_data_tilde_creative_id {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_creative_id ;;
  }

  dimension: last_cta_view_data_tilde_creative_name {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_creative_name ;;
  }

  dimension: last_cta_view_data_tilde_feature {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_feature ;;
  }

  dimension: last_cta_view_data_tilde_id {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_id ;;
  }

  dimension: last_cta_view_data_tilde_keyword_id {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_keyword_id ;;
  }

  dimension: last_cta_view_data_tilde_optimization_model {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_optimization_model ;;
  }

  dimension: last_cta_view_data_tilde_placement {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_placement ;;
  }

  dimension: last_cta_view_data_tilde_secondary_ad_format {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_secondary_ad_format ;;
  }

  dimension: last_cta_view_data_tilde_secondary_publisher {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_secondary_publisher ;;
  }

  dimension: last_cta_view_data_tilde_stage {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_stage ;;
  }

  dimension: last_cta_view_data_tilde_tags {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_tags ;;
  }

  dimension: last_cta_view_data_tilde_technology_partner {
    type: string
    sql: ${TABLE}.last_cta_view_data_tilde_technology_partner ;;
  }

  dimension: last_cta_view_timestamp {
    type: string
    sql: ${TABLE}.last_cta_view_timestamp ;;
  }

  dimension: last_cta_view_timestamp_iso {
    type: string
    sql: ${TABLE}.last_cta_view_timestamp_iso ;;
  }

  dimension: minutes_from_last_attributed_touch_to_event {
    type: string
    sql: ${TABLE}.minutes_from_last_attributed_touch_to_event ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: seconds_from_last_attributed_touch_to_event {
    type: string
    sql: ${TABLE}.seconds_from_last_attributed_touch_to_event ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
  }

  dimension_group: timestamp_iso{
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.timestamp_iso AS TIMESTAMP);;
  }

  dimension: user_data_aaid {
    type: string
    sql: ${TABLE}.user_data_aaid ;;
  }

  dimension: user_data_android_id {
    type: string
    sql: ${TABLE}.user_data_android_id ;;
  }

  dimension: user_data_app_version {
    type: string
    sql: ${TABLE}.user_data_app_version ;;
  }

  dimension: user_data_brand {
    type: string
    sql: ${TABLE}.user_data_brand ;;
  }

  dimension: user_data_browser {
    type: string
    sql: ${TABLE}.user_data_browser ;;
  }

  dimension: user_data_developer_identity {
    type: string
    sql: ${TABLE}.user_data_developer_identity ;;
  }

  dimension: user_data_environment {
    type: string
    sql: ${TABLE}.user_data_environment ;;
  }

  dimension: user_data_geo_country_code {
    type: string
    sql: ${TABLE}.user_data_geo_country_code ;;
  }

  dimension: user_data_geo_dma_code {
    type: string
    sql: ${TABLE}.user_data_geo_dma_code ;;
  }

  dimension: user_data_idfa {
    type: string
    sql: ${TABLE}.user_data_idfa ;;
  }

  dimension: user_data_idfv {
    type: string
    sql: ${TABLE}.user_data_idfv ;;
  }

  dimension: user_data_ip {
    type: string
    sql: ${TABLE}.user_data_ip ;;
  }

  dimension: user_data_language {
    type: string
    sql: ${TABLE}.user_data_language ;;
  }

  dimension: user_data_limit_ad_tracking {
    type: string
    sql: ${TABLE}.user_data_limit_ad_tracking ;;
  }

  dimension: user_data_model {
    type: string
    sql: ${TABLE}.user_data_model ;;
  }

  dimension: user_data_os {
    type: string
    sql: ${TABLE}.user_data_os ;;
  }

  dimension: user_data_os_version {
    type: string
    sql: ${TABLE}.user_data_os_version ;;
  }

  dimension: user_data_platform {
    type: string
    sql: ${TABLE}.user_data_platform ;;
  }

  dimension: user_data_sdk_version {
    type: string
    sql: ${TABLE}.user_data_sdk_version ;;
  }

  dimension: user_data_user_agent {
    type: string
    sql: ${TABLE}.user_data_user_agent ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_cta_view_data_tilde_ad_name,
      last_cta_view_data_tilde_ad_set_name,
      last_cta_view_data_tilde_creative_name,
      last_cta_view_data_tilde_advertising_partner_name,
      last_attributed_touch_data_tilde_ad_name,
      last_attributed_touch_data_tilde_ad_set_name,
      last_attributed_touch_data_tilde_creative_name,
      last_attributed_touch_data_tilde_advertising_partner_name,
      name
    ]
  }
}
