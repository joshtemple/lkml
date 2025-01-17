include: "base_ls_explores_ls_winter18c.model.lkml"

# include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

label: "Payer"

explore: payer_contracts {
  label: "Payer Contracts"
  from: mn_contract_header_dim_payer
  view_name: mn_rbt_ctrt_header_dim
  extends: [mn_rbt_ctrt_header_dim_secure_base, mn_combined_rebate_program_dim_base]

  fields: [ALL_FIELDS*,-mn_rbt_ctrt_header_dim.payer_excl_set*]

  hidden: no

  sql_always_where: ${mn_rbt_ctrt_header_dim.latest_flag} = 'Y' and ${mn_rbt_ctrt_type_dim.ctrt_type_name} IN ('Managed Care','Medicare Part D','Tricare') ;;

# Data security
  access_filter: {
    field: mn_user_access_ctrt_map.access_user_id
    user_attribute: access_user_id
  }

  join: mn_ctrt_attr_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_contract_attr_fact
    view_label: "Contract"
    sql_on: ${mn_rbt_ctrt_header_dim.contract_wid} = ${mn_ctrt_attr_fact.contract_wid};;
    fields: [eff_start_date, eff_end_date, attr_name, attr_value]
  }

  join: mn_combined_rebate_program_dim {
    type: left_outer
    view_label: "Rebate Program"
    relationship: one_to_many
    from: mn_combined_rebate_program_dim
    sql_on: ${mn_rbt_ctrt_header_dim.contract_wid} = ${mn_combined_rebate_program_dim.contract_wid}
    AND ${mn_combined_rebate_program_dim.latest_flag} = 'Y';;
  }

  # ****************************** Rebate Program Qualification joins
  join: mn_rbt_prog_qual_flat_dim {
    type: left_outer
    relationship: one_to_many
    from: mn_rbt_prg_qual_flat_dim
    view_label: "Rebate Program Qualification"
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prog_qual_flat_dim.program_wid} ;;
  }

  join: mn_rbt_qual_prod_map_all {
    type: left_outer
    relationship: one_to_many
    from: mn_rbt_qual_prod_map_all
    view_label: "Rebate Program Qualification Product"
    sql_on: ${mn_rbt_prog_qual_flat_dim.program_qual_wid} = ${mn_rbt_qual_prod_map_all.program_qual_wid} ;;
  }

  join: mn_rbt_qual_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Qualification Product"
    sql_on: ${mn_rbt_qual_prod_map_all.product_wid} = ${mn_rbt_qual_prod_dim.product_wid} ;;
    fields: [ndc, product_num, product_name]
  }

  join: mn_rbt_qual_prod_hier {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Qualification Product Hierarchy"
    sql_on: ${mn_rbt_qual_prod_map_all.product_wid} = ${mn_rbt_qual_prod_hier.level0_product_wid} ;;
  }

  join: mn_rbt_qual_prod_eda {
    type: left_outer
    relationship: many_to_many
    from: mn_product_eff_attr_fact
    view_label: "Rebate Program Qualification Product EDA"
    sql_on: ${mn_rbt_qual_prod_map_all.product_wid} = ${mn_rbt_qual_prod_eda.product_wid} ;;
  }

  # ******************** Rebate Program Benefit joins
  join: mn_rbt_prog_ben_dim {
    type: left_outer
    relationship: one_to_many
    from: mn_rbt_prg_ben_flat_dim
    view_label: "Rebate Program Benefit"
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prog_ben_dim.program_wid} ;;
  }

  join: mn_rbt_ben_prod_map_all {
    type: left_outer
    relationship: one_to_many
    from: mn_rbt_ben_prod_map_all
    view_label: "Rebate Program Benefit Product"
    sql_on: ${mn_rbt_prog_ben_dim.program_ben_wid} = ${mn_rbt_ben_prod_map_all.program_ben_wid} ;;
  }

  join: mn_rbt_ben_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Benefit Product"
    sql_on: ${mn_rbt_ben_prod_map_all.product_wid} = ${mn_rbt_ben_prod_dim.product_wid} ;;
    fields: [ndc, product_num, product_name]
  }

  join: mn_rbt_ben_prod_hier {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Benefit Product Hierarchy"
    sql_on: ${mn_rbt_ben_prod_map_all.product_wid} = ${mn_rbt_ben_prod_hier.level0_product_wid} ;;
  }

  join: mn_rbt_ben_prod_eda {
    type: left_outer
    relationship: many_to_many
    from: mn_product_eff_attr_fact
    view_label: "Rebate Program Benefit Product EDA"
    sql_on: ${mn_rbt_ben_prod_map_all.product_wid} = ${mn_rbt_ben_prod_eda.product_wid} ;;
  }

  # ******************** Rebate Program Qualification MB joins
  join: mn_rbt_qual_mb_prod_map_all {
    type: left_outer
    relationship: one_to_many
    from: mn_rbt_qual_mb_prod_map_all
    view_label: "Rebate Program Qualification MB Product"
    sql_on: ${mn_rbt_prog_qual_flat_dim.program_qual_wid} = ${mn_rbt_qual_mb_prod_map_all.program_qual_wid}
             and ${mn_rbt_qual_mb_prod_map_all.product_type} = 'Item' ;;
  }

  join: mn_rbt_qual_mb_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_market_basket_dim
    view_label: "Rebate Program Qualification MB Product"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.basket_wid} = ${mn_rbt_qual_mb_dim.market_basket_wid} ;;
  }

  join: mn_rbt_qual_mb_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Qualification MB Product"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_dim.product_wid} ;;
    fields: [ndc, product_num, product_name,product_type_adhoc]
  }

  join: mn_rbt_qual_mb_prod_hier {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Qualification MB Product Hierarchy"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_hier.level0_product_wid} ;;
  }

  join: mn_rbt_qual_mb_prod_eda {
    type: left_outer
    relationship: many_to_many
    from: mn_product_eff_attr_fact
    view_label: "Rebate Program Qualification MB Product EDA"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_eda.product_wid} ;;
  }

  # ******************** Rebate Program Qualification eligibility
  join: mn_rbt_prg_qual_elg_cst_map_dt {
    type: left_outer
    relationship: one_to_many
    from: mn_rbt_prg_qual_elg_cst_map_dt
    view_label: "Rebate Program Qualification Eligible Plan"
    sql_on: ${mn_rbt_prog_qual_flat_dim.program_qual_wid} = ${mn_rbt_prg_qual_elg_cst_map_dt.program_qual_wid} ;;
  }

  # ******************** Rebate Program eligibility
  join: mn_rbt_prg_ben_elg_cust_map_dt {
    type: left_outer
    relationship: one_to_many
    from: mn_rbt_prg_ben_elg_cst_map_dt
    view_label: "Rebate Program Eligible Plan"
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prg_ben_elg_cust_map_dt.program_wid} ;;
  }

  join: mn_plan_formulary_map {
    type: left_outer
    relationship: many_to_many
    from: mn_plan_formulary_map
    view_label: "Rebate Program Eligible Plan Formulary"
    sql_on: ${mn_rbt_prg_ben_elg_cust_map_dt.elig_customer_wid} = ${mn_plan_formulary_map.plan_wid} ;;
  }

  join: mn_formulary_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_formulary_dim
    view_label: "Rebate Program Eligible Plan Formulary"
    sql_on: ${mn_plan_formulary_map.formulary_wid} = ${mn_formulary_dim.formulary_wid} ;;
  }

  join: mn_formulary_prod_map {
    type: left_outer
    relationship: many_to_many
    from: mn_formulary_prod_map
    view_label: "Rebate Program Eligible Plan Formulary Product"
    sql_on: ${mn_plan_formulary_map.formulary_wid} = ${mn_formulary_prod_map.formulary_wid} ;;
  }

  join: mn_formulary_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Eligible Plan Formulary Product"
    sql_on: ${mn_formulary_prod_map.product_wid} = ${mn_formulary_product_dim.product_wid} ;;
    fields: [ndc, product_num, product_name]
  }

  # ******************** Rebate Program Products
  join: mn_rebate_prog_prod_map_all {
    type: left_outer
    relationship: one_to_many
    from: mn_rebate_prog_prod_map_all
    view_label: "Rebate Program Product"
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rebate_prog_prod_map_all.program_wid} ;;
    fields: [mn_rebate_prog_prod_map_all.rbt_prog_prod_fields_set*]
  }

  join: mn_rebate_prog_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Product"
    sql_on: ${mn_rebate_prog_prod_map_all.product_wid} = ${mn_rebate_prog_prod_dim.product_wid} ;;
    fields: [product_num, product_name]
  }

  join: mn_rebate_prog_prod_dim_hier {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Product Hierarchy"
    sql_on: ${mn_rebate_prog_prod_map_all.product_wid} = ${mn_rebate_prog_prod_dim_hier.level0_product_wid} ;;
  }

  #   Relabelling the existing labels
  join: mn_rbt_ctrt_author_dim {
    from: mn_user_dim
    view_label: "Contract Author"
  }

  join: mn_rbt_ctrt_delegate_dim {
    from: mn_user_dim
    view_label: "Contract Additional Delegate"
  }

  join: mn_rbt_ctrt_srep_dim {
    from: mn_user_dim
    view_label: "Contract Sales Rep"
  }

  join: mn_rbt_ctrt_status_dim {
    from: mn_ctrt_status_dim
    view_label: "Contract"
  }

  join: mn_rbt_ctrt_domain_dim {
    from: mn_ctrt_domain_dim
    view_label: "Contract"
  }

  join: mn_rbt_ctrt_type_dim {
    from: mn_ctrt_type_dim
    view_label: "Contract"
  }

  join: mn_rbt_ctrt_sub_type_dim {
    from: mn_ctrt_sub_type_dim
   view_label: "Contract"
  }

  join: mn_rbt_cust_owner_dim {
    from: mn_customer_dim
    view_label: "Contracted Customer"
  }

  join: mn_rbt_cust_cot_dim {
    from: mn_customer_cot_dim
    view_label: "Contracted Customer COT"
  }

  join: mn_rbt_cot_dim {
    from: mn_cot_dim
    view_label: "Contracted Customer COT"
  }

  join: mn_rbt_ctrt_parent_dim {
    from: mn_contract_header_dim_reuse
    view_label: "Contract"
  }

  join: mn_rbt_distrib_mthd_dim {
    from: mn_distrib_mthd_dim
    view_label: "Contract"
  }

  join: mn_rbt_org_dim {
    from: mn_org_dim
    view_label: "Contract"
  }
  #   Complete relabel
}

