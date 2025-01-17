view: condition_1000_fh {
  sql_table_name: FHIR_1000_FH.Condition ;;
  drill_fields: [id]

  dimension: id {
    label: "Condition ID"
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: abatement {
    hidden: yes
    sql: ${TABLE}.abatement ;;
  }

  dimension_group: condition_asserted {
    type: time
    timeframes: [
      date
      , week
      , month
      , year
    ]
    sql: timestamp(${TABLE}.assertedDate) ;;
    #substr(${TABLE}.assertedDate,1,10)
  }

  dimension: asserter {
    hidden: yes
    sql: ${TABLE}.asserter ;;
  }

  dimension: body_site {
    hidden: yes
    sql: ${TABLE}.bodySite ;;
  }

  dimension: category {
    hidden: yes
    sql: ${TABLE}.category ;;
  }

  dimension: clinical_status {
    type: string
    sql: ${TABLE}.clinicalStatus ;;
    drill_fields: [
      patient_1000_fh.patient_set*
      , encounter_1000_fh.encounter_set*
      , medication_request_1000_fh.medication_request_set*
      , procedure_1000_fh.procedure_set*
    ]
  }

  dimension: code {
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: context {
    hidden: yes
    sql: ${TABLE}.context ;;
  }

  dimension: evidence {
    hidden: yes
    sql: ${TABLE}.evidence ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: implicit_rules {
    hidden: yes
    type: string
    sql: ${TABLE}.implicitRules ;;
  }

  dimension: language {
    hidden: yes
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: meta {
    hidden: yes
    sql: ${TABLE}.meta ;;
  }

  dimension: note {
    hidden: yes
    sql: ${TABLE}.note ;;
  }

  dimension: onset {
    hidden: yes
    sql: ${TABLE}.onset ;;
  }

  dimension: severity {
    hidden: yes
    sql: ${TABLE}.severity ;;
  }

  dimension: stage {
    hidden: yes
    sql: ${TABLE}.stage ;;
  }

  dimension: subject {
    hidden: yes
    sql: ${TABLE}.subject ;;
  }

  dimension: text {
    hidden: yes
    sql: ${TABLE}.text ;;
  }

  dimension: verification_status {
    type: string
    sql: ${TABLE}.verificationStatus ;;
  }

  ###Appended fields###
  dimension_group: condition_abatement {
    type: time
    timeframes: [
      date
      , month
      , week
      , year
    ]
    sql: timestamp(${TABLE}.abatement.datetime)  ;;
    #substr(${TABLE}.abatement.dateTime,1,10)
  }

  dimension: condition_abated {
    label: "Condition Abated (Yes/No)"
    type: string
    sql:
      case
        when ${TABLE}.abatement.datetime is not null
          then 'Yes'
        else 'No'
      end
    ;;
  }

  dimension: condition_abatement_timeline {
    hidden: yes
    type: date
    sql:
      case
        when ${condition_abatement_date} is null
          then current_date()
        else ${condition_abatement_date}
      end;;
  }

  dimension: condition_text {
    label: "REPLACE AND HIDE Condition Name"
    hidden: yes
    type: string
    sql: ${TABLE}.code.text ;;
    drill_fields: [
      patient_1000_fh.patient_set*
      , encounter_1000_fh.encounter_set*
      , medication_request_1000_fh.medication_request_set*
      , procedure_1000_fh.procedure_set*
    ]
  }

  dimension: condition_text_dummy {
    label: "Condition Name"
    type: string
    sql: ${condition_text} ;;
    drill_fields: [
      patient_1000_fh.patient_set*
      , encounter_1000_fh.encounter_set*
      , medication_request_1000_fh.medication_request_set*
      , procedure_1000_fh.procedure_set*
    ]
    link: {
      label: "Exploration Dashboard"
      url: "/dashboards/11?Condition%20Name={{ value }}
      &Age={{ _filters['patient_1000_fh.age'] | url_encode }}
      &Gender={{ _filters['patient_1000_fh.gender'] | url_encode }}
      &Patient={{ _filters['patient__name.full_name'] | url_encode }}
      &Condition%20Grouping={{ _filters['condition_1000_fh.condition_grouping'] | url_encode }}
      &Encounter%20Type={{ _filters['encounter__type.text'] | url_encode }}
      &Procedure%20Name={{ _filters['procedure_1000_fh.procedure_name_dummy'] | url_encode }}
      &Medication%20Type={{ _filters['medication_request_1000_fh.medication_type_dummy'] | url_encode }}"
    }
  }

#   dimension: condition_grouping {
#     type: string
#     sql:
#       case
#         when ${condition_text} in ('Atrial Fibrillation','Cardiac Arrest','Chronic congestive heart failure (disorder)',
#             'Coronary Heart Disease','Myocardial Infarction')
#           then 'Heart Disease'
#         when ${condition_text} in ('Chronic kidney disease stage 1 (disorder)')
#           then 'Kidney Disease'
#         when ${condition_text} in ('Stroke')
#           then 'Stroke'
#         when ${condition_text} in ('Pulmonary emphysema (disorder)')
#           then 'Chronic Obstructive Pulmonary Disease'
#         when ${condition_text} in ('Diabetes','Diabetic renal disease (disorder)','Diabetic retinopathy associated with type II diabetes mellitus (disorder)')
#           then 'Diabetes'
#         when ${condition_text} in ('Hyperlipidemia')
#           then 'Cholesterol'
#         end
#       ;;
#   }

  dimension: condition_grouping {
    type: string
    sql:
      case
        when ${condition_text} in ('Acute allergic reaction')
          then 'Allergic'
        when ${condition_text} in ('Perennial allergic rhinitis','Perennial allergic rhinitis with seasonal variation','Seasonal allergic rhinitis')
          then 'Allergies'
        when ${condition_text} in ('Localized, primary osteoarthritis of the hand','Osteoarthritis of hip','Osteoarthritis of knee','Rheumatoid arthritis')
          then 'Arthritis'
        when ${condition_text} in ('Anemia (disorder)','Hypertriglyceridemia (disorder)')
          then 'Blood Disorder'
        when ${condition_text} in ('Hypertension')
          then 'Blood Pressure'
        when ${condition_text} in ('Osteoporosis (disorder)')
          then 'Bone Disorder'
        when ${condition_text} in ('First degree burn','Second degree burn','Third degree burn')
          then 'Burn'
        when ${condition_text} in ('Carcinoma in situ of prostate (disorder)','Malignant neoplasm of breast (disorder)','Neoplasm of prostate','Polyp of colon')
          then 'Cancer'
        when ${condition_text} in ('Hyperlipidemia')
          then 'Cholesterol'
        when ${condition_text} in ('Diabetes','Diabetic renal disease (disorder)','Diabetic retinopathy associated with type II diabetes mellitus (disorder)','Gout','Macular edema and retinopathy due to type 2 diabetes mellitus (disorder)','Neuropathy due to type 2 diabetes mellitus (disorder)','Nonproliferative diabetic retinopathy due to type 2 diabetes mellitus (disorder)','Prediabetes')
          then 'Diabetes'
        when ${condition_text} in ('Hyperglycemia (disorder)')
          then 'Diabetes/Blood Disorder'
        when ${condition_text} in ('Drug overdose')
          then 'Drugs'
        when ${condition_text} in ('Closed fracture of hip','Fracture of ankle','Fracture of clavicle','Fracture of forearm','Fracture of rib','Fracture subluxation of wrist')
          then 'Fracture'
        when ${condition_text} in ('Pathological fracture due to osteoporosis (disorder)')
          then 'Fracture/Bone Disorder'
        when ${condition_text} in ('Brain damage - traumatic','Concussion injury of brain','Concussion with loss of consciousness','Concussion with no loss of consciousness')
          then 'Head Injury'
        when ${condition_text} in ('Atrial Fibrillation','Cardiac Arrest','Chronic congestive heart failure (disorder)','Coronary Heart Disease','Myocardial Infarction')
          then 'Heart Disease'
        when ${condition_text} in ('Escherichia coli urinary tract infection','Otitis media','Recurrent urinary tract infection','Streptococcal sore throat (disorder)')
          then 'Infection'
        when ${condition_text} in ('Acute bacterial sinusitis (disorder)','Acute viral pharyngitis (disorder)','Appendicitis','Chronic sinusitis (disorder)','Sinusitis (disorder)','Viral sinusitis (disorder)')
          then 'Infection/Inflammation'
        when ${condition_text} in ('Cystitis')
          then 'Inflammation'
        when ${condition_text} in ('Acute bronchitis (disorder)','Chronic obstructive bronchitis (disorder)')
          then 'Inflammation/Infection/Lung Illness'
        when ${condition_text} in ('Rupture of appendix','Whiplash injury to neck')
          then 'Injury'
        when ${condition_text} in ('Chronic kidney disease stage 1 (disorder)')
          then 'Kidney Disease'
        when ${condition_text} in ('Childhood asthma','Pulmonary emphysema (disorder)')
          then 'Lung Illness'
        when ${condition_text} in ('History of appendectomy','History of cardiac arrest (situation)','History of myocardial infarction (situation)','History of single seizure (situation)')
          then 'Medical History'
        when ${condition_text} in ('Child attention deficit disorder','Major depression disorder','Major depression, single episode','Posttraumatic stress disorder')
          then 'Mental Health'
        when ${condition_text} in ("Alzheimer's disease (disorder)",'Chronic intractable migraine without aura','Epilepsy','Seizure disorder','Stroke')
          then 'Neurological'
        when ${condition_text} in ('Body mass index 30+ - obesity (finding)','Body mass index 40+ - severely obese (finding)')
          then 'Obesity'
        when ${condition_text} in ('Metabolic syndrome X (disorder)')
          then 'Obesity/Cholesterol/Diabetes/Blood Pressure'
        when ${condition_text} in ('Chronic pain','Primary fibromyalgia syndrome')
          then 'Pain'
        when ${condition_text} in ('Blighted ovum','Antepartum eclampsia','Fetus with unknown complication','Miscarriage in first trimester','Normal pregnancy','Preeclampsia','Tubal pregnancy')
          then'Pregnancy'
        when ${condition_text} in ('Atopic dermatitis','Contact dermatitis')
          then 'Skin Condition/Inflammation'
        when ${condition_text} in ('Smokes tobacco daily')
          then 'Smoking'
        when ${condition_text} in ('Sprain of ankle','Sprain of wrist')
          then 'Sprain'
        when ${condition_text} in ('Injury of anterior cruciate ligament','Injury of medial collateral ligament of knee','Injury of tendon of the rotator cuff of shoulder','Rupture of patellar tendon','Tear of meniscus of knee')
          then 'Tendon, Ligament and Meniscus Injuries/Tears/Ruptures'
        when ${condition_text} in ('Impacted molars')
          then 'Tooth'
        when ${condition_text} in ('Bullet wound','Laceration of foot','Laceration of forearm','Laceration of hand','Laceration of thigh','Facial laceration')
          then 'Wound/Injury'
        else 'Not Grouped'
      end
      ;;
    drill_fields: [
      patient_1000_fh.patient_set*
      , encounter_1000_fh.encounter_set*
      , medication_request_1000_fh.medication_request_set*
      , procedure_1000_fh.procedure_set*
      , condition_text
    ]
    link: {
      label: "Exploration Dashboard"
      url: "/dashboards/11?Condition%20Grouping={{ value }}
      &Age={{ _filters['patient_1000_fh.age'] | url_encode }}
      &Gender={{ _filters['patient_1000_fh.gender'] | url_encode }}
      &Patient={{ _filters['patient__name.full_name'] | url_encode }}
      &Condition%20Name={{ _filters['condition_1000_fh.condition_text_dummy'] | url_encode }}
      &Encounter%20Type={{ _filters['encounter__type.text'] | url_encode }}
      &Procedure%20Name={{ _filters['procedure_1000_fh.procedure_name_dummy'] | url_encode }}
      &Medication%20Type={{ _filters['medication_request_1000_fh.medication_type_dummy'] | url_encode }}"
    }
  }

#   dimension: condition_grouping_2 {
#     type: string
#     sql:
#       case
#         when ${condition_text} in ('Acute allergic reaction','Perennial allergic rhinitis','Perennial allergic rhinitis with seasonal variation','Seasonal allergic rhinitis')
#           then 'Allergies'
#         when ${condition_text} in ('Body mass index 30+ - obesity (finding)','Body mass index 40+ - severely obese (finding)')
#           then 'Obesity'
#         when ${condition_text} in ('Concussion injury of brain','Concussion with loss of consciousness','Concussion with no loss of consciousness')
#           then 'Concussion'
#         when ${condition_text} in ('Closed fracture of hip','Fracture of ankle','Fracture of clavicle','Fracture of forearm','Fracture of rib','Fracture subluxation of wrist')
#           then 'Fracture'
#         when ${condition_text} in ('Laceration of foot','Laceration of forearm','Laceration of hand','Laceration of thigh','Facial laceration')
#           then 'Laceration'
#         when ${condition_text} in ('Localized, primary osteoarthritis of the hand','Osteoarthritis of hip','Osteoarthritis of knee','Rheumatoid arthritis')
#           then 'Arthritis'
#         when ${condition_text} in ('Major depression disorder','Major depression, single episode')
#           then 'Depression'
#         when ${condition_text} in ("Alzheimer's disease (disorder)")
#           then ${condition_text}
#         when ${condition_text} in ('Carcinoma in situ of prostate (disorder)','Malignant neoplasm of breast (disorder)','Neoplasm of prostate')
#           then 'Cancer'
#         when ${condition_text} in ('Sprain of ankle','Sprain of wrist')
#           then 'Sprain'
#         when ${condition_text} in ('Injury of anterior cruciate ligament','Injury of medial collateral ligament of knee','Injury of tendon of the rotator cuff of shoulder','Rupture of patellar tendon','Tear of meniscus of knee')
#           then 'Tendon, Ligament and Meniscus Injuries/Tears/Ruptures'
#         when ${condition_text} in ('First degree burn','Second degree burn','Third degree burn')
#           then 'Burn'
#         when ${condition_text} in ('Blighted ovum','Antepartum eclampsia','Fetus with unknown complication','Miscarriage in first trimester','Normal pregnancy','Tubal pregnancy')
#           then'Pregnancy'
#         else null
#       end;;
#   }

  dimension_group: condition_onset {
    type: time
    datatype: date
    timeframes: [
      date
      , month
      , week
      , year
    ]
    sql: ${TABLE}.onset.datetime ;;
  # substr(${TABLE}.onset.dateTime,1,10)
  }

  dimension: age_at_onset {
    type: number
    sql: date_diff(${condition_onset_date}, ${patient_1000_fh.birth_date}, year) ;;
  }

  dimension: age_at_abatement {
    type: number
    sql: date_diff(${condition_abatement_date}, ${patient_1000_fh.birth_date}, year) ;;
  }

  dimension: condition_duration_months {
    label: "Condition Duration (Months)"
    type: number
    sql: date_diff(${condition_abatement_date}, ${condition_onset_date}, month) ;;
  }

  measure: median_age_at_onset {
    label: "Onset: Median Age"
    type: median
    sql: ${age_at_onset} ;;
  }

  measure: min_age_at_onset {
    label: "Onset: Min Age"
    type: min
    sql: ${age_at_onset};;
  }

  measure: max_age_at_onset {
    label: "Onset: Max Age"
    type: max
    sql: ${age_at_onset} ;;
  }

  dimension: median_age_at_onset_groups {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90]
    style: interval
    sql: ${age_at_onset} ;;
  }

  measure: median_age_at_abatement {
    label: "Abatement: Median Age"
    type: median
    sql: ${age_at_abatement} ;;
  }

  measure: min_age_at_abatement {
    label: "Abatement: Min Age"
    type: min
    sql: ${age_at_abatement} ;;
  }

  measure: max_age_at_abatement {
    label: "Abatement: Max Age"
    type: max
    sql: ${age_at_abatement} ;;
  }

  dimension: median_age_at_abatement_groups {
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90]
    style: interval
    sql: ${age_at_abatement} ;;
  }

  measure: condition_duration_average_months {
    label: "Duration: Average in Months"
    type: average
    sql: ${condition_duration_months} ;;
    value_format_name: decimal_1
  }
###End of append###

  measure: count {
    label: "Condition Occurrences"
    type: count
    drill_fields: [id]
  }
}

view: condition__severity__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__severity {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__identifier__assigner__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__identifier__assigner__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__identifier__assigner__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__note__author__reference {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: patient_id {
    type: string
    sql: ${TABLE}.patientId ;;
  }

  dimension: practitioner_id {
    type: string
    sql: ${TABLE}.practitionerId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: related_person_id {
    type: string
    sql: ${TABLE}.relatedPersonId ;;
  }
}

view: condition__note__author__reference__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__note__author__reference__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__note__author__reference__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__note__author__reference__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__note__author__reference__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__note__author__reference__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__note__author {
  dimension: reference {
    hidden: yes
    sql: ${TABLE}.reference ;;
  }

  dimension: string {
    type: string
    sql: ${TABLE}.string ;;
  }
}

view: condition__note {
  dimension: author {
    hidden: yes
    sql: ${TABLE}.author ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.time ;;
  }
}

view: condition__code__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__code {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__evidence__code__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__evidence__code {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__evidence__detail {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: resource_id {
    type: string
    sql: ${TABLE}.resourceId ;;
  }
}

view: condition__evidence__detail__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__evidence__detail__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__evidence__detail__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__evidence__detail__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__evidence__detail__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__evidence__detail__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__subject {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: group_id {
    type: string
    sql: ${TABLE}.groupId ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: patient_id {
    type: string
    sql: ${TABLE}.patientId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__subject__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__subject__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__subject__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__subject__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__subject__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__subject__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__subject__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__subject__identifier__assigner__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__subject__identifier__assigner__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__subject__identifier__assigner__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__subject__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__subject__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__subject__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__subject__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__subject__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__onset {
  dimension: age {
    hidden: yes
    sql: ${TABLE}.age ;;
  }

  dimension: date_time {
    type: string
    sql: ${TABLE}.dateTime ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: range {
    hidden: yes
    sql: ${TABLE}.``range`` ;;
  }

  dimension: string {
    type: string
    sql: ${TABLE}.string ;;
  }
}

view: condition__onset__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__onset__range__high {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: condition__onset__range__low {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: condition__onset__age {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: condition__body_site__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__body_site {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__asserter {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: patient_id {
    type: string
    sql: ${TABLE}.patientId ;;
  }

  dimension: practitioner_id {
    type: string
    sql: ${TABLE}.practitionerId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: related_person_id {
    type: string
    sql: ${TABLE}.relatedPersonId ;;
  }
}

view: condition__asserter__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__asserter__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__asserter__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__asserter__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__asserter__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__asserter__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__asserter__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__stage__summary__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__stage__summary {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__stage__assessment {
  dimension: clinical_impression_id {
    type: string
    sql: ${TABLE}.clinicalImpressionId ;;
  }

  dimension: diagnostic_report_id {
    type: string
    sql: ${TABLE}.diagnosticReportId ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: observation_id {
    type: string
    sql: ${TABLE}.observationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__stage__assessment__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__stage__assessment__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__stage__assessment__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__stage__assessment__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__stage__assessment__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__stage__assessment__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__meta {
  dimension_group: last_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.lastUpdated ;;
  }

  dimension: profile {
    type: string
    sql: ${TABLE}.profile ;;
  }

  dimension: security {
    hidden: yes
    sql: ${TABLE}.security ;;
  }

  dimension: tag {
    hidden: yes
    sql: ${TABLE}.tag ;;
  }

  dimension: version_id {
    type: string
    sql: ${TABLE}.versionId ;;
  }
}

view: condition__meta__security {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__meta__tag {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__context {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: encounter_id {
    type: string
    sql: ${TABLE}.encounterId ;;
  }

  dimension: episode_of_care_id {
    type: string
    sql: ${TABLE}.episodeOfCareId ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__context__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__context__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__context__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__context__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__context__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__context__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__context__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__context__identifier__assigner__identifier__assigner__identifier {
  dimension: assigner {
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: condition__context__identifier__assigner__identifier__assigner__identifier__assigner {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__context__identifier__assigner__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__context__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__context__identifier__assigner__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__context__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__context__identifier__type__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__context__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__text {
  dimension: div {
    type: string
    sql: ${TABLE}.div ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: condition__category__coding {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: condition__category {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: condition__abatement {
  dimension: age {
    hidden: yes
    sql: ${TABLE}.age ;;
  }

  dimension: boolean {
    type: yesno
    sql: ${TABLE}.boolean ;;
  }

  dimension: date_time {
    type: string
    sql: ${TABLE}.dateTime ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: range {
    hidden: yes
    sql: ${TABLE}.``range`` ;;
  }

  dimension: string {
    type: string
    sql: ${TABLE}.string ;;
  }
}

view: condition__abatement__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: condition__abatement__range__high {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: condition__abatement__range__low {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: condition__abatement__age {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: condition__evidence {
  dimension: code {
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: detail {
    hidden: yes
    sql: ${TABLE}.detail ;;
  }
}

view: condition__onset__range {
  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: condition__stage {
  dimension: assessment {
    hidden: yes
    sql: ${TABLE}.assessment ;;
  }

  dimension: summary {
    hidden: yes
    sql: ${TABLE}.summary ;;
  }
}

view: condition__abatement__range {
  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}
