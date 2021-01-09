include: "base_ls_database_connection_ls_winter18c.model.lkml"
include: "*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project
include: "base_ls_explores_ls_winter18c.model.lkml"

label: "Provider"

explore: provider_contracts {

  label: "Provider Contracts"

  extends: [mn_contract_header_dim_secure_base,
            mn_contract_header_dim_adhoc_base,mn_combined_pg_rp_dim_base]

  from:  mn_contract_header_dim
  view_name: mn_contract_header_dim

  fields: [ALL_FIELDS*,-mn_pg_prc_adhoc_fact.provider_ctrt_exclude_set*]

  hidden: no

  sql_always_where:  ${mn_contract_header_dim.latest_flag} = 'Y' and ${mn_ctrt_type_dim.ctrt_type_name} IN ('FSS','IDN','Independent','Institutional','Master','PHS','Purchase Based')   ;;

# Data security
  access_filter: {
    field: mn_user_access_ctrt_map.access_user_id
    user_attribute: access_user_id
  }

  join: mn_combined_pg_rp_dim {
    type: left_outer
    view_label: "Pricing Program"
    relationship: one_to_many
    from: mn_combined_pg_rp_dim
    sql_on: ${mn_contract_header_dim.src_sys_contract_id} = ${mn_combined_pg_rp_dim.src_sys_pk_id}
             and ${mn_combined_pg_rp_dim.latest_flag} = 'Y' ;;
  }

  join: mn_comb_pg_rp_comp_dim {
    type: left_outer
    relationship: one_to_many
    # from: mn_pg_qual_ben_unflat
    from: mn_comb_pg_rp_comp_dim
    view_label: "Pricing Program Tier Basis"
    sql_on: ${mn_combined_pg_rp_dim.program_comb_key} = ${mn_comb_pg_rp_comp_dim.program_key}
      and ${mn_combined_pg_rp_dim.program_type} = ${mn_comb_pg_rp_comp_dim.program_type} ;;
  }

  join: mn_ctrt_elig_customers_map {
    type: left_outer
    view_label: "Contract Eligible Customer"
    relationship: one_to_many
    from: mn_ctrt_elig_customers_map
    sql_on: ${mn_comb_pg_rp_comp_dim.component_key} = ${mn_ctrt_elig_customers_map.component_key}
            and ${mn_comb_pg_rp_comp_dim.elig_component_type} = ${mn_ctrt_elig_customers_map.elig_component_type} ;;
  }

  ############# Overriding price list dim join from mn_combined_product_group_dim_base to get only specific columns#####################################
  join: mn_cpg_price_list_dim {
    from: mn_price_list_dim
    fields: [mn_cpg_price_list_dim.providerpricelistdim_set*]
  }

  join: mn_cpl_price_list_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_price_list_fact
    view_label: "Contracted Price List Product"
    fields: [mn_cpl_price_list_fact.providerpricelistfact_set*]
    sql_on: ${mn_cpl_price_list_fact.price_list_wid} = ${mn_cpg_price_list_dim.price_list_wid};;
  }


  join: mn_price_list_prod_hrc_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Contracted Price List Product Hierarchy"
    sql_on: ${mn_price_list_prod_hrc_dim.level0_product_wid} = ${mn_cpl_price_list_fact.product_wid};;
  }


  join: mn_price_list_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label:"Contracted Price List Product"
    fields: [product_name, product_num]
    sql_on: ${mn_price_list_prod_dim.product_wid} = ${mn_cpl_price_list_fact.product_wid};;
  }



  join: mn_ctrt_wholesaler_map {
    type: left_outer
    view_label: "Contract Trading Partner"
    relationship: many_to_one
    from: mn_ctrt_wholesaler_map
    fields: [eff_start_date, eff_end_date]
    sql_on: ${mn_contract_header_dim.contract_wid} = ${mn_ctrt_wholesaler_map.contract_wid};;
  }

  join: mn_ctrt_elig_cot_map {
    type: left_outer
    view_label: "Contract Eligible Class Of Trade"
    relationship: one_to_many
    from: mn_ctrt_elig_cot_map
    sql_on: ${mn_contract_header_dim.contract_wid} = ${mn_ctrt_elig_cot_map.contract_wid};;
  }

  join: mn_ctrt_elig_cot_dim {
    type: left_outer
    view_label: "Contract Eligible Class Of Trade"
    relationship: many_to_one
    from: mn_cot_dim
    sql_on: ${mn_ctrt_elig_cot_dim.cot_wid} = ${mn_ctrt_elig_cot_map.cot_wid};;
  }


  join: mn_ctrt_wholesaler_dim {
    type: left_outer
    relationship: many_to_one
    view_label: "Contract Trading Partner"
    from: mn_customer_dim
    sql_on: ${mn_ctrt_wholesaler_map.customer_wid} = ${mn_ctrt_wholesaler_dim.customer_wid};;
  }

  join: mn_contract_attr_fact {
    type: left_outer
    view_label: "Contract"
    relationship: one_to_many
    from: mn_contract_attr_fact
    fields: [eff_start_date, eff_end_date, attr_name, attr_value]
    sql_on: ${mn_contract_header_dim.contract_wid} = ${mn_contract_attr_fact.contract_wid};;
  }

  join: mn_ctrt_elig_customer_dim {
    type: left_outer
    relationship: many_to_one
    view_label: "Contract Eligible Customer"
    from: mn_customer_dim
    sql_on: ${mn_ctrt_elig_customers_map.elig_customer_wid} = ${mn_ctrt_elig_customer_dim.customer_wid};;
  }

  join: mn_ctrt_commit_customer_dim {
    type: left_outer
    relationship: many_to_one
    view_label: "Contract Eligible Customer"
    from: mn_customer_commit_dim_ext
    fields: [committed_customer_name, committed_customer_num]
    sql_on: ${mn_ctrt_elig_customers_map.commit_customer_wid} = ${mn_ctrt_commit_customer_dim.customer_wid};;
  }


  join: mn_pg_prc_adhoc_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_pg_product_pricing_fact_adhoc_ext
    view_label: "Pricing Program Products and Pricing"
    sql_on: ${mn_pg_prc_adhoc_fact.pg_wid} = ${mn_combined_pg_rp_dim.pg_wid}
            and ${mn_pg_prc_adhoc_fact.product_wid} = ${mn_product_pg_exp_dim.product_wid}
            and ${mn_pg_prc_adhoc_fact.tier_idx}=1;;
  }

  join: mn_pg_prod_adhoc_map_exp {
    type: left_outer
    relationship: one_to_many
    from: mn_pg_prod_adhoc_map_exp
    view_label: "Pricing Program Product"
    sql_on: ${mn_pg_prod_adhoc_map_exp.pg_wid} = ${mn_combined_pg_rp_dim.pg_wid} ;;
  }

  join: mn_pg_prod_adhoc_map_incl {
    type: left_outer
    relationship: many_to_one
    from: mn_pg_prod_adhoc_map_incl
    view_label: "Pricing Program Product"
    sql_on: ${mn_pg_prod_adhoc_map_exp.combined_source_system_key} = ${mn_pg_prod_adhoc_map_incl.src_sys_struct_li_id} ;;
  }

  join: mn_pg_mb_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_market_basket_dim
    view_label: "Pricing Program Product"
    fields: [mn_pg_mb_dim.market_basket_name,mn_pg_mb_dim.market_basket_number]
    sql_on: ${mn_pg_prod_adhoc_map_exp.basket_wid} = ${mn_pg_mb_dim.market_basket_wid};;
  }

  join: mn_product_pg_exp_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim_adhoc_ext
    view_label: "Pricing Program Product"
    fields: [product_name, product_num, product_type_adhoc]
    sql_on: ${mn_pg_prod_adhoc_map_exp.level0_prod_wid} = ${mn_product_pg_exp_dim.product_wid};;
  }

  join: mn_pg_prod_hrc {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label:"Pricing Program Product Hierarchy"
    sql_on: ${mn_pg_prod_hrc.level0_product_wid} = ${mn_pg_prod_adhoc_map_exp.level0_prod_wid} ;;
  }


  join: mn_product_attr_adhoc_inc {
    type: left_outer
    relationship: many_to_many
    from: mn_product_attr_adhoc_ext
    view_label: "Pricing Program Product"
    fields: [pg_inc_attr_name, pg_inc_attr_value, pg_inc_eff_start_date, pg_inc_eff_end_date]
    sql_on: ${mn_pg_prod_adhoc_map_incl.pg_included_cat_prod_wid} = ${mn_product_attr_adhoc_inc.product_wid};;
  }



  join: mn_product_attr_adhoc_exp {
    type: left_outer
    relationship: many_to_many
    from: mn_product_attr_adhoc_ext
    view_label: "Pricing Program Product"
    fields: [pg_exp_attr_name, pg_exp_attr_value, pg_exp_eff_start_date, pg_exp_eff_end_date]
    sql_on: ${mn_pg_prod_adhoc_map_exp.level0_prod_wid} = ${mn_product_attr_adhoc_exp.product_wid};;
  }



  join: mn_pg_prd_prc_entlmt_fact {
    type: left_outer
    relationship: many_to_one
    from: mn_pg_prd_prc_entlmt_fact
    view_label: "Pricing Program Products and Pricing"
    sql_on: ${mn_pg_prd_prc_entlmt_fact.src_sys_struct_li_id} = ${mn_pg_prc_adhoc_fact.src_sys_struct_li_id};;
  }


  join: mn_pg_prod_attr_sn_fact {
    type: left_outer
    relationship: many_to_one
    from: mn_pg_prod_attr_sn_fact
    view_label: "Pricing Program Products and Pricing"
    sql_on: ${mn_pg_prod_attr_sn_fact.src_sys_struct_li_id} = ${mn_pg_prc_adhoc_fact.src_sys_struct_li_id};;
  }


  join: mn_pg_prod_attr_po_fact {
    type: left_outer
    relationship: many_to_one
    from: mn_pg_prod_attr_po_fact
    view_label: "Pricing Program Products and Pricing"
    sql_on: ${mn_pg_prod_attr_po_fact.src_sys_struct_li_id} = ${mn_pg_prc_adhoc_fact.src_sys_struct_li_id};;
  }

  join: mn_pg_pg_prc_fact_flat {
    type: left_outer
    relationship: many_to_one
    from: mn_pg_prc_fact_flat
    view_label: "Pricing Program Products and Pricing"
    sql_on: ${mn_pg_prc_adhoc_fact.pg_wid} = ${mn_pg_pg_prc_fact_flat.pg_wid}
          AND ${mn_pg_prc_adhoc_fact.product_wid} = ${mn_pg_pg_prc_fact_flat.product_wid}
          AND ${mn_pg_prc_adhoc_fact.start_raw} = ${mn_pg_pg_prc_fact_flat.start_raw};;
  }


  join: mn_big_award_flat_fact {
    type: left_outer
    relationship: many_to_one
    from: mn_bid_award_flat_fact
    view_label: "Pricing Program Products and Pricing"
    sql_on: ${mn_pg_prc_adhoc_fact.pg_wid} = ${mn_big_award_flat_fact.pg_wid};;
  }


  join: mn_product_prc_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Pricing Program Products and Pricing"
    fields: [product_name, product_num]
    sql_on: ${mn_pg_prc_adhoc_fact.product_wid} = ${mn_product_prc_dim.product_wid};;
  }

  join: mn_cc_third_party_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim_reuse
    view_label: "Pricing Program Products and Pricing"
    fields: [mn_cc_third_party_dim.third_party_name_set*]
    sql_on: ${mn_combined_pg_rp_dim.third_party_wid} = ${mn_cc_third_party_dim.customer_wid} ;;
  }

  join: mn_rebate_program_payee_dim {
    type: left_outer
    relationship: many_to_one
    view_label: "Rebate Program Payee"
    from: mn_customer_dim
    fields: [customer_name, customer_num, member_info_type]
    sql_on: ${mn_rebate_program_payee_dim.customer_wid} = ${mn_combined_pg_rp_dim.payee_customer_wid};;
  }

  join: mn_rbt_prog_ben_prod_map {
    type: left_outer
    view_label: "Rebate Program Benefit Product"
    relationship: one_to_many
    from: mn_rbt_prog_ben_prod_map_adhoc_ext
    sql_on: ${mn_rbt_prog_ben_prod_map.program_ben_wid} = ${mn_comb_pg_rp_comp_dim.program_qual_ben_wid}
      and ${mn_comb_pg_rp_comp_dim.is_qual_comp_flag} = 'N';;
  }

  join: mn_rbt_prog_ben_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Benefit Product"
    fields: []
    sql_on: ${mn_rbt_prog_ben_prod_dim.product_wid} = ${mn_rbt_prog_ben_prod_map.product_wid};;
  }

  join: mn_rbt_prog_ben_prod_hrc {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Benefit Product Hierarchy"
    sql_on: ${mn_rbt_prog_ben_prod_hrc.level0_product_wid} = ${mn_rbt_prog_ben_prod_map.product_wid};;
  }

  join: mn_rbt_prog_pg_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Rebate Program Benefit Product"
    fields: []
    sql_on: ${mn_rbt_prog_pg_dim.src_sys_pg_id} = ${mn_rbt_prog_ben_prod_map.source_pg_id}
      AND ${mn_rbt_prog_pg_dim.latest_flag}='Y';;
  }

  join: mn_rbt_prog_qual_prod_map {
    type: left_outer
    view_label: "Rebate Program Qualification Product"
    relationship: one_to_many
    from: mn_rbt_prog_qual_prod_map_adhoc_ext
    sql_on: ${mn_rbt_prog_qual_prod_map.program_qual_wid} = ${mn_comb_pg_rp_comp_dim.program_qual_ben_wid}
            and ${mn_comb_pg_rp_comp_dim.is_qual_comp_flag} = 'Y'
            and ${mn_rbt_prog_qual_prod_map.product_wid} IS NOT NULL;;
  }

  join: mn_rbt_prog_qual_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Qualification Product"
    fields: []
    sql_on: ${mn_rbt_prog_qual_prod_dim.product_wid} = ${mn_rbt_prog_qual_prod_map.product_wid};;
  }

  join: mn_rbt_prog_qual_prod_hrc {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Qualification Product Hierarchy"
    sql_on: ${mn_rbt_prog_qual_prod_hrc.level0_product_wid} = ${mn_rbt_prog_qual_prod_map.product_wid};;
  }

  join: mn_rbt_prog_qual_pg_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Rebate Program Qualification Product"
    fields: []
    sql_on: ${mn_rbt_prog_qual_pg_dim.src_sys_pg_id} = ${mn_rbt_prog_qual_prod_map.source_pg_id}
      AND ${mn_rbt_prog_qual_pg_dim.latest_flag}='Y';;
  }

  join: mn_rbt_qual_mb_prod_map {
    type: left_outer
    view_label: "Rebate Program Qualification MB Product"
    relationship: one_to_many
    from: mn_rbt_qual_mb_prod_map_ext
    sql_on: ${mn_rbt_qual_mb_prod_map.program_qual_wid} = ${mn_comb_pg_rp_comp_dim.program_qual_ben_wid}
      and ${mn_comb_pg_rp_comp_dim.is_qual_comp_flag} = 'Y' ;;
  }

  join: mn_rbt_qual_mb_prod_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Rebate Program Qualification MB Product"
    fields: []
    sql_on: ${mn_rbt_qual_mb_prod_dim.product_wid} = ${mn_rbt_qual_mb_prod_map.product_wid};;
  }

  join: mn_rbt_qual_mb_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_market_basket_dim
    view_label: "Rebate Program Qualification MB Product"
    fields: [market_basket_name, market_basket_number]
    sql_on: ${mn_rbt_qual_mb_prod_map.basket_wid} = ${mn_rbt_qual_mb_dim.market_basket_wid};;
  }

  join: mn_rbt_qual_mb_prod_hrc {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver
    view_label: "Rebate Program Qualification MB Product Hierarchy"
    sql_on: ${mn_rbt_qual_mb_prod_hrc.level0_product_wid} = ${mn_rbt_qual_mb_prod_map.product_wid};;
  }

  join: mn_rbt_qual_mb_pg_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Rebate Program Qualification MB Product"
    fields: []
    sql_on: ${mn_rbt_qual_mb_pg_dim.src_sys_pg_id} = ${mn_rbt_qual_mb_prod_map.source_pg_id}
      AND ${mn_rbt_qual_mb_pg_dim.latest_flag}='Y';;
  }

  ##These just to relabel
  join: mn_contract_author_dim {
    from: mn_user_dim
    view_label: "Contract Author"
  }

  join: mn_additional_delegate_dim {
    from: mn_user_dim
    view_label: "Contract Additional Delegate"
  }

  join: mn_contract_srep_dim {
    from: mn_user_dim
    view_label: "Contract Sales Rep"
  }

  join: mn_ctrt_status_dim {
    from: mn_ctrt_status_dim
    view_label: "Contract"
  }

  join: mn_ctrt_domain_dim {
    from: mn_ctrt_domain_dim
    view_label: "Contract"
  }

  join: mn_ctrt_type_dim {
    from: mn_ctrt_type_dim
    view_label: "Contract"
  }

  join: mn_ctrt_sub_type_dim {
    from: mn_ctrt_sub_type_dim
    view_label: "Contract"
  }

  join: mn_customer_owner_dim {
    from: mn_customer_dim
    view_label: "Contracted Customer"
  }

  join: mn_ch_org_dim {
    from: mn_org_dim
    view_label: "Contract"
  }

  join: mn_ch_cust_cot_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_cot_dim
    view_label: "Contracted Customer COT"
    sql_on: ${mn_contract_header_dim.owner_wid} = ${mn_ch_cust_cot_dim.customer_wid}
            and ${mn_ch_cust_cot_dim.eff_start_raw} <= ${mn_contract_header_dim.eff_end_raw}
            and ${mn_ch_cust_cot_dim.eff_end_raw} >= ${mn_contract_header_dim.eff_start_raw};;
  }

  join: mn_ch_cot_dim {
    from: mn_cot_dim
    view_label: "Contracted Customer COT"
  }

  join: mn_parent_contract_header_dim {
    from: mn_contract_header_dim_reuse
    view_label: "Contract"
  }

  join: mn_distrib_mthd_dim {
    from: mn_distrib_mthd_dim
    view_label: "Contract"
  }
}

