# explore: pdt_mapping {}

# view: pdt_mapping {
#   derived_table: {
#     persist_for: "1 hour"
#     sql:
#       SELECT 'table' name, '${table.SQL_TABLE_NAME}' internal_name
#     ;;
# #     -- UNION SELECT 'series_dates', '${series_dates.SQL_TABLE_NAME}'
# #       -- UNION SELECT 'funnel', '${funnel.SQL_TABLE_NAME}'
# #       -- add additional pdts here...
#   }
#
#   dimension: name {}
#   dimension: internal_name {}
#
#   dimension: view_sql_mysql {
#     sql: CONCAT('CREATE OR REPLACE VIEW pdt.', ${name} , ' AS ',
#           'SELECT * FROM ' , ${internal_name} , ' WITH NO SCHEMA BINDING')
#           ;;
#   }
#
#   dimension: view_sql_redshift {
#     sql: 'CREATE OR REPLACE VIEW pdt.' || ${name} || ' AS '
#           'SELECT * FROM ' || ${internal_name} || ' WITH NO SCHEMA BINDING'
#           ;;
#   }
# }




# doesn't work

datagroup: dg {
  sql_trigger: select current_timetamp ;;
}

# view: derived_table {
#   derived_table: {
#     datagroup_trigger: dg
#     sql: SELECT id,  web_name
#       FROM fpl.players ;;
#   }
#   dimension: id {}
#   dimension: web_name {}
# }
#
# view: constant_view {
#   derived_table: {
#     datagroup_trigger: dg
#     create_process: {
#       sql_step:
#       -- create dummy table so the rename won't fail, SQL is strictly a placeholder to trick Looker into thinking there is a PDT.
#         create table ${SQL_TABLE_NAME} as select 1 dummy ;;
#       sql_step:
#         DROP VIEW IF EXISTS fpl.not_obscure_table_name ;;
#       sql_step:
#         CREATE VIEW fpl.not_obscure_table_name as
#         SELECT web_name FROM ${derived_table.SQL_TABLE_NAME} WITH NO SCHEMA BINDING  ;;
#     }
#   }
#
#   dimension: web_name {}
# }
#
# explore: constant_view {}
