view: mn_customer_addr_fact {
  sql_table_name: MN_CUSTOMER_ADDR_FACT_VW ;;

  dimension: address {
    type: string
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: address_type {
    type: string
    label: "Type"
    sql: ${TABLE}.ADDRESS_TYPE ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: customer_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOMER_WID ;;
  }

  dimension_group: date_created {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DATE_CREATED ;;
  }

  dimension_group: date_updated {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DATE_UPDATED ;;
  }

  dimension: description {
    type: string
    label: "Name"
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: postal_zip {
    type: string
    label: "Zip"
    sql: ${TABLE}.POSTAL_ZIP ;;
  }

  dimension: primary_address {
    type: string
    label: "Is Primary ?"
    sql: ${TABLE}.PRIMARY_ADDRESS ;;
  }

  dimension: run_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RUN_ID ;;
  }

  dimension: source_system_id {
    type: string
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: src_sys_date_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SRC_SYS_DATE_UPDATED ;;
  }

  dimension: state_prov {
    type: string
    label: "State"
    sql: ${TABLE}.STATE_PROV ;;
  }

#   dimension: address_concat {
#     type: string
#     hidden: yes
#     sql: CASE WHEN ${address} IS NULL THEN NULL ELSE ${address} END ||
#           CASE WHEN ${city} IS NULL THEN NULL ELSE ', '||${city} END ||
#           CASE WHEN ${state_prov} IS NULL THEN NULL ELSE ', '||${state_prov} END ||
#           CASE WHEN ${postal_zip} IS NULL THEN NULL ELSE ', '||${postal_zip} END ||
#           CASE WHEN ${country} IS NULL THEN NULL ELSE ', '||${country} END ;;
#   }

  dimension: full_address {
    type: string
    label: "Address"
    sql: ${TABLE}.FULL_ADDRESS ;;
#     sql: CASE WHEN INSTR(${address_concat},', ')=1 THEN SUBSTR(${address_concat},3)
#               ELSE
#               ${address_concat} END ;;
  }

#*************Validata Customer Addr Aliasing
  dimension: trading_partner_street_addr {
    type: string
    label: "Street Address"
    sql: ${address} ;;
  }

  dimension: trading_partner_postal_code {
    type: string
    label: "Postal Code"
    sql: ${postal_zip} ;;
  }

  #  Transaction Explore attributes Start

  #********** Direct Sales group attributes start
  dimension: dir_bill_cust_state {
    type: string
    view_label: "Direct Sales"
    label: "Bill To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: dir_sold_cust_state {
    type: string
    view_label: "Direct Sales"
    label: "Sold To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: dir_ship_cust_state_prim {
    type: string
    view_label: "Direct Sales"
    label: "Ship To Primary Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: dir_ship_cust_state {
    type: string
    view_label: "Direct Sales"
    label: "Customer Address Ship To State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }
  #********** Direct Sales group attributes end


  #********** Indirect Sales group attributes start
  dimension: indir_bill_cust_state {
    type: string
    view_label: "Indirect Sales"
    label: "Bill To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: indir_sold_cust_state {
    type: string
    view_label: "Indirect Sales"
    label: "Sold To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: indir_ship_cust_state_prim {
    type: string
    view_label: "Indirect Sales"
    label: "Ship To Primary Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: indir_ship_cust_state {
    type: string
    view_label: "Indirect Sales"
    label: "Customer Address Ship To State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: indir_wholesaler_state {
    type: string
    view_label: "Indirect Sales"
    label: "Wholesaler Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  #********** Indirect Sales group attributes end

  #********** Chargebacks group attributes start
  dimension: chb_bill_cust_state {
    type: string
    view_label: "Chargebacks"
    label: "Bill To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: chb_sold_cust_state {
    type: string
    view_label: "Chargebacks"
    label: "Sold To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: chb_ship_cust_state_prim {
    type: string
    view_label: "Chargebacks"
    label: "Ship To Primary Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: chb_ship_cust_state {
    type: string
    view_label: "Chargebacks"
    label: "Customer Address Ship To State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: chb_wholesaler_state {
    type: string
    view_label: "Chargebacks"
    label: "Wholesaler Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  #********** Chargebacks group attributes end


  #********** Rebates group attributes start
  dimension: rbt_bill_cust_state {
    type: string
    view_label: "Rebates"
    label: "Bill To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: rbt_sold_cust_state {
    type: string
    view_label: "Rebates"
    label: "Sold To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: rbt_ship_cust_state_prim {
    type: string
    view_label: "Rebates"
    label: "Ship To Primary Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: rbt_ship_cust_state {
    type: string
    view_label: "Rebates"
    label: "Customer Address Ship To State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  #********** Rebates group attributes end

  #********** Projected Rebates group attributes start
  dimension: pr_bill_cust_state {
    type: string
    view_label: "Projected Rebates"
    label: "Bill To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: pr_sold_cust_state {
    type: string
    view_label: "Projected Rebates"
    label: "Sold To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: pr_ship_cust_state_prim {
    type: string
    view_label: "Projected Rebates"
    label: "Ship To Primary Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: pr_ship_cust_state {
    type: string
    view_label: "Projected Rebates"
    label: "Customer Address Ship To State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  #********** Projected Rebates group attributes end

  #********** MCO Utilization group attributes start

  dimension: mco_pbm_state {
    type: string
    view_label: "MCO Utilization"
    label: "PBM State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'MCO Utilizations' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: mco_pbm_city {
    type: string
    view_label: "MCO Utilization"
    label: "PBM City"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'MCO Utilizations' THEN ${TABLE}.CITY ELSE NULL END ;;
  }

  #********** MCO Utilization group attributes End

  #********** Custom Sales group attributes start
  dimension: custom_bill_cust_state {
    type: string
    view_label: "Custom Sales"
    label: "Bill To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: custom_sold_cust_state {
    type: string
    view_label: "Custom Sales"
    label: "Sold To Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: custom_ship_cust_state_prim {
    type: string
    view_label: "Custom Sales"
    label: "Ship To Primary Customer Address State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  dimension: custom_ship_cust_state {
    type: string
    view_label: "Custom Sales"
    label: "Customer Address Ship To State"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.STATE_PROV ELSE NULL END ;;
  }

  #********** Custom Sales group attributes end


  #  Transaction Explore attributes End


  #*********************Customer Address Set
  set: cust_addr_set {
    fields: [description,address_type,primary_address,full_address]
  }

  #*********************Validata Field Set
  set: vd_customer_addr_set {
    fields: [trading_partner_street_addr,city,state_prov,trading_partner_postal_code]
  }

  set: tx_bill_to_cust_addr_set {
    fields: [dir_bill_cust_state,indir_bill_cust_state,rbt_bill_cust_state,pr_bill_cust_state,custom_bill_cust_state,chb_bill_cust_state]
  }

  set: tx_sold_to_cust_addr_set {
    fields: [dir_sold_cust_state,indir_sold_cust_state,rbt_sold_cust_state,pr_sold_cust_state,custom_sold_cust_state,chb_sold_cust_state]
  }

  set: tx_ship_to_cust_addr_prim_set {
    fields: [dir_ship_cust_state_prim,indir_ship_cust_state_prim,rbt_ship_cust_state_prim,pr_ship_cust_state_prim,custom_ship_cust_state_prim,
             chb_ship_cust_state_prim]
  }

  set: tx_ship_to_cust_addr_set {
    fields: [dir_ship_cust_state,indir_ship_cust_state,rbt_ship_cust_state,pr_ship_cust_state,custom_ship_cust_state,chb_ship_cust_state]
  }

  set: tx_wholesaler_addr_set {
    fields: [indir_wholesaler_state,chb_wholesaler_state]
  }

}
