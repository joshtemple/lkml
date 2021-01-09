connection: "googlebigquerystd"

# include all the views
include: "*.view"

datagroup: fhir_data_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hour"
}

persist_with: fhir_data_default_datagroup

explore: patient_1000_fh {
  label: "Patient Full History"

  sql_always_where: ${patient__name.use} = 'official' ;;

  join: patient__name {
    view_label: "Patient: Name"
    sql: left join unnest(${patient_1000_fh.name}) as patient__name ;;
    relationship: one_to_many
  }

  join: encounter_1000_fh {
    view_label: "Encounter"
    type: left_outer
    sql_on: ${encounter_1000_fh.subject}.patientid = ${patient_1000_fh.id};;
    relationship: many_to_one
  }

  join: encounter__type {
    view_label: "Encounter: Type"
    sql: left join unnest(${encounter_1000_fh.type}) as encounter__type ;;
    relationship: one_to_many
  }

  join: encounter__participant {
    view_label: "Encounter: Participant"
    sql: left join unnest(${encounter_1000_fh.participant}) as encounter__participant ;;
    relationship: one_to_many
  }

  join: encounter__diagnosis {
    view_label: "Encounter: Diagnosis"
    relationship: one_to_many
    sql: left join unnest(${encounter_1000_fh.diagnosis}) as encounter__diagnosis ;;
  }

  join: encounter__hospitalization__discharge_disposition__coding {
    view_label: "Encounter: Hospitalization Discharge"
    relationship: one_to_many
    sql: left join unnest(${encounter_1000_fh.hospitalization}.dischargedisposition.coding) as encounter__hospitalization__discharge_disposition__coding ;;
  }

#   join: encounter__hospitalization__discharge_disposition {
#     view_label: "Encounter: Hospitalization Discharge Disposition"
#     relationship: one_to_many
#     sql: left join unnest(${encounter__hospitalization.discharge_disposition}) as encounter__hospitalization__discharge_disposition  ;;
#   }
#
#   join: encounter__hospitalization__discharge_disposition__coding {
#     view_label: "Encounter: Hospitalization Discharge Disposition Coding"
#     relationship: one_to_many
#     sql: left join unnest(${encounter__hospitalization__discharge_disposition.coding}) as encounter__hospitalization__discharge_disposition__coding ;;
#   }

  join: encounter__reason {
    view_label: "Encounter: Reason"
    relationship: one_to_many
    sql: left join unnest(${encounter_1000_fh.reason}) as encounter__reason ;;
  }

  join: encounter__reason__coding {
    view_label: "Encounter: Reason Coding"
    relationship: one_to_many
    sql: left join unnest(${encounter__reason.coding}) as encounter__reason__coding ;;
  }

  join: condition_1000_fh {
    view_label: "Condition"
    type: left_outer
    sql_on: ${encounter_1000_fh.id} = ${condition_1000_fh.context}.encounterId ;;
    relationship: one_to_many
  }

#   join: condition__subject {
#     view_label: "Condition: Subject"
#     relationship: one_to_many
#     sql: left join unnest(${condition_100_fh.subject}) as condition__subject ;;
#   }

#   join: encounter__participant__individual {
#     view_label: "Encounter: Participant Individual"
#     sql: left join unnest(${encounter__participant.individual}) as encounter__participant__individual;;
#     relationship: one_to_many
#   }

  join: observation_1000_fh {
    view_label: "Observation"
    type: left_outer
    sql_on: ${observation_1000_fh.context}.encounterId = ${encounter_1000_fh.id}
            /*and ${observation_1000_fh.subject}.patientid = ${patient_1000_fh.id}*/;;
    relationship: one_to_many
  }

  join: observation__category {
    view_label: "Observation: Category"
    relationship: one_to_many
    sql: left join unnest(${observation_1000_fh.category}) as observation__category ;;
  }

  join: observation__category__coding {
    view_label: "Observation: Category Coding"
    relationship: one_to_many
    sql: left join unnest(${observation__category.coding}) as observation__category__coding;;
  }

  join: observation__code {
    view_label: "Observation: Code"
    relationship: one_to_many
    sql: left join unnest(${observation_1000_fh.code}) as observation__code ;;
  }

  join: observation__component {
    view_label: "Observation: Component"
    relationship: one_to_many
    sql: left join unnest(${observation_1000_fh.component}) as observation__component ;;
  }

  join: observation__code__coding {
    view_label: "Observation: Component Code Coding"
    relationship: one_to_many
    sql: left join unnest(${observation_1000_fh.code}.coding) as observation__code__coding  ;;
  }

  join: dt_condition_and_medication_link_rj {
    type: left_outer
    relationship: many_to_many
    sql_on: ${dt_condition_and_medication_link_rj.condition_id} = ${condition_1000_fh.id} ;;
  }

  join: medication_request_1000_fh {
    view_label: "Medication Request"
    type: left_outer
    relationship: many_to_many
    sql_on: ${medication_request_1000_fh.context}.encounterid = ${encounter_1000_fh.id}
            and ${dt_condition_and_medication_link_rj.medication_id} = ${medication_request_1000_fh.id};;
  }

  join: medication_request__dosage_instruction {
    view_label: "Medication Request: Instruction"
    relationship: one_to_many
    sql: left join unnest(${medication_request_1000_fh.dosage_instruction}) as medication_request__dosage_instruction ;;
  }

  join: medication_request__reason_reference {
    view_label: "Medication Request: Reason Reference"
    relationship: one_to_many
    sql: left join unnest(${medication_request_1000_fh.reason_reference}) as medication_request__reason_reference ;;
  }

  join: procedure_1000_fh {
    type: left_outer
    relationship: one_to_many
    sql_on: ${encounter_1000_fh.id} = ${procedure_1000_fh.context}.encounterid ;;
  }

  join: procedure__reason_reference {
    view_label: "Procedure: Reason Reference"
    relationship: one_to_many
    sql: left join unnest(${procedure_1000_fh.reason_reference}) as procedure__reason_reference  ;;
  }

  join: procedure__complication_detail {
    view_label: "Procedure: Complication"
    relationship: one_to_many
    sql: left join unnest(${procedure_1000_fh.complication_detail}) as procedure__complication_detail ;;
  }

  join: dt_patient_immunization_lookup_rj {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dt_patient_immunization_lookup_rj.patient_id} = ${patient_1000_fh.id} ;;
  }

  join: dt_immunization_schedules {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dt_immunization_schedules.vaccine_code} = ${dt_patient_immunization_lookup_rj.vaccine_code} ;;
  }

