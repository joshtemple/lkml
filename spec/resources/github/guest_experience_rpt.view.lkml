view: guest_experience_rpt {
  sql_table_name: pedw.fact.guest_experience_f ;;

# Keys

  dimension: property_key{
    type: number
    sql: ${TABLE}.property_key ;;
    hidden: yes
  }

  dimension: response_date_sid {
    type: number
    value_format_name: id
    sql: ${TABLE}.response_date_sid ;;
    hidden: yes
  }

  dimension: checkin_date_sid {
    type: number
    value_format_name: id
    sql: ${TABLE}.checkin_date_sid ;;
    hidden: yes
  }

  dimension: checkout_date_sid {
    type: number
    value_format_name: id
    sql: ${TABLE}.checkout_date_sid ;;
    hidden: yes
  }

  #--------------------------------------------------------------------------------
  #-- dimensions
  #--------------------------------------------------------------------------------
  dimension: review_id {
    view_label: "Guest Feedback"
    label: "Review ID"
    description: "Review ID within Revinate."
    type: string
    sql: ${TABLE}.review_id ;;
  }

  dimension: review_title {
    view_label: "Guest Feedback"
    label: "Review Title"
    description: "Review title entered by guest."
    type: string
    sql: ${TABLE}.review_title ;;
  }

  dimension: review_trip_type_cd {
    view_label: "Guest Feedback"
    label: "Review Trip Type"
    description: "Type of trip guest was on."
    type: string
    sql: ${TABLE}.review_trip_type_cd ;;
  }

  dimension: review_site_name {
    view_label: "Guest Feedback"
    label: "Review Site"
    type: string
    sql: ${TABLE}.review_site_name ;;
  }

  dimension: review_site_url {
    view_label: "Guest Feedback"
    label: "Review Site URL"
    type: string
    sql: ${TABLE}.review_site_url ;;
  }

  dimension: review_subratings_str {
    view_label: "Guest Feedback"
    label: "Review Subratings"
    description: "Review Subratings"
    type: string
    sql: ${TABLE}.review_subratings_str ;;
  }

  dimension: feedback_method_name {
    view_label: "Guest Feedback"
    label: "Feedback Method"
    description: "Review, guest survey, meeting survey."
    type: string
    sql: ${TABLE}.feedback_method_name ;;
  }

  dimension: feedback_topic_name {
    view_label: "Guest Feedback"
    label: "Feedback Topic"
    description: "Review or survey topic."
    type: string
    sql: ${TABLE}.feedback_topic_name ;;
  }

  dimension: question_type_name {
    view_label: "Guest Feedback"
    label: "Question Type"
    description: "Range, rating, yesno, text, multi-choice."
    type: string
    sql: ${TABLE}.question_type_name ;;
  }

  filter: question_common_bt {
    view_label: "Guest Feedback"
    label: "Common Question"
    description: "Common questions with assigned goals."
    type: yesno
    sql: ${TABLE}.question_common_bt ;;
  }

  dimension: question_name {
    view_label: "Guest Feedback"
    label: "Question"
    description: "Full question from survey."
    type: string
    sql: ${TABLE}.question_name ;;
  }

  dimension: question_options_str {
    view_label: "Guest Feedback"
    label: "Question Options"
    description: "Options presented for answering the question."
    type: string
    sql: ${TABLE}.question_options_str ;;
  }

  dimension: answer_score_no {
    view_label: "Guest Feedback"
    label: "Answer Score"
    description: "Rating or score given as the guest response."
    type: number
    sql: ${TABLE}.answer_score_no ;;
  }

  dimension: answer_score_range_str {
    view_label: "Guest Feedback"
    label: "Answer Score Range"
    description: "Rating or score given as the guest response, as a tier."
    type: string
    sql: case
            when ${TABLE}.answer_score_no > 0 and ${TABLE}.answer_score_no <= 1 then '0.1 - 1.0'
            when ${TABLE}.answer_score_no > 1 and ${TABLE}.answer_score_no <= 2 then '1.1 - 2.0'
            when ${TABLE}.answer_score_no > 2 and ${TABLE}.answer_score_no <= 3 then '2.1 - 3.0'
            when ${TABLE}.answer_score_no > 3 and ${TABLE}.answer_score_no <= 4 then '3.1 - 4.0'
            when ${TABLE}.answer_score_no > 4 and ${TABLE}.answer_score_no <= 5 then '4.1 - 5.0'
            else 'No Score'
        end
    ;;
  }

  dimension: answer_str {
    view_label: "Guest Feedback"
    label: "Answer Text"
    description: "Multi-choice or text answer given by the guest."
    type: string
    sql: ${TABLE}.answer_str ;;
  }

  dimension: booking_channel_cd {
    view_label: "Guest Stay"
    label: "Booking Channel Cd"
    type: string
    sql: ${TABLE}.booking_channel_cd ;;
  }

  dimension: guest_title_cd {
    view_label: "Guest Stay"
    label: "Guest Title"
    type: string
    sql: ${TABLE}.guest_title_cd ;;
  }

  dimension: guest_name {
    view_label: "Guest Stay"
    label: "Guest"
    type: string
    sql: ${TABLE}.review_guest_name ;;
  }

  dimension: guest_location_name {
    view_label: "Guest Stay"
    label: "Guest City, State"
    type: string
    sql: ${TABLE}.review_guest_location_str ;;
  }

  dimension: review_guest_language_name {
    view_label: "Guest Stay"
    label: "Guest Language"
    type: string
    sql: ${TABLE}.review_guest_language_name ;;
  }

  dimension: guest_state_cd {
    view_label: "Guest Stay"
    label: "Guest State Cd"
    type: string
    sql: ${TABLE}.guest_state_cd ;;
  }

  dimension: guest_adrs1 {
    view_label: "Guest Stay"
    label: "Guest Address"
    type: string
    sql: ${TABLE}.guest_adrs1 ;;
  }

  dimension: guest_adrs2 {
    view_label: "Guest Stay"
    label: "Guest Address2"
    type: string
    sql: ${TABLE}.guest_adrs2 ;;
  }

  dimension: guest_city_name {
    view_label: "Guest Stay"
    label: "Guest City"
    type: string
    sql: ${TABLE}.guest_city_name ;;
  }

  dimension: guest_country_cd {
    view_label: "Guest Stay"
    label: "Guest Country Cd"
    type: string
    sql: ${TABLE}.guest_country_cd ;;
  }

  dimension: guest_email {
    view_label: "Guest Stay"
    label: "Guest Email"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: guest_email_domain {
    view_label: "Guest Stay"
    label: "Guest Email Domain"
    type: string
    sql: ${TABLE}.guest_email_domain ;;
  }

  dimension: guest_phone {
    view_label: "Guest Stay"
    label: "Guest Phone"
    type: string
    sql: ${TABLE}.guest_phone ;;
  }

  dimension: guest_postcode {
    view_label: "Guest Stay"
    label: "Guest Zip/Province Cd"
    type: string
    sql: ${TABLE}.guest_postcode ;;
  }

  dimension: room_type_cd {
    view_label: "Guest Stay"
    label: "Room Type Cd"
    type: string
    sql: ${TABLE}.room_type_cd ;;
  }

  dimension: room_no {
    view_label: "Guest Stay"
    label: "Room No."
    type: string
    sql: ${TABLE}.room_no ;;
  }

  dimension: rate_plan_cd {
    view_label: "Guest Stay"
    label: "Rate Plan Cd"
    type: string
    sql: ${TABLE}.rate_plan_cd ;;
  }

  #--------------------------------------------------------------------------------
  #-- measures
  #--------------------------------------------------------------------------------
  measure: property_cnt {
    label: "Properties"
    description: "Count of distinct properties."
    type: count_distinct
    sql: ${property_key} ;;
    value_format_name: decimal_0
  }

  measure: response_cnt {
    label: "Responses"
    description: "Count of distinct responses."
    type: count_distinct
    sql: ${TABLE}.review_id ;;
    value_format_name: decimal_0
  }

  measure: response_day_cnt {
    label: "Response Days"
    description: "Count of distinct days with responses."
    type: count_distinct
    sql: ${response_date_sid} ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: response_score_no {
    label: "Score No"
    description: "Avg Response Score"
    type: average
    sql: ${answer_score_no} ;;
    value_format_name: decimal_2
  }

  measure: avg_daily_response_cnt {
    label: "Responses/Day"
    description: "Average responses per day."
    type: number
    sql: utl..udf_divide( ${response_cnt}, ${response_day_cnt} ) ;;
    value_format_name: decimal_1
  }

  measure: response_cnt_pct_total {
    label: "Responses % Total"
    description: "% of total responses"
    type: percent_of_total
    sql: ${response_cnt} ;;
    value_format: "0.0\%"
  }

  measure: response_score_no_pct_prev {
    label: "Score No % Prev"
    description: "Score No"
    type: percent_of_previous
    sql: ${response_score_no} ;;
    value_format: "0.0\%"
    html:
        {% if value < 0 %}
        <font color="red">{{ rendered_value }}</font>
        {% endif %};;
  }

  measure: response_cnt_pct_prev {
    label: "Responses % Prev"
    description: "Score No"
    type: percent_of_previous
    sql: ${response_cnt} ;;
    value_format: "0.0\%"
    html:
        {% if value < 0 %}
        <font color="red">{{ rendered_value }}</font>
        {% endif %};;
  }

  #--------------------------------------------------------------------------------
  #-- measure stats
  #--------------------------------------------------------------------------------
  measure: response_score_min {
    view_label: "Stats"
    label: "Score Min"
    description: "Minimum Score Value"
    type: min
    sql: ${answer_score_no} ;;
    value_format_name: decimal_2
  }

  measure: response_score_quartile_1 {
    view_label: "Stats"
    label: "Score 25th Percentile"
    description: "25th Percentile (Q1)"
    type: percentile
    percentile:  25
    sql: ${answer_score_no} ;;
    value_format_name: decimal_2
  }

  measure: response_score_med {
    view_label: "Stats"
    label: "Score Median"
    description: "Median Score Value (50th Percentile)"
    type: median
    sql: ${answer_score_no} ;;
    value_format_name: decimal_2
  }

  measure: response_score_quartile_3 {
    view_label: "Stats"
    label: "Score 75th Percentile"
    description: "75th Percentile (Q3)"
    type: percentile
    percentile:  55
    sql: ${answer_score_no} ;;
    value_format_name: decimal_2
  }

  measure: response_score_max {
    view_label: "Stats"
    label: "Score Max"
    description: "Maximum Score Value"
    type: max
    sql: ${answer_score_no} ;;
    value_format_name: decimal_2
  }

}
