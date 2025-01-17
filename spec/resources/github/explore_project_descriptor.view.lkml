include: "../agencies.view.lkml"
include: "../counties.view.lkml"
include: "../_logs.view.lkml"
include: "../department.view.lkml"
include: "../screen_fields.view.lkml"
include: "../department_program.view.lkml"
include: "../programs.view.lkml"
include: "../program_staff.view.lkml"
include: "../program_coc.view.lkml"
include: "../program_funding_sources.view.lkml"
include: "../vendors.view.lkml"
include: "../program_inventory.view.lkml"
include: "../program_inventory_history.view.lkml"
include: "../program_openings.view.lkml"
include: "../program_openings_custom.view.lkml"
include: "../user_recent_reports.view.lkml"
include: "../agency_contacts.view.lkml"
include: "../funding.view.lkml"
include: "../program_templates.view.lkml"
include: "../program_scoring_eligibility.view.lkml"
include: "../agency_assessments.view.lkml"
include: "../screens.view.lkml"
include: "../screens.view.lkml"
include: "../fields.view.lkml"
include: "../screen_field_constraints.view.lkml"
include: "../members.view.lkml"
include: "../users.view.lkml"
include: "../picklist.view.lkml"
include: "../department_user.view.lkml"
include: "../user_agencies.view.lkml"
include: "../user_groups.view.lkml"
include: "../agency_services.view.lkml"
include: "../program_services.view.lkml"
include: "../service_items.view.lkml"
include: "../sharing_group_agency.view.lkml"
include: "../sharing_group.view.lkml"
include: "../sharing_exceptions.view.lkml"
include: "../program_sites.view.lkml"
include: "../sites.view.lkml"
include: "../geography_types.view.lkml"
include: "../geolocation/sites_geolocations.view.lkml"
include: "../geolocation/agencies_geolocations.view.lkml"
include: "../referral_community_queues.view.lkml"
include: "../referral_settings.view.lkml"
include: "../referral_community_queue_assessments.view.lkml"
include: "../community_queue/community_queue_assessments.view.lkml"
include: "../program_custom.view.lkml"
include: "../clarity_fields.view.lkml"



