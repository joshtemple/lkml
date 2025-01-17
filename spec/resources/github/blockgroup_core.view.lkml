include: "//@{CONFIG_PROJECT_NAME}/geography/blockgroup.view.lkml"


view: blockgroup {
  extends: [blockgroup_config]
}

###################################################

include: "/views/*"
include: "/maps/*"

view: blockgroup_core {
  extends: [
    gender,
    housing,
    race,
    education,
    employment,
    population,
    commute,
    family
  ]
  sql_table_name: `bigquery-public-data.census_bureau_acs.blockgroup_2018_5yr` ;;

  dimension: block_group {
    label: "Block Group 📍"
    primary_key: yes
    view_label: "Geography"
    sql: ${TABLE}.geo_id ;;
    map_layer_name: block_group
  }

  dimension: county_key {
    type: string
    sql: (SUBSTR(CAST(${block_group} as STRING), 0, 5)) ;;
    hidden: yes
  }

  dimension: census_tract_key {
    sql: (SUBSTR(CAST(${block_group} as STRING), 0, 11)) ;;
    hidden: yes
  }

  dimension: block_group_median_income_dim {
    sql: ${TABLE}.median_income ;;
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: usd
    hidden: yes
  }

  dimension: block_group_median_rent_dim {
    sql: ${TABLE}.median_rent ;;
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: usd
    hidden: yes
  }

  dimension: block_group_median_year_structure_built_dim {
    sql: ${TABLE}.median_year_structure_built ;;
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: decimal_0
    hidden: yes
  }

  dimension: block_group_gross_rent_dim {
    sql: ${TABLE}.renter_occupied_housing_units_paying_cash_median_gross_rent ;;
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: usd
    hidden: yes
  }

  dimension: block_group_income_per_capita_dim {
    type: number
    sql: ${TABLE}.income_per_capita ;;
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    view_label: "Income Per Capita"
    group_label: "Block Group"
    hidden: yes
  }

  dimension: block_group_percent_income_spent_on_rent_dim {
    sql: ${TABLE}.percent_income_spent_on_rent  / 100 ;;
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: percent_1
    hidden: yes
  }

  dimension: block_group_median_age_dim {
    type: number
    sql: ${TABLE}.median_age ;;
    description: "Median Age. The median age of all people in a given geographic area."
    hidden: yes
  }

  measure: block_group_median_income {
    sql: MAX(${block_group_median_income_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: usd
  }

  measure: block_group_median_rent {
    sql: MAX(${block_group_median_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: usd
  }

  measure: block_group_median_year_structure_built {
    sql: MAX(${block_group_median_year_structure_built_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: decimal_0
  }

  measure: block_group_gross_rent {
    sql: MAX(${block_group_gross_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: usd
  }

  measure: block_group_income_per_capita {
    type: number
    sql: MAX(${block_group_income_per_capita_dim}) ;;
    view_label: "Income Per Capita"
    group_label: "Block Group"
    description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
    value_format_name: usd
  }

  measure: block_group_percent_income_spent_on_rent {
    sql: MAX(${block_group_percent_income_spent_on_rent_dim}) ;;
    type: number
    view_label: "Medians"
    group_label: "Block Group"
    value_format_name: percent_1
  }
}
