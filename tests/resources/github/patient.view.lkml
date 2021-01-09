#########  Original Table  #########
# unnested arrays are included as view with their own dimensions below

view: patient {
  sql_table_name: lookerdata.healthcare_demo_live.patient ;;
  drill_fields: [id]

  #########  Standard dimensions  #########

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: birth_raw {
    hidden: yes
    type: date_raw
    sql: ${TABLE}.birthDate ;;
  }

  dimension: birth_date {
    hidden: yes
    type: date
    sql: ${birth_raw} ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: age {
    type: duration_year
    sql_end: CURRENT_TIMESTAMP() ;;
    sql_start: ${birth_raw} ;;
  }

  dimension: age_tier {
    sql: ${age} ;;
    type: tier
    style: integer
    tiers: [0, 18, 25, 40, 55, 65]
  }

  #########  JSON  dimensions  #########

  #### birth_place fields  ####

  dimension: birth_place {
    hidden: yes
    sql: ${TABLE}.birthPlace.value.address ;;
  }

  dimension: birth_place__city {
    label: "City"
    group_label: "Birth Place"
    sql: ${birth_place}.city ;;
  }

  dimension: birth_place__state {
    label: "State"
    group_label: "Birth Place"
    map_layer_name: us_states
    sql: ${birth_place}.state ;;
  }

  dimension: birth_place__country {
    label: "Country"
    group_label: "Birth Place"
    map_layer_name: countries
    sql: ${birth_place}.country ;;
  }


  dimension: disability_adjusted_life_years {
    hidden: yes
    type: number
    sql: ${TABLE}.disability_adjusted_life_years.value.decimal;;
  }

  dimension: is_deceased {
    type: yesno
    sql: ${deceased_date} is not null ;;
  }

  dimension_group: deceased {
    type: time
    timeframes: [
      date,
      month,
      year,
      month_name
    ]
    sql: PARSE_DATETIME('%Y-%m-%dT%H:%M:%S+00:00', ${TABLE}.deceased.dateTime) ;;
  }

  dimension: quality_adjusted_life_years {
    hidden: yes
    type: number
    sql: ${TABLE}.quality_adjusted_life_years.value.decimal ;;
  }

  dimension: shr_demographics_social_security_number_extension {
    hidden: yes
    label: "SSN"
    sql: ${TABLE}.shr_demographics_SocialSecurityNumber_extension.value.string ;;
  }

  dimension: us_core_birthsex {
    label: "Birth Sex"
    sql: ${TABLE}.us_core_birthsex.value.code ;;
  }

  dimension: us_core_ethnicity {
    label: "Ethnicity"
    sql: ${TABLE}.us_core_ethnicity.text.value.string ;;
  }

  dimension: us_core_race {
    label: "Race"
    sql: ${TABLE}.us_core_race.text.value.string ;;
  }

  dimension: meta {
    hidden: yes
    sql: ${TABLE}.meta ;;
  }

  dimension: meta__profile {
    hidden: yes
    sql: ${meta}.profile ;;
  }

  #########  Array  dimensions  #########

  dimension: contact {
    hidden: yes
    sql: ${TABLE}.contact ;;
  }

  dimension: address {
    hidden: yes
    sql: ${TABLE}.address ;;
  }

  dimension: communication {
    hidden: yes
    sql: ${TABLE}.communication ;;
  }

  dimension: identifier {
    hidden: yes
    sql: ${TABLE}.identifier ;;
  }

  dimension: first_name {
    hidden: yes
    sql: regexp_replace(${TABLE}.name[Offset(0)].given[Offset(0)],'[0-9]','') ;;
  }

  dimension: last_name {
    hidden: yes
    sql: regexp_replace(${TABLE}.name[Offset(0)].family,'[0-9]','') ;;
  }

  dimension: name {
    sql: CONCAT(${first_name}, ' ',${last_name}) ;;
    link: {
      label: "Patient Overview"
      url: "/dashboards/471?Patient ID={{ patient.id._value }}&Patient%20Name={{ patient.name._value }}"
      icon_url: "https://www.google.com/s2/favicons?domain=https://meta.looker.com/browse"
    }
    action: {
      label: "Email Follow Up to Patient"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Procedure Followup"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ value }},

        We wanted to followup on your recent procedure to see how you are feeling."
      }

    }
  }

  dimension: is_wellness_screened_in_the_past_year {
    type: yesno
    sql: ${name} IN( SELECT ${name}
                              FROM lookerdata.healthcare_demo_live.encounter  AS encounter
                              LEFT JOIN UNNEST(encounter.type) as encounter__type
                              LEFT JOIN UNNEST(encounter__type.coding) as encounter__type__coding
                              LEFT JOIN lookerdata.healthcare_demo_live.patient  AS patient ON encounter.subject.patientId = patient.id

                              WHERE (encounter.period.start ) >= ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -364 DAY)), 'America/Los_Angeles')))
                              AND (encounter.period.start ) < ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -364 DAY), INTERVAL 365 DAY)), 'America/Los_Angeles')))
                              AND (encounter__type__coding.display IN ('Encounter for \'check-up\'', 'Encounter for check up', 'Encounter for check up (procedure)'))
                              GROUP BY 1
                              ORDER BY 1);;

  }

  dimension: telecom {
    sql: ${TABLE}.telecom[Offset(0)].value ;;
  }

  dimension: ssn {
    hidden: yes
    type: string
    sql: cast(round(rand() * 100000, 0) as string) ;;
  }

  dimension: ssn_hashed {
    label: "Patient SSN"
    type: string
    description: "Only users with sufficient permissions will see this data"
    sql:
        CASE
          WHEN '{{_user_attributes["can_see_sensitive_data"]}}' = 'yes'
                THEN ${ssn}
                ELSE concat('###-##-',substr(${ssn},1,4))
                --ELSE TO_BASE64(SHA1(${ssn}))
          END ;;
  }

  #########  Measures  #########

  measure: count {
    label: "Number of Patients"
    type: count
    drill_fields: [name,organization.name,encounter.latest_encounter,encounter.recent_visits]
  }