explore: provider_historical_rebates {
  label: "Provider Historical Rebates"
  from: mn_discount_bridge_fact
  view_name: mn_discount_bridge_fact
  extends: [historical_rebates_base]
  hidden: no

  sql_always_where: ${mn_discount_bridge_fact.is_historical_flag}='Y'
                    AND (${mn_discount_bridge_fact.ds_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.ids_line_ref_num} IS NOT NULL
                          OR ${mn_discount_bridge_fact.cs_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.rebate_module_type} = 'INCENTV') ;;

}

explore: provider_combined{
  label: "Provider Combined"
  extends: [provider_sales
            ,mn_rbt_ctrt_header_dim_base
            ,mn_combined_rebate_program_dim_base
            ,mn_payment_package_dim_base
            ,mn_rebate_payment_fact_base
            ]

  fields: [ALL_FIELDS*,-mn_combined_sale_fact.custom_measure_set1*,-mn_combined_sale_fact.custom_measure_set2*,
    -mn_combined_sale_fact.access_user_wid,-mn_combined_sale_fact.access_user_name]

  # fields: [ALL_FIELDS*,-mn_rbt_prg_ben_flat_dim.provider_ben_exclude_set*,-mn_combined_sale_fact.custom_measure_set1*,
  #   -mn_combined_sale_fact.access_user_wid,-mn_combined_sale_fact.access_user_name,
  #   -mn_rbt_ctrt_header_dim.ctrt_num_provider,-mn_contract_header_dim.ctrt_num_payer]

  hidden: no

  # sql_always_where: ;;
  from:  mn_combined_sale_fact
  view_name: mn_combined_sale_fact

  join: mn_discount_bridge_fact {
    type: left_outer
    view_label: "Rebate Lines"
    relationship: one_to_many
    from: mn_discount_bridge_fact
    sql_on: ${mn_discount_bridge_fact.orig_ref_num} =  ${mn_combined_sale_fact.line_ref_num} AND ${mn_discount_bridge_fact.paid_amt} <> 0
            AND ${mn_discount_bridge_fact.is_historical_flag}='N'
            AND (${mn_discount_bridge_fact.ds_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.ids_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.cs_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.rebate_module_type} = 'INCENTV') ;;
  }


  join: mn_rebate_payment_fact {
    type: left_outer
    view_label: "Rebate Payment"
    relationship: many_to_one
    from: mn_rebate_payment_fact
    sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${mn_discount_bridge_fact.rebate_pmt_wid};;
  }

  join: mn_combined_rebate_program_dim {
    type: left_outer
    view_label: "Rebate Program"
    relationship: many_to_one
    from: mn_combined_rebate_program_dim
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rebate_payment_fact.rebate_program_wid}
      ;;
  }

  join: mn_payment_package_dim {
    type: left_outer
    view_label: "Payment Package"
    relationship: many_to_one
    from: mn_payment_package_dim
    sql_on: ${mn_rebate_payment_fact.pymt_pkg_wid} = ${mn_payment_package_dim.pymt_pkg_wid};;
  }

