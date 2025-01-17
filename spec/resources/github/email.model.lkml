connection: "snowflake"

# include all the views
include: "*.view"

######datagroups for caching and PDT rebuilds
datagroup: daily {
  sql_trigger: SELECT CURRENT_DATE ;;
  max_cache_age: "30 hours"
}

datagroup: monthly {
#   sql_trigger: SELECT max(id) from pcd_log ;;
sql_trigger: select DATE_TRUNC('month',CURRENT_DATE()) ;;
max_cache_age: "840 hours"
}

persist_with: daily

explore: email_detail {
  from: email_event
  view_label: "[Measures] Email Event"
  description: "For detailed reporting on specific email events (sends, opens, clicks, bounce, spam, unsub). One row per event per user per send. Only use this if you really need that level of detail."
  join: event_date {
    view_label: "[Attributes] Date of Event"
    from: calendar_date
    type:  inner
    sql_on: ${email_detail.event_date} = ${event_date.calendar_date};;
    relationship: many_to_one
    fields: [event_date.calendar_date
            ,event_date.calendar_week
            ,event_date.calendar_month
            ,event_date.calendar_month_name
            ,event_date.calendar_year
            ,event_date.calendar_day_of_month
            ,event_date.calendar_month_num
            ,event_date.is_last_day_of_month
            ]
  }
  join: send_date {
    view_label: "[Attributes] Date Sent"
    from: calendar_date
    type:  inner
    sql_on: ${email_detail.send_date} = ${send_date.calendar_date} ;;
    relationship: many_to_one
    fields: [send_date.calendar_date
            ,send_date.calendar_week
            ,send_date.calendar_month
            ,send_date.calendar_month_name
            ,send_date.calendar_year
            ,send_date.calendar_day_of_month
            ,send_date.calendar_month_num
            ,send_date.is_last_day_of_month
            ]
  }
  join: send_date_pop {
    view_label: "[ZZZ - BI Only] Date Sent POP"
    from: calendar_date
    type:  inner
    sql_on: ${email_detail.send_date} = ${send_date_pop.calendar_date} ;;
    relationship: many_to_one
  }
  join:  send_jobs {
    type: left_outer
    view_label: "[Attributes] Email"
    sql_on: ${email_detail.client_id} = ${send_jobs.client_id}
        and ${email_detail.send_id} = ${send_jobs.send_id};;
    relationship: many_to_one
  }
  join: email_send_job_newsletter_bridge {
    type:  left_outer
    sql_on: ${send_jobs.send_id} = ${email_send_job_newsletter_bridge.send_id} ;;
    relationship: one_to_many
  }
  join: newsletter_lookup {
    view_label: "[Attributes] Newsletter (List)"
    type:  left_outer
    sql_on: case when ${send_jobs.newsletter_id} = ${newsletter_lookup.newsletter_id} then True
                 when ${email_send_job_newsletter_bridge.newsletter_id} = ${newsletter_lookup.newsletter_id} then True
                else False
                end;;
    relationship: many_to_one
    fields: [newsletter_lookup.description
            ,newsletter_lookup.newsletter_id
            ,newsletter_lookup.list_type
            ,newsletter_lookup.newsletter
            ,newsletter_lookup.preference_code
            ,newsletter_lookup.public]
  }
  join: sender_profile {
    type: left_outer
    sql_on: ${send_jobs.from_email} = ${sender_profile.from_email}
        and ${send_jobs.from_name} = ${sender_profile.from_name} ;;
    relationship: many_to_one
  }
  join: brand {
    from: aim_brand
    view_label: "[Attributes] Brand & Group"
    type: left_outer
    sql_on: ${sender_profile.brand_id} = ${brand.brand_id} ;;
    relationship: many_to_one
    fields: [brand.brand_name, brand.brand_is_active]
  }
  join: group {
    from: aim_group
    view_label: "[Attributes] Brand & Group"
    type: left_outer
    sql_on: ${sender_profile.group_id} = ${group.id} ;;
    relationship: many_to_one
    fields: [group.group_name]
  }
  join: email_summary {
    from: email_summary
    view_label: "[Rollup Measures] Email Send Job"
    type:  left_outer
    sql_on: ${send_jobs.send_id} = ${email_summary.send_id} ;;
    relationship: one_to_one
  }
  join: email_newsletter_summary {
    view_label: "[Rollup Measures] Newsletter by Day"
    type:  left_outer
    sql_on: ${email_send_job_newsletter_bridge.newsletter_id} = ${email_newsletter_summary.newsletter_id}
        and ${email_send_job_newsletter_bridge.newsletter_id} is not null ;;
    relationship: one_to_many
  }
  join: all_subscribers {
    view_label: "[Attributes] Email Subscriber"
    type:  left_outer
    sql_on: ${email_detail.subscriber_id} = ${all_subscribers.subscriber_id} ;;
    relationship: many_to_one
  }
}

