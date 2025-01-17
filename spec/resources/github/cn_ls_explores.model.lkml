include: "base_ls_explores.model.lkml"

# include: "base_mn_mcd_claim_line_fact.view.lkml"
# include: "base_mn_mcd_claim_line_fact_dt.view.lkml"
# include: "base_mn_mcd_claim_dim.view.lkml"
# include: "base_mn_mcd_claim_pmt_payee_map.view.lkml"
# include: "base_mn_mcd_payment_fact.view.lkml"
# include: "base_mn_user_dim.view.lkml"
# include: "base_mn_price_list_dim.view.lkml"
# include: "base_mn_mcd_util_fact.view.lkml"
# include: "base_mn_mcd_program_state_map.view.lkml"
# include: "base_mn_mcd_program_product_map.view.lkml"
# include: "base_mn_mcd_program_dim.view.lkml"
# include: "base_mn_mcd_claim_payment_map.view.lkml"
# include: "base_mn_mcd_dispute_code_dim.view.lkml"
# include: "base_mn_mcd_adjust_type_dim.view.lkml"
# include: "base_mn_mcd_dispute_code_dim_dt.view.lkml"
# include: "base_mn_mcd_adjust_type_dim_dt.view.lkml"
# include: "base_mn_user_dim_reuse.view.lkml"


# explore: government_explore {
#   from: mn_mcd_program_state_map
#   view_name: mn_mcd_program_state_map
#   label: "Government Explore"
#   view_label: "Program"


#   join: mn_mcd_program_product_map {
#     from: mn_mcd_program_product_map
#     type: full_outer
#     relationship: many_to_many
#     view_label: "Program"
#     sql_on: ${mn_mcd_program_state_map.mcd_program_wid} = ${mn_mcd_program_product_map.mcd_program_wid}  ;;
#   }

#   join: mn_mcd_claim_line_fact_dt {
#     from: mn_mcd_claim_line_fact_dt
#     type: left_outer
#     relationship: one_to_many
#     view_label: "Claim Line"
#     sql_on: ${mn_mcd_program_state_map.mcd_program_wid} = ${mn_mcd_claim_line_fact_dt.mcd_program_wid} and ${mn_mcd_program_product_map.product_wid} = ${mn_mcd_claim_line_fact_dt.product_wid} and ${mn_mcd_claim_line_fact_dt.state_short_desc}= ${mn_mcd_program_state_map.mcd_state_short_desc};;
#   }

#   join: mn_mcd_claim_dim {
#     from: mn_mcd_claim_dim
#     type: full_outer
#     relationship: many_to_one
#     view_label: "Claim"
#     sql_on: ${mn_mcd_claim_line_fact_dt.mcd_claim_wid} = ${mn_mcd_claim_dim.claim_wid} ;;
#   }

#   join:  mn_mcd_util_fact {
#     from: mn_mcd_util_fact
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim Line"
#     sql_on: ${mn_mcd_claim_line_fact_dt.product_wid} = ${mn_mcd_util_fact.product_wid} and ${mn_mcd_claim_line_fact_dt.mcd_claim_wid} = ${mn_mcd_util_fact.claim_wid} ;;
#     fields: [mn_mcd_util_fact.Original_Invoiced_Amount,mn_mcd_util_fact.inv_req_rebate_amt]
#   }

#   join: mn_mcd_claim_pmt_payee_map {
#     from: mn_mcd_claim_pmt_payee_map
#     type: left_outer
#     relationship: many_to_many
#     view_label: "Payment"
#     sql_on: ${mn_mcd_claim_line_fact_dt.mcd_claim_wid} = ${mn_mcd_claim_pmt_payee_map.mcd_claim_wid} ;;
#   }

#   join: mn_mcd_payment_fact {
#     from: mn_mcd_payment_fact
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payment"
#     sql_on: ${mn_mcd_claim_pmt_payee_map.mcd_payment_wid} = ${mn_mcd_payment_fact.mcd_payment_wid} ;;
#   }

#   join: mn_mcd_claim_payment_map {
#     from: mn_mcd_claim_payment_map
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payment"
#     sql_on:${mn_mcd_claim_pmt_payee_map.mcd_payment_wid} = ${mn_mcd_claim_payment_map.mcd_payment_wid}   ;;

#   }
#   join: mn_payment_approver_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payment"
#     fields: [mn_payment_approver_dim.payment_approver_set*]
#     sql_on: ${mn_mcd_payment_fact.approved_by_wid} = ${mn_payment_approver_dim.user_wid} ;;
#   }

