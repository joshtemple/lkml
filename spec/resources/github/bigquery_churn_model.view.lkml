view: bigquery_churn_model {
  derived_table: {
    sql:
(with a as
(select user_id,
        min(date(status_date)) as conversion_date
 from http_api.purchase_event
 where ((topic='customer.product.renewed' or status='renewed') and date(created_at)>'2018-10-31') or (topic='customer.product.created' and date_diff(date(status_date),date(created_at),day)>14 and date(created_at)>'2018-10-31')
 group by 1),

e1 as
(select user_id,
       status_date,
       case when topic='customer.product.set_cancellation' then 1 else 0 end as set_cancel,
       case when topic='customer.product.undo_set_paused' then 1 else 0 end as undo_cancel,
       case when topic='customer.product.charge_failed' then 1 else 0 end as charge_failed
from http_api.purchase_event),

e as
(select distinct b.user_id,
       created_at,
       conversion_date,
       b.status_date,
       email,
       topic,
       region,
       platform,
       date(b.status_date) as end_date,
       date_sub(date(b.status_date), interval 30 day) as start_date,
       date(b.status_date) as start_date2,
       date_add(date(b.status_date), interval 30 day) as end_date2,
       extract(day from date(b.status_date)) as month_day,
       date_diff(date(b.status_date),(conversion_date),month) as num,
       case when moptin=true then 1 else 0 end as marketing_optin,
       case when topic = "customer.product.renewed" or status="renewed" then 0 else 1 end as churn_status
from http_api.purchase_event as b inner join a on a.user_id=b.user_id
where (topic in ('customer.product.expired','customer.product.disabled','customer.product.cancelled','customer.product.renewed'))
and (country='United States' or country is null)
and (conversion_date)<=date(b.status_date)),


/*      awl as
      (SELECT user_id,timestamp, 1 as addwatchlist FROM javascript.addwatchlist where user_id is not null
        UNION ALL
        SELECT user_id,timestamp, 1 as addwatchlist FROM android.addwatchlist where user_id is not null
        UNION ALL
        SELECT user_id,timestamp, 1 as addwatchlist FROM ios.addwatchlist where user_id is not null),

      f as
      (select e.user_id,
              num,
             case when addwatchlist is null then 0 else 1 end as addwatchlist
      from e left join awl on e.user_id=awl.user_id and date(timestamp) between start_date and end_date),

      awl1 as
      (select user_id,
             num,
             sum(addwatchlist) as addwatchlist
      from f
      group by 1,2),*/

      error as
      (SELECT user_id,timestamp, 1 as error FROM javascript.error where user_id is not null
        UNION ALL
        SELECT user_id,timestamp, 1 as error FROM android.error where user_id is not null
        UNION ALL
        SELECT user_id,timestamp, 1 as error FROM ios.error where user_id is not null),

      g as
      (select e.user_id,
              num,
             case when error is null then 0 else 1 end as error
      from e left join error on e.user_id=error.user_id and date(timestamp) between start_date and end_date),

      error1 as
      (select user_id,
             num,
             sum(error) as error
      from g
      group by 1,2),

/*      rwl as
      (SELECT user_id,timestamp, 1 as removewatchlist FROM javascript.removewatchlist where user_id is not null
        UNION ALL
        SELECT user_id,timestamp, 1 as removewatchlist FROM android.removewatchlist where user_id is not null
        UNION ALL
        SELECT user_id,timestamp, 1 as removewatchlist FROM ios.removewatchlist where user_id is not null),

      i as
      (select e.user_id,
              num,
              case when removewatchlist is null then 0 else 1 end as removewatchlist
      from e left join rwl on e.user_id=rwl.user_id and date(timestamp) between start_date and end_date),

      rwl1 as
      (select user_id,
             num,
             sum(removewatchlist) as removewatchlist
      from i
      group by 1,2),*/

      view as
      (SELECT safe_cast(user_id as int64) as user_id,timestamp, 1 as view FROM javascript.pages where user_id is not null
        UNION ALL
        SELECT safe_cast(user_id as int64) as user_id,timestamp, 1 as view FROM android.view where user_id is not null
        UNION ALL
        SELECT user_id,timestamp, 1 as view FROM ios.view where user_id is not null),

      j as
      (select e.user_id,
              num,
              case when view is null then 0 else 1 end as view
      from e left join view on e.user_id=cast(view.user_id as string) and date(timestamp) between start_date and end_date),

      view1 as
      (select user_id,
             num,
             sum(view) as view
      from j
      group by 1,2),

      fp as
      (WITH web AS (
            SELECT
              b.user_id,
              'web' AS source,
              b.timestamp,
              case WHEN metadata_series_name LIKE '%Heartland%' THEN 'Heartland'
                WHEN metadata_series_name LIKE '%Bates%' THEN 'Bringing Up Bates'
                ELSE 'Other'
              END AS content,
              max(timecode) as duration
            FROM
              javascript.video_content_playing as b inner join php.get_titles as a on b.video_id=a.video_id
            where date(ingest_at)>'2020-02-13'
              group by 1,2,3,4),

            droid AS (
            SELECT
              b.user_id,
              'web' AS source,
              b.timestamp,
              case WHEN metadata_series_name LIKE '%Heartland%' THEN 'Heartland'
                WHEN metadata_series_name LIKE '%Bates%' THEN 'Bringing Up Bates'
                ELSE 'Other'
              END AS content,
              max(timecode) as duration
            FROM android.video_content_playing as b inner join php.get_titles as a on b.video_id=a.video_id
            where date(ingest_at)>'2020-02-13'
              group by 1,2,3,4),

            roku AS (
            SELECT
             b.user_id,
              'web' AS source,
              b.timestamp,
              case WHEN metadata_series_name LIKE '%Heartland%' THEN 'Heartland'
                WHEN metadata_series_name LIKE '%Bates%' THEN 'Bringing Up Bates'
                ELSE 'Other'
              END AS content,
              max(timecode) as duration
            FROM roku.video_content_playing as b inner join php.get_titles as a on b.video_id=a.video_id
            where date(ingest_at)>'2020-02-13'
              group by 1,2,3,4),

            apple AS (
            SELECT
              b.user_id,
              'web' AS source,
              b.timestamp,
              case WHEN metadata_series_name LIKE '%Heartland%' THEN 'Heartland'
                WHEN metadata_series_name LIKE '%Bates%' THEN 'Bringing Up Bates'
                ELSE 'Other'
              END AS content,
              max(timecode) as duration
            FROM ios.video_content_playing as b inner join php.get_titles as a on b.video_id=safe_cast(a.video_id as string)
            where date(ingest_at)>'2020-02-13'
              group by 1,2,3,4)


            SELECT web.user_id,
                   (timestamp) as timestamp,
--                    (case when content="Other" then 1 else 0 end) as other_plays,
--                    (case when content="Bringing Up Bates" then 1 else 0 end) as bates_plays,
--                    (case when content="Heartland" then 1 else 0 end) as heartland_plays,
                   (case when content="Other" then duration else 0 end) as other_duration,
                   (case when content="Bringing Up Bates" then duration else 0 end) as bates_duration,
                   (case when content="Heartland" then duration else 0 end) as heartland_duration,
--                    (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then 1 else 0 end) as one_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then 1 else 0 end) as two_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then 1 else 0 end) as three_week_view,
--                    (case when date(timestamp) > date_sub(end_date,interval 21 day) then 1 else 0 end) as four_week_view,
                   (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then duration else 0 end) as one_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then duration else 0 end) as two_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then duration else 0 end) as three_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 28 day) and date_sub(end_date,interval 21 day) then duration else 0 end) as four_week_duration
            FROM web inner join e on web.user_id=e.user_id and date(web.timestamp) between start_date and end_date
            UNION ALL
            SELECT droid.user_id,
                   (timestamp) as timestamp,
