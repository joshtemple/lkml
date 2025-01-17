view: observation {
  label: "Observation"
  sql_table_name: `lookerdata.healthcare_demo_live.observation`
    ;;
  drill_fields: [id]

  dimension: id {
    group_label: "{{ _view._name }}"
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: based_on {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.basedOn ;;
  }

  dimension: body_site {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.bodySite ;;
  }

  dimension: category {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.category ;;
  }

  dimension: code {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: comment {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: component {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.component ;;
  }

  dimension: context {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.context ;;
  }

  ## added for FK
  dimension: context__encounter_id {
    hidden: yes
    sql: ${context}.encounterId ;;
  }

  dimension: data_absent_reason {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.dataAbsentReason ;;
  }

  dimension: device {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.device ;;
  }

  dimension: effective {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.effective ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: implicit_rules {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.implicitRules ;;
  }

  dimension: interpretation {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.interpretation ;;
  }

  dimension_group: issued {
    group_label: "{{ _view._name }}"
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
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: meta {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.meta ;;
  }

  dimension: method {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.method ;;
  }

  dimension: performer {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.performer ;;
  }

  dimension: reference_range {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.referenceRange ;;
  }

  dimension: related {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.related ;;
  }

  dimension: specimen {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.specimen ;;
  }

  dimension: status {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subject {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.subject ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.text ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

view: observation__data_absent_reason__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__data_absent_reason {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__code__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__code {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__subject {
  label: "Observation"
  dimension: device_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.deviceId ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: group_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.groupId ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: location_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.locationId ;;
  }

  dimension: patient_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.patientId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__subject__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__subject__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__subject__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__subject__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__subject__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__subject__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__subject__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__subject__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__subject__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__subject__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__effective {
  label: "Observation"
  dimension_group: date {
    group_label: "{{ _view._name }}"
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
    sql: ${TABLE}.dateTime ;;
  }
}

view: observation__related {
  label: "Observation"
  dimension: target {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.target ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: observation__related__target {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: observation_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.observationId ;;
  }

  dimension: questionnaire_response_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.questionnaireResponseId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: sequence_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.sequenceId ;;
  }
}

view: observation__related__target__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__related__target__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__related__target__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__related__target__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__related__target__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__related__target__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__related__target__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__related__target__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__related__target__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__related__target__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__specimen {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: specimen_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.specimenId ;;
  }
}

view: observation__specimen__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__specimen__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__specimen__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__specimen__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__specimen__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__specimen__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__specimen__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__specimen__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__specimen__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__specimen__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__context {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: encounter_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.encounterId ;;
  }

  dimension: episode_of_care_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.episodeOfCareId ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__context__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__context__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__context__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__context__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__context__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__context__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__context__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__context__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__context__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__context__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__text {
  label: "Observation"
  dimension: div {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.div ;;
  }

  dimension: status {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: observation__value {
  label: "Observation"
  dimension: attachment {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.attachment ;;
  }

  dimension: boolean {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.boolean ;;
  }

  dimension: codeable_concept {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.codeableConcept ;;
  }

  dimension: date_time {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.dateTime ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: quantity {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.quantity ;;
  }

  dimension: range {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.`range` ;;
  }

  dimension: ratio {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.ratio ;;
  }

  dimension: sampled_data {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.sampledData ;;
  }

  dimension: string {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.string ;;
  }

  dimension: time {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.time ;;
  }
}

view: observation__value__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__value__quantity {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__value__attachment {
  label: "Observation"
  dimension: content_type {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.contentType ;;
  }

  dimension: creation {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.creation ;;
  }

  dimension: data {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: hash {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`hash` ;;
  }

  dimension: language {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: size {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.size ;;
  }

  dimension: title {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: url {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: observation__value__sampled_data {
  label: "Observation"
  dimension: data {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: dimensions {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.dimensions ;;
  }

  dimension: factor {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.factor ;;
  }

  dimension: lower_limit {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.lowerLimit ;;
  }

  dimension: origin {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.origin ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: upper_limit {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.upperLimit ;;
  }
}

view: observation__value__sampled_data__origin {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__value__range__high {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__value__range__low {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__value__codeable_concept__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__value__codeable_concept {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__value__ratio__numerator {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__value__ratio__denominator {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__based_on {
  label: "Observation"
  dimension: care_plan_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.carePlanId ;;
  }

  dimension: device_request_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.deviceRequestId ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: immunization_recommendation_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.immunizationRecommendationId ;;
  }

  dimension: medication_request_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.medicationRequestId ;;
  }

  dimension: nutrition_order_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.nutritionOrderId ;;
  }

  dimension: procedure_request_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.procedureRequestId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: referral_request_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.referralRequestId ;;
  }
}

view: observation__based_on__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__based_on__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__based_on__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__based_on__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__based_on__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__based_on__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__based_on__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__based_on__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__based_on__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__based_on__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__performer {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: patient_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.patientId ;;
  }

  dimension: practitioner_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.practitionerId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }

  dimension: related_person_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.relatedPersonId ;;
  }
}

view: observation__performer__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__performer__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__performer__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__performer__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__performer__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__performer__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__performer__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__performer__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__performer__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__performer__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__method__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__method {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__body_site__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__body_site {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__reference_range__high {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__reference_range__low {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__reference_range__applies_to__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__reference_range__applies_to {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__reference_range {
  label: "Observation"
  dimension: age {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.age ;;
  }

  dimension: applies_to {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.appliesTo ;;
  }

  dimension: high {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.low ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }
}

view: observation__reference_range__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__reference_range__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__reference_range__age__high {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__reference_range__age__low {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__data_absent_reason__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__component__data_absent_reason {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__reference_range__high {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__reference_range__low {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__reference_range__applies_to__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__component__reference_range__applies_to {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__reference_range {
  label: "Observation"
  dimension: age {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.age ;;
  }

  dimension: applies_to {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.appliesTo ;;
  }

  dimension: high {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.low ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }
}

view: observation__component__reference_range__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__component__reference_range__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__reference_range__age__high {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__reference_range__age__low {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__code__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__component__code {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__interpretation__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__component__interpretation {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__value {
  label: "Observation"
  dimension: attachment {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.attachment ;;
  }

  dimension: codeable_concept {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.codeableConcept ;;
  }

  dimension: date_time {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.dateTime ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: quantity {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.quantity ;;
  }

  dimension: range {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.`range` ;;
  }

  dimension: ratio {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.ratio ;;
  }

  dimension: sampled_data {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.sampledData ;;
  }

  dimension: string {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.string ;;
  }

  dimension: time {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.time ;;
  }
}

view: observation__component__value__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__component__value__quantity {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__value__attachment {
  label: "Observation"
  dimension: content_type {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.contentType ;;
  }

  dimension: creation {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.creation ;;
  }

  dimension: data {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: hash {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`hash` ;;
  }

  dimension: language {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: size {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.size ;;
  }

  dimension: title {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: url {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.url ;;
  }
}

view: observation__component__value__sampled_data {
  label: "Observation"
  dimension: data {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: dimensions {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.dimensions ;;
  }

  dimension: factor {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.factor ;;
  }

  dimension: lower_limit {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.lowerLimit ;;
  }

  dimension: origin {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.origin ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: upper_limit {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.upperLimit ;;
  }
}

view: observation__component__value__sampled_data__origin {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__value__range__high {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__value__range__low {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__value__codeable_concept__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__component__value__codeable_concept {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__component__value__ratio__numerator {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__value__ratio__denominator {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: comparator {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.comparator ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: unit {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.unit ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.value ;;
  }
}

view: observation__interpretation__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__interpretation {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__meta {
  label: "Observation"
  dimension_group: last_updated {
    group_label: "{{ _view._name }}"
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
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.profile ;;
  }

  dimension: security {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.security ;;
  }

  dimension: tag {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.tag ;;
  }

  dimension: version_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.versionId ;;
  }
}

view: observation__meta__security {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__meta__tag {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__category__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__category {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__device {
  label: "Observation"
  dimension: device_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.deviceId ;;
  }

  dimension: device_metric_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.deviceMetricId ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__device__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__device__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__device__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__device__identifier__assigner__identifier__period {
  label: "Observation"
  dimension: end {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.`end` ;;
  }

  dimension: start {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.start ;;
  }
}

view: observation__device__identifier__assigner__identifier {
  label: "Observation"
  dimension: assigner {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assigner ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.value ;;
  }
}

view: observation__device__identifier__assigner__identifier__assigner {
  label: "Observation"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: organization_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.organizationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: observation__device__identifier__assigner__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__device__identifier__assigner__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__device__identifier__type__coding {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: user_selected {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.userSelected ;;
  }

  dimension: version {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: observation__device__identifier__type {
  label: "Observation"
  dimension: coding {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.coding ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }
}

view: observation__value__range {
  label: "Observation"
  dimension: high {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__value__ratio {
  label: "Observation"
  dimension: denominator {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.denominator ;;
  }

  dimension: numerator {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.numerator ;;
  }
}

view: observation__reference_range__age {
  label: "Observation"
  dimension: high {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__component {
  label: "Observation"
  dimension: code {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: data_absent_reason {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.dataAbsentReason ;;
  }

  dimension: interpretation {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.interpretation ;;
  }

  dimension: reference_range {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.referenceRange ;;
  }

  dimension: value {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: observation__component__reference_range__age {
  label: "Observation"
  dimension: high {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__component__value__range {
  label: "Observation"
  dimension: high {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.high ;;
  }

  dimension: low {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.low ;;
  }
}

view: observation__component__value__ratio {
  label: "Observation"
  dimension: denominator {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.denominator ;;
  }

  dimension: numerator {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.numerator ;;
  }
}