#   join: mn_claim_owner_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim"
#     fields: [mn_claim_owner_dim.claimowner_set*]
#     sql_on: ${mn_mcd_claim_dim.claim_owner_wid} = ${mn_claim_owner_dim.user_wid} ;;
#   }

#   join: mn_mcd_price_list_dim {
#     from: mn_price_list_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Price List"
#     sql_on: ${mn_mcd_claim_line_fact_dt.ura_price_list_wid} = ${mn_mcd_price_list_dim.price_list_wid} ;;
#   }

#   join: mn_mcd_payee_dim {
#     from: mn_customer_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payee"
#     fields: [mn_mcd_payee_dim.governmentpayee_set*]
#     sql_on: ${mn_mcd_program_state_map.payee_wid} = ${mn_mcd_payee_dim.customer_wid};;
#   }

#   join: mn_mcd_product_dim {
#     from: mn_product_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Product"
#     sql_on: ${mn_mcd_program_product_map.product_wid} = ${mn_mcd_product_dim.product_wid} ;;
#   }

#   join: mn_mcd_program_dim {
#     from: mn_mcd_program_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     sql_on: ${mn_mcd_program_state_map.mcd_program_wid} = ${mn_mcd_program_dim.program_wid} ;;
#   }

#   join: mn_mcd_mfr_contact_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mcd_mfr_contact_dim.mfrcontactname_set*]
#     sql_on: ${mn_mcd_program_state_map.mfr_contact_wid} = ${mn_mcd_mfr_contact_dim.user_wid} ;;
#   }

#   join: mn_mcd_recipient_name_dim {
#     from: mn_customer_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mcd_recipient_name_dim.payment_recipient_name_set*]
#     sql_on: ${mn_mcd_program_state_map.payee_wid} = ${mn_mcd_recipient_name_dim.customer_wid} ;;
#   }

#   join: mn_mcd_analyst_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mcd_analyst_dim.defaultanalyst_set*]
#     sql_on: ${mn_mcd_program_state_map.analyst_wid} = ${mn_mcd_analyst_dim.user_wid} ;;
#   }

#   join: mn_mcd_amended_by_name_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mcd_amended_by_name_dim.amemdedby_set*]
#     sql_on: ${mn_mcd_program_dim.amended_by_wid} = ${mn_mcd_amended_by_name_dim.user_wid} ;;
#   }

#   join: mn_mcd_program_owner_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mcd_program_owner_dim.programowner_set*]
#     sql_on: ${mn_mcd_program_dim.owner_wid} = ${mn_mcd_program_owner_dim.user_wid} ;;
#   }

#   join: mn_mcd_prog_lastupdby_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mcd_prog_lastupdby_dim.lastupdatedby_set*]
#     sql_on: ${mn_mcd_program_dim.last_updated_by_wid} = ${mn_mcd_prog_lastupdby_dim.user_wid} ;;
#   }

#   join: mn_mcd_program_createdby_dim {
#     from: mn_user_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mcd_program_createdby_dim.createdby_set*]
#     sql_on: ${mn_mcd_program_dim.created_by_wid} = ${mn_mcd_program_createdby_dim.user_wid} ;;
#   }

#   join: mn_mcd_adjust_code_dim_dt {
#     from: mn_mcd_dispute_code_dim_dt
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim Line"
#     fields: []
#     sql_on: ${mn_mcd_claim_line_fact_dt.inf_corr_codes} = ${mn_mcd_adjust_code_dim_dt.inf_corr_codes} ;;
#   }

#   join: mn_mcd_adjust_code_dim{
#     from: mn_mcd_dispute_code_dim
#     type: full_outer
#     relationship: one_to_many
#     view_label: "Claim Line"
#     sql_on: ${mn_mcd_adjust_code_dim_dt.dispute_code_name} = ${mn_mcd_adjust_code_dim.dispute_code_name} ;;
#     fields: [mn_mcd_adjust_code_dim.adjustcode_set*]
#   }

#   join: mn_mcd_adjust_type_dim_dt {
#     from: mn_mcd_adjust_type_dim_dt
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim Line"
#     fields: []
#     sql_on: ${mn_mcd_claim_line_fact_dt.adjust_type} = ${mn_mcd_adjust_type_dim_dt.adjust_type} ;;
#   }