--                    (case when content="Other" then 1 else 0 end) as other_plays,
--                    (case when content="Bringing Up Bates" then 1 else 0 end) as bates_plays,
--                    (case when content="Heartland" then 1 else 0 end) as heartland_plays,
                   (case when content="Other" then duration else 0 end) as other_duration,
                   (case when content="Bringing Up Bates" then duration else 0 end) as bates_duration,
                   (case when content="Heartland" then duration else 0 end) as heartland_duration,
--                    (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then 1 else 0 end) as one_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then 1 else 0 end) as two_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then 1 else 0 end) as three_week_view,
--                    (case when date(timestamp) > date_sub(end_date,interval 21 day) then 1 else 0 end) as four_week_view,
                   (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then duration else 0 end) as one_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then duration else 0 end) as two_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then duration else 0 end) as three_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 28 day) and date_sub(end_date,interval 21 day) then duration else 0 end) as four_week_duration
            FROM droid inner join e on droid.user_id=e.user_id and date(droid.timestamp) between start_date and end_date
            UNION ALL
            SELECT e.user_id,
                   (timestamp) as timestamp,
--                    (case when content="Other" then 1 else 0 end) as other_plays,
--                    (case when content="Bringing Up Bates" then 1 else 0 end) as bates_plays,
--                    (case when content="Heartland" then 1 else 0 end) as heartland_plays,
                   (case when content="Other" then duration else 0 end) as other_duration,
                   (case when content="Bringing Up Bates" then duration else 0 end) as bates_duration,
                   (case when content="Heartland" then duration else 0 end) as heartland_duration,
