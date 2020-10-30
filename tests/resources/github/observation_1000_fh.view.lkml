view: observation_1000_fh {
  sql_table_name: FHIR_1000_FH.Observation ;;
  drill_fields: [id]

  dimension: id {
    label: "Observation ID"
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: observation_code_text {
    type: string
    sql: ${TABLE}.code.text ;;
  }

  dimension: based_on {
    hidden: yes
    sql: ${TABLE}.basedOn ;;
  }

  dimension: body_site {
    hidden: yes
    sql: ${TABLE}.bodySite ;;
  }

  dimension: category {
    hidden: yes
    sql: ${TABLE}.category ;;
  }

  dimension: code {
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: comment {
    hidden: yes
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: component {
    hidden: yes
    sql: ${TABLE}.component ;;
  }

  dimension: context {
    hidden: yes
    sql: ${TABLE}.context ;;
  }

  dimension: data_absent_reason {
    hidden: yes
    sql: ${TABLE}.dataAbsentReason ;;
  }

  dimension: device {
    hidden: yes
    sql: ${TABLE}.device ;;
  }

  dimension: effective {
    hidden: yes
    sql: ${TABLE}.effective ;;
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

  dimension: interpretation {
    hidden: yes
    sql: ${TABLE}.interpretation ;;
  }

  dimension_group: issued {
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
    sql: ${TABLE}.issued ;;
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

  dimension: method {
    hidden: yes
    sql: ${TABLE}.method ;;
  }

  dimension: performer {
    hidden: yes
    sql: ${TABLE}.performer ;;
  }

  dimension: reference_range {
    hidden: yes
    sql: ${TABLE}.referenceRange ;;
  }

  dimension: related {
    hidden: yes
    sql: ${TABLE}.related ;;
  }

  dimension: specimen {
    hidden: yes
    sql: ${TABLE}.specimen ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subject {
    hidden: yes
    sql: ${TABLE}.subject ;;
  }

  dimension: text {
    hidden: yes
    sql: ${TABLE}.text ;;
  }

  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }

###Appended from the value.quantity view###
  dimension: value_quantity_unit {
    hidden: yes
    type: string
    sql: ${TABLE}.value.quantity.unit ;;
  }

  dimension: value_quantity_value {
    label: "Value Quantity"
    hidden: yes
    type: number
    sql: ${TABLE}.value.quantity.value ;;
  }

  measure: sum_quantity_value {
    hidden: yes
    type: sum
    sql: ${value_quantity_value} ;;
  }

  measure: weight_and_medication {
    hidden: yes
    type: average
    sql: ${value_quantity_value} ;;
    html: {{rendered_value}} || {{medication_request_100_fh.medication_type._rendered_value}} ;;
    filters: {
      field: observation_code_text
      value: "Body Weight"
    }
  }

  measure: weight {
    label: "Average Weight"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "Body Weight"
    }
  }

  measure: height {
    label: "Average Height"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "Body Height"
    }
  }

  measure: body_mass_index {
    label: "Average BMI (kg/m2)"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "Body Mass Index"
    }
  }

#   measure: blood_pressure {
#     label: "Average Blood Pressure"
#     type: average
#     sql: ${value_quantity_value} ;;
#     filters: {
#       field: observation_code_text
#       value: "Blood Pressure"
#     }
#   }

  measure: glucose {
    label: "Average Glucose"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "Glucose"
    }
  }

  measure: cholesterol {
    label: "Average Total Cholesterol"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "Total Cholesterol"
    }
  }

  measure: ldl_cholesterol {
    label: "Average LDL Cholesterol (mg/Dl)"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "Low Density Lipoprotein Cholesterol"
    }
  }

  measure: hba1c_gauge {
    type: number
    sql: ${hba1c} ;;
    html:   <img src="https://chart.googleapis.com/chart?chs=500x300&cht=gom&chma=10,0,0,0&chxt=y&chco=00ff00,ffff00,FF0000&chf=bg,s,FFFFFF00&chl={{ rendered_value }}&chd=t:{{ value }}">;;
  }

  measure: hdl_cholesterol {
    label: "Average HDL Cholesterol (mg/Dl)"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "High Density Lipoprotein Cholesterol"
    }
  }

  measure: hba1c {
    label: "Average HbA1c (%)"
    type: average
    sql: ${value_quantity_value} ;;
    filters: {
      field: observation_code_text
      value: "Hemoglobin A1c/Hemoglobin.total in Blood"
    }
  }

