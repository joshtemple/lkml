connection: "bi"

include: "*.dashboard.lookml"  # include all dashboards in this project
include: "location_dimensions.view.lkml"
include: "survey_responses_flat.view.lkml"
include: "survey_response_facts.view.lkml"
include: "patient_facts.view.lkml"
include: "thr_market_share.view.lkml"
include: "car_dimensions.view.lkml"
include: "nw_zipcodes.view.lkml"
include: "athenadwh_procedure_codes.view.lkml"
include: "market_start_date_bi.view.lkml"
include: "tampa_combined.view.lkml"
include: "icd_code_dimensions.view.lkml"
include: "incontact.view.lkml"
include: "mh_full_risk.view.lkml"
include: "capacity_model_processed.view.lkml"
include: "provider_letters.view.lkml"
include: "phx_heatmap.view.lkml"
include: "athenadwh_payers.view.lkml"
include: "propensity_atl.view.lkml"
include: "dallas_new_service.view.lkml"
include: "az_zipcodes.view.lkml"
include: "dates_hours_reference.view.lkml"
include: "texas_childrens_hospital.view.lkml"
include: "productivity_data.view.lkml"
include: "mh_market_share.view.lkml"
include: "ed_diversion_survey_response_rate.view.lkml"
include: "optum_uhc_atl.view.lkml"
include: "app_shift_summary_facts.view.lkml"
include: "bcbs.view.lkml"
include: "visit_facts.view.lkml"
include: "channel_start_date.view.lkml"
include: "athenadwh_patient_insurances.view.lkml"
include: "athenadwh_documents.view.lkml"
include: "csc_shift_planning_facts.view.lkml"
include: "patient_dimensions.view.lkml"
include: "diagnosis_rank.view.lkml"
include: "facility_type_dimensions.view.lkml"
include: "phx_expanded_zips.view.lkml"
include: "athenadwh_clinical_providers.view.lkml"
include: "risk_assessments_bi.view.lkml"
include: "thr_hospitals_zip.view.lkml"
include: "athenadwh_patients.view.lkml"
include: "optumcare.view.lkml"
include: "optum_zips.view.lkml"
include: "ds_memeber_count.view.lkml"
include: "cpt_em_references.view.lkml"
include: "question_dimensions.view.lkml"
include: "athenadwh_clinical_letters.view.lkml"
include: "market_dimensions.view.lkml"
include: "predicted_on_scene_time.view.lkml"
include: "maricopa.view.lkml"
include: "aetna_uhc_ma.view.lkml"
include: "subtotal_over.view.lkml"
include: "primary_payer_dimension_charge.view.lkml"
include: "spr_zips.view.lkml"
include: "respondent_dimensions.view.lkml"
include: "mh_combined.view.lkml"
include: "icd_visit_joins.view.lkml"
include: "cpt_code_dimensions.view.lkml"
include: "payer_dimensions.view.lkml"
include: "visit_dimensions.view.lkml"
include: "zip_to_zcta.view.lkml"
include: "athena_encounter_claims.view.lkml"
include: "letter_recipient_dimensions.view.lkml"
include: "mh_partial_risk.view.lkml"
include: "transaction_facts.view.lkml"
include: "nc_dx_data.view.lkml"
include: "thr_summarized.view.lkml"
include: "njr_risk_new.view.lkml"
include: "zipcodes_ed_average.view.lkml"
include: "budget_projections_by_market.view.lkml"
include: "tampa_wellmed_optum.view.lkml"
include: "athenadwh_clinical_encounters.view.lkml"
include: "primary_payer_dimensions.view.lkml"
include: "invoca.view.lkml"
include: "shift_planning_shifts.view.lkml"
include: "southwire.view.lkml"
include: "bgbsa.view.lkml"
include: "optum_new.view.lkml"
include: "risk_assessments.view.lkml"
include: "provider_dimensions.view.lkml"
include: "request_type_dimensions.view.lkml"
include: "athenadwh_transactions.view.lkml"
include: "pcp_dimensions.view.lkml"
include: "bs_risk.view.lkml"
include: "indianapolis_combined.view.lkml"
include: "shift_planning_facts.view.lkml"
include: "directmail_zipcode.view.lkml"
include: "channel_dimensions.view.lkml"
include: "tacoma_mssp.view.lkml"
include: "ed_diversion_survey_response.view.lkml"
include: "ut_membership.view.lkml"
include: "uhc_hotspot.view.lkml"
include: "hartford_zips.view.lkml"

