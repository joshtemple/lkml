connection: "thelook_events_redshift"

view: users {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
}

explore: users {
#   view_label: "version 1.1"
#   view_label: "version 1.2"
#   view_label: "version 1.3 - in progress"
#   view_label: "1.4.2"
  view_label: "1.5.1"
}
