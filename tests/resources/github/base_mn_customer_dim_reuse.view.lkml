view: mn_customer_dim_reuse {
  sql_table_name: MN_CUSTOMER_DIM_VW ;;

  dimension: account_size {
    type: string
    sql: ${TABLE}.ACCOUNT_SIZE ;;
  }

  dimension: address {
    type: string
    label: "Address"
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: address_type {
    type: string
    label: "Address Type"
    sql: ${TABLE}.ADDRESS_TYPE ;;
  }

  dimension: city {
    type: string
    label: "City"
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    type: string
    label: "Country"
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: credit_rebill_regexp_criteria {
    type: string
    label: "Credit Rebill Regex Criteria"
    sql: ${TABLE}.CREDIT_REBILL_REGEXP_CRITERIA ;;
  }

  dimension: currency {
    type: string
    label: "Currency"
    sql: ${TABLE}.CURRENCY ;;
  }

  dimension: cust_domain {
    type: string
    label: "Domain"
    sql: ${TABLE}.CUST_DOMAIN ;;
  }

  dimension: customer_name {
    type: string
    label: "Name"
    sql: ${TABLE}.CUSTOMER_NAME ;;
  }

  dimension: customer_num {
    type: string
    label: "ID"
    sql: ${TABLE}.CUSTOMER_NUM ;;
  }

  dimension: customer_wid {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}.CUSTOMER_WID ;;
  }

  dimension: customer_type {
    type: string
    label: "Type"
    sql: ${TABLE}.MEMBER_INFO_TYPE ;;
  }

  dimension_group: date_created {
    type: time
    hidden:  yes
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
    hidden:  yes
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

  dimension: edi_845_enabled {
    type: string
    label: "Is EDI 845 Enabled ?"
    sql: ${TABLE}.EDI_845_ENABLED ;;
  }

  dimension: effective_timezone {
    type: string
    label: "Time Zone"
    sql: ${TABLE}.EFFECTIVE_TIMEZONE ;;
  }

  dimension: expects_cust_flag {
    type: string
    label: "Expects Customer Eligibility on Bid Awards ?"
    sql: ${TABLE}.EXPECTS_CUST_ELIG ;;
  }

  dimension: external_segment {
    type: string
    sql: ${TABLE}.EXTERNAL_SEGMENT ;;
  }

  dimension: is_full_refresh {
    type: string
    label: "Inital/Resend EDI 845 Contains"
    sql: ${TABLE}.IS_FULL_REFRESH ;;
  }

  dimension: locale {
    type: string
    sql: ${TABLE}.LOCALE ;;
  }

  dimension: member_info_type {
    type: string
    hidden: yes
    label: "Customer Type"
    sql: ${TABLE}.MEMBER_INFO_TYPE ;;
  }

  dimension: member_status {
    type: string
    label: "Status"
    sql: ${TABLE}.MEMBER_STATUS ;;
  }

  dimension: non_edi {
    type: string
    label: "Non EDI"
    sql: ${TABLE}.NON_EDI ;;
  }

  dimension: org_id {
    type: string
    label: "Preferred Customer ID"
    sql: ${TABLE}.ORG_ID ;;
  }

  dimension: org_id_type {
    type: string
    label: "Preferred ID Type"
    sql: ${TABLE}.ORG_ID_TYPE ;;
  }

  dimension: plan_id {
    type: string
    label: "Plan ID"
    sql: ${TABLE}.PLAN_ID ;;
  }

  dimension: plan_type {
    type: string
    label: "Plan Type"
    sql: ${TABLE}.PLAN_TYPE ;;
  }

  dimension: pmt_method {
    type: string
    label: "Payment Method"
    sql: ${TABLE}.PMT_METHOD ;;
  }

  dimension: postal_zip {
    type: string
    label: "Postal Zip"
    sql: ${TABLE}.POSTAL_ZIP ;;
  }

  dimension: purchase_method {
    type: string
    label: "Purchase Method"
    sql: ${TABLE}.PURCHASE_METHOD ;;
  }

  dimension: run_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.RUN_ID ;;
  }

  dimension: segmentation_attrubute1 {
    type: string
    label: "Segmentation Attribute 1"
    sql: ${TABLE}.SEG_ATTR1 ;;
  }

  dimension: segmentation_attrubute2 {
    type: string
    label: "Segmentation Attribute 2"
    sql: ${TABLE}.SEG_ATTR2 ;;
  }

  dimension: segmentation_attrubute3 {
    type: string
    label: "Segmentation Attribute 3"
    sql: ${TABLE}.SEG_ATTR3 ;;
  }

  dimension: segmentation_attrubute4 {
    type: string
    label: "Segmentation Attribute 4"
    sql: ${TABLE}.SEG_ATTR4 ;;
  }

  dimension: segmentation_attrubute5 {
    type: string
    label: "Segmentation Attribute 5"
    sql: ${TABLE}.SEG_ATTR5 ;;
  }

  dimension: source_system_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: src_sys_cust_id {
    type: number
    value_format: "0"
    hidden: yes
    sql: ${TABLE}.SRC_SYS_CUST_ID ;;
  }

  dimension_group: src_sys_date_created {
    hidden: yes
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
    sql: ${TABLE}.SRC_SYS_DATE_CREATED ;;
  }

  dimension_group: src_sys_date_updated {
    hidden: yes
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

  dimension: state_province {
    type: string
    label: "State Province"
    sql: ${TABLE}.STATE_PROV ;;
  }

  dimension_group: status_eff_end {
    label: "End"
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
    sql: ${TABLE}.STATUS_EFF_END_DATE ;;
  }

  dimension_group: status_eff_start {
    label: "Start"
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
    sql: ${TABLE}.STATUS_EFF_START_DATE ;;
  }

  dimension: src_sys_mgr_id {
    type: number
    sql: ${TABLE}.SRC_SYS_MGR_ID ;;
  }

  dimension: cust_desc {
    type: string
    hidden: yes
    sql: ${TABLE}.CUSTOMER_DESC ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [customer_name]
  }

  #*************Plan Aliasing
  dimension: plan_plan_type {
    type: string
    label: "Type"
    sql: ${plan_type} ;;
  }

  dimension: plan_num {
    type: string
    label: "ID"
    sql: ${customer_num} ;;
  }

  dimension: plan_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

dimension: plan_member_info_type {
  type: string
  label: "Member Info Type"
  sql: ${member_info_type} ;;
}

  #*************PBM Aliasing
  dimension: pbm_member_info_type {
    type: string
    label: "Type"
    sql: ${member_info_type} ;;
  }

  dimension: pbm_num {
    type: string
    label: "ID"
    sql: ${customer_num} ;;
  }

  dimension: pbm_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

  #*************BOB Aliasing
  dimension: bob_member_info_type {
    type: string
    label: "Type"
    sql: ${member_info_type} ;;
  }

  dimension: bob_num {
    type: string
    label: "ID"
    sql: ${customer_num} ;;
  }

  dimension: bob_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

  dimension: payment_recipient {
    type: string
    label: "Payment Recipient"
    sql: ${customer_name} ;;
  }

  dimension: mcd_customer_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

  dimension: mcd_customer_num {
    type: string
    label: "Number"
    sql: ${customer_num} ;;
  }

# Plan Customer aliasing ########################
  dimension: plan_customer_num {
    type: string
    label: "ID"
    sql: ${customer_num} ;;
  }

  dimension: plan_customer_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

#*************Master Data Customers Aliasing
  dimension: md_member_info_type {
    type: string
    label: "Customer Type"
    sql: ${member_info_type} ;;
  }

  dimension: md_customer_num {
    type: string
    label: "Customer ID"
    sql: ${customer_num} ;;
  }

  dimension: md_customer_name {
    type: string
    label: "Customer Name"
    sql: ${customer_name} ;;
  }

  dimension: md_cust_domain {
    type: string
    label: "Customer Domain"
    sql: ${cust_domain} ;;
  }

  dimension: md_purchase_method {
    type: string
    label: "Purchase Method"
    sql: ${purchase_method} ;;
  }

  dimension: md_currency {
    type: string
    label: "Currency"
    sql: ${currency} ;;
  }

#*************Master Data Customers PBM Plan Aliasing
  dimension: pp_customer_name {
    type: string
    label: "PBM Plan Name"
    sql: ${customer_name} ;;
  }

  dimension: pp_customer_num {
    type: string
    label: "Internal PBM Plan ID"
    sql: ${customer_num} ;;
  }

  dimension: pp_plan_id {
    type: string
    label: "PBM Plan ID"
    sql: ${plan_id} ;;
  }

#*************Master Data Customers Members Aliasing
  dimension: md_mem_customer_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

  dimension: md_mem_org_id {
    type: string
    label: "ID"
    sql: ${org_id} ;;
  }

  dimension: md_mem_member_info_type {
    type: string
    label: "Type"
    sql: ${member_info_type} ;;
  }

#*************Master Data Customer Status Aliasing
  dimension: md_member_status {
    type: string
    label: "Status"
    view_label: "Status"
    sql: ${member_status} ;;
  }

  dimension_group: md_status_eff_start {
    label: "Start"
    view_label: "Status"
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
    sql: ${TABLE}.STATUS_EFF_START_DATE ;;
  }

    dimension_group: md_status_eff_end {
      label: "End"
      view_label: "Status"
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
      sql: ${TABLE}.STATUS_EFF_END_DATE ;;
    }

#*************Membership Data Customer Aliasing
  dimension: ms_customer_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

  dimension: ms_org_id {
    type: string
    label: "ID"
    sql: ${org_id} ;;
  }

  dimension: ms_member_info_type {
    type: string
    label: "Type"
    sql: ${member_info_type} ;;
  }

  dimension: ms_address {
    type: string
    label: "Address"
    sql: ${address} ;;
  }

  dimension: ms_state_province {
    type: string
    label: "State"
    sql: ${state_province} ;;
  }

  dimension: ms_postal_zip {
    type: string
    label: "Zip"
    sql: ${postal_zip} ;;
  }

  measure: mscount {
    label: "Count"
    type: count_distinct
    sql: ${customer_wid} ;;
  }

#*************Members Data Customer Aliasing
  dimension: m_customer_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

  dimension: m_org_id {
    type: string
    label: "ID"
    sql: ${org_id} ;;
  }

  dimension: m_member_info_type {
    type: string
    label: "Type"
    sql: CASE WHEN ${m_plan_id} is null then ${member_info_type} else ${plan_type} end ;;
  }

  dimension: m_plan_id {
    type: string
    label: "External Plan ID"
    sql: ${TABLE}.PLAN_ID ;;
  }

  dimension: m_pc_customer_name {
    type: string
    label: "Plan Customer ID (PBM Only)"
    sql: ${customer_name} ;;
  }

  dimension: m_pc_customer_num {
    type: string
    label: "Plan Customer Name (PBM Only)"
    sql: ${customer_num} ;;
  }

  measure: mcount {
    label: "Count"
    type: count_distinct
    sql: ${customer_wid} ;;
  }

# Third Party Name in Capital Contracts
  dimension: cc_third_party_name {
    type: string
    label: "Third Party Name"
    sql: ${customer_name} ;;
  }

#*************Validata Customer Aliasing
  dimension: trading_partner_key {
    type: number
    value_format: "0"
    label: "Key"
    sql: ${src_sys_cust_id} ;;
  }

  dimension: trading_partner_name {
    type: string
    label: "Name"
    sql: ${customer_name} ;;
  }

  dimension: trading_partner_type {
    type: string
    label: "Type"
    sql: ${plan_type} ;;
  }

  dimension: trading_partner_primary_id {
    type: string
    label: "Primary ID"
    sql: DECODE (${member_info_type}, 'PBM', ${customer_num}, NVL ( ${plan_id}, ${src_sys_cust_id})) ;;
  }

  dimension: trad_partner_prim_id_type {
    type: string
    label: "Primary ID Type"
    sql: DECODE ( ${src_sys_mgr_id}, 50108, DECODE ( ${member_info_type}, 'PBM', 'PBM', 'Sponsor', 'Plan Sponsor', null ), 50162, 'Plan', NULL ) ;;
  }
#   Validata Contract Entity

  dimension: ctrt_ent {
    type: string
    label: "Entity"
    sql: ${customer_num} ;;
  }

  dimension: mds_num {
    type: number
    hidden: yes
    sql: ${TABLE}.MDS_NUM ;;
  }

  dimension: tx_item_plan_key {
    type: number
    value_format: "0"
    label: "Plan Key"
    view_label: "Transaction Items"
    sql: ${src_sys_cust_id} ;;
  }

  dimension: rev_tx_itm_plan_key {
    type: number
    value_format: "0"
    label: "Rev Plan Key"
    view_label: "Reversals"
    sql: ${src_sys_cust_id} ;;
  }

  dimension: dup_tx_itm_plan_key {
    type: number
    value_format: "0"
    label: "Plan Key"
    view_label: "Items in the Duplicate Set"
    sql: ${src_sys_cust_id} ;;
  }

# Alias column name for Transaction-CG Data Duplicates
  dimension: file_cgd_dup_source_key {
    type: number
    value_format: "0"
    label: "Source Key"
    sql: ${src_sys_cust_id} ;;
  }

# *** Alias naming for Transaction-CG Data File History BEGIN
  dimension: file_cgd_file_hist_source_key {
    type: number
    value_format: "0"
    label: "Source Key"
    sql: ${src_sys_cust_id} ;;
  }
# *** Alias naming for Transaction-CG Data File History ENDS

# *** Alias naming for Transaction-CG Invoice File History BEGIN

  dimension: cgi_fh_source_key {
    type: number
    value_format: "0"
    label: "Source Key"
    sql: ${src_sys_cust_id} ;;
  }

# *** Alias naming for Transaction-CG Invoice File History ENDS

#  Transaction Explore Customer Attributes Start

# *************** Direct Sales group start

  dimension: dir_bill_cust_num {
    type: string
    view_label: "Direct Sales"
    label: "Bill To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: dir_bill_cust_name {
    type: string
    view_label: "Direct Sales"
    label: "Bill To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: dir_bill_cust_id {
    type: number
    value_format: "0"
    view_label: "Direct Sales"
    label: "Bill To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: dir_sold_cust_num {
    type: string
    view_label: "Direct Sales"
    label: "Sold To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: dir_sold_cust_name {
    type: string
    view_label: "Direct Sales"
    label: "Sold To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: dir_sold_cust_id {
    type: number
    value_format: "0"
    view_label: "Direct Sales"
    label: "Sold To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: dir_gpo_num {
    type: string
    view_label: "Direct Sales"
    label: "Contract Group Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: dir_gpo_name {
    type: string
    view_label: "Direct Sales"
    label: "Contract Group Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: dir_idn_num {
    type: string
    view_label: "Direct Sales"
    label: "Contract Independent Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: dir_idn_name {
    type: string
    view_label: "Direct Sales"
    label: "Contract Independent Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }


  dimension: dir_cust_domain {
    type: string
    view_label: "Direct Sales"
    label: "Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: dir_cust_type {
    type: string
    view_label: "Direct Sales"
    label: "Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: dir_cust_num {
    type: string
    view_label: "Direct Sales"
    label: "Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: dir_cust_name {
    type: string
    view_label: "Direct Sales"
    label: "Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: dir_ctrt_cust_domain {
    type: string
    view_label: "Direct Sales"
    label: "Contract Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: dir_ctrt_cust_type {
    type: string
    view_label: "Direct Sales"
    label: "Contract Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: dir_cust_desc {
    type: string
    view_label: "Direct Sales"
    label: "Customer Description"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Direct' THEN ${TABLE}.CUSTOMER_DESC ELSE NULL END ;;
  }

  # *************** Direct Sales group end

  # *************** Indirect Sales group start

  dimension: indir_bill_cust_num {
    type: string
    view_label: "Indirect Sales"
    label: "Bill To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: indir_bill_cust_name {
    type: string
    view_label: "Indirect Sales"
    label: "Bill To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: indir_bill_cust_id {
    type: number
    value_format: "0"
    view_label: "Indirect Sales"
    label: "Bill To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: indir_sold_cust_num {
    type: string
    view_label: "Indirect Sales"
    label: "Sold To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: indir_sold_cust_name {
    type: string
    view_label: "Indirect Sales"
    label: "Sold To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: indir_sold_cust_id {
    type: number
    value_format: "0"
    view_label: "Indirect Sales"
    label: "Sold To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: indir_gpo_num {
    type: string
    view_label: "Indirect Sales"
    label: "Contract Group Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: indir_gpo_name {
    type: string
    view_label: "Indirect Sales"
    label: "Contract Group Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: indir_idn_num {
    type: string
    view_label: "Indirect Sales"
    label: "Contract Independent Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: indir_idn_name {
    type: string
    view_label: "Indirect Sales"
    label: "Contract Independent Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }


  dimension: indir_cust_domain {
    type: string
    view_label: "Indirect Sales"
    label: "Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: indir_cust_type {
    type: string
    view_label: "Indirect Sales"
    label: "Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: indir_cust_num {
    type: string
    view_label: "Indirect Sales"
    label: "Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: indir_cust_name {
    type: string
    view_label: "Indirect Sales"
    label: "Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: indir_ctrt_cust_domain {
    type: string
    view_label: "Indirect Sales"
    label: "Contract Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: indir_ctrt_cust_type {
    type: string
    view_label: "Indirect Sales"
    label: "Contract Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: indir_cust_desc {
    type: string
    view_label: "Indirect Sales"
    label: "Customer Description"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_DESC ELSE NULL END ;;
  }

  dimension: indir_wholesaler_num {
    type: string
    view_label: "Indirect Sales"
    label: "Wholesaler ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: indir_wholesaler_name {
    type: string
    view_label: "Indirect Sales"
    label: "Wholesaler Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.tracing_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  # *************** Indirect Sales group end

  # *************** Chargebacks group start

  dimension: chb_bill_cust_num {
    type: string
    view_label: "Chargebacks"
    label: "Bill To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: chb_bill_cust_name {
    type: string
    view_label: "Chargebacks"
    label: "Bill To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: chb_bill_cust_id {
    type: number
    value_format: "0"
    view_label: "Chargebacks"
    label: "Bill To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: chb_sold_cust_num {
    type: string
    view_label: "Chargebacks"
    label: "Sold To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: chb_sold_cust_name {
    type: string
    view_label: "Chargebacks"
    label: "Sold To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: chb_sold_cust_id {
    type: number
    value_format: "0"
    view_label: "Chargebacks"
    label: "Sold To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: chb_gpo_num {
    type: string
    view_label: "Chargebacks"
    label: "Contract Group Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: chb_gpo_name {
    type: string
    view_label: "Chargebacks"
    label: "Contract Group Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: chb_idn_num {
    type: string
    view_label: "Chargebacks"
    label: "Contract Independent Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: chb_idn_name {
    type: string
    view_label: "Chargebacks"
    label: "Contract Independent Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }


  dimension: chb_cust_domain {
    type: string
    view_label: "Chargebacks"
    label: "Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: chb_cust_type {
    type: string
    view_label: "Chargebacks"
    label: "Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: chb_cust_num {
    type: string
    view_label: "Chargebacks"
    label: "Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: chb_cust_name {
    type: string
    view_label: "Chargebacks"
    label: "Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: chb_ctrt_cust_domain {
    type: string
    view_label: "Chargebacks"
    label: "Contract Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: chb_ctrt_cust_type {
    type: string
    view_label: "Chargebacks"
    label: "Contract Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: chb_cust_desc {
    type: string
    view_label: "Chargebacks"
    label: "Customer Description"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_DESC ELSE NULL END ;;
  }

  dimension: chb_wholesaler_num {
    type: string
    view_label: "Chargebacks"
    label: "Wholesaler ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: chb_wholesaler_name {
    type: string
    view_label: "Chargebacks"
    label: "Wholesaler Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.chargeback_flag} = 'Y' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  # *************** Chargebacks group end



  # *************** Rebats group start

  dimension: rbt_bill_cust_num {
    type: string
    view_label: "Rebates"
    label: "Bill To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: rbt_bill_cust_name {
    type: string
    view_label: "Rebates"
    label: "Bill To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: rbt_bill_cust_id {
    type: number
    value_format: "0"
    view_label: "Rebates"
    label: "Bill To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: rbt_sold_cust_num {
    type: string
    view_label: "Rebates"
    label: "Sold To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: rbt_sold_cust_name {
    type: string
    view_label: "Rebates"
    label: "Sold To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: rbt_sold_cust_id {
    type: number
    value_format: "0"
    view_label: "Rebates"
    label: "Sold To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: rbt_gpo_num {
    type: string
    view_label: "Rebates"
    label: "Contract Group Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: rbt_gpo_name {
    type: string
    view_label: "Rebates"
    label: "Contract Group Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: rbt_idn_num {
    type: string
    view_label: "Rebates"
    label: "Contract Independent Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: rbt_idn_name {
    type: string
    view_label: "Rebates"
    label: "Contract Independent Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }


  dimension: rbt_cust_domain {
    type: string
    view_label: "Rebates"
    label: "Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: rbt_cust_type {
    type: string
    view_label: "Rebates"
    label: "Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: rbt_cust_num {
    type: string
    view_label: "Rebates"
    label: "Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: rbt_cust_name {
    type: string
    view_label: "Rebates"
    label: "Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: rbt_ctrt_cust_domain {
    type: string
    view_label: "Rebates"
    label: "Contract Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: rbt_ctrt_cust_type {
    type: string
    view_label: "Rebates"
    label: "Contract Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: rbt_cust_desc {
    type: string
    view_label: "Rebates"
    label: "Customer Description"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_DESC ELSE NULL END ;;
  }

  dimension: rbt_wholesaler_num {
    type: string
    view_label: "Rebates"
    label: "Wholesaler ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: rbt_wholesaler_name {
    type: string
    view_label: "Rebates"
    label: "Wholesaler Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: rbt_plan_num {
    type: string
    view_label: "Rebates"
    label: "Plan Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: rbt_plan_name {
    type: string
    view_label: "Rebates"
    label: "Plan"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Paid Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  # *************** Rebates group end

  # *************** Projected Rebats group start

  dimension: pr_bill_cust_num {
    type: string
    view_label: "Projected Rebates"
    label: "Bill To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: pr_bill_cust_name {
    type: string
    view_label: "Projected Rebates"
    label: "Bill To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: pr_bill_cust_id {
    type: number
    value_format: "0"
    view_label: "Projected Rebates"
    label: "Bill To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: pr_sold_cust_num {
    type: string
    view_label: "Projected Rebates"
    label: "Sold To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: pr_sold_cust_name {
    type: string
    view_label: "Projected Rebates"
    label: "Sold To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: pr_sold_cust_id {
    type: number
    value_format: "0"
    view_label: "Projected Rebates"
    label: "Sold To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: pr_gpo_num {
    type: string
    view_label: "Projected Rebates"
    label: "Contract Group Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: pr_gpo_name {
    type: string
    view_label: "Projected Rebates"
    label: "Contract Group Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: pr_idn_num {
    type: string
    view_label: "Projected Rebates"
    label: "Contract Independent Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: pr_idn_name {
    type: string
    view_label: "Projected Rebates"
    label: "Contract Independent Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }


  dimension: pr_cust_domain {
    type: string
    view_label: "Projected Rebates"
    label: "Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: pr_cust_type {
    type: string
    view_label: "Projected Rebates"
    label: "Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: pr_cust_num {
    type: string
    view_label: "Projected Rebates"
    label: "Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: pr_cust_name {
    type: string
    view_label: "Projected Rebates"
    label: "Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: pr_ctrt_cust_domain {
    type: string
    view_label: "Projected Rebates"
    label: "Contract Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: pr_ctrt_cust_type {
    type: string
    view_label: "Projected Rebates"
    label: "Contract Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: pr_cust_desc {
    type: string
    view_label: "Projected Rebates"
    label: "Customer Description"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_DESC ELSE NULL END ;;
  }

  dimension: pr_wholesaler_num {
    type: string
    view_label: "Projected Rebates"
    label: "Wholesaler ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: pr_wholesaler_name {
    type: string
    view_label: "Projected Rebates"
    label: "Wholesaler Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: pr_plan_num {
    type: string
    view_label: "Projected Rebates"
    label: "Plan Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: pr_plan_name {
    type: string
    view_label: "Projected Rebates"
    label: "Plan"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Projected Rebates' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  # *************** Projected Rebates group end

  # *************** Custom Sales group attributes start


  dimension: custom_bill_cust_num {
    type: string
    view_label: "Custom Sales"
    label: "Bill To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: custom_bill_cust_name {
    type: string
    view_label: "Custom Sales"
    label: "Bill To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: custom_bill_cust_id {
    type: number
    value_format: "0"
    view_label: "Custom Sales"
    label: "Bill To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: custom_sold_cust_num {
    type: string
    view_label: "Custom Sales"
    label: "Sold To Customer Number"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: custom_sold_cust_name {
    type: string
    view_label: "Custom Sales"
    label: "Sold To Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: custom_sold_cust_id {
    type: number
    value_format: "0"
    view_label: "Custom Sales"
    label: "Sold To Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${src_sys_cust_id} ELSE NULL END ;;
  }

  dimension: custom_gpo_num {
    type: string
    view_label: "Custom Sales"
    label: "Contract Group Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: custom_gpo_name {
    type: string
    view_label: "Custom Sales"
    label: "Contract Group Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: custom_idn_num {
    type: string
    view_label: "Custom Sales"
    label: "Contract Independent Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: custom_idn_name {
    type: string
    view_label: "Custom Sales"
    label: "Contract Independent Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }


  dimension: custom_cust_domain {
    type: string
    view_label: "Custom Sales"
    label: "Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: custom_cust_type {
    type: string
    view_label: "Custom Sales"
    label: "Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: custom_cust_num {
    type: string
    view_label: "Custom Sales"
    label: "Customer ID"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: custom_cust_name {
    type: string
    view_label: "Custom Sales"
    label: "Customer Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: custom_ctrt_cust_domain {
    type: string
    view_label: "Custom Sales"
    label: "Contract Customer Domain"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUST_DOMAIN ELSE NULL END ;;
  }

  dimension: custom_ctrt_cust_type {
    type: string
    view_label: "Custom Sales"
    label: "Contract Customer Type"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.MEMBER_INFO_TYPE ELSE NULL END ;;
  }

  dimension: custom_cust_desc {
    type: string
    view_label: "Custom Sales"
    label: "Customer Description"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'Custom' THEN ${TABLE}.CUSTOMER_DESC ELSE NULL END ;;
  }


  # *************** Custom Sales group attributes end



  # *************** MCO Utilizations Rebats group start

  dimension: mco_pbm_num {
    type: string
    view_label: "MCO Utilization"
    label: "PBM ID Num"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'MCO Utilizations' THEN ${TABLE}.CUSTOMER_NUM ELSE NULL END ;;
  }

  dimension: mco_pbm_name {
    type: string
    view_label: "MCO Utilization"
    label: "PBM Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'MCO Utilizations' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

  dimension: mco_plan_mem_name {
    type: string
    view_label: "MCO Utilization"
    label: "Plan Member Name"
    sql: CASE WHEN ${mn_lkr_gp_comb_sales_fact.sale_type} = 'MCO Utilizations' THEN ${TABLE}.CUSTOMER_NAME ELSE NULL END ;;
  }

#  Transaction Explore Customer Attributes End

#*************Workbook Results explore NPP Customer dimensions Start

  dimension: gp_npp_cust_name {
    type: string
    label: "Customer"
    sql: ${customer_name} ;;
  }

  dimension: gp_npp_cust_num {
    type: string
    label: "Customer ID"
    sql: ${customer_num} ;;
  }

#*************Workbook Results explore NPP Customer dimensions End


#*************Customer Field Set
  set: customer {
    fields: [account_size,address,address_type,city,country,credit_rebill_regexp_criteria,currency,
      cust_domain,customer_name,customer_num,customer_type,external_segment,member_info_type,
      member_status,org_id,org_id_type,plan_type,pmt_method,postal_zip,purchase_method,segmentation_attrubute1,
      segmentation_attrubute2,segmentation_attrubute3,segmentation_attrubute4,segmentation_attrubute5,
      state_province,status_eff_end_date,status_eff_end_month,status_eff_end_quarter,status_eff_end_year,
      status_eff_start_date,status_eff_start_month,status_eff_start_quarter,status_eff_start_year]
  }

#*************PBM Field Set
  set: pbm_set {
    fields: [pbm_member_info_type,pbm_num,pbm_name]
  }

#*************Plan Field Set
  set: plan_set {
    fields: [plan_plan_type,plan_num,plan_name,plan_member_info_type]
  }

#*************BOB Field Set
  set: bob_set {
    fields: [bob_member_info_type,bob_num,bob_name]
  }

#*************Medicaid Payment Recipient Name Field Set
  set: payment_recipient_name_set {
    fields: [payment_recipient]
  }

  set: governmentpayee_set {
    fields: [mcd_customer_name,mcd_customer_num,address,city,state_province,postal_zip,country]
  }

#*************Master Data Customer Field Set
  set: md_customer_set {
    fields: [md_customer_num,md_customer_name,md_member_info_type,md_cust_domain,md_purchase_method,md_currency,
      locale,effective_timezone,edi_845_enabled,non_edi,is_full_refresh,expects_cust_flag,mscount]
  }

#*************Master Data PBM Plan Field Set
  set: md_pbm_plan_set {
    fields: [pp_customer_name,pp_customer_num,pp_plan_id]
  }

#*************Master Data Members Field Set
  set: md_members_set {
    fields: [md_mem_customer_name,md_mem_org_id,md_mem_member_info_type,mcount]
  }

#*************Master Data Customer Status Set
  set: md_customer_status_set {
    fields: [md_member_status,md_status_eff_start_raw,md_status_eff_start_time,md_status_eff_start_date,md_status_eff_start_week_of_year,md_status_eff_start_month,
      md_status_eff_start_quarter,md_status_eff_start_year,md_status_eff_end_raw,md_status_eff_end_time,md_status_eff_end_date,md_status_eff_end_week_of_year,
      md_status_eff_end_month,md_status_eff_end_quarter,md_status_eff_end_year]
  }

#*************Plan Field Set
  set: plan_customer_set {
    fields: [plan_customer_num,plan_customer_name]
  }

#*************Membership Field Set

  set: membership_set {
    fields: [ms_customer_name,ms_org_id,ms_member_info_type,ms_address,city,ms_state_province,ms_postal_zip,country,mscount]
  }

#*************Members Field Set
  set: members_set {
    fields: [m_customer_name,m_org_id,m_member_info_type,m_plan_id,mcount]
  }

  set: members_pc_set {
    fields: [m_pc_customer_name,m_pc_customer_num]
  }

#*************Third Party Name in Capital Contracts
  set: third_party_name_set {
    fields: [cc_third_party_name]
  }

#*************Validata Field Set
  set: vd_customer_set {
    fields: [trading_partner_key,trading_partner_name,trading_partner_type,status_eff_start_raw,status_eff_start_time,status_eff_start_date,
      status_eff_start_week_of_year,status_eff_start_month,status_eff_start_quarter,status_eff_start_year,status_eff_end_raw,
      status_eff_end_time,status_eff_end_date,status_eff_end_week_of_year,status_eff_end_month,status_eff_end_quarter,
      status_eff_end_year,trading_partner_primary_id,trad_partner_prim_id_type]
  }

  set: vd_tx_det_cust_set {
    fields: [trading_partner_key,trading_partner_name,trading_partner_type,status_eff_start_raw,status_eff_start_time,status_eff_start_date,
      status_eff_start_week_of_year,status_eff_start_month,status_eff_start_quarter,status_eff_start_year,status_eff_end_raw,
      status_eff_end_time,status_eff_end_date,status_eff_end_week_of_year,status_eff_end_month,status_eff_end_quarter,
      status_eff_end_year,trading_partner_primary_id,trad_partner_prim_id_type,tx_item_plan_key]
  }

  set: vd_cgd_tx_det_cust_set {
    fields: [trading_partner_key,trading_partner_name,trading_partner_type,status_eff_start_raw,status_eff_start_time,status_eff_start_date,
      status_eff_start_week_of_year,status_eff_start_month,status_eff_start_quarter,status_eff_start_year,status_eff_end_raw,
      status_eff_end_time,status_eff_end_date,status_eff_end_week_of_year,status_eff_end_month,status_eff_end_quarter,
      status_eff_end_year,trading_partner_primary_id,trad_partner_prim_id_type]
  }

  set: vd_rev_cust_set {
    fields: [trading_partner_key,trading_partner_name,trading_partner_type,status_eff_start_raw,status_eff_start_time,status_eff_start_date,
      status_eff_start_week_of_year,status_eff_start_month,status_eff_start_quarter,status_eff_start_year,status_eff_end_raw,
      status_eff_end_time,status_eff_end_date,status_eff_end_week_of_year,status_eff_end_month,status_eff_end_quarter,
      status_eff_end_year,trading_partner_primary_id,trad_partner_prim_id_type,rev_tx_itm_plan_key]
  }

  set: vd_dup_cust_set {
    fields: [trading_partner_key,trading_partner_name,trading_partner_type,status_eff_start_raw,status_eff_start_time,status_eff_start_date,
      status_eff_start_week_of_year,status_eff_start_month,status_eff_start_quarter,status_eff_start_year,status_eff_end_raw,
      status_eff_end_time,status_eff_end_date,status_eff_end_week_of_year,status_eff_end_month,status_eff_end_quarter,
      status_eff_end_year,trading_partner_primary_id,trad_partner_prim_id_type,dup_tx_itm_plan_key]
  }

  set: vd_cgd_dup_cust_set {
    fields: [trading_partner_key,trading_partner_name,trading_partner_type,status_eff_start_raw,status_eff_start_time,status_eff_start_date,
      status_eff_start_week_of_year,status_eff_start_month,status_eff_start_quarter,status_eff_start_year,status_eff_end_raw,
      status_eff_end_time,status_eff_end_date,status_eff_end_week_of_year,status_eff_end_month,status_eff_end_quarter,
      status_eff_end_year,trading_partner_primary_id,trad_partner_prim_id_type]
  }

  set: vd_cgd_dup_file_dsk{
    fields: [file_cgd_dup_source_key]
  }

  set: vd_ctrt_entity_set {
    fields: [ctrt_ent]
  }

  set: vd_cgd_file_hist_fsk {
    fields: [file_cgd_file_hist_source_key]
  }

  set: vd_cgi_fh_src_set {
    fields: [cgi_fh_source_key]
  }

# **********  Transaction Data Explore Sets
  set: tx_bill_to_cust_set {
    fields: [dir_bill_cust_num,dir_bill_cust_id,dir_bill_cust_name,indir_bill_cust_num,indir_bill_cust_id,indir_bill_cust_name,
             rbt_bill_cust_num,rbt_bill_cust_name,rbt_bill_cust_id,pr_bill_cust_num,pr_bill_cust_name,pr_bill_cust_id,
             custom_bill_cust_num,custom_bill_cust_name,custom_bill_cust_id,chb_bill_cust_num,chb_bill_cust_id,chb_bill_cust_name]
  }

  set: tx_sold_to_cust_set {
    fields: [dir_sold_cust_num,dir_sold_cust_id,dir_sold_cust_name,indir_sold_cust_num,indir_sold_cust_id,indir_sold_cust_name,
             rbt_sold_cust_num,rbt_sold_cust_name,rbt_sold_cust_id,pr_sold_cust_num,pr_sold_cust_name,pr_sold_cust_id,
             custom_sold_cust_num,custom_sold_cust_name,custom_sold_cust_id,chb_sold_cust_num,chb_sold_cust_id,chb_sold_cust_name]
  }

  set: tx_gpo_cust_set {
    fields: [dir_gpo_num,dir_gpo_name,indir_gpo_num,indir_gpo_name,rbt_gpo_num,rbt_gpo_name,pr_gpo_num,pr_gpo_name,
             custom_gpo_num,custom_gpo_name,chb_gpo_num,chb_gpo_name]
  }

  set: tx_idn_cust_set {
    fields: [dir_idn_num,dir_idn_name,indir_idn_num,indir_idn_name,rbt_idn_num,rbt_idn_name,pr_idn_num,pr_idn_name,
             custom_idn_num,custom_idn_name,chb_idn_num,chb_idn_name]
  }

  set: tx_cust_det_set {
    fields: [dir_cust_domain,dir_cust_type,dir_cust_num,dir_cust_name,dir_cust_desc,
             indir_cust_domain,indir_cust_type,indir_cust_num,indir_cust_name,indir_cust_desc,
             rbt_cust_domain,rbt_cust_type,rbt_cust_num,rbt_cust_name,rbt_cust_desc,
             pr_cust_domain,pr_cust_type,pr_cust_num,pr_cust_name,pr_cust_desc,mco_pbm_num,mco_pbm_name,
             custom_cust_domain,custom_cust_type,custom_cust_num,custom_cust_name,custom_cust_desc,
             chb_cust_domain,chb_cust_type,chb_cust_num,chb_cust_name,chb_cust_desc]
  }

  set: tx_ctrt_cust_set {
    fields: [dir_ctrt_cust_domain,dir_ctrt_cust_type,indir_ctrt_cust_domain,indir_ctrt_cust_type,rbt_ctrt_cust_domain,rbt_ctrt_cust_type,
             pr_ctrt_cust_domain,pr_ctrt_cust_type,custom_ctrt_cust_type,custom_ctrt_cust_domain,chb_ctrt_cust_domain,chb_ctrt_cust_type]
  }

  set: tx_wholesaler_det_set {
    fields: [indir_wholesaler_num,indir_wholesaler_name,chb_wholesaler_num,chb_wholesaler_name]
  }

  set: tx_plan_det_set {
    fields: [rbt_plan_name,rbt_plan_num,pr_plan_num,pr_plan_name]
  }

# ********* Workbook results explore set
  set: gp_npp_cust_set {
    fields: [gp_npp_cust_name,gp_npp_cust_num]
  }



}