explore: visit_facts {

  access_filter: {
    field: market_dimensions.market_name
    user_attribute: "market_name"
  }

  join: market_dimensions {
    relationship: many_to_one
    sql_on: ${market_dimensions.id} = ${visit_facts.market_dim_id} ;;
  }

  join: channel_dimensions {
    relationship: many_to_one
    sql_on: ${channel_dimensions.id} = ${visit_facts.channel_dim_id} ;;
  }

  join: subtotal_over {
    relationship: many_to_one
    type: cross
  }

  join: request_type_dimensions {
    relationship: many_to_one
    sql_on: ${request_type_dimensions.id} = ${visit_facts.request_type_dim_id} ;;
  }

  join: visit_dimensions {
    relationship: many_to_one
    sql_on: ${visit_dimensions.care_request_id} = ${visit_facts.care_request_id} ;;
  }

  join: productivity_data {
    relationship: many_to_one
    sql_on: DATE(${visit_dimensions.local_visit_date}) = DATE(${productivity_data.date_date}) AND ${visit_facts.market_dim_id} = ${productivity_data.market_dim_id} ;;
  }

  join: predicted_on_scene_time {
    relationship: many_to_one
    sql_on: ${predicted_on_scene_time.care_request_id} = ${visit_facts.care_request_id} ;;
  }

  join: car_dimensions {
    relationship: many_to_one
    sql_on: ${car_dimensions.id} = ${visit_facts.car_dim_id} ;;
  }

  join: ed_diversion_survey_response_rate {
    relationship: many_to_one
    sql_on: ${ed_diversion_survey_response_rate.market_dim_id} = ${visit_facts.market_dim_id} ;;
  }

  join: survey_responses_flat {
    relationship: one_to_one
    sql_on: ${survey_responses_flat.visit_dim_number} = ${visit_facts.visit_dim_number};;
  }

  join: survey_response_facts {
    relationship: one_to_one
    # change association to be the care request id instead of visit number - DH
    sql_on: ${survey_response_facts.visit_dim_number} = ${visit_facts.visit_dim_number}
    AND ${survey_response_facts.question_dim_id} = 4
    AND ${survey_response_facts.answer_range_value} IS NOT NULL ;;
  }

  join: question_dimensions {
    relationship: many_to_one
    sql_on: ${survey_response_facts.question_dim_id} = ${question_dimensions.id} ;;
  }

  join: ed_diversion_survey_response {
    relationship: many_to_one
    sql_on: ${ed_diversion_survey_response.visit_dim_number} = ${visit_facts.visit_dim_number} ;;
  }

  join: app_shift_summary_facts {
    relationship: many_to_one
    # change association to be the visit dimension local visit month from visit facts local requested month - DH
    sql_on: ${app_shift_summary_facts.start_of_month_month} = ${visit_dimensions.local_visit_month};;
  }

  join: provider_dimensions {
    relationship: many_to_one
    sql_on: ${provider_dimensions.id} = ${visit_facts.provider_dim_id};;
  }

  join: app_shift_planning_facts {
    from: shift_planning_facts
    type: inner
    relationship: many_to_one
    sql_on:(${app_shift_planning_facts.employee_name} = ${provider_dimensions.shift_app_name}
          and date(${app_shift_planning_facts.local_actual_start_time})=date(${visit_dimensions.local_visit_date})
          and ${app_shift_planning_facts.schedule_role} in('NP/PA', 'Training / Admin COS', 'Training/Admin', 'Training/Admin COR', 'Training/Admin DEN', 'Training/Admin HOU', 'Training/Admin LAS', 'Training/Admin OKC', 'Training/Admin PHX', 'Training/Admin RIC'))
          or (
          ${visit_facts.nppa_shift_id} = ${app_shift_planning_facts.shift_id} and date(${app_shift_planning_facts.local_actual_start_time})=date(${visit_dimensions.local_visit_date})
          )

      ;;
  }

  join: csc_shift_planning_facts {
    from: shift_planning_facts
    relationship: many_to_one
    sql_on: ${visit_facts.csc_shift_id} = ${csc_shift_planning_facts.shift_id}
      and ${csc_shift_planning_facts.schedule_role} LIKE '%CSC%' ;;
  }

  join: risk_assessments_bi {
    from: risk_assessments_bi
    relationship: one_to_one
    sql_on: ${visit_facts.care_request_id} = ${risk_assessments_bi.care_request_id} AND ${risk_assessments_bi.protocol_name} IS NOT NULL;;
  }

  join: primary_payer_dimension_charge {
    sql_on: ${primary_payer_dimension_charge.visit_dim_number} = ${visit_facts.visit_dim_number} AND
            ${transaction_facts.voided_date} IS NULL ;;
  }

  join: transaction_facts {
    relationship: one_to_many
    sql_on: ${transaction_facts.visit_dim_number} = ${visit_dimensions.visit_number}  ;;
  }

  join: primary_payer_dimensions {
    relationship: many_to_one
    sql_on: ${transaction_facts.primary_payer_dim_id} = ${primary_payer_dimensions.id}  ;;
  }

  join: payer_dimensions {
    sql_on: ${transaction_facts.payer_dim_id} = ${payer_dimensions.id}  ;;
  }

  join: patient_dimensions {
    sql_on: ${visit_facts.patient_dim_id} = ${patient_dimensions.id}  ;;
  }

  join: patient_facts {
    sql_on: ${visit_dimensions.dashboard_patient_id} = ${patient_facts.dashboard_patient_id}  ;;
  }

  join: athenadwh_patient_insurances {
    relationship: one_to_many
    sql_on: ${patient_facts.athena_patient_id} = ${athenadwh_patient_insurances.patient_id}
            AND ${athenadwh_patient_insurances.insurance_package_id} != 0;;
  }

  join: athenadwh_payers {
    relationship: many_to_one
    sql_on: ${athenadwh_patient_insurances.insurance_package_id} = ${athenadwh_payers.insurance_package_id} ;;
  }

  join: pcp_dimensions {
    sql_on: ${patient_facts.pcp_dim_id} = ${pcp_dimensions.id}  ;;
  }

  join: budget_projections_by_market {
    relationship: many_to_one
    sql_on: ${visit_facts.market_dim_id} = ${budget_projections_by_market.market_dim_id}
            AND ${visit_dimensions.local_visit_month}=${budget_projections_by_market.month_month};;
  }

  join: budget_projections_by_market_future {
    from: budget_projections_by_market
    sql_on: ${market_dimensions.id} = ${budget_projections_by_market_future.market_dim_id};;
  }


  join: channel_start_date {
    sql_on: ${channel_start_date.market_dim_id} = ${visit_facts.market_dim_id}
            and  ${channel_start_date.channel_dim_id} = ${visit_facts.channel_dim_id} ;;

  }
  join:  capacity_model_processed {
    sql_on: ${market_dimensions.id} =  ${capacity_model_processed.market_dim_id}
            and ${channel_dimensions.id} = ${capacity_model_processed.channel_dim_id}
    ;;
    }


  join:  location_dimensions {
    sql_on: ${visit_facts.location_dim_id} =  ${location_dimensions.id}
    ;;
  }

  join: cpt_code_dimensions {
    relationship: one_to_many
    sql_on: ${cpt_code_dimensions.id} = ${transaction_facts.cpt_code_dim_id} ;;
  }

  join: cpt_em_references {
    sql_on: ${cpt_code_dimensions.cpt_code} = ${cpt_em_references.cpt_code} ;;
  }

  join: athena_encounter_claims {
    sql_on: ${athena_encounter_claims.appointment_id} = ${visit_facts.visit_dim_number} ;;
  }

  join: facility_type_dimensions {
    sql_on: ${visit_facts.facility_type_dim_id} = ${facility_type_dimensions.id} ;;
  }

  join: icd_code_dimensions {
    sql_on: ${icd_visit_joins.icd_dim_id} = ${icd_code_dimensions.id} ;;
  }

  join: diagnosis_rank {
    sql_on: ${icd_code_dimensions.code_and_desc} = ${diagnosis_rank.c_and_d} ;;
  }

  join: icd_visit_joins {
    sql_on: ${transaction_facts.visit_dim_number} = ${icd_visit_joins.visit_dim_number} ;;
  }

  join: respondent_dimensions {
    sql_on: ${survey_response_facts.respondent_dim_id} = ${respondent_dimensions.id} ;;
  }

  join: letter_recipient_dimensions {
    type: left_outer
    relationship:  many_to_one
    sql_on: ${visit_facts.letter_recipient_dim_id} = ${letter_recipient_dimensions.id} ;;
  }

  join: athenadwh_clinical_encounters {
    relationship:  one_to_many
    sql_on: ${patient_facts.athena_patient_id} = ${athenadwh_clinical_encounters.patient_id} AND
            ${athenadwh_clinical_encounters.appointment_id} = ${visit_facts.visit_dim_number};;
  }

  join: athenadwh_documents {
    relationship:  many_to_one
    sql_on:  ${athenadwh_documents.clinical_encounter_id} = ${athenadwh_clinical_encounters.clinical_encounter_id} AND
            ((${athenadwh_documents.document_class} = 'PRESCRIPTION' AND ${athenadwh_documents.deleted_datetime} IS NULL) OR
            (${athenadwh_documents.document_class} = 'LETTER' AND
            (${athenadwh_documents.document_subclass} != 'LETTER_PATIENTCORRESPONDENCE' OR ${athenadwh_documents.document_subclass} IS NULL)) OR
            (${athenadwh_documents.document_class} = 'ENCOUNTERDOCUMENT')) ;;
  }

  join: athenadwh_clinical_letters {
    relationship:  one_to_one
    sql_on: ${athenadwh_clinical_letters.document_id} = ${athenadwh_documents.document_id} ;;
  }

  join: athenadwh_clinical_providers {
    relationship:  one_to_many
    sql_on: ${athenadwh_clinical_providers.clinical_provider_id} = ${athenadwh_clinical_letters.clinical_provider_recipient_id} ;;
  }

  join: athenadwh_patients {
    relationship:  one_to_many
    sql_on: ${athenadwh_patients.patient_id} = ${athenadwh_clinical_encounters.patient_id} ;;
  }

  join: athenadwh_procedure_codes {
    relationship: one_to_one
    sql_on: ${athenadwh_procedure_codes.procedure_code} = ${cpt_code_dimensions.cpt_code} AND
            ${athenadwh_procedure_codes.deleted_datetime_raw} IS NULL ;;
  }

  join: athenadwh_transactions {
    relationship: many_to_one
    sql_on: ${athenadwh_transactions.claim_id} = ${athena_encounter_claims.claim_id} ;;
  }

}

