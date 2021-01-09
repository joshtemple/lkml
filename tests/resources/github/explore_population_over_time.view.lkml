include: "../dates.view.lkml"
include: "../population.view.lkml"
include: "../agencies.view.lkml"
include: "../counties.view.lkml"
include: "../client_programs.view.lkml"
include: "../clients.view.lkml"
include: "../client_demographics.view.lkml"
include: "../client_move_in_date.view.lkml"
include: "../screen_entry.view.lkml"
include: "../screen_update.view.lkml"
include: "../screen_last.view.lkml"
include: "../screen_followup.view.lkml"
include: "../inbound_recidivism.view.lkml"
include: "../outbound_recidivism.view.lkml"
include: "../chronic_homeless.view.lkml"
include: "../client_program_screening_base.view.lkml"
include: "../client_last_program.view.lkml"
include: "../client_last_system_program_enrollment.view.lkml"
include: "../client_first_program.view.lkml"
include: "../client_first_system_enrollment.view.lkml"
include: "../programs.view.lkml"
include: "../program_templates.view.lkml"
include: "../referrals.view.lkml"
include: "../bed_utilization.view.lkml"
include: "../geography_types.view.lkml"
include: "../program_coc.view.lkml"
include: "../program_sites.view.lkml"
include: "../sites.view.lkml"
include: "../geolocation/sites_geolocations.view.lkml"
include: "../geolocation/agencies_geolocations.view.lkml"
include: "../program_custom.view.lkml"

