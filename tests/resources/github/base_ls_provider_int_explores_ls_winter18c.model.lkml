include: "base_ls_database_connection_ls_winter18c.model.lkml"
include: "base_ls_explores_ls_winter18c.model.lkml"

include: "base_mn_discount_percent_band_drv.view.lkml"
include: "base_mn_combined_sale_fact_gtn.view.lkml"
include: "base_mn_product_map_all_ver_ext.view.lkml"
include: "base_mn_seller_hrc_cust_map.view.lkml"
include: "base_mn_seller_hrc_dim.view.lkml"
include: "base_mn_pg_product_pricing_fact.view.lkml"
include: "base_mn_pg_ben_elig_cust_map.view.lkml"
include: "base_mn_cost_of_sale_fact.view.lkml"
include: "base_mn_cmpl_period_fact.view.lkml"



label: "Provider Intelligence"



explore: mn_cmpl_period_fact_base {
  label: "Account Compliance Data"
  from:  mn_cmpl_period_fact
  view_label: "Compliance Period"
  view_name: mn_cmpl_period_fact
  extends: [mn_contract_header_dim_base ]

  extension: required


  join: mn_contract_header_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_contract_header_dim
    view_label: "Contract"
    #fields: []
    sql_on: ${mn_cmpl_period_fact.contract_wid} = ${mn_contract_header_dim.contract_wid};;
  }

  join: mn_customer_cmpl_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Account"
    #fields: []
    sql_on: ${mn_cmpl_period_fact.customer_wid} = ${mn_customer_cmpl_dim.customer_wid};;
  }



}


