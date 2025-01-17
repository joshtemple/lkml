connection: "cloudsql_conn"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }


explore: mpa_d_lead {
  label: "Lead Analysis"
  view_label: "Lead Fields"
  join: mpa_d_company {
    view_label: "Company Fields"
    relationship: many_to_one
    sql_on: ${mpa_d_lead.company_key} = ${mpa_d_company.company_key} ;;
  }

  join: mpa_d_lead_source {
    view_label: "Lead Fields"
    relationship: many_to_one
    sql_on: ${mpa_d_lead.lead_source_key} = ${mpa_d_lead_source.lead_source_key} ;;
  }

  join: mpa_d_lead_status {
    view_label: "Lead Fields"
    relationship: many_to_one
    sql_on: ${mpa_d_lead.lead_status_key} = ${mpa_d_lead_status.lead_status_key} ;;
  }

  join: mpa_d_lead_owner {
    view_label: "Lead Fields"
    relationship: many_to_one
    sql_on: ${mpa_d_lead.lead_owner_key} = ${mpa_d_lead_owner.lead_owner_key} ;;
  }

  join: mpa_d_program {
    view_label: "Lead Fields"
    relationship: many_to_one
    sql_on: ${mpa_d_lead.acquisition_program_key} = ${mpa_d_program.program_key} ;;
  }

  join: mpa_d_abm_account {
    view_label: "Lead Fields"
    relationship: many_to_one
    sql_on: ${mpa_d_lead.abm_account_key} = ${mpa_d_abm_account.abm_account_key} ;;
  }
}

explore: mpa_v_email_activity {
  label: "Email Analysis"
  join: mpa_d_email {
    view_label: "Email Attributes"
    relationship: many_to_one
    sql_on: ${mpa_v_email_activity.email_key} = ${mpa_d_email.email_key} ;;
  }
  join: mpa_d_link {
    view_label: "Email Attributes"
    relationship: many_to_one
    sql_on: ${mpa_v_email_activity.link_key} = ${mpa_d_link.link_key} ;;
  }
  join: mpa_d_lead {
    view_label: "Lead Attributes"
    relationship: many_to_one
    sql_on: ${mpa_v_email_activity.lead_key} = ${mpa_d_lead.lead_key} ;;
  }
  join: mpa_d_company {
    view_label: "Company Attributes"
    relationship: many_to_one
    sql_on: ${mpa_v_email_activity.company_key} = ${mpa_d_company.company_key} ;;
  }
  join: mpa_d_program {
    view_label: "Program Attributes"
    relationship: many_to_one
    sql_on: ${mpa_v_email_activity.program_key} = ${mpa_d_program.program_key} ;;
  }
  join: mpa_d_abm_account {
    view_label: "ABM Account Attributes"
    relationship: many_to_one
    sql_on: ${mpa_v_email_activity.abm_account_key} = ${mpa_d_abm_account.abm_account_key} ;;
  }
}