###End Append###

  measure: count {
    type: count
    drill_fields: [id]
  }
}

view: observation__data_absent_reason__coding {
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

view: observation__data_absent_reason {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__code__coding {
  dimension: code {
    hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    view_label: "Observation"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    hidden: yes
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    hidden: yes
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    hidden: yes
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__code {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
}

view: observation__subject {
  dimension: device_id {
    type: string
    sql: ${TABLE}.deviceId ;;
  }

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

  dimension: location_id {
    type: string
    sql: ${TABLE}.locationId ;;
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

view: observation__subject__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__subject__identifier {
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

view: observation__subject__identifier__assigner {
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

view: observation__subject__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__subject__identifier__assigner__identifier {
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

view: observation__subject__identifier__assigner__identifier__assigner {
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

view: observation__subject__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__subject__identifier__assigner__identifier__assigner__identifier {
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

view: observation__subject__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__subject__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__subject__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__subject__identifier__assigner__identifier__type__coding {
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

view: observation__subject__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__subject__identifier__type__coding {
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

view: observation__subject__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__effective {
  dimension: date_time {
    type: string
    sql: ${TABLE}.dateTime ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }
}

view: observation__effective__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__related {
  dimension: target {
    hidden: yes
    sql: ${TABLE}.target ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: observation__related__target {
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

  dimension: questionnaire_response_id {
    type: string
    sql: ${TABLE}.questionnaireResponseId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: sequence_id {
    type: string
    sql: ${TABLE}.sequenceId ;;
  }
}

view: observation__related__target__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__related__target__identifier {
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

view: observation__related__target__identifier__assigner {
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

view: observation__related__target__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__related__target__identifier__assigner__identifier {
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

view: observation__related__target__identifier__assigner__identifier__assigner {
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

view: observation__related__target__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__related__target__identifier__assigner__identifier__assigner__identifier {
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

view: observation__related__target__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__related__target__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__related__target__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__related__target__identifier__assigner__identifier__type__coding {
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

view: observation__related__target__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__related__target__identifier__type__coding {
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

view: observation__related__target__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__specimen {
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

  dimension: specimen_id {
    type: string
    sql: ${TABLE}.specimenId ;;
  }
}

view: observation__specimen__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__specimen__identifier {
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

view: observation__specimen__identifier__assigner {
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

view: observation__specimen__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__specimen__identifier__assigner__identifier {
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

view: observation__specimen__identifier__assigner__identifier__assigner {
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

view: observation__specimen__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__specimen__identifier__assigner__identifier__assigner__identifier {
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

view: observation__specimen__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__specimen__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__specimen__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__specimen__identifier__assigner__identifier__type__coding {
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

view: observation__specimen__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__specimen__identifier__type__coding {
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

view: observation__specimen__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__context {
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

view: observation__context__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__context__identifier {
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

view: observation__context__identifier__assigner {
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

view: observation__context__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__context__identifier__assigner__identifier {
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

view: observation__context__identifier__assigner__identifier__assigner {
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

view: observation__context__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__context__identifier__assigner__identifier__assigner__identifier {
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

view: observation__context__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__context__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__context__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__context__identifier__assigner__identifier__type__coding {
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

view: observation__context__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__context__identifier__type__coding {
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

view: observation__context__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__text {
  dimension: div {
    type: string
    sql: ${TABLE}.div ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: observation__value {
  dimension: attachment {
    hidden: yes
    sql: ${TABLE}.attachment ;;
  }

  dimension: boolean {
    type: yesno
    sql: ${TABLE}.boolean ;;
  }

  dimension: codeable_concept {
    hidden: yes
    sql: ${TABLE}.codeableConcept ;;
  }

  dimension: date_time {
    type: string
    sql: ${TABLE}.dateTime ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: quantity {
    hidden: yes
    sql: ${TABLE}.quantity ;;
  }

  dimension: range {
    hidden: yes
    sql: ${TABLE}.``range`` ;;
  }

  dimension: ratio {
    hidden: yes
    sql: ${TABLE}.ratio ;;
  }

  dimension: sampled_data {
    hidden: yes
    sql: ${TABLE}.sampledData ;;
  }

  dimension: string {
    type: string
    sql: ${TABLE}.string ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.time ;;
  }

  ###Appending on 'observation__value__quantity'###

  dimension: quantity_code {
    type: string
    sql: ${TABLE}.quantity.code ;;
  }

}

view: observation__value__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

###Commenting out this 'view' as I appended the dimensions onto the 'observation__value' view
view: observation__value__quantity {
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

view: observation__value__attachment {
  dimension: content_type {
    type: string
    sql: ${TABLE}.contentType ;;
  }

  dimension: creation {
    type: string
    sql: ${TABLE}.creation ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: hash {
    type: string
    sql: ${TABLE}.``hash`` ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: size {
    type: number
    sql: ${TABLE}.size ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: observation__value__sampled_data {
  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: dimensions {
    type: number
    sql: ${TABLE}.dimensions ;;
  }

  dimension: factor {
    type: number
    sql: ${TABLE}.factor ;;
  }

  dimension: lower_limit {
    type: number
    sql: ${TABLE}.lowerLimit ;;
  }

  dimension: origin {
    hidden: yes
    sql: ${TABLE}.origin ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: upper_limit {
    type: number
    sql: ${TABLE}.upperLimit ;;
  }
}

view: observation__value__sampled_data__origin {
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

view: observation__value__range__high {
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

view: observation__value__range__low {
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

view: observation__value__codeable_concept__coding {
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

view: observation__value__codeable_concept {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__value__ratio__numerator {
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

view: observation__value__ratio__denominator {
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

view: observation__based_on {
  dimension: care_plan_id {
    type: string
    sql: ${TABLE}.carePlanId ;;
  }

  dimension: device_request_id {
    type: string
    sql: ${TABLE}.deviceRequestId ;;
  }

  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: immunization_recommendation_id {
    type: string
    sql: ${TABLE}.immunizationRecommendationId ;;
  }

  dimension: medication_request_id {
    type: string
    sql: ${TABLE}.medicationRequestId ;;
  }

  dimension: nutrition_order_id {
    type: string
    sql: ${TABLE}.nutritionOrderId ;;
  }

  dimension: procedure_request_id {
    type: string
    sql: ${TABLE}.procedureRequestId ;;
  }

  dimension: reference {
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: referral_request_id {
    type: string
    sql: ${TABLE}.referralRequestId ;;
  }
}

view: observation__based_on__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__based_on__identifier {
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

view: observation__based_on__identifier__assigner {
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

view: observation__based_on__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__based_on__identifier__assigner__identifier {
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

view: observation__based_on__identifier__assigner__identifier__assigner {
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

view: observation__based_on__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__based_on__identifier__assigner__identifier__assigner__identifier {
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

view: observation__based_on__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__based_on__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__based_on__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__based_on__identifier__assigner__identifier__type__coding {
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

view: observation__based_on__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__based_on__identifier__type__coding {
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

view: observation__based_on__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__identifier {
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

view: observation__identifier__assigner {
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

view: observation__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__identifier__assigner__identifier {
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

view: observation__identifier__assigner__identifier__assigner {
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

view: observation__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__identifier__assigner__identifier__assigner__identifier {
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

view: observation__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__identifier__assigner__identifier__type__coding {
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

view: observation__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__identifier__type__coding {
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

view: observation__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__performer {
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

view: observation__performer__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__performer__identifier {
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

view: observation__performer__identifier__assigner {
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

view: observation__performer__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__performer__identifier__assigner__identifier {
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

view: observation__performer__identifier__assigner__identifier__assigner {
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

view: observation__performer__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__performer__identifier__assigner__identifier__assigner__identifier {
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

view: observation__performer__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__performer__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__performer__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__performer__identifier__assigner__identifier__type__coding {
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

view: observation__performer__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__performer__identifier__type__coding {
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

view: observation__performer__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__method__coding {
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

view: observation__method {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__body_site__coding {
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

view: observation__body_site {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__reference_range__high {
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

view: observation__reference_range__low {
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

view: observation__reference_range__applies_to__coding {
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

view: observation__reference_range__applies_to {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__reference_range {
  dimension: age {
    hidden: yes
    sql: ${TABLE}.age ;;
  }

  dimension: applies_to {
    hidden: yes
    sql: ${TABLE}.appliesTo ;;
  }

  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }
}

view: observation__reference_range__type__coding {
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

view: observation__reference_range__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__reference_range__age__high {
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

view: observation__reference_range__age__low {
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

view: observation__component__data_absent_reason__coding {
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

view: observation__component__data_absent_reason {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__reference_range__high {
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

view: observation__component__reference_range__low {
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

view: observation__component__reference_range__applies_to__coding {
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

view: observation__component__reference_range__applies_to {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__reference_range {
  dimension: age {
    hidden: yes
    sql: ${TABLE}.age ;;
  }

  dimension: applies_to {
    hidden: yes
    sql: ${TABLE}.appliesTo ;;
  }

  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: type {
    hidden: yes
    sql: ${TABLE}.type ;;
  }
}

view: observation__component__reference_range__type__coding {
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

view: observation__component__reference_range__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__reference_range__age__high {
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

view: observation__component__reference_range__age__low {
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

view: observation__component__code__coding {
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

view: observation__component__code {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__interpretation__coding {
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

view: observation__component__interpretation {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__value {
  dimension: attachment {
    hidden: yes
    sql: ${TABLE}.attachment ;;
  }

  dimension: codeable_concept {
    hidden: yes
    sql: ${TABLE}.codeableConcept ;;
  }

  dimension: date_time {
    type: string
    sql: ${TABLE}.dateTime ;;
  }

  dimension: period {
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: quantity {
    hidden: yes
    sql: ${TABLE}.quantity ;;
  }

  dimension: range {
    hidden: yes
    sql: ${TABLE}.``range`` ;;
  }

  dimension: ratio {
    hidden: yes
    sql: ${TABLE}.ratio ;;
  }

  dimension: sampled_data {
    hidden: yes
    sql: ${TABLE}.sampledData ;;
  }

  dimension: string {
    type: string
    sql: ${TABLE}.string ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.time ;;
  }
}

view: observation__component__value__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__component__value__quantity {
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

view: observation__component__value__attachment {
  dimension: content_type {
    type: string
    sql: ${TABLE}.contentType ;;
  }

  dimension: creation {
    type: string
    sql: ${TABLE}.creation ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: hash {
    type: string
    sql: ${TABLE}.``hash`` ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: size {
    type: number
    sql: ${TABLE}.size ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: observation__component__value__sampled_data {
  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: dimensions {
    type: number
    sql: ${TABLE}.dimensions ;;
  }

  dimension: factor {
    type: number
    sql: ${TABLE}.factor ;;
  }

  dimension: lower_limit {
    type: number
    sql: ${TABLE}.lowerLimit ;;
  }

  dimension: origin {
    hidden: yes
    sql: ${TABLE}.origin ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: upper_limit {
    type: number
    sql: ${TABLE}.upperLimit ;;
  }
}

view: observation__component__value__sampled_data__origin {
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

view: observation__component__value__range__high {
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

view: observation__component__value__range__low {
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

view: observation__component__value__codeable_concept__coding {
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

view: observation__component__value__codeable_concept {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__value__ratio__numerator {
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

view: observation__component__value__ratio__denominator {
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

view: observation__interpretation__coding {
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

view: observation__interpretation {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__meta {
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

view: observation__meta__security {
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

view: observation__meta__tag {
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

view: observation__category__coding {
  dimension: code {
    view_label: "Observation"
    #hidden: yes
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    view_label: "Observation"
    label: "Observation Category"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    hidden: yes
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    hidden: yes
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    hidden: yes
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__category {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    #No values
    hidden: yes
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__device {
  dimension: device_id {
    type: string
    sql: ${TABLE}.deviceId ;;
  }

  dimension: device_metric_id {
    type: string
    sql: ${TABLE}.deviceMetricId ;;
  }

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
}

view: observation__device__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__device__identifier {
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

view: observation__device__identifier__assigner {
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

view: observation__device__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__device__identifier__assigner__identifier {
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

view: observation__device__identifier__assigner__identifier__assigner {
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

view: observation__device__identifier__assigner__identifier__assigner__identifier__period {
  dimension: end {
    type: string
    sql: ${TABLE}.``end`` ;;
  }

  dimension: start {
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__device__identifier__assigner__identifier__assigner__identifier {
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

view: observation__device__identifier__assigner__identifier__assigner__identifier__assigner {
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

view: observation__device__identifier__assigner__identifier__assigner__identifier__type__coding {
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

view: observation__device__identifier__assigner__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__device__identifier__assigner__identifier__type__coding {
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

view: observation__device__identifier__assigner__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__device__identifier__type__coding {
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

view: observation__device__identifier__type {
  dimension: coding {
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__value__range {
  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__value__ratio {
  dimension: denominator {
    hidden: yes
    sql: ${TABLE}.denominator ;;
  }

  dimension: numerator {
    hidden: yes
    sql: ${TABLE}.numerator ;;
  }
}

view: observation__reference_range__age {
  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__component {

  dimension: row_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${observation_1000_fh.id},"-",${component_text}) ;;
  }
  dimension: code {
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: data_absent_reason {
    hidden: yes
    sql: ${TABLE}.dataAbsentReason ;;
  }

  dimension: interpretation {
    hidden: yes
    sql: ${TABLE}.interpretation ;;
  }

  dimension: reference_range {
    hidden: yes
    sql: ${TABLE}.referenceRange ;;
  }

  dimension: value {
    hidden: yes
    sql: ${TABLE}.value ;;
  }

  ###Appended Fields###
  dimension: component_text {
    label: "Blood Pressure Measurement Type"
    view_label: "Observation"
    type: string
    sql: ${TABLE}.code.text ;;
  }

  dimension: component_value {
    label: "Blood Pressure Measurement"
    view_label: "Observation"
    type: number
    sql: ${TABLE}.value.quantity.value ;;
  }

  measure: average_diastolic_blood_pressure {
    view_label: "Observation"
    type: average
    sql: ${component_value} ;;
    filters: {
      field: component_text
      value: "Diastolic Blood Pressure"
    }
    value_format_name: decimal_1
  }

  measure: average_systolic_blood_pressure {
    view_label: "Observation"
    type: average
    sql: ${component_value} ;;
    filters: {
      field: component_text
      value: "Systolic Blood Pressure"
    }
    value_format_name: decimal_1
    html:
      {% if value < 120 %}
        <font color = "darkgreen">{{ rendered_value }}</font>
      {% elsif value < 130 %}
        <font color = "yellow">{{ rendered_value }}</font>
      {% elsif value < 140 %}
        <font color = "orange">{{ rendered_value }}</font>
      {% elsif value < 180 %}
        <font color = "red">{{ rendered_value }}</font>
      {% else %}
        <font color = "darkred">{{ rendered_value }}</font>
      {% endif %}
      ;;
  }

  measure: blood_pressure {
    view_label: "Observation"
    type: string
    sql:
      case
        when ${average_systolic_blood_pressure} < 120
          and ${average_diastolic_blood_pressure} < 80
            then "Normal"
        when ${average_systolic_blood_pressure} >= 120
          and ${average_systolic_blood_pressure} < 130
          and ${average_diastolic_blood_pressure} < 80
            then "Elevated"
        when ((${average_systolic_blood_pressure} >= 130
          and ${average_systolic_blood_pressure} < 140)
          or (${average_diastolic_blood_pressure} >= 80
          and ${average_diastolic_blood_pressure} < 90))
            then "Hypertension Stage 1"
        when ((${average_systolic_blood_pressure} >= 140
          and ${average_systolic_blood_pressure} < 180)
          or (${average_diastolic_blood_pressure} > 90
          and ${average_diastolic_blood_pressure} <= 120))
            then "Hypertension Stage 2"
        when ${average_diastolic_blood_pressure} >= 180
          and ${average_diastolic_blood_pressure} >= 120
            then "Hypertensive Crisis|Seek Help"
        else null
      end
    ;;
    html:
    {% if value == "Normal" %}
    <font color = "darkgreen">{{ rendered_value }}</font>
    {% elsif value == "Elevated" %}
    <font color = "darkyellow">{{ rendered_value }}</font>
    {% elsif value == "Hypertension Stage 1" %}
    <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == "Hypertension Stage 2" %}
    <font color = "red">{{ rendered_value }}</font>
    {% else %}
    <font color = "darkred">{{ rendered_value }}</font>
    {% endif %};;
  }
}

view: observation__component__reference_range__age {
  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__component__value__range {
  dimension: high {
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__component__value__ratio {
  dimension: denominator {
    hidden: yes
    sql: ${TABLE}.denominator ;;
  }

  dimension: numerator {
    hidden: yes
    sql: ${TABLE}.numerator ;;
  }
}
