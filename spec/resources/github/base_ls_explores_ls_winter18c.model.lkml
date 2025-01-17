include: "base_ls_database_connection_ls_winter18c.model.lkml"

include: "base_mn_user_access_map.view.lkml"
include: "base_mn_contract_header_dim.view.lkml"
include: "base_mn_contract_header_dim_payer.view.lkml"
include: "base_mn_contract_header_dim_secure.view.lkml"
include: "base_mn_contract_header_dim_reuse.view.lkml"
include: "base_mn_user_dim.view.lkml"
include: "base_mn_ctrt_status_dim.view.lkml"
include: "base_mn_ctrt_domain_dim.view.lkml"
include: "base_mn_ctrt_type_dim.view.lkml"
include: "base_mn_ctrt_sub_type_dim.view.lkml"
include: "base_mn_customer_dim.view.lkml"
include: "base_mn_product_group_dim.view.lkml"
include: "base_mn_bus_segment_dim.view.lkml"
include: "base_mn_price_list_dim.view.lkml"
include: "base_mn_price_list_fact.view.lkml"
include: "base_mn_prc_method_dim.view.lkml"
include: "base_mn_user_org_map.view.lkml"
include: "base_mn_combined_rebate_program_dim.view.lkml"
include: "base_mn_accrual_type_dim.view.lkml"
include: "base_mn_pmt_type_dim.view.lkml"
include: "base_mn_program_type_dim.view.lkml"
include: "base_mn_pmt_mth_type_dim.view.lkml"
include: "base_mn_ctrt_elig_cot_map.view.lkml"
include: "base_mn_cot_dim.view.lkml"
include: "base_mn_ctrt_elig_cot_map.view.lkml"
include: "base_mn_pg_prod_adhoc_map_exp.view.lkml"
include: "base_mn_pg_prod_adhoc_map_incl.view.lkml"

include: "base_mn_pg_qual_ben_flat.view.lkml"
#include: "base_mn_pg_qual_ben_flat_lkr.view.lkml"
#include: "base_mn_pg_qual_ben_unflat_lkr.view.lkml"
include: "base_mn_pg_qual_ben_unflat.view.lkml"

include: "base_mn_rbt_qual_mb_prod_map.view.lkml"
include: "base_mn_product_dim.view.lkml"
include: "base_mn_market_basket_dim.view.lkml"
include: "base_mn_product_group_dim.view.lkml"
include: "base_mn_rbt_prog_qual_prod_map.view.lkml"
include: "base_mn_rbt_prog_ben_prod_map.view.lkml"
include: "base_mn_rebate_payment_fact.view.lkml"
include: "base_mn_rebate_payment_fact_payer.view.lkml"
include: "base_mn_payment_package_dim.view.lkml"
include: "base_mn_payment_package_dim_payer.view.lkml"
include: "base_mn_customer_cot_dim.view.lkml"
include: "base_mn_org_dim.view.lkml"
include: "base_mn_distrib_mthd_dim.view.lkml"
include: "base_mn_rbt_prog_qual_ben_dim.view.lkml"
include: "base_mn_rbt_prog_qual_ben_sd_rpt.view.lkml"
include: "base_mn_discount_bridge_fact.view.lkml"
include: "base_mn_discount_bridge_fact_payer.view.lkml"
include: "base_mn_rebate_type_dim.view.lkml"
include: "base_mn_rebate_payment_package_dim.view.lkml"
include: "base_mn_combined_product_group_dim.view.lkml"
include: "base_mn_est_rebate_payment_fact.view.lkml"
include: "base_mn_est_rebate_pmt_prod_map.view.lkml"

include: "base_mn_customer_ids_dim.view.lkml"
include: "base_mn_mco_submission_dim.view.lkml"
include: "base_mn_formulary_dim.view.lkml"
include: "base_mn_customer_ids_dim.view.lkml"
include: "base_mn_cmpl_commit_fact.view.lkml"

include: "base_mn_rbt_prg_qual_flat_dim.view.lkml"
include: "base_mn_rbt_qual_prod_map_all.view.lkml"
include: "base_mn_rbt_prg_ben_flat_dim.view.lkml"
include: "base_mn_rbt_ben_prod_map_all.view.lkml"
include: "base_mn_product_map_all_vers.view.lkml"
include: "base_mn_product_eff_attr_fact.view.lkml"
include: "base_mn_product_eff_attr_fact_ext.view.lkml"
include: "base_mn_rbt_qual_mb_prod_map_all.view.lkml"
include: "base_mn_market_basket_dim.view.lkml"
include: "base_mn_product_group_dim.view.lkml"
include: "base_mn_rbt_prg_qual_elg_cst_map_dt.view.lkml"
include: "base_mn_rbt_prg_ben_elg_cst_map_dt.view.lkml"
include: "base_mn_plan_formulary_map.view.lkml"
include: "base_mn_formulary_dim.view.lkml"
include: "base_mn_formulary_prod_map.view.lkml"
include: "base_mn_rebate_prog_prod_map_all.view.lkml"
include: "base_mn_contract_attr_fact.view.lkml"
include: "base_mn_mco_util_fact.view.lkml"

