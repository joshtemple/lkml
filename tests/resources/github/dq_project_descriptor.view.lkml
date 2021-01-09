include: "programs.view.lkml"
include: "dq_constants.view.lkml"
view: dq_project_descriptor {

  extends: [programs, dq_constants]

  view_label: "DQ Project Descriptor"

  set: dq_project_descriptor_drills {
    fields: [name, id]
  }

  dimension: error_in_project_descriptor {
    view_label: "DQ Project Descriptor"
    label: "Project Descriptor Contains Error"
    description: "Project descriptor contains one or more errors in require HMIS fields"

    allow_fill: no
    case: {
      when: {
        sql: ${project_type_error} = "None"
          AND ${residential_affiliation_error} = "None"
          AND ${tracking_method_error} = "None"
          AND ${target_population_error} = "None"
          AND ${victim_service_provider_error} = "None"
          AND ${housing_type_error} = "None"
          AND ${funding_source_error} = "None"
          AND ${grant_id_error} = "None"
          AND ${grant_start_date_error} = "None"
          AND ${grant_end_date_error} = "None";;
        label: "No"
      }
      else: "Yes"
    }
  }

  dimension: project_type_error  {
    view_label: "DQ Project Descriptor"
    label: "Project Type Error"
    description: "Error in @{hmis_ref_num_project_type}: Project Type Code"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${dq_project_descriptor.ref_category} IS NULL ;;
        label: "Null"
      }
      when: {
        sql:  ${dq_project_descriptor.ref_category} NOT IN (1, 2, 3, 4, 5, 6, 7, 8,
          9, 10, 11, 12, 13, 14) ;;
        label: "Invalid HMIS Project Type"
      }
      else: "None"
    }
  }

  dimension: residential_affiliation_error  {
    view_label: "DQ Project Descriptor"
    label: "Residential Affiliation Error"
    description: "Error in @{hmis_ref_num_aff_res_proj_ids}: Residential Affiliation"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${dq_project_descriptor.ref_category} = 6
          AND ${dq_project_descriptor.aff_res_proj} IS NULL;;
        label: "Null"
      }
      when: {
        sql:  ${dq_project_descriptor.ref_category} = 6
          AND ${dq_project_descriptor.aff_res_proj} NOT IN (0, 1);;
        label: "Residential Affiliation Response Invalid"
      }
      else: "None"
    }
  }

  dimension: tracking_method_error  {
    view_label: "DQ Project Descriptor"
    label: "Tracking Method Error"
    description: "Error in @{hmis_ref_num_tracking_method}: Tracking Method"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${dq_project_descriptor.ref_category} = 1
          AND ${dq_project_descriptor.tracking_method} IS NULL;;
        label: "Null"
      }
      when: {
        sql:  ${dq_project_descriptor.ref_category} = 1
          AND ${dq_project_descriptor.tracking_method} NOT IN (0, 3);;
        label: "Invalid Tracking Method"
      }
      else: "None"
    }
  }

  dimension: target_population_error  {
    label: "Target Population Error"
    description: "Error in @{hmis_ref_num_ref_target_b}: Target Population"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${dq_project_descriptor.raw_ref_target_b} IS NULL;;
        label: "Null"
      }
      when: {
        sql:  ${dq_project_descriptor.raw_ref_target_b} NOT IN (1, 3, 4);;
        label: "Invalid Target Population Selected"
      }
      else: "None"
    }
  }

  dimension: victim_service_provider_error  {
    view_label: "DQ Project Descriptor"
    label: "Victim Service Provider Error"
    description: "Part of Organization Information. Error in @{hmis_ref_num_victim_service_provider}: Victim Service Provider"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${agencies.victim_service_provider_raw} IS NULL;;
        label: "Null"
      }
      when: {
        sql:  ${agencies.victim_service_provider_raw} NOT IN (0, 1);;
        label: "Invalid Victim Service Provider Selected"
      }
      else: "None"
    }
  }

  dimension: housing_type_error  {
    view_label: "DQ Project Descriptor"
    label: "Housing Type Error"
    description: "Error in @{hmis_ref_num_ref_housing_type}: Housing Type"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${dq_project_descriptor.ref_housing_type_raw} IS NULL;;
        label: "Null"
      }
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${dq_project_descriptor.ref_housing_type_raw} NOT IN (1, 2, 3);;
        label: "Invalid House Type Selected"
      }
      else: "None"
    }
  }

  dimension: funding_source_error  {
    view_label: "DQ Project Descriptor"
    label: "Funding Source Error"
    description: "Error in @{hmis_ref_num_funding_source}: Funding Source"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: ${program_funding_sources.funding_source_code} IS NULL;;
        label: "Null"
      }
      when: {
        sql:  ${program_funding_sources.funding_source_code} IS NOT NULL
          AND ${program_funding_sources.funding_source_code} NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                                        16, 17, 18, 19,  20, 21, 22, 23, 24, 25, 26, 27, 29,
                                        30, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46);;
        label: "Invalid Funding Source Selected"
      }
      else: "None"
    }
  }

  dimension: grant_id_error  {
    view_label: "DQ Project Descriptor"
    label: "Grant ID Error"
    description: "Error in @{hmis_ref_num_identifier}: Grant ID"
    alpha_sort: yes

    # We remove Funding Source 34, since that's "NA"
    allow_fill: no
    case: {
      when: {
        sql: ${program_funding_sources.funding_source_code} IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                                        16, 17, 18, 19,  20, 21, 22, 23, 24, 25, 26, 27, 29,
                                        30, 33, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46)
         AND ${program_funding_sources.identifier} IS NULL;;
        label: "Null"
      }
      else: "None"
    }
  }

  dimension: grant_start_date_error  {
    view_label: "DQ Project Descriptor"
    description: "Error in @{hmis_ref_num_grant_start_date}: Grant Start Date"

    alpha_sort: yes

    # We remove Funding Source 34, since that's "NA"
    allow_fill: no
    case: {
      when: {
        sql: ${program_funding_sources.funding_source_code} IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                                        16, 17, 18, 19,  20, 21, 22, 23, 24, 25, 26, 27, 29,
                                        30, 33, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46)
         AND ${program_funding_sources.start_date} IS NULL;;
        label: "Null"
      }
      when: {
        sql: ${program_funding_sources.funding_source_code} IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                                        16, 17, 18, 19,  20, 21, 22, 23, 24, 25, 26, 27, 29,
                                        30, 33, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46)
         AND ${program_funding_sources.start_date} > ${program_funding_sources.end_date};;
        label: "Grant Start Date is after Grant End Date"
      }
      else: "None"
    }
  }

  dimension: grant_end_date_error  {
    view_label: "DQ Project Descriptor"
    description: "Error in @{hmis_ref_num_grant_end_date}: Grant End Date"

    alpha_sort: yes

    # We remove Funding Source 34, since that's "NA"
    allow_fill: no
    case: {
      when: {
        sql: ${program_funding_sources.funding_source_code} IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                                        16, 17, 18, 19,  20, 21, 22, 23, 24, 25, 26, 27, 29,
                                        30, 33, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46)
         AND ${program_funding_sources.start_date} IS NULL;;
        label: "Null"
      }
      when: {
        sql: ${program_funding_sources.funding_source_code} IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
                                        16, 17, 18, 19,  20, 21, 22, 23, 24, 25, 26, 27, 29,
                                        30, 33, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46)
         AND ${program_funding_sources.end_date} < ${program_funding_sources.start_date};;
        label: "Grant End Date is before Grant Start Date"
      }
      else: "None"
    }
  }

  dimension: inventory_household_type_error {
    view_label: "DQ Project Descriptor"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_household_type}: Program Inventory"
    allow_fill: no
    case: {
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.ref_household_type} IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.ref_household_type} NOT IN (1, 3, 4) ;;
        label: "Invalid Program Inventory Household Type Selected"
      }
      else: "None"
    }
  }

  dimension: availability_error {
    view_label: "DQ Project Descriptor"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_availability}: Availability"
    allow_fill: no
    case: {
      when: {
        sql: ${dq_project_descriptor.ref_category} = 1
          AND ${program_inventory.raw_availability} IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${dq_project_descriptor.ref_category} = 1
          AND ${program_inventory.raw_availability} NOT IN (1, 2, 3) ;;
        label: "Invalid Program Inventory Household Type Selected"
      }
      else: "None"
    }
  }

  dimension: units_error {
    label: "Total Unit Inventory Error"
    view_label: "DQ Project Descriptor"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_unit_inventory}: Total Units"
    allow_fill: no
    case: {
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.unit_inventory} IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.unit_inventory} = 0;;
        label: "Program has zero units"
      }
      when: {
        sql: ${program_inventory.unit_inventory} > ${program_inventory.bed_inventory};;
        label: "Total Units are greater than Total Beds"
      }
      else: "None"
    }
  }

  dimension: beds_error {
    label: "Total Bed Inventory Error"
    view_label: "DQ Project Descriptor"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_inventory}: Total Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.bed_inventory} IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.bed_inventory} = 0;;
        label: "Program has zero beds"
      }
      when: {
        sql: ${program_inventory.unit_inventory} > ${program_inventory.bed_inventory};;
        label: "Total Units are greater than Total Beds"
      }
      else: "None"
    }
  }

  dimension: inventory_start_date_error {
    view_label: "DQ Project Descriptor"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_program_inventory_start_date}: Inventory Start Date"
    allow_fill: no
    case: {
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.start_date} IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.start_date} IS NOT NULL
          AND ${program_inventory.end_date} IS NOT NULL
          AND ${program_inventory.start_date} > ${program_inventory.end_date};;
        label: "Bed / Unit Inventory Start Date after End Date"
      }
      else: "None"
    }
  }


  dimension: inventory_end_date_error {
    view_label: "DQ Project Descriptor"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_program_inventory_end_date}: Inventory End Date"
    allow_fill: no
    case: {
      when: {
        sql: ${dq_project_descriptor.ref_category} IN (1, 2, 3, 8, 9, 10, 13)
          AND ${program_inventory.start_date} IS NOT NULL
          AND ${program_inventory.end_date} IS NOT NULL
          AND ${program_inventory.end_date} < ${program_inventory.start_date};;
        label: "Bed / Unit Inventory End Date is before Start Date"
      }
      else: "None"
    }
  }

  measure: project_type_error_count {
    description: "Error in @{hmis_ref_num_project_type}: Project Type Code"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: project_type_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, project_type_error]
    sql: ${id};;
  }

  measure: availability_error_count {
    description: "Error in @{hmis_ref_num_availability}: Availability"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: availability_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, availability_error]
    sql: ${id};;
  }

  measure: units_error_count {
    label: "Total Units Error Count"
    description: "Error in @{hmis_ref_num_total_unit_inventory}: Total Units"
    view_label: "DQ Project Descriptor"
    group_label: "Bed Allocations"
    type: count_distinct
    filters: {
      field: units_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, units_error]
    sql: ${id};;
  }

  measure: funding_source_error_count {
    description: "Error in @{hmis_ref_num_funding_source}: Funding Source"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: funding_source_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, funding_source_error]
    sql: ${id};;
  }

  measure: target_population_error_count {
    description: "Error in @{hmis_ref_num_ref_target_b}: Target Population"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: target_population_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, target_population_error]
    sql: ${id};;
  }

  measure: grant_end_date_error_count {
    description: "Error in @{hmis_ref_num_grant_end_date}: Grant End Date"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: grant_end_date_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, grant_end_date_error]
    sql: ${id};;
  }

  measure: inventory_start_date_error_count {
    description: "Error in @{hmis_ref_num_program_inventory_start_date}: Inventory Start Date"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: inventory_start_date_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, inventory_start_date_error]
    sql: ${id};;
  }

  measure: inventory_end_date_error_count {
    description: "Error in @{hmis_ref_num_program_inventory_end_date}: Inventory End Date"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: inventory_end_date_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, inventory_end_date_error]
    sql: ${id};;
  }

  measure: error_in_project_descriptor_count {
    description: "Project descriptor contains one or more errors in require HMIS fields"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: error_in_project_descriptor
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, error_in_project_descriptor]
    sql: ${id};;
  }

  measure: tracking_method_error_count {
    description: "Error in @{hmis_ref_num_tracking_method}: Tracking Method"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: tracking_method_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, tracking_method_error]
    sql: ${id};;
  }

  measure: inventory_household_type_error_count {
    description: "Error in @{hmis_ref_num_availability}: Program Inventory"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: inventory_household_type_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, inventory_household_type_error]
    sql: ${id};;
  }

  measure: housing_type_error_count {
    description: "Error in @{hmis_ref_num_ref_housing_type}: Housing Type"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: housing_type_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, housing_type_error]
    sql: ${id};;
  }

  measure: grant_start_date_error_count {
    description: "Error in @{hmis_ref_num_grant_start_date}: Grant Start Date"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: grant_start_date_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, grant_start_date_error]
    sql: ${id};;
  }

  measure: beds_error_count {
    label: "Total Beds Error Count"
    description: "Error in @{hmis_ref_num_total_bed_inventory}: Total Beds"
    view_label: "DQ Project Descriptor"
    group_label: "Bed Allocations"
    type: count_distinct
    filters: {
      field: beds_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_error]
    sql: ${id};;
  }

  measure: residential_affiliation_error_count {
    description: "Error in @{hmis_ref_num_aff_res_proj_ids}: Residential Affiliation"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: residential_affiliation_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, residential_affiliation_error]
    sql: ${id};;
  }

  measure: victim_service_provider_error_count {
    description: "Error in @{hmis_ref_num_victim_service_provider}: Victim Service Provider"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: victim_service_provider_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, victim_service_provider_error]
    sql: ${id};;
  }

  measure: grant_id_error_count {
    description: "Error in @{hmis_ref_num_identifier}: Grant ID"
    view_label: "DQ Project Descriptor"
    group_label: ""
    type: count_distinct
    filters: {
      field: grant_id_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, grant_id_error]
    sql: ${id};;
  }

  measure: total_project_descriptor_error_count {
    label: "Total Project Descriptor Error Count"
    view_label: "Aggregates"
    type: number
    sql:  ${project_type_error_count} +
          ${availability_error_count} +
          ${units_error_count} +
          ${funding_source_error_count} +
          ${target_population_error_count} +
          ${grant_end_date_error_count} +
          ${inventory_start_date_error_count} +
          ${inventory_end_date_error_count} +
          ${error_in_project_descriptor_count} +
          ${tracking_method_error_count} +
          ${inventory_household_type_error_count} +
          ${housing_type_error_count} +
          ${grant_start_date_error_count} +
          ${beds_error_count} +
          ${residential_affiliation_error_count} +
          ${victim_service_provider_error_count} +
          ${grant_id_error_count} +
          ${beds_ch_veteran_error_count} +
          ${beds_ch_youth_error_count} +
          ${beds_non_dedicated_error_count} +
          ${beds_ch_other_error_count} +
          ${beds_other_veteran_error_count} +
          ${beds_other_youth_error_count} +
          ${beds_youth_veteran_error_count} +
          ${coc_address_2_error_count} +
          ${coc_address_error_count} +
          ${coc_city_error_count} +
          ${coc_code_error_count} +
          ${coc_geocode_error_count} +
          ${coc_geography_type_error_count} +
          ${coc_state_error_count} +
          ${coc_zip_error_count}
                ;;

      drill_fields: [
        agencies.name,
        name,
        project_type_error_count,
        availability_error_count,
        units_error_count,
        funding_source_error_count,
        target_population_error_count,
        grant_end_date_error_count,
        inventory_start_date_error_count,
        inventory_end_date_error_count,
        error_in_project_descriptor_count,
        tracking_method_error_count,
        inventory_household_type_error_count,
        housing_type_error_count,
        grant_start_date_error_count,
        beds_error_count,
        residential_affiliation_error_count,
        victim_service_provider_error_count,
        grant_id_error_count,
        beds_ch_veteran_error_count,
        beds_ch_youth_error_count,
        beds_non_dedicated_error_count,
        beds_ch_other_error_count,
        beds_other_veteran_error_count,
        beds_other_youth_error_count,
        beds_youth_veteran_error_count,
        coc_address_2_error_count,
        coc_address_error_count,
        coc_city_error_count,
        coc_code_error_count,
        coc_geocode_error_count,
        coc_geography_type_error_count,
        coc_state_error_count,
        coc_zip_error_count
      ]
    }



  dimension: id {
    view_label: "Programs"
  }

  dimension_group: added {
    view_label: "Programs"
  }

  dimension: aff_res_proj {
    view_label: "Programs"
  }

  dimension: aff_res_proj_ids {
    view_label: "Programs"
  }

  dimension: allow_autoservice_placement {
    view_label: "Programs"
  }

  dimension: allow_goals {
    view_label: "Programs"
  }

  dimension: allow_history_link {
    view_label: "Programs"
  }

  dimension: autoexit_duration {
    view_label: "Programs"
  }

  dimension_group: availability_end {
    view_label: "Programs"
  }

  dimension_group: availability_start {
    view_label: "Programs"
  }

  dimension: cascade_threshold {
    view_label: "Programs"
  }

  dimension: availability {
    view_label: "Programs"
  }

  dimension: close_services {
    view_label: "Programs"
  }

  dimension: cross_agency {
    view_label: "Programs"
  }

  dimension: description {
    view_label: "Programs"
  }

  dimension: eligibility_enabled {
    view_label: "Programs"
  }

  dimension: enable_autoexit {
    view_label: "Programs"
  }

  dimension: enable_cascade {
    view_label: "Programs"
  }

  dimension: enable_charts {
    view_label: "Programs"
  }

  dimension: enable_files {
    view_label: "Programs"
  }

  dimension: enable_notes {
    view_label: "Programs"
  }

  dimension: enable_assessments {
    view_label: "Programs"
  }

  dimension: funding_source {
    view_label: "Programs"
  }

  dimension: geocode {
    view_label: "Programs"
  }

  dimension: identifier {
    view_label: "Programs"
  }

  dimension_group: last_updated {
    view_label: "Programs"
  }

  dimension: name {
    view_label: "Programs"
  }

  dimension: agency_project_name {
    view_label: "Programs"
  }

  measure: list_of_program_names {
    view_label: "Programs"
  }

  dimension: project_coc {
    view_label: "Programs"
  }

  measure: list_of_program_cocs {
    view_label: "Programs"
  }


  dimension: public_listing {
    view_label: "Programs"
  }

  dimension: ref_agency {
    hidden: yes
    view_label: "Programs"
  }

  dimension: ref_category {
    hidden: yes
    view_label: "Programs"
  }

  dimension: project_type_code {
    view_label: "Programs"
  }

  dimension: raw_project_type_code {
    view_label: "Programs"
  }

  dimension: ref_site_type {
    view_label: "Programs"
  }

  dimension: ref_target_b {
    view_label: "Programs"
  }

  dimension: raw_ref_target_b {
    view_label: "Programs"
  }

  dimension: ref_template {
    view_label: "Programs"
  }

  dimension: program_applicability {
    view_label: "Programs"
  }

  dimension: ref_user_updated {
    view_label: "Programs"
  }

  dimension: site_id {
    view_label: "Programs"
  }

  dimension: status {
    view_label: "Programs"
  }

  dimension: victim_service_provider {
    view_label: "Programs"
  }

  dimension: ref_housing_type {
    view_label: "Programs"
  }

  dimension: continuum_project {
    view_label: "Programs"
  }

  dimension: tracking_method {
    view_label: "Programs"
  }

  dimension: tracking_method_raw {
    view_label: "Programs"
    hidden: yes
  }

  dimension: first_client_enrollment_date {
    view_label: "Programs"
  }

  dimension: deleted {
    hidden: yes
  }

  measure: count {
    view_label: "Programs"
  }

  dimension: beds_ch_veteran_error {
    view_label: "DQ Project Descriptor"
    label: "CH Veteran Beds Error"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_chronic_and_veteran_inventory}: Chronically Homeless Veteran Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${program_inventory.is_bed_ch_veteran} = TRUE
          AND ${program_inventory.bed_ch_veteran} = 0;;
        label: "Inventory is zero"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_veteran} = TRUE
          AND ${program_inventory.bed_ch_veteran} < 0;;
        label: "Inventory is negative"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_veteran} = TRUE
          AND ${program_inventory.bed_ch_veteran} is null;;
        label: "Inventory is null"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_veteran} = FALSE
          AND ${program_inventory.bed_ch_veteran} != 0;;
        label: "Inventory count entered but not toggled"
      }
      else: "None"
    }
  }

  dimension: beds_ch_youth_error {
    view_label: "DQ Project Descriptor"
    label: "CH Youth Beds Error"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_chronic_youth_inventory}: Chronically Homeless Youth Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${program_inventory.is_bed_ch_youth} = TRUE
          AND ${program_inventory.bed_ch_youth} = 0;;
        label: "Inventory is zero"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_youth} = TRUE
          AND ${program_inventory.bed_ch_youth} < 0;;
        label: "Inventory is negative"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_youth} = TRUE
          AND ${program_inventory.bed_ch_youth} is null;;
        label: "Inventory is null"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_youth} = FALSE
          AND ${program_inventory.bed_ch_youth} != 0;;
        label: "Inventory count entered but not toggled"
      }
      else: "None"
    }
  }

  dimension: beds_non_dedicated_error {
    view_label: "DQ Project Descriptor"
    label: "Non-Dedicated Beds Error"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_non_dedicated_inventory}: Non-Dedicated Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${program_inventory.is_bed_non_dedicated} = TRUE
          AND ${program_inventory.bed_non_dedicated} = 0;;
        label: "Inventory is zero"
      }
      when: {
        sql: ${program_inventory.is_bed_non_dedicated} = TRUE
          AND ${program_inventory.bed_non_dedicated} < 0;;
        label: "Inventory is negative"
      }
      when: {
        sql: ${program_inventory.is_bed_non_dedicated} = TRUE
          AND ${program_inventory.bed_non_dedicated} is null;;
        label: "Inventory is null"
      }
      when: {
        sql: ${program_inventory.is_bed_non_dedicated} = FALSE
          AND ${program_inventory.bed_non_dedicated} != 0;;
        label: "Inventory count entered but not toggled"
      }
      else: "None"
    }
  }

  dimension: beds_ch_other_error {
    view_label: "DQ Project Descriptor"
    label: "Other Chronically Homeless Beds Error"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_other_ch_inventory}: Other Chronically Homeless Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${program_inventory.is_bed_ch_other} = TRUE
          AND ${program_inventory.bed_ch_other} = 0;;
        label: "Inventory is zero"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_other} = TRUE
          AND ${program_inventory.bed_ch_other} < 0;;
        label: "Inventory is negative"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_other} = TRUE
          AND ${program_inventory.bed_ch_other} is null;;
        label: "Inventory is null"
      }
      when: {
        sql: ${program_inventory.is_bed_ch_other} = FALSE
          AND ${program_inventory.bed_ch_other} != 0;;
        label: "Inventory count entered but not toggled"
      }
      else: "None"
    }
  }

  dimension: beds_other_veteran_error {
    view_label: "DQ Project Descriptor"
    label: "Other Veteran Beds Error"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_other_veteran_inventory}: Other Veteran Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${program_inventory.is_bed_other_veteran} = TRUE
          AND ${program_inventory.bed_other_veteran} = 0;;
        label: "Inventory is zero"
      }
      when: {
        sql: ${program_inventory.is_bed_other_veteran} = TRUE
          AND ${program_inventory.bed_other_veteran} < 0;;
        label: "Inventory is negative"
      }
      when: {
        sql: ${program_inventory.is_bed_other_veteran} = TRUE
          AND ${program_inventory.bed_other_veteran} is null;;
        label: "Inventory is null"
      }
      when: {
        sql: ${program_inventory.is_bed_other_veteran} = FALSE
          AND ${program_inventory.bed_other_veteran} != 0;;
        label: "Inventory count entered but not toggled"
      }
      else: "None"
    }
  }

  dimension: beds_other_youth_error {
    view_label: "DQ Project Descriptor"
    label: "Other Youth Beds Error"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_other_youth_inventory}: Other Youth Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${program_inventory.is_bed_other_youth} = TRUE
          AND ${program_inventory.bed_other_youth} = 0;;
        label: "Inventory is zero"
      }
      when: {
        sql: ${program_inventory.is_bed_other_youth} = TRUE
          AND ${program_inventory.bed_other_youth} < 0;;
        label: "Inventory is negative"
      }
      when: {
        sql: ${program_inventory.is_bed_other_youth} = TRUE
          AND ${program_inventory.bed_other_youth} is null;;
        label: "Inventory is null"
      }
      when: {
        sql: ${program_inventory.is_bed_other_youth} = FALSE
          AND ${program_inventory.bed_other_youth} != 0;;
        label: "Inventory count entered but not toggled"
      }
      else: "None"
    }
  }

  dimension: beds_youth_veteran_error {
    view_label: "DQ Project Descriptor"
    label: "Youth-Veteran Beds Error"
    group_label: "Bed Allocations"
    alpha_sort: yes
    description: "Error in @{hmis_ref_num_total_bed_youth_veteran_inventory}: Youth-Veteran Beds"
    allow_fill: no
    case: {
      when: {
        sql: ${program_inventory.is_bed_youth_veteran} = TRUE
          AND ${program_inventory.bed_youth_veteran} = 0;;
        label: "Inventory is zero"
      }
      when: {
        sql: ${program_inventory.is_bed_youth_veteran} = TRUE
          AND ${program_inventory.bed_youth_veteran} < 0;;
        label: "Inventory is negative"
      }
      when: {
        sql: ${program_inventory.is_bed_youth_veteran} = TRUE
          AND ${program_inventory.bed_youth_veteran} is null;;
        label: "Inventory is null"
      }
      when: {
        sql: ${program_inventory.is_bed_youth_veteran} = FALSE
          AND ${program_inventory.bed_youth_veteran} != 0;;
        label: "Inventory count entered but not toggled"
      }
      else: "None"
    }
  }

  measure: beds_ch_veteran_error_count {
    view_label: "DQ Project Descriptor"
    label: "CH Veteran Beds Error Count"
    group_label: "Bed Allocations"
    description: "Error in @{hmis_ref_num_total_bed_chronic_and_veteran_inventory}: Chronically Homeless Veteran Beds"
    type:  count_distinct
    filters: {
      field: beds_ch_veteran_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_ch_veteran_error]
    sql: ${id} ;;
    }

  measure: beds_ch_youth_error_count {
    view_label: "DQ Project Descriptor"
    label: "CH Youth Beds Error Count"
    group_label: "Bed Allocations"
    description: "Error in @{hmis_ref_num_total_bed_chronic_youth_inventory}: Chronically Homeless Youth Beds"
    type:  count_distinct
    filters: {
      field: beds_ch_youth_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_ch_youth_error]
    sql: ${id} ;;
  }

  measure: beds_non_dedicated_error_count {
    view_label: "DQ Project Descriptor"
    label: "Non-Dedicated Beds Error Count"
    group_label: "Bed Allocations"
    description: "Error in @{hmis_ref_num_total_bed_non_dedicated_inventory}: Non-Dedicated Beds"
    type:  count_distinct
    filters: {
      field: beds_non_dedicated_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_non_dedicated_error]
    sql: ${id} ;;
  }

  measure: beds_ch_other_error_count {
    view_label: "DQ Project Descriptor"
    label: "Other Chronically Homeless Beds Error Count"
    group_label: "Bed Allocations"
    description: "Error in @{hmis_ref_num_total_bed_other_ch_inventory}: Other Chronically Homeless Beds"
    type:  count_distinct
    filters: {
      field: beds_ch_other_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_ch_other_error]
    sql: ${id} ;;
  }

  measure: beds_other_veteran_error_count {
    view_label: "DQ Project Descriptor"
    label: "Other Veteran Beds Error Count"
    group_label: "Bed Allocations"
    description: "Error in @{hmis_ref_num_total_bed_other_veteran_inventory}: Other Veteran Beds"
    type:  count_distinct
    filters: {
      field: beds_other_veteran_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_other_veteran_error]
    sql: ${id} ;;
  }

  measure: beds_other_youth_error_count {
    view_label: "DQ Project Descriptor"
    label: "Other Youth Beds Error Count"
    group_label: "Bed Allocations"
    description: "Error in @{hmis_ref_num_total_bed_other_youth_inventory}: Other Youth Beds"
    type:  count_distinct
    filters: {
      field: beds_other_youth_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_other_youth_error]
    sql: ${id} ;;
  }

  measure: beds_youth_veteran_error_count {
    view_label: "DQ Project Descriptor"
    label: "Youth-Veteran Beds Error Count"
    group_label: "Bed Allocations"
    description: "Error in @{hmis_ref_num_total_bed_youth_veteran_inventory}: Youth-Veteran Beds"
    type:  count_distinct
    filters: {
      field: beds_youth_veteran_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, beds_youth_veteran_error]
    sql: ${id} ;;
  }

  dimension: coc_code_error {
    view_label: "DQ Project Descriptor"
    label: "CoC Code Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_project_coc}: CoC Code"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${dq_project_descriptor.project_coc} = ""
            OR ${dq_project_descriptor.project_coc} IS Null;;
        label: "Null"
      }
      when: {
        sql: ${dq_project_descriptor.project_coc} NOT IN ${dq_project_descriptor.const_valid_cocs} ;;
        label: "Invalid CoC Code"
      }
      else: "None"
    }
  }

  dimension: coc_geocode_error {
    view_label: "DQ Project Descriptor"
    label: "Geocode Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_geocode}: Geocode"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${dq_project_descriptor.geocode} IS Null;;
        label: "Null"
      }
      when: {
        sql: LENGTH(${dq_project_descriptor.geocode}) < 6 ;;
        label: "Geocode is too short"
      }
      when: {
        sql: LENGTH(${dq_project_descriptor.geocode}) > 6 ;;
        label: "Geocode is too long"
      }
      when: {
        sql: ${dq_project_descriptor.geocode} = ""
              AND LENGTH(${dq_project_descriptor.geocode}) > 0 ;;
        label: "Geocode contains only white-space"
        }
      when: {
        sql: ${dq_project_descriptor.geocode} REGEXP '^[a-z]' ;;
        label: "Geocode contains letters"
      }
      else: "None"
    }
  }

  dimension: coc_address_error {
    view_label: "DQ Project Descriptor"
    label: "Address Line 1 Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_address}: Project Street Address 1"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${sites.ref_agency} IS Null;;
        label: "No site connected to program"
      }
      when: {
        sql: ${programs.address} IS Null;;
        label: "Null"
      }
      when: {
        sql: ${programs.address} = ${programs.address_2} ;;
        label: "Same address in both lines"
      }
      when: {
        sql: LENGTH(${programs.address}) < 2;;
        label: "Address is too short"
      }
      when: {
        sql: LENGTH(${programs.address}) > 0
          AND ${programs.address} = "" ;;
        label: "Address contains only white-space"
      }
      else: "None"
    }
  }

  dimension: coc_address_2_error {
    view_label: "DQ Project Descriptor"
    label: "Address Line 2 Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_address_2}: Project Street Address 2"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${sites.ref_agency} IS Null;;
        label: "No site connected to program"
      }
      when: {
        sql: ${programs.address} = ${programs.address_2} ;;
        label: "Same address in both lines"
        }
      when: {
        sql: LENGTH(${programs.address_2}) > 0
            AND ${programs.address_2} = "" ;;
        label: "Address 2 contains only white-space"
      }
      when: {
        sql: LENGTH(${programs.address_2}) = 1 ;;
        label: "Address 2 is too short"
      }
      else: "None"
    }
  }

  dimension: coc_city_error {
    view_label: "DQ Project Descriptor"
    label: "City Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_city}: Project City"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${sites.ref_agency} IS Null;;
        label: "No site connected to program"
      }
      when: {
        sql: ${programs.city} IS Null;;
        label: "Null"
      }
      when: {
        sql: LENGTH(${programs.city}) < 2;;
        label: "City is too short"
      }
      when: {
        sql: ${programs.city} = ""
              AND LENGTH(${programs.city}) > 0 ;;
        label: "City contains only white-space"
      }
      else: "None"
    }
  }

  dimension: coc_geography_type_error {
    view_label: "DQ Project Descriptor"
    label: "Geography Type Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_geography_type}: Geography Type"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${sites.ref_agency} IS Null;;
        label: "No site connected to program"
      }
      when: {
        sql: ${programs.geography_type} IS Null;;
        label: "Null"
      }
      when: {
        sql: ${programs.geography_type} NOT IN (1,2,3) ;;
        label: "Invalid geography type"
      }
      else: "None"
    }
  }

  dimension: coc_state_error {
    view_label: "DQ Project Descriptor"
    label: "State Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_state}}: Project State"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${sites.ref_agency} IS Null;;
        label: "No site connected to program"
      }
      when: {
        sql: ${programs.state} IS Null;;
        label: "Null"
      }
      when: {
        sql: LENGTH(${programs.state}) < 2;;
        label: "State is too short"
      }
      when: {
        sql: ${programs.state} = ""
            AND LENGTH(${programs.state}) > 0;;
        label: "State contains only white-space"
      }
      else: "None"
    }
  }

  dimension: coc_zip_error {
    view_label: "DQ Project Descriptor"
    label: "ZIP Code Error"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_zip}: Project ZIP Code"
    alpha_sort: no
    allow_fill: no
    type: string
    case: {
      when: {
        sql: ${sites.ref_agency} IS Null;;
        label: "No site connected to program"
      }
      when: {
        sql: ${programs.zip} IS Null;;
        label: "Null"
      }
      when: {
        sql: LENGTH(${programs.zip}) < 5 ;;
        label: "ZIP Code is too short"
      }
      when: {
        sql: LENGTH(${programs.zip}) > 5 ;;
        label: "ZIP Code is too long"
      }
      when: {
        sql: ${programs.zip} = ""
            AND LENGTH(${programs.zip}) > 0;;
        label: "ZIP Code contains only white-space"
      }
      when: {
        sql: ${programs.zip} REGEXP '^[a-z]' ;;
        label: "ZIP Code contains letters"
      }
      else: "None"
    }
  }

  measure: coc_code_error_count {
    view_label: "DQ Project Descriptor"
    label: "CoC Code Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_project_coc}: CoC Code"
    type: count_distinct
    filters: {
      field: coc_code_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_code_error]
    sql: ${id} ;;
  }

  measure: coc_geocode_error_count {
    view_label: "DQ Project Descriptor"
    label: "Geocode Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_geocode}: Geocode"
    type: count_distinct
    filters: {
      field: coc_geocode_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_geocode_error]
    sql: ${id} ;;
  }

  measure: coc_address_error_count {
    view_label: "DQ Project Descriptor"
    label: "Address Line 1 Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_address}: Project Street Address 1"
    type: count_distinct
    filters: {
      field: coc_address_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_address_error]
    sql: ${id} ;;
  }

  measure: coc_address_2_error_count {
    view_label: "DQ Project Descriptor"
    label: "Address Line 2 Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_address_2}: Project Street Address 2"
    type: count_distinct
    filters: {
      field: coc_address_2_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_address_2_error]
    sql: ${id} ;;
  }

  measure: coc_city_error_count {
    view_label: "DQ Project Descriptor"
    label: "City Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_city}: Project City"
    type: count_distinct
    filters: {
      field: coc_city_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_city_error]
    sql: ${id} ;;
  }

  measure: coc_geography_type_error_count {
    view_label: "DQ Project Descriptor"
    label: "Geography Type Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_geography_type}: Geography Type"
    type: count_distinct
    filters: {
      field: coc_geography_type_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_geography_type_error]
    sql: ${id} ;;
  }

  measure: coc_state_error_count {
    view_label: "DQ Project Descriptor"
    label: "State Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_state}}: Project State"
    type: count_distinct
    filters: {
      field: coc_state_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_state_error]
    sql: ${id} ;;
  }

  measure: coc_zip_error_count {
    view_label: "DQ Project Descriptor"
    label: "ZIP Code Error Count"
    group_label: "CoC Information"
    description: "Error in @{hmis_ref_num_zip}: Project ZIP Code"
    type: count_distinct
    filters: {
      field: coc_zip_error
      value: "-None"
    }
    drill_fields: [dq_project_descriptor_drills*, coc_zip_error]
    sql: ${id} ;;
  }
}
