connection: "kiwi_marketo"

# include all the views
include: "*.view"

# include all the dashboards
#include: "*.dashboard"

datagroup: kiwi_marketo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kiwi_marketo_default_datagroup

# explore: campaigns {}
#
# explore: campaigns_view {}
#
# explore: emails {}
#
# explore: emails_view {}
#
# explore: landing_pages {}
#
# explore: landing_pages_view {}

explore: lead_activities {
  join: leads {
    type: left_outer
    sql_on: ${lead_activities.lead_id} = ${leads.id} ;;
    relationship: many_to_one
  }
}

# explore: lead_activities_view {
#   join: leads {
#     type: left_outer
#     sql_on: ${lead_activities_view.lead_id} = ${leads.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lead_activity_attributes {}
#
# explore: lead_activity_attributes_view {}
#
# explore: lead_activity_type_attributes {}
#
# explore: lead_activity_type_attributes_view {}
#
# explore: lead_activity_types {}
#
# explore: lead_activity_types_view {}
#
# explore: leads {}
#
# explore: leads_view {}
#
# explore: lists {}
#
# explore: lists_view {}
#
# explore: programs {}
#
# explore: programs_view {}
#
# explore: segmentations {}
#
# explore: segmentations_view {}
#
# explore: segments {
#   join: segmentations {
#     type: left_outer
#     sql_on: ${segments.segmentation_id} = ${segmentations.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: segments_view {
#   join: segmentations {
#     type: left_outer
#     sql_on: ${segments_view.segmentation_id} = ${segmentations.id} ;;
#     relationship: many_to_one
#   }
# }
