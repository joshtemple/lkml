view: looker_data_dictionary {
  sql_table_name: REPORT_TEMP.LOOKER_DATA_DICTIONARY_BASE ;;

  dimension: id {
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension: explore_access_filters {
    type: string
    sql: ${TABLE}."EXPLORE_ACCESS_FILTERS" ;;
  }

  dimension: explore_always_filter {
    type: string
    sql: ${TABLE}."EXPLORE_ALWAYS_FILTER" ;;
  }

  dimension: explore_can_explain {
    type: string
    sql: ${TABLE}."EXPLORE_CAN_EXPLAIN" ;;
  }

  dimension: explore_can_pivot_in_db {
    type: string
    sql: ${TABLE}."EXPLORE_CAN_PIVOT_IN_DB" ;;
  }

  dimension: explore_can_save {
    type: string
    sql: ${TABLE}."EXPLORE_CAN_SAVE" ;;
  }

  dimension: explore_can_subtotal {
    type: string
    sql: ${TABLE}."EXPLORE_CAN_SUBTOTAL" ;;
  }

  dimension: explore_can_total {
    type: string
    sql: ${TABLE}."EXPLORE_CAN_TOTAL" ;;
  }

  dimension: explore_description {
    type: string
    sql: ${TABLE}."EXPLORE_DESCRIPTION" ;;
  }

  dimension: explore_driver_view {
    type: string
    sql: ${TABLE}."EXPLORE_DRIVER_VIEW" ;;
  }

  dimension: explore_driver_view_sql_table_name {
    type: string
    sql: ${TABLE}."EXPLORE_DRIVER_VIEW_SQL_TABLE_NAME" ;;
  }

  dimension: explore_errors {
    type: string
    sql: ${TABLE}."EXPLORE_ERRORS" ;;
  }

  dimension: explore_label {
    type: string
    sql: ${TABLE}."EXPLORE_LABEL" ;;
  }

  dimension: explore_model_connection_name {
    type: string
    sql: ${TABLE}."EXPLORE_MODEL_CONNECTION_NAME" ;;
  }

  dimension: explore_name {
    type: string
    sql: ${TABLE}."EXPLORE_NAME" ;;
  }

  dimension: explore_source_file {
    type: string
    sql: ${TABLE}."EXPLORE_SOURCE_FILE" ;;
  }

  dimension: field_can_filter {
    type: string
    sql: ${TABLE}."FIELD_CAN_FILTER" ;;
  }

  dimension: field_category {
    type: string
    sql: ${TABLE}."FIELD_CATEGORY" ;;
  }

  dimension: field_data_type {
    type: string
    sql: ${TABLE}."FIELD_DATA_TYPE" ;;
  }

  dimension: field_description {
    type: string
    sql: ${TABLE}."FIELD_DESCRIPTION" ;;
  }

  dimension: field_group_label {
    type: string
    sql: ${TABLE}."FIELD_GROUP_LABEL" ;;
  }

  dimension: field_group_variant {
    type: string
    sql: ${TABLE}."FIELD_GROUP_VARIANT" ;;
  }

  dimension: field_hidden {
    type: string
    sql: ${TABLE}."FIELD_HIDDEN" ;;
  }

  dimension: field_label {
    type: string
    sql: ${TABLE}."FIELD_LABEL" ;;
  }

  dimension: field_label_short {
    type: string
    sql: ${TABLE}."FIELD_LABEL_SHORT" ;;
  }

  dimension: field_lookml_link {
    type: string
    sql: ${TABLE}."FIELD_LOOKML_LINK" ;;
  }

  dimension: field_name {
    type: string
    sql: ${TABLE}."FIELD_NAME" ;;
  }

  dimension: field_parameter {
    type: string
    sql: ${TABLE}."FIELD_PARAMETER" ;;
  }

  dimension: field_primary_key {
    type: string
    sql: ${TABLE}."FIELD_PRIMARY_KEY" ;;
  }

  dimension: field_project_name {
    type: string
    sql: ${TABLE}."FIELD_PROJECT_NAME" ;;
  }

  dimension: field_sortable {
    type: string
    sql: ${TABLE}."FIELD_SORTABLE" ;;
  }

  dimension: field_source_file {
    type: string
    sql: ${TABLE}."FIELD_SOURCE_FILE" ;;
  }

  dimension: field_source_file_path {
    type: string
    sql: ${TABLE}."FIELD_SOURCE_FILE_PATH" ;;
  }

  dimension: field_source_view {
    type: string
    sql: ${TABLE}."FIELD_SOURCE_VIEW" ;;
  }

  dimension: field_sql {
    type: string
    sql: ${TABLE}."FIELD_SQL" ;;
  }

  dimension: field_sql_case {
    type: string
    sql: ${TABLE}."FIELD_SQL_CASE" ;;
  }

  dimension: field_suggest_dimension {
    type: string
    sql: ${TABLE}."FIELD_SUGGEST_DIMENSION" ;;
  }

  dimension: field_suggest_explore {
    type: string
    sql: ${TABLE}."FIELD_SUGGEST_EXPLORE" ;;
  }

  dimension: field_suggestions {
    type: string
    sql: ${TABLE}."FIELD_SUGGESTIONS" ;;
  }

  dimension: field_tags {
    type: string
    sql: ${TABLE}."FIELD_TAGS" ;;
  }

  dimension: field_value_format {
    type: string
    sql: ${TABLE}."FIELD_VALUE_FORMAT" ;;
  }

  dimension: field_view {
    label: "View"
    type: string
    sql: ${TABLE}."FIELD_VIEW" ;;
  }

  dimension: field_view_label {
    label: "View Label"
    type: string
    sql: ${TABLE}."FIELD_VIEW_LABEL" ;;
  }

  dimension: model_label {
    type: string
    sql: ${TABLE}."MODEL_LABEL" ;;
  }

  dimension: model_name {
    type: string
    sql: ${TABLE}."MODEL_NAME" ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}."PROJECT_NAME" ;;
  }

  measure: count {
    type: count
    description: "Total Fields"
    drill_fields: [detail_drill_path*]
  }

  # ----- Sets of fields for drilling ------
  set: detail_drill_path {
    fields: [
      id,
      model_name,
      explore_name,
      explore_description,
      explore_driver_view_sql_table_name,
      field_category,
      field_source_view,
      field_view,
      field_view_label,
      field_name,
      field_label_short,
      field_label,
      field_description,
      field_data_type,
      field_sql
    ]
  }

  # ----- Exposing these fields will expose PDX IP, hence excluding these fields from being exposed from Customer specific models  ------
  # ----- [model_name,explore_name,explore_description,field_category,field_view_label,field_label_short,field_name,field_description,field_data_type] ---> Are only acceptable fields to be exposed to customer
  set: customer_field_exclusion_list {
    fields: [
      id,
      explore_access_filters,
      explore_always_filter,
      explore_can_explain,
      explore_can_pivot_in_db,
      explore_can_save,
      explore_can_subtotal,
      explore_can_total,
#       explore_description,
      explore_driver_view,
      explore_driver_view_sql_table_name,
      explore_errors,
      explore_label,
      explore_model_connection_name,
#       explore_name,
      explore_source_file,
      field_can_filter,
#       field_category,
#       field_data_type,
#       field_description,
      field_group_label,
      field_group_variant,
      field_hidden,
      field_label,
#       field_label_short,
      field_lookml_link,
#       field_name,
      field_parameter,
      field_primary_key,
      field_project_name,
      field_sortable,
      field_source_file,
      field_source_file_path,
      field_source_view,
      field_sql,
      field_sql_case,
      field_suggest_dimension,
      field_suggest_explore,
      field_suggestions,
      field_tags,
      field_value_format,
      field_view,
#       field_view_label,
      model_label,
#       model_name,
      project_name,
      count
    ]
  }
}
