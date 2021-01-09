connection: "segment_cdh"

# include all the views
include: "*.view"

datagroup: default_datagroup {
  max_cache_age: "24 hours"
}

persist_with: default_datagroup


explore: offline_marketing_old {
  hidden: yes
  view_name: offline_marketing_spend
  always_filter: {
    filters: {
      field: offline_campaign_attribution_old.attribution_time_period
      value: ""
    }
  }
  join: orders {
    view_label: "Associated Orders"
    type: left_outer
    sql_on: ${offline_marketing_spend.deal_id} = ${orders.deal_id}
              AND date(${offline_marketing_spend.campaign_raw}) >= date(${orders.created_raw} - interval {% parameter offline_campaign_attribution_old.attribution_time_period %})
              AND date(${offline_marketing_spend.campaign_raw}) <= date(${orders.created_raw})
              AND ${offline_marketing_spend.state} = ${orders.state}
    ;;
    relationship: many_to_many
  }
  join: offline_campaign_attribution_old {
    view_label: "Attribution Model"
    type: left_outer
    sql_on: ${offline_marketing_spend.id} = ${offline_campaign_attribution_old.offline_marketing_id}
              AND ${orders.id} = ${offline_campaign_attribution_old.order_id}
    ;;
    relationship: one_to_one
  }
}


explore: online_marketing {
  hidden: yes
  view_name: events
  join: users {
    type: inner
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: orders {
    type: inner
    sql_on: ${users.id} = ${orders.user_email}
            AND ${events.original_timestamp_date} >= ${orders.created_raw} - interval '4 weeks'
            AND ${events.original_timestamp_raw} <= ${orders.created_raw}
    ;;
    relationship: one_to_many
  }
}
#ab edit
explore: deal__c {
 view_name: deal__c
#join: offline_marketing_spend {
#    type: inner
#    sql_on: ${deal__c.name} = ${offline_marketing_spend.deal_id};;
 }
#
#}
#abedit

explore: offline_marketing {
  view_name: offline_marketing_spend

  join: orders {
    type: inner
    sql_on: ${offline_marketing_spend.deal_id} = ${orders.deal_id}
              AND date(${offline_marketing_spend.campaign_raw}) >= date(${orders.created_raw} - interval {% parameter offline_marketing_spend.attribution_time_period %})
              AND date(${offline_marketing_spend.campaign_raw}) <= date(${orders.created_raw})
              AND ${offline_marketing_spend.state} = ${orders.state}
    ;;
    relationship: many_to_many
  }
  join: online_campaign_attribution {
    type: left_outer
    sql_on: ${orders.id} = ${online_campaign_attribution.order_id} ;;
    relationship: one_to_many
  }
}


explore: campaign_attribution {
  view_name: orders
  always_filter: {
    filters: {
      field: offline_marketing_spend.attribution_time_period
      value: "7 days"
    }
  }
  join: online_campaign_attribution {
    type: left_outer
    sql_on: ${orders.id} = ${online_campaign_attribution.order_id} ;;
    relationship: one_to_many
  }
  join: offline_campaign_attribution {
    type: left_outer
    sql_on: ${orders.id} = ${offline_campaign_attribution.order_id} ;;
    relationship: one_to_many
  }
  join: offline_marketing_spend {
    type: left_outer
    sql_on: ${orders.deal_id} = ${offline_marketing_spend.deal_id} ;;
    relationship: many_to_many
  }
}


explore: customers {
  view_name: orders
  join: users {
    type: left_outer
    sql_on: ${orders.user_email} = ${users.email} ;;
    relationship: many_to_one
  }
  join: customer_facts {
    type: left_outer
    sql_on: ${orders.user_email} = ${customer_facts.user_email} ;;
    relationship: many_to_one
  }
}
