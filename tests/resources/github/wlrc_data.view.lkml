view: wlrc_data {
  sql_table_name: FELIX_UPLOADS.WLRC_DATA ;;

  dimension: responseid {
    primary_key: yes
    type: string
    sql: ${TABLE}."RESPONSEID" ;;
  }

### TIME & DATE START ###
  dimension: Year {
    view_label: "Time & Date"
    type: string
    sql: ${TABLE}."SUBMISSSIONWLRC" ;;
  }

  dimension: time_category {
    view_label: "Time & Date"
    type: string
    sql: ${TABLE}."TIME_CATEGORY" ;;
  }

  dimension: status {
    view_label: "Time & Date"
    type: string
    sql: ${TABLE}."STATUS" ;;
  }
### TIME & DATE ENDS ###

  ### LOCATION START ###
  dimension: ipaddress {
    view_label: "Location"
    type: string
    sql: ${TABLE}."IPADDRESS" ;;
  }

  dimension: longitude {
    view_label: "Location"
    type: string
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: latitude {
    view_label: "Location"
    type: string
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: living_in_usa {
    view_label: "Location"
    type: string
    sql: ${TABLE}."LIVING_IN_USA" ;;
  }

  dimension: country {
    view_label: "Location"
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
  }

  dimension: others_country_practice {
    view_label: "Location"
    type: string
    sql: ${TABLE}."OTHERS_COUNTRY_PRACTICE" ;;
  }

  dimension: state {
    view_label: "Location"
    type: string
    map_layer_name: us_states
    sql: ${TABLE}."STATE" ;;
  }

  dimension: us_state_practice {
    view_label: "Location"
    type: string
    sql: ${TABLE}."US_STATE_PRACTICE" ;;
  }

  dimension: city {
    view_label: "Location"
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: us_city_meet {
    view_label: "Location"
    type: string
    sql: ${TABLE}."US_CITY_MEET" ;;
  }

  dimension: others_city_meet {
    view_label: "Location"
    type: string
    sql: ${TABLE}."OTHERS_CITY_MEET" ;;
  }

  dimension: postal {
    view_label: "Location"
    type: string
    sql: ${TABLE}."POSTAL" ;;
  }

  dimension: school_name {
    view_label: "Location"
    type: string
    sql: ${TABLE}."SCHOOL_NAME" ;;
  }

  dimension: school_zip {
    view_label: "Location"
    type: string
    sql: ${TABLE}."SCHOOL_ZIP" ;;
  }
### LOCATION ENDS ###

### US SCHOOL START ###
  dimension: pid {
    view_label: "US School"
    type: string
    sql: ${TABLE}."PID" ;;
  }

  dimension: pid_available {
    view_label: "US School"
    type: string
    sql: ${TABLE}."PID_AVAILABLE" ;;
  }
### US SCHOOL ENDS ###

### COACH DEMOGRAPHIC START ###
  measure: gravity {
    view_label: "Coach Demographic"
    type: sum
    sql: ${TABLE}."ROBOTS" ;;
  }

  dimension: coach_demographic_email {
    view_label: "Coach Demographic"
    type: string
    sql: ${TABLE}."COACH_DEMOGRAPHIC_EMAIL" ;;
  }

  dimension: upper_coach_demographic_email {
    view_label: "Coach Demographic"
    type: string
    sql: UPPER(${TABLE}."COACH_DEMOGRAPHIC_EMAIL") ;;
  }

  measure: unique_coach_email {
    view_label: "Coach Demographic"
    type: count_distinct
    sql: ${TABLE}."COACH_DEMOGRAPHIC_EMAIL" ;;
  }

  dimension: coach_demographic_firstname {
    view_label: "Coach Demographic"
    type: string
    sql: ${TABLE}."COACH_DEMOGRAPHIC_FIRSTNAME" ;;
  }

  dimension: coach_demographic_lastname {
    view_label: "Coach Demographic"
    type: string
    sql: ${TABLE}."COACH_DEMOGRAPHIC_LASTNAME" ;;
  }

  dimension: coach_demographic_twitter {
    view_label: "Coach Demographic"
    type: string
    sql: ${TABLE}."COACH_DEMOGRAPHIC_TWITTER" ;;
  }

  dimension: coach_affiliation {
    type: string
    sql: ${TABLE}."COACH_AFFILIATION" ;;
  }

  dimension: coach_affiliation_others {
    type: string
    sql: ${TABLE}."COACH_AFFILIATION_OTHERS" ;;
  }
### COACH DEMOGRAPHIC ENDS ###

### COACH RECURRING START ###
  dimension: coach_recurring {
    type: string
    sql: ${TABLE}."COACH_RECURRING" ;;
  }

  dimension: coach_recurring_y1 {
    type: number
    sql: ${TABLE}."COACH_RECURRING_Y1" ;;
  }

  dimension: coach_recurring_y2 {
    type: number
    sql: ${TABLE}."COACH_RECURRING_Y2" ;;
  }

  dimension: coach_recurring_y3 {
    type: number
    sql: ${TABLE}."COACH_RECURRING_Y3" ;;
  }
### COACH RECURRING ENDS ###

### COACH AGE CATEGORY START ###
  view_label: "Coach Age Category"
    dimension: coach_ages_6_8 {
    type: number
    sql: ${TABLE}."COACH_AGES_6_8" ;;
  }

  dimension: coach_ages_9_11 {
    view_label: "Coach Age Category"
    type: number
    sql: ${TABLE}."COACH_AGES_9_11" ;;
  }

  dimension: coach_ages_12_14 {
    view_label: "Coach Age Category"
    type: number
    sql: ${TABLE}."COACH_AGES_12_14" ;;
  }
### COACH AGE CATEGORY ENDS ###

### AGE CATEGORY COUNT START ###
  measure: calculate_12_14_team {
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_12_14_TEAM" ;;
  }

  measure: calculate_6_8_team {
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_6_8_TEAM" ;;
  }

  measure: calculate_9_11_team {
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_9_11_TEAM" ;;
  }

  measure: total_aged_5_6 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_5_6" ;;
  }

  measure: total_aged_6 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_6" ;;
  }

  measure: total_aged_7 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_7" ;;
  }

  measure: total_aged_8 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_8" ;;
  }

  measure: total_aged_8_9 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_8_9" ;;
  }

  measure: total_aged_9 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_9" ;;
  }

  measure: total_aged_10 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_10" ;;
  }

  measure: total_aged_11 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_11" ;;
  }

  measure: total_aged_11_12 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_11_12" ;;
  }

  measure: total_aged_12 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_12" ;;
  }

  measure: total_aged_13 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_13" ;;
  }

  measure: total_aged_14 {
    hidden: yes
    view_label: "Age Category Count"
    type: sum
    sql: ${TABLE}."CALCULATE_AGED_14" ;;
  }

  measure: total_participants_age_weighted {
    view_label: "Age Category Count"
    hidden: yes
    type: number
    sql:
    ${total_aged_5_6}*5.5+
    ${total_aged_6}*6+
    ${total_aged_7}*7+
    ${total_aged_8}*8+
    ${total_aged_8_9}*8.5+
    ${total_aged_9}*9+
    ${total_aged_10}*10+
    ${total_aged_11}*11+
    ${total_aged_11_12}*11.5+
    ${total_aged_12}*12+
    ${total_aged_13}*13+
    ${total_aged_14}*14
    ;;
  }

  measure: total_participants_age_count {
    hidden: yes
    view_label: "Age Category Count"
    type: number
    sql:
    ${total_aged_5_6}+
    ${total_aged_6}+
    ${total_aged_7}+
    ${total_aged_8}+
    ${total_aged_8_9}+
    ${total_aged_9}+
    ${total_aged_10}+
    ${total_aged_11}+
    ${total_aged_11_12}+
    ${total_aged_12}+
    ${total_aged_13}+
    ${total_aged_14}
    ;;
  }

  measure: participants_average_age {
    view_label: "Age Category Count"
    type: number
    sql:  1.0*${total_participants_age_weighted}/nullif(${total_participants_age_count},0) ;;
    value_format: "0.00"
  }
