connection: "dell"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: exp_customer_a {
  label: "explore customer a"
  from: customer_a
}

view: customer_a {
  extends: [thebase]
#  sql_table_name: extensions.customera ;; #this would be parameterized in production
  sql_table_name: extensions.{{ _user_attributes["customer_table_name"] }} ;;
  #dimensions programatically added through Marketo UI or as customers add custom columns in Looker
  dimension: customcol1 {
    type: string
    sql: ${TABLE}.customcol1 ;;
  }

  dimension: customcol2 {
    type: string
    sql: ${TABLE}.customcol2 ;;
  }

  measure: count {
    type: count
  }
}


view: thebase {
  sql_table_name: extensions.thebase ;;

# and the base view would look like:
# why? shouldn't this point to a shared customer base table with user attributes dictating data access
# view: orders {
#  sql_table_name: {{ _user_attributes["customer_table_name"] }} ;;


  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: event_id {
    type: number
    sql: ${TABLE}.event_id ;;
  }

  dimension_group: eventdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.eventdate ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  measure: count {
    type: count
  }
}

# explore: Explore_Customer_A {
#   label: "Orders"
#   extends: [orders]
#   from: Customer_A
#
# }
#
# view: Customer_A {
#   extends: [orders]
#   sql_table_name: {{ _user_attributes["customer_table_name"] }} ;;
#   view_label: "Orders"
#   dimension: customCol1 {
#     sql: ${TABLE}.customCol1 ;;
#   }
#
#   dimension: customCol2 {
#     sql: ${TABLE}.customCol2 ;;
#   }
# }

# and the base view would look like:
# view: orders {
#  sql_table_name: {{ _user_attributes["customer_table_name"] }} ;;
