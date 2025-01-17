include: "../import_files.view.lkml"
include: "../agencies.view.lkml"
include: "../import_sources.view.lkml"
include: "../import_client_map.view.lkml"
include: "../import_enrollment_map.view.lkml"
include: "../import_service_map_derived.view.lkml"
include: "../clients.view.lkml"
include: "../import_logs.view.lkml"
include: "../import_file_analysis_results.view.lkml"
include: "../import_program_mapping.view.lkml"

explore: imports {
  from:  import_files
  label: "Data Import Analysis "

  access_filter:{field: imports.agency_id
    user_attribute: agency_id }

  join: agencies {
    fields: []
    sql_on: ${imports.agency_id} = ${agencies.id} ;;
    type:  inner
    relationship: many_to_one
  }

  join: import_sources {
    sql_on: ${imports.ref_source} = ${import_sources.id} ;;
    type:  inner
    relationship: one_to_many
  }

  join: import_client_map  {
    sql_on: ${imports.id} = ${import_client_map.ref_file} ;;
    relationship: one_to_many
    type:  left_outer
    sql_where: ${imports.is_imported} = 1 ;;
  }

  join: import_enrollment_map {
    relationship: one_to_many
    type:  left_outer
    sql_on: ${imports.id} = ${import_enrollment_map.ref_file} ;;
    sql_where: ${imports.is_imported} = 1 ;;
  }

  join: import_service_map{
    from: import_service_map_derived
    relationship: one_to_many
    type: left_outer
    sql_on: ${imports.id} = ${import_service_map.ref_file} ;;
    sql_where: ${imports.is_imported} = 1 ;;
  }

  join: hud_client {
    from:  clients
    relationship: many_to_one
    sql_on: ${import_client_map.ref_client} = ${hud_client.id} ;;
  }

  join: import_logs {
    type:  inner
    relationship:  one_to_many
    sql_on: ${imports.id} = ${import_logs.file_id};;
  }

  join: import_file_analysis_results {
    relationship: one_to_one
    sql_on: ${imports.id} = ${import_file_analysis_results.ref_file}  ;;
  }

  join: import_program_mapping {
    relationship: one_to_one
    sql_on: ${imports.id} = ${import_program_mapping.import_id}  ;;
  }
}