# **************************************** Payer Utilization
explore: payer_utilization {
  label: "Payer Utilizations"
  from: mn_mco_util_fact
  view_name: mn_mco_util_fact
  view_label: "Utilization Lines"
  hidden: no

#****************************** Data security

  access_filter: {
    field: mn_user_access_util_map.access_user_id
    user_attribute: access_user_id
  }

  always_filter: {
    filters: {
      field: mn_to_uom_dim.to_uom
    }
  }

  # User Org join
  join: mn_user_access_util_map {
    type: inner
    relationship: many_to_one
    from: mn_user_org_map
#     view_label: "User Access"
    fields: [access_user_id]
    sql_on: ${mn_mco_util_fact.org_wid} = ${mn_user_access_util_map.org_wid};;
  }

  #******************************* Data Security End

  join: mn_util_customer_dim_bob {
    type:  left_outer
    relationship: many_to_one
    from: mn_customer_dim_reuse
    view_label: "Book of Business"
    sql_on: ${mn_mco_util_fact.bob_wid} = ${mn_util_customer_dim_bob.customer_wid} ;;
    fields: [mn_util_customer_dim_bob.bob_set*]
  }

  join: mn_util_plan_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_customer_dim_reuse
    view_label: "Plan"
    sql_on: ${mn_mco_util_fact.plan_wid} = ${mn_util_plan_dim.customer_wid} ;;
    fields: [mn_util_plan_dim.plan_set*]
  }

  join: mn_util_plan_cust_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_customer_dim_reuse
    view_label: "Plan Customer"
    sql_on: ${mn_mco_util_fact.plan_customer_wid} = ${mn_util_plan_cust_dim.customer_wid} ;;
    fields: [mn_util_plan_cust_dim.plan_customer_set*]
  }

  join: mn_util_ctrt_customer_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_customer_dim_reuse
    view_label: "Contracted Customer"
    sql_on: ${mn_mco_util_fact.contract_cust_wid} = ${mn_util_ctrt_customer_dim.customer_wid} ;;
    fields: [mn_util_ctrt_customer_dim.customer*]
  }

  join: mn_util_ctrt_customer_id {
    type:  left_outer
    relationship: one_to_many
    from: mn_customer_ids_dim
    view_label: "Contracted Customer"
    sql_on: ${mn_util_ctrt_customer_dim.customer_wid} = ${mn_util_ctrt_customer_id.customer_wid} ;;
  }

  join: mn_mco_submission_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_mco_submission_dim
    view_label: "Submissions"
    fields: [mn_mco_submission_dim.mco_submissions_set*]
    sql_on: ${mn_mco_util_fact.mco_submission_wid} = ${mn_mco_submission_dim.mco_submission_wid} ;;
  }

  join: mn_util_product_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product"
    sql_on: ${mn_mco_util_fact.product_wid} = ${mn_util_product_dim.product_wid} ;;
  }

  join: mn_util_product_map_all_ver {
    type:  left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Product"
    sql_on: ${mn_util_product_dim.product_wid} = ${mn_util_product_map_all_ver.level0_product_wid} ;;
  }

  join: mn_formulary_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_formulary_dim
    view_label: "Formulary"
    sql_on: ${mn_mco_util_fact.formulary_wid} = ${mn_formulary_dim.formulary_wid} ;;
  }

  join: mn_util_org_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_org_dim
    view_label: "Utilization Lines"
    sql_on: ${mn_mco_util_fact.org_wid} = ${mn_util_org_dim.org_wid} ;;
  }

  join: mn_util_cot_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_cot_dim
    view_label: "Class of Trade"
    sql_on: ${mn_mco_util_fact.cot_wid} = ${mn_util_cot_dim.cot_wid} ;;
  }

  join: mn_from_uom_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_uom_dim
    view_label: "Utilization Lines"
    fields: []
    sql_on: ${mn_mco_util_fact.uom} = ${mn_from_uom_dim.from_uom_util} ;;
  }

  join: mn_uom_conversion_fact {
    type: left_outer
    relationship: many_to_many
    from: mn_uom_conversion_fact
    view_label: "Utilization Lines"
    sql_on: ${mn_mco_util_fact.product_wid} = ${mn_uom_conversion_fact.product_wid}
            and ((${mn_uom_conversion_fact.eff_start_raw} >= ${mn_mco_util_fact.period_start_raw}
            and ${mn_uom_conversion_fact.eff_start_raw} <= ${mn_mco_util_fact.period_end_raw})
            or  (${mn_mco_util_fact.period_start_raw} >= ${mn_uom_conversion_fact.eff_start_raw}
            and ${mn_mco_util_fact.period_start_raw} <=  ${mn_uom_conversion_fact.eff_end_raw}))
            and ${mn_from_uom_dim.src_sys_uom_code} = ${mn_uom_conversion_fact.from_uom} ;;
  }

  join: mn_to_uom_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_uom_dim
    view_label: "Utilization Lines"
    fields: [mn_to_uom_dim.to_uom]
    sql_on: ${mn_uom_conversion_fact.to_uom} = ${mn_to_uom_dim.src_sys_uom_code} ;;
  }

}

