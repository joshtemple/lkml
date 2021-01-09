include: "base_ls_explores.model.lkml"

# include: "base_ls_explores.model.lkml"
# include: "base_mn_mco_util_fact.view.lkml"
# include: "base_mn_product_map_all_vers.view.lkml"
## include: "base_mn_customer_dim_reuse.view.lkml"

# #************************************Payer Utilization Explore
# explore: payer_utilization {
#   label: "Payer Utilization"
#   from: mn_mco_util_fact
#   view_name: mn_mco_util_fact
#   view_label: "Utilization lines"
#   hidden: no

#   join: mn_util_customer_dim_bob {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_customer_dim_reuse
#     view_label: "Book of Business"
#     sql_on: ${mn_mco_util_fact.bob_wid} = ${mn_util_customer_dim_bob.customer_wid} ;;
#     fields: [mn_util_customer_dim_bob.bob_set*]
#   }

#   join: mn_util_cust_dim_parent_pbm {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_customer_dim_reuse
#     view_label: "Parent PBM"
#     sql_on: ${mn_mco_util_fact.parent_pbm_wid} = ${mn_util_cust_dim_parent_pbm.customer_wid} ;;
#     fields: [mn_util_cust_dim_parent_pbm.parent_pbm_set*]
#   }

#   join: mn_util_plan_dim {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_customer_dim_reuse
#     view_label: "Util Plan"
#     sql_on: ${mn_mco_util_fact.plan_wid} = ${mn_util_plan_dim.customer_wid} ;;
#     fields: [mn_util_plan_dim.plan_set*]
#   }

#   join: mn_util_ctrt_customer_dim {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_customer_dim_reuse
#     view_label: "Contracted Customer"
#     sql_on: ${mn_mco_util_fact.contract_cust_wid} = ${mn_util_ctrt_customer_dim.customer_wid} ;;
#     fields: [mn_util_ctrt_customer_dim.customer*]
#   }

#   join: mn_util_ctrt_customer_id {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_customer_ids_dim
#     view_label: "Contracted Customer"
#     sql_on: ${mn_util_ctrt_customer_dim.customer_wid} = ${mn_util_ctrt_customer_id.customer_wid} ;;
#   }

#   join: mn_mco_submission_dim {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_mco_submission_dim
#     view_label: "Submissions"
#     sql_on: ${mn_mco_util_fact.mco_submission_wid} = ${mn_mco_submission_dim.mco_submission_wid} ;;
#   }

#   join: mn_util_product_dim {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_product_dim
#     view_label: "Product"
#     sql_on: ${mn_mco_util_fact.product_wid} = ${mn_util_product_dim.product_wid} ;;
#   }

#   join: mn_util_product_map_all_ver {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_product_map_all_ver
#     view_label: "Product"
#     sql_on: ${mn_util_product_dim.product_wid} = ${mn_util_product_map_all_ver.level0_product_wid} ;;
#   }

#   join: mn_formulary_dim {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_formulary_dim
#     view_label: "Formulary"
#     sql_on: ${mn_mco_util_fact.formulary_wid} = ${mn_formulary_dim.formulary_wid} ;;
#   }

#   join: mn_util_org_dim {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_org_dim
#     view_label: "Utilization lines"
#     sql_on: ${mn_mco_util_fact.org_wid} = ${mn_util_org_dim.org_wid} ;;
#   }

#   join: mn_util_cot_dim {
#     type:  left_outer
#     relationship: many_to_one
#     from: mn_cot_dim
#     view_label: "Class of Trade"
#     sql_on: ${mn_mco_util_fact.cot_wid} = ${mn_util_cot_dim.cot_wid} ;;
# #     fields: [mn_util]
#   }

# }

# #************************************Payer Rebate Explore
# explore: payer_rebate {
#   label: "Payer Rebates"
#   from: mn_discount_bridge_fact
#   view_name: mn_discount_bridge_fact
#   view_label: "Rebate Lines"

#   extends: [mn_paid_rebate_lines_base,mn_rbt_ctrt_header_dim_base]
#   hidden: no

#   sql_always_where: (${mn_discount_bridge_fact.mco_line_ref_num} is not null or
#     upper(${mn_discount_bridge_fact.rebate_module_type}) = 'MCO') ;;

#   join: mn_rebate_payment_fact {
#     from: mn_rebate_payment_fact
#     view_label: "Rebate Payment"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${mn_discount_bridge_fact.rebate_pmt_wid}  ;;
#     fields: [rebate_payment_id, start_date,start_month,start_quarter,start_year, end_date,end_month,end_quarter,end_year,payment_status,payment_priority,tier_attained,tier_applied,qualification_status, paid_date,paid_month,paid_quarter,paid_year,total_net_due_amount,total_rebate_due_amount]
#   }

#   join: mn_rbt_ctrt_header_dim {
#     from: mn_contract_header_dim
#     view_label: "Contract"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${mn_rebate_payment_fact.contract_wid} = ${mn_rbt_ctrt_header_dim.contract_wid} ;;
#   }