include: "base_mn_rbt_prg_ben_flat_dim.view.lkml"
include: "base_mn_erp_payment_fact.view.lkml"
include: "base_mn_customer_dim_reuse.view.lkml"
include: "base_mn_rebate_pmt_ben_fact.view.lkml"
include: "base_mn_comb_disc_ben_qual_lines.view.lkml"
include: "base_mn_comb_disc_ben_qual_lines_payer.view.lkml"
include: "base_mn_rbt_pmt_qual_ben_map.view.lkml"
include: "base_mn_market_share_num_prod_dim.view.lkml"
include: "base_mn_rbt_ql_mb_prod_nms_fact.view.lkml"
include: "base_mn_comb_pg_rp_comp_dim.view.lkml"
include: "base_mn_combined_pg_rp_dim.view.lkml"
include: "base_mn_uom_conversion_fact.view.lkml"
include: "base_mn_uom_dim.view.lkml"


# Governmenmt explorer view

include: "base_mn_mcd_claim_line_fact.view.lkml"
include: "base_mn_mcd_claim_line_fact_dt.view.lkml"
include: "base_mn_mcd_claim_dim.view.lkml"
include: "base_mn_mcd_claim_pmt_payee_map.view.lkml"
include: "base_mn_mcd_payment_fact.view.lkml"
include: "base_mn_user_dim.view.lkml"
include: "base_mn_price_list_dim.view.lkml"
include: "base_mn_mcd_util_fact.view.lkml"
include: "base_mn_mcd_program_state_map.view.lkml"
include: "base_mn_mcd_program_product_map.view.lkml"
include: "base_mn_mcd_program_dim.view.lkml"
include: "base_mn_mcd_claim_payment_map.view.lkml"
include: "base_mn_mcd_dispute_code_dim.view.lkml"
include: "base_mn_mcd_adjust_type_dim.view.lkml"
include: "base_mn_mcd_dispute_code_dim_dt.view.lkml"
include: "base_mn_mcd_adjust_type_dim_dt.view.lkml"
include: "base_mn_user_dim_reuse.view.lkml"
include: "base_mn_prod_addl_eff_attr_fact.view.lkml"
include: "base_mn_product_dim_reuse.view.lkml"
include: "base_mn_product_attr_fact.view.lkml"
include: "base_mn_mcd_prod_ura_prc_fact.view.lkml"

# Master Data explorer views

include: "base_mn_cust_attr_err_lines_fact.view.lkml"
include: "base_mn_customer_addr_fact.view.lkml"
include: "base_mn_customer_attr_fact.view.lkml"
include: "base_mn_user_contact_fact.view.lkml"
include: "base_mn_customer_map.view.lkml"
include: "base_mn_cot_dim_ext.view.lkml"
include: "base_mn_customer_cot_dim_ext.view.lkml"
include: "base_mn_customer_ids_dim_ext.view.lkml"
include: "base_mn_plan_formulary_map_ext.view.lkml"

# Validata Explorer views
include: "base_mn_vd_file_header_fact.view.lkml"
include: "base_mn_vd_tx_item_fact.view.lkml"
include: "base_mn_vd_tx_item_rev_map.view.lkml"
include: "base_mn_vd_tx_item_dupl_map.view.lkml"
include: "base_mn_vd_mds_dim.view.lkml"
include: "base_mn_vd_file_item_hist_fact.view.lkml"
include: "base_mn_vd_cgd_item_fact.view.lkml"
include: "base_mn_vd_cgi_item_fact.view.lkml"
include: "base_mn_vd_contract_dim.view.lkml"
include: "base_mn_vd_file_header_fact_reuse.view.lkml"
include: "base_mn_vd_file_usg_hist_fact.view.lkml"
include: "base_mn_vd_cgd_item_dupl_map.view.lkml"
include: "base_mn_vd_file_item_error_fact.view.lkml"

# GP Explore Views
include: "base_mn_lkr_gp_comb_sales_fact.view.lkml"
include: "base_mn_customer_cot_dim_dt.view.lkml"
include: "base_mn_product_group_dim_ext.view.lkml"
include: "base_mn_price_list_dim_all_vers.view.lkml"
include: "base_mn_price_list_fact_all_vers.view.lkml"
include: "base_mn_rebate_program_dim.view.lkml"
include: "base_mn_custom_type_dim.view.lkml"
include: "base_mn_gp_price_type_dim.view.lkml"
include: "base_mn_gp_workbook_dim.view.lkml"
include: "base_mn_gp_workbook_result_fact.view.lkml"
include: "base_mn_gp_netpp_fact.view.lkml"
include: "base_mn_gp_pt_worksheet_dim.view.lkml"
include: "base_mn_gp_pt_mapping_dim.view.lkml"


############ Named Value Formats ######################

named_value_format: usd_6 {
  value_format: "$#,##0.000000"
}

