connection: "nd_snowflake"
#connection: "next_prd_redshift"

persist_for: "10 minutes"

include: "t4007_dashboard_yesterday.view"         # include specific views in this project
include: "pdt_view_agg_with_article.view"
#include: "ua_connect_event.view"
#include: "ua_device_tags.view"
#include: "ua_connect_push_body.view"
#include: "ua_connect_tag_change.view"
#include: "ua_connect_open.view"
#include: "ua_connect_first_open.view"
#include: "ua_connect_uninstall.view"
#include: "ua_device_crossref.view"
include: "*.dashboard.lookml"                     # include all dashboards in this project

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

explore: t4007_dashboard_yesterday {
  persist_for: "10 minutes"
}

#explore: pdt_view_agg_with_article {
#  persist_for: "12 hours"
#}

#explore: ua_connect_event {
  #persist_for: "12 hours"
#}

#explore: ua_connect_tag_change {
  #persist_for: "12 hours"
#}

#explore: ua_connect_first_open {
  #persist_for: "12 hours"
#}

#explore: ua_connect_uninstall {
  #persist_for: "12 hours"
#}

#explore: ua_connect_push_schedules {
  #view_name: ua_connect_push_body
 # fields: [
 #   ua_connect_push_body.push_body_set*,
 #   ua_connect_push_body.schedule_set*
 # ]
 # sql_always_where: ${resource} = 'SCHEDULES' ;;
 # persist_for: "12 hours"
#}

#explore: ua_connect_push_experiments {
#  view_name:  ua_connect_push_body
#  fields:[
#    ua_connect_push_body.push_body_set*,
#    ua_connect_push_body.experiments_set*
#  ]
#  sql_always_where: ${resource} = 'EXPERIMENTS' ;;
#  persist_for: "12 hours"
#}

#explore: ua_connect_push_payload {
#  view_name: ua_connect_push_body
#  fields:[
#    ua_connect_push_body.push_body_set*,
#    ua_connect_push_body.push_payload_set*
#  ]
#  sql_always_where: ${resource} = 'PUSH' ;;
#  persist_for: "12 hours"
#}

#explore: ua_connect_open {
#  join: ua_connect_push_body  {
#    fields:[
#      ua_connect_push_body.push_body_set*,
#      ua_connect_push_body.push_payload_set*
#    ]
#    sql_on: TRIGGERING_PUSH_ID = ua_connect_push_body.PUSH_ID and ${ua_connect_push_body.resource} = 'PUSH' ;;
#    relationship: many_to_one
#    type: inner
#  }
#  persist_for: "12 hours"
#}

#explore: ua_device_tags {
#  persist_for: "12 hours"
#}

#explore: ua_device_crossref {
#  persist_for: "12 hours"
#}
