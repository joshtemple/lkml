include: "../client_program_screening_base.view.lkml"
include: "../screen_entry.view.lkml"
include: "../screen_update.view.lkml"
include: "../screen_last.view.lkml"
include: "../screen_followup.view.lkml"
include: "../client_assessment_demographics.view.lkml"
include: "../clients_log.view.lkml"
include: "../household_screens.view.lkml"
include: "../household_entry_screen.view.lkml"
include: "../household.view.lkml"
include: "../client_service_expenses.view.lkml"
include: "../client_service_dates.view.lkml"
include: "../client_service_time_tracking.view.lkml"
include: "../client_custom.view.lkml"
include: "../client_demographics.view.lkml"
include: "../client_move_in_date.view.lkml"
include: "../client_move_in_date.view.lkml"
include: "../entry_custom.view.lkml"
include: "../client_files.view.lkml"
include: "../files.view.lkml"
include: "../client_file_names.view.lkml"
include: "../client_file_categories.view.lkml"
include: "../household_exit_screen.view.lkml"
include: "../last_custom.view.lkml"
include: "../followup_custom.view.lkml"
include: "../status_update_custom.view.lkml"
include: "../inbound_recidivism.view.lkml"
include: "../outbound_recidivism.view.lkml"
include: "../client_program_staff.view.lkml"
include: "../client_programs.view.lkml"
include: "../assessing_program.view.lkml"
include: "../client_last_enrollment_by_type.view.lkml"
include: "../client_first_enrollment_by_type.view.lkml"
include: "../client_last_program.view.lkml"
include: "../client_last_system_program_enrollment.view.lkml"
include: "../client_first_program.view.lkml"
include: "../client_first_system_enrollment.view.lkml"
include: "../members.view.lkml"
include: "../programs.view.lkml"
include: "../program_coc.view.lkml"
include: "../program_sites.view.lkml"
include: "../sites.view.lkml"
include: "../program_funding_sources.view.lkml"
include: "../program_templates.view.lkml"
include: "../program_inventory.view.lkml"
include: "../agencies.view.lkml"
include: "../counties.view.lkml"
include: "../client_profile_household.view.lkml"
include: "../household_move_in_date.view.lkml"
include: "../clients.view.lkml"
include: "../client_group_members.view.lkml"
include: "../client_groups.view.lkml"
include: "../client_addresses_recent.view.lkml"
include: "../client_addresses.view.lkml"
include: "../client_field_interactions.view.lkml"
include: "../client_notes.view.lkml"
include: "../chronic_homeless.view.lkml"
include: "../client_service_programs.view.lkml"
include: "../client_services.view.lkml"
include: "../service_items.view.lkml"
include: "../client_service_notes.view.lkml"
include: "../client_program_goals.view.lkml"
include: "../goals.view.lkml"
include: "../funding.view.lkml"
include: "../services.view.lkml"
include: "../client_last_system_service.view.lkml"
include: "../client_last_service.view.lkml"
include: "../client_last_service_by_enrollment.view.lkml"
include: "../client_service_accounts.view.lkml"
include: "../vendors.view.lkml"
include: "../client_last_assessment.view.lkml"
include: "../client_last_assessment_of_kind.view.lkml"
include: "../client_assessment_scores.view.lkml"
include: "../assessment_subtotals.view.lkml"
include: "../client_last_assessment_by_processor.view.lkml"
include: "../assessment_processors.view.lkml"
include: "../client_assessment_high_score.view.lkml"
include: "../client_last_assessment_id.view.lkml"
include: "../custom_score_ranges.view.lkml"
include: "../screens.view.lkml"
include: "../client_assessment_custom.view.lkml"
include: "../release_of_information.view.lkml"
include: "../hoh_client_location.view.lkml"
include: "../dq_clients.view.lkml"
include: "../dq_client_programs.view.lkml"
include: "../dq_client_demographics.view.lkml"
include: "../dq_client_program_demographics.view.lkml"
include: "../dq_project_descriptor.view.lkml"
include: "../users.view.lkml"
include: "../flattened_stays.view.lkml"
include: "../dq_data_error_applies_to_program.view.lkml"
include: "../dq_services.view.lkml"
include: "../dq_enrollments_compare.view.lkml"
include: "../user_groups.view.lkml"
include: "../currently_in_shelter.view.lkml"
include: "../indeterminable_households.view.lkml"
include: "../geography_types.view.lkml"
include: "../latest_enrollment_contextual.view.lkml"
include: "../client_program_demographics.view.lkml"
include: "../enrollment_aggregates.view.lkml"
include: "../coordinated_entry_event.view.lkml"
include: "../current_living_situation.view.lkml"
include: "../dq_coordinated_entry.view.lkml"
include: "../screen_update.view.lkml"
include: "../first_enrollment_since_stably_housed.view.lkml"
include: "../geolocation/client_addresses_geolocations.view.lkml"
include: "../geolocation/sites_geolocations.view.lkml"
include: "../geolocation/agencies_geolocations.view.lkml"
include: "../program_custom.view.lkml"

