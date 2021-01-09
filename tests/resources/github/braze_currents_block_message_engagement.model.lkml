#########################
# Connection
#########################
connection: "currents_connection"

#########################
# Conversion Views
#########################
include: "users_campaigns_conversion.view.lkml"
include: "users_campaigns_enrollincontrol.view.lkml"
include: "users_canvas_conversion.view.lkml"
include: "users_canvas_entry.view.lkml"


#########################
# Email Views
#########################
include: "users_messages_email_bounce.view.lkml"
include: "users_messages_email_click.view.lkml"
include: "users_messages_email_delivery.view.lkml"
include: "users_messages_email_markasspam.view.lkml"
include: "users_messages_email_open.view.lkml"
include: "users_messages_email_send.view.lkml"
include: "email_messaging_cadence.view"
include: "email_messaging_frequency.view"
include: "users_messages_email_softbounce.view.lkml"
include: "users_messages_email_unsubscribe.view.lkml"


#########################
# IAM Views
#
# Note: Uncomment the block below when doing In-App Message analytics
#########################
# include: "users_messages_inappmessage_click.view.lkml"
# include: "users_messages_inappmessage_impression.view.lkml"
#
#########################


#########################
# Newsfeed Views
#
# Note: Uncomment the block below when doing Newsfeed analytics
#########################
#
# include: "users_behaviors_app_newsfeedimpression.view.lkml"
# include: "users_messages_newsfeedcard_click.view.lkml"
# include: "users_messages_newsfeedcard_impression.view.lkml"
#
#########################


#########################
# Push Views
#########################
include: "users_messages_pushnotification_bounce.view.lkml"
include: "users_messages_pushnotification_iosforeground.view.lkml"
include: "users_messages_pushnotification_open.view.lkml"
include: "users_messages_pushnotification_send.view.lkml"
include: "push_messaging_frequency.view"
include: "push_messaging_cadence.view"


#########################
# Uninstall Views
#
# Note: Uncomment the block below when doing Uninstall analytics
#########################
# include: "users_behaviors_uninstall.view.lkml"
#
#########################


#########################
# Webhook Views
#
# Note: Uncomment the block below when doing Webhook message analytics
#########################
#
# include: "users_messages_webhook_send.view.lkml"
#
#########################


#########################
# Dashboards
#########################
include: "email_funnel.dashboard"
include: "push_funnel.dashboard"
include: "email_performance_dashboard.dashboard"
include: "message_engagement_dashboard.dashboard"
include: "email_marketing_pressure.dashboard"
include: "push_marketing_pressure.dashboard"

#########################
# Campaign Conversions Explore
#
# Note: Uncomment the block below when doing Campaign Conversion analytics
#########################
# explore: users_campaigns_conversion {
#   label: "Campaign Conversions"
#   view_label: "Campaign Conversions"
#   join: users_campaigns_enrollincontrol { # only joining so we can have a "user in control" dimension--all its dimensions are hidden"
#     view_label: "Enrolled in Control"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${users_campaigns_conversion.user_id}=${users_campaigns_enrollincontrol.user_id}
#             AND
#             ${users_campaigns_conversion.message_variation_id}=${users_campaigns_enrollincontrol.message_variation_id};;
#   }
# }
#
#########################


#########################
# Canvas Conversions Explore
#
# Note: Uncomment the block below when doing Canvas Conversion analytics
#########################
# explore: users_canvas_conversion {
#   label: "Canvas Conversions"
#   view_label: "Canvas Conversions"
#   join: users_canvas_entry {
#     view_label: "Canvas Conversions"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${users_canvas_conversion.user_id}=${users_canvas_entry.user_id}
#             AND
#             ${users_canvas_conversion.canvas_variation_id}=${users_canvas_entry.canvas_variation_id};;
#   }
# }
#
#########################