#   join: mn_rbt_prg_ben_flat_dim {
#     type: left_outer
#     view_label: "Rebate Program Benefit"
#     relationship: many_to_one
#     from: mn_rbt_prg_ben_flat_dim
# #     fields: [-mn_rbt_prg_ben_flat_dim.provider_ben_exclude_set*]
#     sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prg_ben_flat_dim.program_wid};;
#   }

  join: mn_erp_payment_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_erp_payment_fact
    view_label: "ERP Payment"
    sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${mn_erp_payment_fact.rebate_pmt_wid};;
  }

  join: mn_rbt_ctrt_header_dim {
    from: mn_contract_header_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Rebate Contract"
    #fields: [contract_number]
    sql_on: ${mn_rbt_ctrt_header_dim.contract_wid} = ${mn_combined_rebate_program_dim.contract_wid};;
  }

#   Relabelling the existing labels
  join: mn_rbt_cust_owner_dim {
    from: mn_customer_dim
    view_label: "Rebate Contracted Customer"
  }
#   Complete relabe

}

explore: provider_rebates{
  label: "Provider Rebates"
  from: mn_contract_header_dim
  view_name: mn_rbt_ctrt_header_dim
  view_label: "Rebate Contract"
  extends: [mn_rbt_ctrt_header_dim_base,
              mn_combined_rebate_program_dim_base,
              mn_payment_package_dim_base,
              mn_rebate_payment_fact_base,
              rebate_lines_base]

  fields: [ALL_FIELDS*,-mn_rbt_prg_ben_flat_dim.provider_ben_exclude_set*]

  # fields: [ALL_FIELDS*,-mn_rbt_prg_ben_flat_dim.provider_ben_exclude_set*,-mn_rbt_ctrt_header_dim.ctrt_num_provider]

  hidden: no

  sql_always_where: ${mn_rbt_ctrt_header_dim.latest_flag} = 'Y' and ${mn_rbt_ctrt_type_dim.ctrt_type_name} IN ('FSS','IDN','Independent','Institutional','Master','PHS','Purchase Based') ;;
  always_join: [mn_rebate_payment_fact]

  join: mn_combined_rebate_program_dim {
    type: inner
    view_label: "Rebate Program"
    relationship: one_to_many
    from: mn_combined_rebate_program_dim
    sql_on: ${mn_rbt_ctrt_header_dim.contract_wid} = ${mn_combined_rebate_program_dim.contract_wid}
    ;;
  }

  join: mn_rebate_payment_fact {
    type: inner
    view_label: "Rebate Payment"
    relationship: one_to_many
    from: mn_rebate_payment_fact
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rebate_payment_fact.rebate_program_wid};;
  }

  join: mn_payment_package_dim {
    type: left_outer
    view_label: "Payment Package"
    relationship: many_to_one
    from: mn_payment_package_dim
    sql_on: ${mn_rebate_payment_fact.pymt_pkg_wid} = ${mn_payment_package_dim.pymt_pkg_wid};;
  }

  join: mn_discount_bridge_fact {
    type: left_outer
    view_label: "Rebate Lines"
    relationship: one_to_many
    from: mn_discount_bridge_fact
    sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${mn_discount_bridge_fact.rebate_pmt_wid}
            AND ${mn_discount_bridge_fact.is_historical_flag}='N'
            AND (${mn_discount_bridge_fact.ds_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.ids_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.cs_line_ref_num} IS NOT NULL OR ${mn_discount_bridge_fact.rebate_module_type} = 'INCENTV')
            AND ${mn_discount_bridge_fact.paid_amt} <> 0;;
  }

  join: mn_rbt_prg_ben_flat_dim {
    type: left_outer
    view_label: "Rebate Program Benefit"
    relationship: one_to_many
    from: mn_rbt_prg_ben_flat_dim
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${mn_rbt_prg_ben_flat_dim.program_wid};;
  }

  join: mn_erp_payment_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_erp_payment_fact
    view_label: "ERP Payment"
    sql_on: ${mn_rebate_payment_fact.rebate_pmt_wid} = ${mn_erp_payment_fact.rebate_pmt_wid};;
  }

  ### This Part is to modify views retrieved through extending