#   join: mn_mcd_adjust_type_dim{
#     from: mn_mcd_adjust_type_dim
#     type: full_outer
#     relationship: one_to_many
#     view_label: "Claim Line"
#     sql_on: ${mn_mcd_adjust_type_dim_dt.adjust_type_name} = ${mn_mcd_adjust_type_dim.adjust_type_name} ;;
#   }

#   join: mn_mcd_dispute_code_dim {
#     from: mn_mcd_dispute_code_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim Line"
#     fields: [mn_mcd_dispute_code_dim.dispute_code_name]
#     sql_on: ${mn_mcd_claim_line_fact_dt.disp_codes} = ${mn_mcd_dispute_code_dim.src_sys_dispute_code_code} ;;

#   }

# }



# -----------------------------------------------------------------------------------------------------------------------------------------#
# -----------------------------------------------------------------------------------------------------------------------------------------#
# -----------------------------------------------------------------------------------------------------------------------------------------#

# explore: mn_mcd_claim_line {
#   from: mn_mcd_claim_line_fact
#   view_name: mn_mcd_claim_line_fact
#   label: "Government Explore"
#   view_label: "Claim Lines Old"
#
# sql_always_where: ${row_deleted_flag} = 'N' ;;
#
#   join: mn_mcd_claim_dim {
#     from: mn_mcd_claim_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim"
#     sql_on: ${mn_mcd_claim_line_fact.mcd_claim_wid} = ${mn_mcd_claim_dim.claim_wid} ;;
#   }
#   join:  mn_mcd_util_fact{
#     from: mn_mcd_util_fact
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Util"
#     fields: [inv_req_rebate_amt,mn_mcd_util_fact.paid_date,mn_mcd_util_fact.paid_month,mn_mcd_util_fact.paid_quarter,mn_mcd_util_fact.paid_time,mn_mcd_util_fact.paid_week,mn_mcd_util_fact.paid_year]
#     sql_on: ${mn_mcd_claim_line_fact.product_wid} = ${mn_mcd_util_fact.product_wid} and ${mn_mcd_claim_line_fact.mcd_claim_wid} = ${mn_mcd_util_fact.claim_wid} ;;
#
#   }
#   join: mn_mcd_claim_pmt_payee_map {
#     from: mn_mcd_claim_pmt_payee_map
#     type: left_outer
#     relationship: many_to_many
#     view_label: "Payment"
#     sql_on: ${mn_mcd_claim_line_fact.mcd_claim_wid} = ${mn_mcd_claim_pmt_payee_map.mcd_claim_wid} ;;
#   }
#
#   join: mn_mcd_payment_fact {
#     from: mn_mcd_payment_fact
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payment"
#     sql_on: ${mn_mcd_claim_pmt_payee_map.mcd_payment_wid} = ${mn_mcd_payment_fact.mcd_payment_wid} ;;
# }
#
#   join: mn_mcd_claim_payment_map {
#     from: mn_mcd_claim_payment_map
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payment"
#     sql_on:${mn_mcd_claim_pmt_payee_map.mcd_payment_wid} = ${mn_mcd_claim_payment_map.mcd_payment_wid}   ;;
#
#   }
#   join: mn_payment_approver_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payment"
#     fields: [mn_payment_approver_dim.full_name]
#     sql_on: ${mn_mcd_payment_fact.approved_by_wid} = ${mn_payment_approver_dim.user_wid} ;;
#   }
#
# #   join: mn_mcd_claim_state {
# #     from: mn_customer_dim
# #     type: left_outer
# #     relationship: many_to_one
# #     view_label: "Claim"
# #     sql_on: ${mn_mcd_claim_pmt_payee_map.claim_state_wid} = ${mn_mcd_claim_state.customer_wid} and  ${mn_mcd_claim_state.member_info_type} = 'Medicaid State';;
# #   }
#
#   join: mn_claim_owner_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim"
#     fields: [mn_claim_owner_dim.full_name,mn_claim_owner_dim.member_name]
#     sql_on: ${mn_mcd_claim_dim.claim_owner_wid} = ${mn_claim_owner_dim.user_wid} ;;
#   }
#
#   join: mn_price_list_dim {
#     from: mn_price_list_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Price List"
#     sql_on: ${mn_mcd_claim_line_fact.ura_price_list_wid} = ${mn_price_list_dim.price_list_wid} ;;
#   }
#
#   join: mn_mcd_program_state_map {
#     from: mn_mcd_program_state_map
#     type: left_outer
#     relationship: many_to_many
#     view_label: "Program"
#     sql_on: ${mn_mcd_claim_line_fact.mcd_program_wid} = ${mn_mcd_program_state_map.mcd_program_wid} and ${mn_mcd_claim_dim.state_short_desc} = ${mn_mcd_program_state_map.mcd_state_short_desc} ;;
#   }
#
#   join:  mn_mcd_program_product_map{
#     from: mn_mcd_program_product_map
#     type: full_outer
#     relationship: many_to_many
#     view_label: "Program"
#     sql_on: ${mn_mcd_claim_line_fact.product_wid} = ${mn_mcd_program_product_map.product_wid} ;;
#   }
#
#   join: mn_payee_dim {
#     from: mn_customer_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Payee"
#     sql_on: ${mn_mcd_program_state_map.payee_wid} = ${mn_payee_dim.customer_wid};;
#   }
#
#   join: mn_mcd_product_dim {
#     from: mn_product_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Product"
#     sql_on: ${mn_mcd_program_product_map.product_wid} = ${mn_mcd_product_dim.product_wid} ;;
#   }
#
#   join: mn_mcd_program_dim {
#     from: mn_mcd_program_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     sql_on: ${mn_mcd_program_state_map.mcd_program_wid} = ${mn_mcd_program_dim.program_wid} ;;
#   }
#
#   join: mn_mfr_contact_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_mfr_contact_dim.full_name]
#     sql_on: ${mn_mcd_program_state_map.mfr_contact_wid} = ${mn_mfr_contact_dim.user_wid} ;;
#   }
#
#   join: mn_recipient_name_dim {
#     from: mn_customer_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_recipient_name_dim.customer_name]
#     sql_on: ${mn_mcd_program_state_map.payee_wid} = ${mn_recipient_name_dim.customer_wid} ;;
#   }
#
#   join: mn_analyst_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_analyst_dim.full_name]
#     sql_on: ${mn_mcd_program_state_map.mfr_contact_wid} = ${mn_analyst_dim.user_wid} ;;
#   }
#
#   join: mn_amended_by_name_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_amended_by_name_dim.full_name]
#     sql_on: ${mn_mcd_program_dim.amended_by_wid} = ${mn_amended_by_name_dim.user_wid} ;;
#   }
#
#   join: mn_program_owner_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_program_owner_dim.full_name]
#     sql_on: ${mn_mcd_program_dim.owner_wid} = ${mn_program_owner_dim.user_wid} ;;
#   }
#
#   join: mn_program_lastupdatedby_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_program_lastupdatedby_dim.full_name]
#     sql_on: ${mn_mcd_program_dim.last_updated_by_wid} = ${mn_program_lastupdatedby_dim.user_wid} ;;
#   }
#
#   join: mn_program_createdby_dim {
#     from: mn_user_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Program"
#     fields: [mn_program_createdby_dim.full_name]
#     sql_on: ${mn_mcd_program_dim.created_by_wid} = ${mn_program_createdby_dim.user_wid} ;;
#   }
#
#   join: mn_mcd_adjust_code_dim_dt {
#     from: mn_mcd_dispute_code_dim_dt
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim Lines"
#     fields: []
#     sql_on: ${mn_mcd_claim_line_fact.inf_corr_codes} = ${mn_mcd_adjust_code_dim_dt.src_sys_dispute_code_code} ;;
#   }
#
#   join: mn_mcd_adjust_code_dim{
#     from: mn_mcd_dispute_code_dim
#     type: full_outer
#     relationship: one_to_many
#     view_label: "Claim Lines"
#     sql_on: ${mn_mcd_adjust_code_dim_dt.dispute_code_name} = ${mn_mcd_adjust_code_dim.dispute_code_name} ;;
#   }
#
#   join: mn_mcd_adjust_type_dim_dt {
#     from: mn_mcd_adjust_type_dim_dt
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim Lines"
# #     fields: []
#     sql_on: ${mn_mcd_claim_line_fact.adjust_type} = ${mn_mcd_adjust_type_dim_dt.src_sys_adjust_type_code} ;;
#   }
#
#   join: mn_mcd_adjust_type_dim{
#     from: mn_mcd_adjust_type_dim
#     type: full_outer
#     relationship: one_to_many
#     view_label: "Claim Lines"
#     sql_on: ${mn_mcd_adjust_type_dim_dt.adjust_type_name} = ${mn_mcd_adjust_type_dim.adjust_type_name} ;;
#   }
#
#   join: mn_mcd_dispute_code_dim {
#     from: mn_mcd_dispute_code_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Claim Lines"
#     fields: [mn_mcd_dispute_code_dim.dispute_code_name]
#     sql_on: ${mn_mcd_claim_line_fact.disp_codes} = ${mn_mcd_dispute_code_dim.src_sys_dispute_code_code} ;;
#
#   }
#
# }
#






