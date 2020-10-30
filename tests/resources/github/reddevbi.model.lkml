connection: "reddev"
label: "RedDev Model"
# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: reddevbi_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: reddevbi_default_datagroup

#########  Transaction Fact  ############

explore: fct_sa_transaction {
  label: "Transaction Fact"
  view_name: fct_sa_transaction

  join: fct_sa_transaction_dtl {
    view_label: "Transaction Detail Fact"
    type: left_outer
    relationship: one_to_many
    sql_on: ${fct_sa_transaction.sa_transaction_id} = ${fct_sa_transaction_dtl.sa_transaction_id} ;;
  }

  join: dim_client {
    view_label: "Client"
    type: left_outer
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.client_id} = ${dim_client.client_id} ;;
  }

  join: dim_hcp {
    view_label: "HCP"
    type: left_outer
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.hcp_id} = ${dim_hcp.hcp_id} ;;
  }

  join: dim_hcp_address {
    view_label: "HCP Address"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.hcp_address_id} = ${dim_hcp_address.hcp_address_id} ;;
  }

  join: dim_hcp_license {
    view_label: "HCP License"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.hcp_license_id} = ${dim_hcp_license.hcp_license_id} ;;
  }

  join: dim_source {
    view_label: "Source"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.source_id} = ${dim_source.source_id} ;;
  }

  join: dim_project {
    view_label: "Project"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.project_id} = ${dim_project.project_id} ;;
  }

  join: dim_representative {
    view_label: "Representative"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.representative_id} = ${dim_representative.representative_id} ;;
  }

  join: dim_transaction_type {
    view_label: "Transaction Type"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.transaction_type_id} = ${dim_transaction_type.transaction_type_id} ;;
  }

  join: dim_request_status {
    view_label: "Request Status Code"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction.sa_transaction_status_code} = ${dim_request_status.request_status_code} ;;
  }


}

######### Transaction Detail Fact   ############

explore: fct_sa_transaction_dtl {
  label: "Transaction Detail Fact"
  view_name: fct_sa_transaction_dtl

  join: fct_sa_transaction{
    view_label: "Transaction Fact"
    type: left_outer
    relationship: one_to_many
    sql_on: ${fct_sa_transaction_dtl.sa_transaction_id} = ${fct_sa_transaction.sa_transaction_id} ;;
  }

  join: dim_client {
    view_label: "Client"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.client_id} = ${dim_client.client_id} ;;
  }

  join: dim_hcp {
    view_label: "HCP"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.hcp_id} = ${dim_hcp.hcp_id} ;;
  }

  join: dim_hcp_license {
    view_label: "HCP License"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.hcp_license_id}} = ${dim_hcp_license.hcp_license_id} ;;
  }

  join: dim_source {
    view_label: "Source"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.source_id} = ${dim_source.source_id} ;;
  }

  join: dim_product_family {
    view_label: "Product Family"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.product_family_id} = ${dim_product_family.product_family_id} ;;
  }

  join: dim_product {
    view_label: "Product"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.product_id} = ${dim_product.product_id} ;;
  }

  join: dim_product_type {
    view_label: "Product Type"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.product_type_id} = ${dim_product_type.product_type_id} ;;
  }


  join: dim_representative {
    view_label: "Representative"
    relationship: many_to_one
    sql_on: ${fct_sa_transaction_dtl.representative_id} = ${dim_representative.representative_id} ;;
  }
}


#########  Request Line Fact  ############

explore: fct_dtp_request_line {
  label: "Request Line Fact"
  view_name: fct_dtp_request_line

  join: dim_client {
    view_label: "Client"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.client_id} = ${dim_client.client_id} ;;
  }

  join: dim_hcp {
    view_label: "HCP"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.hcp_id} = ${dim_hcp.hcp_id} ;;
  }

  join: dim_hcp_address {
    view_label: "HCP Address"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.hcp_address_id} = ${dim_hcp_address.hcp_address_id} ;;
  }

  join: dim_hcp_license {
    view_label: "HCP License"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.hcp_license_id} = ${dim_hcp_license.hcp_license_id} ;;
  }

  join: dim_source {
    view_label: "Source"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.source_id} = ${dim_source.source_id} ;;
  }

  join: dim_product_family {
    view_label: "Product Family"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.product_family_id} = ${dim_product_family.product_family_id} ;;
  }

  join: dim_product {
    view_label: "Product"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.product_id} = ${dim_product.product_id} ;;
  }

  join: dim_product_type {
    view_label: "Product Type"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.product_type_id} = ${dim_product_type.product_type_id} ;;
  }

  join: dim_project {
    view_label: "Project"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.project_id} = ${dim_project.project_id} ;;
  }

  join: dim_request_status {
    view_label: "Request Status"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.request_status_id} = ${dim_request_status.request_status_id} ;;
  }

  join: dim_representative {
    view_label: "Representative"
    relationship: many_to_one
    sql_on: ${fct_dtp_request_line.representative_id} = ${dim_representative.representative_id} ;;
  }
}
#########  HCP Dimension  ############
explore: dim_hcp {
  label: "HCP"
  view_name: dim_hcp

  join: dim_hcp_speciality {
    view_label: "HCP Speciality"
    relationship: many_to_one
    type: inner
    sql_on: ${dim_hcp.hcp_speciality_id} = ${dim_hcp_speciality.hcp_speciality_id} ;;
  }


  join: dim_hcp_address {
    view_label: "HCP Address"
    relationship: many_to_one
    type: inner
    sql_on: ${dim_hcp.hcp_id} = ${dim_hcp_address.hcp_id} ;;
  }

  join: dim_hcp_license {
    view_label: "HCP License"
    relationship: many_to_one
    type: inner
    sql_on: ${dim_hcp.hcp_id} = ${dim_hcp_license.hcp_id} ;;
  }

  join: dim_client {
    view_label: "Dim Client"
    relationship: one_to_many
    sql_on: ${dim_client.client_id} = ${fct_dtp_request_line.client_id} or ${dim_client.client_id} = ${fct_sa_transaction_dtl.client_id} ;;
  }

  join: fct_dtp_request_line {
    view_label: "Request Line Fact"
    relationship: one_to_many
    sql_on: ${dim_hcp.hcp_id} = ${fct_dtp_request_line.hcp_id} ;;
  }

  join: fct_sa_transaction {
    view_label: "Transaction Fact"
    relationship: one_to_many
    sql_on: ${dim_hcp.hcp_id} = ${fct_sa_transaction.hcp_id} ;;
  }

  join: fct_sa_transaction_dtl {
    view_label: "Transaction Detail Fact"
    relationship: one_to_many
    sql_on: ${dim_hcp.hcp_id} = ${fct_sa_transaction_dtl.hcp_id} ;;
  }
}
#########  Product  ############
explore: dim_product {
  label: "Product"
  view_name: dim_product

  join: dim_product_family {
    view_label: "Product Family"
    relationship: many_to_one
    type: inner
    sql_on: ${dim_product.product_family_id} = ${dim_product_family.product_family_id} ;;
  }

  join: dim_product_type {
    view_label: "Product Type"
    relationship: many_to_one
    type: inner
    sql_on: ${dim_product_type.product_type_id} = ${dim_product_type.product_type_id} ;;
  }

}

explore: dim_client {}

explore: dim_hcp_license {}

explore: dim_hcp_speciality {}



explore: dim_product_family {}

explore: dim_product_type {}

explore: dim_project {}

explore: dim_representative {}

explore: dim_request_status {}

explore: dim_source {}

explore: dim_transaction_type {}
