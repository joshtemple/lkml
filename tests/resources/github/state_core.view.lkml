include: "//@{CONFIG_PROJECT_NAME}/geography/state.view.lkml"


view: state {
  extends: [state_config]
}

###################################################

view: state_core {
  derived_table: {
    sql: SELECT
      state.*,
      state_name.state_name as state,
      state_name.state_postal_abbreviation as state_abbreviation,
      CAST(state.geo_id as STRING) as key
    FROM
    `bigquery-public-data.census_bureau_acs.state_2018_5yr` as state
    INNER JOIN `bigquery-public-data.census_utility.fips_codes_states` as state_name ON state.geo_id = state_name.state_fips_code ;;
    persist_for: "100000 hours"
  }

  dimension: state_name {
    label: "State 📍"
    primary_key: yes
    sql: ${TABLE}.state ;;
    view_label: "Geography"
    group_label: "State"
    map_layer_name: us_states
  }

  dimension: state_abbreviation {
    sql: ${TABLE}.state_abbreviation ;;
    view_label: "Geography"
    group_label: "State"
    map_layer_name: us_states
  }

  dimension: key {
    hidden: yes
    sql: ${TABLE}.key ;;
  }

  dimension: state_median_income_dim {
    sql: ${TABLE}.median_income ;;
    view_label: "Medians"
    group_label: "State"
    value_format_name: usd
    hidden: yes
  }

  dimension: state_median_year_structure_built_dim {
    sql: ${TABLE}.median_year_structure_built ;;
    view_label: "Medians"
    group_label: "State"
    value_format_name: decimal_0
    hidden: yes
  }

  dimension: state_median_rent_dim {
    sql: ${TABLE}.median_rent ;;
    view_label: "Medians"
    group_label: "State"
    value_format_name: usd
    hidden: yes
  }

  dimension: state_gross_rent_dim {
    sql: ${TABLE}.renter_occupied_housing_units_paying_cash_median_gross_rent ;;
    view_label: "Medians"
    group_label: "State"
    value_format_name: usd
    hidden: yes
  }

  dimension: state_income_per_capita_dim {
    type: number
    sql: ${TABLE}.income_per_capita ;;
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    view_label: "Income Per Capita"
    group_label: "State"
    hidden: yes
  }

  dimension: state_percent_income_spent_on_rent_dim {
    sql: ${TABLE}.percent_income_spent_on_rent / 100 ;;
    view_label: "Medians"
    group_label: "State"
    value_format_name: percent_1
    hidden: yes
  }

  dimension: state_median_age_dim {
    type: number
    sql: ${TABLE}.median_age ;;
    description: "Median Age. The median age of all people in a given geographic area."
    hidden: yes
  }

  measure: state_median_rent {
    sql: MAX(${state_median_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "State"
    value_format_name: usd
  }

  measure: state_median_income {
    sql: MAX(${state_median_income_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "State"
    value_format_name: usd
  }

  measure: state_median_year_structure_built {
    sql: MAX(${state_median_year_structure_built_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "State"
    value_format_name: decimal_0
  }

  measure: state_gross_rent {
    sql: MAX(${state_gross_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "State"
    value_format_name: usd
  }

  measure: state_income_per_capita {
    type: number
    sql: MAX(${state_income_per_capita_dim}) ;;
    view_label: "Income Per Capita"
    group_label: "State"
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    value_format_name: usd
  }

  measure: state_percent_income_spent_on_rent {
    sql: MAX(${state_percent_income_spent_on_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "State"
    value_format_name: percent_1
  }

  measure: state_median_age {
    type: number
    sql: MAX(${state_median_age_dim}) ;;
    view_label: "Medians"
    group_label: "State"
    description: "Median Age. The median age of all people in a given geographic area."
  }
}
