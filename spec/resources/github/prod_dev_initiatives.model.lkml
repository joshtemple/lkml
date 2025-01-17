connection: "initiatives-db"

# include all the views
include: "prod_dev_initiatives/*.view"

# datagroup: proddev_initiatives_default_datagroup {
#  sql_trigger: SELECT MAX(id) FROM etl_log;;
#  max_cache_age: "1 hour"
#}

# persist_with: proddev_initiatives_default_datagroup

explore: engineering_team {}

explore: goal {
  join: initiative {
    type: left_outer
    sql_on: ${goal.initiative_id} = ${initiative.id} ;;
    relationship: many_to_one
  }
}

explore: initiative {
  description: "ProdDev Initiatives Explore (START HERE)"
  from: initiative_with_staffing_measures

  join: goal {
    sql_on: ${goal.initiative_id} = ${initiative.id} ;;
    relationship: many_to_many
  }

  join: type {
    view_label: "Initiative"
    sql_on: ${type.id} = ${initiative.type_id} ;;
    relationship: many_to_one
    fields: [type.value]
  }

  join: status {
    view_label: "Initiative"
    sql_on: ${status.id} = ${initiative.status_id} ;;
    relationship: many_to_one
    fields: [status.value]
  }

  join: target_release {
    view_label: "Initiative"
    sql_on: ${target_release.id} = ${initiative.target_release_id} ;;
    relationship: many_to_one
    fields: [target_release.value]
  }

  #
  # Function Lead Engineering JOINs
  #
  join: function_lead_engineering {
    view_label: "Function Lead Engineering"
    from: resource
    sql_on: ${initiative.function_lead_engineering_id} = ${function_lead_engineering.id} ;;
    relationship: many_to_one
  }

  join: function_lead_engineering_work_area {
    view_label: "Function Lead Engineering"
    from: work_area
    sql_on: ${function_lead_engineering.work_area_id} = ${function_lead_engineering_work_area.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_engineering_team {
    view_label: "Function Lead Engineering"
    from: engineering_team
    sql_on: ${function_lead_engineering.engineering_team_id} = ${function_lead_engineering_team.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_engineering_office_location {
    view_label: "Function Lead Engineering"
    from: office_location
    sql_on: ${function_lead_engineering.office_location_id} = ${function_lead_engineering_office_location.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_engineering_os_specialization {
    from: os_specialization
    view_label: "Function Lead Engineering"
    sql_on: ${function_lead_engineering.os_specialization_id} = ${function_lead_engineering_os_specialization.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_engineering_orc_role {
    from: orc_role
    view_label: "Function Lead Engineering"
    sql_on: ${function_lead_engineering.orc_role_id} = ${function_lead_engineering_orc_role.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_engineering_work_status {
    from: work_status
    view_label: "Function Lead Engineering"
    sql_on: ${function_lead_engineering.work_status_id} = ${function_lead_engineering_work_status.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  #
  # Function Lead Engineering JOINs
  #
  join: function_lead_other {
    view_label: "Function Lead Other"
    from: resource
    sql_on: ${initiative.function_lead_other_id} = ${function_lead_other.id} ;;
    relationship: many_to_one
  }

  join: function_lead_other_work_area {
    view_label: "Function Lead Other"
    from: work_area
    sql_on: ${function_lead_other.work_area_id} = ${function_lead_other_work_area.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_other_team {
    view_label: "Function Lead Other"
    from: engineering_team
    sql_on: ${function_lead_other.engineering_team_id} = ${function_lead_other_team.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_other_office_location {
    view_label: "Function Lead Other"
    from: office_location
    sql_on: ${function_lead_other.office_location_id} = ${function_lead_other_office_location.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_other_os_specialization {
    from: os_specialization
    view_label: "Function Lead Other"
    sql_on: ${function_lead_other.os_specialization_id} = ${function_lead_other_os_specialization.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_other_orc_role {
    from: orc_role
    view_label: "Function Lead Other"
    sql_on: ${function_lead_other.orc_role_id} = ${function_lead_other_orc_role.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_other_work_status {
    from: work_status
    view_label: "Function Lead Other"
    sql_on: ${function_lead_other.work_status_id} = ${function_lead_other_work_status.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  #
  # Function Lead Product JOINs
  #
  join: function_lead_product {
    view_label: "Function Lead Product"
    from: resource
    sql_on: ${initiative.function_lead_product_id} = ${function_lead_product.id} ;;
    relationship: many_to_one
  }

  join: function_lead_product_work_area {
    view_label: "Function Lead Product"
    from: work_area
    sql_on: ${function_lead_product.work_area_id} = ${function_lead_product_work_area.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_product_team {
    view_label: "Function Lead Product"
    from: engineering_team
    sql_on: ${function_lead_product.engineering_team_id} = ${function_lead_product_team.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_product_office_location {
    view_label: "Function Lead Product"
    from: office_location
    sql_on: ${function_lead_product.office_location_id} = ${function_lead_product_office_location.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_product_os_specialization {
    from: os_specialization
    view_label: "Function Lead Product"
    sql_on: ${function_lead_product.os_specialization_id} = ${function_lead_product_os_specialization.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_product_orc_role {
    from: orc_role
    view_label: "Function Lead Product"
    sql_on: ${function_lead_product.orc_role_id} = ${function_lead_product_orc_role.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: function_lead_product_work_status {
    from: work_status
    view_label: "Function Lead Product"
    sql_on: ${function_lead_product.work_status_id} = ${function_lead_product_work_status.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  #
  # Staffing Allocation
  #
  join: staffing_allocation {
    view_label: "Staffing Allocation"
    sql_on: ${staffing_allocation.initiative_id} = ${initiative.id} ;;
    relationship: one_to_many
  }

  join: resource {
    view_label: "Staffing Allocation Resource"
    sql_on: ${staffing_allocation.resource_id} = ${resource.id} ;;
    relationship: many_to_one
  }

  join: resource_manager {
    from: resource
    view_label: "Staffing Allocation Manager"
    sql_on: ${resource.manager_id} = ${resource_manager.id} ;;
    relationship: many_to_one
    fields: [first_name, last_name, email]
  }

  join: work_area {
    view_label: "Staffing Allocation Resource"
    sql_on: ${resource.work_area_id} = ${work_area.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: engineering_team {
    view_label: "Staffing Allocation Resource"
    sql_on: ${resource.engineering_team_id} = ${engineering_team.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: office_location {
    view_label: "Staffing Allocation Resource"
    sql_on: ${resource.office_location_id} = ${office_location.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: os_specialization {
    view_label: "Staffing Allocation Resource"
    sql_on: ${resource.os_specialization_id} = ${os_specialization.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: orc_role {
    view_label: "Staffing Allocation Resource"
    sql_on: ${resource.orc_role_id} = ${orc_role.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  join: work_status {
    view_label: "Staffing Allocation Resource"
    sql_on: ${resource.work_status_id} = ${work_status.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  #
  # Staffing Need
  #
  join: staffing_need {
    view_label: "Staffing Need"
    sql_on: ${staffing_need.initiative_id} = ${initiative.id} ;;
    relationship: one_to_many
  }

  join: work_area_need {
    view_label: "Staffing Need"
    from: work_area
    sql_on: ${staffing_need.work_area_id} = ${work_area_need.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }

  #
  # Initiative Milestones
  #
  join: milestone {
    sql_on: ${milestone.initiative_id} = ${initiative.id} ;;
    relationship: many_to_one
  }
}

explore: milestone {
  join: initiative {
    sql_on: ${milestone.initiative_id} = ${initiative.id} ;;
    relationship: many_to_one
  }
}

explore: office_location {}

explore: orc_role {}

explore: os_specialization {}

# This NDT allows for all the joins in the resource explore to be referenced as a single view
explore: resource_denormalized_ndt {}

explore: resource {
  join: resource_engineering_team {
    from: engineering_team
    type: left_outer
    sql_on: ${resource.engineering_team_id} = ${resource_engineering_team.id} ;;
    relationship: many_to_one
  }

  join: resource_office_location {
    from: office_location
    type: left_outer
    sql_on: ${resource.office_location_id} = ${resource_office_location.id} ;;
    relationship: many_to_one
  }

  join: resource_work_area {
    from: work_area
    type: left_outer
    sql_on: ${resource.work_area_id} = ${resource_work_area.id} ;;
    relationship: many_to_one
  }

  join: resource_os_specialization {
    from: os_specialization
    type: left_outer
    sql_on: ${resource.os_specialization_id} = ${resource_os_specialization.id} ;;
    relationship: many_to_one
  }

  join: resource_orc_role {
    from: orc_role
    type: left_outer
    sql_on: ${resource.orc_role_id} = ${resource_orc_role.id} ;;
    relationship: many_to_one
  }

  join: resource_work_status {
    from: work_status
    type: left_outer
    sql_on: ${resource.work_status_id} = ${resource_work_status.id} ;;
    relationship: many_to_one
  }

  join: resource_staffing_allocation {
    from: staffing_allocation
    sql_on: ${resource.id} = ${resource_staffing_allocation.resource_id} ;;
    relationship: many_to_one
  }

  join: resource_initiative {
    from: initiative
    sql_on:  ${resource_initiative.id} = ${resource_staffing_allocation.initiative_id} ;;
    relationship: many_to_one
  }

  join: resource_primary_specialization {
    from: specialization
    sql_on: ${resource.primary_specialization_id} = ${resource_primary_specialization.id} ;;
    relationship: many_to_one
  }

  join: resource_secondary_specialization {
    from: specialization
    sql_on: ${resource.secondary_specialization_id} = ${resource_secondary_specialization.id} ;;
    relationship: many_to_one
  }

  join: resource_manager {
    from: resource
    sql_on:  ${resource.manager_id} = ${resource_manager.id} ;;
    relationship: many_to_one
  }
}

explore: specialization {}

explore: staffing_allocation {
  join: resource {
    type: left_outer
    sql_on: ${staffing_allocation.resource_id} = ${resource.id} ;;
    relationship: many_to_one
  }

  join: initiative {
    type: left_outer
    sql_on: ${staffing_allocation.initiative_id} = ${initiative.id} ;;
    relationship: many_to_one
  }

  join: engineering_team {
    type: left_outer
    sql_on: ${resource.engineering_team_id} = ${engineering_team.id} ;;
    relationship: many_to_one
  }

  join: office_location {
    type: left_outer
    sql_on: ${resource.office_location_id} = ${office_location.id} ;;
    relationship: many_to_one
  }

  join: work_area {
    type: left_outer
    sql_on: ${resource.work_area_id} = ${work_area.id} ;;
    relationship: many_to_one
  }

  join: os_specialization {
    type: left_outer
    sql_on: ${resource.os_specialization_id} = ${os_specialization.id} ;;
    relationship: many_to_one
  }

  join: orc_role {
    type: left_outer
    sql_on: ${resource.orc_role_id} = ${orc_role.id} ;;
    relationship: many_to_one
  }

  join: work_status {
    type: left_outer
    sql_on: ${resource.work_status_id} = ${work_status.id} ;;
    relationship: many_to_one
  }
}

explore: staffing_need {
  join: initiative {
    type: left_outer
    sql_on: ${staffing_need.initiative_id} = ${initiative.id} ;;
    relationship: many_to_one
  }

  join: work_area {
    type: left_outer
    sql_on: ${staffing_need.work_area_id} = ${work_area.id} ;;
    relationship: many_to_one
  }
}

# This NDT allows for all the joins in the initiative_need_vs_allocation explore to be referenced as a single view
explore: initiative_need_vs_allocation_ndt {}

explore: initiative_need_vs_allocation {
  description: "Initiative needs joined to allocations based on date and work area"
  from: staffing_allocation

  #
  # Allocation Resource
  #
  join: staffing_allocation_resource {
    from: resource_denormalized_ndt
    sql_on: ${initiative_need_vs_allocation.resource_id} = ${staffing_allocation_resource.id} ;;

    # A given initiatve allocation (resource, week, workarea) uses one resource, while a resource may be used for many allocations
    relationship: one_to_many
  }

  #
  # Needs
  #
  join: staffing_need {
    sql_on:
      ${initiative_need_vs_allocation.initiative_id} = ${staffing_need.initiative_id}
      AND ${initiative_need_vs_allocation.week_date} = ${staffing_need.week_date}
      AND ${staffing_allocation_resource.work_area_id} = ${staffing_need.work_area_id} ;;

    # A given initiative allocation (resource, week, workarea) is done for one need, whereas a need (week, workarea) may receive many allocations
    relationship: many_to_one

    # Include allocations w/o needs and needs w/o allocations
    type: full_outer

    sql_where: ${staffing_need.week_date} IS NOT NULL OR ${initiative_need_vs_allocation.week_date} IS NOT NULL ;;
  }

  join: staffing_need_work_area {
    view_label: "Staffing Need"
    from: work_area
    sql_on: ${staffing_need.work_area_id} = ${staffing_need_work_area.id} ;;
    relationship: many_to_one
    fields: [value, count]
  }
}

explore: initiative2 {
  view_label: "Initiative"
  description: "ProdDev Initiatives Explore (START HERE)"
  from: initiative

  join: goal {
    sql_on: ${goal.initiative_id} = ${initiative2.id} ;;
    relationship: many_to_many
  }

  join: type {
    view_label: "Initiative"
    sql_on: ${type.id} = ${initiative2.type_id} ;;
    relationship: many_to_one
    fields: [type.value]
  }

  join: status {
    view_label: "Initiative"
    sql_on: ${status.id} = ${initiative2.status_id} ;;
    relationship: many_to_one
    fields: [status.value]
  }

  join: target_release {
    view_label: "Release Target"
    sql_on: ${target_release.id} = ${initiative2.target_release_id} ;;
    relationship: many_to_one
    fields: [target_release.value]
  }

  join: milestone {
    sql_on: ${milestone.initiative_id} = ${initiative2.id} ;;
    relationship: many_to_one
  }

  #
  # Pull in all related needs and allocations
  #
  join: initiative_need_vs_allocation_ndt {
    view_label: "Need vs Allocation"
    sql_on: ${initiative2.id} = ${initiative_need_vs_allocation_ndt.initiative_id} ;;
    relationship: one_to_many
  }

  join: initiative_resource_classification_ndt {
    view_label: "Need vs Allocation Classification"
    sql_on:
      ${initiative2.id} = ${initiative_resource_classification_ndt.initiative_id}
      AND ${initiative_need_vs_allocation_ndt.report_week_date} = ${initiative_resource_classification_ndt.report_week_date}
      AND ${initiative_need_vs_allocation_ndt.work_area} = ${initiative_resource_classification_ndt.work_area}
      ;;
    relationship: one_to_many
  }

  join: dates_seen {
    view_label: "Need vs Allocation Dates"
    sql_on: ${dates_seen.report_week_date} = ${initiative_resource_classification_ndt.report_week_date} ;;
    relationship: many_to_one
    type: full_outer
    sql_where: ${dates_seen.report_week_date} IS NOT NULL ;;
  }

  #
  # Function Lead Engineering JOINs
  #
  join: function_lead_engineering {
    view_label: "Function Lead Engineering"
    from: resource_denormalized_ndt
    sql_on: ${initiative2.function_lead_engineering_id} = ${function_lead_engineering.id} ;;
    relationship: many_to_one
  }

  #
  # Function Lead Engineering JOINs
  #
  join: function_lead_other {
    view_label: "Function Lead Other"
    from: resource_denormalized_ndt
    sql_on: ${initiative2.function_lead_other_id} = ${function_lead_other.id} ;;
    relationship: many_to_one
  }

  #
  # Function Lead Product JOINs
  #
  join: function_lead_product {
    view_label: "Function Lead Product"
    from: resource_denormalized_ndt
    sql_on: ${initiative2.function_lead_product_id} = ${function_lead_product.id} ;;
    relationship: many_to_one
  }
}

explore: initiative_resource_classification_ndt {}
explore: initiative_need_vs_allocated_rollup {
  description: "Quick view for allocation vs need analysis"
  hidden: yes
}
view: initiative_need_vs_allocated_rollup {
  derived_table: {
    explore_source: initiative {
      column: staffed {}
      column: staffing_ratio {}
      column: need_pct { field: staffing_need.need_pct }
      column: allocation_pct { field: staffing_allocation.allocation_pct }
      column: guid {}
    }
  }
  dimension: staffed {
    label: "Initiative Staffed"
    description: "Is the initiative staffed (> 0.75 ratio of allocation over need)"
    type: yesno
  }
  dimension: staffing_ratio {
    description: "Ratio of allocation over need"
    type: number
  }
  dimension: need_pct {
    description: "Sum of all staffing need values"
    type: number
  }
  dimension: allocation_pct {
    description: "Sum of all staffing allocation values"
    type: number
  }
  dimension: guid {
    primary_key: yes
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: need_pct_sum {
    type: sum
    sql: ${need_pct} ;;
  }

  measure: staffing_ratio_avg {
    type: average
    sql: ${staffing_ratio} ;;
  }

  measure: allocation_pct_sum {
    type: sum
    sql: ${allocation_pct} ;;
  }

  set: detail {
    fields: [
      guid,
      staffed,
      staffing_ratio,
      need_pct,
      allocation_pct,
      guid
    ]
  }
}

explore: bucket_resources_by_initiative_count {
  from: bucket_resources_by_initiative_count_ndt
  description: "Bucket resources by the number of initiatives they are allocated to"
}

explore: work_area {}

explore: work_status {}
