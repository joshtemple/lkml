view: views__derived_table__indexes {
  view_label: "Derived Table"
#     sql: select  v.sha as view_sha,
#                   v.path as view_path,
#                   v.name as view_name,
#                   v.derived_table:indexes::variant as indexes,
#                   idx.value::varchar as column_name
#           from lookml.views v
#           , lateral flatten(input => v.derived_table:indexes) idx ;;

  dimension: indexes_pk {
    group_label: "Indexes"
    label: "Indexes PK"
    type: string
    primary_key: yes
    sql: ${views.view_pk} || '-' || ${column_name}  ;;
    hidden: yes
  }

  dimension: column_name {
    group_label: "Indexes"
    label: "Column Name"
    type: string
    sql: idx.value::varchar ;;
  }

  measure: count {
    label: "Number of Index Columns"
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      view_files.view_file_name,
      views.path,
      views.name,
      column_name
    ]
  }
}
