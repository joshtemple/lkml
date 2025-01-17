include: "fb_account_fact.view"

explore: fb_campaign_date_fact {
  extends: [fb_account_date_fact]
  hidden: yes
  from: fb_campaign_date_fact
  view_name: fact
  label: "Campaign This Period"
  view_label: "Campaign This Period"
  join: last_fact {
    from: fb_campaign_date_fact
    view_label: "Campaign Prior Period"
    sql_on: ${fact.account_id} = ${last_fact.account_id} AND
      ${fact.campaign_id} = ${last_fact.campaign_id} AND
      ${fact.date_last_period} = ${last_fact.date_period} AND
      ${fact.date_day_of_period} = ${last_fact.date_day_of_period} ;;
    relationship: one_to_one
  }
  join: parent_fact {
    view_label: "Account This Period"
    from: fb_account_date_fact
    sql_on: ${fact.account_id} = ${parent_fact.account_id} AND
      ${fact.date_date} = ${parent_fact.date_date};;
    relationship: many_to_one
  }

  join: campaign {
    from: fb_campaign
    view_label: "Campaign"
    type: left_outer
    sql_on: ${fact.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }
}

view: fb_campaign_key_base {
  extends: [fb_account_key_base]
  extension: required

  dimension: campaign_key_base {
    hidden: yes
    sql:
      {% if _dialect._name == 'redshift' %}
        ${account_key_base} || '-' || CAST(${campaign_id} AS VARCHAR)
      {% elsif _dialect._name == 'snowflake' %}
        ${account_key_base} || '-' || TO_CHAR(${campaign_id})
      {% else %}
        CONCAT(${account_key_base}, "-", CAST(${campaign_id} as STRING))
      {% endif %}
       ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${campaign_key_base} ;;
  }
}

view: fb_campaign_date_fact {
  extends: [ad_metrics_parent_comparison_base, fb_account_date_fact, fb_campaign_key_base, pdt_base]
  derived_table: {
    datagroup_trigger: facebook_ads_etl_datagroup
    explore_source: fb_ad_impressions {
      column: campaign_id { field: fact.campaign_id }
      column: campaign_name { field: fact.campaign_name }
      derived_column: _distribution_alias {
        sql: campaign_id ;;
      }
      derived_column: _sortkey_alias {
        sql: campaign_id ;;
      }
    }
  }
  dimension: campaign_id {
    hidden: yes
  }
  dimension: campaign_name {
    required_fields: [account_id, campaign_id]
    label: "Campaign Name"
  }
}