#   measure: count_diabetics_with_comorbities {
#     label: "Number of Diabetics with Comorbities"
#     type: count
#     filters: [patient_facts.is_diabetic_with_comorbities: "Yes"]
#     drill_fields: [id, name, age]
#   }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

}

#########  Unnested Arrays  #########

### arrays with nested JSON ###
view: patient__address {
  label: "Patient"
  dimension: city {
    group_label: "Address"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    group_label: "Address"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: line {
    hidden: yes
    type: string
    sql: ${TABLE}.line ;;
  }

  dimension: postal_code {
    group_label: "Address"
    type: zipcode
    sql: ${TABLE}.postalCode ;;
  }

  dimension: state {
    group_label: "Address"
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.state ;;
  }
}

view: patient__communication {
  label: "Patient"
  dimension: language {
    hidden: yes
    sql: ${TABLE}.language ;;
  }

  dimension: language__text {
    label: "Language"
    sql: ${language}.text ;;
  }
}

view: patient__identifier {
  label: "Patient"
  dimension: system {
    group_label: "Identifier"
    hidden: yes
    type: string
    sql: ${TABLE}.system ;;
  }

  dimension: value {
    hidden: yes
    group_label: "Identifier"
    type: string
    sql: ${TABLE}.value ;;
  }
}

### arrays without nested fields ###
view: patient__meta__profile {
  label: "Patient"

  dimension: profile {
    hidden: yes
    label: " Profile"
    sql: ${TABLE} ;;
  }
}

# ### Contact
#
# view: patient__contact__period {
#   label: "Patient"
#   dimension: end {
#     group_label: "Contact Period"
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     group_label: "Contact Period"
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__contact__address {
#   label: "Patient"
#   dimension: city {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.city ;;
#   }
#
#   dimension: country {
#     group_label: "Contact"
#     type: string
#     map_layer_name: countries
#     sql: ${TABLE}.country ;;
#   }
#
#   dimension: district {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.district ;;
#   }
#
#   dimension: line {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.line ;;
#   }
#
#   dimension: period {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: postal_code {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.postalCode ;;
#   }
#
#   dimension: state {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.state ;;
#   }
#
#   dimension: text {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.text ;;
#   }
#
#   dimension: type {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.use ;;
#   }
# }
#
# view: patient__contact__address__period {
#   label: "Patient"
#   dimension: end {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__contact {
#   label: "Patient"
#   dimension: address {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.address ;;
#   }
#
#   dimension: gender {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.gender ;;
#   }
#
#   dimension: name {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.name ;;
#   }
#
#   dimension: organization {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.organization ;;
#   }
#
#   dimension: period {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: relationship {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.relationship ;;
#   }
#
#   dimension: telecom {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.telecom ;;
#   }
# }
#
# view: patient__contact__organization {
#   label: "Patient"
#   dimension: display {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__contact__organization__identifier__period {
#   label: "Patient"
#   dimension: end {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__contact__organization__identifier {
#   label: "Patient"
#   dimension: assigner {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__contact__organization__identifier__assigner {
#   label: "Patient"
#   dimension: display {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__contact__organization__identifier__assigner__identifier__period {
#   label: "Patient"
#   dimension: end {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__contact__organization__identifier__assigner__identifier {
#   label: "Patient"
#   dimension: assigner {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__contact__organization__identifier__assigner__identifier__assigner {
#   label: "Patient"
#   dimension: display {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: organization_id {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__contact__organization__identifier__assigner__identifier__type__coding {
#   label: "Patient"
#   dimension: code {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     group_label: "Contact"
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__contact__organization__identifier__assigner__identifier__type {
#   label: "Patient"
#   dimension: coding {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__contact__organization__identifier__type__coding {
#   label: "Patient"
#   dimension: code {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     group_label: "Contact"
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__contact__organization__identifier__type {
#   label: "Patient"
#   dimension: coding {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__contact__name {
#   label: "Patient"
#   dimension: family {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.family ;;
#   }
#
#   dimension: given {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.given ;;
#   }
#
#   dimension: period {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: prefix {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.prefix ;;
#   }
#
#   dimension: suffix {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.suffix ;;
#   }
#
#   dimension: text {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.text ;;
#   }
#
#   dimension: use {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.use ;;
#   }
# }
#
# view: patient__contact__name__period {
#   label: "Patient"
#   dimension: end {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__contact__telecom__period {
#   label: "Patient"
#   dimension: end {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__contact__telecom {
#   label: "Patient"
#   dimension: period {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: rank {
#     group_label: "Contact"
#     type: number
#     sql: ${TABLE}.rank ;;
#   }
#
#   dimension: system {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: use {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__contact__relationship__coding {
#   label: "Patient"
#   dimension: code {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     group_label: "Contact"
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__contact__relationship {
#   label: "Patient"
#   dimension: coding {
#     group_label: "Contact"
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     group_label: "Contact"
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }

#
# view: patient {
#   sql_table_name: `lookerdata.healthcare_demo_data.Patient`
#     ;;
#   drill_fields: [id]
#
#   dimension: id {
#     primary_key: yes
#     type: string
#     sql: ${TABLE}.id ;;
#   }
#
#   dimension: active {
#     type: yesno
#     sql: ${TABLE}.active ;;
#   }
#
#   dimension: address {
#     hidden: yes
#     sql: ${TABLE}.address ;;
#   }
#
#   dimension: animal {
#     hidden: yes
#     sql: ${TABLE}.animal ;;
#   }
#
#   dimension: birth_date {
#     type: string
#     sql: ${TABLE}.birthDate ;;
#   }
#
#   dimension: birth_place {
#     hidden: yes
#     sql: ${TABLE}.birthPlace ;;
#   }
#
#   dimension: communication {
#     hidden: yes
#     sql: ${TABLE}.communication ;;
#   }
#
#   dimension: contact {
#     hidden: yes
#     sql: ${TABLE}.contact ;;
#   }
#
#   dimension: deceased {
#     hidden: yes
#     sql: ${TABLE}.deceased ;;
#   }
#
#   dimension: disability_adjusted_life_years {
#     hidden: yes
#     sql: ${TABLE}.disability_adjusted_life_years ;;
#   }
#
#   dimension: gender {
#     type: string
#     sql: ${TABLE}.gender ;;
#   }
#
#   dimension: general_practitioner {
#     hidden: yes
#     sql: ${TABLE}.generalPractitioner ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: implicit_rules {
#     type: string
#     sql: ${TABLE}.implicitRules ;;
#   }
#
#   dimension: language {
#     type: string
#     sql: ${TABLE}.language ;;
#   }
#
#   dimension: link {
#     hidden: yes
#     sql: ${TABLE}.link ;;
#   }
#
#   dimension: managing_organization {
#     hidden: yes
#     sql: ${TABLE}.managingOrganization ;;
#   }
#
#   dimension: marital_status {
#     hidden: yes
#     sql: ${TABLE}.maritalStatus ;;
#   }
#
#   dimension: meta {
#     hidden: yes
#     sql: ${TABLE}.meta ;;
#   }
#
#   dimension: multiple_birth {
#     hidden: yes
#     sql: ${TABLE}.multipleBirth ;;
#   }
#
#   dimension: name {
#     hidden: yes
#     sql: ${TABLE}.name ;;
#   }
#
#   dimension: patient_mothers_maiden_name {
#     hidden: yes
#     sql: ${TABLE}.patient_mothersMaidenName ;;
#   }
#
#   dimension: photo {
#     hidden: yes
#     sql: ${TABLE}.photo ;;
#   }
#
#   dimension: quality_adjusted_life_years {
#     hidden: yes
#     sql: ${TABLE}.quality_adjusted_life_years ;;
#   }
#
#   dimension: shr_actor_fictional_person_extension {
#     hidden: yes
#     sql: ${TABLE}.shr_actor_FictionalPerson_extension ;;
#   }
#
#   dimension: shr_demographics_social_security_number_extension {
#     hidden: yes
#     sql: ${TABLE}.shr_demographics_SocialSecurityNumber_extension ;;
#   }
#
#   dimension: shr_entity_fathers_name_extension {
#     hidden: yes
#     sql: ${TABLE}.shr_entity_FathersName_extension ;;
#   }
#
#   dimension: shr_entity_person_extension {
#     hidden: yes
#     sql: ${TABLE}.shr_entity_Person_extension ;;
#   }
#
#   dimension: telecom {
#     hidden: yes
#     sql: ${TABLE}.telecom ;;
#   }
#
#   dimension: text {
#     hidden: yes
#     sql: ${TABLE}.text ;;
#   }
#
#   dimension: us_core_birthsex {
#     hidden: yes
#     sql: ${TABLE}.us_core_birthsex ;;
#   }
#
#   dimension: us_core_ethnicity {
#     hidden: yes
#     sql: ${TABLE}.us_core_ethnicity ;;
#   }
#
#   dimension: us_core_race {
#     hidden: yes
#     sql: ${TABLE}.us_core_race ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: [id, name, patient_mothers_maiden_name]
#   }
# }
#
# view: patient__deceased {
#   dimension: boolean {
#     type: yesno
#     sql: ${TABLE}.boolean ;;
#   }
#
#   dimension: date_time {
#     type: string
#     sql: ${TABLE}.dateTime ;;
#   }
# }
#
# view: patient__shr_actor_fictional_person_extension__value {
#   dimension: boolean {
#     type: yesno
#     sql: ${TABLE}.boolean ;;
#   }
# }
#
# view: patient__us_core_race__text__value {
#   dimension: string {
#     type: string
#     sql: ${TABLE}.string ;;
#   }
# }
#
# view: patient__us_core_race__omb_category__value__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
# }
#
# view: patient__link__other {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: patient_id {
#     type: string
#     sql: ${TABLE}.patientId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
#
#   dimension: related_person_id {
#     type: string
#     sql: ${TABLE}.relatedPersonId ;;
#   }
# }
#
# view: patient__link__other__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__link__other__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__link__other__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__link__other__identifier__assigner__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__link__other__identifier__assigner__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__link__other__identifier__assigner__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__link__other__identifier__assigner__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__link__other__identifier__assigner__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__link__other__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__link__other__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__link {
#   dimension: other {
#     hidden: yes
#     sql: ${TABLE}.other ;;
#   }
#
#   dimension: type {
#     type: string
#     sql: ${TABLE}.type ;;
#   }
# }
#
# view: patient__disability_adjusted_life_years__value {
#   dimension: decimal {
#     type: number
#     sql: ${TABLE}.decimal ;;
#   }
# }
#
# view: patient__shr_entity_person_extension__value__reference {
#   dimension: basic_id {
#     type: string
#     sql: ${TABLE}.basicId ;;
#   }
# }
#
# view: patient__birth_place__value__address {
#   dimension: city {
#     type: string
#     sql: ${TABLE}.city ;;
#   }
#
#   dimension: country {
#     type: string
#     map_layer_name: countries
#     sql: ${TABLE}.country ;;
#   }
#
#   dimension: state {
#     type: string
#     sql: ${TABLE}.state ;;
#   }
# }
#
# view: patient__general_practitioner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: practitioner_id {
#     type: string
#     sql: ${TABLE}.practitionerId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__general_practitioner__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__assigner__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__assigner__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__assigner__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__assigner__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__assigner__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__general_practitioner__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__telecom__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__telecom {
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: rank {
#     type: number
#     sql: ${TABLE}.rank ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__text {
#   dimension: div {
#     type: string
#     sql: ${TABLE}.div ;;
#   }
#
#   dimension: status {
#     type: string
#     sql: ${TABLE}.status ;;
#   }
# }
#
# view: patient__communication__language__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__communication__language {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__communication {
#   dimension: language {
#     hidden: yes
#     sql: ${TABLE}.language ;;
#   }
#
#   dimension: preferred {
#     type: yesno
#     sql: ${TABLE}.preferred ;;
#   }
# }
#
# view: patient__us_core_ethnicity__text__value {
#   dimension: string {
#     type: string
#     sql: ${TABLE}.string ;;
#   }
# }
#
# view: patient__us_core_ethnicity__omb_category__value__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
# }
#
# view: patient__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__identifier__assigner__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__identifier__assigner__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__identifier__assigner__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__identifier__assigner__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__identifier__assigner__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__address {
#   dimension: city {
#     type: string
#     sql: ${TABLE}.city ;;
#   }
#
#   dimension: country {
#     type: string
#     map_layer_name: countries
#     sql: ${TABLE}.country ;;
#   }
#
#   dimension: district {
#     type: string
#     sql: ${TABLE}.district ;;
#   }
#
#   dimension: geolocation {
#     hidden: yes
#     sql: ${TABLE}.geolocation ;;
#   }
#
#   dimension: line {
#     type: string
#     sql: ${TABLE}.line ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: postal_code {
#     type: string
#     sql: ${TABLE}.postalCode ;;
#   }
#
#   dimension: state {
#     type: string
#     sql: ${TABLE}.state ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
#
#   dimension: type {
#     type: string
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
# }
#
# view: patient__address__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__address__geolocation__latitude__value {
#   dimension: decimal {
#     type: number
#     sql: ${TABLE}.decimal ;;
#   }
# }
#
# view: patient__address__geolocation__longitude__value {
#   dimension: decimal {
#     type: number
#     sql: ${TABLE}.decimal ;;
#   }
# }
#
# view: patient__shr_demographics_social_security_number_extension__value {
#   dimension: string {
#     type: string
#     sql: ${TABLE}.string ;;
#   }
# }
#
# view: patient__photo {
#   dimension: content_type {
#     type: string
#     sql: ${TABLE}.contentType ;;
#   }
#
#   dimension: creation {
#     type: string
#     sql: ${TABLE}.creation ;;
#   }
#
#   dimension: data {
#     type: string
#     sql: ${TABLE}.data ;;
#   }
#
#   dimension: hash {
#     type: string
#     sql: ${TABLE}.`hash` ;;
#   }
#
#   dimension: language {
#     type: string
#     sql: ${TABLE}.language ;;
#   }
#
#   dimension: size {
#     type: number
#     sql: ${TABLE}.size ;;
#   }
#
#   dimension: title {
#     type: string
#     sql: ${TABLE}.title ;;
#   }
#
#   dimension: url {
#     type: string
#     sql: ${TABLE}.url ;;
#   }
# }
#
# view: patient__shr_entity_fathers_name_extension__value__human_name {
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__us_core_birthsex__value {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
# }
#
# view: patient__multiple_birth {
#   dimension: boolean {
#     type: yesno
#     sql: ${TABLE}.boolean ;;
#   }
#
#   dimension: integer {
#     type: number
#     sql: ${TABLE}.integer ;;
#   }
# }
#
# view: patient__managing_organization {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__managing_organization__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__managing_organization__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__managing_organization__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: identifier {
#     hidden: yes
#     sql: ${TABLE}.identifier ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__managing_organization__identifier__assigner__identifier__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__managing_organization__identifier__assigner__identifier {
#   dimension: assigner {
#     hidden: yes
#     sql: ${TABLE}.assigner ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: type {
#     hidden: yes
#     sql: ${TABLE}.type ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
#
#   dimension: value {
#     type: string
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__managing_organization__identifier__assigner__identifier__assigner {
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: organization_id {
#     type: string
#     sql: ${TABLE}.organizationId ;;
#   }
#
#   dimension: reference {
#     type: string
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__managing_organization__identifier__assigner__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__managing_organization__identifier__assigner__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__managing_organization__identifier__type__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__managing_organization__identifier__type {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__meta {
#   dimension_group: last_updated {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.lastUpdated ;;
#   }
#
#   dimension: profile {
#     type: string
#     sql: ${TABLE}.profile ;;
#   }
#
#   dimension: security {
#     hidden: yes
#     sql: ${TABLE}.security ;;
#   }
#
#   dimension: tag {
#     hidden: yes
#     sql: ${TABLE}.tag ;;
#   }
#
#   dimension: version_id {
#     type: string
#     sql: ${TABLE}.versionId ;;
#   }
# }
#
# view: patient__meta__security {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__meta__tag {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__name {
#   dimension: family {
#     type: string
#     sql: ${TABLE}.family ;;
#   }
#
#   dimension: given {
#     type: string
#     sql: ${TABLE}.given ;;
#   }
#
#   dimension: period {
#     hidden: yes
#     sql: ${TABLE}.period ;;
#   }
#
#   dimension: prefix {
#     type: string
#     sql: ${TABLE}.prefix ;;
#   }
#
#   dimension: suffix {
#     type: string
#     sql: ${TABLE}.suffix ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
#
#   dimension: use {
#     type: string
#     sql: ${TABLE}.use ;;
#   }
# }
#
# view: patient__name__period {
#   dimension: end {
#     type: string
#     sql: ${TABLE}.`end` ;;
#   }
#
#   dimension: start {
#     type: string
#     sql: ${TABLE}.start ;;
#   }
# }
#
# view: patient__animal__species__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__animal__species {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__animal__breed__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__animal__breed {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__animal__gender_status__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__animal__gender_status {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__patient_mothers_maiden_name__value {
#   dimension: string {
#     type: string
#     sql: ${TABLE}.string ;;
#   }
# }
#
# view: patient__marital_status__coding {
#   dimension: code {
#     type: string
#     sql: ${TABLE}.code ;;
#   }
#
#   dimension: display {
#     type: string
#     sql: ${TABLE}.display ;;
#   }
#
#   dimension: system {
#     type: string
#     sql: ${TABLE}.system ;;
#   }
#
#   dimension: user_selected {
#     type: yesno
#     sql: ${TABLE}.userSelected ;;
#   }
#
#   dimension: version {
#     type: string
#     sql: ${TABLE}.version ;;
#   }
# }
#
# view: patient__marital_status {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
#
#   dimension: text {
#     type: string
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__quality_adjusted_life_years__value {
#   dimension: decimal {
#     type: number
#     sql: ${TABLE}.decimal ;;
#   }
# }
#
# view: patient__shr_actor_fictional_person_extension {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__us_core_race__text {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__us_core_race__omb_category__value {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
# }
#
# view: patient__disability_adjusted_life_years {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__shr_entity_person_extension__value {
#   dimension: reference {
#     hidden: yes
#     sql: ${TABLE}.reference ;;
#   }
# }
#
# view: patient__birth_place__value {
#   dimension: address {
#     hidden: yes
#     sql: ${TABLE}.address ;;
#   }
# }
#
# view: patient__us_core_ethnicity__text {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__us_core_ethnicity__omb_category__value {
#   dimension: coding {
#     hidden: yes
#     sql: ${TABLE}.coding ;;
#   }
# }
#
# view: patient__address__geolocation__latitude {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__address__geolocation__longitude {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__shr_demographics_social_security_number_extension {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__shr_entity_fathers_name_extension__value {
#   dimension: human_name {
#     hidden: yes
#     sql: ${TABLE}.humanName ;;
#   }
# }
#
# view: patient__us_core_birthsex {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__animal {
#   dimension: breed {
#     hidden: yes
#     sql: ${TABLE}.breed ;;
#   }
#
#   dimension: gender_status {
#     hidden: yes
#     sql: ${TABLE}.genderStatus ;;
#   }
#
#   dimension: species {
#     hidden: yes
#     sql: ${TABLE}.species ;;
#   }
# }
#
# view: patient__patient_mothers_maiden_name {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__quality_adjusted_life_years {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__us_core_race {
#   dimension: omb_category {
#     hidden: yes
#     sql: ${TABLE}.ombCategory ;;
#   }
#
#   dimension: text {
#     hidden: yes
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__us_core_race__omb_category {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__shr_entity_person_extension {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__birth_place {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__us_core_ethnicity {
#   dimension: omb_category {
#     hidden: yes
#     sql: ${TABLE}.ombCategory ;;
#   }
#
#   dimension: text {
#     hidden: yes
#     sql: ${TABLE}.text ;;
#   }
# }
#
# view: patient__us_core_ethnicity__omb_category {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
#
# view: patient__address__geolocation {
#   dimension: latitude {
#     hidden: yes
#     sql: ${TABLE}.latitude ;;
#   }
#
#   dimension: longitude {
#     hidden: yes
#     sql: ${TABLE}.longitude ;;
#   }
# }
#
# view: patient__shr_entity_fathers_name_extension {
#   dimension: value {
#     hidden: yes
#     sql: ${TABLE}.value ;;
#   }
# }
