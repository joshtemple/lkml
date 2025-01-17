include: "base_ls_explores.model.lkml"

label: "Government Explorer"

explore: government_explore {
  from: mn_mcd_program_state_map
  view_name: mn_mcd_program_state_map
  label: "Government Explore"
  view_label: "Program"


  join: mn_mcd_program_product_map {
    from: mn_mcd_program_product_map
    type: full_outer
    relationship: many_to_many
    view_label: "Program"
    sql_on: ${mn_mcd_program_state_map.mcd_program_wid} = ${mn_mcd_program_product_map.mcd_program_wid}  ;;
  }

  join: mn_mcd_claim_line_fact_dt {
    from: mn_mcd_claim_line_fact_dt
    type: left_outer
    relationship: one_to_many
    view_label: "Claim Line"
    sql_on: ${mn_mcd_program_state_map.mcd_program_wid} = ${mn_mcd_claim_line_fact_dt.mcd_program_wid} and ${mn_mcd_program_product_map.product_wid} = ${mn_mcd_claim_line_fact_dt.product_wid} and ${mn_mcd_claim_line_fact_dt.state_short_desc}= ${mn_mcd_program_state_map.mcd_state_short_desc};;
  }

  join: mn_mcd_claim_dim {
    from: mn_mcd_claim_dim
    type: full_outer
    relationship: many_to_one
    view_label: "Claim"
    sql_on: ${mn_mcd_claim_line_fact_dt.mcd_claim_wid} = ${mn_mcd_claim_dim.claim_wid} ;;
  }

  join:  mn_mcd_util_fact {
    from: mn_mcd_util_fact
    type: left_outer
    relationship: many_to_one
    view_label: "Claim Line"
    sql_on: ${mn_mcd_claim_line_fact_dt.product_wid} = ${mn_mcd_util_fact.product_wid} and ${mn_mcd_claim_line_fact_dt.mcd_claim_wid} = ${mn_mcd_util_fact.claim_wid} ;;
    fields: [mn_mcd_util_fact.Original_Invoiced_Amount,mn_mcd_util_fact.inv_req_rebate_amt]
  }

  join: mn_mcd_claim_pmt_payee_map {
    from: mn_mcd_claim_pmt_payee_map
    type: left_outer
    relationship: many_to_many
    view_label: "Payment"
    sql_on: ${mn_mcd_claim_line_fact_dt.mcd_claim_wid} = ${mn_mcd_claim_pmt_payee_map.mcd_claim_wid} ;;
  }

  join: mn_mcd_payment_fact {
    from: mn_mcd_payment_fact
    type: left_outer
    relationship: many_to_one
    view_label: "Payment"
    sql_on: ${mn_mcd_claim_pmt_payee_map.mcd_payment_wid} = ${mn_mcd_payment_fact.mcd_payment_wid} ;;
  }

  join: mn_mcd_claim_payment_map {
    from: mn_mcd_claim_payment_map
    type: left_outer
    relationship: many_to_one
    view_label: "Payment"
    sql_on:${mn_mcd_claim_pmt_payee_map.mcd_payment_wid} = ${mn_mcd_claim_payment_map.mcd_payment_wid}   ;;

  }
  join: mn_payment_approver_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Payment"
    fields: [mn_payment_approver_dim.payment_approver_set*]
    sql_on: ${mn_mcd_payment_fact.approved_by_wid} = ${mn_payment_approver_dim.user_wid} ;;
  }

  join: mn_claim_owner_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Claim"
    fields: [mn_claim_owner_dim.claimowner_set*]
    sql_on: ${mn_mcd_claim_dim.claim_owner_wid} = ${mn_claim_owner_dim.user_wid} ;;
  }

  join: mn_mcd_price_list_dim {
    from: mn_price_list_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Price List"
    sql_on: ${mn_mcd_claim_line_fact_dt.ura_price_list_wid} = ${mn_mcd_price_list_dim.price_list_wid} ;;
  }

  join: mn_mcd_payee_dim {
    from: mn_customer_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Payee"
    fields: [mn_mcd_payee_dim.governmentpayee_set*]
    sql_on: ${mn_mcd_program_state_map.payee_wid} = ${mn_mcd_payee_dim.customer_wid};;
  }

  join: mn_mcd_product_dim {
    from: mn_product_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Product"
    sql_on: ${mn_mcd_program_product_map.product_wid} = ${mn_mcd_product_dim.product_wid} ;;
  }

  join: mn_mcd_program_dim {
    from: mn_mcd_program_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    sql_on: ${mn_mcd_program_state_map.mcd_program_wid} = ${mn_mcd_program_dim.program_wid} ;;
  }

  join: mn_mcd_mfr_contact_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    fields: [mn_mcd_mfr_contact_dim.mfrcontactname_set*]
    sql_on: ${mn_mcd_program_state_map.mfr_contact_wid} = ${mn_mcd_mfr_contact_dim.user_wid} ;;
  }

  join: mn_mcd_recipient_name_dim {
    from: mn_customer_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    fields: [mn_mcd_recipient_name_dim.payment_recipient_name_set*]
    sql_on: ${mn_mcd_program_state_map.payee_wid} = ${mn_mcd_recipient_name_dim.customer_wid} ;;
  }

  join: mn_mcd_analyst_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    fields: [mn_mcd_analyst_dim.defaultanalyst_set*]
    sql_on: ${mn_mcd_program_state_map.analyst_wid} = ${mn_mcd_analyst_dim.user_wid} ;;
  }

  join: mn_mcd_amended_by_name_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    fields: [mn_mcd_amended_by_name_dim.amemdedby_set*]
    sql_on: ${mn_mcd_program_dim.amended_by_wid} = ${mn_mcd_amended_by_name_dim.user_wid} ;;
  }

  join: mn_mcd_program_owner_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    fields: [mn_mcd_program_owner_dim.programowner_set*]
    sql_on: ${mn_mcd_program_dim.owner_wid} = ${mn_mcd_program_owner_dim.user_wid} ;;
  }

  join: mn_mcd_prog_lastupdby_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    fields: [mn_mcd_prog_lastupdby_dim.lastupdatedby_set*]
    sql_on: ${mn_mcd_program_dim.last_updated_by_wid} = ${mn_mcd_prog_lastupdby_dim.user_wid} ;;
  }

  join: mn_mcd_program_createdby_dim {
    from: mn_user_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Program"
    fields: [mn_mcd_program_createdby_dim.createdby_set*]
    sql_on: ${mn_mcd_program_dim.created_by_wid} = ${mn_mcd_program_createdby_dim.user_wid} ;;
  }

  join: mn_mcd_adjust_code_dim_dt {
    from: mn_mcd_dispute_code_dim_dt
    type: left_outer
    relationship: many_to_one
    view_label: "Claim Line"
    fields: []
    sql_on: ${mn_mcd_claim_line_fact_dt.inf_corr_codes} = ${mn_mcd_adjust_code_dim_dt.inf_corr_codes} ;;
  }

  join: mn_mcd_adjust_code_dim{
    from: mn_mcd_dispute_code_dim
    type: full_outer
    relationship: one_to_many
    view_label: "Claim Line"
    sql_on: ${mn_mcd_adjust_code_dim_dt.dispute_code_name} = ${mn_mcd_adjust_code_dim.dispute_code_name} ;;
    fields: [mn_mcd_adjust_code_dim.adjustcode_set*]
  }

  join: mn_mcd_adjust_type_dim_dt {
    from: mn_mcd_adjust_type_dim_dt
    type: left_outer
    relationship: many_to_one
    view_label: "Claim Line"
    fields: []
    sql_on: ${mn_mcd_claim_line_fact_dt.adjust_type} = ${mn_mcd_adjust_type_dim_dt.adjust_type} ;;
  }

  join: mn_mcd_adjust_type_dim{
    from: mn_mcd_adjust_type_dim
    type: full_outer
    relationship: one_to_many
    view_label: "Claim Line"
    sql_on: ${mn_mcd_adjust_type_dim_dt.adjust_type_name} = ${mn_mcd_adjust_type_dim.adjust_type_name} ;;
  }

  join: mn_mcd_dispute_code_dim {
    from: mn_mcd_dispute_code_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Claim Line"
    fields: [mn_mcd_dispute_code_dim.dispute_code_name]
    sql_on: ${mn_mcd_claim_line_fact_dt.disp_codes} = ${mn_mcd_dispute_code_dim.src_sys_dispute_code_code} ;;

  }

}


# **************************************** government Historical Rebates
explore: government_historical_rebates {
  label: "Government Historical Rebates"
  from: mn_discount_bridge_fact
  view_name: mn_discount_bridge_fact
  extends: [historical_rebates_base]
  hidden: no

  sql_always_where: ${mn_discount_bridge_fact.is_historical_flag}='Y'
    AND (${mn_discount_bridge_fact.mcd_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.rebate_module_type} = 'MCD') ;;
}