############ Base Explores ##############################
explore: mn_contract_header_dim_base {

  from:  mn_contract_header_dim
  view_name: mn_contract_header_dim
  hidden: yes
  extension: required


  join: mn_contract_author_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Pricing Contract Author"
    #fields: [full_name]
    sql_on: ${mn_contract_header_dim.author_wid} = ${mn_contract_author_dim.user_wid};;
  }

  join: mn_additional_delegate_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Pricing Contract Additional Delegate"
    #fields: [full_name]
    sql_on: ${mn_contract_header_dim.additional_delegate_wid} = ${mn_additional_delegate_dim.user_wid};;
  }

  join: mn_contract_srep_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Pricing Contract Sales Rep"
    #fields: [full_name]
    sql_on: ${mn_contract_header_dim.sales_rep_wid} = ${mn_contract_srep_dim.user_wid};;
  }


  join: mn_ctrt_status_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_status_dim
    view_label: "Pricing Contract"
    #fields: []
    sql_on: ${mn_contract_header_dim.contract_status_wid} = ${mn_ctrt_status_dim.status_wid};;
  }

  join: mn_ctrt_domain_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_domain_dim
    view_label: "Pricing Contract"
    #fields: []
    sql_on: ${mn_contract_header_dim.contract_domain_wid} = ${mn_ctrt_domain_dim.domain_wid};;
  }

  join: mn_ctrt_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_type_dim
    view_label: "Pricing Contract"
    fields: [mn_ctrt_type_dim.ctrt_type_name]
    sql_on: ${mn_contract_header_dim.contract_type_wid} = ${mn_ctrt_type_dim.ctrt_type_wid};;
  }

  join: mn_ctrt_sub_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_sub_type_dim
    view_label: "Pricing Contract"
    fields: [mn_ctrt_sub_type_dim.ctrt_sub_type_name]
    sql_on: ${mn_contract_header_dim.contract_sub_type_wid} = ${mn_ctrt_sub_type_dim.ctrt_sub_type_wid};;
  }

  join: mn_customer_owner_dim {
    type: left_outer
      relationship: many_to_one
      from: mn_customer_dim
      view_label: "Pricing Contract Owner Account"
      #fields: []
      sql_on: ${mn_contract_header_dim.owner_wid} = ${mn_customer_owner_dim.customer_wid};;
    }

}

# Adhoc base explore for contract header with all needed joins

explore: mn_contract_header_dim_adhoc_base {

  extends: [mn_contract_header_dim_base]
  from:  mn_contract_header_dim
  view_name: mn_contract_header_dim
  hidden: yes
  extension: required

  join: mn_ch_org_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_org_dim
    view_label: "Pricing Contract"
    sql_on: ${mn_contract_header_dim.org_wid} = ${mn_ch_org_dim.org_wid} ;;
  }

  join: mn_ch_cust_cot_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_cot_dim
    view_label: "Pricing Contract Owner COT"
    sql_on: ${mn_contract_header_dim.owner_wid} = ${mn_ch_cust_cot_dim.customer_wid}
            and ${mn_ch_cust_cot_dim.eff_start_raw} <= ${mn_contract_header_dim.eff_end_raw}
            and ${mn_ch_cust_cot_dim.eff_end_raw} >= ${mn_contract_header_dim.eff_start_raw} ;;
  }

  join: mn_ch_cot_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_cot_dim
    view_label: "Pricing Contract Owner COT"
    sql_on: ${mn_ch_cust_cot_dim.cot_wid} = ${mn_ch_cot_dim.cot_wid} ;;
  }

  join: mn_parent_contract_header_dim {
    from: mn_contract_header_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Pricing Contract"
    fields: [mn_parent_contract_header_dim.parentcontractid_set*]
    sql_on: ${mn_contract_header_dim.parent_contract_wid} = ${mn_parent_contract_header_dim.contract_wid} ;;
  }

  join: mn_distrib_mthd_dim {
    from: mn_distrib_mthd_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Pricing Contract Distribution Method"
    sql_on: ${mn_contract_header_dim.distribution_method_wid} = ${mn_distrib_mthd_dim.dist_method_wid} ;;
  }

}

explore: mn_contract_header_dim_secure_base {
  extends: [mn_contract_header_dim_base]
  from:  mn_contract_header_dim
  view_name: mn_contract_header_dim
  hidden: yes
  extension: required


#  access_filter: {
#    field: mn_contract_header_dim.access_user_name
#    user_attribute: rme_access_user_name
#  }

  join: mn_user_access_ctrt_map {
    type: inner
    relationship: many_to_one
    from: mn_user_org_map
#     view_label: "User Access"
    fields: [access_user_id]
    sql_on: ${mn_contract_header_dim.org_wid} = ${mn_user_access_ctrt_map.org_wid};;
  }
}

explore: mn_rbt_ctrt_header_dim_secure_base {
  extends: [mn_rbt_ctrt_header_dim_base]
#   from:  mn_contract_header_dim_secure
  from: mn_contract_header_dim
  view_name: mn_rbt_ctrt_header_dim
  hidden: yes
  extension: required


#  access_filter: {
#    field: mn_contract_header_dim.access_user_name
#    user_attribute: rme_access_user_name
#  }

  join: mn_user_access_ctrt_map {
    type: inner
    relationship: many_to_one
    from: mn_user_org_map
#     view_label: "User Access"
    fields: [access_user_id]
    sql_on: ${mn_rbt_ctrt_header_dim.org_wid} = ${mn_user_access_ctrt_map.org_wid};;
  }
}