--                    (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then 1 else 0 end) as one_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then 1 else 0 end) as two_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then 1 else 0 end) as three_week_view,
--                    (case when date(timestamp) > date_sub(end_date,interval 21 day) then 1 else 0 end) as four_week_view,
                   (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then duration else 0 end) as one_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then duration else 0 end) as two_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then duration else 0 end) as three_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 28 day) and date_sub(end_date,interval 21 day) then duration else 0 end) as four_week_duration
            FROM apple inner join e on apple.user_id=e.user_id and date(apple.timestamp) between start_date and end_date
            union all
            SELECT e.user_id,
                   (timestamp) as timestamp,
--                    (case when content="Other" then 1 else 0 end) as other_plays,
--                    (case when content="Bringing Up Bates" then 1 else 0 end) as bates_plays,
--                    (case when content="Heartland" then 1 else 0 end) as heartland_plays,
                   (case when content="Other" then duration else 0 end) as other_duration,
                   (case when content="Bringing Up Bates" then duration else 0 end) as bates_duration,
                   (case when content="Heartland" then duration else 0 end) as heartland_duration,
--                    (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then 1 else 0 end) as one_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then 1 else 0 end) as two_week_view,
--                    (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then 1 else 0 end) as three_week_view,
--                    (case when date(timestamp) > date_sub(end_date,interval 21 day) then 1 else 0 end) as four_week_view,
                   (case when date(timestamp) between date_sub(end_date,interval 7 day) and end_date then duration else 0 end) as one_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 14 day) and date_sub(end_date,interval 8 day) then duration else 0 end) as two_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 21 day) and date_sub(end_date,interval 15 day) then duration else 0 end) as three_week_duration,
                   (case when date(timestamp) between date_sub(end_date,interval 28 day) and date_sub(end_date,interval 21 day) then duration else 0 end) as four_week_duration
            FROM roku inner join e on roku.user_id=e.user_id and date(roku.timestamp) between start_date and end_date),

      k as
      (select e.user_id,
              num,
--               case when bates_plays is null then 0 else bates_plays end as bates_plays,
--               case when heartland_plays is null then 0 else heartland_plays end as heartland_plays,
--               case when other_plays is null then 0 else other_plays end as other_plays,
              case when bates_duration is null then 0 else bates_duration end as bates_duration,
              case when heartland_duration is null then 0 else heartland_duration end as heartland_duration,
              case when other_duration is null then 0 else other_duration end as other_duration,
--               case when one_week_view is null then 0 else one_week_view end as one_week_view,
--               case when two_week_view is null then 0 else two_week_view end as two_week_view,
--               case when three_week_view is null then 0 else three_week_view end as three_week_view,
--               case when four_week_view is null then 0 else four_week_view end as four_week_view,
              case when one_week_duration is null then 0 else one_week_duration end as one_week_duration,
              case when two_week_duration is null then 0 else two_week_duration end as two_week_duration,
              case when three_week_duration is null then 0 else three_week_duration end as three_week_duration,
              case when four_week_duration is null then 0 else four_week_duration end as four_week_duration
      from e left join fp on e.user_id=fp.user_id and date(timestamp) between start_date and end_date),

      fp1 as
      (select user_id,
             num,
--              sum(bates_plays) as bates_plays,
--              sum(heartland_plays) as heartland_plays,
--              sum(other_plays) as other_plays,
             sum(bates_duration) as bates_duration,
             sum(heartland_duration) as heartland_duration,
             sum(other_duration) as other_duration,
--              sum(one_week_view) as one_week_view,
--              sum(two_week_view) as two_week_view,
--              sum(three_week_view) as three_week_view,
--              sum(four_week_view) as four_week_view,
             sum(one_week_duration) as one_week_duration,
             sum(two_week_duration) as two_week_duration,
             sum(three_week_duration) as three_week_duration,
             sum(four_week_duration) as four_week_duration
      from k
      group by 1,2),