explore: agencies {

  label: "Project Descriptor Model"

  fields: [
    ALL_FIELDS*,
    -program_inventory_history.total_rrh_bed_inventory,
    -program_inventory_history.total_rrh_unit_inventory
  ]

  access_filter:{field: agencies.id
    user_attribute: agency_id }
  access_filter:{field: agencies.coc
    user_attribute: agency_coc }
  access_filter:{field: agencies.county
    user_attribute: agency_county}

  join: counties {
    fields: []
    relationship: many_to_one
    sql_on: ${counties.id} = ${agencies.ref_county} ;;
  }

  join: department_program {
    view_label: "Departments"
    relationship: many_to_one
    sql_on: ${department_program.ref_program} = ${programs.id} ;;
  }

  join: programs {
    from: programs
    relationship: one_to_many
    sql_on: ${agencies.id} = ${programs.ref_agency} and  ( programs.deleted is null OR programs.deleted =0 ) ;;
  }

  join: program_custom {
    relationship: one_to_many
    sql_on: ${programs.id} = ${program_custom.ref_program} ;;
  }

  join: program_staff {
    view_label: "Programs"
    fields: [program_user]
    relationship: many_to_one
    sql_on: ${programs.id} = ${program_staff.ref_program} ;;
  }

  join: program_coc {
    relationship: one_to_many
    sql_on: ${programs.id} = ${program_coc.ref_program} and (${program_coc.deleted} is null or ${program_coc.deleted} = 0) ;;
  }

  join: program_funding_sources {
    view_label: "Program Funding Sources"
    relationship: many_to_one
    sql_on: ${programs.id} = ${program_funding_sources.ref_program} ;;
  }

  join: vendors {
    view_label: "Agency Vendors"
    relationship: many_to_one
    sql_on: ${agencies.id} = ${vendors.ref_agency} ;;
  }

  join: program_inventory {
    relationship: one_to_many
    sql_on: ${programs.id} = ${program_inventory.ref_program} and  ( program_inventory.deleted is null OR  program_inventory.deleted =0 ) ;;
  }

  join: program_inventory_history {
    relationship: one_to_many
    sql_on: ${program_inventory.id} = ${program_inventory_history.ref_program_inventory}  ;;
  }

  join: program_openings {
    relationship: many_to_one
    sql_on: ${program_openings.ref_program} = ${programs.id} ;;
  }

  join: program_openings_custom
  {
    required_joins: [program_openings]
    view_label: "Program Openings"
    relationship: one_to_one
    type: inner
    sql_on: ${program_openings.id} = ${program_openings_custom.id} ;;
  }

  join: user_recent_reports {
    view_label: "Staff"
    type: inner
    relationship: many_to_one
    sql_on: ${user_recent_reports.ref_user} = ${users.id} ;;
  }

  join: agency_contacts {
    view_label: "Agencies"
    fields: [agency_user]
    type: inner
    relationship: one_to_one
    sql_on: ${agencies.id} = ${agency_contacts.ref_agency} and (agency_contacts.status = 1) ;;
  }

  join: funding {
    relationship: many_to_one
    sql_on: ${funding.ref_agency} = ${agencies.id} ;;
  }

  join: program_templates {
    view_label: "Programs"
    type: inner
    relationship: one_to_one
    sql_on: ${programs.ref_template} = ${program_templates.id} ;;
  }

  join: program_scoring_eligibility {
    view_label: "Program Scoring Tier Eligibility"
    type: inner
    relationship: one_to_one
    sql_on: ${programs.id} = ${program_scoring_eligibility.ref_program} ;;
  }

  join: agency_assessments {
    relationship: many_to_one
    sql_on: ${agencies.id} = ${agency_assessments.ref_agency}
      AND ${screens.id} = ${agency_assessments.ref_assessment};;
  }

  join: screens {
    type: inner
    relationship: one_to_one
    sql_on: ${screens.ref_agency} = ${agencies.id} or ${screens.ref_agency} = 0 ;;

  }

  join: screens_default_profile {
    from: screens
    fields: []
    relationship: many_to_one
    sql_on: ${screens_default_profile.id} = ${agencies.ref_profile_screen} ;;
  }

  join: questions {
    relationship: many_to_one
    sql_on: ${screens.id} = ${questions.ref_screen} ;;
  }

  join: fields {
    fields: [fields.table_type_text, fields.ref_field_type]
    relationship: many_to_one
    sql_on: ${fields.id} = ${questions.ref_field} ;;
  }

  join: screen_field_constraints {
    view_label: "Questions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${questions.id} = ${screen_field_constraints.ref_field} ;;
  }

  join: screen_field_dependent_on{
    from:  questions
    fields: []
    type:  left_outer
    relationship: one_to_one
    sql_on: ${screen_field_constraints.ref_field_condition} = ${screen_field_dependent_on.id} ;;
  }

  join: members {
    relationship: many_to_one
    sql_on: ${agencies.id} = ${members.ref_agency} ;;
  }

  join: users {
    fields: []
    relationship: many_to_one
    required_joins: [department_user]
    sql_on: ${users.id} = ${members.ref_user} ;;
  }

  join: picklist {
    sql_on: ${picklist.ref_field}= ${fields.id};;
    type: left_outer
    relationship: many_to_one
  }


  join: member_activity_logs {
    relationship: many_to_one
    sql_on: ${members.id} = ${member_activity_logs.ref_user} ;;
  }

  join: department_user {
    fields: []
    relationship: many_to_one
    sql_on: ${members.id} = ${department_user.ref_user} ;;
  }

  join: member_departments {
    from: department
    relationship: many_to_one
    sql_on: ${department_user.ref_department} = ${member_departments.id} ;;
  }

  join: user_agencies {
    fields: []
    relationship: many_to_one
    sql_on: ${users.id} = ${user_agencies.ref_user} ;;
  }

  join: member_additional_agencies {
    fields: [name, county, id, coc]
    from: agencies
    relationship: many_to_one
    sql_on: ${user_agencies.ref_agency} = ${member_additional_agencies.id} ;;
  }

  join: user_groups {
    fields: []
    relationship: many_to_one
    sql_on: ${users.ref_user_group} = ${user_groups.id} ;;
  }

  join: agency_services {
    from: agency_services
    type: inner
    relationship: one_to_one
    sql_on: ${agencies.id} = ${agency_services.ref_agency}  and ${agency_services.id} NOT IN (select ref_service from program_services) ;;
  }


  join: program_services {
    fields: []
    relationship: many_to_one
    sql_on: ${program_services.ref_program} = ${programs.id} ;;
  }


  join: project_services {
    from: agency_services
    type: inner
    relationship: one_to_one
    sql_on: ${project_services.id} = ${program_services.ref_service} ;;
  }

  join: service_items {
    fields: [charge_attendance,default_amount,adjustable,ref_funding,expense_type]
    relationship: many_to_one
    view_label: "Project Services"
    sql_on: ${program_services.ref_service} = ${service_items.ref_service} ;;
  }


  join: sharing_group_agency {
    fields: [services, messages, location, files, clients, clients_group]
    relationship: many_to_one
    sql_on: ${sharing_group_agency.ref_agency} = ${agencies.id} ;;
  }

  join: sharing_group {
    view_label: "Sharing"
    fields: [name, count, clients, services, messages, location, files]
    relationship: many_to_one
    sql_on: ${sharing_group.id} = ${sharing_group_agency.ref_sharing_group} ;;
  }

  join: sharing_exceptions {
    view_label: "Sharing"
    relationship: many_to_one
    sql_on: ${sharing_group_agency.ref_agency} = ${sharing_exceptions.ref_sharing} ;;
  }

  join: program_sites {
    fields: [is_primary]
    relationship: many_to_one
    sql_on: ${programs.id} = ${program_sites.ref_program} ;;
  }

  join: sites {
    relationship: many_to_one
    sql_on: ${sites.id}=${program_sites.ref_site} ;;
  }

  join: agency_sites {
    view_label: "Agency Sites"
    from: sites
    relationship: many_to_one
    sql_on: ${agency_sites.ref_agency} = ${agencies.id} ;;
  }

  join: geography_types {
    fields: [geography_types.geography_type]
    type: left_outer
    relationship: many_to_one
    sql_on: ${sites.ref_geography_type} = ${geography_types.id};;
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
    sql_on: ${sites.ref_geolocation} = ${sites_geolocations.id}
        AND ${sites_geolocations.deleted} IS NULL
    ;;
  }

  join: referral_settings {
    relationship: many_to_one
    sql_on:
        CASE
          WHEN ${referral_settings.ref_coc} IS NOT NULL
            THEN ${agencies.coc} = ${referral_settings.ref_coc}
          WHEN ${referral_settings.ref_sharing_group} IS NOT NULL
            THEN ${sharing_group.id} = ${referral_settings.ref_sharing_group}
          ELSE NULL
          END
        ;;
  }

  join: referral_community_queues {
    relationship: many_to_one
    sql_on: ${referral_community_queues.ref_referral_setting} = ${referral_settings.id} ;;
  }

  join: referral_community_queue_assessments {
    relationship: many_to_one
    sql_on: ${referral_community_queue_assessments.ref_queue} = ${referral_community_queues.id} ;;
  }

  join: community_queue_assessments {
    fields: [community_queue_assessments*]
    relationship: many_to_one
    sql_on: ${community_queue_assessments.id} = ${referral_community_queue_assessments.ref_assessment} ;;
  }

  join: clarity_fields {
    required_access_grants: [looker_sys_admin]
    relationship: many_to_many
    sql_on: ${agencies.coc} = ${clarity_fields.user_updating_coc} ;;
  }

}
