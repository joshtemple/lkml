view: get_view_video_test {
  derived_table: {
    sql: select view_event.content_id,
        view_event.videoname,
        view_event.videodescr,
        view_event.descr,
        view_event.sess_id,
        view_event.sessiontime,
        view_event.secondfrom70,
        view_event.videoviewlength,
        view_event.watcher,
        view_event.clientowner_id,
        view_event.clientname,
        view_event.eventtime,
        view_event.startsession,
        view_event.session_id
    from
      (select
       a_videostopwatchvideoid as content_id,
       coalesce(a_videostopwatchvideoname, '-') as videoname,
       coalesce(a_videostopwatchvideodescription, '-') as videodescr,
       coalesce(a_videostopwatchwatcherusername, '-') as descr,
       '' as sess_id,
       arrival_timestamp as sessiontime,
      date_part(epoch, arrival_timestamp) as secondfrom70,
      case when coalesce(m_videostopwatchplaybackstoppedtime, 0) <= 0 then
           m_videostopwatchvideolength - coalesce(m_videostopwatchplaybackstartedtime, 0)
       else
           m_videostopwatchplaybackstoppedtime - coalesce(m_videostopwatchplaybackstartedtime, 0)
       end as videoviewlength,
         a_videostopwatchwatcheridentityid as watcher,
         a_videostopwatchvideocreatorid as clientowner_id,
         coalesce(a_videostopwatchwatcherusername, '-') as clientname,
         event_timestamp as eventtime,
         session_start_timestamp as startsession,
         session_id as session_id
from billing.post_event
where event_type = 'VideoStopWatchEvent'
and a_videostopwatchvideocreatorid is not null
and a_videostopwatchvideocreatorid <> a_videostopwatchwatcheridentityid
) as view_event
where view_event.videoviewlength > 0
;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: content_id {
    type: string
    sql: ${TABLE}.content_id ;;
  }

  dimension: videoname {
    type: string
    sql: ${TABLE}.videoname ;;
  }

  dimension: videodescr {
    type: string
    sql: ${TABLE}.videodescr ;;
  }

  dimension: descr {
    type: string
    sql: ${TABLE}.descr ;;
  }

  dimension: sess_id {
    type: string
    sql: ${TABLE}.sess_id ;;
  }

  dimension_group: sessiontime {
    type: time
    sql: ${TABLE}.sessiontime ;;
  }

  dimension: secondfrom70 {
    type: number
    sql: ${TABLE}.secondfrom70 ;;
  }

  dimension: videoviewlength {
    type: number
    sql: ${TABLE}.videoviewlength ;;
  }

  dimension: watcher {
    type: string
    sql: ${TABLE}.watcher ;;
  }

  dimension: clientowner_id {
    type: string
    sql: ${TABLE}.clientowner_id ;;
  }

  dimension: clientname {
    type: string
    sql: ${TABLE}.clientname ;;
  }

  dimension: eventtime {
    type: date_millisecond125
    sql: ${TABLE}.eventtime ;;
  }

  dimension: startsession {
    type: date_millisecond125
    sql: ${TABLE}.startsession ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  set: detail {
    fields: [
      content_id,
      videoname,
      videodescr,
      descr,
      sess_id,
      sessiontime_time,
      secondfrom70,
      videoviewlength,
      watcher,
      clientowner_id,
      clientname,
      eventtime,
      startsession,
      session_id
    ]
  }
}
