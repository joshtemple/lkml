label: "desired label name"
connection: "connection_name"
include: "filename_or_pattern"
include: "filename_or_pattern"

fiscal_month_offset: N
persist_for: "N seconds"
persist_with: datagroup_name
case_sensitive: yes
week_start_day: monday

named_value_format: desired_format_name {
  value_format: "excel-style formatting string"
}

named_value_format: desired_format_name {
  value_format: "excel-style formatting string"
}

map_layer: identifier {
  extents_json_url: "URL to JSON extents file"
  feature_key: "Name of TopoJSON object"
  file: "TopoJSON file name"
  format: topojson
  label: "Label I want"
  max_zoom_level: 10
  min_zoom_level: 5
  projection: geo_projection
  property_key: "TopoJSON property"
  property_label_key: "Label for TopoJSON property"
  url: "URL that contains map file"
}

datagroup: datagroup_name {
  sql_trigger: SQL query ;;
  max_cache_age: "N minutes"
}

datagroup: datagroup_name {
  sql_trigger: SQL query ;;
  max_cache_age: "N minutes"
}

access_grant: access_grant_name {
  user_attribute: user_attribute_name
  allowed_values: ["value_1", "value_2"]
}

access_grant: access_grant_name {
  user_attribute: user_attribute_name
  allowed_values: ["value_1", "value_2"]
}

test: data_test_name {
  explore_source: explore_name {
    column: column_name {
      field: view_name.dimension_name
    }
    filters: {
      field: view_name.dimension_name
      value: "value"
    }
  }
  assert: assertion_name {
    expression: ${view_name.dimension_name} = 626000 ;;
  }
  assert: assertion_name {
    expression: ${view_name.dimension_name} = 'value' ;;
  }
}

test: data_test_name {
  explore_source: explore_name {
    column: column_name {
      field: view_name.dimension_name
    }
    filters: {
      field: view_name.dimension_name
      value: "value"
    }
  }
  assert: assertion_name {
    expression: ${view_name.dimension_name} = 626000 ;;
  }
  assert: assertion_name {
    expression: ${view_name.dimension_name} = 'value' ;;
  }
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

  join: view_name {
    type: left_outer
    relationship: one_to_one
    from: view_name
    sql_table_name: table_name ;;
    view_label: "desired label name"
    fields: [field_or_set, field_or_set]
    required_joins: [view_name, view_name]
    foreign_key: dimension_name
    sql_on: SQL ON clause ;;
    required_access_grants: [access_grant_name, access_grant_name]
  }

  join: view_name {
    type: left_outer
    relationship: one_to_one
    from: view_name
    sql_table_name: table_name ;;
    view_label: "desired label name"
    fields: [field_or_set, field_or_set]
    required_joins: [view_name, view_name]
    foreign_key: dimension_name
    sql_on: SQL ON clause ;;
    required_access_grants: [access_grant_name, access_grant_name]
  }

  persist_for: "N hours"
  persist_with: datagroup_name
  from: view_name
  view_name: view_name
  case_sensitive: true
  sql_table_name: table_name ;;
  cancel_grouping_fields: [fully_scoped_field, fully_scoped_field]
}
