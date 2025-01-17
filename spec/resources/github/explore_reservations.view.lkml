
include: "../reservations.view.lkml"
include: "../reservation_slots.view.lkml"
include: "../clients.view.lkml"
include: "../client_demographics.view.lkml"
include: "../client_service_dates.view.lkml"
include: "../client_services.view.lkml"
include: "../service_items.view.lkml"
include: "../services.view.lkml"
include: "../agencies.view.lkml"
include: "../counties.view.lkml"
include: "../latest_reservation.view.lkml"
include: "../geolocation/agencies_geolocations.view.lkml"

explore: reservations_by_date {

  label: "Reservations"
  from:  reservation_slots

  fields: [ALL_FIELDS*,
          client_services.account_option,
          -client_services.deleted,
          -clients.deleted] # this excluded field references a view that's not included in this explore

  access_filter:{field: agencies.id
    user_attribute: agency_id}
  access_filter:{field: agencies.coc
    user_attribute: agency_coc}
  access_filter:{field: agencies.county
    user_attribute: agency_county}

  conditionally_filter: {
    filters: {
      field: reservations_by_date.date
      value: "3 days ago for 10 days"
    }
  }

  join: reservations {
    sql_on:
      ${reservations.ref_service_item} = ${reservations_by_date.ref_service_item}
      AND ${reservations.date} = ${reservations_by_date.date}
      AND (
        (${reservations_by_date.reservation_option} = 'Designated' AND ${reservations.slot_id} = ${reservations_by_date.id})
        OR (${reservations_by_date.reservation_option} = 'Open' AND ${reservations.slot_num} = ${reservations_by_date.reservation_slot_number})
      )
      AND (${reservations.deleted} IS NULL OR ${reservations.deleted} = 0)
    ;;
    type:  left_outer
    relationship: many_to_one
  }

  join: clients {
    type: left_outer
    relationship: many_to_one
    sql_on: ${reservations.ref_client} = ${clients.id} AND (${clients.deleted} IS NULL OR ${clients.deleted} = 0) ;;
  }

  join: static_demographics {
    from: client_demographics
    type: inner
    view_label: "Clients"
    relationship: one_to_one
    fields: [
      id,
      gender,
      gender_text,
      ethnicity,
      ethnicity_text,
      ref_client,
      race,
      race_text,
      veteran,
      veteran_text,
      veteran_branch,
      veteran_discharge,
      veteran_theater_afg,
      veteran_theater_iraq1,
      veteran_theater_iraq2,
      veteran_theater_kw,
      veteran_theater_other,
      veteran_theater_pg,
      veteran_theater_vw,
      veteran_theater_ww2,
      zipcode,
      primary_language
    ]
    sql_on: ${clients.id} = ${static_demographics.ref_client} ;;
  }

  join: service_dates {
    fields: []
    type: left_outer
    relationship: many_to_one
    sql_on: ${service_dates.id} = ${reservations.ref_client_service_date} ;;
  }

  join: client_services {
    type: left_outer
    fields: [base_fields*]
    relationship: many_to_one
    sql_on: ${service_dates.ref_client_service} = ${client_services.id} AND (${client_services.deleted} IS NULL OR ${client_services.deleted} = 0) ;;
  }

  # Joins to trace back to the security
  join: service_items {
    type: inner
    fields: []
    relationship: many_to_one
    sql_on: ${reservations_by_date.ref_service_item} = ${service_items.id} AND (${service_items.deleted} IS NULL OR ${service_items.deleted} = 0) ;;
  }

  join: services {
    type: inner
    fields: [services.name, services.service_item_name]
    relationship: many_to_one
    sql_on: ${service_items.ref_service} = ${services.id} AND (services.deleted IS NULL OR services.deleted = 0) ;;
  }

  join: agencies {
    type: inner
    fields: [id, coc, county, name]
    relationship: many_to_one
    sql_on: ${services.ref_agency} = ${agencies.id} ;;
  }

  join: counties {
    fields: []
    relationship: many_to_one
    sql_on: ${counties.id} = ${agencies.ref_county} ;;
  }

  join: latest_reservation {
    relationship: many_to_one
    type: left_outer
    sql_on: ${reservations.id} = ${latest_reservation.latest_reservation_id} ;;
  }

}
