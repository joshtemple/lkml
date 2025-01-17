include: "base_ls_database_connection_ls_winter18c.model.lkml"
include: "*.view.lkml"         # include all views in this project
include: "base_si_app_contract_and_products.dashboard.lookml"
include: "base_si_app_sales_performance.dashboard.lookml"
include: "base_si_app_price_trend_and_transaction.dashboard.lookml"
include: "base_si_app_compliance_trend.dashboard.lookml"
include: "base_si_app_account_comparison.dashboard.lookml"

include: "base_ls_explores_ls_winter18c.model.lkml"
include: "base_ls_provider_int_explores_ls_winter18c.model.lkml"

label: "Sales Intelligence"

explore: mn_date_dim {
  label: " Invoice Date"
  hidden: yes
}

explore: mn_cmpl_bucket_fact {
  hidden: yes
  extension:  required
}

explore: mn_date_labels {
  label: "Year Labels"
  hidden: yes
}

explore: mn_user_access_map {
  label: "User Customer Access"
  hidden: yes
  # extension:  required

  join: mn_customer_access_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Account"
    #fields: []
    sql_on: ${mn_user_access_map.customer_wid} = ${mn_customer_access_dim.customer_wid};;
  }

}

explore: mn_cmpl_period_fact {
  label: "Account Compliance Data"
  from:  mn_cmpl_period_fact_secure
  view_name: mn_cmpl_period_fact
  extends: [mn_cmpl_period_fact_base]

  hidden: no


#  access_filter: {
#     field: mn_cmpl_period_fact.access_user_name
#     user_attribute: rme_access_user_name
#   }

  join: mn_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Price Program"
    #fields: [channel_name]
    sql_on: ${mn_cmpl_period_fact.pg_wid} = ${mn_product_group_dim.pg_wid};;
  }

  join: mn_user_access_cmpl_map {
    type: inner
    relationship: many_to_one
    from: mn_user_access_map
    view_label: "User Access"
    fields: []
    sql_on: ${mn_cmpl_period_fact.customer_wid} = ${mn_user_access_cmpl_map.customer_wid};;
  }

}

explore: mn_cmpl_period_fact_dated {
  extends: [mn_cmpl_period_fact]
  from:  mn_cmpl_period_fact_dated
  view_name: mn_cmpl_period_fact
  label: "Account Compliance Monthly Data"

  sql_always_where: ${mn_date_dim.start_date_sql_raw} <= SYSDATE ;;

  hidden: no

  join: mn_date_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_period_dim
    view_label: "Date"
    #fields: [full_name]
    sql_on: ${mn_date_dim.start_date_sql_raw} BETWEEN TRUNC(${mn_cmpl_period_fact.period_start_raw},'MM')
       AND  TRUNC(${mn_cmpl_period_fact.period_end_raw},'MM');;
  }

}

explore: mn_combined_sale_fact {
  label: "Account Sales Data"
  extends: [mn_contract_header_dim_base]

  from:  mn_combined_sale_fact
  view_name: mn_combined_sale_fact
  hidden: no


#  always_join: [mn_user_access_map]

#  access_filter: {
#     field: mn_combined_sale_fact.access_user_name
#     user_attribute: rme_access_user_name
#   }

  join: mn_user_access_sale_map {
    type: inner
    relationship: many_to_one
    from: mn_user_access_map
    view_label: "User Access"
    fields: []
    sql_on: ${mn_combined_sale_fact.customer_wid} = ${mn_user_access_sale_map.customer_wid};;
  }

  join: mn_customer_account_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Account"
    #fields: [full_name]
    sql_on: ${mn_combined_sale_fact.customer_wid} = ${mn_customer_account_dim.customer_wid};;
  }

  join: mn_date_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_date_dim
    view_label: "Invoice Date"
    #fields: [full_name]
    sql_on: ${mn_combined_sale_fact.inv_date_wid} = ${mn_date_dim.date_dim_wid};;
  }

  join: mn_contract_header_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_contract_header_dim
    view_label: "Contract"
    #fields: []
    sql_on: ${mn_contract_header_dim.contract_wid} = ${mn_combined_sale_fact.contract_wid};;
  }

  join: mn_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Price Program"
    #fields: [channel_name]
    sql_on: ${mn_combined_sale_fact.pg_wid} = ${mn_product_group_dim.pg_wid};;
  }

  join: mn_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product"
    #fields: [channel_name]
    sql_on: ${mn_combined_sale_fact.product_wid} = ${mn_product_dim.product_wid};;
  }

  join: mn_product_map {
    type: left_outer
    relationship: one_to_one
    from: mn_product_map
    view_label: ""
    fields: []
    sql_on: ${mn_product_dim.product_wid} = ${mn_product_map.child_prod_wid} AND ${mn_product_map.depth_from_parent} = 1;;
  }

  join: mn_category_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product Category"
    #fields: [channel_name]
    sql_on: ${mn_product_map.parent_prod_wid} = ${mn_category_dim.product_wid};;
  }


  join: mn_billto_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Bill To Customer"
    #fields: [full_name]
    sql_on: ${mn_combined_sale_fact.bill_to_customer_wid} = ${mn_billto_customer_dim.customer_wid};;
  }

  join: mn_1shipto_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Ship To Customer"
    #fields: [full_name]
    sql_on: ${mn_combined_sale_fact.ship_to_customer_wid} = ${mn_1shipto_customer_dim.customer_wid};;
  }

  join: mn_2soldto_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Sold To Customer"
    #fields: [full_name]
    sql_on: ${mn_combined_sale_fact.sold_to_customer_wid} = ${mn_2soldto_customer_dim.customer_wid};;
  }

  join: mn_channel_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Channel"
    #fields: [full_name]
    sql_on: ${mn_combined_sale_fact.branch_distr_wid} = ${mn_channel_customer_dim.customer_wid};;
  }

  join: mn_uom_conversion_fact {
    type: left_outer
    relationship: many_to_many
    from: mn_uom_conversion_fact
    fields: []
    sql_on: ${mn_combined_sale_fact.product_wid} = ${mn_uom_conversion_fact.product_wid} ;;
  }

}