m0 as
(select e1.user_id,
        date_diff(date(e1.status_date),(conversion_date),month) as num,
        sum(set_cancel) as set_cancel,
        sum(undo_cancel) as undo_cancel,
        sum(charge_failed) as charge_failed
 from e1 inner join a on a.user_id=e1.user_id
 group by 1,2),


m as
(select e.*,
--              addwatchlist,
             error,
--              removewatchlist,
             view,
--              bates_plays,
             bates_duration,
--              heartland_plays,
             heartland_duration,
--              other_plays,
             other_duration,
--              one_week_view,
--              two_week_view,
--              three_week_view,
--              four_week_view,
             one_week_duration,
             two_week_duration,
             three_week_duration,
             four_week_duration,
             m0.set_cancel,
             m0.undo_cancel,
             m0.charge_failed,
             1 as code
      from e /*left join awl1 on e.user_id=awl1.user_id and e.num=awl1.num*/
             left join error1 on e.user_id=error1.user_id and e.num=error1.num
--              left join rwl1 on e.user_id=rwl1.user_id and e.num=rwl1.num
             left join view1 on e.user_id=view1.user_id and e.num=view1.num
             left join fp1 on e.user_id=fp1.user_id and e.num=fp1.num
             left join m0 on e.user_id=m0.user_id and e.num=m0.num
      where e.user_id <>'0'),

n as
(select num,
--        min(addwatchlist) as awl_min,
       min(error) as error_min,
--        min(removewatchlist) as rwl_min,
       min(view) as view_min,
--        min(bates_plays) as bp_min,
       min(bates_duration) as bd_min,
--        min(heartland_plays) as hlp_min,
       min(heartland_duration) as hld_min,
--        min(other_plays) as op_min,
       min(other_duration) as od_min,
--        min(one_week_view) as owv_min,
--        min(two_week_view) as twv_min,
--        min(three_week_view) as thwv_min,
--        min(four_week_view) as fwv_min,
       min(one_week_duration) as owd_min,
       min(two_week_duration) as twd_min,
       min(three_week_duration) as thwd_min,
       min(four_week_duration) as fwd_min,
--        max(one_week_view) as owv_max,
--        max(two_week_view) as twv_max,
--        max(three_week_view) as thwv_max,
--        max(four_week_view) as fwv_max,
       max(one_week_duration) as owd_max,
       max(two_week_duration) as twd_max,
       max(three_week_duration) as thwd_max,
       max(four_week_duration) as fwd_max,
--        max(addwatchlist) as awl_max,
       max(error) as error_max,
--        max(removewatchlist) as rwl_max,
       max(view) as view_max,
--        max(bates_plays) as bp_max,
       max(bates_duration) as bd_max,
--        max(heartland_plays) as hlp_max,
       max(heartland_duration) as hld_max,
--        max(other_plays) as op_max,
       max(other_duration) as od_max
from m
where num<12 and num>=0
group by num),

num1 as
(select min(num) as num_min,
        max(num) as num_max,
        1 as code
  from m)

select m.user_id,
       status_date,
       (m.num+1)/(num_max+1) as num,
       region as state,
       churn_status,
       end_date,
       start_date,
       end_date2,
       start_date2,
       platform,
       email,
       created_at,
       topic as status,
       marketing_optin,
       month_day/31 as month_day,
--        (one_week_view-owv_min)/(owv_max-owv_min) as one_week_view,
--        (two_week_view-twv_min)/(twv_max-twv_min) as two_week_view,
--        (three_week_view-thwv_min)/(thwv_max-thwv_min) as three_week_view,
--        (four_week_view-fwv_min)/(fwv_max-fwv_min) as four_week_view,
       (one_week_duration-owd_min)/(owd_max-owd_min) as one_week_duration,
       (two_week_duration-twd_min)/(twd_max-twd_min) as two_week_duration,
       (three_week_duration-thwd_min)/(thwd_max-thwd_min) as three_week_duration,
       (four_week_duration-fwd_min)/(fwd_max-fwd_min) as four_week_duration,
--        (addwatchlist-awl_min)/(awl_max-awl_min) as addwatchlist,
       (error-error_min)/(error_max-error_min) as error,
--        (removewatchlist-rwl_min)/(rwl_max-rwl_min) as removewatchlist,
       (view-view_min)/(view_max-view_min) as view,
--        (bates_plays-bp_min)/(bp_max-bp_min) as bates_plays,
       (bates_duration-bd_min)/(bd_max-bd_min) as bates_duration,
--        (heartland_plays-hlp_min)/(hlp_max-hlp_min) as heartland_plays,
       (heartland_duration-hld_min)/(hld_max-hld_min) as heartland_duration,
