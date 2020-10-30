include: "//@{CONFIG_PROJECT_NAME}/geography/zcta.view.lkml"


view: zcta {
  extends: [zcta_config]
}

###################################################

include: "/views/*"

view: zcta_core {
  extends: [
    commute,
    education,
    employment,
    family,
    gender,
    housing,
    population,
    race
  ]

  derived_table: {
    sql: SELECT
        zcta.*,
        geo.state_fips_code as state_key,
        geo.city as city,
        geo.county as county
      FROM
        `bigquery-public-data.census_bureau_acs.zip_codes_2018_5yr` as zcta
      JOIN
        `bigquery-public-data.geo_us_boundaries.zip_codes` as geo ON zcta.geo_id = geo.zip_code ;;
    persist_for: "100000 hours"
  }

  dimension: zcta {
    label: "ZCTA 📍"
    primary_key: yes
    sql: ${TABLE}.geo_id ;;
    view_label: "Geography"
    map_layer_name: us_zipcode_tabulation_areas
  }

  dimension: state_key {
    sql: ${TABLE}.state_key ;;
    hidden: yes
  }

  dimension: city {
    sql: ${TABLE}.city ;;
    view_label: "Geography"
  }

  dimension: county {
    sql: ${TABLE}.county ;;
    view_label: "Geography"
  }

  dimension: zcta_median_income_dim {
    sql: ${TABLE}.median_income ;;
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: usd
    hidden: yes
  }

  dimension: zcta_median_year_structure_built_dim {
    sql: ${TABLE}.median_year_structure_built ;;
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: decimal_0
    hidden: yes
  }

  dimension: zcta_median_rent_dim {
    sql: ${TABLE}.median_rent ;;
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: usd
    hidden: yes
  }

  dimension: zcta_gross_rent_dim {
    sql: ${TABLE}.renter_occupied_housing_units_paying_cash_median_gross_rent ;;
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: usd
    hidden: yes
  }

  dimension: zcta_income_per_capita_dim {
    type: number
    sql: ${TABLE}.income_per_capita ;;
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    hidden: yes
  }

  dimension: zcta_median_age_dim {
    type: number
    sql: ${TABLE}.median_age ;;
    description: "Median Age. The median age of all people in a given geographic area."
    hidden: yes
  }

  measure: zcta_median_rent {
    sql: MAX(${zcta_median_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: usd
  }

  measure: zcta_median_income {
    sql: MAX(${zcta_median_income_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: usd
  }

  measure: zcta_median_year_structure_built {
    sql: MAX(${zcta_median_year_structure_built_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: decimal_0
  }

  measure: zcta_gross_rent {
    sql: MAX(${zcta_gross_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "ZCTA"
    value_format_name: usd
  }

  measure: zcta_income_per_capita {
    type: number
    sql: MAX(${zcta_income_per_capita_dim}) ;;
    view_label: "Income Per Capita"
    group_label: "ZCTA"
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    value_format_name: usd
  }

  measure: zcta_median_age {
    type: number
    sql: MAX(${zcta_median_age_dim}) ;;
    view_label: "Medians"
    group_label: "ZCTA"
    description: "Median Age. The median age of all people in a given geographic area."
  }
}
