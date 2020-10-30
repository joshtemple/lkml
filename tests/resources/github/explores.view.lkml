include: "*.view"

explore: looker_users {
  label: "Looker Users"
  from:  looker_users

  join: instance_looker_users {
    view_label: "Looker Users"
    type: left_outer
    sql_on: ${looker_users.id} = ${instance_looker_users.looker_user_id} ;;
    relationship: one_to_many
  }

  join: instances {
    view_label: "Looker Users"
    type: left_outer
    sql_on: ${instance_looker_users.instance_id} = ${instances.instance_id} ;;
    relationship: one_to_many
  }
}


explore: clarity_instances {
  label: "Clarity Instances"
  from:  instances

  join: master_servers {
    view_label: "Clarity Instances"
    type: inner
    sql_on: ${clarity_instances.master_db_server_id} = ${master_servers.master_server_id} ;;
    relationship: many_to_one
  }

  join: reporting_servers {
    view_label: "Clarity Instances"
    type: inner
    sql_on: ${clarity_instances.slave_report_db_server_id} = ${reporting_servers.reporting_server_id} ;;
    relationship: many_to_one
    fields: [reporting_servers.basic_fields*]
  }

  join: analysis_servers {
    view_label: "Clarity Instances"
    type: inner
    sql_on: ${clarity_instances.slave_analysis_db_server_id} = ${analysis_servers.analysis_server_id} ;;
    relationship: many_to_one
    fields: [analysis_servers.basic_fields*]
  }

  join: database_servers {
    view_label: "Clarity Instances"
    type: inner
    sql_on: ${clarity_instances.database_id} = ${database_servers.database_id} ;;
    relationship: one_to_one
    fields: [database_servers.basic_fields*]
  }

  join: instance_agency_counts {
    view_label: "Clarity Instances"
    type: inner
    sql_on: ${clarity_instances.instance_id} = ${instance_agency_counts.instance_id} ;;
    relationship: one_to_one
  }

  join: instance_license_counts {
    view_label: "Clarity Licenses"
    type:  inner
    sql_on: ${clarity_instances.instance_id} = ${instance_license_counts.instance_id} ;;
    relationship: one_to_many
  }

  join: licenses {
    view_label: "Clarity Licenses"
    type: inner
    sql_on: ${instance_license_counts.license_id} = ${licenses.id} ;;
    relationship: many_to_one
  }

  join: transactions {
    view_label: "Clarity Licenses"
    type: inner
    sql_on: ${instance_license_counts.id} = ${transactions.instance_license_count_id} ;;
    relationship: one_to_many
  }

  join: instance_license_limiters {
    view_label: "Clarity Licenses"
    type: inner
    sql_on: ${clarity_instances.instance_id} = ${instance_license_limiters.instance_id} ;;
    relationship: one_to_many
  }

  join: license_limiters {
    view_label: "Clarity Licenses"
    type: inner
    sql_on: ${instance_license_limiters.license_limiter_id} = ${license_limiters.id}
      AND  ${licenses.id} = ${license_limiters.license_types_id};;
    relationship: many_to_one
  }

  join: license_editions {
    view_label: "Clarity Licenses"
    type: inner
    sql_on: ${clarity_instances.license_edition_id} = ${license_editions.license_edition_id} ;;
    relationship: many_to_one
  }

  join: license_edition_licenses {
    view_label: "Clarity Licenses"
    type: inner
    sql_on: ${license_editions.license_edition_id} = ${license_edition_licenses.license_edition_id}
      AND ${licenses.id} = ${license_edition_licenses.license_id} ;;
    relationship: one_to_many
  }

 join: aggregated_user_licenses {
    view_label: "Clarity Users"
    type: left_outer
    sql_on: ${instance_license_counts.instance_id} = ${aggregated_user_licenses.ops_instance_id}
        AND ${instance_license_counts.license_id} = ${aggregated_user_licenses.ops_license_id} ;;
    relationship: one_to_many
  }

  join: aggregated_users {
    view_label: "Clarity Users"
    type: left_outer
    sql_on: ${aggregated_user_licenses.ops_instance_id} = ${aggregated_users.ops_instance_id}
        AND ${aggregated_user_licenses.user_id} = ${aggregated_users.user_id} ;;
    relationship: many_to_one
    fields: [aggregated_users.basic_fields*]
  }

  join: user_instance_license_counts {
    view_label: "Clarity Users"
    type:  left_outer
    sql_on: ${aggregated_user_licenses.ops_instance_id} = ${user_instance_license_counts.instance_id}
      AND ${aggregated_user_licenses.ops_license_id} = ${user_instance_license_counts.license_id}
      AND ${aggregated_users.user_id} = ${aggregated_user_licenses.user_id} ;;
    relationship: one_to_one
  }

  join: instance_looker_users {
    view_label: "Clarity Looker Users"
    type: left_outer
    sql_on: ${clarity_instances.instance_id} = ${instance_looker_users.instance_id} ;;
    relationship: one_to_many
  }

  join: looker_users {
    view_label: "Clarity Looker Users"
    type: left_outer
    sql_on: ${instance_looker_users.looker_user_id} = ${looker_users.id};;
    relationship: one_to_many
  }

}
