include: "//@{CONFIG_PROJECT_NAME}/views/gender.view.lkml"


view: gender {
  extends: [gender_config]
}

###################################################

view: gender_core {
  extension: required

  dimension: female_10_to_14_dim {
    view_label: "Gender"
    group_label: "Female"
    type: number
    sql: ${TABLE}.female_10_to_14 ;;
    description: "Female age 10 to 14. The female population between the age of ten years to fourteen years within the specified area."
    hidden: yes
  }

  dimension: female_15_to_17_dim {
    type: number
    sql: ${TABLE}.female_15_to_17 ;;
    description: "Female age 15 to 17. The female population between the age of fifteeen years to seventeen years within the specified area."
    hidden: yes
  }

  dimension: female_18_to_19_dim {
    type: number
    sql: ${TABLE}.female_18_to_19 ;;
    description: "Female age 18 and 19. The female population between the age of eighteen years to nineteen years within the specified area."
    hidden: yes
  }

  dimension: female_20_dim {
    type: number
    sql: ${TABLE}.female_20 ;;
    description: "Female age 20. The female population with an age of twenty years within the specified area."
    hidden: yes
  }

  dimension: female_21_dim {
    type: number
    sql: ${TABLE}.female_21 ;;
    description: "Female age 21. The female population with an age of twenty-one years within the specified area."
    hidden: yes
  }

  dimension: female_22_to_24_dim {
    type: number
    sql: ${TABLE}.female_22_to_24 ;;
    description: "Female age 22 to 24. The female population between the age of twenty-two years to twenty-four years within the specified area."
    hidden: yes
  }

  dimension: female_25_to_29_dim {
    type: number
    sql: ${TABLE}.female_25_to_29 ;;
    description: "Female age 25 to 29. The female population between the age of twenty-five years to twenty-nine years within the specified area."
    hidden: yes
  }

  dimension: female_30_to_34_dim {
    type: number
    sql: ${TABLE}.female_30_to_34 ;;
    description: "Female age 30 to 34. The female population between the age of thirty years to thirty-four years within the specified area."
    hidden: yes
  }

  dimension: female_35_to_39_dim {
    type: number
    sql: ${TABLE}.female_35_to_39 ;;
    description: "Female age 35 to 39. The female population between the age of thirty-five years to thirty-nine years within the specified area."
    hidden: yes
  }

  dimension: female_40_to_44_dim {
    type: number
    sql: ${TABLE}.female_40_to_44 ;;
    description: "Female age 40 to 44. The female population between the age of fourty years to fourty-four years within the specified area."
    hidden: yes
  }

  dimension: female_45_to_49_dim {
    type: number
    sql: ${TABLE}.female_45_to_49 ;;
    description: "Female age 45 to 49. The female population between the age of fourty-five years to fourty-nine years within the specified area."
    hidden: yes
  }

  dimension: female_50_to_54_dim {
    type: number
    sql: ${TABLE}.female_50_to_54 ;;
    description: "Female age 50 to 54. The female population between the age of fifty years to fifty-four years within the specified area."
    hidden: yes
  }

  dimension: female_55_to_59_dim {
    type: number
    sql: ${TABLE}.female_55_to_59 ;;
    description: "Female age 55 to 59. The female population between the age of fifty-five years to fifty-nine years within the specified area."
    hidden: yes
  }

  dimension: female_5_to_9_dim {
    type: number
    sql: ${TABLE}.female_5_to_9 ;;
    description: "Female age 5 to 9. The female population between the age of five years to nine years within the specified area."
    hidden: yes
  }

  dimension: female_60_to_61_dim {
    type: number
    sql: ${TABLE}.female_60_to_61 ;;
    description: "Female age 60 and 61. The female population between the age of sixty years to sixty-one years within the specified area."
    hidden: yes
  }

  dimension: female_62_to_64_dim {
    type: number
    sql: ${TABLE}.female_62_to_64 ;;
    description: "Female age 62 to 64. The female population between the age of sixty-two years to sixty-four years within the specified area."
    hidden: yes
  }

  dimension: female_65_to_66_dim {
    type: number
    sql: ${TABLE}.female_65_to_66 ;;
    description: "Female age 65 to 66. The female population between the age of sixty-five years to sixty-six years within the specified area."
    hidden: yes
  }

  dimension: female_67_to_69_dim {
    type: number
    sql: ${TABLE}.female_67_to_69 ;;
    description: "Female age 67 to 69. The female population between the age of sixty-seven years to sixty-nine years within the specified area."
    hidden: yes
  }

  dimension: female_70_to_74_dim {
    type: number
    sql: ${TABLE}.female_70_to_74 ;;
    description: "Female age 70 to 74. The female population between the age of seventy years to seventy-four years within the specified area."
    hidden: yes
  }

  dimension: female_75_to_79_dim {
    type: number
    sql: ${TABLE}.female_75_to_79 ;;
    description: "Female age 75 to 79. The female population between the age of seventy-five years to seventy-nine years within the specified area."
    hidden: yes
  }

  dimension: female_80_to_84_dim {
    type: number
    sql: ${TABLE}.female_80_to_84 ;;
    description: "Female age 80 to 84. The female population between the age of eighty years to eighty-four years within the specified area."
    hidden: yes
  }

  dimension: female_85_and_over_dim {
    type: number
    sql: ${TABLE}.female_85_and_over ;;
    description: "Female age 85 and over. The female population of the age of eighty-five years and over within the specified area."
    hidden: yes
  }

  dimension: female_pop_dim {
    type: number
    sql: ${TABLE}.female_pop ;;
    description: "Female Population. The number of people within each geography who are female."
    hidden: yes
  }

  dimension: female_under_5_dim {
    type: number
    sql: ${TABLE}.female_under_5 ;;
    description: "Female under 5 years. The female population over the age of five years within the specified area."
    hidden: yes
  }

  dimension: male_10_to_14_dim {
    type: number
    sql: ${TABLE}.male_10_to_14 ;;
    description: "Male age 10 to 14. The male population between the age of ten years to fourteen years within the specified area."
    hidden: yes
  }

  dimension: male_15_to_17_dim {
    type: number
    sql: ${TABLE}.male_15_to_17 ;;
    description: "Male age 15 to 17. The male population between the age of fifteeen years to seventeen years within the specified area."
    hidden: yes
  }

  dimension: male_18_to_19_dim {
    type: number
    sql: ${TABLE}.male_18_to_19 ;;
    description: "Male age 18 and 19. The male population between the age of eighteen years to nineteen years within the specified area."
    hidden: yes
  }

  dimension: male_20_dim {
    type: number
    sql: ${TABLE}.male_20 ;;
    description: "Male age 20. The male population with an age of twenty years within the specified area."
    hidden: yes
  }

  dimension: male_21_dim {
    type: number
    sql: ${TABLE}.male_21 ;;
    description: "Male age 21. The male population with an age of twenty-one years within the specified area."
    hidden: yes
  }

  dimension: male_22_to_24_dim {
    type: number
    sql: ${TABLE}.male_22_to_24 ;;
    description: "Male age 22 to 24. The male population between the age of twenty-two years to twenty-four years within the specified area."
    hidden: yes
  }

  dimension: male_25_to_29_dim {
    type: number
    sql: ${TABLE}.male_25_to_29 ;;
    description: "Male age 25 to 29. The male population between the age of twenty-five years to twenty-nine years within the specified area."
    hidden: yes
  }

  dimension: male_30_to_34_dim {
    type: number
    sql: ${TABLE}.male_30_to_34 ;;
    description: "Male age 30 to 34. The male population between the age of thirty years to thirty-four years within the specified area."
    hidden: yes
  }

  dimension: male_35_to_39_dim {
    type: number
    sql: ${TABLE}.male_35_to_39 ;;
    description: "Male age 35 to 39. The male population between the age of thirty-five years to thirty-nine years within the specified area."
    hidden: yes
  }

  dimension: male_40_to_44_dim {
    type: number
    sql: ${TABLE}.male_40_to_44 ;;
    description: "Male age 40 to 44. The male population between the age of fourty years to fourty-four years within the specified area."
    hidden: yes
  }

  dimension: male_45_to_49_dim {
    type: number
    sql: ${TABLE}.male_45_to_49 ;;
    description: "Men age 45 to 49. The male population between the age of fourty-five years to fourty-nine years within the specified area."
    hidden: yes
  }

  dimension: male_50_to_54_dim {
    type: number
    sql: ${TABLE}.male_50_to_54 ;;
    description: "Men age 50 to 54. The male population between the age of fifty years to fifty-four years within the specified area."
    hidden: yes
  }

  dimension: male_55_to_59_dim {
    type: number
    sql: ${TABLE}.male_55_to_59 ;;
    description: "Men age 55 to 59. The male population between the age of fifty-five years to fifty-nine years within the specified area."
    hidden: yes
  }

  dimension: male_5_to_9_dim {
    type: number
    sql: ${TABLE}.male_5_to_9 ;;
    description: "Male age 5 to 9. The male population between the age of five years to nine years within the specified area."
    hidden: yes
  }

  dimension: male_60_to_61_dim {
    type: number
    sql: ${TABLE}.male_60_to_61 ;;
    description: "Men age 60 to 61. The male population between the age of sixty years to sixty-one years within the specified area."
    hidden: yes
  }

  dimension: male_62_to_64_dim {
    type: number
    sql: ${TABLE}.male_62_to_64 ;;
    description: "Men age 62 to 64. The male population between the age of sixty-two years to sixty-four years within the specified area."
    hidden: yes
  }

  dimension: male_65_to_66_dim {
    type: number
    sql: ${TABLE}.male_65_to_66 ;;
    description: "Male age 65 to 66. The male population between the age of sixty-five years to sixty-six years within the specified area."
    hidden: yes
  }

  dimension: male_67_to_69_dim {
    type: number
    sql: ${TABLE}.male_67_to_69 ;;
    description: "Male age 67 to 69. The male population between the age of sixty-seven years to sixty-nine years within the specified area."
    hidden: yes
  }

  dimension: male_70_to_74_dim {
    type: number
    sql: ${TABLE}.male_70_to_74 ;;
    description: "Male age 70 to 74. The male population between the age of seventy years to seventy-four years within the specified area."
    hidden: yes
  }

  dimension: male_75_to_79_dim {
    type: number
    sql: ${TABLE}.male_75_to_79 ;;
    description: "Male age 75 to 79. The male population between the age of seventy-five years to seventy-nine years within the specified area."
    hidden: yes
  }

  dimension: male_80_to_84_dim {
    type: number
    sql: ${TABLE}.male_80_to_84 ;;
    description: "Male age 80 to 84. The male population between the age of eighty years to eighty-four years within the specified area."
    hidden: yes
  }

  dimension: male_85_and_over_dim {
    type: number
    sql: ${TABLE}.male_85_and_over ;;
    description: "Male age 85 and over. The male population of the age of eighty-five years and over within the specified area."
    hidden: yes
  }

  dimension: male_pop_dim {
    type: number
    sql: ${TABLE}.male_pop ;;
    description: "Male Population. The number of people within each geography who are male."
    hidden: yes
  }

  dimension: male_under_5_dim {
    type: number
    sql: ${TABLE}.male_under_5 ;;
    description: "Male under 5 years. The male population over the age of five years within the specified area."
    hidden: yes
  }

  measure: female_10_to_14 {
    label: "Age 10-14"
    type: sum
    sql: ${female_10_to_14_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 10 to 14. The female population between the age of ten years to fourteen years within the specified area."
  }

  measure: female_15_to_17 {
    label: "Age 15-17"
    type: sum
    sql: ${female_15_to_17_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 15 to 17. The female population between the age of fifteeen years to seventeen years within the specified area."
  }

  measure: female_18_to_19 {
    label: "Age 18-19"
    type: sum
    sql: ${female_18_to_19_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 18 and 19. The female population between the age of eighteen years to nineteen years within the specified area."
  }

  measure: female_20 {
    label: "Age 20"
    type: sum
    sql: ${female_20_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 20. The female population with an age of twenty years within the specified area."
  }

  measure: female_21 {
    label: "Age 21"
    type: sum
    sql: ${female_21_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 21. The female population with an age of twenty-one years within the specified area."
  }

  measure: female_22_to_24 {
    label: "Age 22-24"
    type: sum
    sql: ${female_22_to_24_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 22 to 24. The female population between the age of twenty-two years to twenty-four years within the specified area."
  }

  measure: female_25_to_29 {
    label: "Age 25-29"
    type: sum
    sql: ${female_25_to_29_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 25 to 29. The female population between the age of twenty-five years to twenty-nine years within the specified area."
  }

  measure: female_30_to_34 {
    label: "Age 30-34"
    type: sum
    sql: ${female_30_to_34_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 30 to 34. The female population between the age of thirty years to thirty-four years within the specified area."
  }

  measure: female_35_to_39 {
    label: "Age 35-39"
    type: sum
    sql: ${female_35_to_39_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 35 to 39. The female population between the age of thirty-five years to thirty-nine years within the specified area."
  }

  measure: female_40_to_44 {
    label: "Age 40-44"
    type: sum
    sql: ${female_40_to_44_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 40 to 44. The female population between the age of fourty years to fourty-four years within the specified area."
  }

  measure: female_45_to_49 {
    label: "Age 45-49"
    type: sum
    sql: ${female_45_to_49_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 45 to 49. The female population between the age of fourty-five years to fourty-nine years within the specified area."
  }

  measure: female_50_to_54 {
    label: "Age 50-54"
    type: sum
    sql: ${female_50_to_54_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 50 to 54. The female population between the age of fifty years to fifty-four years within the specified area."
  }

  measure: female_55_to_59 {
    label: "Age 55-59"
    type: sum
    sql: ${female_55_to_59_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 55 to 59. The female population between the age of fifty-five years to fifty-nine years within the specified area."
  }

  measure: female_5_to_9 {
    label: " Age 5-9"
    type: sum
    sql: ${female_5_to_9_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 5 to 9. The female population between the age of five years to nine years within the specified area."
  }

  measure: female_60_to_61 {
    label: "Age 60-61"
    type: sum
    sql: ${female_60_to_61_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 60 and 61. The female population between the age of sixty years to sixty-one years within the specified area."
  }

  measure: female_62_to_64 {
    label: "Age 62-64"
    type: sum
    sql: ${female_62_to_64_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 62 to 64. The female population between the age of sixty-two years to sixty-four years within the specified area."
  }

  measure: female_65_to_66 {
    label: "Age 65-66"
    type: sum
    sql: ${female_65_to_66_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 65 to 66. The female population between the age of sixty-five years to sixty-six years within the specified area."
  }

  measure: female_67_to_69 {
    label: "Age 67-69"
    type: sum
    sql: ${female_67_to_69_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 67 to 69. The female population between the age of sixty-seven years to sixty-nine years within the specified area."
  }

  measure: female_70_to_74 {
    label: "Age 70-74"
    type: sum
    sql: ${female_70_to_74_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 70 to 74. The female population between the age of seventy years to seventy-four years within the specified area."
  }

  measure: female_75_to_79 {
    label: "Age 75-79"
    type: sum
    sql: ${female_75_to_79_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 75 to 79. The female population between the age of seventy-five years to seventy-nine years within the specified area."
  }

  measure: female_80_to_84 {
    label: "Age 80-84"
    type: sum
    sql: ${female_80_to_84_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 80 to 84. The female population between the age of eighty years to eighty-four years within the specified area."
  }

  measure: female_85_and_over {
    label: "Age 85 and over"
    type: sum
    sql: ${female_85_and_over_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female age 85 and over. The female population of the age of eighty-five years and over within the specified area."
  }

  measure: female_pop {
    label: "Total Female Population"
    type: sum
    sql: ${female_pop_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female Population. The number of people within each geography who are female."
  }

  measure: female_under_5 {
    label: "  Age under 5"
    type: sum
    sql: ${female_under_5_dim} ;;
    view_label: "Gender"
    group_label: "Female"
    description: "Female under 5 years. The female population over the age of five years within the specified area."
  }

  measure: male_10_to_14 {
    label: "Age 10-14"
    type: sum
    sql: ${male_10_to_14_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 10 to 14. The male population between the age of ten years to fourteen years within the specified area."
  }

  measure: male_15_to_17 {
    label: "Age 15-17"
    type: sum
    sql: ${male_15_to_17_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 15 to 17. The male population between the age of fifteeen years to seventeen years within the specified area."
  }

  measure: male_18_to_19 {
    label: "Age 18-19"
    type: sum
    sql: ${male_18_to_19_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 18 and 19. The male population between the age of eighteen years to nineteen years within the specified area."
  }

  measure: male_20 {
    label: "Age 20"
    type: sum
    sql: ${male_20_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 20. The male population with an age of twenty years within the specified area."
  }

  measure: male_21 {
    label: "Age 21"
    type: sum
    sql: ${male_21_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 21. The male population with an age of twenty-one years within the specified area."
  }

  measure: male_22_to_24 {
    label: "Age 22-24"
    type: sum
    sql: ${male_22_to_24_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 22 to 24. The male population between the age of twenty-two years to twenty-four years within the specified area."
  }

  measure: male_25_to_29 {
    label: "Age 25-29"
    type: sum
    sql: ${male_25_to_29_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 25 to 29. The male population between the age of twenty-five years to twenty-nine years within the specified area."
  }

  measure: male_30_to_34 {
    label: "Age 30-34"
    type: sum
    sql: ${male_30_to_34_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 30 to 34. The male population between the age of thirty years to thirty-four years within the specified area."
  }

  measure: male_35_to_39 {
    label: "Age 35-39"
    type: sum
    sql: ${male_35_to_39_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 35 to 39. The male population between the age of thirty-five years to thirty-nine years within the specified area."
  }

  measure: male_40_to_44 {
    label: "Age 40-44"
    type: sum
    sql: ${male_40_to_44_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 40 to 44. The male population between the age of fourty years to fourty-four years within the specified area."
  }

  measure: male_45_to_49 {
    label: "Age 45-49"
    type: sum
    sql: ${male_45_to_49_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Men age 45 to 49. The male population between the age of fourty-five years to fourty-nine years within the specified area."
  }

  measure: male_50_to_54 {
    label: "Age 50-54"
    type: sum
    sql: ${male_50_to_54_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Men age 50 to 54. The male population between the age of fifty years to fifty-four years within the specified area."
  }

  measure: male_55_to_59 {
    label: "Age 55-59"
    type: sum
    sql: ${male_55_to_59_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Men age 55 to 59. The male population between the age of fifty-five years to fifty-nine years within the specified area."
  }

  measure: male_5_to_9 {
    label: " Age 5-9"
    type: sum
    sql: ${male_5_to_9_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 5 to 9. The male population between the age of five years to nine years within the specified area."
  }

  measure: male_60_61 {
    label: "Age 60-61"
    type: sum
    sql: ${male_60_to_61_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Men age 60 to 61. The male population between the age of sixty years to sixty-one years within the specified area."
  }

  measure: male_62_64 {
    label: "Age 62-64"
    type: sum
    sql: ${male_62_to_64_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Men age 62 to 64. The male population between the age of sixty-two years to sixty-four years within the specified area."
  }

  measure: male_65_to_66 {
    label: "Age 65-66"
    type: sum
    sql: ${male_65_to_66_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 65 to 66. The male population between the age of sixty-five years to sixty-six years within the specified area."
  }

  measure: male_67_to_69 {
    label: "Age 67-69"
    type: sum
    sql: ${male_67_to_69_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 67 to 69. The male population between the age of sixty-seven years to sixty-nine years within the specified area."
  }

  measure: male_70_to_74 {
    label: "Age 70-74"
    type: sum
    sql: ${male_70_to_74_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 70 to 74. The male population between the age of seventy years to seventy-four years within the specified area."
  }

  measure: male_75_to_79 {
    label: "Age 75-79"
    type: sum
    sql: ${male_75_to_79_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 75 to 79. The male population between the age of seventy-five years to seventy-nine years within the specified area."
  }

  measure: male_80_to_84 {
    label: "Age 80-84"
    type: sum
    sql: ${male_80_to_84_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 80 to 84. The male population between the age of eighty years to eighty-four years within the specified area."
  }

  measure: male_85_and_over {
    label: "Age 85 and over"
    type: sum
    sql: ${male_85_and_over_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male age 85 and over. The male population of the age of eighty-five years and over within the specified area."
  }

  measure: male_pop {
    label: "Total Male Population"
    type: sum
    sql: ${male_pop_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male Population. The number of people within each geography who are male."
  }

  measure: male_under_5 {
    label: "  Age under 5"
    type: sum
    sql: ${male_under_5_dim} ;;
    view_label: "Gender"
    group_label: "Male"
    description: "Male under 5 years. The male population over the age of five years within the specified area."
  }
}