explore: mn_rbt_ctrt_header_dim_base {

  from:  mn_contract_header_dim
  view_name: mn_rbt_ctrt_header_dim
  hidden: yes
  extension: required


  join: mn_rbt_ctrt_author_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Rebate Contract Author"
    #fields: [full_name]
    sql_on: ${mn_rbt_ctrt_header_dim.author_wid} = ${mn_rbt_ctrt_author_dim.user_wid};;
  }

  join: mn_rbt_ctrt_delegate_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Rebate Contract Additional Delegate"
    #fields: [full_name]
    sql_on: ${mn_rbt_ctrt_header_dim.additional_delegate_wid} = ${mn_rbt_ctrt_delegate_dim.user_wid};;
  }

  join: mn_rbt_ctrt_srep_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Rebate Contract Sales Rep"
    #fields: [full_name]
    sql_on: ${mn_rbt_ctrt_header_dim.sales_rep_wid} = ${mn_rbt_ctrt_srep_dim.user_wid};;
  }


  join: mn_rbt_ctrt_status_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_status_dim
    view_label: "Rebate Contract"
    #fields: []
    sql_on: ${mn_rbt_ctrt_header_dim.contract_status_wid} = ${mn_rbt_ctrt_status_dim.status_wid};;
  }

  join: mn_rbt_ctrt_domain_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_domain_dim
    view_label: "Rebate Contract"
    #fields: []
    sql_on: ${mn_rbt_ctrt_header_dim.contract_domain_wid} = ${mn_rbt_ctrt_domain_dim.domain_wid};;
  }

  join: mn_rbt_ctrt_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_type_dim
    view_label: "Rebate Contract"
    fields: [mn_rbt_ctrt_type_dim.ctrt_type_name]
    sql_on: ${mn_rbt_ctrt_header_dim.contract_type_wid} = ${mn_rbt_ctrt_type_dim.ctrt_type_wid};;
  }

  join: mn_rbt_ctrt_sub_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_sub_type_dim
    view_label: "Rebate Contract"
    fields: [mn_rbt_ctrt_sub_type_dim.ctrt_sub_type_name]
    sql_on: ${mn_rbt_ctrt_header_dim.contract_sub_type_wid} = ${mn_rbt_ctrt_sub_type_dim.ctrt_sub_type_wid};;
  }

  join: mn_rbt_cust_owner_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Contract Owner Account"
    #fields: []
    sql_on: ${mn_rbt_ctrt_header_dim.owner_wid} = ${mn_rbt_cust_owner_dim.customer_wid};;
  }

  join: mn_rbt_cust_cot_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_cot_dim
    view_label: "Rebate Contract Customer COT"
    sql_on: ${mn_rbt_ctrt_header_dim.owner_wid} = ${mn_rbt_cust_cot_dim.customer_wid}
            and ${mn_rbt_cust_cot_dim.eff_start_date} <= ${mn_rbt_ctrt_header_dim.eff_end_date}
            and ${mn_rbt_cust_cot_dim.eff_end_date} >= ${mn_rbt_ctrt_header_dim.eff_start_date} ;;
  }

  join: mn_rbt_cot_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_cot_dim
    view_label: "Rebate Contract Customer COT"
    sql_on: ${mn_rbt_cust_cot_dim.cot_wid} = ${mn_rbt_cot_dim.cot_wid} ;;
  }

  join: mn_rbt_ctrt_parent_dim {
    from: mn_contract_header_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Rebate Contract"
    fields: [mn_rbt_ctrt_parent_dim.parentcontractid_set*]
    sql_on: ${mn_rbt_ctrt_header_dim.parent_contract_wid} = ${mn_rbt_ctrt_parent_dim.contract_wid} ;;
  }

  join: mn_rbt_distrib_mthd_dim {
    from: mn_distrib_mthd_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Rebate Contract"
    sql_on: ${mn_rbt_ctrt_header_dim.distribution_method_wid} = ${mn_rbt_distrib_mthd_dim.dist_method_wid} ;;
  }


  join: mn_rbt_org_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_org_dim
    view_label: "Rebate Contract"
    fields: [org_name,description,currency]
    sql_on: ${mn_rbt_ctrt_header_dim.org_wid} = ${mn_rbt_org_dim.org_wid} ;;
  }

}

