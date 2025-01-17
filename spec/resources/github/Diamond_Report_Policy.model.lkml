connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: policy {
  group_label: "Diamond Analytics (REPORT)"
  label: "Policy"
  view_label: "Policy"

  #Exclude records without policy number
  sql_always_where: ${current_policy} > ''  ;;

  join: non_renew_reason {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_many
    sql_on: ${non_renew_reason.nonrenewreason_id} = ${policy.nonrenewreason_id} ;;
  }

  join: quote_source {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_many
    sql_on: ${quote_source.quotesource_id} = ${policy.quotesource_id} ;;
  }

  join: policy_current_status {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_many
    sql_on: ${policy_current_status.policycurrentstatus_id} = ${policy.policycurrentstatus_id} ;;
  }

  join: policy_image {
    view_label: "Policy Image"
    type: inner
    relationship: one_to_one
    sql_on: ${policy_image.policy_id} = ${policy.policy_id} ;;
  }

  join: version {
    view_label: "Company"
    type: inner
    relationship: one_to_one
    sql_on: ${version.version_id} = ${policy_image.version_id} ;;
  }

  join: dt_policy_agency {
    view_label: "Policy Image"
    type: inner
    relationship: one_to_many
    sql_on: ${policy_image.policy_id} = ${dt_policy_agency.policy_id} ;;
  }

  join: dt_policy_agencyproducer {
    view_label: "Policy Image"
    type: left_outer
    relationship: one_to_many
    sql_on: ${policy_image.policy_id} = ${dt_policy_agencyproducer.policy_id} ;;
  }

  join: trans_reason {
    view_label: "Policy Image"
    type: left_outer
    relationship: one_to_many
    sql_on: ${trans_reason.transreason_id} = ${policy_image.transreason_id} ;;
  }

  join: trans_type {
    view_label: "Policy Image"
    type: left_outer
    relationship: one_to_many
    sql_on: ${trans_type.transtype_id} = ${policy_image.transtype_id} ;;
  }

  join: v_users {
    view_label: "Policy Image"
    type: inner
    relationship: one_to_many
    sql_on: ${v_users.users_id} = ${policy_image.trans_users_id} ;;
  }

  join: v_vehicle {
    view_label: "Vehicle"
    type: inner
    relationship: one_to_many
    sql_on: ${v_vehicle.policy_id} = ${policy_image.policy_id}
      AND ${v_vehicle.policyimage_num} = ${policy_image.policyimage_num} ;;
  }

  join: body_type {
    view_label: "Vehicle"
    type: inner
    relationship: one_to_many
    sql_on: ${body_type.bodytype_id} = ${v_vehicle.bodytype_id} ;;
  }

  join: performance_type {
    view_label: "Vehicle"
    type: inner
    relationship: one_to_many
    sql_on: ${performance_type.performancetype_id} = ${v_vehicle.performancetype_id} ;;
  }

  join: restraint_type {
    view_label: "Vehicle"
    type: inner
    relationship: one_to_many
    sql_on: ${restraint_type.restrainttype_id} = ${v_vehicle.restrainttype_id} ;;
  }

  join: vehicle_type {
    view_label: "Vehicle"
    type: inner
    relationship: one_to_many
    sql_on: ${vehicle_type.vehicletype_id} = ${v_vehicle.vehicletype_id} ;;
  }

  join: vehicle_use_type {
    view_label: "Vehicle"
    type: inner
    relationship: one_to_many
    sql_on: ${vehicle_use_type.vehicleusetype_id} = ${v_vehicle.vehicleusetype_id} ;;
  }

  join: driver {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${driver.policy_id} = ${policy_image.policy_id}
      AND ${driver.policyimage_num} = ${policy_image.policyimage_num} ;;
  }

  join: driver_name_link {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${driver_name_link.policy_id} = ${driver.policy_id}
          AND ${driver_name_link.policyimage_num} = ${driver.policyimage_num}
          AND ${driver_name_link.driver_num} = ${driver.driver_num} ;;
  }

  join: driver_name {
    view_label: "Driver"
    type: inner
    relationship: one_to_one
    sql_on: ${driver_name.name_id} = ${driver_name_link.name_id} ;;
  }

  join: marital_status {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${marital_status.maritalstatus_id} = ${driver_name.maritalstatus_id} ;;
  }

  join: sex {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${sex.sex_id} = ${driver_name.sex_id} ;;
  }

  join: driver_exclude_type {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${driver_exclude_type.driverexcludetype_id} = ${driver.driverexcludetype_id} ;;
  }

  join: driver_occupation_type {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${driver_occupation_type.driveroccupationtype_id} = ${driver.driveroccupationtype_id} ;;
  }

  join: license_status {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${license_status.licensestatus_id} = ${driver.licensestatus_id} ;;
  }

  join: license_type {
    view_label: "Driver"
    type: inner
    relationship: one_to_many
    sql_on: ${license_type.licensetype_id} = ${driver.licensetype_id} ;;
  }

  join: coverage {
    view_label: "Coverage"
    type: inner
    relationship: one_to_many
    sql_on: ${coverage.policy_id} = ${policy_image.policy_id}
          AND ${coverage.policyimage_num} = ${policy_image.policyimage_num}
          AND ${coverage.unit_num} = ${v_vehicle.vehicle_num} ;;
  }

  join: coverage_code {
    view_label: "Coverage"
    type: inner
    relationship: one_to_many
    sql_on: ${coverage_code.coveragecode_id} = ${coverage.coveragecode_id} ;;
  }

  join: coverage_limit {
    view_label: "Coverage"
    type: inner
    relationship: one_to_many
    sql_on: ${coverage_limit.coveragelimit_id} = ${coverage.coveragelimit_id} ;;
  }

  join: coverage_exposure {
    view_label: "Coverage"
    type: inner
    relationship: one_to_many
    sql_on: ${coverage_exposure.coverageexposure_id} = ${coverage.exposure} ;;
  }

  join: additional_interest {
    view_label: "Additional Interest"
    type: inner
    relationship: one_to_many
    sql_on: ${additional_interest.policy_id} = ${policy.policy_id}
      AND ${additional_interest.added_policyimage_num} = ${policy_image.policyimage_num};;
  }

  join: additional_interest_type {
    view_label: "Additional Interest"
    type: inner
    relationship: one_to_many
    sql_on: ${additional_interest_type.additionalinteresttype_id} = ${additional_interest.additionalinteresttype_id} ;;
  }

  join: claim_control {
    view_label: "Claim"
    type: left_outer
    relationship: many_to_one
    sql_on: ${claim_control.policy_id} = ${policy.policy_id} ;;
  }

  join: dt_summarized_claim_level_financials {
    view_label: "Claim  Financials"
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_control.claimcontrol_id} = ${dt_summarized_claim_level_financials.claimcontrol_id} ;;
  }
}
connection: "c76-reporting"

include: "/views/*.view.lkml"

explore: dt_retention_policy_by_agent {
  group_label: "Diamond Analytics (REPORT)"
  label: "Retention"
  view_label: "Retention"
  access_filter: {
    field: code
    user_attribute: agency_code
  }
}