#########################
# Email Events Explore
#########################
explore: users_messages_email_send {
  label: "Email Events"
  view_label: "Emails Sent"
  join: users_messages_email_delivery {
    view_label: "Email Delivery"
    type: left_outer
    relationship: one_to_one
    sql_on: ${users_messages_email_send.email_address}=${users_messages_email_delivery.email_address}
            AND
            (${users_messages_email_send.message_variation_id}=${users_messages_email_delivery.message_variation_id}
            OR
            ${users_messages_email_send.canvas_step_id}=${users_messages_email_delivery.canvas_step_id});;
  }
  join: users_messages_email_open {
    view_label: "Email Opens"
    type: left_outer
    relationship: one_to_many
    sql_on: ${users_messages_email_send.email_address}=${users_messages_email_open.email_address}
            AND
            (${users_messages_email_send.message_variation_id}=${users_messages_email_open.message_variation_id}
            OR
            ${users_messages_email_send.canvas_step_id}=${users_messages_email_open.canvas_step_id}) ;;
  }
  join: users_messages_email_click {
    view_label: "Email Clicks"
    type: left_outer
    relationship: one_to_many
    sql_on: ${users_messages_email_send.email_address}=${users_messages_email_click.email_address}
            AND
            (${users_messages_email_send.message_variation_id}=${users_messages_email_click.message_variation_id}
            OR
            ${users_messages_email_send.canvas_step_id}=${users_messages_email_click.canvas_step_id}) ;;
  }
  join: users_messages_email_unsubscribe {
    view_label: "Email Unsubscribes"
    type: left_outer
    relationship: one_to_many
    sql_on: ${users_messages_email_send.email_address}=${users_messages_email_unsubscribe.email_address}
            AND
            (${users_messages_email_send.message_variation_id}=${users_messages_email_unsubscribe.message_variation_id}
            OR
            ${users_messages_email_send.canvas_step_id}=${users_messages_email_unsubscribe.canvas_step_id});;
  }
  join: users_messages_email_bounce {
    view_label: "Email Bounces"
    type: left_outer
    relationship: one_to_one
    sql_on: ${users_messages_email_send.email_address}=${users_messages_email_bounce.email_address}
            AND
            (${users_messages_email_send.message_variation_id}=${users_messages_email_bounce.message_variation_id}
            OR
            ${users_messages_email_send.canvas_step_id}=${users_messages_email_bounce.canvas_step_id});;
  }
  join: users_messages_email_softbounce {
    view_label: "Email Bounces"
    type: left_outer
    relationship: one_to_one
    sql_on: ${users_messages_email_send.email_address}=${users_messages_email_softbounce.email_address}
            AND
            (${users_messages_email_send.message_variation_id}=${users_messages_email_softbounce.message_variation_id}
            OR
            ${users_messages_email_send.canvas_step_id}=${users_messages_email_softbounce.canvas_step_id});;
  }
  join: users_messages_email_markasspam {
    view_label: "Emails Marked as Spam"
    type: left_outer
    relationship: one_to_one
    sql_on: ${users_messages_email_send.email_address}=${users_messages_email_markasspam.email_address}
            AND
            (${users_messages_email_send.message_variation_id}=${users_messages_email_markasspam.message_variation_id}
            OR
            ${users_messages_email_send.canvas_step_id}=${users_messages_email_markasspam.canvas_step_id});;
  }
}

#########################
# Email Marketing Pressure
#########################
explore: email_messaging_frequency {}
explore: email_messaging_cadence {}

#########################
# IAM Events Explore
#
# Note: Uncomment the block below when doing In-App Message analytics
#########################
# explore: users_messages_inappmessage_impression {
#   label: "In-App Message Events"
#   view_label: "IAM Impressions"
#   join: users_messages_inappmessage_click {
#     view_label: "IAM Clicks"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${users_messages_inappmessage_impression.user_id}=${users_messages_inappmessage_click.user_id}
#             AND
#             (${users_messages_inappmessage_impression.message_variation_id}=${users_messages_inappmessage_click.message_variation_id}
#             OR
#             ${users_messages_inappmessage_impression.canvas_step_id}=${users_messages_inappmessage_click.canvas_step_id}) ;;
#   }
# }
#
#########################


