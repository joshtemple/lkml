view: us_diversity {
  sql_table_name: ferrovial.f_diversity_u ;;

  dimension: age {
    view_label: "Employee Details"
    type: number
    sql: ${TABLE}.Age ;;
  }

  dimension: age_group {
    type: tier
    view_label: "Employee Details"
    style: integer
    tiers: [18,25,35,45,55,65,75]
    sql: ${age} ;;
  }

  dimension: annual_salary {
    type: number
    drill_fields: [ethnicity_category,generation,gender]
    view_label: "Employment Information"
    value_format_name: usd_0
    sql: ${TABLE}.Annual_Salary_ ;;
  }

  dimension: random_days {
    hidden: yes
    type: number
    sql: RAND() ;;
  }

  dimension: days_absent {
    type: number
    sql: case
      when ${random} < 0.1 then 1
      when ${random} >= 0.1 and ${random} < 0.25 then 2
      when ${random} >= 0.25 and ${random} < 0.45 then 3
      when ${random} >= 0.45 and ${random} < 0.7 then 4
      when ${random} >= 0.7 and ${random} < 0.8 then 5
      when ${random} >= 0.8 and ${random} < 0.9 then 6
      when ${random} >= 0.9 and ${random} < 0.95 then 7
      else 8 end ;;
  }

  dimension: absence_rate_employee {
    sql: ((${days_absent} * 8) / 1820)*100 ;;
    value_format_name: decimal_1
    type: number
  }

  dimension: salary_difference {
    type: number
    sql: (${annual_salary}-${pay_by_position.average_salary}) / NULLIF(${pay_by_position.average_salary},0) ;;
    value_format_name: percent_1
    html: {% if {{value}} > 0 %}
    <i class="fa fa-3x fa-arrow-circle-up" style="color:#4897CE;"></i><p>{{rendered_value}}</p>
    {% elsif {{value}} < 0 %}
    <i class="fa fa-3x fa-arrow-circle-down" style="color:#ffc700;"></i><p>{{rendered_value}}</p>
    {% endif %};;
  }

  dimension: tenure_difference {
    type: number
    sql: (${tenure_months}-${pay_by_position.average_tenure}) / NULLIF(${pay_by_position.average_tenure},0) ;;
    value_format_name: percent_1
    html: {% if {{value}} > 0 %}
    <i class="fa fa-3x fa-arrow-circle-up" style="color:#4897CE;"></i><p>{{rendered_value}}</p>
    {% elsif {{value}} < 0 %}
    <i class="fa fa-3x fa-arrow-circle-down" style="color:#ffc700;"></i><p>{{rendered_value}}</p>
    {% endif %};;
  }

  measure: total_salary {
    type: sum
    view_label: "Employment Information"
    value_format_name: usd_0
    sql: ${annual_salary} ;;
  }

  dimension: salary_tiers {
    type: tier
    style: integer
    value_format_name: usd_0
    tiers: [25000,55000,85000,100000,165000,250000,325000]
    sql: ${annual_salary} ;;
  }

  measure: average_salary {
    type: average
    drill_fields: [personnel_number,full_name,manager_email,average_salary]
    view_label: "Employment Information"
    value_format_name: usd_0
    sql: ${annual_salary} ;;
  }

  dimension: cost_center {
    type: number
    view_label: "Employment Information"
    sql: ${TABLE}.Cost_Center ;;
  }

  dimension_group: date_of_birth {
    type: time
    view_label: "Employee Details"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date_of_Birth ;;
  }

  dimension: generation {
    type: string
    view_label: "Employee Details"
    sql: CASE WHEN ${date_of_birth_year} <= 1945 AND ${date_of_birth_year} > 1924
            THEN "Silent Generation"
         WHEN ${date_of_birth_year} >= 1946 AND ${date_of_birth_year} < 1965
            THEN "Baby Boomer"
         WHEN ${date_of_birth_year} >= 1965 AND ${date_of_birth_year} <= 1980
            THEN "Gen X"
         WHEN ${date_of_birth_year} > 1980 AND ${date_of_birth_year} < 1997
            THEN "Millennial"
        ELSE "Gen Z" END
    ;;
  }

  dimension: employee_group {
    type: string
    drill_fields: [employee_sub_group]
    view_label: "Job Information"
    sql: ${TABLE}.Employee_Group ;;
  }

  dimension: employee_status {
    type: string
    view_label: "Employment Information"
    sql: ${TABLE}.Employee_Status ;;
  }

  dimension: employee_sub_group {
    type: string
    drill_fields: [person_area]
    view_label: "Job Information"
    sql: ${TABLE}.Employee_subgroup_Desc ;;
  }

  dimension: ethnic_origin {
    type: string
    view_label: "Employee Details"
    hidden: yes
    sql: ${TABLE}.Ethnic_origin ;;
  }

  dimension: ethnic_origin_group {
    type: string
    view_label: "Employee Details"
    sql: CASE WHEN ${ethnic_origin} IS NULL THEN "Not Stated" ELSE ${ethnic_origin} END ;;
    drill_fields: [generation,full_name,ethnicity_category]
  }

  dimension: recent_performance_rating {
    type: number
    sql:
    case
      when ${random} < 0.1 then 1
      when ${random} >= 0.1 and ${random} < 0.25 then 2
      when ${random} >= 0.25 and ${random} < 0.75 then 3
      when ${random} >= 0.75 and ${random} < 0.93 then 4
      else 5 end
    ;;
  }

  measure: average_performance_rating {
    type: average
    value_format_name: decimal_1
    sql: ${recent_performance_rating} ;;
  }

  dimension: random {
    type: number
    hidden: yes
    sql: RAND()/2 ;;
  }

  dimension: ethnicity {
    type: string
    view_label: "Employee Details"
    sql: ${TABLE}.Ethnicity ;;
  }

  dimension: ethnicity_category {
    type: string
    view_label: "Employee Details"
    sql: ${TABLE}.Ethnicity_Racial_Cat_1 ;;
  }

  dimension: first_name {
    type: string
    view_label: "Employee Details"
    sql: ${TABLE}.First_Name ;;
  }

  dimension: gender {
    type: string
    view_label: "Employee Details"
    sql: ${TABLE}.Gender ;;
  }

  dimension_group: hire {
    type: time
    view_label: "Employment Information"
    timeframes: [
      raw,
      date,
      week,
      month_name,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Hire_Date ;;
  }

  dimension: tenure_months {
    type: number
    sql: DATE_DIFF(CURRENT_DATE(),${hire_raw},MONTH) ;;
  }

  measure: average_tenure {
    type: average
    drill_fields: [full_name,manager_name,manager_email,employee_status,position___description]
    value_format_name: decimal_0
    sql: ${tenure_months} ;;
  }

  dimension: last_name {
    view_label: "Employee Details"
    type: string
    sql: ${TABLE}.Last_Name ;;
  }

  dimension: full_name {
    type: string
    view_label: "Employee Details"
    sql: CONCAT(${first_name}, " ", ${last_name}) ;;
  }

  dimension: manager_name {
    type: string
    view_label: "Employment Information"
    sql: ${TABLE}.Manager_s_Name ;;
  }

  dimension: manager_email {
    type: string
    sql: LOWER(CONCAT(REPLACE(${manager_name}," ","."),"@hrdepartment.com")) ;;
    action: {
      label: "Email {{ value }}"
      url: "https:mailto:"
      form_param: {
        name: "title"
        type: textarea
        label: "Body"
        required: yes
        default: "{% if us_diversity.full_name._in_query %}
        Hi {{ us_diversity.manager_name._value }} , do you have a few minutes this week to talk about {{ us_diversity.full_name._value }}?
        {% else %}
        Your message here...
        {% endif %}"
    }
  }
  }

  dimension: organizational_unit {
    type: string
    view_label: "Job Information"
    sql: ${TABLE}.Organizational_unit_Desc ;;
  }

  dimension: person_area {
    type: string
    drill_fields: [person_sub_area]
    view_label: "Job Information"
    sql: ${TABLE}.Pers_Area_Desc ;;
  }

  dimension: this_year {
    type: yesno
    hidden: yes
    sql: ${hire_year} = 2018 ;;
  }

  dimension: last_year {
    type: yesno
    hidden: yes
    sql: ${hire_year} = 2017 ;;
  }

  measure: 2018_count {
    type: count_distinct
    label: "Current Year Employee Count"
    view_label: "Employment Information"
    sql: ${personnel_number} ;;
    filters: {
      field: this_year
      value: "yes"
    }
  }

  measure: 2017_count {
    type: count_distinct
    label: "Previous Year Employee Count"
    view_label: "Employment Information"
    sql: ${personnel_number} ;;
    filters: {
      field: last_year
      value: "yes"
    }
  }

  measure: percent_change_hires {
    type: number
    view_label: "Employment Information"
    value_format_name: percent_0
    sql: (${2018_count} - ${2017_count}) / nullif(${2017_count},0) ;;
    html: {% if {{value}} > 0 %}
    <p>{{rendered_value}}</p><i class="fa fa-3x fa-arrow-circle-o-up" style="color:#4897CE;"></i>
    {% elsif {{value}} < 0 %}
    <p>{{rendered_value}}</p><i class="fa fa-3x fa-arrow-circle-o-down" style="color:#D6782C;"></i>
    {% else %}
    <i class="fa fa-3x fa-minus" style="color:lightgray;"></i><p>No Gap</p>
    {% endif %}
    ;;
  }

  dimension: person_sub_area {
    type: string
    view_label: "Job Information"
    sql: ${TABLE}.Pers_Subarea_Desc ;;
  }

  dimension: location {
    type: string
    map_layer_name: us_states
    sql: TRIM(SUBSTR(REPLACE(${person_sub_area},",",""),-2)) ;;
  }

  dimension: personnel_number {
    type: number
    primary_key: yes
    link: {
      label: "View details for {{ value }}"
      url: "https://googlecloud.looker.com/dashboards/237?Personnel%20Number={{ value }}"
    }
    view_label: "Employee Details"
    sql: ${TABLE}.Personnel_Number ;;
  }

  measure: total_employee_count {
    type: count_distinct
    view_label: "Employment Information"
    sql: ${personnel_number} ;;
  }

  measure: male_count {
    type: count_distinct
    sql: ${personnel_number} ;;
    filters: {
      field: gender
      value: "Male"
    }
    html: <i class="fa fa-male" style="color:#B3C7C1;position:fixed;"></i><p>{{rendered_value}}</p> ;;
  }

  measure: female_count {
    type: count_distinct
    sql: ${personnel_number} ;;
    filters: {
      field: gender
      value: "Female"
    }
    html: <i class="fa fa-female" style="color:#F6C844;position:fixed;"></i><p>{{rendered_value}}</p> ;;
  }

  dimension: position___description {
    type: string
    view_label: "Job Information"
    sql: ${TABLE}.Position___Description ;;
  }

  dimension: termination_date {
    type: string
    view_label: "Employment Information"
    sql: ${TABLE}.Termination_Date ;;
  }

  dimension: work_contract {
    type: string
    view_label: "Job Information"
    sql: ${TABLE}.Work_Contract ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [first_name, last_name]
  }
}