--        (other_plays-op_min)/(op_max-op_min) as other_plays,
       (other_duration-od_min)/(od_max-od_min) as other_duration,
       rand() as random,
       set_cancel,
       undo_cancel,
       charge_failed
from m left join n on m.num=n.num inner join num1 on m.code=num1.code
where
-- awl_min<>awl_max and
error_min<>error_max and
-- rwl_min<>rwl_max and
view_min<>view_max and
-- bp_min<>bp_max and
bd_min<>bd_max and
-- hlp_min<>hlp_max and
hld_min<>hld_max and
-- op_min<>op_max and
od_min<>od_max);;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: set_cancel {
    type: number
    sql: ${TABLE}.set_cancel ;;
  }

  dimension: undo_cancel {
    type: number
    sql: ${TABLE}.undo_cancel ;;
  }

  dimension: charge_failed {
    type: number
    sql: ${TABLE}.charge_failed ;;
  }

  dimension: start_date2 {
    type: date
    sql: ${TABLE}.start_date2 ;;
  }

  dimension: end_date2 {
    type: date
    sql: ${TABLE}.end_date2 ;;
  }

  dimension: one_week_view {
    type: number
    sql: ${TABLE}.one_week_view ;;
  }

  dimension: two_week_view {
    type: number
    sql: ${TABLE}.two_week_view ;;
  }

  dimension: three_week_view {
    type: number
    sql: ${TABLE}.three_week_view ;;
  }

  dimension: four_week_view {
    type: number
    sql: ${TABLE}.four_week_view ;;
  }

  dimension: one_week_duration {
    type: number
    sql: ${TABLE}.one_week_duration ;;
  }

  dimension: two_week_duration {
    type: number
    sql: ${TABLE}.two_week_duration ;;
  }

  dimension: three_week_duration {
    type: number
    sql: ${TABLE}.three_week_duration ;;
  }

  dimension: four_week_duration {
    type: number
    sql: ${TABLE}.four_week_duration ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: marketing_optin {
    type: number
    sql: ${TABLE}.marketing_optin ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: random {
    type: number
    sql: ${TABLE}.random ;;
  }

  dimension_group: event_created_at {
    type: time
    sql: ${TABLE}.status_date ;;
  }

  dimension_group: customer_created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: months_since_conversion {
    type: number
    sql: ${TABLE}.months_since_conversion ;;
  }

  dimension: days_since_conversion {
    type: number
    sql: ${TABLE}.days_since_conversion ;;
  }

  dimension: num {
    type: number
    sql: ${TABLE}.num ;;
  }

  dimension: max_num {
    type: number
    sql: ${TABLE}.max_num ;;
  }

  dimension: start_date {
    type: date
    sql: ${TABLE}.start_date ;;
  }

  dimension_group: end_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_date ;;
  }

  dimension: churn_status {
    type: number
    sql: ${TABLE}.churn_status ;;
  }

  dimension: addwatchlist {
    type: number
    sql: ${TABLE}.addwatchlist ;;
  }

  dimension: error {
    type: number
    sql: ${TABLE}.error ;;
  }

  measure: error_ {
    type: sum
    sql: ${error} ;;
  }

  dimension: removewatchlist {
    type: number
    sql: ${TABLE}.removewatchlist ;;
  }

  dimension: view {
    type: number
    sql: ${TABLE}.view ;;
  }

  dimension: bates_plays {
    type: number
    sql: ${TABLE}.bates_plays ;;
  }

  dimension: bates_duration {
    type: number
    sql: ${TABLE}.bates_duration ;;
  }

  dimension: heartland_plays {
    type: number
    sql: ${TABLE}.heartland_plays ;;
  }

  dimension: heartland_duration {
    type: number
    sql: ${TABLE}.heartland_duration ;;
  }

  dimension: month_day {
    type: number
    sql: ${TABLE}.month_day ;;
  }

  dimension: other_plays {
    type: number
    sql: ${TABLE}.other_plays ;;
  }

  dimension: other_duration {
    type: number
    sql: ${TABLE}.other_duration ;;
  }

  set: detail {
    fields: [
      customer_id,
      email,
      first_name,
      last_name,
      state,
      status,
      platform,
      event_created_at_time,
      customer_created_at_time,
      months_since_conversion,
      days_since_conversion,
      num,
      churn_status,
      addwatchlist,
      error,
      removewatchlist,
      view,
      bates_plays,
      bates_duration,
      heartland_plays,
      heartland_duration,
      other_plays,
      other_duration
    ]
  }
}