# explore:  test {
#   from: mn_contract_header_dim
#   view_name: mn_contract_header_dim
#   view_label: "Contracts"
#   fields: [mn_contract_header_dim.contract_number,mn_contract_header_dim.contract_name]

#   join: mn_ctrt_org_dim {
#     from: mn_org_dim
#     type: left_outer
#     relationship: many_to_many
#     sql_on: ${mn_contract_header_dim.org_wid} = ${mn_ctrt_org_dim.org_wid} ;;
#     fields: [mn_ctrt_org_dim.org_name,mn_ctrt_org_dim.description]
#     view_label: "Contracts"
#   }

#   fields: [ALL_FIELDS*]
# }
# include: "bhavani.model.lkml"
#
# explore:  payer_combined_new {
#   label: "Payer Combined Model New"
#   from: mn_mco_util_fact
#   view_name: mn_mco_util_fact
#   extends: [payer_rebate, payer_utilization]
#   view_label: "Utilization Lines"
#   hidden: no
#   sql_always_where: 1=1 ;;
#
#   join: mn_discount_bridge_fact {
#     type: left_outer
#     relationship: one_to_many
#     from: mn_discount_bridge_fact
#     sql_on: ${mn_mco_util_fact.pub_util_id} = ${mn_discount_bridge_fact.pub_util_id} ;;
#     view_label: "Rebate lines"
#   }
#
#   join: mn_ctrt_Adtnl_dlgt_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_user_dim
#     view_label: "Contract Additional Delegate"
#     sql_on: ${mn_rbt_ctrt_header_dim.author_wid} = ${mn_ctrt_Adtnl_dlgt_dim.user_wid};;
#   }
#
#   #   Relabelling the existing labels
#
#   join: mn_util_customer_dim_bob {
#     from: mn_customer_dim
#     view_label: "Util Book of Business"
#   }
#
#   join: mn_util_cust_dim_parent_pbm {
#     from: mn_customer_dim
#     view_label: "Util PBM"
#   }
#
#   join: mn_util_cust_dim_plan {
#     from: mn_customer_dim
#     view_label: "Util Plan"
#   }
#
#   join: mn_util_ctrt_customer_dim {
#     from: mn_customer_dim
#     view_label: "Util Contracted Customer"
#   }
#
#   join: mn_util_ctrt_customer_id {
#     from: mn_customer_ids_dim
#     view_label: "Util Contracted Customer"
#   }
#
#   join: mn_mco_submission_dim {
#     from: mn_mco_submission_dim
#     view_label: "Util Submission"
#   }
#
#   join: mn_util_product_dim {
#     from: mn_product_dim
#     view_label: "Util Product"
#   }
#   join: mn_util_product_map_all_ver {
#     from: mn_product_map_all_ver
#     view_label: "Util Product"
#   }
#
#   join: mn_formulary_dim {
#     from: mn_formulary_dim
#     view_label: "Util Formulary"
#   }
#
#   join: mn_util_org_dim {
#     from: mn_org_dim
#     view_label: "Util Org"
#   }
#
#   join: mn_util_cot_dim {
#     from: mn_cot_dim
#     view_label: "Util COT"
#   }
#
# #  Hiding unwanted joins - from Exended Rebates
#   join: mn_rbt_cust_owner_dim {
#     from: mn_customer_dim
#     fields: []
#   }
#
#   join: mn_rbt_cust_cot_dim {
#     from: mn_customer_cot_dim
#     fields: []
#   }
#
#   join: mn_rbt_cot_dim {
#     from: mn_cot_dim
#     fields: []
#   }
#
# #   join: mn_rbt_org_dim {
# #     from: mn_org_dim
# #     fields: []
# #   }
#
#
# #  Hiding unwanted joins - Rebates
#   join: mn_rbt_product_dim {
#     from: mn_product_dim
#     fields: []
#   }
#
#   join:  mn_rbt_plan_dim {
#     from: mn_customer_dim
#     fields: []
#   }
#
# }
#
# explore: payer_combined {
#   label: "Payer Combined Model"
#   from: mn_discount_bridge_fact
#   view_name: mn_discount_bridge_fact
#   view_label: "Rebate Lines"
#   extends: [payer_rebate,payer_utilization]
#   hidden: no
#
#   join: mn_ctrt_Adtnl_dlgt_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_user_dim
#     view_label: "Contract Additional Delegate"
#      sql_on: ${mn_rbt_ctrt_header_dim.author_wid} = ${mn_ctrt_Adtnl_dlgt_dim.user_wid};;
#   }
#
#   join: mn_mco_util_fact {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_mco_util_fact
#     sql_on: ${mn_discount_bridge_fact.pub_util_id} = ${mn_mco_util_fact.pub_util_id} ;;
#     view_label: "Utilization lines"
#   }
#
#   #   Relabelling the existing labels - Utilization
#
#   join: mn_util_customer_dim_bob {
#     from: mn_customer_dim
#     view_label: "Util Book of Business"
#   }
#
#   join: mn_util_cust_dim_parent_pbm {
#     from: mn_customer_dim
#     view_label: "Util PBM"
#   }
#
#   join: mn_util_cust_dim_plan {
#     from: mn_customer_dim
#     view_label: "Util Plan"
#   }
#
#   join: mn_util_ctrt_customer_dim {
#     from: mn_customer_dim
#     view_label: "Util Contracted Customer"
#   }
#
#   join: mn_util_ctrt_customer_id {
#     from: mn_customer_ids_dim
#     view_label: "Util Contracted Customer"
#   }
#
#   join: mn_mco_submission_dim {
#     from: mn_mco_submission_dim
#     view_label: "Util Submission"
#   }
#
#   join: mn_util_product_dim {
#     from: mn_product_dim
#     view_label: "Util Product"
#   }
#   join: mn_util_product_map_all_ver {
#     from: mn_product_map_all_ver
#     view_label: "Util Product"
#   }
#
#   join: mn_formulary_dim {
#     from: mn_formulary_dim
#     view_label: "Util Formulary"
#   }
#
#   join: mn_util_org_dim {
#     from: mn_org_dim
#     view_label: "Util Org"
#   }
#
#   join: mn_util_cot_dim {
#     from: mn_cot_dim
#     view_label: "Util COT"
#   }
#
# #  Hiding unwanted joins - Contracts
#   join: mn_rbt_cust_owner_dim {
#     from: mn_customer_dim
#     fields: []
#   }
#
#   join: mn_rbt_cust_cot_dim {
#     from: mn_customer_cot_dim
#     fields: []
#   }
#
#   join: mn_rbt_cot_dim {
#     from: mn_cot_dim
#     fields: []
#   }
#
# #  Hiding unwanted joins - Rebates
#   join: mn_rbt_product_dim {
#     from: mn_product_dim
#     fields: []
#   }
#
#   join:  mn_rbt_plan_dim {
#     from: mn_customer_dim
#     fields: []
#   }
#
#
#
# }
# explore: payer_estimated_rebates{
#   label: "Estimated Rebates"
#   from: mn_est_rebate_payment_fact
#   view_name: mn_est_rebate_payment_fact
#   extends: [estimated_rebates_base]
#   hidden: no
#
#   sql_always_where: ${mn_est_rebate_payment_fact.estimate_pmt_type} = 'Managed Care';;
# }
#
# explore: payer_historical_rebates {
#   label: "Historical Rebates"
#   from: mn_discount_bridge_fact
#   view_name: mn_discount_bridge_fact
#   extends: [historical_rebates_base]
#   hidden: no
#
#   sql_always_where: ${mn_discount_bridge_fact.is_historical_flag}='Y'
#                     AND (${mn_discount_bridge_fact.mco_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.rebate_module_type} = 'MCO') ;;
# }

