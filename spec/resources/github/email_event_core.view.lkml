include: "//@{CONFIG_PROJECT_NAME}/email_event.view.lkml"


view: email_event {
  extends: [email_event_config]
}

###################################################

view: email_event_core {
  sql_table_name: @{DATASET_NAME}.EMAIL_EVENT ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    description: "A randomly-generated ID for this event."
  }

  dimension: app_id {
    type: number
    sql: ${TABLE}.app_id ;;
    hidden: yes
    description: "An ID referencing the HubSpot application that sent the email message."
  }

  dimension: app_name {
    type: string
    sql: ${TABLE}.app_name ;;
    description: "The name of the HubSpot application that sent the email message. Note that this is a derived value, and may be modified at any time."
  }

  dimension: caused_by_created {
    type: string
    sql: ${TABLE}.caused_by_created ;;
  }

  dimension: caused_by_id {
    type: number
    sql: ${TABLE}.caused_by_id ;;
    description: "The EventId which uniquely identifies the event which directly caused this event. If not applicable, this property is omitted."
  }

  dimension: email_campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.email_campaign_id ;;
    description: "An ID referencing the email campaign which the email message is part of."
  }

  dimension: obsoleted_by_created {
    type: string
    sql: ${TABLE}.obsoleted_by_created ;;
  }

  dimension: obsoleted_by_id {
    type: number
    sql: ${TABLE}.obsoleted_by_id ;;
    description: "The Event ID which uniquely identifies the follow-on event which makes this current event obsolete. If not applicable, this property is omitted."
  }

  dimension: portal_id {
    type: number
    hidden: yes
    sql: ${TABLE}.portal_id ;;
    description: "An ID referencing the HubSpot account that sent the email message. This will correspond to your account."
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
    description: "The email address of the recipient of the email message."
  }

  dimension: sent_by_created {
    type: string
    sql: ${TABLE}.sent_by_created ;;
  }

  dimension: sent_by_id {
    type: number
    sql: ${TABLE}.sent_by_id ;;
    hidden: yes
    description: "The Event ID which uniquely identifies the email message's SENT event. If not applicable, this property is omitted."
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
    description: "The type of event."
  }

  dimension: caused_subscription_change {
    type: yesno
    sql: CASE WHEN ${email_subscription_change.caused_by_event_id} IS NOT NULL THEN TRUE ELSE FALSE END ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    sql:  ${TABLE}.created ;;
    description: "The timestamp (in milliseconds since epoch) when this event was created."
  }

  measure: count {
    type: count
    drill_fields: [id, app_name, email_campaign.app_name, email_campaign.name, email_campaign.id]
  }

  measure: undelivered_count {
    type: number
    sql: ${email_event_bounce.count} + ${email_event_dropped.count} + ${email_event_deferred.count} ;;
  }

  measure: first_touch {
    type: date
    sql: MIN(${created_raw}) ;;
  }

  measure: last_touch {
    type: date
    sql: MAX(${created_raw}) ;;
  }

  measure: total_recip_openers  {
    type: count_distinct
    sql: ${recipient} ;;
    filters: [type: "OPEN"]
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: total_recip_clicks  {
    type: count_distinct
    sql: ${recipient} ;;
    filters: [type: "CLICK"]
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: total_recip_delivered  {
    type: count_distinct
    sql: ${recipient} ;;
    filters: [type: "DELIVERED"]
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: total_recip_sent  {
    type: count_distinct
    sql: ${recipient} ;;
    filters: [type: "SENT"]
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: total_recip_deferred  {
    type: count_distinct
    sql: ${recipient} ;;
    filters: [type: "DEFERRED"]
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: total_recip_dropped  {
    type: count_distinct
    sql: ${recipient} ;;
    filters: [type: "DROPPED"]
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: total_recip_bounced  {
    type: count_distinct
    sql: ${recipient} ;;
    filters: [type: "BOUNCED"]
    hidden: yes   # surfaced in the email event attribute view
  }


  measure: open_ratio {
    type: number
    value_format_name: percent_2
    sql: 1*${total_recip_openers}/nullif(${total_recip_sent},0) ;;
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: click_ratio {
    type: number
    value_format_name: percent_2
    sql: 1*${total_recip_clicks}/nullif(${total_recip_sent},0) ;;
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: delivered_ratio {
    type: number
    value_format_name: percent_2
    sql: 1*${total_recip_delivered}/nullif(${total_recip_sent},0) ;;
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: deferred_ratio {
    type: number
    value_format_name: percent_2
    sql: 1*${total_recip_deferred}/nullif(${total_recip_sent},0) ;;
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: dropped_ratio {
    type: number
    value_format_name: percent_2
    sql: 1*${total_recip_dropped}/nullif(${total_recip_sent},0) ;;
    hidden: yes   # surfaced in the email event attribute view
  }
  measure: bounced_ratio {
    type: number
    value_format_name: percent_2
    sql: 1*${total_recip_bounced}/nullif(${total_recip_sent},0) ;;
    hidden: yes   # surfaced in the email event attribute view
  }
}
