view: averod_property_business_category_f {
  sql_table_name: pedw.fact.averod_property_business_category_f  ;;

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

  dimension: category_level_name {
    sql: ${TABLE}.category_level_name ;;
    view_label: "Business Detail"
    label: "Category Level"
    description: "Category Level Name"
    type: string
  }

  dimension: category_name {
    sql: ${TABLE}.category_name ;;
    view_label: "Business Detail"
    label: "Category"
    description: "Category Name"
    type: string
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
    html:
    {% if value < 0 %}
    <p style="color: red; font-size: 100%">{{ rendered_value }}</p>
    {% endif %};;
  }

}