explore: mn_product_group_dim_base {
  from:  mn_product_group_dim
  view_name: mn_product_group_dim
  hidden: yes
  extension: required

  join: mn_pg_prc_method_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_prc_method_dim
    view_label: "Pricing Program"
    sql_on: ${mn_product_group_dim.pricing_method_wid} = ${mn_pg_prc_method_dim.prc_method_wid};;
  }

  join: mn_pg_price_list_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_price_list_dim
    view_label: "Contracted Price List"
    sql_on: ${mn_product_group_dim.base_price_list_wid} = ${mn_pg_price_list_dim.price_list_wid};;
  }

  join: mn_pg_bus_segment_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_bus_segment_dim
    view_label: "Pricing Program"
    sql_on: ${mn_product_group_dim.bus_seg_wid} = ${mn_pg_bus_segment_dim.bus_seg_wid};;
  }

  join: mn_pg_tier_basis_dim {
    type: left_outer
    relationship: one_to_many
    from: mn_pg_qual_ben_flat
    view_label: "Pricing Program Tier Basis"
    sql_on: ${mn_product_group_dim.pg_wid} = ${mn_pg_tier_basis_dim.pg_wid}
     AND  ${mn_pg_tier_basis_dim.is_qual_comp_flag} ='Y';;
  }

}

explore: mn_combined_product_group_dim_base {
  from:  mn_combined_product_group_dim
  view_name: mn_combined_product_group_dim
  hidden: yes
  extension: required

  join: mn_prc_method_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_prc_method_dim
    view_label: "Pricing Program"
    sql_on: ${mn_combined_product_group_dim.pricing_method_wid} = ${mn_prc_method_dim.prc_method_wid};;
  }

  join: mn_cpg_price_list_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_price_list_dim
    view_label: "Contracted Price List"
    sql_on: ${mn_combined_product_group_dim.base_price_list_wid} = ${mn_cpg_price_list_dim.price_list_wid};;
  }

  join: mn_cpg_bus_segment_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_bus_segment_dim
    view_label: "Pricing Program"
    sql_on: ${mn_combined_product_group_dim.bus_seg_wid} = ${mn_cpg_bus_segment_dim.bus_seg_wid};;
  }

  join: mn_pg_tier_basis_dim {
    type: left_outer
    relationship: one_to_many
   # from: mn_pg_qual_ben_unflat
   from: mn_pg_qual_ben_flat
    view_label: "Pricing Program Tier Basis"
    sql_on: ${mn_combined_product_group_dim.pg_wid} = ${mn_pg_tier_basis_dim.pg_wid}
    AND  ${mn_pg_tier_basis_dim.is_qual_comp_flag} ='Y';;
  }

}

explore: mn_combined_pg_rp_dim_base {
  from:  mn_combined_pg_rp_dim
  view_name: mn_combined_pg_rp_dim
  hidden: yes
  extension: required

  join: mn_prc_method_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_prc_method_dim
    view_label: "Pricing Program"
    sql_on: ${mn_combined_pg_rp_dim.pricing_method_wid} = ${mn_prc_method_dim.prc_method_wid};;
  }

  join: mn_cpg_price_list_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_price_list_dim
    view_label: "Contracted Price List"
    sql_on: ${mn_combined_pg_rp_dim.base_price_list_wid} = ${mn_cpg_price_list_dim.price_list_wid};;
  }

  join: mn_cpg_bus_segment_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_bus_segment_dim
    view_label: "Pricing Program"
    sql_on: ${mn_combined_pg_rp_dim.bus_seg_wid} = ${mn_cpg_bus_segment_dim.bus_seg_wid};;
  }
}

explore: mn_combined_rebate_program_dim_base {

  from:  mn_combined_rebate_program_dim
  view_name: mn_combined_rebate_program_dim
  hidden: yes
  extension: required

  join: mn_pm_accrual_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_accrual_type_dim
    view_label: "Rebate Program"
    sql_on: ${mn_combined_rebate_program_dim.accrual_type_wid} = ${mn_pm_accrual_type_dim.accrual_type_wid};;
  }

  join: mn_pm_pmt_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_pmt_type_dim
    view_label: "Rebate Program"
    sql_on: ${mn_combined_rebate_program_dim.pmt_type_wid} = ${mn_pm_pmt_type_dim.pmt_type_wid};;
  }

  join: mn_pm_program_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_program_type_dim
    view_label: "Rebate Program"
    sql_on: ${mn_combined_rebate_program_dim.program_type_wid} = ${mn_pm_program_type_dim.program_type_wid};;
  }

  join: mn_pm_pmt_mth_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_pmt_mth_type_dim
    view_label: "Rebate Program"
    sql_on: ${mn_combined_rebate_program_dim.pmt_method_wid} = ${mn_pm_pmt_mth_type_dim.pmt_mth_type_wid};;
  }

  join: mn_crp_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Program Payee"
    sql_on: ${mn_combined_rebate_program_dim.payee_customer_wid} = ${mn_crp_customer_dim.customer_wid};;
  }
}

