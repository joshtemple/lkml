include: "*.view" # include all the views


########################################################################################
# Web Analytics Tool Explore
########################################################################################
explore: data_tool {
  hidden: yes
  label: "Web Analytics Data Tool"

  join: sessions {
    from: sessions_webanalytics
    fields: [sessions.session_id, sessions.session_start_date, sessions.is_bounce_session, sessions.count_purchase, session_end_date, sessions.duration, sessions.duration_seconds_tier, sessions.average_duration, sessions.count, sessions.count_bounce_sessions, sessions.percent_bounce_sessions, sessions.overall_conversion, sessions.furthest_funnel_step]
    sql_on: ${data_tool.session_id} =  ${sessions.session_id} ;;
    relationship: many_to_one
  }

  join: users {
    sql_on: ${sessions.session_user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_order_facts {
    sql_on: ${users.id} = ${user_order_facts.user_id} ;;
    relationship: one_to_one
    view_label: "Users"
  }
}



####################################################################################
# Dynamic Fields
# https://looker.com/platform/blocks/data-tool/web-analytics
####################################################################################

view: data_tool {
  extends: [events]
  view_label: "Events"


parameter: timeframe_filter {
  view_label: "Data Tool"
  allowed_value: { value: "Date" }
  allowed_value: { value: "Week" }
  allowed_value: { value: "Month" }
}

dimension: timeframe {
  view_label: "Data Tool"
  sql: CASE
          WHEN {% parameter timeframe_filter %} = 'Date' THEN ${event_date}::varchar
          WHEN {% parameter timeframe_filter %} = 'Week' THEN ${event_week}
          WHEN {% parameter timeframe_filter %} = 'Month' THEN ${event_month}
        END ;;
  label_from_parameter: timeframe_filter
  drill_fields: [os, browser, event_type]
}


parameter: primary_metric_filter {
  view_label: "Data Tool"
  allowed_value: { value: "Users" }
  allowed_value: { value: "Visitors" }
  allowed_value: { value: "Sessions" }
  allowed_value: { value: "Orders" }
  default_value: "Users"
}

measure: primary_metric {
  type: number
  view_label: "Data Tool"
  sql: CASE
          WHEN {% parameter primary_metric_filter %} = 'Users' THEN ${users.count}
          WHEN {% parameter primary_metric_filter %} = 'Visitors' THEN ${unique_visitors}
          WHEN {% parameter primary_metric_filter %} = 'Sessions' THEN ${sessions.count}
          WHEN {% parameter primary_metric_filter %} = 'Orders' THEN ${sessions.count_purchase}
        END ;;
  label_from_parameter: primary_metric_filter
  drill_fields: [detail*]
}

parameter: second_metric_filter {
  view_label: "Data Tool"
  allowed_value: { value: "Bounces" }
  allowed_value: { value: "Bounce Rate" }
  allowed_value: { value: "Conversion Rate" }
  default_value: "Conversion Rate"
}

measure: second_metric {
  type: number
  view_label: "Data Tool"
  sql: CASE
          WHEN {% parameter second_metric_filter %} = 'Bounces' THEN ${sessions.count_bounce_sessions}
          WHEN {% parameter second_metric_filter %} = 'Bounce Rate' THEN round((100.0 * ${sessions.percent_bounce_sessions}),2)
          WHEN {% parameter second_metric_filter %} = 'Conversion Rate' THEN round((100.0 * ${sessions.conversion_rate}),2)
        END ;;
  html: {% if metric_name._value contains 'Rate' or metric_name._value contains 'Users'  %}
            {{ linked_value }}{{ format_symbol._value }}
          {% else %}
            {{ format_symbol._value }}{{ linked_value }}
          {% endif %} ;;
  label_from_parameter: second_metric_filter
  drill_fields: [detail*]
}


set: detail {
  fields: [
    event_date,
    users.count,
    unique_visitors,
    sessions.count,
    sessions.count_bounce_sessions,
    sessions.percent_bounce_sessions,
    sessions.conversion_rate,
    sessions.orders
  ]
}




################################################################
# Used for dynamically applying a format to the metric parameter
################################################################
dimension: metric_name {
  hidden: yes
  type: string
  sql: CASE
          WHEN {% parameter second_metric_filter %} = 'Bounces' THEN 'Bounces'
          WHEN {% parameter second_metric_filter %} = 'Bounce Rate' THEN 'Bounce Rate'
          WHEN {% parameter second_metric_filter %} = 'Conversion Rate' THEN 'Conversion Rate'
          WHEN {% parameter second_metric_filter %} = '% New Users' THEN '% New Users'
          ELSE NULL
        END ;;
}

dimension: format_symbol {
  hidden: yes
  sql:
        CASE
          WHEN ${metric_name} IN ('Bounce Rate','Conversion Rate','% New Users') THEN '%'
        END ;;
}



}






################################################################
# Change view labels for a few fields
################################################################

view: sessions_webanalytics {
  extends: [sessions]

  measure: conversion_rate {
    view_label: "Sessions"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${count_purchase} / nullif(${count},0) ;;
    drill_fields: [count_purchase, count, overall_conversion]
  }

  measure: count_purchase {
    view_label: "Sessions"
    label: "Orders"
#     hidden: yes
    type: count
    filters: {
      field: furthest_funnel_step
      value: "(5) Purchase"
    }
    drill_fields: [detail*]
  }

}
