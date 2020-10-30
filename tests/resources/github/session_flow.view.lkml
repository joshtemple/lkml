#############################################################################################################
# Purpose: A derived table that extracts session information such as page flow and time between sessions for each visitor
#############################################################################################################
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/Custom_Views/session_flow.view.lkml"

view: session_flow {
  extends: [session_flow_config]
}

view: session_flow_core {
  extension: required
  derived_table: {
    sql:
        SELECT
          id
          , TIMESTAMP_DIFF(visit_start_date, COALESCE(previous_visit_start_date, visit_start_date), DAY) AS prev_visit_start
          , count(*) AS pages_visited
          , MAX(cumulative_page_path) AS full_page_path_history
          , MAX(IF(page_sequence_number = 1, page_path, NULL)) AS first_page_path
          , MAX(IF(page_sequence_number = 2, page_path, NULL)) AS second_page_path
          , MAX(IF(page_sequence_number = 3, page_path, NULL)) AS third_page_path
          , MAX(IF(page_sequence_number = 4, page_path, NULL)) AS fourth_page_path
          , MAX(IF(page_sequence_number = 5, page_path, NULL)) AS fifth_page_path
          , MAX(IF(page_sequence_number = 6, page_path, NULL)) AS sixth_page_path
        FROM ${page_facts.SQL_TABLE_NAME} AS page_facts
        GROUP BY 1,2
       ;;
    persist_for: "24 hours"
  }

  ########## PRIMARY KEYS ##########

  dimension: session_id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  ########## DIMENSIONS ##########

  dimension: full_page_history  {
    view_label: "Session"
    group_label: "Pages Visited"
    description: "Full Path of Pages Visited in Session"
    type: string
    sql: ${TABLE}.full_page_path_history  ;;
  }

  dimension: page_path_1 {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "1st Page in Session"
    description: "First Page Path visited in Session (i.e. Landing Page)"
    type: string
    sql: ${TABLE}.first_page_path ;;
  }

  dimension: page_path_2 {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "2nd Page in Session"
    description: "Second Page Path Visited in Session"
    type: string
    sql: ${TABLE}.second_page_path ;;
  }

  dimension: page_path_3 {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "3rd Page in Session"
    description: "Third Page Path Visited in Session"
    type: string
    sql: ${TABLE}.third_page_path ;;
  }

  dimension: page_path_4 {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "4th Page in Session"
    description: "Third Page Path Visited in Session"
    type: string
    sql: ${TABLE}.fourth_page_path ;;
  }

  dimension: page_path_5 {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "5th Page in Session"
    description: "Third Page Path Visited in Session"
    type: string
    sql: ${TABLE}.fifth_page_path ;;
  }

  dimension: page_path_6 {
    view_label: "Page Flow"
    group_label: "Page Path"
    label: "6th Page in Session"
    description: "Third Page Path Visited in Session"
    type: string
    sql: ${TABLE}.sixth_page_path ;;
  }

  dimension: pages_visited {
    view_label: "Session"
    group_label: "Pages Visited"
    label: "Number of Pages Visited in Session"
    description: "Total Pages Visited in Session"
    type: number
    sql: ${TABLE}.pages_visited ;;
  }

  dimension: days_since_previous_session {
    view_label: "Audience"
    group_label: "User"
    description: "Days since the previous session. 0 if user only has 1 session."
    type: number
    sql: COALESCE(${TABLE}.prev_visit_start, 0);;
  }

  dimension: days_since_previous_session_tier {
    view_label: "Audience"
    group_label: "User"
    description: "Days since the previous session. 0 if user only has 1 session."
    type: tier
    style: integer
    tiers: [1,2,4,8,15,31,61,121,365]
    sql: ${days_since_previous_session};;
  }
}
