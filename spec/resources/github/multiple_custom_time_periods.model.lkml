connection: "thelook_events_redshift"

include: "basic_users.*"

view: multiple_custom_time_periods {
  extends: [basic_users]
}

view: cross_join_view {
  derived_table: {
    sql: select 1 as cross_version union all select 2 as cross_version union all select 3 as cross_version ;;
  }
  dimension: cross_version {}
  filter: date_select {
    type: date
  }
  filter: date_select3 {
    type: date
  }
}

explore: multiple_custom_time_periods {
  join: cross_join_view {
    relationship: one_to_one
    type: cross
  }

  sql_always_where:
(cross_join_view.cross_version = 2 and {% condition cross_join_view.date_select %}${multiple_custom_time_periods.created_raw}{%endcondition%})
or
(cross_join_view.cross_version = 3 and {% condition cross_join_view.date_select3 %}${multiple_custom_time_periods.created_raw}{%endcondition%})
--or cross_join_view.cross_version = 1
;;
}