explore: population {

  label: "HMIS Population over Time"

  access_filter:{field: agencies.id
    user_attribute: agency_id }
  access_filter:{field: agencies.coc
    user_attribute: agency_coc }
  access_filter:{field: agencies.county
    user_attribute: agency_county}
  always_join: [clients]

  conditionally_filter: {
    filters: {
      field: population.observation_range
      value: "Last 6 months"
    }
  }

  sql_always_where: clients.deleted is NULL or clients.deleted =0 ;;

  fields: [ALL_FIELDS*,
          -enrollments.deleted,
          -last_screen.exit_type,
          -last_screen.acceptable_exit

  ]

  join: entry_screen {
    fields: [entry_screen_set*]
    relationship: many_to_one
    sql_on: ${population.first_entry_screen_id} = ${entry_screen.id} ;;
    type: left_outer
  }

  join: inbound_recidivism {
    fields: []
    relationship: many_to_one
    sql_on: ${entry_screen.id} = ${inbound_recidivism.screen_id} ;;
  }

  join: last_screen {
    view_label: "Last Screen"
    fields: [last_screen_set*]
    relationship: many_to_one
    sql_on: ${population.last_screening_to_analyze} = ${last_screen.id} ;;
    type: left_outer
  }

  join: outbound_recidivism {
    fields: []
    relationship: many_to_one
    sql_on: ${entry_screen.id} = ${outbound_recidivism.screen_id} ;;
  }

  join: chronic_homeless {
    fields: []
    relationship: many_to_one
    sql_on: ${chronic_homeless.ref_client} = ${clients.id} and  ${enrollments.id} = ${chronic_homeless.enrollment_id} and ${chronic_homeless.screen_type} = 2;;
  }

  join: chronic_homeless_beta {
    relationship: many_to_one
    sql_on: ${chronic_homeless_beta.enrollment_id} = ${enrollments.id} ;;
  }

  join: enrollments {
    fields: [
      id,
      date_filter,
      end_date,
      start_date,
      head_of_household,
      ref_household,
      days_since_start,
      days_since_start_tier,
      average_duration,
      still_in_program,
      is_first_enrollment,
      is_latest_enrollment,
      is_first_system_enrollment,
      is_latest_system_enrollment,
      count
    ]
    relationship: many_to_one
    sql_on: ${population.enrollment_id} = ${enrollments.id} ;;
  }

  join: client_last_program {
    fields: []
    relationship: many_to_one
    sql_on: ${client_last_program.id} = ${enrollments.id} ;;
  }

  join: client_last_system_program_enrollment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_last_system_program_enrollment.id} = ${enrollments.id} ;;
  }

  join: client_first_program {
    fields: []
    relationship: many_to_one
    sql_on: ${client_first_program.id} = ${enrollments.id} ;;
  }

  join: client_first_system_enrollment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_first_system_enrollment.id} = ${enrollments.id} ;;
  }

  join: programs {
    fields: [
      ref_agency,
      status,
      name,
      project_type_code,
      agency_project_name,
      id,
      list_of_program_names,
      added_date,
      description,
      tracking_method,
      count,
      coc_information*
    ]
    relationship: many_to_one
    sql_on: ${enrollments.ref_program} = ${programs.id} ;;
  }

  join: program_custom {
    relationship: one_to_many
    sql_on: ${programs.id} = ${program_custom.ref_program} ;;
  }

  join: program_sites {
    fields: []
    relationship: many_to_one
    sql_on: ${programs.id} = ${program_sites.ref_program} ;;
  }

  join: program_coc {
    relationship: one_to_many
    fields: []
    sql_on: ${programs.id} = ${program_coc.ref_program} and (${program_coc.deleted} is null or ${program_coc.deleted} = 0) ;;
  }

  join: sites {
    fields: []
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${sites.id} = ${program_sites.ref_site}
            {% else %}
                ${sites.id} = ${program_sites.ref_site} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: geography_types {
    fields: [geography_types.geography_type]
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.ref_geography_type} = ${geography_types.id};;
  }

  join: program_templates {
    fields: []
    relationship: many_to_one
    sql_on: ${programs.ref_template} = ${program_templates.id} ;;
  }

  join: agencies {
    fields: [id, coc, name, county]
    relationship: many_to_one
    sql_on: ${programs.ref_agency} = ${agencies.id} ;;
  }

  join: counties {
    fields: []
    relationship: many_to_one
    sql_on: ${counties.id} = ${agencies.ref_county} ;;
  }

  join: clients {
    relationship: many_to_one
    sql_on: ${population.personal_id} = ${clients.id} ;;
  }

  join: client_move_in_date {
    fields: [latest_move_in_client]
    relationship: many_to_one
    type: left_outer
    sql_on: ${enrollments.id} = ${client_move_in_date.enrollment_id} ;;
  }

  join: static_demographics {
    view_label: "Clients"
    from: client_demographics
    fields: [
      id,
      gender,
      gender_text,
      ethnicity,
      ethnicity_text,
      ref_client,
      race,
      race_text,
      marital_status,
      veteran,
      veteran_text,
      veteran_theater_iraq1,
      veteran_theater_iraq2,
      primary_language
    ]
    relationship: many_to_one
    sql_on: ${clients.id} = ${static_demographics.ref_client} ;;
  }

  # join: referrals {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_where:
  #         {% if _user_attributes['agency_id'] != '>0' %}
  #               (CASE WHEN ${referrals.private} = 1 THEN ${referrals.ref_agency} in ({{_user_attributes['agency_id']}})
  #               AND ( ${referrals.deleted} is NULL OR ${referrals.deleted} =0 )
  #               ELSE (${referrals.private} = 0 or ${referrals.private} is NULL) AND ( ${referrals.deleted} is NULL OR ${referrals.deleted} =0 )END)
  #         {% else %}
  #               ( ${referrals.deleted} is NULL OR ${referrals.deleted} =0 )
  #         {% endif %};;
  #   sql_on: ${population.referral_id} = ${referrals.id};;
  # }

  # join: referring_agencies {
  #   from: agencies
  #   fields: []
  #   relationship: many_to_one
  #   sql_on: ${referrals.ref_agency} = ${referring_agencies.id} ;;
  # }

  join: bed_utilization {
    relationship: many_to_one
    view_label: "Bed Utilization"
    sql_on:  ${population.program_inventory_id} = ${bed_utilization.id}
      AND  ( ${bed_utilization.deleted} IS NULL OR ${bed_utilization.deleted}  = 0 ) ;;
  }

  join: agencies_geolocations {
    fields: [agencies_geolocations*]
    relationship: one_to_one
    sql_on: ${agencies.ref_geolocation} = ${agencies_geolocations.id}
        AND ${agencies_geolocations.deleted} IS NULL
    ;;
  }

  join: sites_geolocations {
    fields: [sites_geolocations*]
    relationship: one_to_one
    sql_on:     ${sites.ref_geolocation} = ${sites_geolocations.id}
            AND ${sites_geolocations.deleted} IS NULL
    ;;
  }
}