explore: mn_rebate_payment_fact_base {

  from:  mn_rebate_payment_fact
  view_name: mn_rebate_payment_fact
  hidden: yes
  extension: required

  join: rpf_rebate_payment_payee {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Payment Payee"
    sql_on: ${mn_rebate_payment_fact.payee_customer_wid} = ${rpf_rebate_payment_payee.customer_wid};;
  }

  join: rpf_accrued_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Payment Accrued Customer"
    sql_on: ${mn_rebate_payment_fact.accrued_customer_wid} = ${rpf_accrued_customer.customer_wid};;
  }

  join: rpf_committed_cutomer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Payment Committed Customer"
    sql_on: ${mn_rebate_payment_fact.commited_customer_wid} = ${rpf_committed_cutomer.customer_wid};;
  }

  join: rpf_analyst {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Rebate Payment Analyst"
    sql_on: ${mn_rebate_payment_fact.analyst_user_wid} = ${rpf_analyst.user_wid};;
  }

  join: rpf_sales_rep {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Rebate Payment Sales Rep"
    sql_on: ${mn_rebate_payment_fact.salesrep_user_wid} = ${rpf_sales_rep.user_wid};;
  }


}

explore: mn_payment_package_dim_base {
  from:  mn_payment_package_dim
  view_name: mn_payment_package_dim
  hidden: yes
  extension: required

  join: mn_1pp_pmt_mth_type_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_pmt_mth_type_dim
    view_label: "Payment Package"
    sql_on: ${mn_payment_package_dim.pymt_method_wid} = ${mn_1pp_pmt_mth_type_dim.pmt_mth_type_wid};;
  }

  join: pp_payee {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Payment Package Payee"
    sql_on: ${mn_payment_package_dim.payee_wid} = ${pp_payee.customer_wid};;
  }

  join: pp_analyst {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Payment Package Analyst"
    sql_on: ${mn_payment_package_dim.analyst_wid} = ${pp_analyst.user_wid};;
  }

  join: pp_created_by {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Payment Package Created By"
    sql_on: ${mn_payment_package_dim.created_by_user_wid} = ${pp_created_by.user_wid};;
  }

  join: pp_modified_by {
    type: left_outer
    relationship: many_to_one
    from: mn_user_dim
    view_label: "Payment Package Modified By"
    sql_on: ${mn_payment_package_dim.last_modified_by_user_wid} = ${pp_modified_by.user_wid};;
  }

}

explore: mn_rbt_qual_mb_prod_map_base {
  from:  mn_rbt_qual_mb_prod_map
  view_name: mn_rbt_qual_mb_prod_map
  hidden: yes
  extension: required

  join: mn_rbt_qm_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Qualification Market Basket Product"
    sql_on: ${mn_rbt_qual_mb_prod_map.product_wid} = ${mn_rbt_qm_product_dim.product_wid};;
  }

  join: mn_rbt_qm_market_basket_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_market_basket_dim
    view_label: "Rebate Program Qualification Market Basket"
    sql_on: ${mn_rbt_qual_mb_prod_map.basket_wid} = ${mn_rbt_qm_market_basket_dim.market_basket_wid} ;;
  }

  join: mn_rbt_qm_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Rebate Program Qualification Market Basket Product Group"
    sql_on: ${mn_rbt_qual_mb_prod_map.source_pg_id} = ${mn_rbt_qm_product_group_dim.src_sys_pg_id} ;;
    sql_where: ${mn_rbt_qm_product_group_dim.latest_flag} = 'Y' ;;

  }
}

explore: mn_rbt_prog_ben_prod_map_base {
  from:  mn_rbt_prog_ben_prod_map
  view_name: mn_rbt_prog_ben_prod_map
  hidden: yes
  extension: required

  join: mn_rbt_b_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Benefit Product"
    sql_on: ${mn_rbt_prog_ben_prod_map.product_wid} = ${mn_rbt_b_product_dim.product_wid};;
  }

  join: mn_rbt_b_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Rebate Program Benefit Product Group"
    sql_on: ${mn_rbt_prog_ben_prod_map.source_pg_id} = ${mn_rbt_b_product_group_dim.src_sys_pg_id} ;;
    sql_where: ${mn_rbt_b_product_group_dim.latest_flag} = 'Y' ;;
  }

}

explore: mn_rbt_prog_qual_prod_map_base {
  from:  mn_rbt_prog_qual_prod_map
  view_name: mn_rbt_prog_qual_prod_map
  hidden: yes
  extension: required

  join: mn_rbt_q_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Qualification Product"
    sql_on: ${mn_rbt_prog_qual_prod_map.product_wid} = ${mn_rbt_q_product_dim.product_wid};;
  }

  join: mn_rbt_q_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Rebate Program Qualification Product Group"
    sql_on: ${mn_rbt_prog_qual_prod_map.source_pg_id} = ${mn_rbt_q_product_group_dim.src_sys_pg_id} ;;
    sql_where: ${mn_rbt_q_product_group_dim.latest_flag} = 'Y' ;;
  }
}

explore: mn_paid_rebate_lines_base {

  from:  mn_discount_bridge_fact
  view_name: mn_discount_bridge_fact
  hidden: yes
  extension: required
  sql_always_where: ${mn_discount_bridge_fact.paid_amt} <> 0 ;;

  # join: mn_pr_rebate_type_dim {
  #   type: left_outer
  #   relationship: many_to_one
  #   from: mn_rebate_type_dim
  #   view_label: "Rebate Lines Rebate"
  #   sql_on: ${mn_discount_bridge_fact.rebate_type_wid} = ${mn_pr_rebate_type_dim.rebate_type_wid};;
  # }

  join: mn_dbf_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Lines Payee"
    sql_on: ${mn_discount_bridge_fact.payee_wid} = ${mn_dbf_customer_dim.customer_wid};;
  }
}