explore: provider_sales_base {
  label: "Sales"
  extension: required
  extends: [mn_contract_header_dim_base, mn_combined_product_group_dim_base]
  from:  mn_org_dim
  view_name: mn_sale_org_dim

  view_label: "Sales Org"

  join: mn_combined_sale_fact {
    type: inner
    relationship: one_to_many
    from: mn_combined_sale_fact_gtn
    view_label: "Sales"
    fields: [mn_combined_sale_fact.gtn_set1*]
    sql_on: ${mn_combined_sale_fact.org_wid} = ${mn_sale_org_dim.org_wid} ;;
  }

  join: sl_contracted_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: Contracted"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.customer_wid} = ${sl_contracted_customer.customer_wid};;
  }

  join: sl_gpo_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: GPO"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.gpo_wid} = ${sl_gpo_customer.customer_wid};;
  }

  join: sl_idn_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: IDN"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.idn_wid} = ${sl_idn_customer.customer_wid};;
  }


  join: sl_contracted_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Customer: Contracted"
    fields: [id_num, id_type]
    sql_on: ${mn_combined_sale_fact.customer_wid} = ${sl_contracted_customer_ids.customer_wid};;
  }

  join: sl_contr_cust_cot_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_cot_dim
    view_label: "Customer: Contracted"
    sql_on: ${sl_contracted_customer.customer_wid} = ${sl_contr_cust_cot_dim.customer_wid}
            and ${sl_contr_cust_cot_dim.eff_start_raw} <= ${mn_combined_sale_fact.invoice_raw}
            and ${sl_contr_cust_cot_dim.eff_end_raw} >= ${mn_combined_sale_fact.invoice_raw} ;;
  }

  join: sl_contr_cot_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_cot_dim
    view_label: "Customer: Contracted"
    sql_on: ${sl_contr_cust_cot_dim.cot_wid} = ${sl_contr_cot_dim.cot_wid} ;;
  }


  join: sl_wholesaler {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: Wholesaler"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.distr_wid} = ${sl_wholesaler.customer_wid}
      AND ${sl_wholesaler.member_info_type} =  'Wholesaler'  ;;
  }

  join: sl_wholesaler_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    sql_on: ${mn_combined_sale_fact.distr_wid}=${sl_wholesaler_customer_ids.customer_wid}
      AND ${sl_wholesaler.member_info_type} =  'Wholesaler'  ;;
    view_label: "Customer: Wholesaler"
    fields: [id_num, id_type]
  }

  join: sl_parent_wholesaler {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: Parent Wholesaler"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.parent_distr_wid} = ${sl_parent_wholesaler.customer_wid}
      AND ${sl_parent_wholesaler.member_info_type} =  'Wholesaler'  ;;
  }

  join: sl_sold_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: Sold To"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.sold_to_customer_wid} = ${sl_sold_to_customer.customer_wid};;
  }

  join: sl_sold_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Customer: Sold To"
    fields: [id_num, id_type]
    sql_on: ${mn_combined_sale_fact.sold_to_customer_wid}=${sl_sold_to_customer_ids.customer_wid};;
  }

  join: sl_hip_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: Ship To"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.ship_to_customer_wid} = ${sl_hip_to_customer.customer_wid};;
  }

  join: sl_hip_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Customer: Ship To"
    fields: [id_num, id_type]
    sql_on: ${mn_combined_sale_fact.ship_to_customer_wid}=${sl_hip_to_customer_ids.customer_wid};;
  }

  join: sl_ship_cust_cot_dim {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_cot_dim
    view_label: "Customer: Ship To"
    sql_on: ${mn_combined_sale_fact.ship_to_customer_wid} = ${sl_ship_cust_cot_dim.customer_wid}
            and ${sl_ship_cust_cot_dim.eff_start_raw} <= ${mn_combined_sale_fact.invoice_raw}
            and ${sl_ship_cust_cot_dim.eff_end_raw} >= ${mn_combined_sale_fact.invoice_raw} ;;
  }

  join: sl_ship_cot_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_cot_dim
    view_label: "Customer: Ship To"
    sql_on: ${sl_ship_cust_cot_dim.cot_wid} = ${sl_ship_cot_dim.cot_wid} ;;
  }



  join: sl_bill_to_customer {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Customer: Bill To"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.bill_to_customer_wid} = ${sl_bill_to_customer.customer_wid};;
  }

  join: sl_bill_to_customer_ids {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_ids_dim
    view_label: "Customer: Bill To"
    fields: [id_num, id_type]
    sql_on: ${mn_combined_sale_fact.bill_to_customer_wid}=${sl_bill_to_customer_ids.customer_wid};;
  }

  join: mn_sale_elig_cot_dim {
    type: left_outer
    view_label: "Class Of Trade: Sale"
    relationship: many_to_one
    from: mn_cot_dim
    #fields: []
    sql_on: ${mn_combined_sale_fact.cot_wid} = ${mn_sale_elig_cot_dim.cot_wid};;
  }


  join: mn_contract_header_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_contract_header_dim
    view_label: "Contract"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.contract_wid} = ${mn_contract_header_dim.contract_wid};;
  }

  join: sl_mn_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product and Product Hierarchy"
    #fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.product_wid} = ${sl_mn_product_dim.product_wid};;
  }

  join: mn_pg_prod_hrc {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver_ext
    view_label:"Product and Product Hierarchy"
    fields: [short_gtn_set1*]
    sql_on: ${mn_pg_prod_hrc.level0_product_wid} = ${mn_combined_sale_fact.product_wid} ;;
  }


  join: mn_combined_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_combined_product_group_dim
    view_label: "Pricing Program"
    fields: [short_gtn_set1*]
    sql_on: ${mn_combined_sale_fact.pg_wid} = ${mn_combined_product_group_dim.pg_wid};;
  }

  join: sl_product_eff_attr_fact {
    type: left_outer
    relationship: many_to_many
    from: mn_product_eff_attr_fact_ext
    view_label: "Product and Product Hierarchy"
    fields: [Product_EDA_Attributes*]
    sql_on: ${mn_combined_sale_fact.product_wid} = ${sl_product_eff_attr_fact.product_wid}
      AND (${mn_combined_sale_fact.invoice_raw} BETWEEN ${sl_product_eff_attr_fact.eff_start_raw} AND ${sl_product_eff_attr_fact.eff_end_raw});;
  }

  join: sl_seller_hrc_cust_map {
    type: left_outer
    relationship: many_to_many
    from: mn_seller_hrc_cust_map
    view_label: "Seller Hierarchy"
    fields: []
    sql_on: ${mn_combined_sale_fact.customer_wid} = ${sl_seller_hrc_cust_map.customer_wid};;
  }


  join: sl_seller_hrc_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_seller_hrc_dim
    view_label: "Seller Hierarchy"
    #fields: []
    sql_on: ${sl_seller_hrc_dim.seller_hrc_wid} = ${sl_seller_hrc_cust_map.seller_hrc_wid};;
  }


# Hiding Unwanted Joins
  join: mn_customer_owner_dim {
    from: mn_customer_dim
    view_label: "Pricing Contract Owner Account"
    #fields: []
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


  ### This Part is to modify views retrieved through extending
  join: mn_ctrt_domain_dim {
    view_label: "Contract"
  }
  join: mn_ctrt_status_dim {
    view_label: "Contract"
  }

  join: mn_ctrt_type_dim {
    view_label: "Contract"
  }

  join: mn_ctrt_sub_type_dim {
    view_label: "Contract"
  }

  join: mn_contract_author_dim {
    fields: []
    from:  mn_user_dim
    view_label: "Pricing Contract Author"
  }

  join: mn_contract_srep_dim {
    fields: [mn_contract_srep_dim.full_name]
    from:  mn_user_dim
    view_label: "Pricing Contract Sales Rep"
  }

  join: mn_additional_delegate_dim  {
    from:  mn_user_dim
    fields: []
  }

}