explore: email_summary {
  from: email_summary
  description: "For rollup reporting on email sends. One row per email job."
  join:  lists {
    type: left_outer
    sql_on: ${email_summary.list_id} = ${lists.list_id};;
    relationship: many_to_one
  }
  join:  send_jobs {
    type: left_outer
    view_label: "[Attributes] Email"
    sql_on: ${email_summary.send_id} = ${send_jobs.send_id};;
    relationship: many_to_one
  }
  join: send_date {
    view_label: "Date [Sent]"
    from: calendar_date
    type:  inner
    sql_on: ${send_jobs.sent_time}::date = ${send_date.calendar_date} ;;
    relationship: many_to_one
    fields: [send_date.calendar_date
      ,send_date.calendar_week
      ,send_date.calendar_month
      ,send_date.calendar_month_name
      ,send_date.calendar_year
      ,send_date.calendar_day_of_month
      ,send_date.calendar_month_num
      ,send_date.is_last_day_of_month
    ]
  }
  join: send_date_pop {
    view_label: "[ZZZ - BI Only] Date Sent POP"
    from: calendar_date
    type:  inner
    sql_on: ${send_jobs.sent_time}::date = ${send_date_pop.calendar_date} ;;
    relationship: many_to_one
  }
  join: email_send_job_newsletter_bridge {
    type:  left_outer
    sql_on: ${send_jobs.send_id} = ${email_send_job_newsletter_bridge.send_id} ;;
    relationship: one_to_many
  }
  join: newsletter_lookup {
    type:  left_outer
    view_label: "[Attributes] Newsletter (List)"
    sql_on: ${email_send_job_newsletter_bridge.newsletter_id} = ${newsletter_lookup.newsletter_id};;
    relationship: one_to_many
    fields: [newsletter_lookup.description
      ,newsletter_lookup.newsletter_id
      ,newsletter_lookup.list_type
      ,newsletter_lookup.newsletter
      ,newsletter_lookup.preference_code
      ,newsletter_lookup.public]
  }
  join: sender_profile {
    type: left_outer
    sql_on: ${send_jobs.from_email} = ${sender_profile.from_email}
      and ${send_jobs.from_name} = ${sender_profile.from_name} ;;
    relationship: many_to_one
  }
  join: brand {
    from: aim_brand
    view_label: "[Attributes] Brand & Group"
    type: left_outer
    sql_on: ${sender_profile.brand_id} = ${brand.brand_id} ;;
    relationship: many_to_one
  }
  join: group {
    from: aim_group
    view_label: "[Attributes] Brand & Group"
    type: left_outer
    sql_on: ${sender_profile.group_id} = ${group.id} ;;
    relationship: many_to_one
  }
}


