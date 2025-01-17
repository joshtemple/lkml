include: "/Views-Core/*.view.lkml"

view: event_registration_fact {
  sql_table_name: cidw.event_registration_fact ;;

  dimension: cancellation_date_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.cancellation_date_wid ;;
  }

  dimension: checkedin_date_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.checkedin_date_wid ;;
  }

  dimension: confirmation_number {
    view_label: "Event Registration Details"
    type: string
    sql: ${TABLE}.confirmation_number ;;
  }

  dimension: data_source_wid {
    view_label: "Event Registration Details"
    required_access_grants: [developer_access]
    type: number
    value_format_name: id
    sql: ${TABLE}.data_source_wid ;;
  }

  dimension: event_reg_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.event_reg_id ;;
  }

  dimension: event_registration_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.event_registration_wid ;;
  }

  dimension: last_updated_date_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.last_updated_date_wid ;;
  }

  dimension: marketing_code_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.marketing_code_wid ;;
  }

  dimension: person_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.person_wid ;;
  }

  dimension: product_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.product_wid ;;
  }

  dimension: promo_code_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.promo_code_wid ;;
  }

  dimension: registration_date_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.registration_date_wid ;;
  }

  dimension: paid_date_wid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.paid_date_wid ;;
  }

  dimension: registration_flag {
    view_label: "Event Registration Details"
    type: string
    sql: ${TABLE}.registration_flag ;;
  }

  dimension: row_wid {
    hidden:  yes
    primary_key: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.row_wid ;;
  }

  dimension: total_collected {
    view_label: "Event Registration Details"
    type: number
    value_format_name: usd
    sql: ${TABLE}.total_collected ;;
  }

  dimension: annual_budget {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"

    type:  string
  }
  dimension: company_revenue {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }
  dimension: company_size {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }
  dimension: job_function {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }
  dimension: job_level {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }
  dimension: industry {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }
  dimension: product_interests {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }

  dimension: purchase_influence {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }

  dimension: purchase_role {
    view_label: "Event Registration Demographics"
    description: "Aggregated value of form for the event"
    type:  string
  }

  measure: sum_total_collected {
    view_label: "Event Registration Details"
    type: sum_distinct
    sql_distinct_key: ${row_wid} ;;
    sql: ${total_collected} ;;
    value_format_name: usd
    }

  measure: average_total_collected {
    view_label: "Event Registration Details"
    type: average_distinct
    sql_distinct_key: ${row_wid} ;;
    sql: ${total_collected} ;;
    value_format_name: usd
  }

  measure: count {
    hidden: yes
    type: count
  }

  dimension:weekout {
    view_label: "Event Registration Details"
    label: "Weeks Out"
    type: number
    description: "Weeks Out Difference from Reigstration Date to start of event"
    sql: datediff('week',${registration.calendar_date}, ${product_start.calendar_date}) ;;
    }

  dimension: weekout_paid_date {
    view_label: "Event Registration Details"
    label: "Weeks Out - Paid Date"
    type:  number
    description: "Weeks out Difference from Paid Date to start of event"
    sql:  datediff('week',${paid.calendar_date}, ${product_start.calendar_date}) ;;
  }

  dimension: warehouse_date_wid {
    hidden: yes
    required_access_grants: [developer_access]
    type: number
    value_format_name: id
    sql: ${TABLE}.warehouse_date_wid ;;
  }

  dimension: warehouse_update_date_wid {
    hidden: yes
    required_access_grants: [developer_access]
    type: number
    value_format_name: id
    sql: ${TABLE}.warehouse_update_date_wid ;;
  }

  dimension: is_net_new {
    view_label: "Person"
    label: "Net New"
    description: "Activity resulted in new user"
    type:  yesno
    sql: CASE WHEN ${TABLE}.row_wid = ${person.initial_fact_wid} and ${person.initial_table_source} = 'event_registration_fact' THEN true ELSE false END;;
  }

  dimension: possibly_net_new {
    view_label: "Person"
    label: "Net New [Possibly]"
    description: "User created on same day as activity"
    type:  yesno
    sql: CASE WHEN ${TABLE}.registration_date_wid = ${person.created_date_wid} THEN true ELSE false END;;
  }



}
