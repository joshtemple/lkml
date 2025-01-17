view: mn_lkr_gp_comb_sales_fact {

    sql_table_name: MN_LKR_GP_COMB_SALE_FACT_VW ;;

  dimension: adm_fee_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.ADM_FEE_AMT ;;
  }

  dimension: approved_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.APPROVED_DATE_WID ;;
  }

  dimension: ba_ref_num {
    type: string
    hidden: yes
    sql: ${TABLE}.BA_REF_NUM ;;
  }

  dimension: base_price {
    type: number
    hidden: yes
    sql: ${TABLE}.BASE_PRICE_BASE ;;
  }


  dimension: rbt_pmt_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.REBATE_PAYMENT_AMT_BASE ;;
  }

  dimension: basic_rbt_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.BASIC_RBT_AMT ;;
  }

  dimension: bill_to_customer_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.BILL_TO_CUSTOMER_WID ;;
  }

  dimension: plan_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PLAN_WID ;;
  }

  dimension: mco_submission_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.MCO_SUBMISSION_WID ;;
  }

  dimension: rebate_prog_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.REBATE_PROG_WID ;;
  }

  dimension: rebate_type_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.REBATE_TYPE_WID ;;
  }

  dimension: branch_distr_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.BRANCH_DISTR_WID ;;
  }

  dimension: chargeback_flag {
    type: string
    hidden: yes
    sql: ${TABLE}.CHARGEBACK_FLAG ;;
  }

  dimension: tracing_flag {
    type: string
    hidden: yes
    sql: ${TABLE}.TRACING_FLAG ;;
  }

  dimension: chgbk_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.CHGBK_AMT ;;
  }

  dimension_group: chgbk_close_date {
    type: time
    hidden: yes
    sql: ${TABLE}.CHGBK_CLOSE_DATE ;;
  }

  dimension_group: external_process_date {
    type: time
    hidden: yes
    sql: ${TABLE}.EXTERNAL_PROCESS_DATE ;;
  }

  dimension_group: external_approved_date {
    type: time
    hidden: yes
    sql: ${TABLE}.EXTERNAL_APPROVED_DATE ;;
  }

  dimension_group: external_request_date {
    type: time
    hidden: yes
    sql: ${TABLE}.EXTERNAL_REQUEST_DATE ;;
  }

  dimension_group: external_tx_date {
    type: time
    hidden: yes
    sql: ${TABLE}.EXTERNAL_TRANSACTION_DATE ;;
  }

  dimension: chgbk_close_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CHGBK_CLOSE_DATE_WID ;;
  }

  dimension: close_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CLOSE_DATE_WID ;;
  }

  dimension: comments {
    type: string
    hidden: yes
    sql: ${TABLE}.COMMENTS ;;
  }

  dimension: contract_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.CONTRACT_AMT_BASE ;;
  }

  dimension: contract_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CONTRACT_WID ;;
  }

  dimension: cot_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.COT_WID ;;
  }

  dimension: custom_type1_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOM_TYPE1_WID ;;
  }

  dimension: custom_type2_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOM_TYPE2_WID ;;
  }

  dimension: custom_type3_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOM_TYPE3_WID ;;
  }

  dimension: customer_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOMER_WID ;;
  }

  dimension: deal_doc_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.DEAL_DOC_WID ;;
  }

  dimension: dist_srvs_fee_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.DIST_SRVS_FEE_AMT ;;
  }

  dimension: distr_cost_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.DISTR_COST_AMT_BASE ;;
  }

  dimension: distr_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.DISTR_WID ;;
  }

  dimension: exchange_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.EXCHANGE_RATE ;;
  }

  dimension: external_contract_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.EXTERNAL_CONTRACT_AMT ;;
  }

  dimension: external_contract_id {
    type: string
    hidden: yes
    sql: ${TABLE}.EXTERNAL_CONTRACT_ID ;;
  }

  dimension: external_contract_qty {
    type: number
    hidden: yes
    sql: ${TABLE}.EXTERNAL_CONTRACT_QTY ;;
  }

  dimension: external_inv_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.EXTERNAL_INV_AMT_BASE ;;
  }

  dimension: external_line_ref_id {
    type: string
    hidden: yes
    sql: ${TABLE}.EXTERNAL_LINE_REF_ID ;;
  }

  dimension: external_line_type {
    type: string
    hidden: yes
    sql: ${TABLE}.EXTERNAL_LINE_TYPE ;;
  }

  dimension_group: external_paid_date {
    type: time
    hidden: yes
    sql: ${TABLE}.EXTERNAL_PAID_DATE ;;
  }

  dimension: fee_for_srvs_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.FEE_FOR_SRVS_AMT ;;
  }

  dimension: gpo_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.GPO_WID ;;
  }

  dimension: idn_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.IDN_WID ;;
  }

  dimension: internal_line_id {
    type: string
    hidden: yes
    sql: ${TABLE}.INTERNAL_LINE_ID ;;
  }

  dimension: inv_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.INV_AMT_BASE ;;
  }

  dimension: inv_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.INV_DATE_WID ;;
  }

  dimension_group: inv_date {
    type: time
    hidden: yes
    sql: ${TABLE}.INV_DATE ;;
  }

  dimension: inv_qty {
    type: number
    hidden: yes
    sql: ${TABLE}.INV_QTY ;;
  }

  dimension: inv_uom {
    type: string
    hidden: yes
    sql: ${TABLE}.INV_UOM ;;
  }

  dimension: ir_rbt_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.IR_RBT_AMT ;;
  }

  dimension: lifecycle_status {
    type: number
    hidden: yes
    sql: ${TABLE}.LIFECYCLE_STATUS ;;
  }

  dimension: lifecycle_status_name {
    type: string
    hidden: yes
    sql: ${TABLE}.LIFECYCLE_STATUS_NAME ;;
  }

  dimension: line_ref_num {
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_REF_NUM ;;
  }

  dimension: primary_key_column {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(${line_ref_num},(${sale_type})) ;;
  }


  dimension: line_severity {
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_SEVERITY ;;
  }

  dimension: line_severity_name {
    type: string
    hidden: yes
    sql: ${TABLE}.LINE_SEVERITY_NAME ;;
  }

  dimension: list_price {
    type: number
    hidden: yes
    sql: ${TABLE}.LIST_PRICE_BASE ;;
  }

  dimension_group: load_date {
    type: time
    hidden: yes
    sql: ${TABLE}.LOAD_DATE ;;
  }

  dimension: org_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.ORG_WID ;;
  }

  dimension: paid_chgbk_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.PAID_CHGBK_AMT_BASE ;;
  }

  dimension: paid_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PAID_DATE_WID ;;
  }

  dimension: parent_distr_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PARENT_DISTR_WID ;;
  }

  dimension: pg_commit_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PG_COMMIT_WID ;;
  }

  dimension: pg_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PG_WID ;;
  }

  dimension: prc_condition_code1 {
    type: string
    hidden: yes
    sql: ${TABLE}.PRC_CONDITION_CODE1 ;;
  }

  dimension: prc_condition_code2 {
    type: string
    hidden: yes
    sql: ${TABLE}.PRC_CONDITION_CODE2 ;;
  }

  dimension: process_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PROCESS_DATE_WID ;;
  }

  dimension: product_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PRODUCT_WID ;;
  }

  dimension: prompt_pay_discount {
    type: number
    hidden: yes
    sql: ${TABLE}.PROMPT_PAY_DISCOUNT ;;
  }

  dimension_group: received_date {
    type: time
    hidden: yes
    sql: ${TABLE}.RECEIVED_DATE ;;
  }

  dimension: request_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.REQUEST_DATE_WID ;;
  }

  dimension: reversal_status {
    type: number
    hidden: yes
    sql: ${TABLE}.REVERSAL_STATUS ;;
  }

  dimension: reversal_status_name {
    type: string
    hidden: yes
    sql: ${TABLE}.REVERSAL_STATUS_NAME ;;
  }

  dimension: sale_curr {
    type: string
    hidden: yes
    sql: ${TABLE}.SALE_CURR ;;
  }

  dimension: ship_to_customer_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.SHIP_TO_CUSTOMER_WID ;;
  }

  dimension: sold_to_customer_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.SOLD_TO_CUSTOMER_WID ;;
  }

  dimension_group: src_model_date {
    type: time
    hidden: yes
    sql: ${TABLE}.SRC_MODEL_DATE ;;
  }

  dimension: src_sys_commit_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SRC_SYS_COMMIT_ID ;;
  }

  dimension_group: sub_close_date {
    type: time
    hidden: yes
    sql: ${TABLE}.SUB_CLOSE_DATE ;;
  }

  dimension_group: claim_due_date {
    type: time
    hidden: yes
    sql: ${TABLE}.CLAIM_DUE_DATE ;;
  }

  dimension: submission_num {
    type: string
    hidden: yes
    sql: ${TABLE}.SUBMISSION_NUM ;;
  }

  dimension: tier_idx {
    type: number
    hidden: yes
    sql: ${TABLE}.TIER_IDX ;;
  }

  dimension: total_appr_rebate {
    type: number
    hidden: yes
    sql: ${TABLE}.TOTAL_APPR_REBATE ;;
  }

  dimension: total_chgbk_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.TOTAL_CHGBK_AMT ;;
  }

  dimension: total_contract_amt {
    type: string
    hidden: yes
    sql: ${TABLE}.TOTAL_CONTRACT_AMT_BASE ;;
  }

  dimension: total_discrepancy_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.TOTAL_DISCREPANCY_AMT ;;
  }

  dimension: total_inv_amt {
    type: string
    hidden: yes
    sql: ${TABLE}.TOTAL_INV_AMT_BASE ;;
  }

  dimension: total_rbt_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.TOTAL_RBT_AMT ;;
  }

  dimension: transaction_date_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_DATE_WID ;;
  }

  dimension: sale_type {
    type: string
    hidden: yes
    sql: ${TABLE}.SALE_TYPE ;;
  }

  dimension: sale_type_filter {
    type: string
    hidden: yes
    label: "Sale Type"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Indirect' THEN 'Indirect / Chargebacks' ELSE ${TABLE}.SALE_TYPE END ;;
  }

  dimension: wac_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.WAC_AMT_BASE ;;
  }

  dimension: util_type {
    type: string
    hidden: yes
    sql: ${TABLE}.UTIL_TYPE ;;
  }

  dimension: est_pmt_flag_yn {
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.ESTIMATE_PMT_FLAG = 1 THEN 'Yes'
              WHEN ${TABLE}.ESTIMATE_PMT_FLAG = 0 THEN 'No' ELSE NULL END ;;
  }

  dimension: formulary_name {
    type: string
    hidden: yes
    sql: ${TABLE}.FORMULARY_NAME ;;
  }

  dimension: wac_price {
    type: number
    hidden: yes
    sql: ${TABLE}.WAC_PRICE_BASE ;;
  }

  dimension: org_ref_num {
    type: number
    hidden: yes
    sql: ${TABLE}.ORIG_REF_NUM ;;
  }

  dimension: rbt_rev_status {
    type: string
    hidden: yes
    sql: ${TABLE}.REBATE_REVERSAL_STATUS ;;
  }

  dimension: reason_code_name {
    type: string
    hidden: yes
    sql: ${TABLE}.REASON_CODE_NAME ;;
  }

  dimension: financial_adj_amt {
    type: number
    hidden: yes
    sql: ${TABLE}.FINANCIAL_ADJ_AMT_BASE ;;
  }


