view: database_views {
  view_label: "Database Views"
  sql_table_name: @{info_schema_db}.INFORMATION_SCHEMA.VIEWS ;;

  dimension: view_pk {
    label: "View PK"
    type: string
    sql: ${table_catalog} || '.' || ${table_schema} || '.' || ${table_name} ;;
    hidden: yes
  }

  dimension: catalog_schema_name {
    label: "Catalog.Schema Name"
    type: string
    sql: ${table_catalog} || '.' || ${table_schema} ;;
  }

  dimension: schema_view_name {
    label: "Schema.View Name"
    type: string
    sql: ${table_schema} || '.' || ${table_name} ;;
  }

  dimension: check_option {
    label: "Check Option"
    type: string
    sql: ${TABLE}.CHECK_OPTION ;;
  }

  dimension: comment {
    label: "View Comment"
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  dimension_group: view_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CREATED ;;
  }

  dimension: insertable_into {
    label: "Insertable Into"
    type: string
    sql: ${TABLE}.INSERTABLE_INTO ;;
  }

  dimension: is_secure {
    label: "Is Secure"
    type: string
    sql: ${TABLE}.IS_SECURE ;;
  }

  dimension: is_updatable {
    label: "Is Updateable"
    type: string
    sql: ${TABLE}.IS_UPDATABLE ;;
  }

  dimension_group: view_last_altered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LAST_ALTERED ;;
  }

  dimension: table_catalog {
    label: "Catalog"
    type: string
    sql: ${TABLE}.TABLE_CATALOG ;;
  }

  dimension: table_name {
    label: "View Name"
    type: string
    sql: ${TABLE}.TABLE_NAME ;;
  }

  dimension: table_owner {
    label: "View Owner"
    type: string
    sql: ${TABLE}.TABLE_OWNER ;;
  }

  dimension: table_schema {
    label: "View Schema"
    type: string
    sql: ${TABLE}.TABLE_SCHEMA ;;
  }

  dimension: view_definition {
    label: "View Definition"
    type: string
    sql: ${TABLE}.VIEW_DEFINITION ;;
  }

  measure: count {
    label: "Number of Views"
    type: count
    drill_fields: [table_name]
  }
}
