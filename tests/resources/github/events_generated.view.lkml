#### Event Properties ####
view: events_generated {
  extension: required

  dimension: first_visit.page_location {
    type: string
    sql: CASE WHEN ${event_name} = 'first_visit' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_location')
       END ;;
  }

  dimension: first_visit.ga_session_number {
    type: number
    sql: CASE WHEN ${event_name} = 'first_visit' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_number')
       END ;;
  }

  dimension: first_visit.page_referrer {
    type: string
    sql: CASE WHEN ${event_name} = 'first_visit' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_referrer')
       END ;;
  }

  dimension: first_visit.ga_session_id {
    type: number
    sql: CASE WHEN ${event_name} = 'first_visit' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_id')
       END ;;
  }

  dimension: first_visit.session_engaged {
    type: number
    sql: CASE WHEN ${event_name} = 'first_visit' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'session_engaged')
       END ;;
  }

  dimension: first_visit.page_title {
    type: string
    sql: CASE WHEN ${event_name} = 'first_visit' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_title')
       END ;;
  }

  dimension: page_view.session_engaged {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'session_engaged')
       END ;;
  }

  dimension: page_view.source {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'source')
       END ;;
  }

  dimension: page_view.term {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'term')
       END ;;
  }

  dimension: page_view.entrances {
    type: number
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'entrances')
       END ;;
  }

  dimension: page_view.ga_session_id {
    type: number
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_id')
       END ;;
  }

  dimension: page_view.page_location {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_location')
       END ;;
  }

  dimension: page_view.page_title {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_title')
       END ;;
  }

  dimension: page_view.engaged_session_event {
    type: number
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'engaged_session_event')
       END ;;
  }

  dimension: page_view.ga_session_number {
    type: number
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_number')
       END ;;
  }

  dimension: page_view.origin {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'origin')
       END ;;
  }

  dimension: page_view.page_referrer {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_referrer')
       END ;;
  }

  dimension: page_view.medium {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'medium')
       END ;;
  }

  dimension: page_view.campaign {
    type: string
    sql: CASE WHEN ${event_name} = 'page_view' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'campaign')
       END ;;
  }

  dimension: session_start.page_title {
    type: string
    sql: CASE WHEN ${event_name} = 'session_start' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_title')
       END ;;
  }

  dimension: session_start.engaged_session_event {
    type: number
    sql: CASE WHEN ${event_name} = 'session_start' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'engaged_session_event')
       END ;;
  }

  dimension: session_start.page_location {
    type: string
    sql: CASE WHEN ${event_name} = 'session_start' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_location')
       END ;;
  }

  dimension: session_start.ga_session_number {
    type: number
    sql: CASE WHEN ${event_name} = 'session_start' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_number')
       END ;;
  }

  dimension: session_start.page_referrer {
    type: string
    sql: CASE WHEN ${event_name} = 'session_start' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_referrer')
       END ;;
  }

  dimension: session_start.session_engaged {
    type: number
    sql: CASE WHEN ${event_name} = 'session_start' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'session_engaged')
       END ;;
  }

  dimension: session_start.ga_session_id {
    type: number
    sql: CASE WHEN ${event_name} = 'session_start' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_id')
       END ;;
  }

  dimension: user_engagement.medium {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'medium')
       END ;;
  }

  dimension: user_engagement.page_referrer {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_referrer')
       END ;;
  }

  dimension: user_engagement.ga_session_number {
    type: number
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_number')
       END ;;
  }

  dimension: user_engagement.ga_session_id {
    type: number
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'ga_session_id')
       END ;;
  }

  dimension: user_engagement.session_engaged {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'session_engaged')
       END ;;
  }

  dimension: user_engagement.term {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'term')
       END ;;
  }

  dimension: user_engagement.origin {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'origin')
       END ;;
  }

  dimension: user_engagement.page_title {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_title')
       END ;;
  }

  dimension: user_engagement.engaged_session_event {
    type: number
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'engaged_session_event')
       END ;;
  }

  dimension: user_engagement.engagement_time_msec {
    type: number
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.int_value
             FROM UNNEST(${event_params})
             WHERE key = 'engagement_time_msec')
       END ;;
  }

  dimension: user_engagement.source {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'source')
       END ;;
  }

  dimension: user_engagement.page_location {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'page_location')
       END ;;
  }

  dimension: user_engagement.campaign {
    type: string
    sql: CASE WHEN ${event_name} = 'user_engagement' THEN
         (SELECT value.string_value
             FROM UNNEST(${event_params})
             WHERE key = 'campaign')
       END ;;
  }

}
