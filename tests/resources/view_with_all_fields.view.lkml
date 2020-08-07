include: "filename_or_pattern"
include: "filename_or_pattern"

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

view: view_name {
  sql_table_name: table_name ;;
  suggestions: no
  extends: [view_name, view_name]
  extension: required
  required_access_grants: [access_grant_name, access_grant_name]
  derived_table: {
    explore_source: explore_name {
      bind_filters: {
        from_field: field_name
        to_field: field_name
      }
      column: column_name {
        field: field_name
      }
      column: column_name {
        field: field_name
      }
      derived_column: column_name {
        sql: SQL query ;;
      }
      derived_column: column_name {
        sql: SQL query ;;
      }
      expression_custom_filter: custom_filter_expression ;;
      filters: {
        field: field_name
        value: "filter_value"
      }
      filters: {
        field: field_name
        value: "filter_value"
      }
      limit: number
      sort: {
        desc: no
        field: field_name
      }
      timezone: "timezone_name"
    }
    sql: SQL query ;;
    persist_for: "N hours"
    sql_trigger_value: SQL query ;;
    cluster_keys: ["column_name", "column_name"]
    datagroup_trigger: datagroup_name
    distribution: "column_name"
    distribution_style: all
    sortkeys: ["column_name", "column_name"]
    indexes: ["column_name", "column_name"]
    partition_keys: ["column_name", "column_name"]
    create_process: {
      sql_step: SQL query ;;
    }
    sql_create: SQL query ;;
  }
  set: set_name {
    fields: [field_or_set, field_or_set]
  }
  dimension: field_name {
    action: {
      label: "Label to Appear in Action Menu"
      url: "url"
      icon_url: "url"
      form_url: "url"
      user_attribute_param: {
        user_attribute: user_attribute_name
        name: "name_for_json_payload"
      }
      user_attribute_param: {
        user_attribute: user_attribute_name
        name: "name_for_json_payload"
      }
      param: {
        name: "name string"
        value: "value string"
      }
      param: {
        name: "name string"
        value: "value string"
      }
      form_param: {
        name: "form_param_name_1"
        type: select
        label: "desired label name"
        required: yes
        default: "value string"
        option: {
          name: "name string"
          value: "value string"
        }
        option: {
          name: "name string"
          value: "value string"
        }
      }
      form_param: {
        name: "title"
        type: string
        label: "desired label name"
        required: no
        default: "value string"
        option: {
          name: "name string"
          value: "value string"
        }
        option: {
          name: "name string"
          value: "value string"
        }
      }
    }
    action: {
      label: "Another Label to Appear in Action Menu"
      url: "url"
      icon_url: "url"
      form_url: "url"
      param: {
        name: "name string"
        value: "value string"
      }
      form_param: {
        name: "form_param_name_1"
        type: select
        label: "desired label name"
        required: yes
        default: "value string"
        option: {
          name: "name string"
          value: "value string"
        }
      }
    }
    label: "desired label name"
    label_from_parameter: parameter_name
    view_label: "desired label name"
    group_label: "label used to group dimensions in the field picker"
    group_item_label: "label to use for the field under its group label in the field picker"
    description: "description string"
    hidden: no
    alias: [old_field_name, old_field_name]
    value_format: "excel-style formatting string"
    value_format_name: format_name
    html: HTML expression using Liquid template elements ;;
    sql: SQL expression to generate the field value ;;
    required_fields: [field_name, field_name]
    drill_fields: [field_or_set, field_or_set]
    can_filter: no
    fanout_on: repeated_record_name
    tags: ["string1", "string2"]
    type: field_type
    primary_key: no
    case: {
      when: {
        sql: SQL condition ;;
        label: "value"
      }
      when: {
        sql: SQL condition ;;
        label: "value"
      }
    }
    alpha_sort: no
    tiers: [N, N]
    style: relational
    sql_latitude: SQL expression to generate a latitude ;;
    sql_longitude: SQL expression to generate a longitude ;;
    suggestable: no
    suggest_persist_for: "N hours"
    suggest_dimension: dimension_name
    suggest_explore: explore_name
    suggestions: ["suggestion string", "suggestion string"]
    allowed_value: {
      label: "desired label name"
      value: "looker filter expression"
    }
    allowed_value: {
      label: "desired label name"
      value: "looker filter expression"
    }
    required_access_grants: [access_grant_name, access_grant_name]
    bypass_suggest_restrictions: no
    full_suggestions: no
    skip_drill_filter: no
    case_sensitive: no
    order_by_field: dimension_name
    map_layer_name: name_of_map_layer
    link: {
      label: "desired label name;"
      url: "desired_url"
      icon_url: "url_of_an_ico_file"
    }
    link: {
      label: "desired label name;"
      url: "desired_url"
      icon_url: "url_of_an_ico_file"
    }
    timeframes: [timeframe, timeframe]
    convert_tz: no
    datatype: timestamp
    intervals: [interval, interval]
    sql_start: SQL expression for start time of duration ;;
    sql_end: SQL expression for end time of duration ;;
    direction: "column"
    approximate: no
    approximate_threshold: N
    sql_distinct_key: SQL expression to define repeated entities ;;
    list_field: dimension_name
    percentile: 90
    precision: N
    filters: {
      field: dimension_name
      value: "looker filter expression"
    }
    filters: [
      dimension_name: "looker filter expression",
      dimension_name: "looker filter expression"
    ]
    default_value: "desired default value"
  }
}
