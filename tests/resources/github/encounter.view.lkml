
view: encounter {
  label: "Encounter"
  sql_table_name: `lookerdata.healthcare_demo_live.encounter`
    ;;
  drill_fields: [id]

  dimension: id {
        group_label: "{{ _view._name }}"
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.account ;;
  }

  dimension: appointment {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.appointment ;;
  }

  dimension: class {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.class ;;
  }

  dimension: class_history {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.classHistory ;;
  }

  dimension: diagnosis {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.diagnosis ;;
  }

  dimension: episode_of_care {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.episodeOfCare ;;
  }

  dimension: hospitalization {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.hospitalization ;;
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

  dimension: incoming_referral {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.incomingReferral ;;
  }

  dimension: language {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: length {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.length ;;
  }

  dimension: location {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.location ;;
  }

  dimension: meta {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.meta ;;
  }

  dimension: part_of {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.partOf ;;
  }

  dimension: participant {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.participant ;;
  }

  dimension: period {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: priority {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.priority ;;
  }

  dimension: reason {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.reason ;;
  }

  dimension: service_provider {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.serviceProvider ;;
  }

  dimension: shr_action_performed_context_extension {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.shr_action_PerformedContext_extension ;;
  }

  dimension: status {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_history {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.statusHistory ;;
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

  dimension: type {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

view: encounter__part_of {
  label: "Encounter"
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

view: encounter__part_of__identifier__period {
  label: "Encounter"
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

view: encounter__part_of__identifier {
  label: "Encounter"
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

view: encounter__part_of__identifier__assigner {
  label: "Encounter"
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

view: encounter__part_of__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__part_of__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__part_of__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__part_of__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__part_of__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__part_of__identifier__type__coding {
  label: "Encounter"
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

view: encounter__part_of__identifier__type {
  label: "Encounter"
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

view: encounter__reason__coding {
  label: "Encounter"
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

view: encounter__reason {
  label: "Encounter"
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

view: encounter__shr_action_performed_context_extension__shr_action_status_extension__value {
  label: "Encounter"
  dimension: code {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.code ;;
  }
}

view: encounter__subject {
  label: "Encounter"
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

view: encounter__subject__identifier__period {
  label: "Encounter"
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

view: encounter__subject__identifier {
  label: "Encounter"
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

view: encounter__subject__identifier__assigner {
  label: "Encounter"
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

view: encounter__subject__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__subject__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__subject__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__subject__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__subject__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__subject__identifier__type__coding {
  label: "Encounter"
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

view: encounter__subject__identifier__type {
  label: "Encounter"
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

view: encounter__appointment {
  label: "Encounter"
  dimension: appointment_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.appointmentId ;;
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

view: encounter__appointment__identifier__period {
  label: "Encounter"
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

view: encounter__appointment__identifier {
  label: "Encounter"
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

view: encounter__appointment__identifier__assigner {
  label: "Encounter"
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

view: encounter__appointment__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__appointment__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__appointment__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__appointment__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__appointment__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__appointment__identifier__type__coding {
  label: "Encounter"
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

view: encounter__appointment__identifier__type {
  label: "Encounter"
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

view: encounter__type__coding {
  label: "Encounter"
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

view: encounter__type {
  label: "Encounter"
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

view: encounter__participant__period {
  label: "Encounter"
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

view: encounter__participant__individual {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__period {
  label: "Encounter"
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

view: encounter__participant__individual__identifier {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__assigner {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__type__coding {
  label: "Encounter"
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

view: encounter__participant__individual__identifier__type {
  label: "Encounter"
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

view: encounter__participant__type__coding {
  label: "Encounter"
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

view: encounter__participant__type {
  label: "Encounter"
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

view: encounter__episode_of_care {
  label: "Encounter"
  dimension: display {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
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

view: encounter__episode_of_care__identifier__period {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__assigner {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__type__coding {
  label: "Encounter"
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

view: encounter__episode_of_care__identifier__type {
  label: "Encounter"
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

view: encounter__text {
  label: "Encounter"
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

view: encounter__class {
  label: "Encounter"
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

view: encounter__identifier__period {
  label: "Encounter"
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

view: encounter__identifier {
  label: "Encounter"
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

view: encounter__identifier__assigner {
  label: "Encounter"
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

view: encounter__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__identifier__type__coding {
  label: "Encounter"
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

view: encounter__identifier__type {
  label: "Encounter"
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

view: encounter__incoming_referral {
  label: "Encounter"
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

  dimension: referral_request_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.referralRequestId ;;
  }
}

view: encounter__incoming_referral__identifier__period {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__assigner {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__type__coding {
  label: "Encounter"
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

view: encounter__incoming_referral__identifier__type {
  label: "Encounter"
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

view: encounter__period {
  label: "Encounter"
  dimension_group: end {
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
    sql: ${TABLE}.`end` ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start ;;
  }
}

view: encounter__class_history__period {
  label: "Encounter"
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

view: encounter__class_history__class {
  label: "Encounter"
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

view: encounter__hospitalization__special_arrangement__coding {
  label: "Encounter"
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

view: encounter__hospitalization__special_arrangement {
  label: "Encounter"
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

view: encounter__hospitalization__re_admission__coding {
  label: "Encounter"
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

view: encounter__hospitalization__re_admission {
  label: "Encounter"
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

view: encounter__hospitalization__origin {
  label: "Encounter"
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

  dimension: location_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.locationId ;;
  }

  dimension: reference {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: encounter__hospitalization__origin__identifier__period {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__assigner {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__type__coding {
  label: "Encounter"
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

view: encounter__hospitalization__origin__identifier__type {
  label: "Encounter"
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

view: encounter__hospitalization__destination {
  label: "Encounter"
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

  dimension: location_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.locationId ;;
  }

  dimension: reference {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: encounter__hospitalization__destination__identifier__period {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__assigner {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__type__coding {
  label: "Encounter"
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

view: encounter__hospitalization__destination__identifier__type {
  label: "Encounter"
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

view: encounter__hospitalization__diet_preference__coding {
  label: "Encounter"
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

view: encounter__hospitalization__diet_preference {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__period {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__type__coding {
  label: "Encounter"
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

view: encounter__hospitalization__pre_admission_identifier__type {
  label: "Encounter"
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

view: encounter__hospitalization__special_courtesy__coding {
  label: "Encounter"
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

view: encounter__hospitalization__special_courtesy {
  label: "Encounter"
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

view: encounter__hospitalization__discharge_disposition__coding {
  label: "Encounter"
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

view: encounter__hospitalization__discharge_disposition {
  label: "Encounter"
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

view: encounter__hospitalization__admit_source__coding {
  label: "Encounter"
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

view: encounter__hospitalization__admit_source {
  label: "Encounter"
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

view: encounter__length {
  label: "Encounter"
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

view: encounter__diagnosis__condition {
  label: "Encounter"
  dimension: condition_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.conditionId ;;
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

  dimension: procedure_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.procedureId ;;
  }

  dimension: reference {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: encounter__diagnosis__condition__identifier__period {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__assigner {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__type__coding {
  label: "Encounter"
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

view: encounter__diagnosis__condition__identifier__type {
  label: "Encounter"
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

view: encounter__diagnosis__role__coding {
  label: "Encounter"
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

view: encounter__diagnosis__role {
  label: "Encounter"
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

view: encounter__diagnosis {
  label: "Encounter"
  dimension: condition {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.condition ;;
  }

  dimension: rank {
        group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: role {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.role ;;
  }
}

view: encounter__priority__coding {
  label: "Encounter"
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

view: encounter__priority {
  label: "Encounter"
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

view: encounter__status_history__period {
  label: "Encounter"
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

view: encounter__status_history {
  label: "Encounter"
  dimension: period {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: status {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: encounter__meta {
  label: "Encounter"
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

view: encounter__meta__security {
  label: "Encounter"
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

view: encounter__meta__tag {
  label: "Encounter"
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

view: encounter__service_provider {
  label: "Encounter"
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

view: encounter__service_provider__identifier__period {
  label: "Encounter"
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

view: encounter__service_provider__identifier {
  label: "Encounter"
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

view: encounter__service_provider__identifier__assigner {
  label: "Encounter"
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

view: encounter__service_provider__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__service_provider__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__service_provider__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__service_provider__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__service_provider__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__service_provider__identifier__type__coding {
  label: "Encounter"
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

view: encounter__service_provider__identifier__type {
  label: "Encounter"
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

view: encounter__location__period {
  label: "Encounter"
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

view: encounter__location__location {
  label: "Encounter"
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

  dimension: location_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.locationId ;;
  }

  dimension: reference {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: encounter__location__location__identifier__period {
  label: "Encounter"
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

view: encounter__location__location__identifier {
  label: "Encounter"
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

view: encounter__location__location__identifier__assigner {
  label: "Encounter"
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

view: encounter__location__location__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__location__location__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__location__location__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__location__location__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__location__location__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__location__location__identifier__type__coding {
  label: "Encounter"
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

view: encounter__location__location__identifier__type {
  label: "Encounter"
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

view: encounter__location {
  label: "Encounter"
  dimension: location {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.location ;;
  }

  dimension: period {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: status {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.status ;;
  }
}

view: encounter__account {
  label: "Encounter"
  dimension: account_id {
        group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.accountId ;;
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

view: encounter__account__identifier__period {
  label: "Encounter"
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

view: encounter__account__identifier {
  label: "Encounter"
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

view: encounter__account__identifier__assigner {
  label: "Encounter"
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

view: encounter__account__identifier__assigner__identifier__period {
  label: "Encounter"
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

view: encounter__account__identifier__assigner__identifier {
  label: "Encounter"
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

view: encounter__account__identifier__assigner__identifier__assigner {
  label: "Encounter"
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

view: encounter__account__identifier__assigner__identifier__type__coding {
  label: "Encounter"
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

view: encounter__account__identifier__assigner__identifier__type {
  label: "Encounter"
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

view: encounter__account__identifier__type__coding {
  label: "Encounter"
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

view: encounter__account__identifier__type {
  label: "Encounter"
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

view: encounter__shr_action_performed_context_extension__shr_action_status_extension {
  label: "Encounter"
  dimension: value {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.value ;;
  }
}

view: encounter__participant {
  label: "Encounter"
  dimension: individual {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.individual ;;
  }

  dimension: period {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: type {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }
}

view: encounter__class_history {
  label: "Encounter"
  dimension: class {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.class ;;
  }

  dimension: period {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }
}

view: encounter__hospitalization {
  label: "Encounter"
  dimension: admit_source {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.admitSource ;;
  }

  dimension: destination {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.destination ;;
  }

  dimension: diet_preference {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.dietPreference ;;
  }

  dimension: discharge_disposition {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.dischargeDisposition ;;
  }

  dimension: origin {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.origin ;;
  }

  dimension: pre_admission_identifier {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.preAdmissionIdentifier ;;
  }

  dimension: re_admission {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.reAdmission ;;
  }

  dimension: special_arrangement {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.specialArrangement ;;
  }

  dimension: special_courtesy {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.specialCourtesy ;;
  }
}

view: encounter__shr_action_performed_context_extension {
  label: "Encounter"
  dimension: shr_action_status_extension {
        group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.shr_action_Status_extension ;;
  }
}