#   join: mn_rl_product_dim {
#     view_label: "Product"
#   }
#
#   join: rpf_rebate_payment_payee {
#     view_label: "Payee"
#   }
#
#   join: mn_rl_shipto_customer_dim {
#     view_label: "Benefit Line Ship To Customer"
#   }
#
#   join: rl_ship_to_customer_ids {
#     view_label: "Benefit Line Ship To Customer"
#   }
#
#   join: mn_rl_soldto_customer_dim {
#     view_label: "Benefit Line Sold To Customer"
#   }
#
#   join: rl_sold_to_customer_ids {
#     view_label: "Benefit Line Sold To Customer"
#   }
#
#   join: mn_rl_rebate_type_dim {
#     view_label: "Benefit Line Rebate Type"
#   }
#
#   join: mn_rl_customer_dim {
#     view_label: "Benefit Line Payee"
#   }
#
#   join: mn_ctrt_status_dim {
#     view_label: "Rebate Contract"
#   }
#
#   join: mn_ctrt_domain_dim {
#     view_label: "Rebate Contract"
#   }
#
#   join: mn_ctrt_type_dim {
#     view_label: "Rebate Contract"
#   }
#
#   join: mn_ctrt_sub_type_dim {
#     view_label: "Rebate Contract"
#   }
#
#   join: mn_contract_author_dim {
#     view_label: "Rebate Contract Author"
#   }
#
#   join: mn_additional_delegate_dim {
#     view_label: "Rebate Contract Additional Delegate"
#   }
#
#   join: mn_contract_srep_dim {
#     view_label: "Rebate Contract Sales Rep"
#   }
#
#   join: mn_customer_owner_dim {
#     fields: []
#   }
#
#   join: mn_ch_org_dim {
#       fields: []
#   }
#
#   join: mn_ch_cust_cot_dim {
#     fields: []
#   }
#
#   join: mn_ch_cot_dim {
#     fields: []
#   }
#
#   join: mn_parent_contract_header_dim {
#     view_label: "Rebate Contract Parent"
#   }
#
#   join: mn_distrib_mthd_dim {
#     view_label: "Rebate Contract Distribution Method"
#   }