explore: data_quality {

  access_filter:{field: agencies.id
    user_attribute: agency_id }
  access_filter:{field: agencies.coc
    user_attribute: agency_coc }
  access_filter:{field: agencies.county
    user_attribute: agency_county}

  from: dq_clients
  sql_table_name: clients ;;
  view_label: "Clients"
  label: "Data Quality"

  fields: [ALL_FIELDS*, -last_screen.exit_type, -last_screen.acceptable_exit]


  sql_always_where: ${data_quality.deleted} is NULL or ${data_quality.deleted}=0;;

  join: client_first_enrollment_by_type {
    fields: []
    relationship: many_to_one
    sql_on: ${base.ref_client} = ${client_first_enrollment_by_type.ref_client}
      and ${programs.ref_category} = ${client_first_enrollment_by_type.ref_category} ;;
  }

  conditionally_filter: {
    filters: {
      field: dq_client_programs.date_filter
      value: "1 Quarter"
    }
  }

  join: client_last_enrollment_by_type {
    fields: []
    relationship: many_to_one
    sql_on: ${base.ref_client} = ${client_last_enrollment_by_type.ref_client}
      and ${programs.ref_category} = ${client_last_enrollment_by_type.ref_category} ;;
  }

  join: latest_enrollment_contextual {
    fields: []
    relationship: one_to_one
    type: left_outer
    sql_on: ${data_quality.id} = ${latest_enrollment_contextual.ref_client} ;;
  }

  join: client_last_service_by_enrollment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_services.id} = ${client_last_service_by_enrollment.id} ;;
  }

  #Extends: client_demographics.view
  join: dq_client_demographics {
    view_label: "Clients"
    relationship: one_to_many
    sql_on: ${data_quality.id} = ${dq_client_demographics.ref_client};;
  }

  join: dq_client_programs {
    view_label: "Enrollments"
    type: inner
    relationship: one_to_many
    sql_on: ${enrollments.id} = ${dq_client_programs.id} AND ${dq_client_programs.deleted} IS NULL ;;
  }

  join: enrollments {
    fields: [ref_client]
    relationship: one_to_many
    type: left_outer
    sql_on: ${data_quality.id} = ${enrollments.ref_client} AND ${enrollments.deleted} IS NULL;;
  }

  join: first_enrollment_since_stably_housed {
    fields: []
    relationship: many_to_one
    sql_on: ${data_quality.id} = ${first_enrollment_since_stably_housed.personal_id} ;;
  }


  join: coordinated_entry_event {
    relationship: many_to_one
    sql_on: ${coordinated_entry_event.ref_client} = ${data_quality.id}
            AND ${coordinated_entry_event.enrollment_id} = ${enrollments.id}
    ;;
  }


  # Extends: client_program_demographics.view
  join: dq_client_program_demographics {
    view_label: "Enrollments"
    relationship: one_to_many
    type: left_outer
    sql_on: ${dq_client_programs.id} = ${dq_client_program_demographics.enrollment_id}
      AND ${dq_client_program_demographics.deleted} IS NULL ;;
  }

  join: programs {
    fields: []
    type: inner
    relationship: many_to_one
    sql_on: ${dq_client_programs.ref_program} = ${programs.id} AND ${programs.deleted} IS NULL ;;
  }

  join: program_custom {
    fields: []
    relationship: one_to_many
    sql_on: ${programs.id} = ${program_custom.ref_program} ;;
  }

  #Extends programs.view
  join: dq_project_descriptor {
    view_label: "Programs"
    relationship: many_to_one
    type: inner
    sql_on: ${programs.id} = ${dq_project_descriptor.id}
      AND ${dq_project_descriptor.deleted} IS NULL;;
  }

  join: program_inventory {
    relationship: one_to_many
    type: left_outer
    sql_on: ${dq_project_descriptor.id} = ${program_inventory.ref_program} AND ( program_inventory.deleted IS NULL OR  program_inventory.deleted = 0 );;
  }

  join: agencies {
    relationship: many_to_one
    type: left_outer
    fields: [id, name, coc, county, agencies.victim_service_provider_raw]
    sql_on: ${dq_client_programs.ref_agency} = ${agencies.id};;
  }
  join: counties {
    relationship: many_to_one
    fields: []
    sql_on: ${counties.id} = ${agencies.ref_county} ;;
  }
  join: users {
    relationship: many_to_one
    type: left_outer
    fields: []
    sql_on: ${dq_client_programs.ref_user_updated} = ${users.id};;
  }
  join: program_funding_sources {
    relationship: many_to_one
    type: left_outer
    sql_on: ${dq_project_descriptor.id} = ${program_funding_sources.ref_program};;
  }

  join: flat_grant_dates {
    relationship: many_to_one
    type: left_outer
    sql_on:     ${enrollments.ref_program} = ${flat_grant_dates.program_id}
            AND            ${enrollments.start_date}             <= ${flat_grant_dates.grant_end_date}
                AND IFNULL(${enrollments.end_date}, CURDATE())   >= ${flat_grant_dates.grant_start_date}
    ;;
  }

  join: dq_data_error_applies_to_program {
    relationship: one_to_one
    fields: []
    sql_on: ${dq_project_descriptor.id} =  ${dq_data_error_applies_to_program.id};;
  }

  join: dq_residential_stay_compare {
    relationship: many_to_one
    type: left_outer
    sql_on: ${dq_client_programs.id} = ${dq_residential_stay_compare.id} ;;
  }

  join: dq_deceased_compare {
    relationship: many_to_one
    type: left_outer
    sql_on: ${dq_client_programs.id} = ${dq_deceased_compare.id} ;;
  }

  join: household_makeup {
    relationship: many_to_one
    fields: []
    sql_on: ${dq_client_programs.ref_household} = ${household_makeup.id};;
  }

  join: client_service_programs {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${dq_client_programs.id} = ${client_service_programs.ref_client_program} ;;
  }

  join: client_services {
    fields: [base_fields*]
    relationship: many_to_one
    sql_on: ${client_services.id} = ${client_service_programs.ref_client_service} and ( ${client_services.deleted} is null OR ${client_services.deleted} =0 ) ;;
  }


  join: services {
    relationship: many_to_one
    type: left_outer
    sql_on: ${dq_services.ref_service} = ${services.id} ;;
  }

  # Extends service_items
  join: dq_services {
    relationship: many_to_one
    type: left_outer
    sql_on: ${dq_services.id} = ${client_services.ref_service_item};;
  }

  # Added to remove "Inaccessible view" errors.
  join: client_first_program {
    fields: []
    relationship: many_to_one
    sql_on: ${client_first_program.id} = ${dq_client_programs.id} ;;
  }
  join: client_first_system_enrollment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_first_system_enrollment.id} = ${dq_client_programs.id} ;;
  }

  join: client_last_program {
    fields: []
    relationship: many_to_one
    sql_on: ${client_last_program.id} = ${dq_client_programs.id} ;;
  }

  join: client_last_system_program_enrollment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_last_system_program_enrollment.id} = ${dq_client_programs.id} ;;
  }

  join: client_program_staff {
    fields: []
    relationship: many_to_one
    sql_on: ${client_program_staff.ref_client_program} = ${dq_client_programs.id} ;;
  }

  join: entry_screen {
    view_label: "Enrollments"
    fields: [entry_screen.chronic_homeless_calculation, entry_screen.client_location]
    sql_on: ${base.first_entry_screen_id} = ${entry_screen.id} ;;
    relationship: many_to_one
    type: left_outer
  }

  join: last_screen {
    view_label: "Update/Exit Screen"
    fields: []
    relationship: many_to_one
    type: left_outer
    sql_on: ${base.last_screening_to_analyze} = ${last_screen.id} ;;
  }

  join: current_living_situation {
    type: left_outer
    relationship: one_to_one
    sql_on:
    ${current_living_situation.id} = ${status_update_screen.id}
        AND ${current_living_situation.screen_type} = 3
        AND ${current_living_situation.status_screen_type} = 2
        AND (${current_living_situation.deleted} IS NULL OR ${current_living_situation.deleted} = 0)
    ;;
  }

  join: household_entry_screen {
    fields: []
    view_label: "Entry Screen"
    type: inner
    relationship: many_to_one
    sql_on: ${dq_client_programs.ref_household} =  ${household_entry_screen.household_id} ;;
  }

  join: members {
    relationship: many_to_one
    fields: [first_name, last_name, name, access_role, status, email]
    sql_on: ${client_program_staff.ref_user} = ${members.ref_user} ;;
  }

  join: program_coc {
    relationship: many_to_many
    sql_on: ${dq_project_descriptor.id} = ${program_coc.ref_program}
      AND (${program_coc.deleted} IS NULL OR ${program_coc.deleted} = 0) ;;
  }

  join: last_exit_screen {
    from: last_screen
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.last_exit_screen_id} = ${last_exit_screen.id}  ;;
  }

  join: screens_default_profile {
    from: screens
    fields: []
    relationship: many_to_one
    sql_on: ${screens_default_profile.id} = ${agencies.ref_profile_screen} ;;
  }

  join: base {
    from: client_program_screening_base
    relationship: many_to_one
    type: inner
    fields: []
    sql_on: ${base.ref_program} = ${dq_client_programs.id} ;;
  }

  join: user_groups {
    fields: []
    relationship: many_to_one
    sql_on: ${users.ref_user_group} = ${user_groups.id} ;;
  }

  join: client_service_notes {
    fields: []
    relationship: many_to_one
    sql_on: ${client_service_notes.ref_client_service} = ${client_services.id} ;;
  }
  join: service_dates {
    view_label: "Services"
    type: left_outer
    relationship: one_to_one
    sql_on: ${service_dates.ref_client_service} = ${client_services.id} AND ${client_services.deleted} IS NULL ;;
  }
  join: service_items {
    fields: []
    view_label: "Services"
    type: left_outer
    relationship: one_to_one
    sql_on: ${service_items.id} = ${dq_services.id}
            AND ${dq_services.deleted} IS NULL
            AND ${service_items.deleted} IS NULL;;
  }

  join: currently_in_shelter {
    fields: []
    relationship: many_to_one
    sql_on: ${data_quality.id} = ${currently_in_shelter.ref_client} ;;
  }

  join: client_move_in_date {
    fields: [latest_move_in_client]
    type: left_outer
    relationship: many_to_one
    sql_on: ${data_quality.id} = ${client_move_in_date.ref_client} ;;
  }

  join: dq_annual_assessments {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dq_client_programs.id} = ${dq_annual_assessments.enrollment_id};;
  }

  join: indeterminable_households {
    fields: []
    type: left_outer
    relationship: one_to_one
    sql_on:     ${indeterminable_households.personal_id} = ${data_quality.id}
      AND ${indeterminable_households.enrollment_id} = ${dq_client_programs.id};;
  }

  join: chronic_homeless {
    fields: []
    relationship: many_to_one
    sql_on: ${chronic_homeless.ref_client} = ${data_quality.id}
           AND  ${dq_client_programs.id} = ${chronic_homeless.enrollment_id}
           AND ${chronic_homeless.screen_type} = 2;;
  }

  join: chronic_homeless_beta {
    relationship: many_to_one
    sql_on: ${chronic_homeless_beta.enrollment_id} = ${enrollments.id} ;;
  }

  join: client_assessments {
    fields: []
    relationship: many_to_one
    sql_on: {% if _user_attributes['agency_id'] != '>0' %}
              (${client_assessments.ref_agency} IN ({{_user_attributes['agency_id']}}) OR ${client_assessments.ref_agency} IS NULL)
              AND ${client_assessments.deleted} IS NULL
              AND ${data_quality.id} = ${client_assessments.ref_client}
            {% else %}
                  ${data_quality.id} = ${client_assessments.ref_client}
                    AND  ${client_assessments.deleted} IS NULL
            {% endif %} ;;
  }

  join: client_last_assessment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment.id} ;;
  }

  join: client_assessment_custom {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_assessment_custom.ref_client_assessment_demographics} ;;
  }

  join: client_assessment_scores {
    fields: [assessment_score_average]
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_assessment_scores.ref_assessment} ;;
  }

  join: client_assessment_high_score {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessment_high_score.ref_assessment} = ${client_assessments.id} ;;
  }

  join: client_last_assessment_by_processor {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment_by_processor.id} ;;
  }

  join: client_last_assessment_id {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment_id.id} ;;
  }

  join: client_last_assessment_of_kind {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment_of_kind.id} ;;
  }

  join: client_last_service {
    fields: []
    relationship: many_to_one
    sql_on: ${client_services.id} = ${client_last_service.id};;
  }

  join: client_last_system_service {
    fields: []
    relationship: one_to_one
    sql_on: ${client_services.id} = ${client_last_system_service.id} ;;
  }

  join: custom_score_ranges {
    fields: []
    relationship: many_to_one
    sql_on: ${custom_score_ranges.id} = ${client_assessments.id} ;;
  }
  join: screens {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${screens.id} = ${client_assessments.ref_assessment} ;;
  }

  join: program_sites {
    fields: [is_primary]
    relationship: many_to_one
    sql_on: ${programs.id} = ${program_sites.ref_program} ;;
  }

  join: sites {
    fields: [coc]
    relationship: many_to_one
    sql_on: ${sites.id} = ${program_sites.ref_site} AND ${sites.deleted} IS NULL;;
  }

  join: geography_types {
    fields: [geography_types.geography_type]
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.ref_geography_type} = ${geography_types.id};;
  }

  join: client_latest_enrollment_per_agency {
    relationship: one_to_one
    type: left_outer
    sql_on: ${enrollments.id} = ${client_latest_enrollment_per_agency.enrollment_id} ;;
  }

  join: client_first_enrollment_per_agency {
    relationship: one_to_one
    type: left_outer
    sql_on: ${enrollments.id} = ${client_first_enrollment_per_agency.enrollment_id} ;;
  }

  join: dq_coordinated_entry {
    fields: [living_situation_verified_by_error,
              living_situation_verified_by_error_count,
              total_ce_error_count]
    relationship: many_to_one
    type: left_outer
    sql_on: ${dq_coordinated_entry.ref_program} = ${enrollments.id}
            AND ${dq_coordinated_entry.deleted} IS NULL;;
  }

  join: status_update_screen {
    fields: []
    view_label: "Status Update Screen"
    type: left_outer
    relationship: many_to_one
    sql_on: ${status_update_screen.ref_program} = ${enrollments.id} and ${status_update_screen.screen_type} in (3,6)
      and (${status_update_screen.deleted} is null or ${status_update_screen.deleted} = 0);;
  }

# Agencies is joined below a second time to link dq_clarity_fields to clients
  join: field_agencies {
    required_access_grants: [looker_sys_admin]
    from: agencies
    fields: []
    relationship: many_to_one
    type: left_outer
    sql_on: ${data_quality.ref_agency} = ${agencies.id};;
  }

  join: sites_geolocations {
    fields: [sites_geolocations*]
    relationship: one_to_one
    sql_on: ${sites.ref_geolocation} = ${sites_geolocations.id}
        AND ${sites_geolocations.deleted} IS NULL
    ;;
  }

}
