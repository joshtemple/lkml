view: dq_services {

  sql_table_name: service_items ;;

  dimension: service_name {
    hidden: yes
    sql: ${services.name} ;;
  }

  dimension: service_date_id {
    view_label: "Client Services"
    label: "Service Date Id"
    sql: ${service_dates.id} ;;
  }

  dimension: service_date {
    view_label: "Client Services"
    label: "Attendance Service Date"
    description:  "Date service was provided for 'Daily Attendance' or 'Multi-Attendance' services"
    sql: DATE(CASE WHEN ${TABLE}.ref_delivery_type IN (2, 3)
              THEN ${service_dates.date_date}
              ELSE NULL
              END
          );;
  }

  dimension: service_date_error {
    view_label: "DQ Service"
    label: "Service Date Error"
    allow_fill: no
    case: {
      when: {
        sql:  ${service_date} < ${dq_client_programs.start_date};;
        label: "Service Provided before Program Start Date"
      }
      when: {
        sql:  ${service_date} > ${dq_client_programs.end_date};;
        label: "Service Provided after Program End Date"
      }
      else: "None"
    }
  }

  # 4.12.2A and B [Service: Contact Location Error] and 4.12.2B [Service: Contact Setting Error]
  dimension: contact_location_error {
    view_label: "DQ Service"
    label: "Contact Error"
    description: "Error in HMIS Element 4.12: Contact"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: (${services.raw_ref_category} = 2160 AND ${TABLE}.si_cat1 < 1000
             OR ${services.raw_ref_category} = 6)

             AND (${dq_project_descriptor.ref_category} IN (4, 6)
                  OR ${dq_project_descriptor.tracking_method_raw} = 3)
             AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
             AND ${TABLE}.si_cat1 IS NULL;;
        label: "Contact -- Staying on Streets ES or SH is null"
      }
      when: {
        # Legacy
        sql: (${services.raw_ref_category} = 2160 AND ${TABLE}.si_cat1 < 1000

                                 AND (${dq_project_descriptor.ref_category} IN (4, 6)
                                      OR ${dq_project_descriptor.tracking_method_raw} = 3)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat1 NOT IN (0, 1, 2, 4);;
        label: "Contact Location Selection is invalid"
      }
      when: {
        # Current
        sql: ${services.raw_ref_category} = 6

                                 AND (${dq_project_descriptor.ref_category} IN (4, 6)
                                      OR ${dq_project_descriptor.tracking_method_raw} = 3)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat1 NOT IN (1, 2, 3);;
        label: "Contact Location Selection is invalid"
      }
      # Should add check for Engagement record without corresponding Contact
      # Checking for valid HMIS codes is not possible, given Services schema is non-HMIS
      else: "None"
    }
  }

  # P1  [Service: Services Provided - PATH Record Type Error]
  dimension: path_services_provided_error {
    view_label: "DQ Service"
    label: "PATH Services Provided Error"
    description: "Error in HMIS Element P1: Services Provided"
    alpha_sort: yes

    allow_fill: no
    case: {

      when: {
        sql: ${services.raw_ref_category} = 2160 AND ${TABLE}.si_cat1 < 1000

                                 AND ${dq_project_descriptor.ref_category} IN (4, 6)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat1 NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14);;
        label: "Service Type Selection is invalid"
      }
      else: "None"
    }
  }

  # P2.2  [Service: Referrals Provided - PATH Record Type Error]
  dimension: path_referrals_provided_error {
    view_label: "DQ Service"
    label: "PATH Referrals Provided Error"
    description: "Error in HMIS Element P2: Referrals Provided"
    alpha_sort: yes

    allow_fill: no
    case: {
      # Check below is useless, as si_cat1 is used to identify where to apply check.
      when: {
        sql: ${services.raw_ref_category} = 2100 AND ${TABLE}.si_cat1 = 2000

                                 AND ${dq_project_descriptor.ref_category} IN (4, 6)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat2 IS NULL;;
        label: "Referral Type Provided is null"
      }
      when: {
        sql: ${services.raw_ref_category} = 2100 AND ${TABLE}.si_cat1 = 2000

                                 AND ${dq_project_descriptor.ref_category} IN (4, 6)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat2 NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);;
        label: "Referral Type Selection is invalid"
      }
      when: {
        sql: ${services.raw_ref_category} = 2100 AND ${TABLE}.si_cat1 = 2000

                                           AND ${dq_project_descriptor.ref_category} IN (4, 6)
                                           AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                           AND ${TABLE}.si_cat3 IS NULL;;
        label: "Attainment Type is null"
      }
      when: {
        sql: ${services.raw_ref_category} = 2100 AND ${TABLE}.si_cat1 = 2000

                                           AND ${dq_project_descriptor.ref_category} IN (4, 6)
                                           AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                           AND ${TABLE}.si_cat3 NOT IN (1, 2, 3);;
        label: "Attainment Type Selection is invalid"
      }
      else: "None"
    }
  }

  # W1.2  [Service: Services Provided - HOPWA Record Type Error]
  dimension: hopwa_services_provided_error {
    view_label: "DQ Service"
    label: "HOPWA Services Provided Error"
    description: "Error in @{hmis_ref_num_hopwa_service_type}: Services Provided"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: ${services.raw_ref_category} = 2500 AND ${TABLE}.si_cat1 < 1000

                                   AND ${dq_project_descriptor.ref_category} IN (1, 2, 3, 6, 12)
                                   AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                   AND ${TABLE}.si_cat1 NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14);;
        label: "Services Provided Type Selection is invalid"
      }
      else: "None"
    }
  }

  # W2  [Service: Financial Assistance - HOPWA Record Type Error]
  dimension: hopwa_financial_assistance_error {
    view_label: "DQ Service"
    label: "HOPWA Financial Assistance Error"
    description: "Error in HMIS Element W2: Financial Assistance"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: ${services.raw_ref_category} = 2500 AND ${TABLE}.si_cat1 = 3000

                                 AND ${program_funding_sources.funding_source_code} IN (15, 16, 17)
                                 AND ${dq_project_descriptor.ref_category} IN (6, 12)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat2 IS NULL;;
        label: "Is null"
      }
      #   HUD:  HOPWA – Permanent Housing Placement
      when: {
        sql: ${services.raw_ref_category} = 2500 AND ${TABLE}.si_cat1 = 3000

                                 AND ${program_funding_sources.funding_source_code} = 16
                                 AND ${dq_project_descriptor.ref_category} IN (6, 12)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat2 NOT IN (1, 2, 3, 4, 7);;
        label: "HOPWA – Permanent Housing Placement Financial Assistance selection is invalid"
      }
      #   HUD:  HOPWA – Short-Term Rent, Mortgage, Utility assistance
      when: {
        sql: ${services.raw_ref_category} = 2500 AND ${TABLE}.si_cat1 = 3000

                                 AND ${program_funding_sources.funding_source_code} = 17
                                 AND ${dq_project_descriptor.ref_category} IN (6, 12)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat2 NOT IN (1, 4, 7);;
        label: "HOPWA – Short-Term Rent, Mortgage, Utility assistance selection is invalid"
      }
      # HOPWA – Permanent Housing (facility based or TBRA)
      when: {
        sql: ${services.raw_ref_category} = 2500 AND ${TABLE}.si_cat1 = 3000

                                 AND ${program_funding_sources.funding_source_code} = 15
                                 AND ${dq_project_descriptor.ref_category} IN (3)
                                 AND (${data_quality.age} >= 18 OR ${dq_client_program_demographics.raw_relationship_to_hoh} = 1)
                                 AND ${TABLE}.si_cat2 <> 1;;
        label: "HOPWA – Permanent Housing (facility based or TBRA) selection is invalid"
      }
      else: "None"
    }
  }

  # V2.2  [Service: Services Provided - SSVF Record Type Error]
  dimension: ssvf_services_provided_error {
    view_label: "DQ Service"
    label: "SSVF Services Provided Error"
    description: "Error in @{hmis_ref_num_ssvf_services_type}: Services Provided"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: ${services.raw_ref_category} = 2700 AND ${TABLE}.si_cat1 < 1000

                                 AND ${program_funding_sources.funding_source_code} = 33
                                 AND ${dq_project_descriptor.ref_category} IN (12, 13)
                                 AND ${TABLE}.si_cat1 NOT IN (1, 2, 3, 4, 5, 6);;
        label: "SSVF Services Provided selection is invalid"
      }
      # V2.A Assistance obtaining VA benefits
      when: {
        sql: ${services.raw_ref_category} = 2700 AND ${TABLE}.si_cat1 < 1000

                                 AND ${program_funding_sources.funding_source_code} = 33
                                 AND ${dq_project_descriptor.ref_category} IN (12, 13)
                                 AND ${TABLE}.si_cat1 IN (1, 2, 3, 4, 5, 6)
                                 AND ${TABLE}.si_cat2 NOT IN (1, 2, 3, 4);;
        label: "SSVF Services Provided: Assistance obtaining VA benefits selection is invalid"
      }
      # V2.B Assistance obtaining / coordinating other public benefits
      when: {
        sql: ${services.raw_ref_category} = 2700 AND ${TABLE}.si_cat1 < 1000

                                 AND ${program_funding_sources.funding_source_code} = 33
                                 AND ${dq_project_descriptor.ref_category} IN (12, 13)
                                 AND ${TABLE}.si_cat1 IN (1, 2, 3, 4, 5, 6)
                                 AND ${TABLE}.si_cat2 NOT IN (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13);;
        label: "SSVF Services Provided: Assistance obtaining / coordinating other public benefits selection is invalid"
      }
      # V2.C Direct provision of other public benefits
      when: {
        sql: ${services.raw_ref_category} = 2700 AND ${TABLE}.si_cat1 < 1000

                                 AND ${program_funding_sources.funding_source_code} = 33
                                 AND ${dq_project_descriptor.ref_category} IN (12, 13)
                                 AND ${TABLE}.si_cat1 IN (1, 2, 3, 4, 5, 6)
                                 AND ${TABLE}.si_cat2 NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);;
        label: "SSVF Services Provided: Direct provision of other public benefits selection is invalid"
      }
      else: "None"
    }
  }

  # V3.2  [Service: Financial Assistance - SSVF Record Type Error]
  dimension: ssvf_services_financial_assistance_error {
    view_label: "DQ Service"
    label: "SSVF Services Financial Assistance Error"
    description: "Error in @{hmis_ref_num_ssvf_financial_assistance_amount}: Financial Assistance"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: ${services.raw_ref_category} = 2700 AND ${TABLE}.si_cat1 < 1000

                                 AND ${program_funding_sources.funding_source_code} = 33
                                 AND ${dq_project_descriptor.ref_category} IN (12, 13)
                                 AND ${TABLE}.si_cat1 IS NULL;;
        label: "Is null"
      }
      when: {
        sql: ${services.raw_ref_category} = 2700 AND ${TABLE}.si_cat1 < 1000

                                 AND ${program_funding_sources.funding_source_code} = 33
                                 AND ${dq_project_descriptor.ref_category} IN (12, 13)
                                 AND ${TABLE}.si_cat2 NOT IN (1, 2, 3, 4, 5, 8, 9, 10, 11, 12, 14);;
        label: "SSVF Services Provided selection is invalid"
      }
      else: "None"
    }
  }

  # V8.2  [Service: HUD-VASH Voucher Tracking Record Type Error]
  dimension: hud_vash_voucher_tracking_error {
    view_label: "DQ Service"
    label: "HUD-VASH Voucher Tracking Record Type Error"
    description: "Error in @{hmis_ref_num_vash_voucher_change}: Financial Assistance"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql: ${services.raw_ref_category} = 2800

                                 AND ${program_funding_sources.funding_source_code} = 20
                                 AND ${dq_project_descriptor.ref_category} = 3
                                 AND ${TABLE}.si_cat2 IS NULL;;
        label: "Is null"
      }
      when: {
        sql: ${services.raw_ref_category} = 2800

                                AND ${program_funding_sources.funding_source_code} = 20
                                AND ${dq_project_descriptor.ref_category} = 3
                                AND ${TABLE}.si_cat2 NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);;
        label: "HUD-VASH Voucher Tracking selection is invalid"
      }
      # Missing OtherTypeProvided case
      else: "None"
    }
  }


  # P1  [Service: Services Provided - PATH Record Type Error]
  measure: path_services_provided_error_count {
    view_label: "DQ Service"
    label: "PATH Services Provided Error Count"
    description: "Count of errors in P1 : Service: Services Provided - PATH Record Type Error"
    type: count_distinct
    sql: CASE WHEN ${dq_services.path_services_provided_error} != 'None'
            THEN ${client_services.id}
            ELSE NULL
            END;;
  }

  # P2.2  [Service: Referrals Provided - PATH Record Type Error]
  measure: path_referrals_provided_error_count {
    view_label: "DQ Service"
    label: "PATH Referrals Provided Error Count"
    description: "Count of errors in P2.2 : Service: Referrals Provided - PATH Record Type Error"
    type: count_distinct
    sql: CASE WHEN ${dq_services.path_referrals_provided_error} != 'None'
            THEN ${client_services.id}
            ELSE NULL
            END;;
  }

  # W1.2  [Service: Services Provided - HOPWA Record Type Error]
  measure: hopwa_services_provided_error_count {
    view_label: "DQ Service"
    label: "HOPWA Services Provided Error Count"
    description: "Count of Errors in @{hmis_ref_num_hopwa_service_type}: Services Provided"
    type: count_distinct
    sql: CASE WHEN ${dq_services.hopwa_services_provided_error} != 'None'
              THEN ${client_services.id}
              ELSE NULL
              END;;
  }

  # W2  [Service: Financial Assistance - HOPWA Record Type Error]
  measure: hopwa_financial_assistance_error_count {
    view_label: "DQ Service"
    label: "HOPWA Financial Assistance Error Count"
    description: "Count of Errors in HMIS Element W2: Financial Assistance"
    type: count_distinct
    sql: CASE WHEN ${dq_services.hopwa_financial_assistance_error} != 'None'
      THEN ${client_services.id}
      ELSE NULL
      END;;
  }

  # V2.2  [Service: Services Provided - SSVF Record Type Error]
  measure: ssvf_services_provided_error_count {
    view_label: "DQ Service"
    label: "SSVF Services Provided Error Count"
    description: "Count of Error in @{hmis_ref_num_ssvf_services_type}: Services Provided"
    type: count_distinct
    sql: CASE WHEN ${dq_services.ssvf_services_provided_error} != 'None'
          THEN ${client_services.id}
          ELSE NULL
          END;;
  }

  # V3.2  [Service: Financial Assistance - SSVF Record Type Error]
  measure: ssvf_services_financial_assistance_error_count {
    view_label: "DQ Service"
    label: "SSVF Services Financial Assistance"
    description: "Error in @{hmis_ref_num_ssvf_financial_assistance_amount}: Financial Assistance"
    type: count_distinct
    sql: CASE WHEN ${dq_services.ssvf_services_financial_assistance_error} != 'None'
          THEN ${client_services.id}
          ELSE NULL
          END;;
  }

  # V8.2  [Service: HUD-VASH Voucher Tracking Record Type Error]
  measure: hud_vash_voucher_tracking_error_count {
    view_label: "DQ Service"
    label: "HUD-VASH Voucher Tracking Record Type Error"
    description: "Error in @{hmis_ref_num_vash_voucher_change}: Financial Assistance"
    type: count_distinct
    sql: CASE WHEN ${dq_services.hud_vash_voucher_tracking_error} != 'None'
                THEN ${client_services.id}
                ELSE NULL
                END;;
  }

  dimension: type_provided {
    view_label: "Service Items"
  }

  dimension: id {
    view_label: "Service Items"
  }

  dimension: end_availability {
    hidden: yes
    sql: ${TABLE}.end_availability ;;
  }

  dimension: ref_delivery_type {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_delivery_type ;;
  }

  dimension: deleted {
    hidden: yes
    type: yesno
    sql: ${TABLE}.deleted ;;
  }

  dimension: ref_service {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_service ;;
  }

  dimension: start_availability {
    hidden: yes
    sql: ${TABLE}.start_availability ;;
  }

  dimension: record_type {
    view_label: "Service Items"
  }

  dimension: hmis_record_type_text {
    view_label: "Service Items"
  }


  dimension: service_item_name {
    view_label: "Service Items"
  }

  dimension: type_provided_text {
    view_label: "Service Items"
  }

  dimension: service_subtype_provided {
    view_label: "Service Items"
  }

  dimension: service_subtype_provided_text {
    view_label: "Service Items"
  }

  dimension: service_referral_provided {
    view_label: "Service Items"
  }

  dimension: service_referral_provided_text {
    view_label: "Service Items"
  }

  dimension: raw_service_record_type {
    view_label: "Service Items"
    hidden: yes
  }

  dimension: raw_record_type {
    view_label: "Service Items"
    hidden: yes
  }

  dimension: raw_service_subtype_provided {
    view_label: "Service Items"
    hidden: yes
  }

  dimension: raw_service_referral_provided {
    view_label: "Service Items"
    hidden: yes
  }

  dimension: charge_attendance {
    view_label: "Service Items"
  }

  dimension: default_amount {
    view_label: "Service Items"
  }

  dimension: adjustable {
    view_label: "Service Items"
  }

  dimension: ref_funding {
    label: "Funding"
    view_label: "Service Items"
  }


  dimension: client_last_service {
    view_label: "Service Items"
  }

  dimension: client_last_system_service {
    view_label: "Service Items"
  }

}