# include: "base_mn_rbt_prg_qual_flat_dim.view.lkml"
# include: "base_mn_rbt_qual_prod_map_all.view.lkml"

# include: "base_mn_rbt_prg_ben_flat_dim.view.lkml"
# include: "base_mn_rbt_ben_prod_map_all.view.lkml"

# include: "base_mn_product_map_all_vers.view.lkml"
# include: "base_mn_product_eff_attr_fact.view.lkml"

# include: "base_mn_rbt_qual_mb_prod_map_all.view.lkml"
# include: "base_mn_market_basket_dim.view.lkml"
# include: "base_mn_product_group_dim.view.lkml"

# include: "base_mn_rbt_prg_qual_elg_cst_map_derived.view.lkml"

# include: "base_mn_rbt_prg_ben_elg_cst_map_derived.view.lkml"
# include: "base_mn_plan_formulary_map.view.lkml"
# include: "base_mn_formulary_dim.view.lkml"
# include: "base_mn_formulary_prod_map.view.lkml"

# include: "base_mn_rebate_prog_prod_map_all.view.lkml"

# include: "base_mn_contract_attr_fact.view.lkml"

# explore: mn_payer_contract {
#   label: "Contracts"
#   from: mn_contract_header_dim
#   view_name: mn_contract_header_dim