# explore: mn_rebate_qual_ben_lines_base {

#   from:  mn_comb_disc_ben_qual_lines
#   view_name: mn_comb_disc_ben_qual_lines
#   hidden: yes

#   join: mn_dbf_customer_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_customer_dim
#     view_label: "Rebate Lines Payee"
#     sql_on: ${mn_comb_disc_ben_qual_lines.payee_wid} = ${mn_dbf_customer_dim.customer_wid};;
#   }
# }

explore: estimated_rebates_base {
  from:  mn_est_rebate_payment_fact
  view_name: mn_est_rebate_payment_fact
  view_label:"Estimated Payment"
  extends: [mn_rbt_ctrt_header_dim_base,
            mn_combined_rebate_program_dim_base,
            mn_payment_package_dim_base]
  hidden: yes
  extension: required


  join: mn_est_rebate_pmt_prod_map {
    type: left_outer
    view_label: "Estimated Rebate Payment Product"
    relationship: one_to_many
    from: mn_est_rebate_pmt_prod_map
    sql_on: ${mn_est_rebate_payment_fact.estimate_pmt_wid} = ${mn_est_rebate_pmt_prod_map.estimate_pmt_wid};;
  }

  join: mn_rbt_ctrt_header_dim {
    type: left_outer
    view_label: "Rebate Contract"
    relationship: many_to_one
    from: mn_contract_header_dim
    sql_on: ${mn_rbt_ctrt_header_dim.contract_wid} =
                    Case
                    When ${mn_est_rebate_pmt_prod_map.contract_wid} Is Not Null
                    Then ${mn_est_rebate_pmt_prod_map.contract_wid}
                    Else
                    ${mn_est_rebate_payment_fact.contract_wid}
                    End
                    And ${mn_rbt_ctrt_header_dim.latest_flag} = 'Y' ;;
  }

  join: mn_payment_package_dim {
    type: left_outer
    view_label: "Rebate Payment Package"
    relationship: many_to_one
    from: mn_payment_package_dim
    sql_on: ${mn_est_rebate_payment_fact.pymt_pkg_wid} = ${mn_payment_package_dim.pymt_pkg_wid};;
  }

  join: mn_er_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Payment Payee"
    sql_on: ${mn_est_rebate_payment_fact.payee_wid} = ${mn_er_customer_dim.customer_wid};;
  }

  join: mn_er_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Benefit Product"
    sql_on: ${mn_est_rebate_pmt_prod_map.product_wid} = ${mn_er_product_dim.product_wid};;
  }

   join: mn_combined_rebate_program_dim {
     type: left_outer
     relationship: many_to_one
     from: mn_combined_rebate_program_dim
     view_label: "Rebate Program"
     sql_on: ${mn_est_rebate_pmt_prod_map.program_wid} = ${mn_combined_rebate_program_dim.program_wid};;
   }

#    join: mn_rbt_prg_ben_flat_dim {
#        type: left_outer
#        view_label: "Rebate Program Benefit"
#        relationship: many_to_one
#        from: mn_rbt_prg_ben_flat_dim
#        sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prg_ben_flat_dim.program_wid};;
#    }

   join: mn_erp_payment_fact {
     type: left_outer
     relationship: many_to_one
     from: mn_erp_payment_fact
     view_label: "ERP Payment"
     sql_on: ${mn_est_rebate_payment_fact.estimate_pmt_wid} = ${mn_erp_payment_fact.estimate_pmt_wid};;
   }
}

explore: historical_rebates_base {
  label: "Historical Rebates"
  from: mn_discount_bridge_fact
  view_name: mn_discount_bridge_fact
  view_label: "Historical Rebates"
  hidden: yes
  extension: required

  join: mn_hr_soldto_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Sold To Customer"
    #fields: [full_name]
    sql_on: ${mn_discount_bridge_fact.sold_to_customer_wid} = ${mn_hr_soldto_customer_dim.customer_wid};;
  }

  join: mn_hr_billto_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Bill To Customer"
    #fields: [full_name]
    sql_on: ${mn_discount_bridge_fact.bill_to_customer_wid} = ${mn_hr_billto_customer_dim.customer_wid};;
  }

  join: mn_hr_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Product"
    #fields: [full_name]
    sql_on: ${mn_discount_bridge_fact.product_wid} = ${mn_hr_product_dim.product_wid};;
  }

#   join: mn_rl_rebate_type_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_rebate_type_dim
#     view_label: "Rebate Type"
#     sql_on: ${mn_discount_bridge_fact.rebate_type_wid} = ${mn_rl_rebate_type_dim.rebate_type_wid};;
#   }

  # join: mn_rl_customer_dim {
  #   type: left_outer
  #   relationship: many_to_one
  #   from: mn_customer_dim
  #   view_label: "Rebate Payee"
  #   sql_on: ${mn_discount_bridge_fact.payee_wid} = ${mn_rl_customer_dim.customer_wid};;
  # }
}

