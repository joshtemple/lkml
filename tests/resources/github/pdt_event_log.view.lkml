view: pdt_event_log {
  label: "PDT Event Log"

  dimension: id {
    primary_key: yes
    description: "The unique numeric identifier for the log entry"
    type: number
  }

  dimension: action {
    description: "The type of PDT action that created the log entry"
    type: string
  }

  dimension: action_data {
    description: "Data related to the type of action. For example, a trigger value action would show the value of the data that caused the trigger to occur, whereas a regenerate end action would show whether the table regeneration was successful."
    type: string
  }

  dimension: connection {
    description: "The name of the Looker connection from which a model retrieves data from the PDT"
    type: string
  }

  dimension: hash {
    description: "A unique string identifier for the query that creates the PDT. This is a method to ensure that PDTs are not duplicated."
    type: string
    sql: ${TABLE}.HASH_KEY ;;
  }

  dimension: short_hash {
    description: "The first 8 characters of the hash"
    label: "Hash (short)"
    type: string
    sql: SUBSTRING(${hash}, 1, 8) ;;
  }

  dimension: model_name {
    description: "The name of the model in which the PDT view is saved"
    type: string
  }

  dimension_group: created {
    description: "The date and time the event occurred"
    type: time
    datatype: epoch
    sql:
    {% if _dialect._name == 'hypersql' %}
      ${TABLE}.AT
    {% elsif _dialect._name == 'bigquery_standard_sql' %}
      CAST(${TABLE}.AT AS INT64)
    {% else %}
      ${TABLE}.AT
    {% endif %};;
  }

  dimension: sequence {
    description: "A single PDT action can create several events. The transaction ID uniquely identifies PDT actions, and the sequence number uniquely identifies individual events that comprise the action."
    label: "Transaction Sequence #"
    type: number
    sql: ${TABLE}.TSEQ ;;
  }

  dimension: table_name {
    description: "The database table name assigned to the PDT"
    type: string
  }

  dimension: extract_view_from_table {
    description: "The PDT view name, derived from the database table name"
    type: string
    sql:
    {% if _dialect._name == 'hypersql' %}
      SUBSTR(${table_name}, LOCATE('_', ${table_name}) + 1)
    {% elsif _dialect._name == 'bigquery_standard_sql' %}
      CASE WHEN STRPOS(pdt_event_log.table_name, '$') = 0 THEN SUBSTR(SUBSTR(pdt_event_log.table_name, 4), STRPOS(SUBSTR(pdt_event_log.table_name, 4), '_') + 1)
      WHEN STRPOS(pdt_event_log.table_name, '$') > 0  THEN SUBSTR(pdt_event_log.table_name, STRPOS(pdt_event_log.table_name, '_') + 1)
      ELSE NULL END
    {% else %}
      NULL
    {% endif %};;
  }

  dimension: tid {
    description: "The unique identifier the database assigned to the unit of work, containing one or more SQL statements, related to the event"
    type: string
    label: "Transaction ID"
  }
  dimension: short_tid {
    description: "The first 8 characters of the transaction ID"
    label: "Transaction ID (short)"
    type: string
    sql: SUBSTRING(${tid},1,8) ;;
  }

  dimension: view_name {
    description: "The PDT LookML view name"
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: pdt_trigger_failures {
    label: "PDT Trigger Failures"
    description: "A count of the actions of type 'trigger value error'"
    type: count
    filters: {
      field: action
      value: "trigger value error"
    }
  }

  measure: pdt_create_failures {
    label: "PDT Create Failures"
    description: "A count of the actions of type 'create cancelled error'"
    type: count
    filters: {
      field: action
      value: "create cancelled error, create child error, create rename error, create sql error"
    }
  }

  measure: successful_pdt_builds {
    label: "Successful PDT Builds"
    description: "A count of the actions of type 'create complete'"
    type: count
    filters: {
      field: action
      value: "create complete"
    }
  }

  measure: percent_successful_builds {
    label: "Percent Successful Builds"
    description: "Count of successful builds, divided by sum of successful builds and create failures"
    type: number
    sql: COALESCE(${successful_pdt_builds} / NULLIF(${successful_pdt_builds} + ${pdt_create_failures}, 0), 0) ;;
    value_format_name: percent_3
  }

  ################
  # The following measures are used in the NDT defined in the pdt_builds view.
  # They're pretty specific to that view, so they're hidden.
  measure: raw_status {
    type: max
    hidden: yes
    sql:
      CASE
        WHEN ${action} LIKE 'create begin' THEN '00-waiting dependencies'
        WHEN ${action} LIKE 'create ready' THEN '01-in process'
        WHEN ${action} LIKE 'create complete' THEN '03-done'
        WHEN ${action} LIKE 'create%error' THEN CONCAT('03-',${action})
        ELSE CONCAT('02-',${action}) -- unhandled
      END ;;
  }

  measure: status {
    hidden: yes
    type: string
    sql: SUBSTR(${raw_status}, 4) ;;
  }

  measure: earliest_created {
    hidden: yes
    type: min
    sql: ${created_raw} ;;
  }

  measure: latest_created {
    hidden: yes
    type: max
    sql: ${created_raw} ;;
  }

  measure: create_context {
    type: max
    hidden: yes
    description: "The workspace and optional user id e.g. dev-user-42"
    sql:
      {% if _dialect._name == 'hypersql' %}
        CASE ${action}
          WHEN 'create begin' THEN COALESCE(${action_data}, 'Unknown')
          ELSE NULL
        END
      {% else %}
        CASE
          WHEN ${action} = 'create begin' THEN COALESCE(${action_data}, "Unknown")
          ELSE NULL
        END
      {% endif %} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      connection,
      model_name,
      view_name,
      table_name,
      action,
      created_time
    ]
  }
}

view: pdt_table_to_view_map {
  derived_table: {
    explore_source: pdt_event_log {
      column: table_name_0 { field: pdt_event_log.table_name }
      column: view_name_0 { field: pdt_event_log.view_name }
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
    description:
      "Some events capture the table name, but not the view name.
      This field calculates the view name based on any other events that
      may have captured the view name with the table name."
    sql: ${TABLE}.view_name_0 ;;
  }

}
