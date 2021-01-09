view: weekly_activities {
  derived_table: {
#     sql_trigger_value: select current_date() ;;
    sql_trigger_value: SELECT FORMAT_TIMESTAMP('%F', CURRENT_TIMESTAMP(), 'Asia/Seoul') ;;
    # sortkeys: ["product_view_week"]
    # distribution: "user_id"
    sql:WITH
          week_list as (
            SELECT
              DISTINCT(TIMESTAMP_TRUNC(e.timestamp, WEEK(MONDAY))) as product_view_week
            FROM ${mapped_events.SQL_TABLE_NAME} as e
            WHERE e.event = "Product"
        ), data as (
            SELECT
                  me.looker_visitor_id as user_id
                , TIMESTAMP_TRUNC(me.timestamp, WEEK(MONDAY)) as product_view_week
                , COUNT(distinct me.event_id) AS weekly_views
            FROM ${mapped_events.SQL_TABLE_NAME} as me
            WHERE me.event = "Product"
            GROUP BY 1,2
        )

         SELECT
            u.looker_visitor_id as user_id
          , TIMESTAMP_TRUNC(u.first_date, WEEK(MONDAY)) as first_week
          , week_list.product_view_week as product_view_week
          -- , d.weekly_views as weekly_views
          , COALESCE(d.weekly_views, 0) as weekly_views
          , row_number() over() AS key
        FROM
          ${user_facts.SQL_TABLE_NAME} as u
          CROSS JOIN week_list
          LEFT JOIN data as d ON (d.user_id = u.looker_visitor_id AND d.product_view_week = week_list.product_view_week)
          WHERE cast(TIMESTAMP_TRUNC(u.first_date, WEEK(MONDAY)) as date)
          BETWEEN DATE_ADD(cast(TIMESTAMP_TRUNC(u.first_date, WEEK(MONDAY)) as date), INTERVAL -100 WEEK) AND cast(TIMESTAMP_TRUNC(week_list.product_view_week, WEEK(MONDAY)) as date)
          ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: first_visit {
    type: time
    timeframes: [week]
    sql: ${TABLE}.first_week ;;
  }

  dimension_group: product_view {
    type: time
    timeframes: [week]
    sql: ${TABLE}.product_view_week ;;
  }

  # dimension_group: since_first_visit {
  #   type: duration
  #   intervals: [day, week]
  #   sql_start: ${TABLE}.first_week ;;
  #   sql_end: ${TABLE}.product_view_week ;;
  # }

  # dimension: days_since_first_visit {
  #   type: number
  #   sql: date_diff((cast(${TABLE}.first_week) as date), (cast(${TABLE}.product_view_week) as date), DAY) ;;
  # }

  dimension: weeks_since_first_visit {
    type: number
    sql: cast(TIMESTAMP_DIFF(${TABLE}.product_view_week, ${TABLE}.first_week, HOUR) / 24 / 7 as numeric) ;;
  }

  dimension: weekly_views {
    description: "number of products views each week"
    type: number
    sql: ${TABLE}.weekly_views ;;
  }

#   dimension: monthly_spend {
#     type: number
#     sql: ${TABLE}.monthly_spend ;;
#   }

  measure: total_users {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [users.id, users.age, users.name, user_order_facts.lifetime_orders]
  }

  measure: total_active_users {
    description: "number of users who viewed one or more products"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [users.id, users.age, users.name]

    filters: {
      field: weekly_views
      value: ">0"
    }
  }

  measure: percent_of_cohort_active {
    type: number
    value_format_name: percent_1
    sql: 1.0 * ${total_active_users} / nullif(${total_users},0) ;;
    drill_fields: [user_id, weekly_views]
  }

  measure: 7_days_active_users {
    description: "number of users who viewed 1 or more products after first week of visit"
    type: count_distinct
    sql: ${user_id} ;;

    filters: {
      field: weekly_views
      value: ">0"
    }
    filters: {
      field: weeks_since_first_visit
      value: ">0"
    }
  }

  measure: 7_days_retention_rate {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${7_days_active_users} / nullif(${total_active_users},0) ;;
  }

  measure: 28_days_active_users {
    description: "number of users who viewed 1 or more products after fourth week of visit"
    type: count_distinct
    sql: ${user_id} ;;

    filters: {
      field: weekly_views
      value: ">0"
    }
    filters: {
      field: weeks_since_first_visit
      value: ">4"
    }
  }

  measure: 28_days_retention_rate {
    type: number
    value_format_name: percent_2
    sql: 1.0 * ${28_days_active_users} / nullif(${total_active_users},0) ;;
  }

#   measure: total_amount_spent {
#     type: sum
#     value_format_name: usd
#     sql: ${monthly_spend} ;;
#     drill_fields: [detail*]
#   }

#   measure: spend_per_user {
#     type: number
#     value_format_name: usd
#     sql: ${total_amount_spent} / nullif(${total_users},0) ;;
#     drill_fields: [user_id, monthly_purchases, total_amount_spent]
#   }
#
#   measure: spend_per_active_user {
#     type: number
#     value_format_name: usd
#     sql: ${total_amount_spent} / nullif(${total_active_users},0) ;;
#     drill_fields: [user_id, total_amount_spent]
#   }

  dimension: key {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.key ;;
  }

  set: detail {
    fields: [user_id, first_visit_week, weekly_views]
  }
}
