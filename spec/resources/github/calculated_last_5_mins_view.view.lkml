view: calculated_last_5_mins_view {
  derived_table: {
    sql: WITH last_5_mins_view AS (select *
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
              cast(value as timestamp) >= CURRENT_TIMESTAMP - interval ''5 minutes''
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
              cast(value as timestamp) >= CURRENT_TIMESTAMP - interval ''5 minutes''
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
  last_5_mins_view.filename  AS "last_5_mins_view.filename",
  last_5_mins_view.total  AS "last_5_mins_view.total",
  last_5_mins_view.drop_time  AS "last_5_mins_view.drop_time",
  last_5_mins_view.success  AS "last_5_mins_view.success",
  last_5_mins_view.failure  AS "last_5_mins_view.failure",
  cast(last_5_mins_view.failure as float) / cast(last_5_mins_view.total as float) * 100  AS "last_5_mins_view.error_rate",
  last_5_mins_view.end_time  AS "last_5_mins_view.end_time",
  date_part('epoch', cast(last_5_mins_view.end_time as timestamp)) - date_part('epoch', cast(last_5_mins_view.start_time as timestamp))  AS "last_5_mins_view.duration",
  cast(last_5_mins_view.success as float) / (date_part('epoch', cast(last_5_mins_view.end_time as timestamp)) - date_part('epoch', cast(last_5_mins_view.start_time as timestamp)))  AS "last_5_mins_view.ingestion-rate",
  last_5_mins_view.sf_count  AS "last_5_mins_view.sf_count",
  last_5_mins_view.sf_last_seeen  AS "last_5_mins_view.sf_last_seeen",
  last_5_mins_view.athena_count  AS "last_5_mins_view.athena_count",
  last_5_mins_view.athena_last_seen  AS "last_5_mins_view.athena_last_seen"
FROM last_5_mins_view

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
ORDER BY 1
LIMIT 50
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: last_5_mins_view_filename {
    type: string
    sql: ${TABLE}."last_5_mins_view.filename" ;;
  }

  dimension: last_5_mins_view_total {
    type: string
    sql: ${TABLE}."last_5_mins_view.total" ;;
  }

  dimension: last_5_mins_view_drop_time {
    type: string
    sql: ${TABLE}."last_5_mins_view.drop_time" ;;
  }

  dimension: last_5_mins_view_success {
    type: string
    sql: ${TABLE}."last_5_mins_view.success" ;;
  }

  dimension: last_5_mins_view_failure {
    type: string
    sql: ${TABLE}."last_5_mins_view.failure" ;;
  }

  dimension: last_5_mins_view_error_rate {
    type: number
    sql: ${TABLE}."last_5_mins_view.error_rate" ;;
  }

  dimension: last_5_mins_view_end_time {
    type: string
    sql: ${TABLE}."last_5_mins_view.end_time" ;;
  }

  dimension: last_5_mins_view_duration {
    type: number
    sql: ${TABLE}."last_5_mins_view.duration" ;;
  }

  dimension: last_5_mins_view_ingestionrate {
    type: number
    sql: ${TABLE}."last_5_mins_view.ingestion-rate" ;;
  }

  dimension: last_5_mins_view_sf_count {
    type: string
    sql: ${TABLE}."last_5_mins_view.sf_count" ;;
  }

  dimension: last_5_mins_view_sf_last_seeen {
    type: string
    sql: ${TABLE}."last_5_mins_view.sf_last_seeen" ;;
  }

  dimension: last_5_mins_view_athena_count {
    type: string
    sql: ${TABLE}."last_5_mins_view.athena_count" ;;
  }

  dimension: last_5_mins_view_athena_last_seen {
    type: string
    sql: ${TABLE}."last_5_mins_view.athena_last_seen" ;;
  }

  set: detail {
    fields: [
      last_5_mins_view_filename,
      last_5_mins_view_total,
      last_5_mins_view_drop_time,
      last_5_mins_view_success,
      last_5_mins_view_failure,
      last_5_mins_view_error_rate,
      last_5_mins_view_end_time,
      last_5_mins_view_duration,
      last_5_mins_view_ingestionrate,
      last_5_mins_view_sf_count,
      last_5_mins_view_sf_last_seeen,
      last_5_mins_view_athena_count,
      last_5_mins_view_athena_last_seen
    ]
  }
}
