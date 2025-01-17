view: q_goal_achieved {

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
        property_event_ts_str,
        experience_goal_achieved.goalId AS goalId,
        experience_goal_achieved.goalType AS goalType,
        experience_goal_achieved.goalValue AS goalValue,
        experience_goal_achieved.goalKey AS goalKey,
        experience_goal_achieved.experienceId AS experienceId,
        experience_goal_achieved.experienceName AS experienceName,
        experience_goal_achieved.variationMasterId AS variationMasterId,
        experience_goal_achieved.variationName AS variationName,
        experience_goal_achieved.iterationName AS iterationName,
        experience_goal_achieved.iterationId AS iterationId,
        experience_goal_achieved.isControl AS isControl,
        experience_goal_achieved.first_view_meta_ts AS first_view_meta_ts,
        experience_goal_achieved.first_view_meta_recordDate AS first_view_meta_recordDate,
        experience_goal_achieved.first_view_in_iteration AS first_view_in_iteration,
        experience_goal_achieved.last_view_in_iteration AS last_view_in_iteration,
        experience_goal_achieved.is_post_goal_achieved_view AS is_post_goal_achieved_view,
        experience_goal_achieved.experience_status AS experience_status,
        experience_goal_achieved.days_experience_live AS days_experience_live,
        experience_goal_achieved.experience_first_published_at AS experience_first_published_at,
        experience_goal_achieved.iteration_published_at AS iteration_published_at,
        experience_goal_achieved.iteration_paused_at AS iteration_paused_at,
        experience_goal_achieved.experience_paused_on_view AS experience_paused_on_view,
        experience_goal_achieved.experience_last_paused_at AS experience_last_paused_at,
        experience_goal_achieved.experience_paused_within_15_days AS experience_paused_within_15_days
      FROM
        `qubit-client-{{q_view_v01.project._parameter_value}}.{{q_view_v01.site._parameter_value}}__v2.livetap_goal_achieved`
      LEFT JOIN
        UNNEST (experience_goal_achieved) as experience_goal_achieved
      WHERE
        {% condition q_view_v01.time_data_points_date  %} property_event_ts {% endcondition %}
      ;;
 }

  dimension: view_id {
    type: string
    sql: ${TABLE}.view_id ;;
    primary_key: yes
    description: "View number of the visitor, in a lifetime (only if any goal was achieved on this view or afterwards, for a certain visitor). QP fields: context_id, context_viewNumber"
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}.context_id ;;
    label: "Visitor ID"
    description: "ID unique to the visitor. QP fields: context_id"
  }

  dimension: context_view_number {
    type: number
    sql: ${TABLE}.context_viewNumber ;;
    label: "View Number"
    hidden: yes
  }

  dimension: is_post_goal_achieved_view {
    type: yesno
    sql: ${TABLE}.is_post_goal_achieved_view = 1 ;;
    label: "Include Post Goal Achieved Views?"
    description: "Set to 'No' if you do NOT require post-goal achieved analysis. Flag allows to filter views: 'yes' if you only need views that happened after user achieved a goal, 'no' if you only need views on which user achieved a goal. QP fields: derived"
  }

  dimension: experience_id {
    type: string
    sql: CAST(${TABLE}.experienceId AS STRING) ;;
    group_label: "Experience"
    description: "ID unique to the experience which the goal refers to. QP fields: experienceId"
  }

  dimension: experience_name {
    type: string
    sql: ${TABLE}.experienceName ;;
    group_label: "Experience"
    description: "The name of experience which the goal refers to. QP fields: experienceName"
    hidden:  yes
  }

  dimension: goal_id {
    type: string
    sql: CAST(${TABLE}.goalId AS STRING);;
    group_label: "Goal Achieved"
    description: "ID unique to the goal. QP fields: goalId"
  }

  dimension: goal_value {
    type: string
    sql: ${TABLE}.goalValue ;;
    group_label: "Goal Achieved"
    description: "Goal name. QP fields: goalValue"
  }

  dimension: goal_type {
    type: string
    sql: ${TABLE}.goalType ;;
    group_label: "Goal Achieved"
    description: "Goal type as specified for a given experience. QP fields: goalType"
  }

  dimension: is_control {
    type: yesno
    sql: ${TABLE}.isControl = 1;;
    group_label: "Experience"
    description: "Returns 'Yes' if the visitor is in conrtol group of experiment (on a view), otherwise returns 'No'. QP fields: isControl"
  }

  dimension: iteration_id {
    type: string
    sql: CAST(${TABLE}.iterationId AS STRING) ;;
    group_label: "Experience"
    description: "The unique ID of the experience variation shown. QP fields: iterationId"
  }

  dimension: meta_record_date {
    type: string
    sql: ${TABLE}.meta_recordDate ;;
    label: "Record Received Date"
    description: "Date for ts (in the timezone configured for the tracking ID, format yyyy-MM-dd). QP fields: meta_recordDate"
  }

  dimension_group: time_data_points {
    label: ""
    type: time
    timeframes:  [time, hour_of_day, date, day_of_week, week, week_of_year, month, month_name, quarter_of_year, year]
    sql:  ${TABLE}.property_event_ts ;;
    group_label: "⏰ Date & Time"
    description: "Timestamp of achieving the goal by the visitor. QP fields:  meta_serverTs (with applied UTC offset, for your timezone)"
    hidden: yes
  }

  dimension: variation_master_id {
    type: string
    sql: CAST( ${TABLE}.variationMasterId AS STRING) ;;
    group_label: "Experience"
    description: "Master variation ID of an experiment. The ID is assigned when a variation is launched and it is preserved throughout the experiment. QP fields: variationMasterId"
  }

  dimension: variation_name {
    type: string
    sql: ${TABLE}.variationName ;;
    group_label: "Experience"
    description: "The name assigned to variation master ID. QP fields: variationName"
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

  dimension: days_experience_live_on_visitors_view {
    type: number
    sql: ${TABLE}.days_experience_live ;;
    group_label: "Experience"
    description: "The number of days the experience had been live at the time of user's pageview"
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
    sql: ${TABLE}.experience_paused_on_view = 1;;
    group_label: "Experience"
    description: "True if experience was paused at the time of the view. NB. An experience will be visible in user's activity for up to 15 days from the time it was paused. After the cut-off period, the paused experience will no longer be included in visitor's activity"
  }

  measure: goal_achieved_visitors {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.goalId IS NOT NULL,${TABLE}.context_id,NULL))  ;;
    description: "Count of unique visitor_ids.  Only for views on which a goal was achieved or views that happened after a goal was achieved. QP fields: context_id, goalId"
  }

  measure: distinct_goals {
    type: number
    sql: COUNT(DISTINCT ${TABLE}.goalId) ;;
    description: "Count of unique goal_ids. Only for views on which a goal was achieved or views that happened after a goal was achieved. QP fields: goalId"
  }

  measure: goal_achieved_views {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.goalId IS NOT NULL,${TABLE}.view_id,NULL))  ;;
    description: "Count of unique views.  Only for views on which a goal was achieved or views that happened after a goal was achieved. QP fields: context_id, context_viewNumber, goalId"

  }

  measure: primary_goal_converters {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.goalType = 'primaryConversion', ${TABLE}.context_id,NULL))  ;;
  }

  measure: custom_goal_converters {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.goalType = 'other', ${TABLE}.context_id,NULL))  ;;
  }

  measure: days_experience_live {
    type: number
    sql:   COUNT(DISTINCT IF(${TABLE}.experience_status  = 'Live' AND ${TABLE}.meta_recordDate >= CAST(${TABLE}.experience_first_published_at as DATE), ${TABLE}.meta_recordDate, NULL) ) ;;
    group_label: "Experience"
    description: "The number of days the experience has been live as of today"
  }

}