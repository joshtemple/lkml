connection: "currents_connection"

# Views
include: "users_behaviors_app_firstsession.view.lkml"
include: "users_behaviors_app_sessionstart.view.lkml"
#include: "users_behaviors_app_sessionend.view.lkml"
#include: "users_behaviors_customevent.view.lkml"
#include: "users_behaviors_installattribution.view.lkml"
#include: "users_behaviors_location.view.lkml"
#include: "users_behaviors_purchase.view.lkml"

# Dashboards
include: "daily_retention_chart.dashboard"
include: "daily_retention_graph.dashboard"
include: "weekly_retention_chart.dashboard"
include: "weekly_retention_graph.dashboard"
include: "28_day_retention.dashboard"

# Attribution Events
# explore: users_behaviors_installattribution {
#   label: "Attribution Events"
#   view_label: "Attribution Events"
# }

# Custom Events
# explore: users_behaviors_customevent {
#   label: "Custom Events"
#   view_label: "Custom Events"
# }

# Location
# explore: users_behaviors_location {
#   label: "Location Events"
#   view_label: "Location Events"
# }

# Purchase Events
# explore: users_behaviors_purchase {
#   label: "Purchase Events"
#   view_label: "Purchase Events"
# }

# Sessions for Retention
explore: users_behaviors_app_sessionstart {
  label: "Sessions"
  view_label: "Session Start Events"
  join: users_behaviors_app_firstsession {
    view_label: "First Session Events"
    type: left_outer
    relationship: many_to_one
    sql_on: ${users_behaviors_app_sessionstart.user_id}=${users_behaviors_app_firstsession.user_id}
            AND
            ${users_behaviors_app_firstsession.app_id}=${users_behaviors_app_sessionstart.app_id};;
  }

# Session End Events
# explore: users_behaviors_app_sessionend {
#   label: "Session End Events"
#   view_label: "Session End Events"
# }

}