#   join: mn_rbt_analyst_user_dim {
#     from: mn_user_dim
#     view_label: "Rebate Analyst"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${mn_rebate_payment_fact.analyst_user_wid} = ${mn_rbt_analyst_user_dim.user_wid} ;;
#   }

#   join: mn_rbt_slsrep_user_dim {
#     from: mn_user_dim
#     view_label: "Rebate SalesRep"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${mn_rebate_payment_fact.salesrep_user_wid} = ${mn_rbt_slsrep_user_dim.user_wid} ;;
#   }

#   join: mn_payment_package_dim {
#     from: mn_payment_package_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Rebate Payment Package"
#     sql_on: ${mn_rebate_payment_fact.pymt_pkg_wid} = ${mn_payment_package_dim.pymt_pkg_wid} ;;
#   }

#   join: mn_rbt_product_dim {
#     from: mn_product_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Rebate Product"
#     sql_on: ${mn_discount_bridge_fact.product_wid} = ${mn_rbt_product_dim.product_wid} ;;
#   }

#   join:  mn_rbt_plan_dim {
#     from: mn_customer_dim_reuse
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Rebate Plan"
#     sql_on: ${mn_discount_bridge_fact.plan_wid} = ${mn_rbt_plan_dim.customer_wid}
#     and Upper(${mn_rbt_plan_dim.member_info_type}) = 'PLAN' ;;
#     fields: [mn_rbt_plan_dim.plan_set*]
#   }

#   join: mn_combined_rebate_program_dim {
#     from: mn_combined_rebate_program_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Rebate Program"
#     sql_on: ${mn_rebate_payment_fact.rebate_program_wid} = ${mn_combined_rebate_program_dim.program_wid} ;;
#   }

#   # join: mn_rbt_prg_ben_flat_dim {
#   #   type: left_outer
#   #   relationship: many_to_one
#   #   from: mn_rbt_prg_ben_flat_dim
#   #   view_label: "Rebate Program Benefit"
#   #   sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prg_ben_flat_dim.program_wid} ;;
#   # }


#   # join: mn_rbt_prog_ben_prod_map {
#   #   type: left_outer
#   #   relationship: many_to_one
#   #   from: mn_rbt_prog_ben_prod_map
#   #   view_label: "Rebate Program Benefit Product"
#   #   sql_on: ${mn_rbt_prg_ben_flat_dim.program_ben_wid} = ${mn_rbt_prog_ben_prod_map.program_ben_wid} ;;
#   # }

#   join: mn_rbt_ctrt_author_dim {
#     from: mn_user_dim
#     view_label: "Contract Author"
#   }

#   join: mn_rbt_ctrt_delegate_dim {
#     from: mn_user_dim
#     view_label: "Contract Additional Delegate"
#   }

#   join: mn_rbt_ctrt_srep_dim {
#     from: mn_user_dim
#     view_label: "Contract Sales Rep"
#   }

#   join: mn_rbt_ctrt_status_dim {
#     from: mn_ctrt_status_dim
#     view_label: "Contract"
#   }

#   join: mn_rbt_ctrt_domain_dim {
#     from: mn_ctrt_domain_dim
#     view_label: "Contract"
#   }

#   join: mn_rbt_ctrt_type_dim {
#     from: mn_ctrt_type_dim
#     view_label: "Contract"
#   }

#   join: mn_rbt_ctrt_sub_type_dim {
#     from: mn_ctrt_sub_type_dim
#     view_label: "Contract"
#   }

#   join: mn_rbt_cust_owner_dim {
#     from: mn_customer_dim
#     view_label: "Contract Owner Account"
#   }

#   join: mn_rbt_cust_cot_dim {
#     from: mn_customer_cot_dim
#     view_label: "Contract Customer COT"
#   }

#   join: mn_rbt_cot_dim {
#     from: mn_cot_dim
#     view_label: "Contract Customer COT"
#   }

#   join: mn_rbt_ctrt_parent_dim {
#     from: mn_contract_header_dim
#     view_label: "Contract Parent"
#   }

#   join: mn_rbt_distrib_mthd_dim {
#     from: mn_distrib_mthd_dim
#     view_label: "Contract Distribution Method"
#   }

#   join: mn_rbt_org_dim {
#     from: mn_org_dim
#     view_label: "Contract"
#   }

#   fields: [ALL_FIELDS*,-mn_discount_bridge_fact.cs_line_ref_num,-mn_discount_bridge_fact.ids_line_ref_num,
#     -mn_discount_bridge_fact.ds_line_ref_num,-mn_discount_bridge_fact.mcd_claim_wid,-mn_discount_bridge_fact.mcd_line_ref_num,
#     -mn_discount_bridge_fact.mcd_payment_wid,-mn_discount_bridge_fact.pub_util_id,-mn_discount_bridge_fact.estimate_pmt_flag,
#     -mn_discount_bridge_fact.estimate_qty,-mn_discount_bridge_fact.inv_amt_base,-mn_discount_bridge_fact.paid_amt_base]

# }
