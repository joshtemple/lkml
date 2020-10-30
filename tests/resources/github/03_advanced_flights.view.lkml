include: "02_medium_flights.view.lkml"

view: advanced_flights {
  extends: [flights]

#########################
#### Security
#########################

  dimension: pilot_ssn {
    type: string
    sql: cast(round(rand() * 10000, 0) as string) ;;
    hidden: yes
  }

  dimension: pilot_ssn_hashed {
    type: number
    view_label: "Advanced Features"
    description: "Only users with sufficient permissions will see this data"
    sql:
        CASE
          WHEN '{{_user_attributes["can_see_sensitive_data"]}}' = 'yes'
                THEN ${pilot_ssn}
                ELSE TO_BASE64(SHA1(${pilot_ssn}))
          END ;;
    html:
      {% if _user_attributes["can_see_sensitive_data"]  == 'yes' %}
      {{ value }}
      {% else %}
      ###-##-####
      {% endif %}  ;;
  }

#########################
#### Case Logic to Account for Mergers
#########################

  dimension: merged_carrier_code {
    view_label: "Advanced Features"
    description: "Accounts for American-US Air & Delta-NW Mergers"
    type: string
    sql:
        CASE
          WHEN ${carrier} = 'US' and ${dep_date} > '2013-06-01' then 'AA' --2013 US Air - American Merger
          WHEN ${carrier} = 'NW' and ${dep_date} > '2008-09-01' then 'DL' --2008 Delta - Northwest Merger
        END ;;
  }

#########################
#### Scoring Airports
#########################

  ## Score based on three factors:
      ## What % of flights delayed
      ## What % of flying minutes delayed
      ## % flights above 2 hours
  ## Lower scores are BETTER

  ## % Flying Minutes delayed

  measure: percent_flying_minutes_delayed {
    group_label: "Risk Score"
    view_label: "Advanced Features"
    description: "Take average delay across flights as a percent of their total flight length"
    type: number
    sql: 1.0 * ${average_delay_length} / ${average_flight_length} ;;
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
    group_label: "Risk Score"
    view_label: "Advanced Features"
    type: count
    filters: {
      field: flight_length
      value: ">120"
    }
    drill_fields: [drill*]
  }

  measure: percent_flights_above_2_hours {
    group_label: "Risk Score"
    view_label: "Advanced Features"
    type: number
    sql: 1.0 * ${count_flights_above_2_horus} / nullif(${count},0) ;;
    value_format_name: percent_2
    drill_fields: [drill*]
    link: {
      label: "More information here"
      url: "https://drive.google.com/file/d/1Z-vnLla82zHQT0h1lrltTxJBx8dQduHU/view"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  ## Establish weights

  parameter: weight_percent_flights_delayed {
    view_label: "Advanced Features"
    type:  unquoted
    default_value: "4"
  }

  parameter: weight_percent_flight_minutes_delayed {
    view_label: "Advanced Features"
    type:  unquoted
    default_value: "2"
  }

  parameter: weight_percent_flight_over_2_hours {
    view_label: "Advanced Features"
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

  dimension: risk_score_dimension {
    group_label: "Risk Score"
    view_label: "Advanced Features"
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
    view_label: "Advanced Features"
    group_label: "Risk Score"
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

  dimension: is_above_risk_score_threshold {
    view_label: "Advanced Features"
    group_label: "Risk Score"
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
    view_label: "Advanced Features"
    group_label: "Risk Score Threshold"
    type: count_distinct
    sql: ${origin} ;;
    filters: {
      field: is_above_risk_score_threshold
      value: "yes"
    }
    drill_fields: [drill*]
  }

  measure: count_distinct_airports {
    view_label: "Advanced Features"
    group_label: "Risk Score Threshold"
    type: count_distinct
    sql: ${origin} ;;
    drill_fields: [drill*]
  }

  measure: percent_airports_above_threshold {
    view_label: "Advanced Features"
    group_label: "Risk Score Threshold"
    type: number
    sql: 1.0 * ${count_airports_above_threshold} / NULLIF(${count_distinct_airports},0) ;;
    value_format_name: percent_2
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      origin,
      average_risk_score,
      percent_flights_delayed_plain,
      percent_flying_minutes_delayed,
      percent_flights_above_2_hours
    ]
  }


#########################
#### Predictive Analytics
#########################

  dimension: slope {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    type: number
    sql: -0.102 ;;
  }

  dimension: yintercept {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    type: number
    sql: 0.178 ;;
  }

  dimension: predicted_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    type: number
    sql: ${slope} * ${values_by_carrier_by_origin.percent_flying_minutes_delayed} + ${yintercept} ;;
    value_format_name: percent_2
  }

  dimension: actual_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    value_format_name: percent_2
    type: number
    sql: ${values_by_carrier_by_origin.percent_flights_delayed} ;;
  }

  dimension: prediction_residual {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    type: number
    sql: abs(${actual_percent_delayed_flights} - ${predicted_percent_delayed_flights}) ;;
    value_format_name: percent_2
  }

  measure: avg_predicted_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    type: average
    sql: ${predicted_percent_delayed_flights} ;;
    value_format_name: percent_2
  }

  measure: avg_actual_percent_delayed_flights {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    value_format_name: percent_2
    type: average
    sql: ${actual_percent_delayed_flights} ;;
  }

  measure: avg_prediction_residual {
    group_label: "Predictive Analytics"
    view_label: "Advanced Features"
    type: average
    sql: ${prediction_residual} ;;
    value_format_name: percent_2
  }

}


#########################
#### NDT
#########################


# If necessary, uncomment the line below to include explore_source.
# include: "03_advanced_airlines.model.lkml"

view: values_by_carrier_by_origin {
  derived_table: {
    persist_for: "10 hours"
    explore_source: flights {
      column: carrier {}
      column: origin {}
      column: percent_flights_delayed {}
      column: percent_flying_minutes_delayed {}
      column: percent_flights_above_2_hours {}
      column: count {}
      filters: {
        field: flights.minutes_delayed
        value: "15"
      }
    }
  }

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
    # hidden: yes
    label: "Origin Airport Count"
    type: number
  }
}
