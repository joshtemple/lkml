view: v_claim_detail_feature {
  #Commented Dimensions are not used for SCS

  sql_table_name: dbo.vClaimDetail_Feature ;;
  view_label: "Claimant Coverage"

  dimension: compound_primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${claimcontrol_id},${claimant_num},${claimfeature_num}) ;;
  }

  #---------------------------------------------------------------
  dimension: claimcontrol_id {
    type: number
    hidden: yes
    sql: ${TABLE}.claimcontrol_id ;;
  }

  dimension: claimant_num {
    label: "Claimant Number"
    hidden: yes
    type: number
    sql: ${TABLE}.claimant_num ;;
  }

  dimension: claimfeature_num {
    label: "Claim Feature Number"
    hidden:  yes
    type: number
    sql: ${TABLE}.claimfeature_num ;;
  }
  #---------------------------------------------------------------

  dimension: exposure_dscr {
    label: "Exposure"
    type: string
    sql: ${TABLE}.exposure_dscr ;;
  }

  dimension: subexposure_dscr {
    label: "Exposure Detail"
    type: string
    sql: ${TABLE}.subexposure_dscr ;;
  }

  dimension: coverage_dscr {
    label: "Coverage"
    type: string
    sql: ${TABLE}.coverage_dscr ;;
  }

  dimension: subcoverage_dscr {
    label: "Coverage Detail"
    type: string
    sql: ${TABLE}.subcoverage_dscr ;;
  }

  # dimension: record_only {
  #   type: string
  #   sql: case when ${TABLE}.record_only=0 then 'Yes' else 'No' end ;;
  # }

  # dimension: in_suit {
  #   type: string
  #   label: "Is In Suit"
  #   sql: case when ${TABLE}.in_suit=1 then 'Yes' else 'No' end;;
  # }

  # dimension_group: statute_of_limitations {
  #   type: time
  #   timeframes: [time, date, week, month]
  #   sql: ${TABLE}.statute_of_limitations_date ;;
  # }

#   dimension: inside_adjuster {
#     type: string
#     sql: ${TABLE}.inside_adjuster ;;
#   }