#   join: immunization_1000_fh {
#     view_label: "Immunization"
#     type: left_outer
#     relationship: one_to_many
#     sql_on: ${immunization_1000_fh.encounter}.encounterid = ${encounter_1000_fh.id} ;;
#   }
#
#   join: immunization__vaccine_code {
#     view_label: "Immunization: Vaccine Code"
#     relationship: one_to_many
#     sql: left join unnest(${immunization_1000_fh.vaccine_code}) as immunization__vaccine_code ;;
#   }
#
#   join: immunization__vaccine_code__coding {
#     view_label: "Immunization: Vaccine Code Coding"
#     relationship: one_to_many
#     sql: left join unnest(${immunization_1000_fh.vaccine_code}.coding) as immunization__vaccine_code__coding ;;
#   }
}

explore: procedure_1000_fh {
  label: "Procedure"

  hidden: yes

  join: procedure__reason_reference {
    view_label: "Procedure: Reason Reference"
    relationship: one_to_many
    sql: left join unnest(${procedure_1000_fh.reason_reference}) as procedure__reason_reference  ;;
  }

  join: procedure__complication_detail {
    view_label: "Procedure: Complication"
    relationship: one_to_many
    sql: left join unnest(${procedure_1000_fh.complication_detail}) as procedure__complication_detail ;;
  }

  join: condition_reason_for_procedure {
    from: condition_1000_fh
    view_label: "Condition: Reason for Procedure"
    type: left_outer
    relationship: many_to_many
    sql_on: ${condition_reason_for_procedure.id} = ${procedure__reason_reference.condition_id} ;;
  }

#  removing due to no data at this time
#   join: condition_procedure_complications {
#     from: condition_1000_fh
#     view_label: "Condition: Complication in Procedure"
#     type: left_outer
#     relationship: many_to_many
#     sql_on: ${condition_procedure_complications.id} = ${procedure__complication_detail.condition_id} ;;
#   }

  join: patient_1000_fh {
    view_label: "Patient"
    type: left_outer
    relationship: many_to_many
    sql_on: ${patient_1000_fh.id} = ${procedure_1000_fh.subject}.patientid;;
  }

  join: patient__name {
    view_label: "Patient: Name"
    sql: left join unnest(${patient_1000_fh.name}) as patient__name ;;
    relationship: one_to_many
  }
}

explore: dt_immunization_schedules {
  label: "Immunizations"

  hidden: yes

  join: immunization_1000_fh {
    type: full_outer
    relationship: one_to_many
    sql_on: ${immunization_1000_fh.vaccine_code}.text = ${dt_immunization_schedules.vaccine_text} ;;
  }

  join: encounter_1000_fh {
    type: full_outer
    relationship: many_to_one
    sql_on: ${immunization_1000_fh.encounter}.encounterid = ${encounter_1000_fh.id} ;;
  }

  join: patient_1000_fh {
    type: full_outer
    relationship: many_to_one
    sql_on: ${patient_1000_fh.id} = ${encounter_1000_fh.subject}.patientid;;
  }

  join: patient__name {
    view_label: "Patient: Name"
    sql: left join unnest(${patient_1000_fh.name}) as patient__name ;;
    relationship: one_to_many
  }
}
