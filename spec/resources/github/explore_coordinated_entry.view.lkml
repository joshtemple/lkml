include: "../clients.view.lkml"
include: "../client_custom.view.lkml"
include: "../client_addresses_recent.view.lkml"
include: "../client_addresses.view.lkml"
include: "../files.view.lkml"
include: "../chronic_homeless.view.lkml"
include: "../client_groups.view.lkml"
include: "../referral_connections.view.lkml"
include: "../client_group_members.view.lkml"
include: "../currently_in_shelter.view.lkml"
include: "../client_last_assessment_by_processor.view.lkml"
include: "../client_last_shelter_attendance.view.lkml"
include: "../client_move_in_date.view.lkml"
include: "../client_move_in_date.view.lkml"
include: "../client_last_service_by_enrollment.view.lkml"
include: "../client_demographics.view.lkml"
include: "../assessing_program.view.lkml"
include: "../client_files.view.lkml"
include: "../client_file_names.view.lkml"
include: "../client_file_categories.view.lkml"
include: "../agencies.view.lkml"
include: "../client_release_of_information.view.lkml"
include: "../counties.view.lkml"
include: "../client_assessment_demographics.view.lkml"
include: "../custom_score_ranges.view.lkml"
include: "../client_last_assessment.view.lkml"
include: "../client_last_assessment_of_kind.view.lkml"
include: "../client_assessment_scores.view.lkml"
include: "../assessment_processors.view.lkml"
include: "../assessment_subtotals.view.lkml"
include: "../client_assessment_high_score.view.lkml"
include: "../client_last_assessment_id.view.lkml"
include: "../eligibility_processor_results.view.lkml"
include: "../screens.view.lkml"
include: "../client_assessment_custom.view.lkml"
include: "../referrals.view.lkml"
include: "../client_referral_status.view.lkml"
include: "../client_alerts.view.lkml"
include: "../referral_history.view.lkml"
include: "../program_openings_history.view.lkml"
include: "../program_openings.view.lkml"
include: "../program_openings_custom.view.lkml"
include: "../client_program_staff.view.lkml"
include: "../client_programs.view.lkml"
include: "../client_last_enrollment_by_type.view.lkml"
include: "../members.view.lkml"
include: "../users.view.lkml"
include: "../user_groups.view.lkml"
include: "../household.view.lkml"
include: "../client_last_program.view.lkml"
include: "../client_last_system_program_enrollment.view.lkml"
include: "../client_first_program.view.lkml"
include: "../client_first_system_enrollment.view.lkml"
include: "../client_program_screening_base.view.lkml"
include: "../screen_entry.view.lkml"
include: "../household_entry_screen.view.lkml"
include: "../screen_last.view.lkml"
include: "../programs.view.lkml"
include: "../program_sites.view.lkml"
include: "../sites.view.lkml"
include: "../client_service_programs.view.lkml"
include: "../client_services.view.lkml"
include: "../client_last_service.view.lkml"
include: "../client_last_system_service.view.lkml"
include: "../service_items.view.lkml"
include: "../client_service_notes.view.lkml"
include: "../services.view.lkml"
include: "../client_service_dates.view.lkml"
include: "../entry_custom.view.lkml"
include: "../last_custom.view.lkml"
include: "../client_contacts.view.lkml"
include: "../referral_opening_history.view.lkml"
include: "../client_profile_household.view.lkml"
include: "../latest_assessment_contextual.view.lkml"
include: "../latest_enrollment_contextual.view.lkml"
include: "../client_programs.view.lkml"
include: "../household_move_in_date.view.lkml"
include: "../days_elapsed_last_assessment.view.lkml"
include: "../client_program_demographics.view.lkml"
include: "../client_programs_files.view.lkml"
include: "../coordinated_entry_event.view.lkml"
include: "../geography_types.view.lkml"
include: "../program_coc.view.lkml"
include: "../current_living_situation.view.lkml"
include: "../aggregations/last_assessment_filters.view.lkml"
include: "../screen_update.view.lkml"
include: "../referral_notes.view.lkml"
include: "../geolocation/client_field_interactions_geolocations.view.lkml"
include: "../geolocation/client_addresses_geolocations.view.lkml"
include: "../geolocation/sites_geolocations.view.lkml"
include: "../geolocation/client_geolocations.view.lkml"
include: "../geolocation/client_services_geolocations.view.lkml"
include: "../geolocation/service_items_geolocations.view.lkml"
include: "../geolocation/agencies_geolocations.view.lkml"
include: "../geolocation/client_assessment_demographics_geolocations.view.lkml"
include: "../geolocation/client_program_demographics_geolocations.view.lkml"
include: "../referral_community_queues.view.lkml"
include: "../referral_community_queue_assessments.view.lkml"
include: "../community_queue/referrals_referral_community_queues.view.lkml"
include: "../community_queue/referral_history_referral_community_queues.view.lkml"
include: "../community_queue/on_queue/client_referral_status_ever_on_specific_queue.view.lkml"
include: "../aggregations/first_assessment_filters.view.lkml"
include: "../aggregations/last_assessment_filters.view.lkml"
include: "../aggregations/first_current_living_situation_filters.view.lkml"
include: "../aggregations/last_current_living_situation_filters.view.lkml"
include: "../community_queue/client_referral_status_referral_community_queues.view.lkml"
include: "../aggregations/client_contacts_rank.view.lkml"
include: "../program_custom.view.lkml"
include: "../aggregations/last_referral_filters.view.lkml"



