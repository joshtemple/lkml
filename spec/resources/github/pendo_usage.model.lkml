connection: "pendosnowflake"

# include all the views
include: "*.view"

include: "*.dashboard.lookml"

datagroup: pendo_usage_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: pendo_usage_default_datagroup

explore: events {
  label: "Events"

  join: pendo_activeuser_view {
    view_label: "Pendo Active User View"
    relationship: many_to_one
    sql_on: ${events.accountid}=${pendo_activeuser_view.accountid} and ${events.visitorid}=${pendo_activeuser_view.visitorid}  ;;
  }

  join: pendo_activeaccount_view {
    view_label: "Pendo Active Account View"
    relationship: many_to_one
    sql_on: ${events.accountid}=${pendo_activeaccount_view.accountid} ;;
  }

}

explore: accounts {
  label: "Accounts"
}


explore: allfeatures {
  label: "All Features"
}


explore: allpages {
  label: "All Pages"
}

explore: featureevents {
  label: "Feature Events"
  join: accounts {
    type: left_outer
    sql_on: ${featureevents.account_id} = ${accounts.account_id} ;;
    relationship: many_to_one
  }

  join: visitors {
    type: left_outer
    sql_on: ${featureevents.visitor_id} = ${visitors.visitor_id} ;;
    relationship: many_to_one
  }

  join: allfeatures {
    type: left_outer
    sql_on: ${featureevents.feature_id} = ${allfeatures.id} ;;
    relationship: many_to_one
  }
}

explore: pageevents {
  label: "Page Events"
  join: accounts {
    type: left_outer
    sql_on: ${pageevents.account_id} = ${accounts.account_id} ;;
    relationship: many_to_one
  }

  join: visitors {
    type: left_outer
    sql_on: ${pageevents.visitor_id} = ${visitors.visitor_id} ;;
    relationship: many_to_one
  }

  join: allpages {
    type: left_outer
    sql_on: ${pageevents.page_id} = ${allpages.id} ;;
    relationship: many_to_one
  }
}

explore: visitors {
  label: "Visitors"
  join: accounts {
    type: left_outer
    sql_on: ${visitors.accountid} = ${accounts.account_id} ;;
    relationship: one_to_many
  }
}