# **************************************** Payer Rebates
explore: payer_rebates {
  label: "Payer Rebates"
  from: mn_rebate_payment_fact_payer
  view_name: mn_rebate_payment_fact
  view_label: "Rebate Payment"

  extends: [mn_payer_rebate_payment_fact_base,mn_paid_rebate_lines_base,
    mn_rbt_ctrt_header_dim_base,mn_combined_rebate_program_dim_base,mn_payment_package_dim_base]

  fields: [ALL_FIELDS*,-mn_discount_bridge_fact.payer_discount_bridge_excluded_set*,
    -mn_rebate_payment_fact.payer_rebatepayment_excluded_set*,-mn_rbt_ctrt_header_dim.payer_excl_set*,-mn_payment_package_dim.payer_excl_set*,
    -mn_rebate_payment_fact.payer_excl_set*,-mn_discount_bridge_fact.payer_excl_set*]

  # fields: [ALL_FIELDS*,-mn_discount_bridge_fact.payer_discount_bridge_excluded_set*,
  #   -mn_rebate_payment_fact.payer_rebatepayment_excluded_set*,-mn_rbt_ctrt_header_dim.ctrt_num_provider]

  hidden: no

  sql_always_where: ${mn_rebate_payment_fact.contract_type} in ('Managed Care','Medicare Part D','Tricare');;

  join: mn_discount_bridge_fact {
    from: mn_discount_bridge_fact_payer
    view_label: "Rebate Lines"
    type: left_outer
    relationship: one_to_many
    sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${mn_discount_bridge_fact.rebate_pmt_wid} and ${mn_discount_bridge_fact.is_historical_flag}='N' and ${mn_discount_bridge_fact.paid_amt} <> 0;;

  }

  join: mn_rbt_ctrt_header_dim {
    from: mn_contract_header_dim_payer
    view_label: "Rebate Contract"
    type: left_outer
    relationship: many_to_one
    sql_on: ${mn_rebate_payment_fact.contract_wid} = ${mn_rbt_ctrt_header_dim.contract_wid} ;;
  }

  join: mn_rbt_product_dim {
    from: mn_product_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Rebate Product"
    sql_on: ${mn_discount_bridge_fact.product_wid} = ${mn_rbt_product_dim.product_wid} ;;
  }

  join:  mn_rbtplan_dim {
    from: mn_customer_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Rebate Plan"
    sql_on: ${mn_discount_bridge_fact.plan_wid} = ${mn_rbtplan_dim.customer_wid}
      and Upper(${mn_rbtplan_dim.member_info_type}) = 'PLAN' ;;
    fields: [mn_rbtplan_dim.plan_set*]
  }

  join: mn_combined_rebate_program_dim {
    from: mn_combined_rebate_program_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Rebate Program"
    sql_on: ${mn_rebate_payment_fact.rebate_program_wid} = ${mn_combined_rebate_program_dim.program_wid}
      and ${mn_combined_rebate_program_dim.contract_wid} = ${mn_rebate_payment_fact.contract_wid};;
  }

  join: mn_payment_package_dim {
    from: mn_payment_package_dim_payer
    type: left_outer
    relationship: many_to_one
    view_label: "Payment Package"
    sql_on: ${mn_rebate_payment_fact.pymt_pkg_wid} = ${mn_payment_package_dim.pymt_pkg_wid} ;;
  }

  #   Relabelling the existing labels
#   join: mn_rbt_ctrt_author_dim {
#     from: mn_user_dim
#     view_label: "Contract Author"
#   }
#
#   join: mn_rbt_ctrt_srep_dim {
#     from: mn_user_dim
#     view_label: "Contract Sales Rep"
#   }
#
#   join: mn_rbt_ctrt_status_dim {
#     from: mn_ctrt_status_dim
#     view_label: "Contract"
#   }
#
#   join: mn_rbt_ctrt_domain_dim {
#     from: mn_ctrt_domain_dim
#     view_label: "Contract"
#   }
#
#   join: mn_rbt_ctrt_type_dim {
#     from: mn_ctrt_type_dim
#     view_label: "Contract"
#   }
#
#   join: mn_rbt_ctrt_sub_type_dim {
#     from: mn_ctrt_sub_type_dim
#     view_label: "Contract"
#   }
#
#   join: mn_rbt_cust_owner_dim {
#     from: mn_customer_dim
#     view_label: "Contract Owner Account"
#   }
#
#   join: mn_rbt_cust_cot_dim {
#     from: mn_customer_cot_dim
#     view_label: "Contract Customer COT"
#   }
#
#   join: mn_rbt_cot_dim {
#     from: mn_cot_dim
#     view_label: "Contract Customer COT"
#   }
#
#   join: mn_rbt_ctrt_parent_dim {
#     from: mn_contract_header_dim
#     view_label: "Contract"
#   }
#
#   join: mn_rbt_distrib_mthd_dim {
#     from: mn_distrib_mthd_dim
#     view_label: "Contract"
#   }
#
#   join: mn_rbt_org_dim {
#     from: mn_org_dim
#     view_label: "Contract"
#   }

  join: mn_rbt_cust_owner_dim {
    from: mn_customer_dim
    view_label: "Rebate Contracted Customer"
  }
#   # Complete relable

   #  ************************** Hiding unwanted joins
  join: mn_rbt_ctrt_delegate_dim {
    from: mn_user_dim
    view_label: "Contract Additional Delegate"
    fields: []
  }

}

