connection: "thelook_events_redshift"

include: "basic_users*"

view: test_aliasing_fields_using_view_name_for_aliasing {
  sql_table_name: public.users ;;

  dimension: id {}
  dimension: test_dimension {
    group_label: "q"
    label: "view's_name_is: {{_view._name}}"
    sql: 1 ;;
  }
  dimension: test_dimension2 {
    hidden: yes
    group_label: "q"
    label: ""
    sql: 1 ;;
  }

  measure: drill_fields_test {
    drill_fields: [test_dimension2]
    type: max
    sql: ${id}  ;;
    html: {{linked_value}} ;;
  }

}

explore: test_aliasing_fields_using_view_name_for_aliasing {
  join: t {
    from: test_aliasing_fields_using_view_name_for_aliasing
    sql_on: ${test_aliasing_fields_using_view_name_for_aliasing.id}=${t.id} ;;
    relationship: one_to_one
  }
  join: t_another_additional {
    from: test_aliasing_fields_using_view_name_for_aliasing
    sql_on: ${test_aliasing_fields_using_view_name_for_aliasing.id}=${t.id} ;;
    relationship: one_to_one
  }
}