### AGE CATEGORY COUNT ENDS ###

### TEAM COUNT START ###
  measure: calculate_team_members {
    view_label: "Team Count"
    type: sum
    sql: ${TABLE}."CALCULATE_TEAM_MEMBERS" ;;
  }

  measure: calculate_team_submission {
    view_label: "Team Count"
    type: sum
    sql: ${TABLE}."CALCULATE_TEAM_SUBMISSION" ;;
  }

  measure: team_submission_1718 {
    view_label: "Team Count"
    type: sum
    sql: ${TABLE}."CALCULATE_TEAM_SUBMISSION" where ${Year}="1718" ;;
  }

  measure: coach_team_count {
    view_label: "Team Count"
    type: sum
    sql: ${TABLE}."COACH_TEAM_COUNT" ;;
  }

  measure: coach_team_help {
    view_label: "Team Count"
    type: sum
    sql: ${TABLE}."COACH_TEAM_HELP" ;;
  }

  measure: coach_total_kids {
    view_label: "Team Count"
    type: sum
    sql: ${TABLE}."COACH_TOTAL_KIDS" ;;
  }
### TEAM COUNT ENDS ###

### GENDER COUNT START ###
  measure: calculate_female_count {
    view_label: "Gender Count"
    type: sum
    sql: ${TABLE}."CALCULATE_FEMALE_COUNT" ;;
  }

  measure: calculate_male_count {
    view_label: "Gender Count"
    type: sum
    sql: ${TABLE}."CALCULATE_MALE_COUNT" ;;
  }

  measure: calculate_other_count {
    view_label: "Gender Count"
    type: sum
    sql: ${TABLE}."CALCULATE_OTHER_COUNT" ;;
  }
  ### GENDER COUNT ENDS ###

  dimension: referral {
    type: string
    sql: ${TABLE}."REFERRAL" ;;
}

  measure: count {
    type: count
    drill_fields: [school_name, coach_demographic_firstname, coach_demographic_lastname]
  }
  }

#   dimension: time {
#     type: string
#     sql: ${TABLE}."TIME" ;;
#   }
#   dimension: time_day {
#     type: string
#     sql: ${TABLE}."TIME_DAY" ;;
#   }
#
#   dimension: time_hours {
#     type: string
#     sql: ${TABLE}."TIME_HOURS" ;;
#   }
#
#   dimension: time_minutes {
#     type: string
#     sql: ${TABLE}."TIME_MINUTES" ;;
#   }
#
#   dimension: time_start {
#     type: string
#     sql: ${TABLE}."TIME_START" ;;
#   }
#
#   dimension: time_end {
#     type: string
#     sql: ${TABLE}."TIME_END" ;;
#   }