#########################
# Newsfeed Card Events Explore
#
# Note: Uncomment the block below when doing Newsfeed analytics
#########################
#
# explore: users_messages_newsfeedcard_impression {
#   label: "Newsfeed Card Events"
#   view_label: "Newsfeed Card Impressions"
#   join: users_messages_newsfeedcard_click {
#     view_label: "Newsfeed Card Clicks"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${users_messages_newsfeedcard_impression.user_id}=${users_messages_newsfeedcard_click.user_id}
#             AND
#             ${users_messages_newsfeedcard_impression.card_id}=${users_messages_newsfeedcard_click.card_id}
#             AND
#             ${users_messages_newsfeedcard_impression.device_id}=${users_messages_newsfeedcard_click.device_id};;
#   }
# }
#
#########################


#########################
# Newsfeed Impression Events Explore
#
# Note: Uncomment the block below when doing Newsfeed analytics
#########################
#
# explore: users_behaviors_app_newsfeedimpression {
#   label: "Newsfeed Impressions"
#   view_label: "Newsfeed Impressions"
# }
#
#########################


#########################
# Push Events Explore
#########################
explore: users_messages_pushnotification_send {
  label: "Push Events"
  view_label: "Push Sent"
  join: users_messages_pushnotification_open {
    view_label: "Push Opens"
    type: left_outer
    relationship: one_to_many
    sql_on: ${users_messages_pushnotification_send.user_id}=${users_messages_pushnotification_open.user_id}
            AND
            ${users_messages_pushnotification_send.device_id}=${users_messages_pushnotification_open.device_id}
            AND
            (${users_messages_pushnotification_send.message_variation_id}=${users_messages_pushnotification_open.message_variation_id}
            OR
            ${users_messages_pushnotification_send.canvas_step_id}=${users_messages_pushnotification_open.canvas_step_id}) ;;
  }
  join: users_messages_pushnotification_bounce {
    view_label: "Push Bounces"
    type: left_outer
    relationship: one_to_one
    sql_on: ${users_messages_pushnotification_send.user_id}=${users_messages_pushnotification_bounce.user_id}
            AND
            ${users_messages_pushnotification_send.device_id}=${users_messages_pushnotification_bounce.device_id}
            AND
            (${users_messages_pushnotification_send.message_variation_id}=${users_messages_pushnotification_bounce.message_variation_id}
            OR
            ${users_messages_pushnotification_send.canvas_step_id}=${users_messages_pushnotification_bounce.canvas_step_id}) ;;
  }
########################
# Note: Uncomment the block below when doing iOS foreground analytics
########################
#
#   join: users_messages_pushnotification_iosforeground {
#     view_label: "iOS Foreground Opens"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${users_messages_pushnotification_send.user_id}=${users_messages_pushnotification_iosforeground.user_id}
#             AND
#             ${users_messages_pushnotification_send.device_id}=${users_messages_pushnotification_iosforeground.device_id}
#             AND
#             (${users_messages_pushnotification_send.message_variation_id}=${users_messages_pushnotification_iosforeground.message_variation_id}
#             OR
#             ${users_messages_pushnotification_send.canvas_step_id}=${users_messages_pushnotification_iosforeground.canvas_step_id}) ;;
#   }
########################
}

#########################
# Push Marketing Pressure
#########################
explore: push_messaging_frequency {}
explore: push_messaging_cadence {}

#########################
# Uninstall Events Explore
#
# Note: Uncomment the block below when doing Uninstall analytics
#########################
# explore: users_behaviors_uninstall {
#   label: "Uninstall Events"
#   view_label: "Uninstall Events"
# }
#
#########################


#########################
# Webhook Events Explore
#
# Note: Uncomment the block below when doing Webhook message analytics
#########################
#
# explore: users_messages_webhook_send {
#   label: "Webhook Events"
#   view_label: "Webhook Send Events"
# }
#
#########################