explore: incontact {

  join: invoca {
    sql_on: abs(TIME_TO_SEC(TIMEDIFF(${incontact.end_time_raw}, (addtime(${invoca.start_time_raw}, ${invoca.total_duration}))))) < 15 and
             abs(TIME_TO_SEC(TIMEDIFF(${incontact.start_time_raw}, ${invoca.start_time_raw})))<15
             and ${invoca.caller_id} like  CONCAT('%', ${incontact.from_number} ,'%')
          ;;

    }

}

explore: ds_memeber_count {

}
explore: optumcare {
}

explore: provider_letters {
}

explore: maricopa {
}

explore: optum_zips {
}

explore: optum_new{
}

explore: bcbs {
}

explore: mh_full_risk {

}

explore: mh_combined {

}

explore: mh_partial_risk {

}

explore: mh_market_share {
}

explore: thr_market_share {
}

explore: phx_heatmap {
}


explore: bgbsa {
}

explore: southwire {
}

explore: directmail_zipcode {
}
  explore: invoca {


      join: incontact {
        sql_on: abs(TIME_TO_SEC(TIMEDIFF(${incontact.end_time}, (addtime(${invoca.start_time_raw}, ${invoca.total_duration}))))) < 3
                and ${incontact.from_number} like  CONCAT('%', ${invoca.caller_id} ,'%')
          ;;

        }
  }