explore: mn_pg_product_pricing_fact{

  label: "Account Contracts, Pricing Program and Prices"

  extends: [mn_contract_header_dim_base]

  from:  mn_pg_product_pricing_fact_secure
  view_name: mn_pg_product_pricing_fact
  hidden: no

  sql_always_where: ${mn_product_group_dim.latest_flag} = 'Y' and ${mn_contract_header_dim.latest_flag} = 'Y'  ;;

#  always_join: [mn_user_access_map]

#  access_filter: {
#     field: mn_pg_product_pricing_fact.access_user_name
#     user_attribute: rme_access_user_name
#   }

  join: mn_user_access_pg_map {
    type: inner
    relationship: many_to_one
    from: mn_user_access_map
    view_label: "User Access"
    fields: []
    sql_on: ${mn_pg_ben_elig_cust_map.elig_customer_wid} = ${mn_user_access_pg_map.customer_wid};;
  }

  join: mn_pg_ben_elig_cust_map {
    type: left_outer
    relationship: many_to_many
    from: mn_pg_ben_elig_cust_map
    view_label: "Product"
    #fields: [channel_name]
    sql_on: ${mn_pg_product_pricing_fact.pg_wid} = ${mn_pg_ben_elig_cust_map.pg_wid};;
  }


  join: mn_eligible_customer_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_customer_dim
    view_label: "Eligible Account"
    #fields: [full_name]
    sql_on: ${mn_pg_ben_elig_cust_map.elig_customer_wid} = ${mn_eligible_customer_dim.customer_wid};;
  }


  join: mn_product_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product"
    #fields: [channel_name]
    sql_on: ${mn_pg_product_pricing_fact.product_wid} = ${mn_product_dim.product_wid};;
  }

  join: mn_product_map {
    type: left_outer
    relationship: many_to_one
    from: mn_product_map
    view_label: ""
    fields: []
    sql_on: ${mn_pg_product_pricing_fact.product_wid} = ${mn_product_map.child_prod_wid} AND ${mn_product_map.depth_from_parent} = 1;;
  }

  join: mn_category_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_dim
    view_label: "Product Category"
    #fields: [channel_name]
    sql_on: ${mn_product_map.parent_prod_wid} = ${mn_category_dim.product_wid};;
  }

  join: mn_product_group_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_product_group_dim
    view_label: "Price Program"
    #fields: [channel_name]
    sql_on: ${mn_pg_product_pricing_fact.pg_wid} = ${mn_product_group_dim.pg_wid};;
  }


  join: mn_contract_header_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_contract_header_dim
    view_label: "Contract"
    #fields: []
    sql_on: ${mn_contract_header_dim.src_sys_contract_id} = ${mn_product_group_dim.src_sys_contract_id};;
  }

  join: mn_prc_method_dim {
    type: left_outer
    relationship: many_to_one
    from: mn_prc_method_dim
    view_label: "Product Group"
    #fields: [channel_name]
    sql_on: ${mn_prc_method_dim.prc_method_wid} = ${mn_product_group_dim.pricing_method_wid};;
  }

}

explore: mn_contract_header_dim {

  label: "Contract Header"
  hidden: yes

  extends: [mn_contract_header_dim_base]

  from: mn_contract_header_dim_secure
  view_name: mn_contract_header_dim
  #extension:
  sql_always_where: ${mn_contract_header_dim.latest_flag} = 'Y'  ;;

  join: mn_user_access_ctrt_map {
      type: inner
      relationship: many_to_one
      from: mn_user_access_map
      view_label: "User Access"
      fields: []
      sql_on: ${mn_pg_ben_elig_cust_map.elig_customer_wid} = ${mn_user_access_ctrt_map.customer_wid};;
    }

    join: mn_pg_ben_elig_cust_map {
      type: left_outer
      relationship: one_to_many
      from: mn_pg_ben_elig_cust_map #mn_ctrt_elig_customers_map
      view_label: "Product"
      #fields: [channel_name]
      sql_on: ${mn_product_group_dim.pg_wid} = ${mn_pg_ben_elig_cust_map.pg_wid};;
    }


    join: mn_product_group_dim {
      type: left_outer
      relationship: many_to_one
      from: mn_product_group_dim
      view_label: "Price Program"
      #fields: [channel_name]
      sql_on:  ${mn_contract_header_dim.src_sys_contract_id} = ${mn_product_group_dim.src_sys_contract_id};;
    }

#     access_filter: {
#       field: mn_contract_header_dim.access_user_name
#       user_attribute: rme_access_user_name
#     }
}
