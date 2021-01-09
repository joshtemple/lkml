view: pg_table_def {
  derived_table: {
    sql: select * from pg_table_def
          where
          {% condition information_schema__columns.table_name %}tablename{% endcondition %}
          and
          {% condition information_schema__columns.column_name %}"column"{% endcondition %}
          ;;
  }
#   sql_table_name: pg_catalog.pg_table_def ;;


  dimension: primary_key_table_column {
    sql: ${tablename}||${column} ;;
  }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }

  dimension: schemaname {
    type: string
    sql: {{ _view._name | replace: '_hidden_fields','' }}.schemaname ;;
  }

  dimension: tablename {
    type: string
    sql: {{ _view._name | replace: '_hidden_fields','' }}.tablename ;;
  }

  dimension: column {
    type: string
    sql: {{ _view._name | replace: '_hidden_fields','' }}."column" ;;
  }

  dimension: type {
    type: string
    sql: {{ _view._name | replace: '_hidden_fields','' }}.type ;;
  }

  dimension: encoding {
    type: string
    sql: {{ _view._name | replace: '_hidden_fields','' }}.encoding ;;
  }

  dimension: distkey {
    type: string
    sql: {{ _view._name | replace: '_hidden_fields','' }}.distkey ;;
  }

  dimension: sortkey {
    type: number
    sql: {{ _view._name | replace: '_hidden_fields','' }}.sortkey ;;
  }

  dimension: notnull {
    type: string
    sql: {{ _view._name | replace: '_hidden_fields','' }}."notnull" ;;
  }

  set: hidden_fields {
    fields: [
      schemaname,
      tablename,
      column,
      primary_key_table_column
#       type,
#       encoding,
#       distkey,
#       sortkey,
#       notnull
    ]
  }
}
view: pg_table_def_hidden_fields {extends:[pg_table_def] sql_table_name:;;}
