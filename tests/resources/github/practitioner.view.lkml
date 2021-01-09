view: practitioner {
  label: "Practitioner"
  sql_table_name: `lookerdata.healthcare_demo_live.practitioner`
    ;;
  drill_fields: [id]

  dimension: id {
    group_label: "{{ _view._name }}"
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: active {
    group_label: "{{ _view._name }}"
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: address {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: birth_date {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.birthDate ;;
  }

  dimension: communication {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.communication ;;
  }

  dimension: gender {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.gender ;;
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

  dimension: name {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.name ;;
  }

  dimension: photo {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.photo ;;
  }

  dimension: qualification {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.qualification ;;
  }

  dimension: telecom {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.telecom ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.text ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}

view: practitioner__identifier__period {
  label: "Practitioner"
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

view: practitioner__identifier {
  label: "Practitioner"
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

view: practitioner__identifier__assigner {
  label: "Practitioner"
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

view: practitioner__identifier__assigner__identifier__period {
  label: "Practitioner"
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

view: practitioner__identifier__assigner__identifier {
  label: "Practitioner"
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

view: practitioner__identifier__assigner__identifier__assigner {
  label: "Practitioner"
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

view: practitioner__identifier__assigner__identifier__type__coding {
  label: "Practitioner"
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

view: practitioner__identifier__assigner__identifier__type {
  label: "Practitioner"
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

view: practitioner__identifier__type__coding {
  label: "Practitioner"
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

view: practitioner__identifier__type {
  label: "Practitioner"
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

view: practitioner__address {
  label: "Practitioner"
  dimension: city {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    group_label: "{{ _view._name }}"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: district {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.district ;;
  }

  dimension: line {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.line ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: postal_code {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.postalCode ;;
  }

  dimension: state {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: type {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }
}

view: practitioner__address__period {
  label: "Practitioner"
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

view: practitioner__photo {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__period {
  label: "Practitioner"
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

view: practitioner__qualification__identifier {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__assigner {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__assigner__identifier__period {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__assigner__identifier {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__assigner__identifier__assigner {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__assigner__identifier__type__coding {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__assigner__identifier__type {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__type__coding {
  label: "Practitioner"
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

view: practitioner__qualification__identifier__type {
  label: "Practitioner"
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

view: practitioner__qualification__period {
  label: "Practitioner"
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

view: practitioner__qualification__code__coding {
  label: "Practitioner"
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

view: practitioner__qualification__code {
  label: "Practitioner"
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

view: practitioner__qualification__issuer {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__period {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__assigner {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__assigner__identifier__period {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__assigner__identifier {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__assigner__identifier__assigner {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__assigner__identifier__type__coding {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__assigner__identifier__type {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__type__coding {
  label: "Practitioner"
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

view: practitioner__qualification__issuer__identifier__type {
  label: "Practitioner"
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

view: practitioner__meta {
  label: "Practitioner"
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

view: practitioner__meta__security {
  label: "Practitioner"
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

view: practitioner__meta__tag {
  label: "Practitioner"
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

view: practitioner__name {
  label: "Practitioner"
  dimension: family {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.family ;;
  }

  dimension: given {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.given ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: prefix {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.prefix ;;
  }

  dimension: suffix {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.suffix ;;
  }

  dimension: text {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.text ;;
  }

  dimension: use {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.use ;;
  }
}

view: practitioner__name__period {
  label: "Practitioner"
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

view: practitioner__telecom__period {
  label: "Practitioner"
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

view: practitioner__telecom {
  label: "Practitioner"
  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }

  dimension: rank {
    group_label: "{{ _view._name }}"
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: system {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.system ;;
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

view: practitioner__text {
  label: "Practitioner"
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

view: practitioner__communication__coding {
  label: "Practitioner"
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

view: practitioner__communication {
  label: "Practitioner"
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

view: practitioner__qualification {
  label: "Practitioner"
  dimension: code {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.code ;;
  }

  dimension: identifier {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: issuer {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.issuer ;;
  }

  dimension: period {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.period ;;
  }
}
