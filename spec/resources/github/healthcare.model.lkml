connection: "lookerdata"
# include: "/demo_vitals/*.view.lkml"
include: "/simplified_views/*.view.lkml"
include: "/unnested_views/*.view.lkml"
include: "/realtime_views/*.view.lkml"
include: "dashboards/*.dashboard.lookml"

label: "1) Healthcare Systems and Providers"


############ Simplified View Explores #############

explore: condition_simple {
  view_label: "Condition"
  label: "  Simplified Patient, Encounter & Condition"
  join: patient_simple {
    view_label: "Patient"
    type: left_outer
    relationship: many_to_one
    sql_on: ${condition_simple.patient_id} = ${patient_simple.id} ;;
  }
  join: encounter_simple {
    view_label: "Encounter"
    type: left_outer
    relationship: many_to_one
    sql_on: ${encounter_simple.id} = ${condition_simple.encounter_id} ;;
  }
}

explore: realtime_observations {
  hidden: yes
  join: vital_fact {
    view_label: "Vital"
    relationship: many_to_one
    sql_on: ${vital_fact.vital_type}=${realtime_observations.type} ;;
  }
}


############ Unnested Explores #############

#### bsase explores

explore: encounter {
  hidden: yes
  label: "Unnested Encounter"
  join: encounter__meta__profile {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${encounter.meta__profile}) as encounter__meta__profile;;
  }
  join: encounter__hospitalization__discharge_disposition__coding {
    #view_label: "Encounter: Discharge Disposition"
    sql: LEFT JOIN UNNEST(${encounter.hospitalization__discharge_disposition__coding}) as encounter__hospitalization__discharge_disposition__coding ;;
    relationship: one_to_many
  }
  join: encounter__participant {
    #view_label: "Encounter: Participant"
    sql: LEFT JOIN UNNEST(${encounter.participant}) as encounter__participant ;;
    relationship: one_to_many
  }
  join: encounter__reason {
    #view_label: "Encounter: Reason"
    sql: LEFT JOIN UNNEST(${encounter.reason}) as encounter__reason ;;
    relationship: one_to_many
  }
  join: encounter__reason__coding {
    #view_label: "Encounter: Reason"
    sql: LEFT JOIN UNNEST(${encounter__reason.coding}) as encounter__reason__coding ;;
    relationship: one_to_many
  }
  join: encounter__type {
    #view_label: "Encounter: Type"
    sql: LEFT JOIN UNNEST(${encounter.type}) as encounter__type ;;
    relationship: one_to_many
  }
  join: encounter__type__coding {
    #view_label: "Encounter: Type"
    sql: LEFT JOIN UNNEST(${encounter__type.coding}) as encounter__type__coding ;;
    relationship: one_to_many
  }


}

explore: diagnostic_report {
  hidden: yes
  label: "Unnested Diagnostic Report"
  join: diagnostic_report__code__coding {
    sql: LEFT JOIN UNNEST(${diagnostic_report.code__coding}) as diagnostic_report__code__coding ;;
    relationship: one_to_many
  }
  join: diagnostic_report__result {
    sql: LEFT JOIN UNNEST(${diagnostic_report.result}) as diagnostic_report__result ;;
    relationship: one_to_many
  }
}

explore: condition {
  hidden: yes
  label: "Unnested Condition"
  join: condition__meta__profile {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${condition.meta__profile}) as condition__meta__profile;;
  }
  join: condition__code__coding {
    sql: LEFT JOIN UNNEST(${condition.code__coding}) as condition__code__coding ;;
    relationship: one_to_many
  }
  join: condition__category {
    sql: LEFT JOIN UNNEST(${condition.category}) as condition__category ;;
    relationship: one_to_many
  }
  join: condition__category__coding {
    sql: LEFT JOIN UNNEST(${condition__category.coding}) as condition__category__coding ;;
    relationship: one_to_many
  }
}

explore: medication_request {
  hidden: yes
  label: "Unnested Medication Request"
  join: medication_request__meta__profile {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${medication_request.meta__profile}) as medication_request__meta__profile;;
  }
  join: medication_request__medication__codeable_concept__coding {
    sql: LEFT JOIN UNNEST(${medication_request.medication__codeable_concept__coding}) as medication_request__medication__codeable_concept__coding ;;
    relationship: one_to_many
  }
  join: medication_request__extension__codeable_concept__coding {
    sql: LEFT JOIN UNNEST(${medication_request.code_extension__value__codeable_concept__coding}) as medication_request__extension__codeable_concept__coding ;;
    relationship: one_to_many
  }
}

explore: observation {
  hidden: yes
  label: "Unnested Observation"
  join: observation__meta__profile {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${observation.meta__profile}) as observation__meta__profile;;
  }
  join: observation__category {
    sql: LEFT JOIN UNNEST(${observation.category}) as observation__category ;;
    relationship: one_to_many
  }
  join: observation__category__coding {
    sql: LEFT JOIN UNNEST(${observation__category.coding}) as observation__category__coding ;;
    relationship: one_to_many
  }
  join: observation__component {
    sql: LEFT JOIN UNNEST(${observation.component}) as observation__component ;;
    relationship: one_to_many
  }
  join: observation__component__code__coding {
    sql: LEFT JOIN UNNEST(${observation__component.code__coding}) as observation__component__code__coding ;;
    relationship: one_to_many
  }
}

