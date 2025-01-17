view: condition {
  label: "Condition"
  sql_table_name: `lookerdata.healthcare_demo_live.condition`
    ;;
  drill_fields: [id]

  dimension: id {
    group_label: "{{ _view._name }}"
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: abatement {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.abatement ;;
  }

  dimension: asserted_date {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.assertedDate ;;
  }

  dimension: asserter {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.asserter ;;
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

  dimension: clinical_status {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.clinicalStatus ;;
  }

  dimension: code {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.code ;;
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

  dimension: evidence {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.evidence ;;
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

  dimension: note {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.note ;;
  }

  dimension: onset {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.onset ;;
  }

  dimension: severity {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.severity ;;
  }

  dimension: stage {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.stage ;;
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

  dimension: verification_status {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.verificationStatus ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

view: condition__severity__coding {
  label: "Condition"
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

view: condition__severity {
  label: "Condition"
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

view: condition__identifier__period {
  label: "Condition"
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

view: condition__identifier {
  label: "Condition"
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

view: condition__identifier__assigner {
  label: "Condition"
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

view: condition__identifier__assigner__identifier__period {
  label: "Condition"
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

view: condition__identifier__assigner__identifier {
  label: "Condition"
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

view: condition__identifier__assigner__identifier__assigner {
  label: "Condition"
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

view: condition__identifier__assigner__identifier__type__coding {
  label: "Condition"
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

view: condition__identifier__assigner__identifier__type {
  label: "Condition"
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

view: condition__identifier__type__coding {
  label: "Condition"
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

view: condition__identifier__type {
  label: "Condition"
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

view: condition__note__author__reference {
  label: "Condition"
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

view: condition__note__author__reference__identifier__period {
  label: "Condition"
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

view: condition__note__author__reference__identifier {
  label: "Condition"
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

view: condition__note__author__reference__identifier__assigner {
  label: "Condition"
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

view: condition__note__author__reference__identifier__assigner__identifier__period {
  label: "Condition"
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

view: condition__note__author__reference__identifier__assigner__identifier {
  label: "Condition"
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

view: condition__note__author__reference__identifier__assigner__identifier__assigner {
  label: "Condition"
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

view: condition__note__author__reference__identifier__assigner__identifier__type__coding {
  label: "Condition"
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

view: condition__note__author__reference__identifier__assigner__identifier__type {
  label: "Condition"
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

view: condition__note__author__reference__identifier__type__coding {
  label: "Condition"
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

view: condition__note__author__reference__identifier__type {
  label: "Condition"
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

view: condition__note__author {
  label: "Condition"
  dimension: reference {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.reference ;;
  }

  dimension: string {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.string ;;
  }
}

view: condition__note {
  label: "Condition"
  dimension: author {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.author ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: time {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.time ;;
  }
}

view: condition__code__coding {
  label: "Condition"
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

view: condition__code {
  label: "Condition"
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

view: condition__evidence__code__coding {
  label: "Condition"
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

view: condition__evidence__code {
  label: "Condition"
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

view: condition__evidence__detail {
  label: "Condition"
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

  dimension: resource_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.resourceId ;;
  }
}

view: condition__evidence__detail__identifier__period {
  label: "Condition"
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

view: condition__evidence__detail__identifier {
  label: "Condition"
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

view: condition__evidence__detail__identifier__assigner {
  label: "Condition"
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

view: condition__evidence__detail__identifier__assigner__identifier__period {
  label: "Condition"
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

view: condition__evidence__detail__identifier__assigner__identifier {
  label: "Condition"
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

view: condition__evidence__detail__identifier__assigner__identifier__assigner {
  label: "Condition"
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

view: condition__evidence__detail__identifier__assigner__identifier__type__coding {
  label: "Condition"
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

view: condition__evidence__detail__identifier__assigner__identifier__type {
  label: "Condition"
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

view: condition__evidence__detail__identifier__type__coding {
  label: "Condition"
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

view: condition__evidence__detail__identifier__type {
  label: "Condition"
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

view: condition__subject {
  label: "Condition"
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

view: condition__subject__identifier__period {
  label: "Condition"
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

view: condition__subject__identifier {
  label: "Condition"
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

view: condition__subject__identifier__assigner {
  label: "Condition"
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

view: condition__subject__identifier__assigner__identifier__period {
  label: "Condition"
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

view: condition__subject__identifier__assigner__identifier {
  label: "Condition"
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

view: condition__subject__identifier__assigner__identifier__assigner {
  label: "Condition"
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

view: condition__subject__identifier__assigner__identifier__type__coding {
  label: "Condition"
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

view: condition__subject__identifier__assigner__identifier__type {
  label: "Condition"
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

view: condition__subject__identifier__type__coding {
  label: "Condition"
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

view: condition__subject__identifier__type {
  label: "Condition"
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

view: condition__onset {
  label: "Condition"
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

view: condition__body_site__coding {
  label: "Condition"
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

view: condition__body_site {
  label: "Condition"
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

view: condition__asserter {
  label: "Condition"
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

view: condition__asserter__identifier__period {
  label: "Condition"
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

view: condition__asserter__identifier {
  label: "Condition"
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

view: condition__asserter__identifier__assigner {
  label: "Condition"
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

view: condition__asserter__identifier__assigner__identifier__period {
  label: "Condition"
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

view: condition__asserter__identifier__assigner__identifier {
  label: "Condition"
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

view: condition__asserter__identifier__assigner__identifier__assigner {
  label: "Condition"
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

view: condition__asserter__identifier__assigner__identifier__type__coding {
  label: "Condition"
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

view: condition__asserter__identifier__assigner__identifier__type {
  label: "Condition"
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

view: condition__asserter__identifier__type__coding {
  label: "Condition"
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

view: condition__asserter__identifier__type {
  label: "Condition"
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

view: condition__stage__summary__coding {
  label: "Condition"
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

view: condition__stage__summary {
  label: "Condition"
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

view: condition__stage__assessment {
  label: "Condition"
  dimension: clinical_impression_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.clinicalImpressionId ;;
  }

  dimension: diagnostic_report_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.diagnosticReportId ;;
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

  dimension: observation_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.observationId ;;
  }

  dimension: reference {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.reference ;;
  }
}

view: condition__stage__assessment__identifier__period {
  label: "Condition"
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

view: condition__stage__assessment__identifier {
  label: "Condition"
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

view: condition__stage__assessment__identifier__assigner {
  label: "Condition"
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

view: condition__stage__assessment__identifier__assigner__identifier__period {
  label: "Condition"
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

view: condition__stage__assessment__identifier__assigner__identifier {
  label: "Condition"
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

view: condition__stage__assessment__identifier__assigner__identifier__assigner {
  label: "Condition"
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

view: condition__stage__assessment__identifier__assigner__identifier__type__coding {
  label: "Condition"
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

view: condition__stage__assessment__identifier__assigner__identifier__type {
  label: "Condition"
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

view: condition__stage__assessment__identifier__type__coding {
  label: "Condition"
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

view: condition__stage__assessment__identifier__type {
  label: "Condition"
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

view: condition__meta {
  label: "Condition"
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

view: condition__meta__security {
  label: "Condition"
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

view: condition__meta__tag {
  label: "Condition"
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

view: condition__context {
  label: "Condition"
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

view: condition__context__identifier__period {
  label: "Condition"
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

view: condition__context__identifier {
  label: "Condition"
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

view: condition__context__identifier__assigner {
  label: "Condition"
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

view: condition__context__identifier__assigner__identifier__period {
  label: "Condition"
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

view: condition__context__identifier__assigner__identifier {
  label: "Condition"
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

view: condition__context__identifier__assigner__identifier__assigner {
  label: "Condition"
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

view: condition__context__identifier__assigner__identifier__type__coding {
  label: "Condition"
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

view: condition__context__identifier__assigner__identifier__type {
  label: "Condition"
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

view: condition__context__identifier__type__coding {
  label: "Condition"
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

view: condition__context__identifier__type {
  label: "Condition"
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

view: condition__text {
  label: "Condition"
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

view: condition__category__coding {
  label: "Condition"
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

view: condition__category {
  label: "Condition"
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

view: condition__abatement {
  label: "Condition"
  dimension: age {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.age ;;
  }

  dimension: boolean {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.boolean ;;
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

  dimension: range {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.`range` ;;
  }

  dimension: string {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.string ;;
  }
}

view: condition__abatement__period {
  label: "Condition"
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

view: condition__abatement__range__high {
  label: "Condition"
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

view: condition__abatement__range__low {
  label: "Condition"
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

view: condition__abatement__age {
  label: "Condition"
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

view: condition__evidence {
  label: "Condition"
  dimension: code {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: detail {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.detail ;;
  }
}

view: condition__stage {
  label: "Condition"
  dimension: assessment {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.assessment ;;
  }

  dimension: summary {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.summary ;;
  }
}

view: condition__abatement__range {
  label: "Condition"
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
