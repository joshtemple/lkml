include: "//@{CONFIG_PROJECT_NAME}/pdt_table_to_view_map.view.lkml"

view: pdt_table_to_view_map {
  extends: [pdt_table_to_view_map_config]
}

view: pdt_table_to_view_map_core {
  derived_table: {
    explore_source: pdt_event_log {
      column: table_name_0 {
        field: pdt_event_log.table_name
      }

      column: view_name_0 {
        field: pdt_event_log.view_name
      }

      filters: {
        field: pdt_event_log.view_name
        value: "-NULL"
      }
    }
  }

  dimension: table_name {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.table_name_0 ;;
  }

  dimension: derived_view_name {
    view_label: "PDT Event Log"
    label: "View Name (derived)"
    description: "Some events capture the table name, but not the view name.
      This field calculates the view name based on any other events that
      may have captured the view name with the table name."
    sql: ${TABLE}.view_name_0 ;;
  }
}