#   Transaction Explore Direct Sales group attributes and measures Start

  dimension_group: dir_ext_paid {
    type: time
    view_label: "Direct Sales"
    label: "External Paid"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN  ${TABLE}.EXTERNAL_PAID_DATE ELSE NULL END ;;
  }

  dimension_group: dir_inv {
    type: time
    view_label: "Direct Sales"
    label: "Invoice"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN to_date(${TABLE}.INV_DATE_WID,'yyyymmdd') ELSE NULL END;;
  }

  dimension: dir_line_ref_num {
    type: number
    view_label: "Direct Sales"
    label: "Line Reference Number"
    value_format: "0"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.LINE_REF_NUM ELSE NULL END;;
  }

  dimension_group: dir_load {
    type: time
    view_label: "Direct Sales"
    label: "Load"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.LOAD_DATE ELSE NULL END ;;
  }

  dimension_group: dir_ext_process {
    type: time
    view_label: "Direct Sales"
    label: "Process"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.EXTERNAL_PROCESS_DATE ELSE NULL END;;
  }

  dimension_group: dir_received {
    type: time
    view_label: "Direct Sales"
    label: "Received"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN  ${TABLE}.RECEIVED_DATE ELSE NULL END ;;
  }

  dimension_group: dir_ext_request {
    type: time
    view_label: "Direct Sales"
    label: "Request"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.EXTERNAL_REQUEST_DATE ELSE NULL END ;;
  }

  dimension_group: dir_ext_transaction {
    type: time
    view_label: "Direct Sales"
    label: "Transaction"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN  ${TABLE}.EXTERNAL_TRANSACTION_DATE ELSE NULL END ;;
  }

  dimension_group: dir_ext_apprvd {
    type: time
    view_label: "Direct Sales"
    label: "External Approved"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN  ${TABLE}.EXTERNAL_APPROVED_DATE ELSE NULL END ;;
  }


  dimension: dir_ext_ctrt_id {
    type: string
    view_label: "Direct Sales"
    label: "Transaction External Contract ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.EXTERNAL_CONTRACT_ID ELSE NULL END ;;
  }

  dimension: dir_ext_line_ref_id {
    type: string
    view_label: "Direct Sales"
    label: "Transaction External Line Ref ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.EXTERNAL_LINE_REF_ID ELSE NULL END ;;
  }

  dimension: dir_int_line_id {
    type: string
    view_label: "Direct Sales"
    label: "Transaction Line Link ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.INTERNAL_LINE_ID ELSE NULL END ;;
  }

  dimension: dir_inv_uom {
    type: string
    view_label: "Direct Sales"
    label: "UOM"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.INV_UOM ELSE NULL END ;;
  }

  dimension: dir_ext_line_type {
    type: string
    view_label: "Direct Sales"
    label: "Transaction Type Code"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${TABLE}.EXTERNAL_LINE_TYPE ELSE NULL END ;;
  }

  dimension: dir_inv_date_num {
    type: string
    view_label: "Direct Sales"
    label: "Pricing Period Date Number"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN to_number(to_char(${TABLE}.INV_DATE, 'yyyymmddHH24MISS')) ELSE NULL END ;;
  }

  measure: dir_tot_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Direct Sales"
    label: "Customer $"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${total_inv_amt} ELSE NULL END ;;
  }

  measure: dir_cust_price {
    type: sum
    value_format_name: usd_6
    view_label: "Direct Sales"
    label: "Customer Price"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${inv_amt} ELSE NULL END ;;
  }

  measure: dir_disc_tot_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Direct Sales"
    label: "Discounted Total Invoice Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN (1 - coalesce(${prompt_pay_discount},0)) * (${total_inv_amt}) ELSE NULL END ;;
  }

  measure: dir_prompt_pay_disc {
    type: sum
    value_format_name: usd_6
    view_label: "Direct Sales"
    label: "Prompt Pay Discount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN coalesce(${prompt_pay_discount},0) ELSE NULL END ;;
  }

  measure: dir_tot_ctrt_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Direct Sales"
    label: "Total Contract Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${total_contract_amt} ELSE NULL END ;;
  }

  measure: dir_ext_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Direct Sales"
    label: "Transaction Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN ${external_inv_amt} ELSE NULL END ;;
  }

  measure: dir_inv_qty {
    type: sum
    value_format_name: decimal_2
    view_label: "Direct Sales"
    label: "Transaction Quantity"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Direct' THEN  ${inv_qty} ELSE NULL END ;;
  }