explore: mn_org_comb_product_group_dim_base {
  label: "Pricing Program"
  extension: required
  from:  mn_combined_product_group_dim
  view_name: mn_org_comb_product_group_dim



  join: mn_pg_product_fact {
    type: left_outer
    relationship: one_to_many
    from: mn_pg_product_pricing_fact
    view_label: "General Pricing Program Products and Pricing"
    sql_on: ${mn_pg_product_fact.pg_wid} = ${mn_org_comb_product_group_dim.pg_wid};;
  }


  join: mn_pg_prod_adhoc_map {
    type: left_outer
    relationship: many_to_one
    from: mn_pg_prod_adhoc_map_exp
    view_label: "General Pricing Program Products and Pricing"
    #fields: [product_name, product_num]
    sql_on: ${mn_pg_prod_adhoc_map.pg_wid} = ${mn_pg_product_fact.pg_wid}
      AND ${mn_pg_prod_adhoc_map.product_wid} = ${mn_pg_product_fact.product_wid}
      AND ${mn_pg_prod_adhoc_map.excluded_flag} ='N';;
  }

  join: ct_prc_prod_hrc {
    type: left_outer
    relationship: many_to_many
    from: mn_product_map_all_ver_ext
    view_label:"General Pricing Program Product and Product Hierarchy"
    fields: [short_gtn_set1*]
    sql_on: ${ct_prc_prod_hrc.level0_product_wid} = ${mn_pg_product_fact.product_wid} ;;
  }


  join: mn_product_prc_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "General Pricing Program Products and Pricing"
    fields: [product_name, product_num, product_name_num]
    sql_on: ${mn_pg_product_fact.product_wid} = ${mn_product_prc_dim.product_wid};;
  }
}

explore: provider_rebates_base {
  label: "Provider Intelligence Rebates"
  extension: required
  extends: [mn_rbt_ctrt_header_dim_base, mn_combined_rebate_program_dim_base, mn_rebate_payment_fact_base]
  from: mn_contract_header_dim
  view_name: mn_rbt_ctrt_header_dim
  view_label: "Rebate Contract"

  join: mn_combined_rebate_program_dim {
    type: inner
    view_label: "Rebate Program"
    relationship: one_to_many
    from: mn_combined_rebate_program_dim
    sql_on: ${mn_rbt_ctrt_header_dim.contract_wid} = ${mn_combined_rebate_program_dim.contract_wid}
      ;;
  }

  join: rbt_prog_product_map {
    type: left_outer
    view_label: "Rebate Product Hierarchy"
    relationship: one_to_many
    from: mn_rebate_prog_prod_map_all
    fields: []
    sql_on: ${mn_combined_rebate_program_dim.program_wid} = ${rbt_prog_product_map.program_wid}
            AND ${rbt_prog_product_map.excluded_flag} = 'N'
            ;;
  }

  join: rbt_mn_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product and Product Hierarchy"
    sql_on: ${rbt_prog_product_map.product_wid} = ${rbt_mn_product_dim.product_wid};;
  }

  join: mn_rbt_prod_hrc {
    type: left_outer
    relationship: many_to_many
    view_label: "Product and Product Hierarchy"
    from: mn_product_map_all_ver_ext
    sql_on: ${mn_rbt_prod_hrc.level0_product_wid} = ${rbt_prog_product_map.product_wid} ;;

  }

  join: rbt_seller_hrc_comtd_cust_map {
    type: left_outer
    relationship: many_to_many
    view_label: "Seller Hierarchy"
    from: mn_seller_hrc_cust_map
    fields: []
    sql_on: ${mn_rebate_payment_fact.commited_customer_wid} = ${rbt_seller_hrc_comtd_cust_map.customer_wid} ;;
  }

  join: rbt_seller_hrc_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_seller_hrc_dim
    view_label: "Seller Hierarchy"
    sql_on: ${rbt_seller_hrc_dim.seller_hrc_wid} = ${rbt_seller_hrc_comtd_cust_map.seller_hrc_wid} ;;
  }

  join: rbt_cmtd_cust_eda {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_attr_fact
    view_label: "Customer EDA"
    sql_on: ${mn_rebate_payment_fact.commited_customer_wid} = ${rbt_cmtd_cust_eda.customer_wid} and ${rbt_cmtd_cust_eda.eda_date_filter} =1 ;;
  }

  join: rbt_cust_map {
    type: left_outer
    relationship: many_to_many
    from: mn_customer_map
    view_label: "Rebate Committed Customer Map"
    fields: []
    sql_on: ${mn_rebate_payment_fact.commited_customer_wid} = ${rbt_cust_map.child_cust_wid} and ${rbt_cust_map.mem_level} > 0 ;;
  }

  join: rbt_inst_cust_dim {
    type: left_outer
    relationship: one_to_many
    from: mn_customer_dim
    view_label: "Commited Customer Hierarchy"
    fields: [short_gtn_set1*]
    sql_on: ${rbt_cust_map.parent_cust_wid} = ${rbt_inst_cust_dim.customer_wid}  ;;
  }
}