#   Relabelling the existing labels
  join: mn_rbt_cust_owner_dim {
    from: mn_customer_dim
    view_label: "Rebate Contracted Customer"
  }
#   Complete relabe
}

explore: provider_estimated_rebates{
  label: "Provider Estimated Rebates"
  extends: [estimated_rebates_base]

  # fields: [ALL_FIELDS*,-mn_rbt_ctrt_header_dim.ctrt_num_provider]

  hidden: no

  sql_always_where: ${mn_est_rebate_payment_fact.estimate_pmt_type} = 'Institutional' ;;
  # AND ${mn_rbt_ctrt_type_dim.ctrt_type_name} IN ('FSS','IDN','Independent','Institutional','Master','PHS','Purchase Based');;

#   join: mn_ctrt_type_dim {
#     view_label: "Contract"
#     sql_on: ${mn_ctrt_type_dim.ctrt_type_name} IN ('FSS','IDN','Independent','Institutional','Master','PHS','Purchase Based');;
#   }

  #This part is for renaming or limitting fields
#   join: mn_est_rebate_pmt_prod_map {
#     view_label: "Estimated Payments Product Map"
#   }

#   join: mn_ctrt_status_dim {
#     view_label: "Rebate Contract"
#   }
#
#   join: mn_ctrt_domain_dim {
#     view_label: "Rebate Contract"
#   }
#
#
#   join: mn_ctrt_sub_type_dim {
#     view_label: "Rebate Contract"
#   }
#
#   join: mn_contract_author_dim {
#     view_label: "Rebate Contract Author"
#   }
#
#   join: mn_additional_delegate_dim {
#     view_label: "Rebate Contract Additional Delegate"
#   }
#
#   join: mn_contract_srep_dim {
#     view_label: "Rebate Contract Sales Rep"
#   }
#
#   join: mn_customer_owner_dim {
#     fields: []
#   }
#
#   join: mn_ch_org_dim {
#     fields: []
#   }
#
#   join: mn_ch_cust_cot_dim {
#     fields: []
#   }
#
#   join: mn_ch_cot_dim {
#     fields: []
#   }
#
#   join: mn_parent_contract_header_dim {
#     view_label: "Rebate Contract Parent"
#   }
#
#   join: mn_distrib_mthd_dim {
#     view_label: "Rebate Contract Distribution Method"
#   }
#
#   join: mn_er_customer_dim {
#     view_label: "Payee"
#   }
#
#   join: mn_er_product_dim {
#     view_label: "Product"
#   }
#
#   join: mn_payment_package_dim {
#     view_label: "Payment Package"
#   }
#
#
#  join: mn_erp_payment_fact {
#    view_label: "ERP Payment"
#  }
  join: mn_rbt_cust_owner_dim {
    from: mn_customer_dim
    view_label: "Rebate Contracted Customer"
  }

}