#   Transaction Explore Direct Sales group attributes and measures End

#   Transaction Explore Indirect Sales group attributes and measures Start


  dimension_group: indir_ext_paid {
    type: time
    view_label: "Indirect Sales"
    label: "External Paid"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_PAID_DATE ELSE NULL END ;;
  }

  dimension_group: indir_inv {
    type: time
    view_label: "Indirect Sales"
    label: "Invoice"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN to_date(${TABLE}.INV_DATE_WID,'yyyymmdd') ELSE NULL END;;
  }

  dimension: indir_line_ref_num {
    type: number
    view_label: "Indirect Sales"
    label: "Line Reference Number"
    value_format: "0"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.LINE_REF_NUM ELSE NULL END;;
  }

  dimension_group: indir_load {
    type: time
    view_label: "Indirect Sales"
    label: "Load"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.LOAD_DATE ELSE NULL END ;;
  }

  dimension_group: indir_ext_process {
    type: time
    view_label: "Indirect Sales"
    label: "Process"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_PROCESS_DATE ELSE NULL END;;
  }

  dimension_group: indir_received {
    type: time
    view_label: "Indirect Sales"
    label: "Received"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN  ${TABLE}.RECEIVED_DATE ELSE NULL END ;;
  }

  dimension_group: indir_ext_request {
    type: time
    view_label: "Indirect Sales"
    label: "Request"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_REQUEST_DATE ELSE NULL END ;;
  }

  dimension_group: indir_ext_transaction {
    type: time
    view_label: "Indirect Sales"
    label: "Transaction"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN  ${TABLE}.EXTERNAL_TRANSACTION_DATE ELSE NULL END ;;
  }

  dimension_group: indir_ext_apprvd {
    type: time
    view_label: "Indirect Sales"
    label: "External Approved"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN  ${TABLE}.EXTERNAL_APPROVED_DATE ELSE NULL END ;;
  }

  dimension: indir_ext_ctrt_id {
    type: string
    view_label: "Indirect Sales"
    label: "Transaction External Contract ID"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_CONTRACT_ID ELSE NULL END ;;
  }

  dimension: indir_ext_line_ref_id {
    type: string
    view_label: "Indirect Sales"
    label: "Transaction External Line Ref ID"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_LINE_REF_ID ELSE NULL END ;;
  }

  dimension: indir_int_line_id {
    type: string
    view_label: "Indirect Sales"
    label: "Transaction Line Link ID"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.INTERNAL_LINE_ID ELSE NULL END ;;
  }

  dimension: indir_inv_uom {
    type: string
    view_label: "Indirect Sales"
    label: "UOM"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.INV_UOM ELSE NULL END ;;
  }

  dimension: indir_ext_line_type {
    type: string
    view_label: "Indirect Sales"
    label: "Transaction Type Code"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_LINE_TYPE ELSE NULL END ;;
  }

  dimension: indir_inv_date_num {
    type: string
    view_label: "Indirect Sales"
    label: "Pricing Period Date Number"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN to_number(to_char(${TABLE}.INV_DATE, 'yyyymmddHH24MISS')) ELSE NULL END ;;
  }

  measure: indir_tot_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Indirect Sales"
    label: "Customer $"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${total_inv_amt} ELSE NULL END ;;
  }

  measure: indir_cust_price {
    type: sum
    value_format_name: usd_6
    view_label: "Indirect Sales"
    label: "Customer Price"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${inv_amt} ELSE NULL END ;;
  }

  measure: indir_tot_ctrt_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Indirect Sales"
    label: "Total Contract Amount"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${total_contract_amt} ELSE NULL END ;;
  }

  measure: indir_ext_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Indirect Sales"
    label: "Transaction Amount"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${external_inv_amt} ELSE NULL END ;;
  }

  measure: indir_inv_qty {
    type: sum
    value_format_name: decimal_2
    view_label: "Indirect Sales"
    label: "Transaction Quantity"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN  ${inv_qty} ELSE NULL END ;;
  }

  measure: indir_ctrt_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Indirect Sales"
    label: "Contract Amount"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${contract_amt} ELSE NULL END ;;
  }

  measure: indir_paid_chgbk_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Indirect Sales"
    label: "Paid Chargeback Amount"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${paid_chgbk_amt} ELSE NULL END ;;
  }

  measure: indir_distr_cost_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Indirect Sales"
    label: "Transactional WAC"
    sql: CASE WHEN ${TABLE}.TRACING_FLAG = 'Y' THEN ${distr_cost_amt} ELSE NULL END ;;
  }

