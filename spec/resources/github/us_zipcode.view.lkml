view: us_zipcode {
  #sql_table_name: "UTIL"."US_ZIPCODE"
  #  ;;
  derived_table: {
    sql: select * from analytics.util.us_zipcode where zcta;;
  }

  dimension: zip {
    primary_key: yes
    view_label: "Geography"
    group_label: "Demographics"
    label: "Zipcode"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: zipcode
    sql: ${TABLE}."ZIP" ;;
  }

  dimension: age_10_to_19 {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "10 to 19"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_10_TO_19" ;;
  }

  dimension: age_20_s {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "20 to 29"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_20S" ;;
  }

  dimension: age_30_s {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "30 to 39"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_30S" ;;
  }

  dimension: age_40_s {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "40 to 49"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_40S" ;;
  }

  dimension: age_50_s {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "50 to 59"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_50S" ;;
  }

  dimension: age_60_s {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "60 to 69"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_60S" ;;
  }

  dimension: age_70_s {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "70 to 79"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_70S" ;;
  }

  dimension: age_median {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Median Age"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_MEDIAN" ;;
  }

  dimension: age_over_80 {
    view_label: "Geography"
    group_label: "Age Range %"
    label: "Over 80"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."AGE_OVER_80" ;;
  }

  dimension: age_under_10 {
    type: number
    view_label: "Geography"
    group_label: "Age Range %"
    label: " Under 10"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    sql: ${TABLE}."AGE_UNDER_10" ;;
  }

  dimension: charitable_givers {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Charitable Givers %"
    description: "Percent of charitable givers in zipcode. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."CHARITABLE_GIVERS" ;;
  }

  dimension: city {
    view_label: "Geography"
    group_label: "Demographics"
    label: "City"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: commute_time {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Commute Time"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."COMMUTE_TIME" ;;
  }

  dimension: county_fips {
    view_label: "Geography"
    group_label: "Demographics"
    label: "County Fips"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."COUNTY_FIPS" ;;
  }

  dimension: county_fips_all {
    view_label: "Geography"
    group_label: "Demographics"
    label: "County Fips All"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."COUNTY_FIPS_ALL" ;;
  }

  dimension: county_name {
    view_label: "Geography"
    group_label: "Demographics"
    label: "County Name"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."COUNTY_NAME" ;;
  }

  dimension: county_names_all {
    view_label: "Geography"
    group_label: "Demographics"
    label: "County Name All"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."COUNTY_NAMES_ALL" ;;
  }

  dimension: county_weights {
    view_label: "Geography"
    group_label: "Demographics"
    label: "County Weight"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."COUNTY_WEIGHTS" ;;
  }

  dimension: density {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Density"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."DENSITY" ;;
  }

  dimension: disabled {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Disabled %"
    description: "Percent Diabled. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."DISABLED" ;;
  }

  dimension: divorced {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Divorced %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."DIVORCED" ;;
  }

  dimension: education_bachelors {
    view_label: "Geography"
    group_label: "Education %"
    label: "Bachelors"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."EDUCATION_BACHELORS" ;;
  }

  dimension: education_college_or_above {
    view_label: "Geography"
    group_label: "Education %"
    label: "College or Above"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."EDUCATION_COLLEGE_OR_ABOVE" ;;
  }

  dimension: education_graduate {
    view_label: "Geography"
    group_label: "Education %"
    label: "Graduate"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."EDUCATION_GRADUATE" ;;
  }

  dimension: education_highschool {
    view_label: "Geography"
    group_label: "Education %"
    label: " Highschool"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."EDUCATION_HIGHSCHOOL" ;;
  }

  dimension: education_less_highschool {
    view_label: "Geography"
    group_label: "Education %"
    label: " Below Highschool"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."EDUCATION_LESS_HIGHSCHOOL" ;;
  }

  dimension: education_some_college {
    view_label: "Geography"
    group_label: "Education %"
    label: " Some College"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."EDUCATION_SOME_COLLEGE" ;;
  }

  dimension: education_stem_degree {
    view_label: "Geography"
    group_label: "Education %"
    label: "STEM Degree"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."EDUCATION_STEM_DEGREE" ;;
  }

  dimension: family_dual_income {
    view_label: "Geography"
    group_label: "Income %"
    label: "Family Dual Income"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."FAMILY_DUAL_INCOME" ;;
  }

  dimension: family_size {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Family Size"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."FAMILY_SIZE" ;;
  }

  dimension: farmer {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Farmer %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."FARMER" ;;
  }

  dimension: female {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Female %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."FEMALE" ;;
  }

  dimension: health_uninsured {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Health Uninsured %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."HEALTH_UNINSURED" ;;
  }

  dimension: hispanic {
    view_label: "Geography"
    group_label: "Race %"
    label: "Hispanic"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."HISPANIC" ;;
  }

  dimension: home_ownership {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Home Ownership %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."HOME_OWNERSHIP" ;;
  }

  dimension: home_value {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Home Value"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."HOME_VALUE" ;;
  }

  dimension: imprecise {
    view_label: "Geography"
    group_label: "Demographics"
    label: "* Imprecise"
    description: "Yes is not percise, no is percise. Source: looker_block.us_zipcode"
    hidden: yes
    type: yesno
    sql: ${TABLE}."IMPRECISE" ;;
  }

  dimension: income_household_100_to_150 {
    view_label: "Geography"
    group_label: "Income %"
    label: " $100k to $150k"
    description: "Household income between $100k to $150k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_100_TO_150" ;;
  }

  dimension: income_household_10_to_15 {
    view_label: "Geography"
    group_label: "Income %"
    label: "  $10k to $15k"
    description: "Household income between $10k to $15k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_10_TO_15" ;;
  }

  dimension: income_household_150_over {
    view_label: "Geography"
    group_label: "Income %"
    label: " Over $150k"
    description: "Household income over $150k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_150_OVER" ;;
  }

  dimension: income_household_15_to_20 {
    view_label: "Geography"
    group_label: "Income %"
    label: "  $15k to $20k"
    description: "Household income between $15k to $20k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_15_TO_20" ;;
  }

  dimension: income_household_20_to_25 {
    view_label: "Geography"
    group_label: "Income %"
    label: "  $20k to $25k"
    description: "Household income between $20k to $25k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_20_TO_25" ;;
  }

  dimension: income_household_25_to_35 {
    view_label: "Geography"
    group_label: "Income %"
    label: "  $25k to $35k"
    description: "Household income between $25k to $35k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_25_TO_35" ;;
  }

  dimension: income_household_35_to_50 {
    view_label: "Geography"
    group_label: "Income %"
    label: "  $35k to $50k"
    description: "Household income between $35k to $50k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_35_TO_50" ;;
  }

  dimension: income_household_50_to_75 {
    view_label: "Geography"
    group_label: "Income %"
    label: "  $50k to $75k"
    description: "Household income between $50k to $75k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_50_TO_75" ;;
  }

  dimension: income_household_5_to_10 {
    view_label: "Geography"
    group_label: "Income %"
    label: "   $5k to $10k"
    description: "Household income between $5k to $10k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_5_TO_10" ;;
  }

  dimension: income_household_75_to_100 {
    view_label: "Geography"
    group_label: "Income %"
    label: "  $75k to $100k"
    description: "Household income between $75k to $100k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_75_TO_100" ;;
  }

  dimension: income_household_median {
    view_label: "Geography"
    group_label: "Income %"
    label: "Median (Household)"
    description: "Median household income. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_MEDIAN" ;;
  }

  dimension: income_household_six_figure {
    view_label: "Geography"
    group_label: "Income %"
    label: "Six Figure"
    description: "Six figure household income. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_SIX_FIGURE" ;;
  }

  dimension: income_household_under_5 {
    view_label: "Geography"
    group_label: "Income %"
    label: "    Under $5k"
    description: "Household income under $5k. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_HOUSEHOLD_UNDER_5" ;;
  }

  dimension: income_individual_median {
    view_label: "Geography"
    group_label: "Income %"
    label: "Median (Individual)"
    description: "Median individual income. Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."INCOME_INDIVIDUAL_MEDIAN" ;;
  }

  dimension: labor_force_participation {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Labor Force Participation %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."LABOR_FORCE_PARTICIPATION" ;;
  }

  dimension: lat {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Latitude"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: string
    sql: ${TABLE}."LAT" ;;
  }

  dimension: limited_english {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Limited English %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."LIMITED_ENGLISH" ;;
  }

  dimension: lng {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Longitude"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: string
    sql: ${TABLE}."LNG" ;;
  }

  dimension: male {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Male %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."MALE" ;;
  }

  dimension: married {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Married %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."MARRIED" ;;
  }

  dimension: military {
    view_label: "Geography"
    group_label: "Demographics"
    label: " * Military"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: yesno
    sql: ${TABLE}."MILITARY" ;;
  }

  dimension: never_married {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Never Married %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."NEVER_MARRIED" ;;
  }

  dimension: parent_zcta {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Parent ZCTA"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."PARENT_ZCTA" ;;
  }

  dimension: population {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Population"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."POPULATION" ;;
  }

  dimension: poverty {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Poverty %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."POVERTY" ;;
  }

  dimension: race_asian {
    view_label: "Geography"
    group_label: "Race %"
    label: "Asian"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RACE_ASIAN" ;;
  }

  dimension: race_black {
    view_label: "Geography"
    group_label: "Race %"
    label: "Black"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RACE_BLACK" ;;
  }

  dimension: race_multiple {
    view_label: "Geography"
    group_label: "Race %"
    label: "Multiple"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RACE_MULTIPLE" ;;
  }

  dimension: race_native {
    view_label: "Geography"
    group_label: "Race %"
    label: "Native"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RACE_NATIVE" ;;
  }

  dimension: race_other {
    view_label: "Geography"
    group_label: "Race %"
    label: "Other"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RACE_OTHER" ;;
  }

  dimension: race_pacific {
    view_label: "Geography"
    group_label: "Race %"
    label: "Pacific"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RACE_PACIFIC" ;;
  }

  dimension: race_white {
    view_label: "Geography"
    group_label: "Race %"
    label: "White"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RACE_WHITE" ;;
  }

  dimension: rent_burden {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Rent Burden %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RENT_BURDEN" ;;
  }

  dimension: rent_median {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Rent Median"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."RENT_MEDIAN" ;;
  }

  dimension: self_employed {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Self Employed %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."SELF_EMPLOYED" ;;
  }

  dimension: state_id {
    view_label: "Geography"
    group_label: "Demographics"
    label: "State ID"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."STATE_ID" ;;
  }

  dimension: state_name {
    view_label: "Geography"
    group_label: "Demographics"
    label: "State"
    description: "Source: looker_block.us_zipcode"
    hidden: yes
    type: string
    sql: ${TABLE}."STATE_NAME" ;;
  }

  dimension: timezone {
    view_label: "Geography"
    group_label: "Demographics"
    label: " Timezone"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: string
    sql: ${TABLE}."TIMEZONE" ;;
  }

  dimension: unemployment_rate {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Unemployeement %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."UNEMPLOYMENT_RATE" ;;
  }

  dimension: veteran {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Veteran %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."VETERAN" ;;
  }

  dimension: widowed {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Widowed %"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: number
    sql: ${TABLE}."WIDOWED" ;;
  }

  measure: count {
    view_label: "Geography"
    group_label: "Demographics"
    type: count
    drill_fields: [county_name, state_name]
  }

  measure: avg_age_median {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Median Age"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."AGE_MEDIAN" ;;
  }

  measure: avg_commute_time {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Commute Time"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."COMMUTE_TIME" ;;
  }

  measure: avg_family_size {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Family Size"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."FAMILY_SIZE" ;;
  }

  measure: avg_home_value {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Home Value"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."HOME_VALUE" ;;
  }

  measure: avg_income_household_median {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Median (Household)"
    description: "Median household income. Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."INCOME_HOUSEHOLD_MEDIAN" ;;
  }

  measure: avg_income_individual_median {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Median (Individual)"
    description: "Median individual income. Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."INCOME_INDIVIDUAL_MEDIAN" ;;
  }

  measure: avg_population {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Population"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."POPULATION" ;;
  }

  measure: total_population {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Total Population"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: sum
    sql: ${TABLE}."POPULATION" ;;
  }

  measure: avg_rent_median {
    view_label: "Geography"
    group_label: "Demographics"
    label: "Average Rent Median"
    description: "Source: looker_block.us_zipcode"
    hidden: no
    type: average
    sql: ${TABLE}."RENT_MEDIAN" ;;
  }
}