#   extends: [mn_contract_header_dim_secure_base,
#     mn_contract_header_dim_adhoc_base, mn_combined_rebate_program_dim_base]

#   hidden: no

# # Data security
#   #access_filter: {
#   #  field: mn_user_access_ctrt_map.user_wid
#   #  user_attribute: access_user_name
#   #}

#   sql_always_where: ${mn_contract_header_dim.latest_flag} = 'Y' ;;

#   join: mn_combined_rebate_program_dim {
#     type: left_outer
#     view_label: "Rebate Program"
#     relationship: many_to_one
#     from: mn_combined_rebate_program_dim
#     sql_on: ${mn_contract_header_dim.contract_wid} = ${mn_combined_rebate_program_dim.contract_wid} ;;
#   }

# # ****************************** Rebate Program Qualification joins
#   join: mn_rbt_prog_qual_flat_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rbt_prg_qual_flat_dim
#     view_label: "Rebate Program Qualification"
#     sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prog_qual_flat_dim.program_wid} ;;
#   }

#   join: mn_rbt_qual_prod_map_all {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rbt_qual_prod_map_all
#     view_label: "Rebate Program Qualification Product"
#     sql_on: ${mn_rbt_prog_qual_flat_dim.program_qual_wid} = ${mn_rbt_qual_prod_map_all.basket_wid}.program_qual_wid} ;;
#   }

