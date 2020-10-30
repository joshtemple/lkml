include: "session_purchase_facts.view.lkml"         # include all views in this project
view: session_attribution {
  extends: [session_purchase_facts]

  dimension: percent_attribution_per_session {
    view_label: "Sessions"
    description: "Associated Weight (%) from sales based on a linear multi-touch source attribution"
    type: number
    sql: 1.0/nullif(${sessions_till_purchase},0 );;
    drill_fields: [detail*]
  }

  dimension: contains_search {
    view_label: "Ad Events"
    label: "Sessions leading up to Purchase contains search"
    type: yesno
    sql: ${TABLE}.search_session_count > 0 ;;
  }

  measure: conversions_from_search {
    view_label: "Ad Events"
    description: "All Conversions with Traffic Source *Search* as a touch point"
    type: count_distinct
    sql: ${session_purchase_facts.order_id} ;;
    filters: {
      field: contains_search
      value: "yes"
    }
  }

  dimension: attribution_per_session {
    view_label: "Sessions"
    description: "Associated Revenue ($) from sales based on a linear multi-touch source attribution"
    hidden: yes
    type: number
    sql: 1.0 * ${sale_price}/nullif(${sessions_till_purchase},0 );;
    value_format_name: usd
    drill_fields: [metric_drill*]
  }

  measure: total_attribution {
    view_label: "Sessions"
    label: "Associated Revenue"
    description: "The total revenue associated with these sessions"
    type: sum_distinct
    sql_distinct_key: ${sessions.session_id} ;;
    sql: ${attribution_per_session} ;;
    value_format_name: usd
    drill_fields: [metric_drill*]
  }

  measure: ROI {
    view_label: "Sessions"
    label: "Percent ROI"
    description: "Associated revenue divided by the total cost"
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${total_attribution}/ NULLIF(${adevents.total_cost},0) - 1 ;;
  }

  measure: net_roi {
    view_label: "Sessions"
    label: "Net Revenue"
    description: "Associated revenue minus total associated cost"
    type: number
    value_format_name: usd
    sql:  ${total_attribution}-${adevents.total_cost} ;;
  }





#   ----------------------------------------------------  #

  parameter: attribution_filter {
    view_label: "Cohort"
    label: "Attribution Picker"
    description: "Choose a type of Attribution"
    allowed_value: { value: "First Touch" }
    allowed_value: { value: "Last Touch" }
    allowed_value: { value: "Multi-Touch Linear" }
  }

  dimension: attribution_source {
    view_label: "Cohort"
    type: string
    description: "Use in conjuction with the Attribution Picker"
    sql: CASE
          WHEN {% parameter attribution_filter %} = 'First Touch' THEN ${user_session_fact.site_acquisition_source}
          WHEN {% parameter attribution_filter %} = 'Last Touch' THEN ${purchase_session_source}
          WHEN {% parameter attribution_filter %} = 'Multi-Touch Linear' THEN ${sessions.traffic_source}
          ELSE NULL
        END ;;
      label_from_parameter: attribution_filter
    }

  dimension_group: last_session_end {
#     hidden: yes
    label: "Purchase Start Session"
    view_label: "Sessions"
    type: time
    timeframes: [raw, time, date, week, quarter, month]
    sql: ${TABLE}.last_session_end;;
  }
  dimension_group: session_end {
    type: time
    view_label: "Sessions"
    label: "Purchase End Session"
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.session_end ;;
  }

  set: attribution_detail {
    fields: [
      last_session_end_month,
      last_session_end_quarter,
      session_end_month,
      attribution_per_session,
      total_attribution,
      ROI,
      attribution_filter,
      attribution_source,
    ]
  }

  set: metric_drill {
    fields: [
      campaigns.campaign_name,
      adevents.total_cost,
      sessions.purchases,
      total_attribution,
      events.bounce_rate
    ]
  }
}
