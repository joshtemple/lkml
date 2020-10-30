view: q_experience {

  # Qubit LookML | Retail | V2
  derived_table: {
    sql: SELECT
      qp_bi_view_name,
      ts,
      property_event_ts,
      view_id,
      meta_recordDate,
      meta_trackingId,
      context_id,
      context_viewNumber,
      context_sessionNumber,
      context_conversionNumber,
      meta_ts,
      meta_serverTs,
      experience.experienceId AS experienceId,
      experience.experienceName AS experienceName,
      experience.variationMasterId AS variationMasterId,
      experience.variationName AS variationName,
      experience.iterationName AS iterationName,
      experience.iterationId AS iterationId,
      experience.isControl AS isControl,
      experience.first_view_meta_ts AS first_view_meta_ts,
      experience.first_view_meta_recordDate AS first_view_meta_recordDate,
      experience.first_view_in_iteration AS first_view_in_iteration,
      experience.last_view_in_iteration AS last_view_in_iteration,
      experience.is_post_experience_view AS is_post_experience_view,
      experience.trafficAllocation AS trafficAllocation,
      experience.experience_status AS experience_status,
      experience.days_experience_live AS days_experience_live,
      experience.experience_first_published_at AS experience_first_published_at,
      experience.iteration_published_at AS iteration_published_at,
      experience.iteration_paused_at AS iteration_paused_at,
      experience.experience_last_paused_at AS experience_last_paused_at,
      experience.experience_paused_on_view AS experience_paused_on_view,
      experience.experience_paused_within_15_days AS experience_paused_within_15_days
    FROM
      `qubit-client-{{q_view_v01.project._parameter_value}}.{{q_view_v01.site._parameter_value}}__v2.livetap_experience`
    LEFT JOIN 
      UNNEST (experience) as experience
    WHERE 
      {% condition q_view_v01.time_data_points_date  %} property_event_ts {% endcondition %}
    ;;
  }

  #Time, visitor and meta info
  dimension: view_id {
    type: string
    sql: ${TABLE}.view_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    hidden: yes
  }

  dimension: entrance_id {
    type: string
    sql: ${TABLE}.entrance_id ;;
    hidden:  yes
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}.context_id ;;
    label: "Visitor ID"
    description: "View number of the visitor, in lifetime. Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: context_viewNumber"
  }

  dimension: is_post_experience_view {
    type: yesno
    sql: ${TABLE}.is_post_experience_view = 1 ;;
    label: "Include Post Experience Views?"
    description: "'Yes' flags all views that happened after the view on which an experience was seen, while 'No' flags all views on which a certain experience was seen. Default settign - 'yes'. Set to 'no' if you don't require post-experience analysis. QP fields: derived"
  }

  dimension: context_view_number {
    type: number
    sql: ${TABLE}.first_view_in_iteration ;;
    label: "View Number"
    description: "View number of the visitor, in lifetime. Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: context_viewNumber"
  }

  dimension: last_view_in_iteration {
    type: number
    sql: ${TABLE}.last_view_in_iteration ;;
    hidden: yes
  }

  dimension: first_view_meta_ts {
    type: number
    sql: ${TABLE}.first_view_meta_ts ;;
    hidden: yes
  }

  dimension_group: time_data_points {
    label: ""
    type: time
    timeframes:  [time, hour_of_day, date, day_of_week, week, week_of_year, month, month_name, quarter_of_year, year]
    sql:  ${TABLE}.property_event_ts ;;
    group_label: "⏰ Date & Time"
    description: "Timestamp of all views that happened on or after seeing an experience. QP field: meta_serverTs (with applied UTC offset for your timezone)"
    hidden: yes
  }

  #Experience related dimensions

  dimension: experience_id {
    type: string
    sql: CAST(${TABLE}.experienceId AS STRING) ;;
    group_label: "Experience"
    description: "ID unique to the experience. QP fields: experienceId"
  }

  dimension: experience_name {
    type: string
    sql: ${TABLE}.experienceName ;;
    group_label: "Experience"
    description: "The assigned name of experience."
    hidden: yes
  }

  dimension: iteration_id {
    type: string
    sql: CAST(${TABLE}.iterationId AS STRING) ;;
    group_label: "Experience"
    description: "The unique ID of iteration. Updates when modification is made to a master variation. QP fields: iterationId"
  }

  dimension: variation_master_id {
    type: string
    sql: CAST(${TABLE}.variationMasterId AS STRING) ;;
    group_label: "Experience"
    description: "Master variation ID of an experiment. The ID is assigned when a variation is launched and it is preserved throughout the experiment. QP fields: variationMasterId"
  }

  dimension: variation_name {
    type: string
    sql: ${TABLE}.variationName ;;
    group_label: "Experience"
    description: "A name given to a master variation ID. Best to use in combination with ID as some of them may not have assigned names. QP fields: variationName"
  }

  dimension: is_control {
    type: yesno
    sql: ${TABLE}.isControl = 1 ;;
    label: "Control"
    group_label: "Experience"
    description: "Returns Yes if the visitor is in contol group of experiment (on a page view), otherwise returns No. QP fields: isControl"
  }

  dimension: traffic_allocation {
    type: number
    sql: if (${TABLE}.trafficAllocation is not null, CAST(${TABLE}.trafficAllocation as NUMERIC), 1) ;;
    group_label: "Experience"
  }

  dimension: days_experience_live_on_visitors_view {
    type: number
    sql: ${TABLE}.days_experience_live ;;
    group_label: "Experience"
    description: "The number of days the experience had been live at the time of user's pageview"
  }

  dimension: experience_status_as_of_date {
    type: string
    sql: CASE
     WHEN ${TABLE}.experience_paused_within_15_days = 1  THEN 'Paused for 15 days or less'
     WHEN ${TABLE}.experience_status         = 'Paused'  THEN 'Paused for more than 15 days'
     WHEN ${TABLE}.experience_status         = 'Live'    THEN 'Live'
     END
       ;;
    label: "Experience Status As Of Date "
    group_label: "Experience"
    description: "Status of the experience at the time of pageview"
  }

  dimension: experience_paused_15_days_window {
      type: yesno
      sql: ${TABLE}.experience_paused_within_15_days = 1 ;;
      label: "Experience Paused - 15-day window"
      group_label: "Experience"
      description: "True if view happened within 15 days of the date experience being paused "
      hidden: yes
  }

  dimension: iteration_published_at {
    type: date
    sql: TIMESTAMP(${TABLE}.iteration_published_at) ;;
    group_label: "Experience"
    description: "Date the iteration was published"
  }

  dimension: iteration_paused_at {
    type: date
    sql: TIMESTAMP(${TABLE}.iteration_paused_at) ;;
    group_label: "Experience"
    description: "Date the iteration was paused"
  }

  dimension: experience_paused_on_view {
    type: yesno
    sql: ${TABLE}.experience_paused_on_view = 1 ;;
    group_label: "Experience"
    description: "True if experience was paused at the time of the view. NB. An experience will be visible in user's activity for up to 15 days from the time it was paused. After the cut-off period, the paused experience will no longer be included in visitor's activity"
  }

  #Measures

  measure: experience_visitors {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.experienceId IS NOT NULL,${TABLE}.context_id,NULL))  ;;
    description: "Count of unique visitor_ids.  Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: context_id, experienceId"
  }

  measure: distinct_experiences {
    type: number
    sql: COUNT(DISTINCT ${TABLE}.experienceId) ;;
    description: "Count of unique experience_ids.  QP fields: experienceId"
  }

  measure: visitor_conversion_rate {
    type: number
    sql: SAFE_DIVIDE(${experience_converters},COUNT(DISTINCT ${TABLE}.context_id)) ;;
    value_format_name: percent_2
    description: "Share of unique visitors on views that are labeled with any non-null transaction_id in all visitors. Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: context_id, transaction_id"
  }

  measure: experience_views {
    type: number
    sql: COUNT(DISTINCT ${TABLE}.view_id) ;;
    description: "Count of unique combinations of a visitor_id and a view_number.  Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: context_id, context_viewNumber"
  }

  measure: experience_converters {
    type: number
    sql: COUNT(DISTINCT IF(${q_transaction_v01.transaction_id} IS NOT NULL,${TABLE}.context_id,NULL)) ;;
    description: "Count of unique visitor_ids on views that are labeled with any non-null transaction_id.  Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: context_id, transaction_id"
  }

  measure: transaction_total {
    type: sum_distinct
    sql_distinct_key: ${q_transaction_v01.transaction_id} ;;
    sql: CASE WHEN ${TABLE}.experienceId IS NOT NULL THEN ${q_transaction_v01.transaction_total} END ;;
    value_format_name: decimal_2
    description: "Sum of transaction_total. Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: experienceId, basket_total_baseValue"
  }

  measure: transactions {
    type: number
    sql: COUNT(DISTINCT CASE WHEN ${TABLE}.experienceId IS NOT NULL THEN ${q_transaction_v01.transaction_id} END) ;;
  description: "Count of unique transaction_ids (always exact count). Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: transaction_id, experienceId"
  }

  measure: revenue_per_visitor {
    type: number
    sql: SAFE_DIVIDE(${q_experience_v01.transaction_total}, ${q_experience_v01.experience_visitors}) ;;
    value_format_name: decimal_2
    description: "Sum of transaction_total divided by count of unique visitor_ids. Only for views on which an experience was seen or views that happened after an experience was seen. QP fields: basket_total_baseValue, context_id, experienceId"
  }

  measure: latest_traffic_allocation {
    type: number
    sql: CAST(COALESCE(SUBSTR(MAX(CONCAT(IF(${TABLE}.trafficAllocation = 0, NULL, CAST(${TABLE}.meta_recordDate AS STRING)), CAST(CAST(IF(${TABLE}.trafficAllocation = 0, NULL,${TABLE}.trafficAllocation) AS FLOAT64) AS STRING))),11),'0.00') AS FLOAT64);;
  }

  measure: days_experience_live {
    type: number
    sql:   COUNT(DISTINCT IF(${TABLE}.experience_status  = 'Live' AND cast(${TABLE}.meta_recordDate as string) >= ${TABLE}.experience_first_published_at, ${TABLE}.meta_recordDate, NULL) ) ;;
    description: "The number of days the experience has been live as of today"
  }
}