explore: provider_sales {
  label: "Provider Sales"
  extends: [mn_contract_header_dim_base, mn_combined_product_group_dim_base]
  from:  mn_combined_sale_fact
  view_name: mn_combined_sale_fact

  fields: [ALL_FIELDS*,-mn_combined_sale_fact.custom_measure_set1*,-mn_combined_sale_fact.custom_measure_set2*, -mn_combined_sale_fact.access_user_wid,
    -mn_combined_sale_fact.access_user_name]

  # fields: [ALL_FIELDS*,-mn_combined_sale_fact.custom_measure_set1*,-mn_combined_sale_fact.access_user_wid,
  #   -mn_combined_sale_fact.access_user_name,-mn_contract_header_dim.ctrt_num_payer]

  hidden: no

  view_label: "Sales"

  always_filter: {
    filters: {
      field: mn_to_uom_dim.to_uom
    }
  }

#****************************** Data security

  access_filter: {
    field: mn_user_access_sale_map.access_user_id
    user_attribute: access_user_id
  }

  # User Org join
  join: mn_user_access_sale_map {
    type: inner
    relationship: many_to_one
    from: mn_user_org_map
#     view_label: "User Access"
    fields: [access_user_id]
    sql_on: ${mn_combined_sale_fact.org_wid} = ${mn_user_access_sale_map.org_wid};;
  }

  #******************************* Data Security End

  join: sl_contracted_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Pricing Contract Customer"
    sql_on: ${mn_combined_sale_fact.customer_wid} = ${sl_contracted_customer.customer_wid};;
  }

  join: sl_contracted_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Pricing Contract Customer"
    sql_on: ${mn_combined_sale_fact.customer_wid} = ${sl_contracted_customer_ids.customer_wid};;
  }

  join: sl_wholesaler {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Wholesaler"
    sql_on: ${mn_combined_sale_fact.distr_wid} = ${sl_wholesaler.customer_wid}
      AND ${sl_wholesaler.member_info_type} =  'Wholesaler'  ;;
  }

  join: sl_wholesaler_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    sql_on: ${mn_combined_sale_fact.distr_wid}=${sl_wholesaler_customer_ids.customer_wid}
      AND ${sl_wholesaler.member_info_type} =  'Wholesaler'  ;;
    view_label: "Wholesaler"
    fields: [id_num, id_type]
  }

  join: sl_parent_wholesaler {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Parent Wholesaler"
    sql_on: ${mn_combined_sale_fact.parent_distr_wid} = ${sl_parent_wholesaler.customer_wid}
      AND ${sl_parent_wholesaler.member_info_type} =  'Wholesaler'  ;;
  }

  join: sl_sold_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Sold to Customer"
    sql_on: ${mn_combined_sale_fact.sold_to_customer_wid} = ${sl_sold_to_customer.customer_wid};;
  }

  join: sl_sold_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Sold to Customer"
    fields: [id_num, id_type]
    sql_on: ${mn_combined_sale_fact.sold_to_customer_wid}=${sl_sold_to_customer_ids.customer_wid};;
  }

  join: sl_hip_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Ship to Customer"
    sql_on: ${mn_combined_sale_fact.ship_to_customer_wid} = ${sl_hip_to_customer.customer_wid};;
  }

  join: sl_hip_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Ship to Customer"
    fields: [id_num, id_type]
    sql_on: ${mn_combined_sale_fact.ship_to_customer_wid}=${sl_hip_to_customer_ids.customer_wid};;
  }

  join: sl_bill_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Bill to Customer"
    sql_on: ${mn_combined_sale_fact.bill_to_customer_wid} = ${sl_bill_to_customer.customer_wid};;
  }

  join: sl_bill_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Bill to Customer"
    fields: [id_num, id_type]
    sql_on: ${mn_combined_sale_fact.bill_to_customer_wid}=${sl_bill_to_customer_ids.customer_wid};;
  }

  join: mn_contract_header_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_contract_header_dim
    view_label: "Pricing Contract"
    sql_on: ${mn_combined_sale_fact.contract_wid} = ${mn_contract_header_dim.contract_wid};;
  }

  join: sl_mn_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Sold Product"
    sql_on: ${mn_combined_sale_fact.product_wid} = ${sl_mn_product_dim.product_wid};;
  }

  join: mn_combined_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_combined_product_group_dim
    view_label: "Pricing Program"
    sql_on: ${mn_combined_sale_fact.pg_wid} = ${mn_combined_product_group_dim.pg_wid};;
  }

  join: sl_product_eff_attr_fact {
    type: left_outer
    relationship: many_to_one
    from: mn_product_eff_attr_fact_ext
    view_label: "Sold Product"
    fields: [Product_EDA_Attributes*]
    sql_on: ${mn_combined_sale_fact.product_wid} = ${sl_product_eff_attr_fact.product_wid}
      AND (${mn_combined_sale_fact.invoice_raw} BETWEEN ${sl_product_eff_attr_fact.eff_start_raw} AND ${sl_product_eff_attr_fact.eff_end_raw});;
  }

  join: mn_uom_conversion_fact {
    type: left_outer
    relationship: many_to_many
    from: mn_uom_conversion_fact
    view_label: "Sales"
    sql_on: ${mn_combined_sale_fact.product_wid} = ${mn_uom_conversion_fact.product_wid}
            and (${mn_combined_sale_fact.invoice_raw} >= ${mn_uom_conversion_fact.eff_start_raw} and ${mn_combined_sale_fact.invoice_raw} <= ${mn_uom_conversion_fact.eff_end_raw})
            and ${mn_combined_sale_fact.inv_uom} = ${mn_uom_conversion_fact.from_uom} ;;
  }

  join: mn_from_uom_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_uom_dim
    view_label: "Sales"
    fields: [mn_from_uom_dim.from_uom_sales]
    sql_on: ${mn_combined_sale_fact.inv_uom} = ${mn_from_uom_dim.src_sys_uom_code} ;;
  }

  join: mn_to_uom_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_uom_dim
    view_label: "Sales"
    fields: [mn_to_uom_dim.to_uom]
    sql_on: ${mn_uom_conversion_fact.to_uom} = ${mn_to_uom_dim.src_sys_uom_code} ;;
  }

  join: mn_sales_org_dim {
    type:  left_outer
    relationship: many_to_one
    from: mn_org_dim
    view_label: "Sales"
    sql_on: ${mn_combined_sale_fact.org_wid} = ${mn_sales_org_dim.org_wid} ;;
  }

# Hiding Unwanted Joins
  join: mn_customer_owner_dim {
    from: mn_customer_dim
    view_label: "Pricing Contract Owner Account"
    fields: []
  }

  join: mn_cpg_price_list_dim {
    from: mn_price_list_dim
    view_label: "Contracted Price List"
    fields: []
  }

  join: mn_pg_tier_basis_dim {
    from: mn_pg_qual_ben_flat
    view_label: "Pricing Program Tier Basis"
    fields: []
  }


