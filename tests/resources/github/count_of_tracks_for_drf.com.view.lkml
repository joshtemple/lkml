view: count_of_tracks_for_drf_com {

# view: count_of_tracks_per_user {
#   # # You can specify the table name if it's different from the view name:
#   sql_table_name: public.prod_stream_table ;;
#   #
#   # # Define your dimensions and measures here, like this:
#
#
#   dimension: location_url {
#     description: "location_url"
#     type: string
#     sql: ${TABLE}.location_url ;;
#
#   }
#   #
#   # dimension: lifetime_orders {
#   #   description: "The total number of orders for each user"
#   #   type: number
#   #   sql: ${TABLE}.lifetime_orders ;;
#   # }
#   #
#   dimension: created_at {
#     description: "When the event happened"
#     type: string
#     sql: ${TABLE}.created_at ;;
#   }
  #
  #   dimension: created_at_ms {
#     type: number
#     sql: ${TABLE}.created_at_ms ;;
#   }
#
#   dimension_group: created_at_ms_formatted {
#     type: time
#     datatype: epoch
#     timeframes: [time, raw, date, week, month, year, hour_of_day]
#     sql: CAST(${created_at_ms} AS BIGINT) / 1000;;
#   }
#
#
#   dimension: device_model{
#     description: "device model"
#     type: string
#     sql: CASE
#         WHEN ${TABLE}.device = 'desktop' THEN 'desktop'
#         WHEN ${TABLE}.device = 'console' THEN 'console'
#         WHEN ${TABLE}.device = 'smarttv' THEN 'smarttv'
#         WHEN json_extract_path_text( ${TABLE}.device, 'type') != '' THEN json_extract_path_text(${TABLE}.device, 'type')
#         ELSE 'Device Unknown'
#         end;;
#   }
#
#   dimension: DRF_Customer_ID {
#     description: "DRF Customer ID"
#     type: string
#     sql:  ${TABLE}.drf_user_id ;;
#   }
#   dimension: event_type {
#     description: "DRF Customer ID"
#     type: string
#     sql:  ${TABLE}.event_type ;;
#   }
#
# #   measure:  {
# #     description: "count of user event"
# #     type: count_distinct
# #     sql: ${DRF_Customer_ID} ;;
# #     drill_fields: []
# #   }
#
#   measure: count_event_type {
#     description: "count of user event"
#     type: count
#     sql: ${event_type} ;;
#     drill_fields: []
#   }
#
#   measure: distinct_Location_URL {
#     description: "average number of clicks"
#     type: count_distinct
#     sql: rtrim(trim(${location_url}, regexp_substr(${location_url},'https://play.drf.com/#/pp-details/[0-9]*/')),regexp_substr(trim(${location_url}, regexp_substr(${location_url},'https://play.drf.com/#/pp-details/[0-9]*/')),'/[0-9]*/[A-Z]*/[A-Z]*'));;
#   }
#
#
# }


# view: count_of_tracks_per_user {
#   derived_table: {
#     sql: select
#         registration_view.drf_user_id,
#         count(distinct(rtrim(trim(registration_view.location_url, regexp_substr(registration_view.location_url,'https://play.drf.com/#/pp-details/[0-9]*/')),regexp_substr(trim(registration_view.location_url, regexp_substr(registration_view.location_url,'https://play.drf.com/#/pp-details/[0-9]*/')),'/[0-9]*/[A-Z]*/[A-Z]*'))))as "track"
#           FROM public.prod_stream_table  AS registration_view
#
#         WHERE
#         (registration_view.location_url LIKE '%https://play.drf.com/#/pp-details/%') and drf_user_id is not Null
#
#         group by 1
#       LIMIT 500
#        ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#
#   dimension: drf_user_id {
#     type: number
#     sql: ${TABLE}.drf_user_id ;;
#   }
#
#   dimension: track {
#     type: number
#     sql: ${TABLE}.track ;;
#   }
#
#   set: detail {
#     fields: [drf_user_id, track]
#   }
# }

#   filter:created_time_filter {
#     suggest_dimension: created_at_ms
#     type: number
#   }

  derived_table: {
    sql:
     (SELECT count_of_tracks_per_user.drf_user_id, trim(regexp_substr(trim(count_of_tracks_per_user.location_url, regexp_substr(count_of_tracks_per_user.location_url,'https://www.drf.com/pp-details/[0-9]*-[0-9]*-[0-9]*')),'[A-Z]*')) AS "track_id",
      DATE(CONVERT_TIMEZONE('UTC', 'America/New_York', (timestamp 'epoch' + CAST(count_of_tracks_per_user.created_at_ms AS BIGINT) / 1000 * interval '1 second')))
      FROM public.prod_stream_table  AS count_of_tracks_per_user WHERE count_of_tracks_per_user.event_type = 'PAGE_LOAD' and count_of_tracks_per_user.location_url like 'https://www.drf.com/pp-details/%' and
      (count_of_tracks_per_user.drf_user_id IS NOT NULL))

      ;;
  }

  dimension: created_at {
    description: "When the event happened"
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_at_ms {
    type: number
    sql: ${TABLE}.created_at_ms ;;
  }

  dimension_group: created_at_ms_formatted {
    type: time
    datatype: epoch
    timeframes: [time, raw, date, week, month, year, hour_of_day]
    sql: CAST(${created_at_ms} AS BIGINT) / 1000;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: drf_user_id {
    type: string
    sql: ${TABLE}.drf_user_id ;;
  }


  measure: distinct_user_id {
    type: count_distinct
    sql:${TABLE}.drf_user_id ;;
  }

  dimension: track_id {
    type: string
  }

  measure: count_track_id {
    type: count_distinct
    sql: ${track_id} ;;
  }

  dimension: date {
    type: date
    convert_tz:no
  }

  dimension: week {
#     type: date
  convert_tz: no
  sql: TO_CHAR(DATE_TRUNC('week', ${date}), 'YYYY-MM-DD');;
}
set: detail {
  fields: [drf_user_id,track_id]
}

 # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: count_of_tracks_for_drf_com {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