#   Transaction Explore Indirect Sales group attributes and measures End

#   Transaction Explore chargebacks group attributes and measures Start



  dimension_group: chb_ext_paid {
    type: time
    view_label: "Chargebacks"
    label: "External Paid"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_PAID_DATE ELSE NULL END ;;
  }

  dimension_group: chb_inv {
    type: time
    view_label: "Chargebacks"
    label: "Invoice"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN to_date(${TABLE}.INV_DATE_WID,'yyyymmdd') ELSE NULL END;;
  }

  dimension: chb_line_ref_num {
    type: number
    view_label: "Chargebacks"
    label: "Line Reference Number"
    value_format: "0"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.LINE_REF_NUM ELSE NULL END;;
  }

  dimension_group: chb_load {
    type: time
    view_label: "Chargebacks"
    label: "Load"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.LOAD_DATE ELSE NULL END ;;
  }

  dimension_group: chb_ext_process {
    type: time
    view_label: "Chargebacks"
    label: "Process"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_PROCESS_DATE ELSE NULL END;;
  }

  dimension_group: chb_received {
    type: time
    view_label: "Chargebacks"
    label: "Received"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN  ${TABLE}.RECEIVED_DATE ELSE NULL END ;;
  }

  dimension_group: chb_ext_request {
    type: time
    view_label: "Chargebacks"
    label: "Request"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_REQUEST_DATE ELSE NULL END ;;
  }

  dimension_group: chb_ext_transaction {
    type: time
    view_label: "Chargebacks"
    label: "Transaction"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN  ${TABLE}.EXTERNAL_TRANSACTION_DATE ELSE NULL END ;;
  }

  dimension_group: chb_ext_apprvd {
    type: time
    view_label: "Chargebacks"
    label: "External Approved"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN  ${TABLE}.EXTERNAL_APPROVED_DATE ELSE NULL END ;;
  }

  dimension: chb_ext_ctrt_id {
    type: string
    view_label: "Chargebacks"
    label: "Transaction External Contract ID"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_CONTRACT_ID ELSE NULL END ;;
  }

  dimension: chb_ext_line_ref_id {
    type: string
    view_label: "Chargebacks"
    label: "Transaction External Line Ref ID"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_LINE_REF_ID ELSE NULL END ;;
  }

  dimension: chb_int_line_id {
    type: string
    view_label: "Chargebacks"
    label: "Transaction Line Link ID"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.INTERNAL_LINE_ID ELSE NULL END ;;
  }

  dimension: chb_inv_uom {
    type: string
    view_label: "Chargebacks"
    label: "UOM"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.INV_UOM ELSE NULL END ;;
  }

  dimension: chb_ext_line_type {
    type: string
    view_label: "Chargebacks"
    label: "Transaction Type Code"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${TABLE}.EXTERNAL_LINE_TYPE ELSE NULL END ;;
  }

  dimension: chb_inv_date_num {
    type: string
    view_label: "Chargebacks"
    label: "Pricing Period Date Number"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN to_number(to_char(${TABLE}.INV_DATE, 'yyyymmddHH24MISS')) ELSE NULL END ;;
  }

  measure: chb_tot_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Chargebacks"
    label: "Customer $"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${total_inv_amt} ELSE NULL END ;;
  }

  measure: chb_cust_price {
    type: sum
    value_format_name: usd_6
    view_label: "Chargebacks"
    label: "Customer Price"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${inv_amt} ELSE NULL END ;;
  }

  measure: chb_tot_ctrt_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Chargebacks"
    label: "Total Contract Amount"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${total_contract_amt} ELSE NULL END ;;
  }

  measure: chb_ext_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Chargebacks"
    label: "Transaction Amount"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${external_inv_amt} ELSE NULL END ;;
  }

  measure: chb_inv_qty {
    type: sum
    value_format_name: decimal_2
    view_label: "Chargebacks"
    label: "Transaction Quantity"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN  ${inv_qty} ELSE NULL END ;;
  }

  measure: chb_ctrt_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Chargebacks"
    label: "Contract Amount"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${contract_amt} ELSE NULL END ;;
  }

  measure: chb_paid_chgbk_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Chargebacks"
    label: "Paid Chargeback Amount"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${paid_chgbk_amt} ELSE NULL END ;;
  }

  measure: chb_distr_cost_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Chargebacks"
    label: "Transactional WAC"
    sql:CASE WHEN ${TABLE}.CHARGEBACK_FLAG = 'Y' THEN ${distr_cost_amt} ELSE NULL END ;;
  }