# Below code commented and moved to Data Secutity section in sales explore -Chandra 28/08/2017
#   join: mn_user_access_sale_map {
#     type: inner
#     relationship: many_to_one
#     from: mn_user_org_map_dt
#     view_label: "User Access"
#     fields: []
#     sql_on: ${mn_combined_sale_fact.org_wid} = ${mn_user_access_sale_map.org_wid};;
#   }

  ### This Part is to modify views retrieved through extending
#   join: mn_contract_author_dim {
#     #fields: [mn_contract_author_dim.fname,mn_contract_author_dim.lname]
#     view_label: "Pricing Contract Author"
#   }
#
#   join: mn_contract_srep_dim {
#     view_label: "Pricing Contract Sales Rep"
#   }
#
#   join: mn_ctrt_domain_dim {
#     view_label: "Pricing Contract Domain"
#   }
#
#   join: mn_additional_delegate_dim  {
#     fields: []
#   }
#
#   join: mn_customer_owner_dim  {
#     fields: []
#   }

#   join: mn_ctrt_status_dim {
#     view_label: "Pricing Contract Status"
#   }
#
#   join: mn_ctrt_type_dim {
#     view_label: "Pricing Contract Type"
#   }
#
#   join: mn_ctrt_sub_type_dim {
#     view_label: "Pricing Contract Subtype"
#   }

#   join: mn_cpg_price_list_dim {
#     view_label: "Pricing Program Price List"
#     fields: [price_list_name]
#   }
}

# PBC Compliance Commitments model
explore: provider_compliance {
  label: "Provider Compliance"
  extends: [mn_contract_header_dim_adhoc_base, mn_combined_product_group_dim_base]
  #from: mn_cmpl_commit_fact
  #from: base_mn_cmb_cmpl_cmit_fct_lkr
  from: mn_combined_cmpl_commit_fact
  view_name: mn_combined_cmpl_commit_fact
  view_label: "Commitment"

  # fields: [ALL_FIELDS*,-mn_contract_header_dim.ctrt_num_payer]

  hidden: no

  sql_always_where: ${mn_ctrt_type_dim.ctrt_type_name} IN
                      ('FSS','IDN','Independent','Institutional','Master','PHS','Purchase Based')
                      and ${mn_contract_header_dim.latest_flag} = 'Y'
                    ;;

#****************************** Data security


  access_filter: {
    field: mn_user_access_ctrt_map.access_user_id
    user_attribute: access_user_id
  }

  # User Org join
  join: mn_user_access_ctrt_map {
    type: inner
    relationship: many_to_one
    from: mn_user_org_map
#     view_label: "User Access"
    fields: [access_user_id]
    sql_on: ${mn_contract_header_dim.org_wid} = ${mn_user_access_ctrt_map.org_wid};;
  }

  #******************************* Data Security End

  join: mn_combined_product_group_dim {
    type: inner
    relationship: many_to_one
    from: mn_combined_product_group_dim
    view_label: "Pricing Program"
    sql_on: ${mn_combined_cmpl_commit_fact.pg_wid} = ${mn_combined_product_group_dim.pg_wid} AND ${mn_combined_product_group_dim.latest_flag} = 'Y' ;;
  #  sql_on: ${base_mn_cmb_cmpl_cmit_fct_lkr.pg_wid} = ${mn_combined_product_group_dim.pg_wid} AND ${mn_combined_product_group_dim.latest_flag} = 'Y' ;;

  }

  join: mn_contract_header_dim {
    type: inner
    relationship: many_to_one
    from: mn_contract_header_dim
    view_label: "Pricing Contract"
    sql_on: ${mn_combined_cmpl_commit_fact.contract_wid} = ${mn_contract_header_dim.contract_wid} AND ${mn_contract_header_dim.latest_flag} = 'Y' ;;
   # sql_on: ${base_mn_cmb_cmpl_cmit_fct_lkr.contract_wid} = ${mn_contract_header_dim.contract_wid}  ;;
    # AND ${mn_contract_header_dim.latest_flag} = 'Y'

  }

#   join: mn_cmt_type_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_cmt_type_dim
#     view_label: "Commitments"
#     sql_on: ${mn_combined_cmpl_commit_fact.commit_type_wid} = ${mn_cmt_type_dim.cmt_type_wid} ;;
#     fields:[cmt_type_name]
#
#   }

  join: mn_distrib_mthd_dim {
    view_label: "Pricing Contract"
    fields: [dist_method_name]

  }

  join: cmpl_committed_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_commit_dim_ext
    view_label: "Commitment"
    sql_on: ${mn_combined_cmpl_commit_fact.customer_wid} = ${cmpl_committed_customer.customer_wid};;
    fields: [cmpl_committed_customer.commitcustomer_set*]
   # sql_on: ${base_mn_cmb_cmpl_cmit_fct_lkr.customer_wid} = ${cmpl_committed_customer.customer_wid} ;;
  }

#   join: mn_cmt_change_reason_dim {
#     type: left_outer
#     relationship: many_to_one
#     from: mn_cmt_change_reason_dim
#     view_label: "Commitments"
#     fields: [cmt_change_code_name]
#     sql_on: ${mn_cmpl_commit_fact.cmt_change_code_wid} = ${mn_cmt_change_reason_dim.cmt_change_code_wid} ;;
#
#   }

  join: mn_cmpl_period_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_cmpl_period_fact
    view_label: "Period"
    sql_on: ${mn_combined_cmpl_commit_fact.src_sys_commit_id} = ${mn_cmpl_period_fact.src_sys_commit_id} AND ${mn_cmpl_period_fact.hidden_flag} = 'N' ;;
  #  sql_on: ${base_mn_cmb_cmpl_cmit_fct_lkr.src_sys_commit_id} = ${mn_cmpl_period_fact.src_sys_commit_id} AND ${mn_cmpl_period_fact.hidden_flag} = 'N' ;;
  }

