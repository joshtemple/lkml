include: "bing_ad_metrics_base.view"
include: "date_fact.view"

explore: bing_account_date_fact {
  persist_with: bing_ads_etl_datagroup
  hidden: yes
  from: bing_account_date_fact
  extends: [bing_account_join]
  view_name: fact
  label: "Account This Period"
  view_label: "Account This Period"
  join: last_fact {
    from: bing_account_date_fact
    view_label: "Account Prior Period"
    sql_on: ${fact.account_id} = ${last_fact.account_id} AND
      ${fact.date_last_period} = ${last_fact.date_period} AND
      ${fact.date_day_of_period} = ${last_fact.date_day_of_period} ;;
    relationship: one_to_one
  }
  join: total {
    from: bing_date_fact
    view_label: "Total This Period"
    sql_on: ${fact.date_period} = ${total.date_period} ;;
    relationship: many_to_one
  }
  join: last_total {
    from: bing_date_fact
    view_label: "Total Last Period"
    sql_on: ${fact.date_last_period} = ${last_total.date_period} ;;
    relationship: many_to_one
  }
}

view: bing_account_key_base {
  extends: [date_primary_key_base]
  extension: required

  dimension: account_key_base {
    hidden: yes
    sql: {% if _dialect._name == 'snowflake' %}
        TO_CHAR(${account_id}) || '-' || TO_CHAR(${device_type})
      {% elsif _dialect._name == 'redshift' %}
        CAST(${account_id} AS VARCHAR)  || '-' || CAST(${device_type} AS VARCHAR)
      {% else %}
        CAST(${account_id} AS STRING, "-", CAST(${device_type} as STRING))
      {% endif %} ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${account_key_base} ;;
  }
}

view: bing_account_date_fact {
  extends: [date_base, bing_ad_metrics_base, bing_account_key_base, period_base, ad_metrics_period_comparison_base, ad_metrics_weighted_period_comparison_base]

  derived_table: {
    datagroup_trigger: bing_ads_etl_datagroup
    explore_source: bing_ad_impressions {
      column: _date { field: fact.date_date }
      column: account_id { field: fact.account_id }
      column: device_type {field: fact.device_type }
      column: average_position {field: fact.weighted_average_position}
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: revenue {field: fact.total_conversionvalue}
      column: spend {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
    }
  }
  dimension: account_id {
    hidden: yes
  }
  dimension: device_type {
    hidden: no
  }
  dimension: _date {
    hidden: yes
    type: date_raw
    sql: CAST(${TABLE}._date AS DATE) ;;
  }
  set: detail {
    fields: [account_id]
  }
}