#   join: mn_rbt_qual_prod_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_dim
#     view_label: "Rebate Program Qualification Product"
#     sql_on: ${mn_rbt_qual_prod_map_all.product_wid} = ${mn_rbt_qual_prod_dim.product_wid} ;;
#     fields: [ndc, product_num, product_name]
#   }

#   join: mn_rbt_qual_prod_hier {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_map_all_ver
#     view_label: "Rebate Program Qualification Product Hierarchy"
#     sql_on: ${mn_rbt_qual_prod_map_all.product_wid} = ${mn_rbt_qual_prod_hier.level0_product_wid} ;;
#   }

#   join: mn_rbt_qual_prod_eda {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_eff_attr_fact
#     view_label: "Rebate Program Qualification Product EDA"
#     sql_on: ${mn_rbt_qual_prod_map_all.product_wid} = ${mn_rbt_qual_prod_eda.product_wid} ;;
#   }


# # ******************** Rebate Program Benefit joins
#   join: mn_rbt_prog_ben_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rbt_prg_ben_flat_dim
#     view_label: "Rebate Program Benefit"
#     sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prog_ben_dim.program_wid} ;;
#   }

#   join: mn_rbt_ben_prod_map_all {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rbt_ben_prod_map_all
#     view_label: "Rebate Program Benefit Product"
#     sql_on: ${mn_rbt_prog_ben_dim.program_ben_wid} = ${mn_rbt_ben_prod_map_all.program_ben_wid} ;;
#   }

#   join: mn_rbt_ben_prod_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_dim
#     view_label: "Rebate Program Benefit Product"
#     sql_on: ${mn_rbt_ben_prod_map_all.product_wid} = ${mn_rbt_ben_prod_dim.product_wid} ;;
#     fields: [ndc, product_num, product_name]
#   }

#   join: mn_rbt_ben_prod_hier {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_map_all_ver
#     view_label: "Rebate Program Benefit Product Hierarchy"
#     sql_on: ${mn_rbt_ben_prod_map_all.product_wid} = ${mn_rbt_ben_prod_hier.level0_product_wid} ;;
#   }

