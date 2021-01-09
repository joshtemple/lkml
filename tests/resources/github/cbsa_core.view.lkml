include: "//@{CONFIG_PROJECT_NAME}/geography/cbsa.view.lkml"


view: cbsa {
  extends: [cbsa_config]
}

###################################################

include: "/views/*"
include: "/maps/*"

view: cbsa_core {
  extends: [
    commute,
    education,
    gender,
    population,
    employment,
    family,
    housing,
    race
  ]

  derived_table: {
    sql: SELECT
        cbsa.*,
        geo.name as name,
        geo.lsad_name as full_name
      FROM
        `bigquery-public-data.census_bureau_acs.cbsa_2018_5yr` as cbsa
      JOIN `bigquery-public-data.geo_us_boundaries.cbsa` as geo ON cbsa.geo_id = geo.cbsa_fips_code ;;
  }

  dimension: cbsa {
    label: "Core-based Statistical Area 📍"
    view_label: "Geography"
    group_label: "CBSA"
    primary_key: yes
    sql: ${TABLE}.geo_id ;;
    map_layer_name: cbsa_2018
  }

  dimension: state_abbreviation {
    hidden: yes
    sql: TRIM(SUBSTR(${cbsa_name}, STRPOS(${cbsa_name} ,",")+1, LENGTH(${cbsa_name}))) ;;
  }

  dimension: cbsa_name {
    sql: ${TABLE}.name ;;
    view_label: "Geography"
    group_label: "CBSA"
  }

  dimension: cbsa_full_name {
    sql: ${TABLE}.full_name ;;
    view_label: "Geography"
    group_label: "CBSA"
  }

  dimension: cbsa_median_income_dim {
    sql: ${TABLE}.median_income ;;
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: usd
    hidden: yes
  }

  dimension: cbsa_median_rent_dim {
    sql: ${TABLE}.median_rent ;;
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: usd
    hidden: yes
  }

  dimension: cbsa_median_year_structure_built_dim {
    sql: ${TABLE}.median_year_structure_built ;;
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: decimal_0
    hidden: yes
  }

  dimension: cbsa_gross_rent_dim {
    sql: ${TABLE}.renter_occupied_housing_units_paying_cash_median_gross_rent ;;
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: usd
    hidden: yes
  }

  dimension: cbsa_income_per_capita_dim {
    type: number
    sql: ${TABLE}.income_per_capita ;;
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    view_label: "Income Per Capita"
    group_label: "CBSA"
    hidden: yes
  }

  dimension: cbsa_percent_income_spent_on_rent_dim {
    sql: ${TABLE}.percent_income_spent_on_rent / 100 ;;
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: percent_1
    hidden: yes
  }

  dimension: cbsa_median_age_dim {
    type: number
    sql: ${TABLE}.median_age ;;
    description: "Median Age. The median age of all people in a given geographic area."
    hidden: yes
  }

  measure: cbsa_median_income {
    sql: MAX(${cbsa_median_income_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: usd
  }

  measure: cbsa_median_rent {
    sql: MAX(${cbsa_median_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: usd
  }

  measure: cbsa_median_year_structure_built {
    sql: MAX(${cbsa_median_year_structure_built_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: decimal_0
  }

  measure: cbsa_gross_rent {
    sql: MAX(${cbsa_gross_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: usd
  }

  measure: cbsa_income_per_capita {
    type: number
    sql: MAX(${cbsa_income_per_capita_dim}) ;;
    view_label: "Income Per Capita"
    group_label: "CBSA"
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    value_format_name: usd
  }

  measure: cbsa_percent_income_spent_on_rent {
    sql: MAX(${cbsa_percent_income_spent_on_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "CBSA"
    value_format_name: percent_1
  }

  measure: cbsa_median_age {
    sql: MAX(${cbsa_median_age_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "CBSA"
  }
}
