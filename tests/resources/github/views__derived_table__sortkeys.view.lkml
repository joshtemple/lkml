view: views__derived_table__sortkeys {
  view_label: "Derived Table"
#     sql: select  v.sha as view_sha,
#                   v.path as view_path,
#                   v.name as view_name,
#                   v.derived_table:sortkeys::variant as sortkeys,
#                   sk.value::varchar as column_name
#           from lookml.views v
#           , lateral flatten(input => v.derived_table:sortkeys) sk ;;

  dimension: sort_keys_pk {
    group_label: "Sortkeys"
    label: "Sort Keys PK"
    type: string
    primary_key: yes
    sql: ${views.view_pk} || '-' || ${column_name}  ;;
    hidden: yes
  }

  dimension: column_name {
    group_label: "Sortkeys"
    label: "Column Name"
    type: string
    sql: sk.value::varchar ;;
  }

  measure: count {
    label: "Number of Sort Key Columns"
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
