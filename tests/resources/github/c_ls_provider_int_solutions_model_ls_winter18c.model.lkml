include: "base_ls_database_connection_ls_winter18c.model.lkml"
include: "base_ls_explores_ls_winter18c.model.lkml"
include: "base_ls_provider_int_explores_ls_winter18c.model.lkml"
include: "base_ls_provider_int_app_model_ls_winter18c.model.lkml"
include: "*.view.lkml"         # include all views in this project



#include: "c_ls_revenue_waterfall_ls_winter18c.dashboard.lookml"
#include: "SalesRevenueGrossToNet.dashboard.lookml"
#include: "SalesSummaryByCustomerView.dashboard.lookml"

label: "Int Solutions Provider Intelligence"


explore: c_gross_to_net_sales {
  label: "Solutions Sales for Gross To Net"
  extends: [gross_to_net_sales]
  from:  mn_org_dim
  view_name: mn_sale_org_dim

  hidden: no

  view_label: "Sales Org"

  join: mn_gross_to_net_label {
    type: left_outer
    relationship: many_to_one
    from: mn_gross_to_net_label
    view_label: "Sales"
    fields: [kpi_name, price_kpi_name, kpi_num]
    sql_on: ${mn_gross_to_net_label.dummy_id} = ${mn_combined_sale_fact.dummy_id};;
  }


}


explore: c_provider_sales_and_contract_pricing {
  label: "PBC Contracts and Sales"
  #label: "AZ PBC Contracts and Sales"
  extends: [provider_sales_base, mn_org_comb_product_group_dim_base, mn_contract_header_dim]
  from:  mn_org_dim
  view_name: mn_sale_org_dim


  hidden: no

  sql_always_where:  ${mn_contract_header_dim.latest_flag} = 'Y';;
  #and ${mn_ctrt_type_dim.ctrt_type_name} IN ('FSS','IDN','Independent','Institutional','Master','PHS','Purchase Based')   ;;

  view_label: "Sales Org"

  join: mn_contract_header_dim {
    type: inner
    relationship: many_to_one
    from: mn_contract_header_dim
    #view_label: "General Contract"
    #fields: []
    sql_on: ${mn_contract_header_dim.org_wid} = ${mn_sale_org_dim.org_wid};;
  }

  join: mn_pg_ben_elig_cust_map {
    type: left_outer
    relationship: many_to_one
    from: mn_ctrt_elig_customers_map
    view_label: "Contract Eligible Customer"
    fields: [program_type, component_type]
    sql_on: ${mn_contract_header_dim.src_sys_contract_id} = ${mn_pg_ben_elig_cust_map.src_sys_contract_id};;
  }


  join: mn_combined_rebate_program_dim {
    type: left_outer
    view_label: "Rebate Program"
    relationship: many_to_one
    from: mn_combined_rebate_program_dim
    sql_on: ${mn_pg_ben_elig_cust_map.program_wid} = ${mn_combined_rebate_program_dim.program_wid}
      --AND ${mn_combined_rebate_program_dim.latest_flag} = 'Y'
      AND ${mn_pg_ben_elig_cust_map.program_type} ='Rebate Program';;
  }

#   join: mn_org_comb_product_group_dim {
#     type: inner
#     view_label: "General Pricing Program"
#     relationship: many_to_one
#     from: mn_combined_product_group_dim
#     sql_on: ${mn_contract_header_dim.src_sys_contract_id} = ${mn_org_comb_product_group_dim.src_sys_pk_id}
#       AND ${mn_org_comb_product_group_dim.latest_flag} = 'Y' ;;
#   }

  join: mn_combined_sale_fact {
    type: left_outer
    relationship: many_to_one
    from: mn_combined_sale_fact_gtn
    view_label: "Sales"
    fields: [mn_combined_sale_fact.gtn_set1*]
    sql_on: ${mn_combined_sale_fact.org_wid} = ${mn_sale_org_dim.org_wid}
      AND ${mn_contract_header_dim.contract_wid} =  ${mn_combined_sale_fact.contract_wid}
      AND  ${mn_combined_sale_fact.ship_to_customer_wid} = ${mn_pg_ben_elig_cust_map.elig_customer_wid};;
  }

  # Changing labels
  join: sl_mn_product_dim {
    from: mn_product_dim
    view_label: "Sale Product and Product Hierarchy"
  }

  join: mn_pg_prod_hrc {
    from: mn_product_map_all_ver_ext
    view_label:"Sale Product and Product Hierarchy"
  }

  join: sl_product_eff_attr_fact {
    from: mn_product_eff_attr_fact_ext
    view_label: "Sale Product and Product Hierarchy"
  }
}
