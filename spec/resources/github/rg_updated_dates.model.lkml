connection: "bigquery"

# include all the views
include: "*.view"

datagroup: rg_dates_example_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "48 hours"
}

persist_with: rg_dates_example_default_datagroup

explore: raw_data {
  join: mtd_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_MTD_Derived}=${mtd_derived.Join_Key_MTD_Derived} ;;
  }

  join: qtd_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_QTD_Derived}=${qtd_derived.Join_Key_QTD_Derived} ;;
  }

  join: ytd_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_YTD_Derived}=${ytd_derived.Join_Key_YTD_Derived} ;;
  }

  join: last_month_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_Last_Month_Derived}=${last_month_derived.Join_Key_Last_Month_Derived} ;;
  }

  join: last_mtd_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_LMTD_Raw}=${last_mtd_derived.Join_Key_LMTD_Raw} ;;
  }

  join: last_qtd_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_LQTD_Raw}=${last_qtd_derived.Join_Key_LQTD_Raw} ;;
  }

  join: last_quarter_derived {
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_LQ_Raw}=${last_quarter_derived.Join_Key_LQ_Raw} ;;
  }

  join: last_year_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_LY_Raw}=${last_year_derived.Join_Key_LY_Raw} ;;
  }

  join: last_ytd_derived{
    view_label: "Raw Data"
    relationship: one_to_one
    sql_on: ${raw_data.Join_Key_LYTD_Raw}=${last_ytd_derived.Join_Key_LYTD_Raw} ;;
  }



}