#   dimension: outside_adjuster {
#     type: string
#     sql: ${TABLE}.outside_adjuster ;;
#   }

  dimension: status_dscr {
    type: string
    label: "Status (Claimant/Coverage)"
    sql: ${TABLE}.status_dscr ;;
  }

  dimension: initial_indemnity_reserve {
    hidden: yes
    type: number
    label: "Indemnity: Initial Reserve"
    sql: ${TABLE}.initial_indemnity_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: indemnity_reserve {
    hidden: yes
    type: number
    label: "Indemnity: Reserve"
    sql: ${TABLE}.indemnity_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: indemnity_paid {
    hidden: yes
    type: number
    label: "Indemnity: Paid"
    sql: ${TABLE}.indemnity_paid ;;
    value_format: "$#,##0.00"
  }

  dimension: initial_expense_reserve {
    hidden: yes
    type: number
    label: "Indemnity: Initial Expense"
    sql: ${TABLE}.initial_expense_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: expense_reserve {
    hidden: yes
    type: number
    label: "Expense: Reserve"
    sql: ${TABLE}.expense_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: expense_paid {
    hidden: yes
    type: number
    label: "Indemnity: Paid"
    sql: ${TABLE}.expense_paid ;;
    value_format: "$#,##0.00"
  }

  dimension: alae_reserve {
    hidden: yes
    type: number
    label: "ALAE: Reserve"
    sql: ${TABLE}.alae_reserve ;;
    value_format: "$#,##0.00"
  }

  dimension: alae_paid {
    hidden: yes
    type: number
    label: "ALAE: Paid"
    sql: ${TABLE}.alae_paid ;;
    value_format: "$#,##0.00"
  }

  # dimension: initial_anticipated_expense_recovery {
  #   type: number
  #   sql: ${TABLE}.initial_anticipated_expense_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: anticipated_expense_recovery {
  #   type: number
  #   sql: ${TABLE}.anticipated_expense_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  dimension: expense_recovery {
    hidden: yes
    type: number
    label: "Expense Recovery"
    sql: ${TABLE}.expense_recovery ;;
    value_format: "$#,##0.00"
  }

  # dimension: initial_anticipated_salvage {
  #   type: number
  #   sql: ${TABLE}.initial_anticipated_salvage ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: anticipated_salvage {
  #   type: number
  #   sql: ${TABLE}.anticipated_salvage ;;
  #   value_format: "$#,##0.00"
  # }

  dimension: salvage {
    type: number
    sql: ${TABLE}.salvage ;;
    value_format: "$#,##0.00"
  }

  # dimension: initial_anticipated_subro {
  #   type: number
  #   sql: ${TABLE}.initial_anticipated_subro ;;
  #   value_format: "$#,##0.00"
  # }

  dimension: subro {
    type: number
    sql: ${TABLE}.subro ;;
    value_format: "$#,##0.00"
  }

  # dimension: initial_anticipated_other_recovery {
  #   type: number
  #   sql: ${TABLE}.initial_anticipated_other_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: anticipated_other_recovery {
  #   type: number
  #   sql: ${TABLE}.anticipated_other_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: other_recovery {
  #   type: number
  #   sql: ${TABLE}.other_recovery ;;
  #   value_format: "$#,##0.00"
  # }

  # dimension: claimfeaturestatus_id {
  #   type: number
  #   sql: ${TABLE}.claimfeaturestatus_id ;;
  # }

  # dimension: claimpersonnel_id {
  #   type: number
  #   sql: ${TABLE}.claimpersonnel_id ;;
  # }

  # dimension: display_name {
  #   type: string
  #   sql: ${TABLE}.display_name ;;
  # }

  # dimension: users_id {
  #   type: number
  #   sql: ${TABLE}.users_id ;;
  # }

  # dimension: claimdenialreason_id {
  #   type: number
  #   sql: ${TABLE}.claimdenialreason_id ;;
  # }

  # dimension: claimdenialusers_id {
  #   type: number
  #   sql: ${TABLE}.claimdenialusers_id ;;
  # }

  # dimension: claimdenialreason_remarks {
  #   label: "Denial Reason Remarks"
  #   type: string
  #   sql: ${TABLE}.claimdenialreason_remarks ;;
  # }

  dimension: denied {
    type: string
    label: "Is Denied"
    sql: case when ${TABLE}.denied=1 then 'Yes' else 'No' end ;;
  }

  # dimension_group: claimdenial_date {
  #   label: "Claim Denial"
  #   type: time
  #   timeframes: [time, date, week, month]
  #   sql: ${TABLE}.claimdenial_date ;;
  # }

  # dimension: coveragecode_id {
  #   type: number
  #   sql: ${TABLE}.coveragecode_id ;;
  # }

  # dimension: subcoveragecode_id {
  #   type: number
  #   sql: ${TABLE}.subcoveragecode_id ;;
  # }

  dimension: coveragecode {
    view_label: "Checks & Transactions"
    type: string
    hidden: no
    label: "Coverage Code"
    sql: ${TABLE}.coveragecode ;;
  }

  # dimension: claimexposure_id {
  #   type: number
  #   hidden: yes
  #   sql: ${TABLE}.claimexposure_id ;;
  # }

  # dimension: claimsubexposure_num {
  #   label: "Claim Subexposure Number"
  #   type: number
  #   sql: ${TABLE}.claimsubexposure_num ;;
  # }

  dimension: claimcoverage_num {
    label: "Claim Coverage Number"
    type: number
    hidden: yes
    sql: ${TABLE}.claimcoverage_num ;;
  }

  # dimension: claimsubcoverage_num {
  #   label: "Claim Subcoverage Number"
  #   type: number
  #   sql: ${TABLE}.claimsubcoverage_num ;;
  # }

  #DATA ELEMENTS COMPLETED-------------------------------------------------------

  measure: count {
    type: count
    label: "Count"
    drill_fields: [feature_stats*]
  }

  measure:  sum_indemnity_paid {
    view_label: "Claim Financials (Current)"
    type: sum
    #label: "Total Indemnity Paid"
    label: "Loss Paid"
    sql: ${indemnity_paid} ;;
    value_format_name: usd
  }

  measure:  ave_indemnity_paid {
    view_label: "Claim Financials (Current)"
    type: average
    #label: "Average Indemnity Paid"
    label: "Average Loss Paid"
    sql: ${indemnity_paid} ;;
    value_format_name: usd
    drill_fields: [percent_indemnity_paid*]
    filters: {
      field: indemnity_paid
      value: ">0.00"
    }
  }

  measure:  percent_indemnity_paid {
    view_label: "Claim Financials (Current)"
    type: percent_of_total
    label: "% Loss Paid"
    direction: "column"
    sql: ${sum_indemnity_paid} ;;
    value_format_name: decimal_1
    drill_fields: [percent_indemnity_paid*]
  }

  measure:  sum_indemnity_reserve {
    view_label: "Claim Financials (Current)"
    type:  sum
    #label: "Total Indemnity Reserve"
    label: "Loss Reserve"
    sql:  ${indemnity_reserve} ;;
    value_format_name: usd
  }

  measure: sum_total_indemnity_incurred {
    view_label: "Claim Financials (Current)"
    type: number
    #label: "Total Indemnity Incurred"
    label: "Loss Incurred"
    sql: ${sum_indemnity_paid} + ${sum_indemnity_reserve};;
    value_format_name: usd
  }

  measure: ave_total_indemnity_incurred{
    view_label: "Claim Financials (Current)"
    type: average
    label: "Loss Average Incurred"
    sql: ${indemnity_reserve} + ${indemnity_paid}  ;;
    value_format_name: usd
  }

  measure:  sum_expense_paid {
    view_label: "Claim Financials (Current)"
    type: sum
    #label: "Total Expense Paid"
    label: "AO Paid"
    sql: ${expense_paid} ;;
    value_format_name: usd
  }

  measure:  sum_expense_reserve {
    view_label: "Claim Financials (Current)"
    type:  sum
    #label: "Total Expense Reserve"
    label: "AO Reserve"
    sql:  ${expense_reserve} ;;
    value_format_name: usd
  }

  measure:  sum_expense_recovery {
    view_label: "Claim Financials (Current)"
    type:  sum
    #label: "Total Expense Recovery"
    label: "AO Recovery"
    sql:  ${expense_recovery} ;;
    value_format_name: usd
  }

  measure:  sum_alae_paid {
    view_label: "Claim Financials (Current)"
    type: sum
    #label: "Total Alae Paid"
    label: "DCC Paid"
    sql: ${alae_paid} ;;
    value_format_name: usd
  }

  measure:  sum_alae_reserve {
    view_label: "Claim Financials (Current)"
    type: sum
    #label: "Total Alae Reserve"
    label: "DCC Reserve"
    sql: ${alae_reserve} ;;
    value_format_name: usd
  }

  measure: sum_initial_indemnity_reserve {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Loss Initial Reserve"
    sql: ${initial_indemnity_reserve} ;;
    value_format_name: usd
  }

  measure: sum_initial_expense_reserve {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Loss Initial Expense"
    sql: ${initial_expense_reserve} ;;
    value_format_name: usd
  }

  measure: sum_salvage {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Salvage"
    sql: ${salvage} ;;
    value_format_name: usd
  }

  measure: sum_subro {
    view_label: "Claim Financials (Current)"
    type: sum
    label: "Subro"
    sql: ${subro} ;;
    value_format_name: usd
  }

  measure: sum_total_reserve_paid {
    view_label: "Claim Financials (Current)"
    hidden: no
    type: number
    label: "Total Reserve & Paid**"
    sql: ${sum_indemnity_paid} + ${sum_indemnity_reserve}
      + ${sum_alae_reserve} + ${sum_alae_paid}
      + ${sum_expense_reserve} + ${sum_expense_paid} ;;
    value_format_name: usd
  }

  set: feature_stats {
    fields: [
      claim_control.claim_number,
      claim_control.dscr,
      claimant_num,
      claimfeature_num,
      claimcoverage_num,
      exposure_dscr,
      coveragecode,
      coverage_dscr,
      indemnity_reserve,
      indemnity_paid,
      expense_reserve,
      expense_paid
    ]
  }

  set: percent_indemnity_paid {
    fields: [
      claim_control.claim_number,
      claim_control.dscr,
      #claimant_num,
      #claimfeature_num,
      #claimcoverage_num,
      claim_loss_type.dscr,
      claim_type.dscr,
      claim_severity.dscr,
      claim_control.loss_date_date,
      claim_control.reported_date_date,
      status_dscr,
      #exposure_dscr,
      #subexposure_dscr,
      coveragecode,
      coverage_dscr,
      indemnity_paid,
      expense_paid,
      alae_paid
    ]
  }
}
