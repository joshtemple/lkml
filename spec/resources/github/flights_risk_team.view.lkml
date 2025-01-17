include: "flights.view.lkml"

view: flights_risk_team {
  extends: [flights]

  required_access_grants: [only_advanced_users]

  #########################
  #### Scoring Airports
  #########################

  ## Score based on three factors:
  ## What % of flights delayed
  ## What % of flying minutes delayed
  ## % flights above 2 hours
  ## Lower scores are BETTER

  ## % Flying Minutes delayed

  measure: average_delay_length {
    view_label: "Risk Team"
    group_label: "Risk Score Building Blocks"
    type: average
    sql: ${flights.dep_delay} ;;
    value_format_name: decimal_1
  }

  measure: percent_flying_minutes_delayed {
    group_label: "Risk Score Building Blocks"
    view_label: "Risk Team"
    description: "Take average delay across flights as a percent of their total flight length"
    type: number
    sql: 1.0 * ${average_delay_length} / ${flights.average_flight_length} ;;
    value_format_name: percent_2
    drill_fields: [drill*]
    link: {
      label: "More information here"
      url: "https://drive.google.com/file/d/1Z-vnLla82zHQT0h1lrltTxJBx8dQduHU/view"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  ## Flights > 2 hours

  measure: count_flights_above_2_horus {
    group_label: "Risk Score Building Blocks"
    view_label: "Risk Team"
    type: count
    filters: {
      field: minutes_flight_length
      value: ">120"
    }
    drill_fields: [drill*]
  }

  measure: percent_flights_above_2_hours {
    group_label: "Risk Score Building Blocks"
    view_label: "Risk Team"
    type: number
    sql: 1.0 * ${count_flights_above_2_horus} / nullif(${flights.flight_count},0) ;;
    value_format_name: percent_2
    drill_fields: [drill*]
    link: {
      label: "More information here"
      url: "https://drive.google.com/file/d/1Z-vnLla82zHQT0h1lrltTxJBx8dQduHU/view"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  ## Establish weights (for weighted average)

  parameter: weight_percent_flights_delayed {
    view_label: "Risk Team"
    type:  unquoted
    default_value: "4"
  }

  parameter: weight_percent_flight_minutes_delayed {
    view_label: "Risk Team"
    type:  unquoted
    default_value: "2"
  }

  parameter: weight_percent_flight_over_2_hours {
    view_label: "Risk Team"
    type:  unquoted
    default_value: "1"
  }

  dimension: weight_percent_flights_delayed_value {
    type: number
    sql: {% parameter weight_percent_flights_delayed %} ;;
    hidden:  yes
  }

  dimension: weight_percent_flight_minutes_delayed_value {
    type: number
    sql: {% parameter weight_percent_flight_minutes_delayed %} ;;
    hidden:  yes
  }

  dimension: weight_percent_flight_over_2_hours_value {
    type: number
    sql: {% parameter weight_percent_flight_over_2_hours %} ;;
    hidden:  yes
  }

  dimension: sum_weights_dimension {
    type: number
    hidden: yes
    sql:    ${weight_percent_flights_delayed_value} +
            ${weight_percent_flight_minutes_delayed_value} +
            ${weight_percent_flight_over_2_hours_value}
            ;;
  }

  ## Calculate Risk Score

  dimension: risk_score_dimension {
    view_label: "Risk Team"
    label: "Risk Score"
    description: "Lower is better; a weighted average of 3 KPIs: % Flights Delayed, % Flying Min Delayed, & % Flights > 2 Hours"
    type: number
    sql:
          (
            ${values_by_carrier_by_origin.percent_flights_delayed} * ${weight_percent_flights_delayed_value}
        +   ${values_by_carrier_by_origin.percent_flying_minutes_delayed} * ${weight_percent_flight_minutes_delayed_value}
        +   ${values_by_carrier_by_origin.percent_flights_above_2_hours} * ${weight_percent_flight_over_2_hours_value}
      ) /   nullif(${sum_weights_dimension},0)
    ;;
    value_format_name: percent_2
    link: {
      label: "More information here"
      url: "https://drive.google.com/file/d/1Z-vnLla82zHQT0h1lrltTxJBx8dQduHU/view"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  measure: average_risk_score {
    view_label: "Risk Team"
    description: "Lower is better; a weighted average of 3 KPIs: % Flights Delayed, % Flying Min Delayed, & % Flights > 2 Hours"
    type: average
    sql: ${risk_score_dimension} ;;
    value_format_name: percent_2
    drill_fields: [drill*]
    link: {
      label: "More information here"
      url: "https://drive.google.com/file/d/1Z-vnLla82zHQT0h1lrltTxJBx8dQduHU/view"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  ## Decide if an airport is above risk threshold
  ## This depends on air traffic
  ## A major hub is under stricter guidelines - needs a low score
  ## A minor spoke is under looser guidelines - ok with higher score

  dimension: is_above_risk_score_threshold {
    view_label: "Risk Team"
    description: "Threshold depends on how popular that airport is - an airport with more traffic for a carrier is held to a higher standard"
    type: yesno
    sql:  ${risk_score_dimension} >
          case
            when ${values_by_carrier_by_origin.count} > 50000 then .2
            when ${values_by_carrier_by_origin.count} BETWEEN 10000 and 50000 then .4
            when ${values_by_carrier_by_origin.count} < 10000 then .6
          end ;;
    drill_fields: [origin, carrier]
  }

  measure: count_airports_above_threshold {
    group_label: "Risk Score Building Blocks"
    view_label: "Risk Team"
    type: count_distinct
    sql: ${origin} ;;
    filters: {
      field: is_above_risk_score_threshold
      value: "yes"
    }
    drill_fields: [drill*]
  }

  measure: count_distinct_airports {
    group_label: "Risk Score Building Blocks"
    view_label: "Risk Team"
    type: count_distinct
    sql: ${origin} ;;
    drill_fields: [drill*]
  }

  measure: percent_airports_above_threshold {
    view_label: "Risk Team"
    type: number
    sql: 1.0 * ${count_airports_above_threshold} / NULLIF(${count_distinct_airports},0) ;;
    value_format_name: percent_2
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      origin,
      average_risk_score,
      percent_flying_minutes_delayed,
      percent_flights_above_2_hours
    ]
  }


#########################
#### Predictive Analytics
#########################

  dimension: slope {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    type: number
    sql: 1.302 ;;
  }

  dimension: yintercept {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    type: number
    sql: 0.078 ;;
  }

  dimension: predicted_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    type: number
    sql: ${slope} * ${values_by_carrier_by_origin.percent_flying_minutes_delayed} + ${yintercept} ;;
    value_format_name: percent_2
  }

  dimension: actual_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    value_format_name: percent_2
    type: number
    sql: ${values_by_carrier_by_origin.percent_flights_delayed} ;;
  }

  dimension: prediction_residual {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    type: number
    sql: abs(${actual_percent_delayed_flights} - ${predicted_percent_delayed_flights}) ;;
    value_format_name: percent_2
  }

  measure: avg_predicted_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    type: average
    sql: ${predicted_percent_delayed_flights} ;;
    value_format_name: percent_2
  }

  measure: avg_actual_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    value_format_name: percent_2
    type: average
    sql: ${actual_percent_delayed_flights} ;;
  }

  measure: avg_prediction_residual {
    group_label: "Predictive Analytics"
    view_label: "Risk Team"
    type: average
    sql: ${prediction_residual} ;;
    value_format_name: percent_2
  }

##### Copy from flights

  dimension: carrier {}

  dimension: minutes_delayed {}

  dimension: origin {}

}

#########################
#### NDT
#########################

## We need lifetime flight count to determine if an airport is a major hub or a minor spoke
## Looker has instructed the database to build a persistent table based on the code below
## This code will run the following SQL (below)

view: values_by_carrier_by_origin {
  derived_table: {
    explore_source: flights_risk_team {
      column: carrier {}
      column: origin {}
      column: percent_flights_delayed {}
      column: percent_flying_minutes_delayed {}
      column: percent_flights_above_2_hours {}
      column: flight_count {}
      filters: {
        field: flights_risk_team.minutes_delayed
        value: "15"
      }
    }
  }

  required_access_grants: [only_regular_advanced_users]

  dimension: pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: concat(${carrier}, '-', ${origin}) ;;
  }
  dimension: carrier {
    hidden: yes
    label: "1 - Flights Carrier"
  }
  dimension: origin {
    hidden: yes
    label: "1 - Flights Origin"
  }
  dimension: percent_flights_delayed {
    hidden: yes
    label: "Actual Percent Flight Delayed"
    value_format_name: percent_2
    type: number
  }
  dimension: percent_flying_minutes_delayed {
    hidden: yes
    label: "Percent Flying Minutes Delayed"
    value_format_name: percent_2
    type: number
  }
  dimension: percent_flights_above_2_hours {
    hidden: yes
    label: "1 - Flights Percent Flights Above 2 Hours"
    value_format: "#,##0.00%"
    type: number
  }
  dimension: count {
    label: "Lifetime Flights"
    view_label: "Origin"
    type: number
    sql: ${TABLE}.flight_count ;;
  }
  dimension: lifetime_flight_tier {
    label: "Lifetime Flight Tiers"
    view_label: "Origin"
    type: tier
    tiers: [10000, 50000]
    drill_fields: [count]
  }
}
