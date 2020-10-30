connection: "kiwi_facebookads"

# include all the views
include: "*.view"

# include all the dashboards
#include: "*.dashboard"

datagroup: kiwi_facebookads_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kiwi_facebookads_default_datagroup

# explore: ad_accounts {}
#
# explore: ad_accounts_view {}
#
# explore: ad_sets {
#   join: campaigns {
#     type: left_outer
#     sql_on: ${ad_sets.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ad_sets_view {
#   join: campaigns {
#     type: left_outer
#     sql_on: ${ad_sets_view.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ads {
#   join: campaigns {
#     type: left_outer
#     sql_on: ${ads.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ads_view {
#   join: campaigns {
#     type: left_outer
#     sql_on: ${ads_view.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: campaigns {}
#
# # explore: campaigns_view {}

explore: insights_view {
  join: ads {
    type: left_outer
    sql_on: ${insights_view.ad_id} = ${ads.id} ;;
    relationship: many_to_one
  }

  join: campaigns_view{
    type: left_outer
    sql_on: ${ads.campaign_id} = ${campaigns_view.id} ;;
    relationship: many_to_one
  }

join: ad_sets_view {
    type: left_outer
    sql_on: ${ads.adset_id} = ${ad_sets_view.id} ;;
    relationship: many_to_one
  }

join: pages {
    type:  left_outer
    sql_on:  ${insights_view.ad_id} = ${pages.ad_id} ;;
    relationship:  many_to_many
    required_joins: [ads]
  }
  join: users {
    type: left_outer
    sql_on: ${pages.user_id} = ${users.id} ;;
    relationship: many_to_one
    required_joins: [pages]
  }
  join: completed_order {
    type: left_outer
    sql_on: ${pages.anonymous_id} = ${completed_order.anonymous_id} ;;
    relationship: many_to_many
    required_joins: [pages]
  }
  join: email_submitted {
    type: left_outer
    sql_on: ${pages.anonymous_id} = ${email_submitted.anonymous_id} ;;
    relationship: many_to_many
    required_joins: [pages]
  }
}

# explore: insights_view {
#   join: ads {
#     type: left_outer
#     sql_on: ${insights_view.ad_id} = ${ads.id} ;;
#     relationship: many_to_one
#   }
# }
#   join: campaigns {
#     type: left_outer
#     sql_on: ${ads.campaign_id} = ${campaigns.id} ;;
#     relationship: many_to_one
#   }
# }