explore: rebate_lines_base {
  from: mn_discount_bridge_fact
  view_name: mn_discount_bridge_fact
  view_label: "Rebate Lines"
  hidden: yes
  extension: required
  sql_always_where: ${mn_discount_bridge_fact.paid_amt} <> 0 ;;

  join: mn_rl_hipto_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Ship To Customer"
    #fields: [full_name]
    sql_on: ${mn_discount_bridge_fact.ship_to_customer_wid} = ${mn_rl_hipto_customer_dim.customer_wid};;
  }

  join: rl_hip_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Ship To Customer"
    fields: [id_num, id_type]
    sql_on: ${mn_discount_bridge_fact.sold_to_customer_wid}=${rl_hip_to_customer_ids.customer_wid};;
  }

  join: mn_rl_soldto_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Sold To Customer"
    #fields: [full_name]
    sql_on: ${mn_discount_bridge_fact.sold_to_customer_wid} = ${mn_rl_soldto_customer_dim.customer_wid};;
  }

  join: rl_sold_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Sold To Customer"
    fields: [id_num, id_type]
    sql_on: ${mn_discount_bridge_fact.sold_to_customer_wid}=${rl_sold_to_customer_ids.customer_wid};;
  }

  join: mn_rl_product_eff_attr_fact {
    type: left_outer
    relationship: many_to_many
    from: mn_product_eff_attr_fact_ext
    view_label: "Rebate Benefit Product"
    fields: [mn_rl_product_eff_attr_fact.Product_EDA_Attributes*]
    sql_on: ${mn_discount_bridge_fact.product_wid} = ${mn_rl_product_eff_attr_fact.product_wid}
      AND ( ${mn_discount_bridge_fact.invoice_raw} BETWEEN ${mn_rl_product_eff_attr_fact.eff_start_raw} AND ${mn_rl_product_eff_attr_fact.eff_end_raw});;
  }

  join: mn_rl_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Benefit Product"
    sql_on: ${mn_discount_bridge_fact.product_wid} = ${mn_rl_product_dim.product_wid};;
  }

  # join: mn_rl_rebate_type_dim {
  #   type: left_outer
  #   relationship: many_to_one
  #   from: mn_rebate_type_dim
  #   view_label: "Rebate Lines Rebate"
  #   sql_on: ${mn_discount_bridge_fact.rebate_type_wid} = ${mn_rl_rebate_type_dim.rebate_type_wid};;
  # }

  join: mn_rl_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Rebate Lines Payee"
    sql_on: ${mn_discount_bridge_fact.payee_wid} = ${mn_rl_customer_dim.customer_wid};;
  }

}

explore: compl_commitment_fact_base {
  label: "Compliance Commitments"
  from: mn_cmpl_commit_fact
  view_name: mn_cmpl_commit_fact
  view_label: "Compliance Commitment Fact"
  hidden: yes
  extension: required


}

explore: mn_payer_rebate_payment_fact_base {

  from:  mn_rebate_payment_fact
  view_name: mn_rebate_payment_fact
  hidden: yes
  extension: required

  join: mn_rbt_analyst_user_dim {
    from: mn_user_dim
    view_label: "Rebate Analyst"
    type: left_outer
    relationship: many_to_one
    sql_on: ${mn_rebate_payment_fact.analyst_user_wid} = ${mn_rbt_analyst_user_dim.user_wid} ;;
  }

  join: mn_rbt_slsrep_user_dim {
    from: mn_user_dim
    view_label: "Rebate Sales Rep"
    type: left_outer
    relationship: many_to_one
    sql_on: ${mn_rebate_payment_fact.salesrep_user_wid} = ${mn_rbt_slsrep_user_dim.user_wid} ;;
  }

#   join: mn_payment_package_dim {
#     from: mn_payment_package_dim
#     type: left_outer
#     relationship: many_to_one
#     view_label: "Rebate Payment Package"
#     sql_on: ${mn_rebate_payment_fact.pymt_pkg_wid} = ${mn_payment_package_dim.pymt_pkg_wid} ;;
#   }

}

# Custom Value Formats
named_value_format: amt_3 {
  value_format: "$#,##0.000"
}

explore: mn_price_list_dim_base {
  label: "Price List"
  view_label: "Price List"
  from:  mn_price_list_dim
  view_name: mn_price_list_dim
  extension: required

  join: mn_pl_price_list_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_price_list_fact
    view_label: "Product Prices"
    sql_on: ${mn_pl_price_list_fact.price_list_wid} = ${mn_price_list_dim.price_list_wid};;
  }

  join: mn_price_list_prod_hrc_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Product Hierarchy"
    #fields: []
    sql_on: ${mn_price_list_prod_hrc_dim.level0_product_wid} = ${mn_pl_price_list_fact.product_wid};;
  }

  join: mn_price_list_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label:"Products"
    #fields: [product_name, product_num]
    sql_on: ${mn_price_list_prod_dim.product_wid} = ${mn_pl_price_list_fact.product_wid};;
  }
}
