include: "//@{CONFIG_PROJECT_NAME}/views.view"

view: views {
  extends: [views_config]
}

view: views_core {
  sql_table_name: @{DATABASE_NAME}.ACCOUNT_USAGE.VIEWS ;;

  # Field Descriptions from Snowflake Documentation: https://docs.snowflake.net/manuals/sql-reference/account-usage/views.html

  # DIMENSIONS #

  dimension: check_option {
    type: string
    sql: ${TABLE}.CHECK_OPTION ;;
    description: "Not applicable for Snowflake"
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
    description: "Comment for the view"
  }

  dimension_group: created {
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
    description: "Date and time when the view was created"
  }

  dimension_group: deleted {
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
    sql: ${TABLE}.DELETED ;;
    description: "Date and time when the view was deleted"
  }

  dimension: is_secure {
    type: yesno
    sql: CASE WHEN ${TABLE}.IS_SECURE = 'YES' THEN TRUE ELSE FALSE END ;;
    description: "Specifies whether the view is secure"
  }

  dimension_group: last_altered {
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
    description: "Date and time when the view was last altered"
  }

  dimension: table_catalog {
    type: string
    sql: ${TABLE}.TABLE_CATALOG ;;
    description: "Database that the view belongs to"
  }

  dimension: table_catalog_id {
    type: string
    sql: ${TABLE}.TABLE_CATALOG_ID ;;
    description: "Internal/system-generated identifier for the database that the view belongs to"
  }

  dimension: table_id {
    type: string
    sql: ${TABLE}.TABLE_NAME ;;
    description: "Internal/system-generated identifier for the view"
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.TABLE_NAME ;;
    description: "Name of the view"
  }

  dimension: table_owner {
    type: string
    sql: ${TABLE}.TABLE_OWNER ;;
    description: "Name of the role that owns the view"
  }

  dimension: table_schema {
    type: string
    sql: ${TABLE}.TABLE_SCHEMA ;;
    description: "Schema that the view belongs to"
  }

  dimension: table_schema_id {
    type: string
    sql: ${TABLE}.TABLE_SCHEMA ;;
    description: "Internal/system-generated identifier for the schema that the view belongs to"
  }

  dimension: view_definition {
    type: string
    sql: ${TABLE}.VIEW_DEFINITION ;;
    description: "Text of the query expression for the view"
  }

  # No descriptions available for the below dimensions

  dimension: insertable_into {
    type: yesno
    sql: CASE WHEN ${TABLE}.INSERTABLE_INTO = 'YES' THEN TRUE ELSE FALSE END ;;
  }

  dimension: is_updatable {
    type: yesno
    sql: CASE WHEN ${TABLE}.IS_UPDATABLE = 'YES' THEN TRUE ELSE FALSE END ;;
  }

  # No descriptions available for the above dimensions

  # MEASURES #

  measure: count {
    type: count
    drill_fields: [table_name]
  }
}