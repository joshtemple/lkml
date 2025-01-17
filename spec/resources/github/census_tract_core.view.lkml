include: "//@{CONFIG_PROJECT_NAME}/geography/census_tract.view.lkml"


view: census_tract {
  extends: [census_tract_config]
}

###################################################

view: census_tract_core {
  sql_table_name: `bigquery-public-data.census_bureau_acs.censustract_2018_5yr` ;;

  dimension: census_tract {
    label: "Census Tract 📍"
    primary_key: yes
    sql: ${TABLE}.geo_id ;;
    view_label: "Geography"
    map_layer_name: census_tracts
  }

  dimension: county_key {
    sql: SUBSTR(CAST(${census_tract} as STRING), 0, 5) ;;
    hidden: yes
  }

  dimension: state_key {
    sql: SUBSTR(CAST(${census_tract} as STRING), 0, 2) ;;
    hidden: yes
  }

  dimension: census_tract_median_income_dim {
    sql: ${TABLE}.median_income ;;
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: usd
    hidden: yes
  }

  dimension: census_tract_median_rent_dim {
    sql: ${TABLE}.median_rent ;;
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: usd
    hidden: yes
  }

  dimension: census_tract_median_year_structure_built_dim {
    sql: ${TABLE}.median_year_structure_built ;;
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: decimal_0
    hidden: yes
  }

  dimension: census_tract_gross_rent_dim {
    sql: ${TABLE}.renter_occupied_housing_units_paying_cash_median_gross_rent ;;
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: usd
    hidden: yes
  }

  dimension: census_tract_income_per_capita_dim {
    type: number
    sql: ${TABLE}.income_per_capita ;;
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    hidden: yes
  }

  dimension: census_tract_median_age_dim {
    type: number
    sql: ${TABLE}.median_age ;;
    description: "Median Age. The median age of all people in a given geographic area."
    hidden: yes
  }

  measure: census_tract_median_income {
    sql: MAX(${census_tract_median_income_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: usd
  }

  measure: census_tract_median_rent {
    sql: MAX(${census_tract_median_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: usd
  }

  measure: census_tract_median_year_structure_built {
    sql: MAX(${census_tract_median_year_structure_built_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: decimal_0
  }

  measure: census_tract_gross_rent {
    sql: MAX(${census_tract_gross_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Census Tract"
    value_format_name: usd
  }

  measure: census_tract_income_per_capita {
    type: number
    sql: MAX(${census_tract_income_per_capita_dim}) ;;
    view_label: "Income Per Capita"
    group_label: "Census Tract"
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    value_format_name: usd
  }

  measure: census_tract_median_age {
    type: number
    sql: MAX(${census_tract_median_age_dim}) ;;
    view_label: "Medians"
    group_label: "Census Tract"
    description: "Median Age. The median age of all people in a given geographic area."
  }
}