#   join: mn_rbt_ben_prod_eda {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_eff_attr_fact
#     view_label: "Rebate Program Benefit Product EDA"
#     sql_on: ${mn_rbt_ben_prod_map_all.product_wid} = ${mn_rbt_ben_prod_eda.product_wid} ;;
#   }

# # ******************** Rebate Program Qualification MB joins
#   join: mn_rbt_qual_mb_prod_map_all {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rbt_qual_mb_prod_map_all
#     view_label: "Rebate Program Qualification MB"
#     sql_on: ${mn_rbt_prog_qual_flat_dim.program_qual_wid} = ${mn_rbt_qual_mb_prod_map_all.program_qual_wid} ;;
#   }

#   join: mn_rbt_qual_mb_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_market_basket_dim
#     view_label: "Rebate Program Qualification MB"
#     sql_on: ${mn_rbt_qual_mb_prod_map_all.basket_wid} = ${mn_rbt_qual_mb_dim.market_basket_wid} ;;
#   }

#   join: mn_rbt_qual_mb_prod_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_dim
#     view_label: "Rebate Program Qualification MB Product"
#     sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_dim.product_wid} ;;
#     fields: [ndc, product_num, product_name]
#   }

#   join: mn_rbt_qual_mb_prod_hier {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_map_all_ver
#     view_label: "Rebate Program Qualification MB Product Hierarchy"
#     sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_hier.level0_product_wid} ;;
#   }

#   join: mn_rbt_qual_mb_prod_eda {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_eff_attr_fact
#     view_label: "Rebate Program Qualification MB Product EDA"
#     sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_eda.product_wid} ;;
#   }

# # ******************** Rebate Program Qualification eligibility
#   join: mn_rbt_prg_qual_elg_cst_map_dr {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rbt_prg_qual_elg_cst_map_dr
#     view_label: "Rebate Program Qualification Eligible Plan"
#     sql_on: ${mn_rbt_prog_qual_flat_dim.program_qual_wid} = ${mn_rbt_prg_qual_elg_cst_map_dr.program_qual_wid} ;;
#   }

# # ******************** Rebate Program eligibility
#   join: mn_rbt_prg_ben_elg_cust_map_dr {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rbt_prg_ben_elg_cst_map_dr
#     view_label: "Rebate Program Eligible Plan"
#     sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prg_ben_elg_cust_map_dr.program_wid} ;;
#   }

#   join: mn_plan_formulary_map {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_plan_formulary_map
#     view_label: "Rebate Program Eligible Plan Formulary"
#     sql_on: ${mn_rbt_prg_ben_elg_cust_map_dr.elig_customer_wid} = ${mn_plan_formulary_map.plan_wid} ;;
#   }

#   join: mn_formulary_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_formulary_dim
#     view_label: "Rebate Program Eligible Plan Formulary"
#     sql_on: ${mn_plan_formulary_map.formulary_wid} = ${mn_formulary_dim.formulary_wid} ;;
#   }

#   join: mn_formulary_prod_map {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_formulary_prod_map
#     view_label: "Rebate Program Elig Plan Formulary Product"
#     sql_on: ${mn_plan_formulary_map.formulary_wid} = ${mn_formulary_prod_map.formulary_wid} ;;
#   }

#   join: mn_formulary_product_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_dim
#     view_label: "Rebate Program Elig Plan Formulary Product"
#     sql_on: ${mn_formulary_prod_map.product_wid} = ${mn_formulary_product_dim.product_wid} ;;
#     fields: [ndc, product_num, product_name]
#   }

# # ******************** Rebate Program Products
#   join: mn_rebate_prog_prod_map_all {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rebate_prog_prod_map_all
#     view_label: "Rebate Program Product"
#     sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rebate_prog_prod_map_all.program_wid} ;;
#     fields: [mn_rebate_prog_prod_map_all.rbt_prog_prod_fields_set*]
#   }

#   join: mn_rebate_prog_prod_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_product_dim
#     view_label: "Rebate Program Product"
#     sql_on: ${mn_rebate_prog_prod_map_all.product_wid} = ${mn_rebate_prog_prod_dim.product_wid} ;;
#     fields: [product_num, product_name]
#   }

# # ******************** Contract attr fact

#   join: mn_contract_attr_fact {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_contract_attr_fact
#     view_label: "Contract Attributes"
#     sql_on: ${mn_contract_header_dim.contract_wid} = ${mn_contract_attr_fact.contract_wid} ;;
#   }

# }
