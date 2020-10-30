# include: "ad_impressions.view"
# include: "fb_ad_impressions.view"

view: cross_channel_ad_impressions_base {
  extends: [ad_metrics_base, date_base, period_base, date_primary_key_base]

  dimension: _date {
    hidden: yes
    type: date_raw
  }
  dimension: account_id {
    hidden: yes
  }
  dimension: campaign_id {
    hidden: yes
  }
  dimension: ad_group_id {
    hidden: yes
  }
  dimension: cross_channel_ad_group_key_base {
    hidden: yes
    sql: concat(${account_id}, ${campaign_id}, ${ad_group_id}) ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${cross_channel_ad_group_key_base} ;;
  }
}

explore: google_adwords_ad_impressions {
  persist_with: adwords_etl_datagroup
  hidden: yes
  from: google_adwords_ad_impressions
  view_name: fact
}

view: google_adwords_ad_impressions {
  extends: [cross_channel_ad_impressions_base]

  derived_table: {
    datagroup_trigger: adwords_etl_datagroup
    explore_source: ad_impressions_ad_group {
      column: _date { field: fact.date_date}
      column: account_id { field: fact.external_customer_id_string }
      column: campaign_id { field: fact.campaign_id_string }
      column: ad_group_id { field: fact.ad_group_id_string }
      column: cost { field: fact.total_cost }
      column: impressions { field: fact.total_impressions }
      column: clicks { field: fact.total_clicks }
      column: conversions { field: fact.total_conversions }
      column: conversionvalue { field: fact.total_conversionvalue }
    }
  }
}

explore: facebook_ad_impressions {
  persist_with: facebook_ads_etl_datagroup
  hidden: yes
  from: facebook_ad_impressions
  view_name: fact
}

view: facebook_ad_impressions {
  extends: [cross_channel_ad_impressions_base]

  derived_table: {
    datagroup_trigger: facebook_ads_etl_datagroup
    explore_source: fb_ad_impressions {
      column: _date { field: fact.date_date}
      column: account_id { field: fact.account_id }
      column: campaign_id { field: fact.campaign_id }
      column: ad_group_id { field: fact.adset_id }
      column: cost { field: fact.total_cost }
      column: impressions { field: fact.total_impressions }
      column: clicks { field: fact.total_clicks }
      column: conversions { field: fact.total_conversions }
      column: conversionvalue { field: fact.total_conversionvalue }
    }
  }
}

explore: cross_channel_ad_impressions {
  persist_with: ama_etl_datagroup
  hidden: yes
  from: cross_channel_ad_impressions
  view_name: fact
}

view: cross_channel_ad_impressions {
  extends: [cross_channel_ad_impressions_base, cross_channel_ad_impressions_dt]
}
