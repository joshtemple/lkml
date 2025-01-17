connection: "kiwi_iterable"

# include all the views
include: "*.view"

datagroup: kiwi_iterable_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kiwi_iterable_default_datagroup

#explore: email_bounced {}

#explore: email_bounced_view {}

explore: email_delivered {
  label: "Email Delivered"
  join: email_opened {
    view_label: "Email Opened"
    type: left_outer
    sql_on: ${email_delivered.message_id} = ${email_opened.message_id} ;;
    relationship: many_to_many
  }
  join: email_link_clicked {
    view_label: "Email Link Clicked"
    type: left_outer
    sql_on: ${email_delivered.message_id} = ${email_link_clicked.message_id} ;;
    relationship: many_to_many
  }
  join: email_bounced {
    view_label: "Email Bounced"
    type: full_outer
    sql_on: ${email_delivered.message_id} = ${email_bounced.message_id} ;;
    relationship: many_to_many
  }
  join: unsubscribed{
    type: left_outer
    sql_on: ${email_delivered.email} =${unsubscribed.email}  AND ${email_delivered.message_id} = ${unsubscribed.message_id};;
    relationship: many_to_many
  }
}

explore: web_push_delivered {}

explore: sms_delivered {
#   join: sms_received {
#     type: full_outer
#     sql_on: ${sms_delivered.id}=${sms_received.id} ;;
#     relationship: many_to_many
#   }
  join: sms_bounced {
    type: full_outer
    sql_on:  ${sms_delivered.campaign_id}=${sms_bounced.campaign_id} ;;
    relationship: many_to_many
  }
}


explore: sendgrid_delivered_view {
}

#explore: email_delivered_view {}

explore: email_link_clicked {}

#explore: email_link_clicked_view {}

explore: email_marked_as_spam {}

#explore: email_marked_as_spam_view {}

explore: email_opened {}

#explore: email_opened_view {}

explore: subscribed {}

#explore: subscribed_view {}

explore: tracks {}

#explore: tracks_view {}

explore: unsubscribed {}

#explore: unsubscribed_view {}