#   Transaction Explore chargebacks group attributes and measures End


#   Transaction Explore Rebates group attributes and measures Start


  dimension_group: rbt_ext_paid {
    type: time
    view_label: "Rebates"
    label: "External Paid"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN  ${TABLE}.EXTERNAL_PAID_DATE ELSE NULL END ;;
  }

  dimension_group: rbt_inv {
    type: time
    view_label: "Rebates"
    label: "Invoice"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN to_date(${TABLE}.INV_DATE_WID,'yyyymmdd') ELSE NULL END;;
  }

  dimension: rbt_line_ref_num {
    type: number
    view_label: "Rebates"
    label: "Line Reference Number"
    value_format: "0"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.LINE_REF_NUM ELSE NULL END;;
  }

  dimension_group: rbt_ext_process {
    type: time
    view_label: "Rebates"
    label: "Process"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.EXTERNAL_PROCESS_DATE ELSE NULL END;;
  }

  dimension_group: rbt_received {
    type: time
    view_label: "Rebates"
    label: "Received"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN  ${TABLE}.RECEIVED_DATE ELSE NULL END ;;
  }

  dimension_group: rbt_ext_request {
    type: time
    view_label: "Rebates"
    label: "Request"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.EXTERNAL_REQUEST_DATE ELSE NULL END ;;
  }

  dimension_group: rbt_ext_transaction {
    type: time
    view_label: "Rebates"
    label: "Transaction"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN  ${TABLE}.EXTERNAL_TRANSACTION_DATE ELSE NULL END ;;
  }

  dimension_group: rbt_ext_apprvd {
    type: time
    view_label: "Rebates"
    label: "External Approved"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN  ${TABLE}.EXTERNAL_APPROVED_DATE ELSE NULL END ;;
  }

  dimension: rbt_ext_ctrt_id {
    type: string
    view_label: "Rebates"
    label: "Transaction External Contract ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.EXTERNAL_CONTRACT_ID ELSE NULL END ;;
  }

  dimension: rbt_ext_line_ref_id {
    type: string
    view_label: "Rebates"
    label: "Transaction External Line Ref ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.EXTERNAL_LINE_REF_ID ELSE NULL END ;;
  }

  dimension: rbt_int_line_id {
    type: string
    view_label: "Rebates"
    label: "Transaction Line Link ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.INTERNAL_LINE_ID ELSE NULL END ;;
  }

  dimension: rbt_inv_uom {
    type: string
    view_label: "Rebates"
    label: "UOM"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.INV_UOM ELSE NULL END ;;
  }

  dimension: rbt_inv_date_num {
    type: string
    view_label: "Rebates"
    label: "Pricing Period Date Number"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN to_number(to_char(${TABLE}.INV_DATE, 'yyyymmddHH24MISS')) ELSE NULL END ;;
  }

  dimension_group: rbt_claim_due {
    type: time
    view_label: "Rebates"
    label: "Claim Due"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN  ${TABLE}.CLAIM_DUE_DATE ELSE NULL END ;;
  }

  dimension: rbt_wac_amt {
    type: number
    view_label: "Rebates"
    label: "WAC Amount"
    value_format_name: usd_6
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.WAC_AMT_BASE ELSE NULL END ;;
  }

  dimension: rbt_util_type {
    type: string
    view_label: "Rebates"
    label: "Transaction Util Type"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.UTIL_TYPE ELSE NULL END ;;
  }

  dimension: rbt_est_pmt_flag {
    type: string
    view_label: "Rebates"
    label: "Estimated Payment Flag"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${est_pmt_flag_yn} ELSE NULL END ;;
  }

  dimension: rbt_formulary_name {
    type: string
    view_label: "Rebates"
    label: "Formulary"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.FORMULARY_NAME ELSE NULL END ;;
  }

  dimension: rbt_wac_price {
    type: number
    view_label: "Rebates"
    label: "Invoice Date WAC"
    value_format_name: usd_6
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.WAC_PRICE_BASE ELSE NULL END ;;
  }

  dimension: rbt_org_ref_num {
    type: number
    view_label: "Rebates"
    label: "Orig Ref Num"
    value_format: "0"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN COALESCE(${TABLE}.ORIG_REF_NUM,0) ELSE NULL END ;;
  }

  dimension: rbt_reversal_status {
    type: string
    view_label: "Rebates"
    label: "Rebate Reversal Status"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${TABLE}.REBATE_REVERSAL_STATUS ELSE NULL END ;;
  }


  measure: rbt_ext_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Rebates"
    label: "Transaction Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${external_inv_amt} ELSE NULL END ;;
  }

  measure: rbt_inv_qty {
    type: sum
    value_format_name: decimal_2
    view_label: "Rebates"
    label: "Transaction Quantity"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN  ${inv_qty} ELSE NULL END ;;
  }

  measure: tot_rbt_pmt_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Rebates"
    label: "Rebate Payment Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Paid Rebates' THEN ${rbt_pmt_amt} ELSE NULL END ;;
  }

