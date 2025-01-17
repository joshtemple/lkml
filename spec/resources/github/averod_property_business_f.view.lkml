view: averod_property_business_f {
  sql_table_name: pedw.fact.averod_property_business_f  ;;

  #-------------------------------------------------------------------------------------------
  #-- Keys
  #-------------------------------------------------------------------------------------------

  dimension: property_key {
    primary_key: yes
    sql: ${TABLE}.property_key ;;
    hidden: yes
  }

  dimension: date_sid {
    sql: ${TABLE}.date_sid ;;
    hidden: yes
  }

  #-------------------------------------------------------------------------------------------
  #-- Dimensions
  #-------------------------------------------------------------------------------------------

  dimension: parent_business_level_name {
    sql: ${TABLE}.parent_business_level_name ;;
    view_label: "Business Detail"
    label: "Parent Business Level"
    description: "Parent Business Level Name"
    type: string
  }

  dimension: parent_business_name {
    sql: ${TABLE}.parent_business_name ;;
    view_label: "Business Detail"
    label: "Parent Business"
    description: "Parent Business Name"
    type: string
  }

  dimension: business_level_name {
    sql: ${TABLE}.business_level_name ;;
    view_label: "Business Detail"
    label: "Business Level"
    description: "Business Level Name"
    type: string
  }

  dimension: business_name {
    sql: ${TABLE}.business_name ;;
    view_label: "Business Detail"
    label: "Business"
    description: "Business Name"
    type: string
  }

  dimension: meal_period_sort_no {
    sql: case
          when ${TABLE}.meal_period_name = 'Breakfast' then 1
          when ${TABLE}.meal_period_name = 'Lunch' then 2
          when ${TABLE}.meal_period_name = 'Dinner' then 3
          when ${TABLE}.meal_period_name = 'Late Night' then 4
          when ${TABLE}.meal_period_name = 'All Day' then 5
          else 9999
        end ;;
    view_label: "Business Detail"
    label: "Meal Period"
    description: "Meal Period Name"
    type: string
    hidden:  yes
  }

  dimension: meal_period_name {
    sql: ${TABLE}.meal_period_name ;;
    view_label: "Business Detail"
    label: "Meal Period"
    description: "Meal Period Name"
    type: string
    order_by_field: meal_period_sort_no
  }

  #-------------------------------------------------------------------------------------------
  #-- Measures - Business Detail Stats
  #-------------------------------------------------------------------------------------------

  measure: parent_business_cnt {
    view_label: "Business Detail"
    label: "Ttl Parent Business"
    description: "Total Count of Parent Businesses"
    type: count_distinct
    sql: ${TABLE}.parent_business_name ;;
    hidden: no
  }

  measure: business_cnt {
    view_label: "Business Detail"
    label: "Ttl Business"
    description: "Total Count of Businesses"
    type: count_distinct
    sql: ${TABLE}.business_name ;;
    hidden: no
  }

  #-------------------------------------------------------------------------------------------
  #-- Measures
  #-------------------------------------------------------------------------------------------

  measure:  ty_gross_sales_amt {
    sql: ${TABLE}.ty_gross_sales_amt ;;
    value_format_name: usd_0
    view_label: "   TY"
    label: "Rev $"
    description: "Gross Sales Amount"
    type: sum
  }

  measure:  ty_net_sales_amt {
    sql: ${TABLE}.ty_net_sales_amt ;;
    value_format_name: usd_0
    view_label: "   TY"
    label: "Rev Net $"
    description: "Net Sales Amount"
    type: sum
  }

  measure:  ty_cover_cnt {
    sql: ${TABLE}.ty_cover_cnt ;;
    value_format_name: decimal_0
    view_label: "   TY"
    label: "Cvrs"
    description: "Cover Count"
    type: sum
  }

  measure:  ty_check_cnt {
    sql: ${TABLE}.ty_check_cnt ;;
    value_format_name: decimal_0
    view_label: "   TY"
    label: "Chks"
    description: "Check Count"
    type: sum
  }

  measure:  ty_avg_check_amt {
    sql: utl..udf_divide( ${ty_gross_sales_amt} , ${ty_cover_cnt} ) ;;
    value_format_name: usd
    view_label: "   TY"
    label: "Avg Cvrs $"
    description: "Rev $ / Covers"
    type: number
  }

  #-------------------------------------------------------------------------------------------
  #-- Measures LY
  #-------------------------------------------------------------------------------------------

  measure:  ly_gross_sales_amt {
    sql: ${TABLE}.ly_gross_sales_amt ;;
    value_format_name: usd_0
    view_label: "  LY"
    label: "Rev $"
    description: "Gross Sales Amount"
    type: sum
  }

  measure:  ly_net_sales_amt {
    sql: ${TABLE}.ly_net_sales_amt ;;
    value_format_name: usd_0
    view_label: "  LY"
    label: "Rev Net $"
    description: "Net Sales Amount"
    type: sum
  }

  measure:  ly_cover_cnt {
    sql: ${TABLE}.ly_cover_cnt ;;
    value_format_name: decimal_0
    view_label: "  LY"
    label: "Cvrs"
    description: "Cover Count"
    type: sum
  }

  measure:  ly_check_cnt {
    sql: ${TABLE}.ly_check_cnt ;;
    value_format_name: decimal_0
    view_label: "  LY"
    label: "Chks"
    description: "Check Count"
    type: sum
  }

  measure:  ly_avg_cover_amt {
    sql: utl..udf_divide( ${ly_gross_sales_amt}, ${ly_cover_cnt} ) ;;
    value_format_name: usd
    view_label: "  LY"
    label: "Avg Cvrs $"
    description: "Rev $ / Covers"
    type: number
  }

  #-------------------------------------------------------------------------------------------
  #-- Measures compare to py
  #-------------------------------------------------------------------------------------------

  measure:  gross_sales_var_perc{
    sql: utl..udf_percent_var((${ty_gross_sales_amt}),(${ly_gross_sales_amt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   TY"
    label: "Rev $ Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  gross_sales_var{
    sql: (${ty_gross_sales_amt})-(${ly_gross_sales_amt}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   TY"
    label: "Rev $ Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  net_sales_var_perc{
    sql: utl..udf_percent_var((${ty_net_sales_amt}),(${ly_net_sales_amt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   TY"
    label: "Rev Net $ Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  net_sales_var{
    sql: (${ty_net_sales_amt})-(${ly_net_sales_amt}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   TY"
    label: "Rev Net $ Act:LY - var"
    description: "(TY - LY)"
  }

  measure:  cover_var_perc{
    sql: utl..udf_percent_var((${ty_cover_cnt}),(${ly_cover_cnt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   TY"
    label: "Cvrs Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  cover_var{
    sql: (${ty_cover_cnt})-(${ly_cover_cnt}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   TY"
    label: "Cvrs Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  check_var_perc{
    sql: utl..udf_percent_var((${ty_check_cnt}),(${ly_check_cnt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   TY"
    label: "Chks Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  check_var{
    sql: (${ty_check_cnt})-(${ly_check_cnt}) ;;
    type: number
    value_format_name: decimal_0
    view_label: "   TY"
    label: "Chks Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  avg_cover_perc{
    sql: utl..udf_percent_var((${ty_check_cnt}),(${ly_check_cnt})) ;;
    type: number
    value_format_name: percent_1
    view_label: "   TY"
    label: "Avg Cvrs Act:LY - % var"
    description: "(TY - LY)/LY"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

  measure:  avg_cover_var{
    sql: (${ty_check_cnt})-(${ly_check_cnt}) ;;
    type: number
    value_format_name: usd
    view_label: "   TY"
    label: "Avg Cvrs Act:LY - var"
    description: "(TY - LY)"
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

}
