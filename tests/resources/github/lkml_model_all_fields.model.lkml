# This model contains at least 2 of ALL sub-objects with ALL parameter fields possible
# Used for building/testing Stitch/Singer data integration and Object Schema JSONs

connection: "snowflake_stitch"

include: "/**/*.view"                      # include all views in this project
include: "/lkml/lkml_view_all_fields.view"

label: "desired label name"

fiscal_month_offset: 0
persist_for: "24 hours"
# persist_with: datagroup_name
case_sensitive: yes
week_start_day: monday

# Some comments
named_value_format: dollars {
  value_format: "$#,##0.00"
}

named_value_format: euros {
  value_format: "\€#.##0,00"
}

map_layer: identifier {
  # extents_json_url: "URL to JSON extents file"
  feature_key: "Name of TopoJSON object"
  file: "/lkml/africa_map_layer.topojson"
  format: topojson
  label: "Label I want"
  # max_zoom_level: 10
  # min_zoom_level: 5
  projection: cartesian
  property_key: "TopoJSON property"
  property_label_key: "Label for TopoJSON property"
  # url: "URL that contains map file"
}

map_layer: identifier_2 {
  # extents_json_url: "URL to JSON extents file"
  feature_key: "Name of TopoJSON object"
  file: "/lkml/africa_map_layer.topojson"
  format: topojson
  label: "Label I want"
  # max_zoom_level: 10
  # min_zoom_level: 5
  projection: cartesian
  property_key: "TopoJSON property"
  property_label_key: "Label for TopoJSON property"
  # url: "URL that contains map file"
}

datagroup: datagroup_name {
  sql_trigger: SQL query ;;
  max_cache_age: "24 hours"
}

datagroup: datagroup_name_2 {
  sql_trigger: SQL query ;;
  max_cache_age: "12 hours"
}

access_grant: access_grant_name {
  user_attribute: test
  allowed_values: ["value_1", "value_2"]
}

access_grant: access_grant_name_2 {
  user_attribute: test_2
  allowed_values: ["value_1", "value_2"]
}

explore: view_name {
  description: "description string"
  label: "desired label name"
  group_label: "label to use as a heading in the Explore menu"
  view_label: "field picker heading to use for the Explore's fields"
  extends: [explore_name, explore_name]
  extension: required
  symmetric_aggregates: yes
  hidden: yes
  fields: [field_or_set, field_or_set]

  sql_always_where: SQL WHERE condition ;;
  sql_always_having: SQL WHERE condition ;;

  required_access_grants: [access_grant_name, access_grant_name]

  always_filter: {
    filters: {
      field: field_name
      value: "looker filter expression"
    }
  }

  conditionally_filter: {
    filters: {
      field: field_name
      value: "looker filter expression"
    }
    unless: [field_or_set, field_or_set]
  }

  access_filter: {
    field: fully_scoped_field
    user_attribute: user_attribute_name
  }

  always_join: [view_name, view_name]

  join: view_name_2 {
    type: left_outer
    relationship: one_to_one
    from: view_name
    outer_only: no
    sql_table_name: table_name ;;
    sql_foreign_key: foreign_key_name ;;
    sql_where: where_criteria ;;
    view_label: "desired label name"
    fields: [field_or_set, field_or_set]
    required_joins: [view_name, view_name]
    foreign_key: dimension_name
    sql_on: SQL ON clause ;;
    required_access_grants: [access_grant_name, access_grant_name]
  }
  # Join comments
  join: view_name_3 {
    type: left_outer
    relationship: one_to_one
    from: view_name
    outer_only: yes
    sql_table_name: table_name ;;
    sql_foreign_key: foreign_key_name ;;
    sql_where: where_criteria ;;
    view_label: "desired label name"
    fields: [field_or_set, field_or_set]
    required_joins: [view_name, view_name]
    foreign_key: dimension_name
    sql_on: SQL ON clause ;;
    required_access_grants: [access_grant_name, access_grant_name]
  }

  persist_for: "24 hours"
  persist_with: datagroup_name
  from: view_name
  view_name: view_name
  case_sensitive: yes
  sql_table_name: table_name ;;
  cancel_grouping_fields: [fully_scoped_field, fully_scoped_field]
}


# Ending comments