#   Transaction Explore Rebates group attributes and measures End


#   Transaction Explore Projected Rebates group attributes and measures Start


  dimension_group: pr_ext_paid {
    type: time
    view_label: "Projected Rebates"
    label: "External Paid"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN  ${TABLE}.EXTERNAL_PAID_DATE ELSE NULL END ;;
  }

  dimension_group: pr_inv {
    type: time
    view_label: "Projected Rebates"
    label: "Invoice"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN to_date(${TABLE}.INV_DATE_WID,'yyyymmdd') ELSE NULL END;;
  }

  dimension: pr_line_ref_num {
    type: number
    view_label: "Projected Rebates"
    label: "Line Reference Number"
    value_format: "0"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.LINE_REF_NUM ELSE NULL END;;
  }

  dimension_group: pr_ext_process {
    type: time
    view_label: "Projected Rebates"
    label: "Process"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.EXTERNAL_PROCESS_DATE ELSE NULL END;;
  }

  dimension_group: pr_received {
    type: time
    view_label: "Projected Rebates"
    label: "Received"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN  ${TABLE}.RECEIVED_DATE ELSE NULL END ;;
  }

  dimension_group: pr_ext_request {
    type: time
    view_label: "Projected Rebates"
    label: "Request"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.EXTERNAL_REQUEST_DATE ELSE NULL END ;;
  }

  dimension_group: pr_ext_transaction {
    type: time
    view_label: "Projected Rebates"
    label: "Transaction"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN  ${TABLE}.EXTERNAL_TRANSACTION_DATE ELSE NULL END ;;
  }

  dimension_group: pr_ext_apprvd {
    type: time
    view_label: "Projected Rebates"
    label: "External Approved"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN  ${TABLE}.EXTERNAL_APPROVED_DATE ELSE NULL END ;;
  }

  dimension: pr_ext_ctrt_id {
    type: string
    view_label: "Projected Rebates"
    label: "Transaction External Contract ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.EXTERNAL_CONTRACT_ID ELSE NULL END ;;
  }

  dimension: pr_ext_line_ref_id {
    type: string
    view_label: "Projected Rebates"
    label: "Transaction External Line Ref ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.EXTERNAL_LINE_REF_ID ELSE NULL END ;;
  }

  dimension: pr_int_line_id {
    type: string
    view_label: "Projected Rebates"
    label: "Transaction Line Link ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.INTERNAL_LINE_ID ELSE NULL END ;;
  }

  dimension: pr_inv_uom {
    type: string
    view_label: "Projected Rebates"
    label: "UOM"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.INV_UOM ELSE NULL END ;;
  }

  dimension: pr_inv_date_num {
    type: string
    view_label: "Projected Rebates"
    label: "Pricing Period Date Number"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN to_number(to_char(${TABLE}.INV_DATE, 'yyyymmddHH24MISS')) ELSE NULL END ;;
  }

  dimension_group: pr_claim_due {
    type: time
    view_label: "Projected Rebates"
    label: "Claim Due"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN  ${TABLE}.CLAIM_DUE_DATE ELSE NULL END ;;
  }

  dimension: pr_wac_amt {
    type: number
    view_label: "Projected Rebates"
    label: "WAC Amount"
    value_format_name: usd_6
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.WAC_AMT_BASE ELSE NULL END ;;
  }

  dimension: pr_util_type {
    type: string
    view_label: "Projected Rebates"
    label: "Transaction Util Type"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.UTIL_TYPE ELSE NULL END ;;
  }

  dimension: pr_est_pmt_flag {
    type: string
    view_label: "Projected Rebates"
    label: "Estimated Payment Flag"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${est_pmt_flag_yn} ELSE NULL END ;;
  }

  dimension: pr_formulary_name {
    type: string
    view_label: "Projected Rebates"
    label: "Formulary"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.FORMULARY_NAME ELSE NULL END ;;
  }

  dimension: pr_wac_price {
    type: number
    view_label: "Projected Rebates"
    label: "Invoice Date WAC"
    value_format_name: usd_6
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.WAC_PRICE_BASE ELSE NULL END ;;
  }

  dimension: pr_org_ref_num {
    type: number
    view_label: "Projected Rebates"
    label: "Orig Ref Num"
    value_format: "0"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN COALESCE(${TABLE}.ORIG_REF_NUM,0) ELSE NULL END ;;
  }

  dimension: pr_reversal_status {
    type: string
    view_label: "Projected Rebates"
    label: "Rebate Reversal Status"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.REBATE_REVERSAL_STATUS ELSE NULL END ;;
  }

  dimension_group: pr_load {
    type: time
    view_label: "Projected Rebates"
    label: "Load"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${TABLE}.LOAD_DATE ELSE NULL END ;;
  }

  measure: pr_ext_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Projected Rebates"
    label: "Transaction Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${external_inv_amt} ELSE NULL END ;;
  }

  measure: pr_inv_qty {
    type: sum
    value_format_name: decimal_2
    view_label: "Projected Rebates"
    label: "Transaction Quantity"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN  ${inv_qty} ELSE NULL END ;;
  }

  measure: tot_pr_pmt_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Projected Rebates"
    label: "Rebate Payment Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${rbt_pmt_amt} ELSE NULL END ;;
  }

  measure: pr_cust_price {
    type: sum
    value_format_name: usd_6
    view_label: "Projected Rebates"
    label: "Customer Price"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Projected Rebates' THEN ${inv_amt} ELSE NULL END ;;
  }

