label: "Email Performance(sales)"

connection: "edwrpt"

case_sensitive: no

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: em_event_f {
  label: "Email Sends"
  description: "Email send measures w/sales attribution by Business Unit, Email, List, Subscriber, etc."
  view_label: "1) Measures"
  persist_for: "8 hours"
  always_join: [em_email_dm]

  join: send_date_dm {
    from: date_dm
    view_label: "2) Date Sent"
    sql_on: ${send_date_dm.date_sid} = ${em_event_f.send_date_sid} ;;
    type: inner
    relationship: many_to_one
  }

  join: event_date_dm {
    from: date_dm
    view_label: "3) Date of Event"
    sql_on: ${event_date_dm.date_sid} = ${em_event_f.event_date_sid} ;;
    type: inner
    relationship: many_to_one
  }

  join: email_sales_channel_dm {
    from: sales_channel_dm
    view_label: "4) Sales Channel(Email)"
    sql_on: ${email_sales_channel_dm.sales_channel_shk} = ${em_event_f.email_sales_channel_shk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: order_sales_channel_dm {
    from: sales_channel_dm
    view_label: "5) Sales Channel(Orders)"
    sql_on: ${order_sales_channel_dm.sales_channel_shk} = ${em_event_f.order_sales_channel_shk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: em_attribution_type_dm {
    view_label: "Sales Attribution Type"
    sql_on: ${em_attribution_type_dm.em_attribution_type_sid} = ${em_event_f.em_attribution_type_sid} ;;
    type: inner
    relationship: many_to_one
  }

  join: em_email_dm {
    view_label: "Email"
    sql_on: ${em_email_dm.em_email_shk} = ${em_event_f.em_email_shk} and lower( ${em_email_dm.subject_line} ) not like 'test send%' and lower( ${em_email_dm.subject_line} ) not like '[test send%' ;;
    type: inner
    relationship: many_to_one
  }

  join: em_event_type_dm {
    view_label: "Email Event"
    sql_on: ${em_event_type_dm.em_event_type_sid} = ${em_event_f.em_event_type_sid} ;;
    type: inner
    relationship: many_to_one
  }

  join: em_list_dm {
    view_label: "List"
    sql_on: ${em_list_dm.em_list_shk} = ${em_event_f.em_list_shk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: em_subscriber_dm {
    view_label: "Subscriber"
    sql_on: ${em_subscriber_dm.em_subscriber_shk} = ${em_event_f.em_subscriber_shk} and ${em_subscriber_dm.em_bu_shk} = ${em_event_f.em_bu_shk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: elapsed_day_dm {
    view_label: "Elapsed Days"
    sql_on: ${elapsed_day_dm.elapsed_day_sid} = ${em_event_f.elapsed_day_sid} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: em_list_membership_dm {
    view_label: "List Subscriber"
    sql_on: ${em_list_membership_dm.em_list_membership_shk} = ${em_event_f.em_list_membership_shk} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: em_bu_dm {
    view_label: "Business Unit"
    sql_on: ${em_bu_dm.em_bu_shk} = ${em_event_f.em_bu_shk} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: em_list_subscriber_rpt {
  label: "List Subscribers"
  description: "Email subscriber list sizes by Business Unit, Engagement Status & Aging, List, etc."
  view_label: "1) Measures"
  persist_for: "8 hours"

  always_filter: {
    filters: {
      field: engagement_cd
      value: "Engaged"
    }
  }

  join: em_bu_dm {
    view_label: "Business Unit"
    sql_on: ${em_bu_dm.src_client_id} = ${em_list_subscriber_rpt.client_id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: em_list_membership_dm {
    view_label: "List Subscriber"
    sql_on: ${em_list_membership_dm.src_client_id}     = ${em_list_subscriber_rpt.client_id} and   ${em_list_membership_dm.src_list_id}       = ${em_list_subscriber_rpt.list_id} and   ${em_list_membership_dm.src_subscriber_id} = ${em_list_subscriber_rpt.subscriber_id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: em_subscriber_dm {
    view_label: "Subscriber"
    sql_on: ${em_subscriber_dm.src_subscriber_id} = ${em_list_subscriber_rpt.subscriber_id} and ${em_subscriber_dm.src_client_id} = ${em_list_subscriber_rpt.client_id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: em_list_dm {
    view_label: "List"
    sql_on: ${em_list_dm.src_list_id} = ${em_list_subscriber_rpt.list_id} ;;
    type: left_outer
    relationship: many_to_one
  }
}