# **************************************** Payer Estimated Rebates
explore: payer_estimated_rebates{
  label: "Payer Estimated Rebates"
  from: mn_est_rebate_payment_fact
  view_name: mn_est_rebate_payment_fact
  extends: [estimated_rebates_base]

  fields: [ALL_FIELDS*,-mn_rbt_ctrt_header_dim.payer_excl_set*,-mn_payment_package_dim.payer_excl_set*]

  hidden: no

  sql_always_where: ${mn_est_rebate_payment_fact.estimate_pmt_type} = 'Managed Care';;

  join: mn_rbt_ctrt_header_dim {
    type: left_outer
    view_label: "Rebate Contract"
    relationship: many_to_one
    from: mn_contract_header_dim_payer
    sql_on: ${mn_rbt_ctrt_header_dim.contract_wid} =
                    Case
                    When ${mn_est_rebate_pmt_prod_map.contract_wid} Is Not Null
                    Then ${mn_est_rebate_pmt_prod_map.contract_wid}
                    Else
                    ${mn_est_rebate_payment_fact.contract_wid}
                    End
                    And ${mn_rbt_ctrt_header_dim.latest_flag} = 'Y' ;;
  }

  #   Relabelling the existing labels
  join: mn_payment_package_dim {
    from: mn_payment_package_dim_payer
    view_label: "Payment Package"
  }

  join: mn_rbt_cust_owner_dim {
    from: mn_customer_dim
    view_label: "Rebate Contracted Customer"
  }
  # Complete relable
}