explore: productivity_data {
  join: market_dimensions {
    relationship: many_to_one
    sql_on: ${productivity_data.market_dim_id} = ${market_dimensions.id}
          ;;
    }
  join: market_start_date_bi {
    relationship: one_to_one
    sql_on: ${market_start_date_bi.market_dim_id} = ${market_dimensions.id};;
  }

  }

explore: shift_planning_shifts {
  join: shift_planning_facts {
    sql_on:  ${shift_planning_facts.shift_id}=${shift_planning_shifts.shift_id} and ${shift_planning_shifts.imported_after_shift}=1 ;;
  }

  join: market_dimensions {
    sql_on:  ${market_dimensions.id}=${shift_planning_shifts.market_dim_id};;
  }

  join:  budget_projections_by_market{
    sql_on:   ${shift_planning_facts.local_expected_end_month}=${budget_projections_by_market.month_month}
    and ${budget_projections_by_market.market_dim_id}=${shift_planning_shifts.market_dim_id};;
  }

  join: car_dimensions {
    sql_on: ${shift_planning_facts.car_dim_id} = ${car_dimensions.id} ;;
  }

}

explore: risk_assessments {

  join: visit_facts {
    relationship: one_to_one
    sql_on: ${visit_facts.care_request_id} = ${risk_assessments.care_request_id} ;;
  }

  join: visit_dimensions {
    relationship: one_to_one
    sql_on: ${visit_dimensions.care_request_id} = ${risk_assessments.care_request_id} ;;
  }

  join: market_dimensions {
    relationship: many_to_one
    sql_on: ${visit_facts.market_dim_id} = ${market_dimensions.id} ;;
  }

  join: channel_dimensions {
    relationship: many_to_one
    sql_on: ${visit_facts.channel_dim_id} = ${channel_dimensions.id} ;;
  }

  join: csc_shift_planning_facts {
    from: shift_planning_facts
    relationship: many_to_one
    sql_on: ${visit_facts.csc_shift_id} = ${csc_shift_planning_facts.shift_id}
      and ${csc_shift_planning_facts.schedule_role} LIKE '%CSC%' ;;
  }

}