#   Transaction Explore Projected Rebates group attributes and measures End


#   Transaction Explore MCO Utilization group attributes and measures Start

  dimension_group: mco_claim_due {
    type: time
    view_label: "MCO Utilization"
    label: "Claim Due"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN  ${TABLE}.CLAIM_DUE_DATE ELSE NULL END ;;
  }

  dimension: mco_wac_price {
    type: number
    view_label: "MCO Utilization"
    label: "End Date WAC"
    value_format_name: usd_6
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN ${TABLE}.WAC_PRICE_BASE ELSE NULL END ;;
  }

  dimension: mco_line_ref_num {
    type: number
    view_label: "MCO Utilization"
    label: "Line Reference ID"
    value_format: "0"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN ${TABLE}.LINE_REF_NUM ELSE NULL END;;
  }

  dimension: mco_reason_code {
    type: string
    view_label: "MCO Utilization"
    label: "Reason Code"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN ${TABLE}.REASON_CODE_NAME ELSE NULL END;;
  }

  dimension: mco_util_type {
    type: string
    view_label: "MCO Utilization"
    label: "Transaction Util Type"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN ${TABLE}.UTIL_TYPE ELSE NULL END ;;
  }

  dimension: mco_inv_uom {
    type: string
    view_label: "MCO Utilization"
    label: "UOM"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN ${TABLE}.INV_UOM ELSE NULL END ;;
  }

  dimension_group: mco_util_start {
    type: time
    view_label: "MCO Utilization"
    label: "Util Start"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN  ${TABLE}.INV_DATE ELSE NULL END ;;
  }

  dimension_group: mco_util_end {
    type: time
    view_label: "MCO Utilization"
    label: "Util End"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN  ${TABLE}.PERIOD_END_DATE ELSE NULL END ;;
  }

  measure: mco_ndc_qty {
    type: sum
    value_format_name: decimal_2
    view_label: "MCO Utilization"
    label: "Transaction Quantity"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'MCO Utilizations' THEN  ${inv_qty} ELSE NULL END ;;
  }

