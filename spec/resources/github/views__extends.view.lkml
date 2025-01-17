view: views__extends {
  view_label: "Views"
#     sql: select  v.sha as view_sha,
#                   v.path as view_path,
#                   v.name as view_name,
#                   v.extends::variant as extends
#                   ext.value::varchar as explore_name
#           from lookml.views v
#           , lateral flatten(input => v.extends) ext ;;

  dimension: extends_pk {
    group_label: "Extends"
    label: "Extends PK"
    type: string
    primary_key: yes
    sql: ${views.view_pk} || '-' || ${explore_name}  ;;
    hidden: yes
  }

  dimension: explore_name {
    group_label: "Extends"
    label: "Extended Explore Name"
    type: string
    sql: ext.value::varchar ;;
  }

  measure: count {
    label: "Number of Extended Explores"
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      view_files.view_file_name,
      views.path,
      views.name,
      explore_name
    ]
  }
}