explore: client {
  from: clients
  view_label: "Clients"
  persist_for: "60 minutes"
  label: "Coordinated Entry"
  access_filter:{field: agencies.id
    user_attribute: agency_id }
  access_filter:{field: agencies.coc
    user_attribute: agency_coc }
  access_filter:{field: agencies.county
    user_attribute: agency_county}

  sql_always_where:
        {% if _user_attributes['agency_id'] != '>0' %}
              (CASE WHEN ${client.private} = 1 THEN ${client.ref_agency} in ({{_user_attributes['agency_id']}})
              AND ( ${client.deleted} is NULL OR ${client.deleted} =0 )
              ELSE (${client.private} = 0 or ${client.private} is NULL) AND ( ${client.deleted} is NULL OR ${client.deleted} =0 )END)
        {% else %}
              ( ${client.deleted} is NULL OR ${client.deleted} =0 )
        {% endif %}
  ;;

  fields: [ALL_FIELDS*,
          -client_addresses.deleted,
          -client_addresses_recent.deleted,
          -enrollments.deleted,
          -client_alerts.deleted,
          -client_services.deleted,
          -client_assessments.deleted,
          -client.deleted,
          -referrals.deleted,
          -client_release_of_information.deleted,
          -members.deleted,
          -client_files.deleted,
          -client_contacts.deleted,
          -client_group_members.end_date,
          -last_screen.exit_type,
          -last_screen.acceptable_exit

  ]

  join: client_addresses_recent {
    fields: []
    type: left_outer
    relationship: many_to_one
      sql_on:
          {% if _user_attributes['agency_id'] != '>0' %}
                ${client.id} = ${client_addresses_recent.ref_client} AND
                (CASE WHEN ${client_addresses_recent.private} = 1
                      THEN ${client_addresses_recent.ref_agency} in ({{_user_attributes['agency_id']}})
                        AND ( ${client_addresses_recent.deleted} is NULL OR ${client_addresses_recent.deleted} =0 )
                      ELSE (${client_addresses_recent.private} = 0 or ${client_addresses_recent.private} is NULL)
                        AND ( ${client_addresses_recent.deleted} is NULL OR ${client_addresses_recent.deleted} =0 )
                      END)
          {% else %}
                ${client.id} = ${client_addresses_recent.ref_client} AND
                (${client_addresses_recent.deleted} is NULL or ${client_addresses_recent.deleted} =0)
          {% endif %}
    ;;

  }

  join: client_addresses {
    relationship: many_to_one
      sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${base.ref_client} = ${client_addresses.ref_client}  AND ${client_addresses.deleted} IS null
            {% else %}
                ${base.ref_client} = ${client_addresses.ref_client}  AND ${client_addresses.deleted} IS NULL AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
            {% if _user_attributes['agency_id'] != '>0' %}
                  AND  (CASE WHEN ${client_addresses.private} = 1 THEN ${client_addresses.ref_agency} in ({{_user_attributes['agency_id']}})
                  AND ( ${client_addresses.deleted} is NULL OR ${client_addresses.deleted} =0 )
                  ELSE (${client_addresses.private} = 0 or ${client_addresses.private} is NULL) AND ( ${client_addresses.deleted} is null OR ${client_addresses.deleted} =0 )END)
            {% else %}
                  AND ( ${client_addresses.deleted} is NULL OR ${client_addresses.deleted} =0 )
            {% endif %}
    ;;
  }

  join: files {
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${client_files.ref_file} = ${files.id}
            {% else %}
                ${client_files.ref_file} = ${files.id} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: chronic_homeless {
    fields: []
    relationship: many_to_one
    sql_on: ${chronic_homeless.ref_client} = ${client.id} and  ${enrollments.id} = ${chronic_homeless.enrollment_id} and ${chronic_homeless.screen_type} = 2;;
  }

  join: chronic_homeless_beta {
    relationship: many_to_one
    sql_on: ${chronic_homeless_beta.enrollment_id} = ${enrollments.id} ;;
  }

  join: client_groups {
    fields: []
    relationship: many_to_one
    sql_on: ${client_group_members.ref_client} = ${client_groups.ref_client} ;;
  }

  join: referral_connections {
    fields: []
    relationship: many_to_one
    sql_on: ${referral_connections.ref_referral} = ${referrals.id} ;;
  }

  join: referral_connections_enrollment {
    fields: [-is_first_enrollment_by_type]
    from: enrollments
    relationship: many_to_one
    sql_on: ${referral_connections.ref_client_program} = ${referral_connections_enrollment.id}
              and ${referral_connections.ref_referral} = ${referrals.id}
              and (${referral_connections_enrollment.deleted} IS NULL OR ${referral_connections_enrollment.deleted} = 0);;
  }

  join: household_move_in_date_enrolling {
    from: household_move_in_date
    view_label: "Referrals"
    relationship: many_to_one
    sql_on: ${referral_connections_enrollment.id} = ${household_move_in_date_enrolling.enrollment_id}
            and (${referral_connections_enrollment.deleted} IS NULL OR ${referral_connections_enrollment.deleted} = 0);;
  }

  join: client_group_members {
    view_label: "Clients"
    relationship: many_to_one
    sql_on: ${client.id} = ${client_group_members.ref_client} and ${client_group_members.end_date} is NULL ;;
  }

  join: currently_in_shelter {
    fields: []
    relationship: many_to_one
    sql_on: ${client.id} = ${currently_in_shelter.ref_client} ;;
  }

  join: client_last_assessment_by_processor {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment_by_processor.id} ;;
  }

  join: client_last_shelter_attendance {
    fields: [end_date,future_service_date]
    relationship: many_to_one
    sql_on: ${client_last_shelter_attendance.ref_client} =  ${client.id}
      ;;
  }

  join: client_move_in_date {
    view_label: "Clients"
    fields: [latest_move_in_client]
    type: left_outer
    relationship: many_to_one
    sql_on: ${enrollments.id} = ${client_move_in_date.enrollment_id};;

  }



  join: client_move_in_date_client {
    from: client_move_in_date
    fields: [latest_move_in_client]
    view_label: "Enrollments"
    type: left_outer
    relationship: many_to_one
    sql_on: ${client.id} = ${client_move_in_date.ref_client} ;;
  }

  join: client_last_service_by_enrollment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_services.id} = ${client_last_service_by_enrollment.id} ;;
  }


  join: client_profile_household {
    view_label: "Clients"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${client.id} = ${client_profile_household.personal_id} ;;
  }

  join: static_demographics {
    from: client_demographics
    view_label: "Clients"
    relationship: many_to_one
    fields: [
      id,
      gender,
      gender_text,
      ethnicity,
      ethnicity_text,
      ref_client,
      race,
      race_text,
      race_1_text,
      race_2_text,
      race_3_text,
      race_4_text,
      race_5_text,
      name_middle,
      veteran,
      veteran_text,
      veteran_discharge,
      veteran_branch,
      currently_in_shelter,
      veteran_theater_afg,
      veteran_theater_iraq1,
      veteran_theater_iraq2,
      veteran_theater_kw,
      veteran_theater_other,
      veteran_theater_pg,
      veteran_theater_vw,
      veteran_theater_ww2,
      veteran_entered,
      veteran_separated,
      primary_language

    ]
    sql_on: ${client.id} = ${static_demographics.ref_client} ;;
  }

  join: assessing_program {
    relationship: many_to_one
    sql_on: ${assessing_program.ref_client_assessment} = ${client_assessments.id} ;;
  }

  join: client_files {
    view_label: "Clients"
    type: left_outer
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' and _user_attributes['agency_id'] == '>0' %}
              ${client_files.ref_client} = ${client.id} AND (${client_files.deleted} = 0 OR ${client_files.deleted} IS NULL)
            {% elsif  _user_attributes['allow_sensitive_data'] == 'yes' and _user_attributes['agency_id'] != '>0' %}
              ${client_files.ref_client} = ${client.id} AND (${client_files.deleted} = 0 OR ${client_files.deleted} IS NULL)
                AND ${agencies.id} in ({{ _user_attributes['agency_root_id'] }})
                AND (CASE
                      WHEN ${client_files.private} = 1 THEN ${client_files.ref_agency} in ({{_user_attributes['agency_id']}})
                        AND ( ${client_files.deleted} is NULL OR ${client_files.deleted} =0 )
                      ELSE (${client_files.private} = 0 or ${client_files.private} is NULL)
                        AND ( ${client_files.deleted} is NULL OR ${client_files.deleted} =0 )
                      END)
            {% elsif _user_attributes['allow_sensitive_data'] != 'yes' %}
              ${client.id} = ${client_files.ref_client}
              AND ${client_files.ref_agency} in ({{ _user_attributes['agency_root_id'] }})
              AND ( ${client_files.deleted} is NULL OR ${client_files.deleted} =0 )

            {% endif %}
    ;;

  }

  join: client_programs_files {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${client_files.id} = ${client_programs_files.ref_client_file}
      and ${enrollments.id} = ${client_programs_files.ref_client_program} ;;
  }

  join: client_file_names {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${client_files.ref_file_name} = ${client_file_names.id} ;;
  }

  join: client_file_categories {
    view_label: "Clients"
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${client_files.ref_category} = ${client_file_categories.id} ;;
  }

  join: static_demographics_custom {
    from: client_custom
    view_label: "Static Demographics Custom"
    relationship: many_to_one
    fields: [static_demographics_custom.client_custom_fields*]
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
              ${static_demographics.id} = ${static_demographics_custom.ref_client_demographics}
            {% else %}
              ${static_demographics.id} = ${static_demographics_custom.ref_client_demographics} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: agencies {
    from: agencies
    view_label: "Assessing Agency"
    fields: [id, coc, name, county]
    relationship: many_to_one
    sql_on: ${client_assessments.ref_agency} = ${agencies.id} ;;
  }

  join: client_release_of_information {
    #fields: [-deleted]
    view_label: "Release of Information"
    relationship: many_to_one
    sql_on: ${client_release_of_information.ref_client} = ${client.id}
      AND (${client_release_of_information.deleted} IS NULL or ${client_release_of_information.deleted} =0);;
  }

  join: roi_agencies {
    from: agencies
    fields: []
    relationship: many_to_one
    sql_on: ${client_release_of_information.ref_agency} =${roi_agencies.id} ;;
  }

  join: counties {
    fields: []
    relationship: many_to_one
    sql_on: ${counties.id} = ${agencies.ref_county} ;;
  }

  join: client_assessments {
    relationship: many_to_one
    sql_on:
          {% if _user_attributes['agency_id'] != '>0' %}
                ${client.id} = ${client_assessments.ref_client} AND
                (CASE WHEN ${client_assessments.private} = 1 THEN ${client_assessments.ref_agency} in ({{_user_attributes['agency_id']}})
                AND ( ${client_assessments.deleted} is NULL OR ${client_assessments.deleted} =0 )
                ELSE (${client_assessments.private} = 0 or ${client_assessments.private} is NULL) AND ( ${client_assessments.deleted} is NULL OR ${client_assessments.deleted} =0 )END)
          {% else %}
                ${client.id} = ${client_assessments.ref_client} AND
                ( ${client_assessments.deleted} is NULL OR ${client_assessments.deleted} =0 )
          {% endif %};;

    required_joins: [client_assessment_scores]
  }

  join: days_elapsed_last_assessment {
    view_label: "Client Assessments"
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${days_elapsed_last_assessment.id} ;;

  }

  join: latest_assessment_contextual {
    fields: []
    relationship: one_to_one
    type: left_outer
    sql_on: ${client.id} = ${latest_assessment_contextual.ref_client} ;;
  }

  join: custom_score_ranges {
    fields: []
    relationship: many_to_one
    sql_on: ${custom_score_ranges.id} = ${client_assessments.id} ;;
  }

  join: client_last_assessment {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment.id} ;;
  }

  join: client_last_assessment_of_kind {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment_of_kind.id} and ${client_assessments.ref_assessment} = ${client_last_assessment_of_kind.ref_assessment} ;;
  }

  join: client_assessment_scores {
    fields: [assessment_score_average, assessment_score_max]
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_assessment_scores.ref_assessment} ;;
  }

  join: assessment_processors {
    fields: []
    relationship: many_to_one
    sql_on: ${assessment_processors.code} = ${client_assessment_scores.score_type} ;;
  }

  join: assessment_subtotals {
    fields: [code]
    relationship: many_to_one
    sql_on: ${assessment_subtotals.ref_assessment_processor} = ${assessment_processors.id} ;;
  }

  join: client_assessment_high_score {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessment_high_score.ref_assessment} = ${client_assessments.id} ;;
  }

  join: client_last_assessment_id {
    fields: []
    relationship: many_to_one
    sql_on: ${client_assessments.id} = ${client_last_assessment_id.id} ;;
  }

  join: eligibility_processor_results {
    view_label: "Eligible Programs"
    from:  eligibility_processor_results
    relationship: one_to_many
    sql_on: ${client_assessments.id} = ${eligibility_processor_results.ref_assessment_demographic} ;;
  }

  join: eligibility_program {
    from: programs
    fields: [id,name, project_type_code, tracking_method, geocode]
    view_label: "Eligible Programs"
    relationship: one_to_many
    sql_on: ${eligibility_processor_results.ref_program} = ${eligibility_program.id}  ;;
  }

  join: screens {
    fields: []
    type: inner
    relationship: one_to_one
    sql_on: ${screens.id} = ${client_assessments.ref_assessment} ;;
  }

  join: client_assessment_custom {
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${client_assessments.id} =${client_assessment_custom.ref_client_assessment_demographics}
            {% else %}
                ${client_assessments.id} =${client_assessment_custom.ref_client_assessment_demographics} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: referrals {
    type: left_outer
    relationship: many_to_one
    sql_on:
          {% if _user_attributes['agency_id'] != '>0' %}
                ${client.id} = ${referrals.ref_client} AND ${client_assessments.id} = ${referrals.assessment_id} AND
                (CASE WHEN ${referrals.private} = 1 THEN ${referrals.ref_agency} in ({{_user_attributes['agency_id']}})
                AND ( ${referrals.deleted} is NULL OR ${referrals.deleted} =0 )
                ELSE (${referrals.private} = 0 or ${referrals.private} is NULL) AND ( ${referrals.deleted} is NULL OR ${referrals.deleted} =0 )END)
          {% else %}
                ${client.id} = ${referrals.ref_client} AND ${client_assessments.id} = ${referrals.assessment_id} AND
                ( ${referrals.deleted} is NULL OR ${referrals.deleted} =0 )
          {% endif %};;

  }

  join: client_latest_referral {
    type: left_outer
    relationship: one_to_one
    sql_on: ${client_latest_referral.max_referral_id} = ${referrals.id} ;;
  }

  join: referrals_referral_community_queues {
    fields: [referrals_referral_community_queues*]
    type: left_outer
    relationship: one_to_many
    sql_on:  ${referrals_referral_community_queues.id} = ${referrals.ref_queue}
         AND ${referrals.queue} IS NOT NULL
    ;;
  }

  join: referral_notes{
    view_label: "Referral History"
    relationship: one_to_many
    sql_on: ${referral_notes.ref_referral} = ${referrals.id}
      AND (${referral_notes.deleted} IS NULL OR ${referral_notes.deleted} = 0);;
  }

  join: client_referral_status {
    fields: [id,
             ref_queue,
             ever_on_queue,
             Currently_On_Queue]
    relationship: many_to_one
    sql_on: ${client.id} = ${client_referral_status.ref_client} and (${client_referral_status.deleted} = 0 or ${client_referral_status.deleted} is null);;
  }

  join: client_referral_status_referral_community_queues {
    view_label: "Client Referral Status"
    type: left_outer
    relationship: many_to_one
    fields: [referrals_referral_community_queues*]
    sql_on: ${client_referral_status.ref_queue} = ${client_referral_status_referral_community_queues.id}
        AND ${client_referral_status.queue} IS NOT NULL
    ;;
  }

  join: client_referral_status_ever_on_specific_queue {
    type: left_outer
    relationship: one_to_many
    fields: [client_referral_status_ever_on_specific_queue*]
    sql_on:   ${client_referral_status.ref_client} = ${client_referral_status_ever_on_specific_queue.ref_client}
          AND ${client_referral_status.queue} IS NOT NULL
          AND ${client_referral_status_ever_on_specific_queue.ref_queue} = ${client_referral_status_referral_community_queues.id}
          AND ${client_referral_status_ever_on_specific_queue.queue} = TRUE
    ;;
  }

  join: coordinated_entry_event {
    relationship: many_to_one
    sql_on: ${coordinated_entry_event.ref_client} = ${client.id}
            AND ${coordinated_entry_event.enrollment_id} = ${enrollments.id}
      ;;
  }


  join: client_alerts {
    type: left_outer
    relationship: one_to_many
    sql_on:
          {% if _user_attributes['agency_id'] != '>0' %}
                (CASE WHEN ${client_alerts.private} = 1 THEN ${client_alerts.ref_agency} in ({{_user_attributes['agency_id']}})
                  AND ( ${client_alerts.deleted} is NULL OR ${client_alerts.deleted} =0 )
                ELSE (${client_alerts.private} = 0 or ${client_alerts.private} is NULL)
                  AND ( ${client_alerts.deleted} is NULL OR ${client_alerts.deleted} =0 )END)
          {% else %}
                ( ${client_alerts.deleted} is NULL OR ${client_alerts.deleted} =0 )
          {% endif %}
          {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                AND ${client.id} = ${client_alerts.ref_client}
          {% else %}
                AND ${client.id} = ${client_alerts.ref_client} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
          {% endif %};;

  }

  join: referring_agencies {
    from: agencies

    fields: []
    relationship: many_to_one
    sql_on: ${referrals.ref_agency} = ${referring_agencies.id} ;;
  }

  join: referral_history {
    relationship: many_to_one
    fields: [referral_history.coordinated_entry*]
    sql_on: ${referrals.id} = ${referral_history.ref_referral} ;;
  }

  join: referral_history_referral_community_queues {
    fields: [referral_history_referral_community_queues*]
    type: left_outer
    relationship: one_to_many
    sql_on: ${referral_history_referral_community_queues.id} = ${referrals.ref_queue} ;;
  }

  join: referto_program {
    view_label: "Referto Program"
    from: programs
    type: left_outer
    relationship: one_to_many
    fields: [
      ref_agency,
      name,
      project_type_code,
      id,
      added_date,
      description,
      availability,
      tracking_method,
      count,
      coc_information*
    ]
    sql_on: ${referrals.ref_program} = ${referto_program.id} ;;
  }



  join: referto_agencies {
    view_label: "Referto Program"
    relationship: one_to_many
    from: agencies
    fields: [name, id]
    sql_on: ${referto_agencies.id} = ${referto_program.ref_agency} ;;
  }

  join: referto_program_openings {
    type: left_outer
    relationship: one_to_many
    from: program_openings
    sql_on: ${referto_program_openings.id} = ${referrals.ref_opening} ;;
  }


  join: program_openings_history {
    type: left_outer
    relationship: many_to_one
    view_label: "Program Opening History (Beta)"
    sql_on: ${program_openings_history.id} = ${referto_program_openings.id} ;;

  }

  join: program_openings {
    relationship: many_to_one
    sql_on: ${program_openings.ref_program} = ${programs.id} ;;
  }

  join: program_openings_custom {
    view_label: "Program Openings"
    relationship: one_to_one
    type: inner
    sql_on: ${program_openings.id} = ${program_openings_custom.id} ;;
  }

  join: refer_to_program_openings_custom {
    from: program_openings_custom
    view_label: "Referto Program Openings Custom"
    relationship: one_to_one
    type: inner
    sql_on: ${referrals.ref_opening} = ${refer_to_program_openings_custom.id} ;;
  }


  join: client_program_staff {
    fields: []
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${client_program_staff.ref_client_program} = ${enrollments.id}
            {% else %}
                ${client_program_staff.ref_client_program} = ${enrollments.id} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: enrollments {
    type: left_outer
    relationship: one_to_many
    fields: [
      id,
      date_filter,
      end_date,
      start_date,
      head_of_household,
      latest_move_in_date,
      ref_household,
      days_since_start,
      days_since_start_tier,
      average_duration,
      still_in_program,
      is_latest_enrollment,
      is_latest_system_enrollment,
      is_first_enrollment,
      is_first_system_enrollment,
      count,
      last_entry,
      is_latest_enrollment_by_type,
      private,
      assigned_staff,
      ref_client,
      ref_agency,
      ref_agency_text,
      ref_agency_coc
#       ,
#       latest_enrollment_id,
#       first_enrollment_id,
#       latest_enrollment_date,
#       first_enrollment_date,
#       is_latest_enrollment_contextual,
#       programs_name,
#       programs_type_code
    ]

    required_joins: [client_program_staff]

    sql_on: ${client.id} = ${enrollments.ref_client} and ( ${enrollments.deleted} is null OR ${enrollments.deleted} =0 ) ;;

  }

  join: latest_enrollment_contextual {
    fields: []
    relationship: one_to_one
    type: left_outer
    sql_on: ${client.id} = ${latest_enrollment_contextual.ref_client} ;;
  }

  join: client_last_enrollment_by_type {
    fields: []
    relationship: many_to_one
    sql_on: ${base.ref_client} = ${client_last_enrollment_by_type.ref_client}
      and ${programs.ref_category} = ${client_last_enrollment_by_type.ref_category} ;;
  }

  join: members {
    fields: [members.members_coordinated_entry*]
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${client_program_staff.ref_user} = ${members.ref_user}
            {% else %}
                ${client_program_staff.ref_user} = ${members.ref_user} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
     ;;
  }

  join: users {
    fields: []
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${users.id} = ${members.ref_user}
            {% else %}
                ${users.id} = ${members.ref_user} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
   ;;
  }

  join: user_groups {
    fields: []
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${users.ref_user_group} = ${user_groups.id}
            {% else %}
                ${users.ref_user_group} = ${user_groups.id} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: household_makeup {
    view_label: "Enrollments"
    relationship: many_to_one
    sql_on: ${enrollments.ref_household} = ${household_makeup.id} ;;
  }

  join: household_move_in_date {
    view_label: "Referrals"
    fields: []
    relationship: many_to_one
    sql_on: ${referral_connections_enrollment.id} = ${household_move_in_date.enrollment_id} ;;
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

  join: base {
    from: client_program_screening_base
    fields: []
    relationship: many_to_one
    sql_on: ${base.ref_program} = ${enrollments.id} ;;
  }

  join: entry_screen {
    fields: [entry_screen_set*]
    view_label: "Entry Screen"
    sql_on: ${base.first_entry_screen_id} = ${entry_screen.id} ;;
    type: left_outer
    relationship: many_to_one
  }


  join: household_entry_screen {
    view_label: "Entry Screen"
    type: inner
    relationship: one_to_one
    sql_on: ${enrollments.ref_household} =  ${household_entry_screen.household_id} ;;
  }

  join: last_screen {
    view_label: "Update/Exit Screen"
    fields: [last_screen_set*]
    sql_on: ${base.last_screening_to_analyze} = ${last_screen.id} ;;
    type: left_outer
    relationship: many_to_one
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

#   join: client_first_current_living_situation {
#   type: left_outer
#   relationship: one_to_one
#   sql_on: ${client_first_current_living_situation.min_cls_id} = ${status_update_screen.id};;
# }
#
# join: client_last_current_living_situation {
#   type: left_outer
#   relationship: one_to_one
#   sql_on: ${client_last_current_living_situation.cls_id} = ${status_update_screen.id}
#     ;;
# }

 join: programs {
    relationship: one_to_one
    fields: [
      ref_agency,
      name,
      project_type_code,
      id,
      added_date,
      description,
      geocode,
      tracking_method,
      program_applicability,
      status,
      ref_target_b,
      count,
      coc_information*
    ]
    sql_on: ${enrollments.ref_program} = ${programs.id} ;;
  }

  join: program_custom {
    relationship: one_to_many
    sql_on: ${programs.id} = ${program_custom.ref_program} ;;
  }

  join: program_coc {
    relationship: one_to_many
    fields: []
    sql_on: ${programs.id} = ${program_coc.ref_program} and (${program_coc.deleted} is null or ${program_coc.deleted} = 0) ;;
  }

  join: program_sites {
    fields: []
    relationship: many_to_one
    sql_on: ${programs.id} = ${program_sites.ref_program} ;;
  }

  join: geography_types {
    fields: [geography_types.geography_type]
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.ref_geography_type} = ${geography_types.id};;
  }

  join: sites {
    fields: [coc]
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${sites.id} = ${program_sites.ref_site}
            {% else %}
                ${sites.id} = ${program_sites.ref_site} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: client_service_programs {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${enrollments.id} = ${client_service_programs.ref_client_program} ;;
  }

  join: client_services {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${client_services.id} = ${client_service_programs.ref_client_service}
              AND ( ${client_services.deleted} IS NULL OR ${client_services.deleted} = 0 )
              AND CASE WHEN {% date_start services.date_filter %} IS NOT NULL
                        THEN  ${client_services.start_date} <= {% date_end services.date_filter %}
                         AND (${client_services.end_date} >= {% date_start services.date_filter %}
                           OR ${client_services.end_date} IS NULL)
                        ELSE TRUE
                      END;;
  }

  join: client_last_service {
    fields: []
    relationship: many_to_one
    type: left_outer
    sql_on: ${client_services.id} = ${client_last_service.id} ;;
  }

  join: client_last_system_service {
    fields: []
    relationship: one_to_one
    sql_on: ${client_services.id} = ${client_last_system_service.id} ;;
  }


  join: service_items {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${service_items.id} = ${client_services.ref_service_item} ;;
  }

  join: client_service_notes {
    fields: []
    relationship: many_to_one
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${client_service_notes.ref_client_service} = ${client_services.id}
            {% else %}
                ${client_service_notes.ref_client_service} = ${client_services.id} AND ${agencies.id} IN ({{ _user_attributes['agency_root_id'] }})
            {% endif %}
    ;;
  }

  join: services {
    relationship: many_to_one
    sql_on:  ${service_items.ref_service} = ${services.id} ;;
  }

  join: service_dates {
    type: left_outer
    relationship: many_to_one
    sql_on: ${service_dates.ref_client_service} = ${client_services.id}
              AND ${service_items.ref_delivery_type} IN (2, 3)
              AND CASE WHEN {% date_start services.date_filter %} IS NOT NULL
                    THEN ${service_dates.date_date} BETWEEN {% date_start services.date_filter %}
                                                        AND {% date_end services.date_filter %}
                    ELSE TRUE
               END
    ;;
  }

  join: enrollment_agencies {
    from: agencies
    fields: [
      id,
      coc,
      name,
      status,
      count
    ]
    relationship: many_to_one
    sql_on: ${enrollment_agencies.id} = ${programs.ref_agency} ;;
  }

  join: entry_custom {
    type: inner
    relationship: one_to_one
    fields: [entry_custom_fields*]
    # sql_on: ${entry_custom.ref_client_program_demographics} = ${entry_screen.id} ;;
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                  ${entry_custom.ref_client_program_demographics} = ${entry_screen.id}
            {% else %}
                  ${entry_custom.ref_client_program_demographics} = ${entry_screen.id} AND false
            {% endif %}
    ;;
  }

  join: last_custom {
    type: left_outer
    relationship: many_to_one
    view_label: "Update/Exit Custom"
    fields: [last_custom_fields*]
    #  sql_on: ${last_custom.ref_client_program_demographics} = ${last_screen.id} ;;
    sql_on: {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                ${last_custom.ref_client_program_demographics} = ${last_screen.id}
            {% else %}
                ${last_custom.ref_client_program_demographics} = ${last_screen.id} AND false
            {% endif %}
    ;;
  }

  join: client_contacts{
    relationship: many_to_one
    sql_on:
          {% if _user_attributes['agency_id'] != '>0' %}
                (CASE WHEN ${client_contacts.private} = 1 THEN ${client_contacts.ref_agency} in ({{_user_attributes['agency_id']}})
                  AND ( ${client_contacts.deleted} is NULL OR ${client_contacts.deleted} =0 )
                ELSE (${client_contacts.private} = 0 or ${client_contacts.private} is NULL)
                  AND ( ${client_contacts.deleted} is NULL OR ${client_contacts.deleted} =0 )END)
          {% else %}
                ( ${client_contacts.deleted} is NULL OR ${client_contacts.deleted} =0 )
          {% endif %}
          {% if _user_attributes['allow_sensitive_data'] == 'yes' %}
                AND ${base.ref_client} = ${client_contacts.ref_client}  and ${client_contacts.deleted} is null
          {% else %}
                AND ${base.ref_client} = ${client_contacts.ref_client}  and ${client_contacts.deleted} is null
                AND ${agencies.id} in ({{ _user_attributes['agency_root_id'] }})
          {% endif %};;

  }

  join: client_rank_client_contacts {
    view_label: "Client Contacts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${client_contacts.id} = ${client_rank_client_contacts.id} ;;
  }

  join: referral_opening_history {
    view_label: "Referral History"
    type: left_outer
    relationship: many_to_one
    sql_on: ${referrals.id} = ${referral_opening_history.ref_referral} ;;
  }

  join: client_latest_assessment {
    type: left_outer
    relationship: one_to_one
    sql_on: ${client_latest_assessment.assessment_id} = ${client_assessments.id};;
  }

  join: client_first_assessment {
    type: left_outer
    relationship: one_to_one
    sql_on: ${client_first_assessment.assessment_id} = ${client_assessments.id} ;;
  }

  join: status_update_screen {
    fields: []
    view_label: "Status Update Screen"
    type: left_outer
    relationship: many_to_one
    sql_on: ${status_update_screen.ref_program} = ${enrollments.id} and ${status_update_screen.screen_type} in (3,6)
      and (${status_update_screen.deleted} is null or ${status_update_screen.deleted} = 0);;
  }

  join: client_addresses_geolocations {
    fields: [client_addresses_geolocations*]
    relationship: one_to_one
    sql_on: ${client_addresses.ref_geolocation} = ${client_addresses_geolocations.id}
        AND ${client_addresses_geolocations.deleted} IS NULL
    ;;
  }

  join: sites_geolocations {
    fields: [
             address,
             address2,
             city,
             state,
             zipcode
    ]
    relationship: one_to_one
    sql_on:     ${sites.ref_geolocation} = ${sites_geolocations.id}
            AND ${sites_geolocations.deleted} IS NULL
    ;;
  }

#   join: client_geolocations {
#     relationship: one_to_one
#     sql_on: ${clients.ref_geolocation} = ${client_geolocations.id}
#             AND ${client_geolocations.deleted} IS NULL;;
#   }


  join: client_assessment_demographics_geolocations {
    relationship: one_to_one
    sql_on:     ${sites.ref_geolocation} = ${sites_geolocations.id}
            AND ${sites_geolocations.deleted} IS NULL
    ;;
  }

  join: client_program_demographics_geolocations {
    relationship: one_to_one
    sql_on:     ${sites.ref_geolocation} = ${sites_geolocations.id}
            AND ${sites_geolocations.deleted} IS NULL
    ;;
  }


}