#   Transaction Explore MCO Utilization group attributes and measures End

  dimension_group: custom_ext_paid {
    type: time
    view_label: "Custom Sales"
    label: "External Paid"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN  ${TABLE}.EXTERNAL_PAID_DATE ELSE NULL END ;;
  }

  dimension_group: custom_inv {
    type: time
    view_label: "Custom Sales"
    label: "Invoice"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN to_date(${TABLE}.INV_DATE_WID,'yyyymmdd') ELSE NULL END;;
  }

  dimension: custom_line_ref_num {
    type: number
    view_label: "Custom Sales"
    value_format: "0"
    label: "Line Reference Number"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.LINE_REF_NUM ELSE NULL END;;
  }

  dimension_group: custom_load {
    type: time
    view_label: "Custom Sales"
    label: "Load"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.LOAD_DATE ELSE NULL END ;;
  }

  dimension_group: custom_ext_process {
    type: time
    view_label: "Custom Sales"
    label: "Process"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.EXTERNAL_PROCESS_DATE ELSE NULL END;;
  }

  dimension_group: custom_received {
    type: time
    view_label: "Custom Sales"
    label: "Received"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN  ${TABLE}.RECEIVED_DATE ELSE NULL END ;;
  }

  dimension_group: custom_ext_request {
    type: time
    view_label: "Custom Sales"
    label: "Request"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.EXTERNAL_REQUEST_DATE ELSE NULL END ;;
  }

  dimension_group: custom_ext_transaction {
    type: time
    view_label: "Custom Sales"
    label: "Transaction"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN  ${TABLE}.EXTERNAL_TRANSACTION_DATE ELSE NULL END ;;
  }

  dimension_group: custom_ext_apprvd {
    type: time
    view_label: "Custom Sales"
    label: "External Approved"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN  ${TABLE}.EXTERNAL_APPROVED_DATE ELSE NULL END ;;
  }

  dimension: custom_ext_ctrt_id {
    type: string
    view_label: "Custom Sales"
    label: "Transaction External Contract ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.EXTERNAL_CONTRACT_ID ELSE NULL END ;;
  }

  dimension: custom_ext_line_ref_id {
    type: string
    view_label: "Custom Sales"
    label: "Transaction External Line Ref ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.EXTERNAL_LINE_REF_ID ELSE NULL END ;;
  }

  dimension: custom_int_line_id {
    type: string
    view_label: "Custom Sales"
    label: "Transaction Line Link ID"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.INTERNAL_LINE_ID ELSE NULL END ;;
  }

  dimension: custom_inv_uom {
    type: string
    view_label: "Custom Sales"
    label: "UOM"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.INV_UOM ELSE NULL END ;;
  }

  dimension: custom_ext_line_type {
    type: string
    view_label: "Custom Sales"
    label: "Transaction Type Code"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.EXTERNAL_LINE_TYPE ELSE NULL END ;;
  }

  dimension: custom_inv_date_num {
    type: string
    view_label: "Custom Sales"
    label: "Pricing Period Date Number"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN to_number(to_char(${TABLE}.INV_DATE, 'yyyymmddHH24MISS')) ELSE NULL END ;;
  }


  dimension: custom_wac_price {
    type: number
    view_label: "Custom Sales"
    label: "Invoice Date WAC"
    value_format_name: usd_6
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${TABLE}.WAC_PRICE_BASE ELSE NULL END ;;
  }

  measure: custom_tot_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Custom Sales"
    label: "Customer $"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${total_inv_amt} ELSE NULL END ;;
  }

  measure: custom_cust_price {
    type: sum
    value_format_name: usd_6
    view_label: "Custom Sales"
    label: "Customer Price"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${inv_amt} ELSE NULL END ;;
  }

  measure: custom_ext_inv_amt {
    type: sum
    value_format_name: usd_6
    view_label: "Custom Sales"
    label: "Transaction Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${external_inv_amt} ELSE NULL END ;;
  }

  measure: custom_inv_qty {
    type: sum
    value_format_name: decimal_2
    view_label: "Custom Sales"
    label: "Transaction Quantity"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN  ${inv_qty} ELSE NULL END ;;
  }

  measure: financial_adj_amout {
    type: sum
    value_format_name: usd_6
    view_label: "Custom Sales"
    label: "Financial Adjustment Amount"
    sql: CASE WHEN ${TABLE}.SALE_TYPE = 'Custom' THEN ${financial_adj_amt} ELSE NULL END ;;
  }

#   Transaction Explore Custom Sales group attributes and measures End




# Transactional COT Dates Start

  dimension_group: tx_inv_date {
    type: time
    view_label: "Direct Sales"
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
    sql: to_date(${TABLE}.INV_DATE_WID,'yyyymmdd') ;;
  }

  dimension_group: tx_approved_date {
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
    sql: to_date(${TABLE}.APPROVED_DATE_WID,'yyyymmdd') ;;
  }

  dimension_group: tx_paid_date {
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
    sql: to_date(${TABLE}.PAID_DATE_WID,'yyyymmdd') ;;
  }


  dimension_group: tx_process_date {
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
    sql: to_date(${TABLE}.PROCESS_DATE_WID,'yyyymmdd') ;;
  }

  dimension_group: tx_received_date {
    type: time
    view_label: "Direct Sales"
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
    sql: ${TABLE}.RECEIVED_DATE ;;
  }

  dimension_group: tx_request_date {
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
    sql: to_date(${TABLE}.REQUEST_DATE_WID,'yyyymmdd') ;;
  }

  dimension_group: transaction_date {
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
    sql: to_date(${TABLE}.TRANSACTION_DATE_WID,'yyyymmdd') ;;
  }

  dimension_group: tx_claim_due_date {
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
    sql: ${TABLE}.CLAIM_DUE_DATE ;;
  }

# Transactional COT Dates End


}
