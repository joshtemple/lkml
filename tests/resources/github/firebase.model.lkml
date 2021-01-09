connection: "bigquery_publicdata_standard_sql"

include: "FIREBASE_BLOCK.view"         # include all views in this project
include: "*generated.view"

# Change the name to the location of the table (note, no trailing space).
view: app_events_table {
  sql_table_name: bigquery-connectors.firebase.app_events_;;
}

explore: sessions {
  extends: [sessions_base]
  # Uncomment if you want to examine less time by default
  # conditionally_filter:{ filters:{field:event_date  value:"2 days"}}
}

view: sessions {
  extends: [sessions_base]
}

view: user {
  extends: [user_base, user_generated]

  # Uncomment if user is identified by the app_instance.
  dimension: user_id {sql: ${app_instance_id} ;;}
}

view: events {
  extends: [events_base, events_generated]
}

view: events2 {
  extends: [events_base]
}

view: device {
  extends: [device_base]
}
