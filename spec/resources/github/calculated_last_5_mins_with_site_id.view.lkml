view: calculated_last_5_mins_with_site_id {
  derived_table: {
    sql: WITH calculated_last_5_mins_view AS (WITH last_5_mins_view AS (select *
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
  last_5_mins_view.athena_last_seen  AS "last_5_mins_view.athena_last_seen",
  metric_events.site_id as "site_id"
FROM last_5_mins_view
join metric_events on last_5_mins_view.filename=metric_events.filename
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
ORDER BY 1
LIMIT 50
 )
select
  calculated_last_5_mins_view."site_id",
  calculated_last_5_mins_view."last_5_mins_view.filename"  AS "calculated_last_5_mins_view.last_5_mins_view_filename",
  calculated_last_5_mins_view."last_5_mins_view.total"  AS "calculated_last_5_mins_view.last_5_mins_view_total",
  calculated_last_5_mins_view."last_5_mins_view.drop_time"  AS "calculated_last_5_mins_view.last_5_mins_view_drop_time",
  calculated_last_5_mins_view."last_5_mins_view.success"  AS "calculated_last_5_mins_view.last_5_mins_view_success",
  calculated_last_5_mins_view."last_5_mins_view.failure"  AS "calculated_last_5_mins_view.last_5_mins_view_failure",
  calculated_last_5_mins_view."last_5_mins_view.error_rate"  AS "calculated_last_5_mins_view.last_5_mins_view_error_rate",
  calculated_last_5_mins_view."last_5_mins_view.end_time"  AS "calculated_last_5_mins_view.last_5_mins_view_end_time",
  calculated_last_5_mins_view."last_5_mins_view.duration"  AS "calculated_last_5_mins_view.last_5_mins_view_duration",
  calculated_last_5_mins_view."last_5_mins_view.ingestion-rate"  AS "calculated_last_5_mins_view.last_5_mins_view_ingestionrate",
  calculated_last_5_mins_view."last_5_mins_view.sf_count"  AS "calculated_last_5_mins_view.last_5_mins_view_sf_count",
  calculated_last_5_mins_view."last_5_mins_view.sf_last_seeen"  AS "calculated_last_5_mins_view.last_5_mins_view_sf_last_seeen",
  calculated_last_5_mins_view."last_5_mins_view.athena_count"  AS "calculated_last_5_mins_view.last_5_mins_view_athena_count",
  calculated_last_5_mins_view."last_5_mins_view.athena_last_seen"  AS "calculated_last_5_mins_view.last_5_mins_view_athena_last_seen"
FROM calculated_last_5_mins_view
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
ORDER BY 1
LIMIT 500
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: site_id {
    type: string
    sql: ${TABLE}.site_id ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_filename {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_filename" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_total {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_total" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_drop_time {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_drop_time" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_success {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_success" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_failure {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_failure" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_error_rate {
    type: number
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_error_rate" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_end_time {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_end_time" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_duration {
    type: number
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_duration" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_ingestionrate {
    type: number
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_ingestionrate" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_sf_count {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_sf_count" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_sf_last_seeen {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_sf_last_seeen" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_athena_count {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_athena_count" ;;
  }

  dimension: calculated_last_5_mins_view_last_5_mins_view_athena_last_seen {
    type: string
    sql: ${TABLE}."calculated_last_5_mins_view.last_5_mins_view_athena_last_seen" ;;
  }

  set: detail {
    fields: [
      site_id,
      calculated_last_5_mins_view_last_5_mins_view_filename,
      calculated_last_5_mins_view_last_5_mins_view_total,
      calculated_last_5_mins_view_last_5_mins_view_drop_time,
      calculated_last_5_mins_view_last_5_mins_view_success,
      calculated_last_5_mins_view_last_5_mins_view_failure,
      calculated_last_5_mins_view_last_5_mins_view_error_rate,
      calculated_last_5_mins_view_last_5_mins_view_end_time,
      calculated_last_5_mins_view_last_5_mins_view_duration,
      calculated_last_5_mins_view_last_5_mins_view_ingestionrate,
      calculated_last_5_mins_view_last_5_mins_view_sf_count,
      calculated_last_5_mins_view_last_5_mins_view_sf_last_seeen,
      calculated_last_5_mins_view_last_5_mins_view_athena_count,
      calculated_last_5_mins_view_last_5_mins_view_athena_last_seen
    ]
  }
}