# **************************************** Payer Historical Rebates
explore: payer_historical_rebates {
  label: "Payer Historical Rebates"
  from: mn_discount_bridge_fact
  view_name: mn_discount_bridge_fact
  extends: [historical_rebates_base]
  hidden: no

  sql_always_where: ${mn_discount_bridge_fact.is_historical_flag}='Y'
    AND (${mn_discount_bridge_fact.mco_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.rebate_module_type} = 'MCO') ;;
}

# **************************************** Payer Combined Model
explore:  payer_combined {
  label: "Payer Combined"
  from: mn_mco_util_fact
  view_name: mn_mco_util_fact
  extends: [payer_utilization,mn_payer_rebate_payment_fact_base,mn_rbt_ctrt_header_dim_base,mn_combined_rebate_program_dim_base]
  view_label: "Utilization Lines"

  fields: [ALL_FIELDS*,-mn_comb_disc_ben_qual_lines.payer_discount_bridge_excluded_set*,
    -mn_rebate_payment_fact.payer_rebatepayment_excluded_set*,-mn_rbt_ctrt_header_dim.payer_comb_excl_set*,
    -mn_payment_package_dim.payer_excl_set*,-mn_rebate_payment_fact.payer_excl_set*,
    -mn_comb_disc_ben_qual_lines.payer_excl_set*]

  # fields: [ALL_FIELDS*,-mn_discount_bridge_fact.payer_discount_bridge_excluded_set*,
  #   -mn_rebate_payment_fact.payer_rebatepayment_excluded_set*,-mn_rbt_ctrt_header_dim.ctrt_num_provider]

  hidden: no

  join: mn_comb_disc_ben_qual_lines {
    type: left_outer
    relationship: one_to_many
    from: mn_comb_disc_ben_qual_line_pyr
    sql_on: ${mn_mco_util_fact.pub_util_id} = ${mn_comb_disc_ben_qual_lines.pub_util_id} ;;
#     sql_where: ${mn_comb_disc_ben_qual_lines.line_type} = 'Benefit' ;;
    view_label: "Rebate Lines"
  }

  join: mn_rebate_payment_fact {
    type: left_outer
    view_label: "Rebate Payment"
    relationship: many_to_one
    from: mn_rebate_payment_fact_payer
    sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${mn_comb_disc_ben_qual_lines.rebate_pmt_wid};;
  }

  join: rbt_pmt_qual_ben_map {
    type: left_outer
    relationship: one_to_many
    from: rbt_pmt_qual_ben_map
    fields: []
    sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${rbt_pmt_qual_ben_map.rebate_pmt_wid} ;;
  }

  join: mn_rbt_qual_mb_prod_map_all {
    type: left_outer
    relationship: many_to_one
    from: mn_rbt_qual_mb_prod_map_all
    view_label: "Rebate Program Qualification MB Product"
    sql_on: ${rbt_pmt_qual_ben_map.program_qual_ben_wid} = ${mn_rbt_qual_mb_prod_map_all.program_qual_wid}
            and ${mn_mco_util_fact.product_wid} = ${mn_rbt_qual_mb_prod_map_all.product_wid}
            and ${mn_rbt_qual_mb_prod_map_all.product_type} = 'Item' ;;
    sql_where: ${mn_rbt_qual_mb_prod_map_all.product_wid} is not null  and ${mn_rebate_payment_fact.payment_status} = 'Paid';;
  }

  join: mn_market_share_num_prod_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_market_share_num_prod_dim
    view_label: "Rebate Program Qualification MB Product"
    fields: [mn_market_share_num_prod_dim.numerator_flag]
    sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} =  ${mn_market_share_num_prod_dim.product_wid} ;;
  }

  join: mn_rbt_qual_mb_prod_nms_fact {
    type: left_outer
    relationship: many_to_many
    from: mn_rbt_ql_mb_prod_nms_fact
    view_label: "Rebate Lines"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.program_qual_wid} = ${mn_rbt_qual_mb_prod_nms_fact.program_qual_wid}
            and ${mn_rbt_qual_mb_prod_map_all.basket_wid} = ${mn_rbt_qual_mb_prod_nms_fact.basket_wid}
            and ${mn_mco_util_fact.product_wid} = ${mn_rbt_qual_mb_prod_nms_fact.product_wid}
            and ((${mn_rbt_qual_mb_prod_nms_fact.start_date} >= ${mn_rebate_payment_fact.start_date}
            and ${mn_rbt_qual_mb_prod_nms_fact.start_date} <= ${mn_rebate_payment_fact.end_date})
            or  (${mn_rebate_payment_fact.start_date} >= ${mn_rbt_qual_mb_prod_nms_fact.start_date}
            and ${mn_rebate_payment_fact.start_date} <=  ${mn_rbt_qual_mb_prod_nms_fact.end_date})) ;;
  }

  join: mn_rbt_qual_mb_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_market_basket_dim
    view_label: "Rebate Program Qualification MB Product"
    sql_on: ${rbt_pmt_qual_ben_map.basket_wid} = ${mn_rbt_qual_mb_dim.market_basket_wid} ;;
  }

  join: mn_rbt_qual_mb_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Qualification MB Product"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_dim.product_wid} ;;
    fields: [ndc, product_num, product_name,product_type_adhoc]
  }

  join: mn_rbt_qual_mb_prod_hier {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Qualification MB Product Hierarchy"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_hier.level0_product_wid} ;;
  }

  join: mn_rbt_qual_mb_prod_eda {
    type: left_outer
    relationship: many_to_many
    from: mn_product_eff_attr_fact
    view_label: "Rebate Program Qualification MB Product EDA"
    sql_on: ${mn_rbt_qual_mb_prod_map_all.product_wid} = ${mn_rbt_qual_mb_prod_eda.product_wid} ;;
  }

  join: mn_combined_rebate_program_dim {
    type: left_outer
    view_label: "Rebate Program"
    relationship: many_to_one
    from: mn_combined_rebate_program_dim
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rebate_payment_fact.rebate_program_wid}
      and ${mn_combined_rebate_program_dim.contract_wid} = ${mn_rebate_payment_fact.contract_wid} ;;
  }

  join: mn_rbt_ctrt_header_dim {
    from: mn_contract_header_dim_payer
    view_label: "Contract"
    type: left_outer
    relationship: many_to_one
    sql_on: ${mn_rebate_payment_fact.contract_wid} = ${mn_rbt_ctrt_header_dim.contract_wid} ;;
  }

  join: mn_ctrt_adtnl_dlgt_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Contract Additional Delegate"
    sql_on: ${mn_rbt_ctrt_header_dim.author_wid} = ${mn_ctrt_adtnl_dlgt_dim.user_wid};;
  }

  join: mn_payment_package_dim {
    from: mn_payment_package_dim_payer
    type: left_outer
    relationship: many_to_one
    view_label: "Payment Package"
    sql_on: ${mn_rebate_payment_fact.pymt_pkg_wid} = ${mn_payment_package_dim.pymt_pkg_wid} ;;
  }

  join: mn_dbf_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Lines Payee"
    sql_on: ${mn_comb_disc_ben_qual_lines.payee_wid} = ${mn_dbf_customer_dim.customer_wid};;
  }

  #  ******************************** Relabelling the existing labels
  join: mn_util_customer_dim_bob {
    from: mn_customer_dim_reuse
    view_label: "Util Book of Business"
  }

  join: mn_util_plan_dim {
    from: mn_customer_dim_reuse
    view_label: "Util Plan"
  }

  join: mn_util_plan_cust_dim {
    from: mn_customer_dim_reuse
    view_label: "Util Plan Customer"
  }

  join: mn_util_ctrt_customer_dim {
    from: mn_customer_dim_reuse
    view_label: "Util Contracted Customer"
  }

  join: mn_util_ctrt_customer_id {
    from: mn_customer_ids_dim
    view_label: "Util Contracted Customer"
  }

  join: mn_mco_submission_dim {
    from: mn_mco_submission_dim
    view_label: "Util Submission"
  }

  join: mn_util_product_dim {
    from: mn_product_dim
    view_label: "Util Product"
  }
  join: mn_util_product_map_all_ver {
    from: mn_product_map_all_ver
    view_label: "Util Product"
  }

  join: mn_formulary_dim {
    from: mn_formulary_dim
    view_label: "Util Formulary"
  }

  join: mn_util_cot_dim {
    from: mn_cot_dim
    view_label: "Util COT"
  }
  # Complete relabel

  #  ************************** Hiding unwanted joins - from Exended Rebates
  join: mn_rbt_cust_owner_dim {
    from: mn_customer_dim
    fields: []
  }

  join: mn_rbt_cust_cot_dim {
    from: mn_customer_cot_dim
    fields: []
  }

  join: mn_rbt_cot_dim {
    from: mn_cot_dim
    fields: []
  }

  #   Relabelling the existing labels
  join: mn_rbt_ctrt_author_dim {
    from: mn_user_dim
    view_label: "Contract Author"
  }

  join: mn_rbt_ctrt_srep_dim {
    from: mn_user_dim
    view_label: "Contract Sales Rep"
  }

  join: mn_rbt_ctrt_status_dim {
    from: mn_ctrt_status_dim
    view_label: "Contract"
  }

  join: mn_rbt_ctrt_domain_dim {
    from: mn_ctrt_domain_dim
    view_label: "Contract"
  }

  join: mn_rbt_ctrt_type_dim {
    from: mn_ctrt_type_dim
    view_label: "Contract"
  }

  join: mn_rbt_ctrt_sub_type_dim {
    from: mn_ctrt_sub_type_dim
    view_label: "Contract"
  }

  join: mn_rbt_ctrt_parent_dim {
    from: mn_contract_header_dim
    view_label: "Contract"
  }

  join: mn_rbt_distrib_mthd_dim {
    from: mn_distrib_mthd_dim
    view_label: "Contract"
  }

  join: mn_rbt_org_dim {
    from: mn_org_dim
    view_label: "Contract"
  }
  # Complete relable
}