explore: dates_hours_reference {

  join: shift_planning_facts {
    type: left_outer
    relationship: one_to_many
    sql_on:  (${dates_hours_reference.datehour_raw} >= ${shift_planning_facts.local_actual_start_raw}
            AND ${dates_hours_reference.datehour_raw} <= ${shift_planning_facts.local_actual_end_raw}
            AND (${shift_planning_facts.schedule_role} = 'NP/PA' OR ${shift_planning_facts.schedule_role} = 'DHMT'));;
  }

  join: visit_facts {
    type: left_outer
    relationship: one_to_many
    sql_on:  (DATE(${visit_facts.local_on_scene_date}) = ${dates_hours_reference.datehour_date}
      AND HOUR(${visit_facts.local_on_scene_raw}) = ${dates_hours_reference.hour_of_day}
      AND ${visit_facts.nppa_shift_id} = ${shift_planning_facts.shift_id}) ;;
  }

  join: car_dimensions {
    relationship: many_to_one
    sql_on: ${shift_planning_facts.car_dim_id} = ${car_dimensions.id} ;;
  }

  join: market_dimensions {
    relationship: many_to_one
    sql_on: ${market_dimensions.humanity_id} = ${shift_planning_facts.schedule_location_id} ;;
  }

  join: visit_dimensions {
    relationship: many_to_one
    sql_on: ${visit_dimensions.care_request_id} = ${visit_facts.care_request_id} ;;
  }

  join: transaction_facts {
    relationship: one_to_many
    sql_on: ${transaction_facts.visit_dim_number} = ${visit_dimensions.visit_number}  ;;
  }

  join: primary_payer_dimensions {
    relationship: many_to_one
    sql_on: ${transaction_facts.primary_payer_dim_id} = ${primary_payer_dimensions.id}  ;;
  }

}

explore: az_zipcodes{

}
explore: phx_expanded_zips {

}

explore: spr_zips {

}
explore: dallas_new_service {}
explore: thr_summarized {}
explore: thr_hospitals_zip {}
explore: tacoma_mssp {

}
explore: aetna_uhc_ma {}
explore: bs_risk {}
explore: nw_zipcodes {}
explore: njr_risk_new {}
explore: optum_uhc_atl {
  join: zip_to_zcta {
    sql_on: ${optum_uhc_atl.zipcode}=${zip_to_zcta.zip_code} ;;
  }
  join: propensity_atl {
    sql_on:  ${optum_uhc_atl.zipcode}=${propensity_atl.zipcode} ;;
  }

}
explore: propensity_atl {}
explore: texas_childrens_hospital {}
explore: zipcodes_ed_average {}
explore: tampa_combined {
  sql_always_where: ${zipcode}!=33630 ;;
}

explore: indianapolis_combined{

}
explore: uhc_hotspot {}
explore: nc_dx_data {}
explore: ut_membership {}
explore: tampa_wellmed_optum {}
explore: hartford_zips {}
