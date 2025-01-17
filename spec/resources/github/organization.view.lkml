view: organization {
  label: "Organization"
  sql_table_name: `lookerdata.healthcare_demo_live.organization`
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

  dimension: alias {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.alias ;;
  }

  dimension: contact {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.contact ;;
  }

  dimension: endpoint {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.endpoint ;;
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
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: part_of {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.partOf ;;
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

  dimension: type {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}

view: organization__part_of {
  label: "Organization"
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

view: organization__part_of__identifier__period {
  label: "Organization"
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

view: organization__part_of__identifier {
  label: "Organization"
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

view: organization__part_of__identifier__assigner {
  label: "Organization"
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

view: organization__part_of__identifier__assigner__identifier__period {
  label: "Organization"
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

view: organization__part_of__identifier__assigner__identifier {
  label: "Organization"
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

view: organization__part_of__identifier__assigner__identifier__assigner {
  label: "Organization"
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

view: organization__part_of__identifier__assigner__identifier__type__coding {
  label: "Organization"
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

view: organization__part_of__identifier__assigner__identifier__type {
  label: "Organization"
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

view: organization__part_of__identifier__type__coding {
  label: "Organization"
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

view: organization__part_of__identifier__type {
  label: "Organization"
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

view: organization__identifier__period {
  label: "Organization"
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

view: organization__identifier {
  label: "Organization"
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

view: organization__identifier__assigner {
  label: "Organization"
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

view: organization__identifier__assigner__identifier__period {
  label: "Organization"
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

view: organization__identifier__assigner__identifier {
  label: "Organization"
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

view: organization__identifier__assigner__identifier__assigner {
  label: "Organization"
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

view: organization__identifier__assigner__identifier__type__coding {
  label: "Organization"
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

view: organization__identifier__assigner__identifier__type {
  label: "Organization"
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

view: organization__identifier__type__coding {
  label: "Organization"
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

view: organization__identifier__type {
  label: "Organization"
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

view: organization__address {
  label: "Organization"
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

view: organization__address__period {
  label: "Organization"
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

view: organization__type__coding {
  label: "Organization"
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

view: organization__type {
  label: "Organization"
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

view: organization__endpoint {
  label: "Organization"
  dimension: display {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: endpoint_id {
    group_label: "{{ _view._name }}"
    type: string
    sql: ${TABLE}.endpointId ;;
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

view: organization__endpoint__identifier__period {
  label: "Organization"
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

view: organization__endpoint__identifier {
  label: "Organization"
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

view: organization__endpoint__identifier__assigner {
  label: "Organization"
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

view: organization__endpoint__identifier__assigner__identifier__period {
  label: "Organization"
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

view: organization__endpoint__identifier__assigner__identifier {
  label: "Organization"
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

view: organization__endpoint__identifier__assigner__identifier__assigner {
  label: "Organization"
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

view: organization__endpoint__identifier__assigner__identifier__type__coding {
  label: "Organization"
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

view: organization__endpoint__identifier__assigner__identifier__type {
  label: "Organization"
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

view: organization__endpoint__identifier__type__coding {
  label: "Organization"
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

view: organization__endpoint__identifier__type {
  label: "Organization"
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

view: organization__meta {
  label: "Organization"
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

view: organization__meta__security {
  label: "Organization"
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

view: organization__meta__tag {
  label: "Organization"
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

view: organization__contact__address {
  label: "Organization"
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

view: organization__contact__address__period {
  label: "Organization"
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

view: organization__contact__purpose__coding {
  label: "Organization"
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

view: organization__contact__purpose {
  label: "Organization"
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

view: organization__contact__name {
  label: "Organization"
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

view: organization__contact__name__period {
  label: "Organization"
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

view: organization__contact__telecom__period {
  label: "Organization"
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

view: organization__contact__telecom {
  label: "Organization"
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

view: organization__telecom__period {
  label: "Organization"
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

view: organization__telecom {
  label: "Organization"
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

view: organization__text {
  label: "Organization"
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

view: organization__contact {
  label: "Organization"
  dimension: address {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: name {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.name ;;
  }

  dimension: purpose {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.purpose ;;
  }

  dimension: telecom {
    group_label: "{{ _view._name }}"
    hidden: yes
    sql: ${TABLE}.telecom ;;
  }
}