explore: newsletter_summary {
  from: email_newsletter_summary
  description: "For rollup reporting on newsletter (list) level performace over time. One row per newsletter per day that had sends."
  join: send_date {
    view_label: "Date [Sent]"
    from: calendar_date
    type:  inner
    sql_on: ${newsletter_summary.daydate}::date = ${send_date.calendar_date} ;;
    relationship: many_to_one
  }
  join: send_date_pop {
    view_label: "[ZZZ - BI Only] Date Sent POP"
    from: calendar_date
    type:  inner
    sql_on: ${newsletter_summary.daydate}::date = ${send_date_pop.calendar_date} ;;
    relationship: many_to_one
  }
  join: email_send_job_newsletter_bridge {
    type:  left_outer
    sql_on: ${newsletter_summary.newsletter_id} = ${email_send_job_newsletter_bridge.newsletter_id} ;;
    relationship: one_to_many
  }
  join:  send_jobs {
    type: left_outer
    view_label: "[Attributes] Email"
    sql_on: ${email_send_job_newsletter_bridge.send_id} = ${send_jobs.send_id};;
    relationship: many_to_one
  }
  join: newsletter_lookup {
    view_label: "[Attributes] Newsletter (List)"
    type:  left_outer
    sql_on: ${newsletter_summary.newsletter_id} = ${newsletter_lookup.newsletter_id};;
    relationship: one_to_many
  }
  join: sender_profile {
    type: left_outer
    sql_on: ${send_jobs.from_email} = ${sender_profile.from_email}
      and ${send_jobs.from_name} = ${sender_profile.from_name} ;;
    relationship: many_to_one
  }
  join: brand {
    from: aim_brand
    view_label: "[Attributes] Brand & Group"
    type: left_outer
    sql_on: ${sender_profile.brand_id} = ${brand.brand_id} ;;
    relationship: many_to_one
  }
  join: group {
    from: aim_group
    view_label: "[Attributes] Brand & Group"
    type: left_outer
    sql_on: ${sender_profile.group_id} = ${group.id} ;;
    relationship: many_to_one
  }
}

explore: newsletters {
#   persist_with: default
  from: newsletter_lookup
  description: "Information on Newsletters (lists). Includes subscriber counts, list name, list type, etc."
  view_label: "Newsletter (Newsletter Lookup)"
  join:  subscriber_newsletters {
    view_label: "Email Opt-Ins (Sub News)"
    type: left_outer
    sql_on: ${newsletters.newsletter_id} = ${subscriber_newsletters.newsletter_id};;
    relationship: one_to_many
  }
  join:  subscriber_master {
    type: left_outer
    view_label: "Customer (Sub Master)"
    sql_on: lower(${subscriber_newsletters.subscriber_key}) = lower(${subscriber_master.subscriber_key});;
    relationship: one_to_many
  }
  join:  subscriber_newsletters2 {
    from: subscriber_newsletters
    view_label: "Overlap"
    type: left_outer
    sql_on: lower(${subscriber_newsletters.subscriber_key}) = lower(${subscriber_newsletters2.subscriber_key});;
    fields: [subscriber_newsletters2.unique_subscribers, subscriber_newsletters2.subscribers]
    relationship: one_to_many
  }
  join:  newsletter_lookup2 {
    from: newsletter_lookup
    view_label: "Overlap"
    type: left_outer
    sql_on: ${subscriber_newsletters2.newsletter_id} = ${newsletter_lookup2.newsletter_id};;
    fields: [newsletter_lookup2.brand_code, newsletter_lookup2.newsletter,newsletter_lookup2.list_type, newsletter_lookup2.newsletter_id]
    relationship: many_to_one
  }
  join: brand {
    from: aim_brand
    type: left_outer
    sql_on: ${newsletters.brand_code} = ${brand.brand_code} ;;
    relationship: many_to_one
  }
  join: group {
    from: aim_group
    type: left_outer
    sql_on: ${brand.group_id} = ${group.id} ;;
    relationship: many_to_one
  }
}
explore: aim_optouts {
#   persist_with: default
  from: optouts_master
  description: "Information on Optouts by Email and Newsletter_ID"
  view_label: "Optouts (OptOuts_Master)"
  join:  newsletter_lookup {
    type: left_outer
    view_label: "Newsletter (Newsletter_Lookup)"
    sql_on: lower(${aim_optouts.newsletter_id}) = lower(${newsletter_lookup.newsletter_id});;
    relationship: many_to_one
  }
  join: brand {
    from: aim_brand
    view_label: "[Attributes] Brand & Group"
    type: left_outer
    sql_on: ${newsletter_lookup.brand_code} = ${brand.brand_code} ;;
    relationship: many_to_one
  }
}
explore: list_subscribers {
    from:  list_subscribers
    description: "Information on Business Unit Level Status"
    view_label: "Business Unit Status"
}
explore: all_subscribers {
  from:  all_subscribers
  description: "Information on AIM Parent Level Status"
  view_label: "AIM Parent Status"
  }