explore: organization {
  hidden: yes
  label: "Unnested Organization"
  join: organization__address {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${organization.address}) as organization__address;;
  }
  join: organization__identifier {
    sql: LEFT JOIN UNNEST(${organization.identifier}) as organization__identifier ;;
    relationship: one_to_many
  }
  join: organization__type {
    sql: LEFT JOIN UNNEST(${organization.type}) as organization__type ;;
    relationship: one_to_many
  }
  join: organization__meta__profile {
    sql: LEFT JOIN UNNEST(${organization.meta__profile}) as organization__meta__profile ;;
    relationship: one_to_many
  }
}

explore: patient {
  hidden: yes
  label: "Patient Details"
  join: patient__address {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${patient.address}) as patient__address;;
  }
  join: patient__identifier {
    sql: LEFT JOIN UNNEST(${patient.identifier}) as patient__identifier ;;
    relationship: one_to_many
  }
  join: patient__communication {
    sql: LEFT JOIN UNNEST(${patient.communication}) as patient__communication ;;
    relationship: one_to_many
  }
  join: patient__meta__profile {
    sql: LEFT JOIN UNNEST(${patient.meta__profile}) as patient__meta__profile ;;
    relationship: one_to_many
  }
}

explore: procedure {
  hidden: yes
  label: "Unnested Procedure"
  join: procedure__code__coding {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${procedure.code__coding}) as procedure__code__coding;;
  }
  join: procedure__meta__profile {
    sql: LEFT JOIN UNNEST(${procedure.meta__profile}) as procedure__meta__profile ;;
    relationship: one_to_many
  }
}

explore: practitioner {
  hidden: yes
  label: "Unnested Practitioners"
  join: practitioner__address {
    relationship: many_to_one
    sql: LEFT JOIN UNNEST(${practitioner.address}) as practitioner__address;;
  }
  join: practitioner__identifier {
    sql: LEFT JOIN UNNEST(${practitioner.identifier}) as practitioner__identifier ;;
    relationship: one_to_many
  }
}


#### extended explores

explore: encounter_extended {
  hidden: no
  extends: [encounter,patient]
  from: encounter
  view_name: encounter
  label: "Organizations, Practitioners & Encounters"
  join: patient {
    relationship: many_to_one
    sql_on: ${encounter.patient_id} = ${patient.id} ;;
  }
  join: organization {
    relationship: many_to_one
    sql_on: ${organization.id} = ${encounter.organization_id} ;;
  }
  join: practitioner {
    relationship: many_to_one
    sql_on: ${practitioner.id} = ${encounter__participant.practitionerId} ;;
  }
}

explore: observation_extended {
  hidden: yes
  extends: [observation,encounter_extended]
  from: observation
  view_name: observation
  label: "Observations"
  join: encounter {
    relationship: many_to_one
    sql_on: ${observation.context__encounter_id} = ${encounter.id} ;;
  }
}

explore: condition_extended {
  hidden: no
  label: "Diagnoses & Medication Requests"
  extends: [condition,encounter_extended,medication_request]
  from: condition
  view_name: condition
  join: encounter {
    relationship: many_to_one
    sql_on: ${condition.context__encounterId} = ${encounter.id} ;;
  }
  join: medication_request {
    relationship: many_to_many
    sql_on: ${medication_request.context__encounter_id} = ${encounter.id} ;;
  }
}

explore: observation_vitals {
  label: "Vitals Monitoring"
  join: patient {
    relationship: many_to_one
    sql_on: ${observation_vitals.patient_id} = ${patient.id} ;;
  }
  join: organization {
    relationship: many_to_one
    sql_on: ${organization.id} = ${observation_vitals.organization_id} ;;
  }
  join: practitioner {
    relationship: many_to_one
    sql_on: ${practitioner.id} = ${observation_vitals.practitioner_id} ;;
  }
  join: vital_fact {
    view_label: "Vital"
    relationship: many_to_one
    sql_on: ${vital_fact.vital_type}=${observation_vitals.type} ;;
  }
  join: observation_count_by_vital {
    relationship: many_to_one
    sql_on: ${observation_count_by_vital.type}=${observation_vitals.type} ;;
  }

}

explore: readmission {
  hidden: no
  join: condition {
    type: left_outer
    relationship: many_to_one
    sql_on: ${condition.context__encounterId} = ${readmission.encounter_id} ;;
  }
  join: condition__code__coding {
    sql: LEFT JOIN UNNEST(${condition.code__coding}) as condition__code__coding ;;
    relationship: one_to_many
  }
  join: prior_condition {
    from: condition
    type: left_outer
    relationship: many_to_one
    sql_on: ${prior_condition.context__encounterId} = ${readmission.prior_encounter_id};;
  }
  join: prior_condition__code__coding {
    view_label: "Prior Condition"
    from: condition__code__coding
    sql: LEFT JOIN UNNEST(${prior_condition.code__coding}) as prior_condition__code__coding ;;
    relationship: one_to_many
  }
  extends: [patient]
  join: patient {
    type: left_outer
    relationship: many_to_one
    sql_on: ${patient.id}=${readmission.patient_id} ;;
  }
}



############ Caching Logic ############

persist_with: once_weekly

### PDT Timeframes

datagroup: once_daily {
  max_cache_age: "24 hours"
  sql_trigger: SELECT current_date() ;;
}

datagroup: once_weekly {
  max_cache_age: "168 hours"
  sql_trigger: SELECT extract(week from current_date()) ;;
}

datagroup: once_monthly {
  max_cache_age: "720 hours"
  sql_trigger: SELECT extract(month from current_date()) ;;
}

datagroup: once_yearly {
  max_cache_age: "9000 hours"
  sql_trigger: SELECT extract(year from current_date()) ;;
}
