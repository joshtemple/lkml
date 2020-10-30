view: calculated_last_24_hours_view {
  derived_table: {
    sql: WITH last_24_hours_view AS (select *
      from crosstab (
          '
      select filename,property_id,max(value)
              from metric_events
          where
            filename in (
            select distinct filename
            from metric_events
            where
              (
              property_id = 1 or
              property_id = 2
              ) and
              cast(value as timestamp) >= CURRENT_TIMESTAMP - interval ''24 H''
              and cast(value as timestamp) < CURRENT_TIMESTAMP
            ) and
            property_id in
            (
            select distinct id
            from metric_property
            where
              property_type = ''varchar''
            )
          group by 1,2
      UNION
      select filename, property_id, cast(sum(cast(value as integer)) as varchar) as value from metric_events
          where
            filename in (
            select distinct filename
            from metric_events
            where
              (
              property_id = 1 or
              property_id = 2
              ) and
              cast(value as timestamp) >= CURRENT_TIMESTAMP - interval ''24 H''
              and cast(value as timestamp) < CURRENT_TIMESTAMP
            ) and
            property_id in
            (
            select distinct id
            from metric_property
            where
              property_type = ''integer''
            )
          group by 1,2
      order by 1,2

        ',
        'select id from metric_property order by 1 ')
          AS (filename varchar, start_time varchar, end_time varchar, total varchar,
            success varchar, failure varchar,
            sf_last_seeen varchar, sf_count varchar,
            athena_last_seen varchar, athena_count varchar, drop_time varchar)
       )
SELECT
  last_24_hours_view.filename  AS "last_24_hours_view.filename",
  last_24_hours_view.total  AS "last_24_hours_view.total",
  last_24_hours_view.drop_time  AS "last_24_hours_view.drop_time",
  last_24_hours_view.success  AS "last_24_hours_view.success",
  last_24_hours_view.failure  AS "last_24_hours_view.failure",
  cast(last_24_hours_view.failure as float) / cast(last_24_hours_view.total as float) * 100  AS "last_24_hours_view.error_rate",
  last_24_hours_view.end_time  AS "last_24_hours_view.end_time",
  date_part('epoch', cast(last_24_hours_view.end_time as timestamp)) - date_part('epoch', cast(last_24_hours_view.start_time as timestamp))  AS "last_24_hours_view.duration",
  cast(last_24_hours_view.success as float) / (date_part('epoch', cast(last_24_hours_view.end_time as timestamp)) - date_part('epoch', cast(last_24_hours_view.start_time as timestamp)))  AS "last_24_hours_view.ingestion-rate",
  last_24_hours_view.sf_count  AS "last_24_hours_view.sf_count",
  last_24_hours_view.sf_last_seeen  AS "last_24_hours_view.sf_last_seeen",
  last_24_hours_view.athena_count  AS "last_24_hours_view.athena_count",
  last_24_hours_view.athena_last_seen  AS "last_24_hours_view.athena_last_seen"
FROM last_24_hours_view

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
ORDER BY 1
LIMIT 50
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: last_24_hours_view_filename {
    type: string
    sql: ${TABLE}."last_24_hours_view.filename" ;;
  }

  dimension: last_24_hours_view_total {
    type: string
    sql: ${TABLE}."last_24_hours_view.total" ;;
  }

  dimension: last_24_hours_view_drop_time {
    type: string
    sql: ${TABLE}."last_24_hours_view.drop_time" ;;
  }

  dimension: last_24_hours_view_success {
    type: string
    sql: ${TABLE}."last_24_hours_view.success" ;;
  }

  dimension: last_24_hours_view_failure {
    type: string
    sql: ${TABLE}."last_24_hours_view.failure" ;;
  }

  dimension: last_24_hours_view_error_rate {
    type: number
    sql: ${TABLE}."last_24_hours_view.error_rate" ;;
  }

  dimension: last_24_hours_view_end_time {
    type: string
    sql: ${TABLE}."last_24_hours_view.end_time" ;;
  }

  dimension: last_24_hours_view_duration {
    type: number
    sql: ${TABLE}."last_24_hours_view.duration" ;;
  }

  dimension: last_24_hours_view_ingestionrate {
    type: number
    sql: ${TABLE}."last_24_hours_view.ingestion-rate" ;;
  }

  dimension: last_24_hours_view_sf_count {
    type: string
    sql: ${TABLE}."last_24_hours_view.sf_count" ;;
  }

  dimension: last_24_hours_view_sf_last_seeen {
    type: string
    sql: ${TABLE}."last_24_hours_view.sf_last_seeen" ;;
  }

  dimension: last_24_hours_view_athena_count {
    type: string
    sql: ${TABLE}."last_24_hours_view.athena_count" ;;
  }

  dimension: last_24_hours_view_athena_last_seen {
    type: string
    sql: ${TABLE}."last_24_hours_view.athena_last_seen" ;;
  }

  set: detail {
    fields: [
      last_24_hours_view_filename,
      last_24_hours_view_total,
      last_24_hours_view_drop_time,
      last_24_hours_view_success,
      last_24_hours_view_failure,
      last_24_hours_view_error_rate,
      last_24_hours_view_end_time,
      last_24_hours_view_duration,
      last_24_hours_view_ingestionrate,
      last_24_hours_view_sf_count,
      last_24_hours_view_sf_last_seeen,
      last_24_hours_view_athena_count,
      last_24_hours_view_athena_last_seen
    ]
  }
}
