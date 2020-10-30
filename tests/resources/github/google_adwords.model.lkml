connection: "calendars"

# include all the views
include: "*.view"

# include all the explores
include: "*.explore"

# include all the dashboards
include: "*.dashboard"

explore: master_stats {
  persist_for: "24 hours"
  label: "Ad Stats"
  view_label: "Ad Stats"

  join: keyword {
    view_label: "Keyword"
    sql_on: ${master_stats.unique_key} = ${keyword.unique_key} AND
      ${master_stats._data_raw} = ${keyword._data_raw} ;;
    relationship: many_to_one
  }
  join: audience {
    view_label: "Audience"
    sql_on: ${master_stats.unique_key} = ${audience.unique_key} AND
      ${master_stats._data_raw} = ${audience._data_raw} ;;
    relationship: many_to_one
  }
  join: ad {
    view_label: "Ads"
    sql_on: ${ad.creative_id} = ${master_stats.creative_id} AND
      ${master_stats._data_raw} = ${ad._data_raw} ;;
    relationship:  many_to_one
  }
  join: ad_group {
    view_label: "Ad Groups"
    sql_on: ${master_stats.ad_group_id} = ${ad_group.ad_group_id} AND
      ${master_stats._data_raw} = ${ad_group._data_raw} ;;
    relationship: many_to_one
  }
  join: campaign {
    view_label: "Campaigns"
    sql_on: ${master_stats.campaign_id} = ${campaign.campaign_id} AND
      ${master_stats._data_raw} = ${campaign._data_raw};;
    relationship: many_to_one
  }
  join: customer {
    view_label: "Customer"
    sql_on: ${master_stats.external_customer_id} = ${customer.external_customer_id} AND
      ${master_stats._data_raw} = ${customer._data_raw} ;;
    relationship: many_to_one
  }
}



## Entity tables are daily snapshots
explore: customer {
  hidden: yes
  conditionally_filter: {
    filters: {
      field: latest
      value: "Yes"
    }
    unless: [_data_date]
  }
}

explore: campaign {
  hidden: yes
  conditionally_filter: {
    filters: {
      field: latest
      value: "Yes"
    }
    unless: [_data_date]
  }
  join: customer {
    view_label: "Customer"
    sql_on: ${campaign.external_customer_id} = ${customer.external_customer_id} AND
      ${campaign._data_raw} = ${customer._data_raw} ;;
    relationship:  many_to_one
  }
}

explore: ad_group {
  hidden: yes
  conditionally_filter: {
    filters: {
      field: latest
      value: "Yes"
    }
    unless: [_data_date]
  }
  join: campaign {
    view_label: "Campaign"
    sql_on: ${ad_group.campaign_id} = ${campaign.campaign_id} AND
      ${ad_group._data_raw} = ${campaign._data_raw} ;;
    relationship: many_to_one
  }
  join: customer {
    view_label: "Customer"
    sql_on: ${ad_group.external_customer_id} = ${customer.external_customer_id} AND
      ${ad_group._data_raw} = ${customer._data_raw} ;;
    relationship:  many_to_one
  }
}

explore: keyword {
  hidden: yes
  conditionally_filter: {
    filters: {
      field: latest
      value: "Yes"
    }
    unless: [_data_date]
  }
  join: ad_group {
    view_label: "Keyword"
    sql_on: ${keyword.ad_group_id} = ${ad_group.ad_group_id} AND
      ${keyword._data_raw} = ${ad_group._data_raw} ;;
    relationship: many_to_one
  }
  join: campaign {
    view_label: "Campaign"
    sql_on: ${keyword.campaign_id} = ${campaign.campaign_id} AND
      ${keyword._data_raw} = ${campaign._data_raw} ;;
    relationship: many_to_one
  }
  join: customer {
    view_label: "Customer"
    sql_on: ${keyword.external_customer_id} = ${customer.external_customer_id} AND
      ${keyword._data_raw} = ${customer._data_raw} ;;
    relationship:  many_to_one
  }
}

explore: ad {
  hidden: yes
  conditionally_filter: {
    filters: {
      field: latest
      value: "Yes"
    }
    unless: [_data_date]
  }
  join: ad_group {
    view_label: "Ad Group"
    sql_on: ${ad.ad_group_id} = ${ad_group.ad_group_id}  AND
      ${ad._data_raw} = ${ad_group._data_raw} ;;
    relationship: many_to_one
  }
  join: campaign {
    view_label: "Campaign"
    sql_on: ${ad.campaign_id} = ${campaign.campaign_id} AND
      ${ad._data_raw} = ${campaign._data_raw} ;;
    relationship: many_to_one
  }
  join: customer {
    view_label: "Customer"
    sql_on: ${customer.external_customer_id} = ${customer.external_customer_id} AND
      ${customer._data_raw} = ${customer._data_raw} ;;
    relationship:  many_to_one
  }
}

explore: account_quarter_stats {
  hidden: yes
  persist_for: "24 hours"
  label: "Account Quarter Stats"
  view_label: "Account Quarter Stats"

  join: last_account_quarter_stats {
    from: account_quarter_stats
    view_label: "Last Quarter Account Stats"
    sql_on: ${account_quarter_stats.external_customer_id} = ${last_account_quarter_stats.external_customer_id} AND
      ${account_quarter_stats._data_last_quarter} = ${last_account_quarter_stats._data_quarter} ;;
    relationship: one_to_one
  }
  join:  customer {
    view_label: "Customer"
    sql_on: ${account_quarter_stats.external_customer_id} = ${customer.external_customer_id} AND
      ${customer._latest} = ${customer._data_raw} ;;
    relationship: many_to_one
  }
}

explore: campaign_quarter_stats {
  hidden: yes
  persist_for: "24 hours"
  label: "Campaign Quarter Stats"
  view_label: "Campaign Quarter Stats"

  join: last_campaign_quarter_stats {
    from: campaign_quarter_stats
    view_label: "Last Quarter Campaign Stats"
    sql_on: ${campaign_quarter_stats.campaign_id} = ${last_campaign_quarter_stats.campaign_id} AND
      ${campaign_quarter_stats._data_last_quarter} = ${last_campaign_quarter_stats._data_quarter} ;;
    relationship: one_to_one
  }
  join: campaign {
    view_label: "Campaign"
    sql_on: ${campaign_quarter_stats.campaign_id} = ${campaign.campaign_id}  AND
      ${campaign_quarter_stats._data_raw} = ${campaign._data_raw} ;;
    relationship: many_to_one
  }
  join: customer {
    view_label: "Customer"
    sql_on: ${campaign_quarter_stats.external_customer_id} = ${customer.external_customer_id} AND
      ${campaign_quarter_stats._data_raw} = ${customer._data_raw} ;;
    relationship: many_to_one
  }
}

explore: campaign_budget_stats {
  hidden: yes
  persist_for: "24 hours"
  label: "Campaign Budget Stats"
  view_label: "Campaign Budget Stats"

  join: campaign {
    view_label: "Campaign"
    sql_on: ${campaign_budget_stats.campaign_id} = ${campaign.campaign_id}  AND
      ${campaign_budget_stats._data_raw} = ${campaign._data_raw} ;;
    relationship: many_to_one
  }
  join: customer {
    view_label: "Customer"
    sql_on: ${campaign_budget_stats.external_customer_id} = ${customer.external_customer_id} AND
      ${campaign_budget_stats._data_raw} = ${customer._data_raw} ;;
    relationship: many_to_one
  }
}