# use base_mn_product_eff_attr_fact_ext to create multi level label groupping

  join: mn_cmpl_period_pkg_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_cmpl_period_pkg_dim
    view_label: "Period"
    fields: [period_pkg_id_num, period_pkg_name, period_pkg_status]
    sql_on: ${mn_cmpl_period_fact.period_pkg_wid} = ${mn_cmpl_period_pkg_dim.cmpl_period_pkg_wid} ;;
  }

  join: mn_cmpl_per_lines_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_cmpl_per_lines_fact_dist
   # from: mn_cmpl_per_lines_fct_dst_lkr
    view_label: "Compliance Bucket Line"
    sql_on: ${mn_cmpl_period_fact.period_wid} = ${mn_cmpl_per_lines_fact.period_wid} ;;
  }

  join: cmpl_hip_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Compliance Bucket Line - Ship To Customer"
    sql_on: ${mn_cmpl_per_lines_fact.sale_ship_to_cust_wid} = ${cmpl_hip_to_customer.customer_wid};;
  }

  join: cmpl_hip_to_customer_ids_dim {
    type: left_outer
    relationship: one_to_many
    from: mn_customer_ids_dim
    view_label: "Compliance Bucket Line - Ship To Alternate IDs"
    sql_on: ${cmpl_hip_to_customer.customer_wid} = ${cmpl_hip_to_customer_ids_dim.customer_wid} ;;
  }

  join: cmpl_sold_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Compliance Bucket Line - Sold To Customer"
    sql_on: ${mn_cmpl_per_lines_fact.sale_sold_to_cust_wid} = ${cmpl_sold_to_customer.customer_wid};;
  }

  join: cmpl_sold_to_customer_ids_dim {
    type: left_outer
    relationship: one_to_many
    from: mn_customer_ids_dim
    view_label: "Compliance Bucket Line - Sold To Alternate IDs"
    sql_on: ${cmpl_sold_to_customer.customer_wid} = ${cmpl_sold_to_customer_ids_dim.customer_wid} ;;
  }

  join: cmpl_mn_product_dim {
    type: inner
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product"
    fields: [product_num, product_name, gl_account_code, sku, ndc, market_entry_date]
    sql_on: ${mn_cmpl_per_lines_fact.product_wid} = ${cmpl_mn_product_dim.product_wid} ;;
  }

  join: cmpl_prod_eff_attr_fact_ext {
    type: left_outer
    relationship: many_to_many
    from: mn_product_eff_attr_fact_ext
    view_label: "Product"
    fields: [cmpl_prod_eff_attr_fact_ext.Product_EDA_Attributes*]
    sql_on: ${mn_cmpl_per_lines_fact.product_wid} = ${cmpl_prod_eff_attr_fact_ext.product_wid} ;;
  }

#   join: mn_pg_qual_ben_flat_ext {
#     type: inner
#     relationship: many_to_one
#     from: mn_pg_qual_ben_flat_ext
#     view_label: "Period"
#     sql_on: ${mn_cmpl_period_fact.pg_wid} = ${mn_pg_qual_ben_flat_ext.pg_wid}
#             and
#             ${mn_pg_tier_basis_dim.pg_tb_wid} = ${mn_pg_qual_ben_flat_ext.pg_tb_wid}
#             ;;
#   }

  join: mn_pg_qual_ben_processed {
    type: inner
    relationship: many_to_one
    from: mn_pg_qual_ben_unflat
   #  from: lkr_mn_pg_qual_ben_unflat
    view_label: "Period"
    fields: []
    sql_on: ${mn_cmpl_period_fact.pg_wid} = ${mn_pg_qual_ben_processed.pg_wid}
            AND
            ${mn_pg_tier_basis_dim.pg_tb_tier_wid} = ${mn_pg_qual_ben_processed.pg_tb_tier_wid}
            AND ${mn_cmpl_period_fact.commit_tier} = ${mn_pg_qual_ben_processed.tier_idx}
            ;;
  }

  # override join from base explore mn_combined_product_group_dim_base
  join: mn_pg_tier_basis_dim {
    type: left_outer
    relationship: one_to_many
    from: mn_pg_qual_ben_unflat
    view_label: "Pricing Program Tier Basis"
    sql_on: ${mn_combined_product_group_dim.pg_wid} = ${mn_pg_tier_basis_dim.pg_wid}
      AND  ${mn_pg_tier_basis_dim.is_qual_comp_flag} ='Y';;
  }

#   Hiding Unwanted Joins
  join: mn_cpg_price_list_dim {
    from: mn_price_list_dim
    view_label: "Contracted Price List"
    fields: []
  }

#   Relabelling the existing labels
  join: mn_customer_owner_dim {
    from: mn_customer_dim
    view_label: "Pricing Contracted Customer"
  }

  join: mn_ch_cust_cot_dim {
    from: mn_customer_cot_dim
    view_label: "Pricing Contracted Customer COT"
  }

  join: mn_ch_cot_dim {
    from: mn_cot_dim
    view_label: "Pricing Contracted Customer COT"
  }
#    Complete relable

} # end of commercial_compliance explore


explore: mn_price_list_dim {
  label: "Provider Price Lists"
  extends: [mn_price_list_dim_base]
  from: mn_price_list_dim
  view_name: mn_price_list_dim
  view_label: "Price List"
  hidden: yes


}

explore: mn_price_list_dim_dated {
  label: "Provider Price Lists Dated"
  extends: [mn_price_list_dim_base]
  hidden: yes
  from: mn_price_list_dim
  view_name: mn_price_list_dim
  view_label: "Price List"

  join: mn_date_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_period_dim
    view_label: "Date"
    #fields: [full_name]
    sql_on: ${mn_date_dim.start_date_sql_raw} BETWEEN TRUNC(${mn_pl_price_list_fact.period_start_raw},'MM')
      AND  TRUNC(${mn_pl_price_list_fact.period_end_raw},'MM');;
  }

}

explore: mn_chgbk_claim_dim {
  label: "Provider Chargeback Claims"
  from: mn_chgbk_claim_dim
  view_name: mn_chgbk_claim_dim
  view_label: "Claim"
  hidden: yes

  join: mn_claim_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Trading Partner"
    sql_on: ${mn_claim_customer_dim.customer_wid} = ${mn_chgbk_claim_dim.payee_wid};;
  }

  join: mn_chgbk_sale_fact {
    type: left_outer
    relationship: many_to_one
    from: mn_indir_sale_fact
    view_label: "Chargeback Data"
    sql_on: ${mn_chgbk_sale_fact.chgbk_claim_wid} = ${mn_chgbk_claim_dim.chgbk_claim_wid};;
  }

}
