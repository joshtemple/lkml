connection: "hot_cluster"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

datagroup: daily {
  sql_trigger: SELECT CURRENT_DATE ;;
  max_cache_age: "12 hours"
}


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: revenue_display_ad{
  view_name: revenue_report_per_country
  group_label: "Overall Revenue"
  description: "Aggregated Revenue from Display Ads(data source:MSFT pubcenter)"
}


explore: revenue_product_ad {
  view_name: revenue_report_product_ad
  view_label: "Aggregated Revenue from Product Ads(data source:MSFT pubcenter)"
  group_label: "Overall Revenue"
  description: "Aggregated Revenue from Product Ads per Country (data source:MSFT pubcenter)"
}

explore: revenue_report_per_typetag {
  label: "Revenue explore"
  view_label: "Marketing Revenue"
  group_label: "Marketing"
  description: "Aggregated Revenue per Marketing Source - aka Typetag (data source:MSFT pubcenter)"
  join: link_database {
    # view_label: "Marketing Revenue"
    type:left_outer
    relationship: many_to_one
    sql_on:${revenue_report_per_typetag.typetag}=${link_database.typetag};;
  }
}

# explore: marketing_events {
#   view_name: events
#   group_label: "Marketing"
#   join: org_ecosia_ecfg_context_1 {
#     view_label: "ECFG User cookie data"
#     type: left_outer
#     relationship: one_to_one
#     sql_on: ${events.event_id} = ${org_ecosia_ecfg_context_1.root_id} ;;
#   }
#   join: link_database
#   {view_label:"Campaign Attributes"
#     type: left_outer
#     relationship: many_to_one
#     sql_on:${org_ecosia_ecfg_context_1.typetag}=${link_database.typetag};;
#   }
# }


explore: marketing_touches_desktop{
view_name: touches
description: "Touches per user on desktop"
group_label: "Marketing"

join: link_database {
    view_label:"Campaign Attributes"
    type: left_outer
    relationship: many_to_one
    sql_on:${touches.typetag}=${link_database.typetag};;
  }

join: user_touch_facts {
  view_label: "Touches"
  type: left_outer
  sql_on: ${touches.domain_userid} = ${user_touch_facts.domain_userid} ;;
  relationship: many_to_one
  }
}


explore: installs{
  view_name: install_all
  description: "Installs on desktop with reactivation"
  group_label: "Installs and Uninstalls"
  join: link_database
  {view_label:"Campaign Attributes"
    type: left_outer
    relationship: many_to_one
    sql_on:${install_all.typetag}=${link_database.typetag};;
  }
  join: install_first {
    view_label: "Touches"
    type: left_outer
    sql_on: ${install_all.domain_userid} = ${install_first.domain_userid} ;;
    relationship: many_to_one
  }
}

access_grant: can_see_designer_fields
{user_attribute: designer
  allowed_values: [ "yes"]}



  explore: events {
    access_filter: {
    field: org_ecosia_ecfg_context_1.devicetype
    user_attribute: devicetype
    }
    group_label: "Atomic events"
    join: org_ecosia_ecfg_context_1 {
      view_label: "Events"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_ecfg_context_1.root_id} ;;
    }
    join: org_ecosia_abtest_context_1 {
      view_label: "AB Test"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_abtest_context_1.root_id} ;;
    }
    join: org_ecosia_ad_context_2 {
      view_label: "Ad Shown Details"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_ad_context_2.root_id} ;;
    }
    join: org_ecosia_advert_click_event_1 {
      view_label: "Ad Click Details"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_advert_click_event_1.root_id} ;;
    }
    join: org_ecosia_android_install_event_1 {
      view_label: "Android Installs"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_android_install_event_1.root_id} ;;
    }
    join: org_ecosia_install_event_1 {
      view_label: "All Installs"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_install_event_1.root_id} ;;
    }
    join: org_ecosia_ios_install_event_1 {
      view_label: "iOS Installs"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_ios_install_event_1.root_id} ;;
    }
    join: org_ecosia_knowledge_context_1 {
      view_label: "Entity Information Received"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_install_event_1.root_id} ;;
    }
    join: org_ecosia_search_event_1 {
      view_label: "Search Event Details"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_search_event_1.root_id} ;;
    }
    join: org_ecosia_slottings_context_1 {
      view_label: "Slotting Signals"
      type: left_outer
      relationship: one_to_one
      sql_on: ${events.event_id} = ${org_ecosia_slottings_context_1.root_id} ;;
    }
  }

  explore: search_events{
    group_label: "Product"
    view_name: org_ecosia_search_event_1
    join: org_ecosia_ecfg_context_1 {
      view_label: "ECFG"
      type: left_outer
      relationship: one_to_one
      sql_on: ${org_ecosia_search_event_1.root_id} = ${org_ecosia_ecfg_context_1.root_id} ;;
    }
    join: org_ecosia_ad_context_2 {
      view_label: "Ad Shown Details"
      type: left_outer
      relationship: one_to_one
      sql_on: ${org_ecosia_search_event_1.root_id} = ${org_ecosia_ad_context_2.root_id} ;;
    }
    join: org_ecosia_knowledge_context_1 {
      view_label: "Entity Information Received"
      type: left_outer
      relationship: one_to_one
      sql_on: ${org_ecosia_search_event_1.root_id} = ${org_ecosia_knowledge_context_1.root_id} ;;
    }
    join: org_ecosia_slottings_context_1 {
      view_label: "Slotting Signals"
      type: left_outer
      relationship: one_to_one
      sql_on: ${org_ecosia_search_event_1.root_id} = ${org_ecosia_slottings_context_1.root_id} ;;
    }
    join: org_ecosia_weather_context_1 {
      view_label: "Weather Widget info"
      type: left_outer
      relationship: one_to_one
      sql_on: ${org_ecosia_search_event_1.root_id} = ${org_ecosia_weather_context_1.root_id} ;;
    }
    join: events {
      view_label: "Events Info"
      type: left_outer
      relationship: one_to_one
      sql_on: ${org_ecosia_search_event_1.root_id} = ${events.event_id} ;;
    }
  }
