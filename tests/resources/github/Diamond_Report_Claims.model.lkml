connection: "c76-reporting"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: claim_control {
  group_label: "Diamond Analytics (REPORT)"
  label: "Claims"
  view_label: "Claim"

  #Exclude records without claim number
  sql_always_where: ${claim_number} > ''
    AND {% condition dt_claim_transactions_as_of.as_of_date %} claim_control.reported_date {% endcondition %} ;;

  join: dt_reserves_loss {
    view_label: "Claim Financials (Totals)"
    type: inner
    relationship: one_to_one
    sql_on: ${claim_control.claimcontrol_id} = ${dt_reserves_loss.claimcontrol_id} ;;
  }

  join: dt_reserves_ao {
    view_label: "Claim Financials (Totals)"
    type: inner
    relationship: one_to_one
    sql_on: ${claim_control.claimcontrol_id} = ${dt_reserves_ao.claimcontrol_id} ;;
  }

  join: dt_reserves_dcc {
    view_label: "Claim Financials (Totals)"
    type: inner
    relationship: one_to_one
    sql_on: ${claim_control.claimcontrol_id} = ${dt_reserves_dcc.claimcontrol_id} ;;
  }

  join: dt_summarized_claim_level_financials {
    view_label: "Summarized Financials (Claim Level)"
    type: left_outer
    relationship: one_to_one
    sql_on: ${claim_control.claimcontrol_id} = ${dt_summarized_claim_level_financials.claimcontrol_id} ;;
  }

  join: dt_is_claim_litigated_represented {
    view_label: "Claim"
    type: inner
    relationship: one_to_one
    sql_on: ${claim_control.claimcontrol_id} = ${dt_is_claim_litigated_represented.claimcontrol_id} ;;
  }

  join: dt_claim_days_open {
    view_label: "Claim"
    type: inner
    relationship: one_to_one
    sql_on: ${dt_claim_days_open.claimcontrol_id} = ${claim_control.claimcontrol_id} ;;
  }

  join: claim_control_activity {
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${claim_control_activity.claimcontrol_id}
      and ${claim_control_activity.num} = 1 ;;
  }

  join: dt_claims_first_activity {
    view_label: "Claim Activity"
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_claims_first_activity.claimcontrol_id}
      and ${dt_claims_first_activity.num} = 1 ;;
  }

  join: dt_claims_reopen_activity {
    view_label: "Claim Activity"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_claims_reopen_activity.claimcontrol_id}
      and ${dt_claims_reopen_activity.num} > 1 ;;
  }

  join: dt_reopen_count {
    view_label: "Claim"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_reopen_count.claimcontrol_id} ;;
  }

  join: dt_claim_close_date {
    view_label: "Claim"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_close_date.claimcontrol_id} ;;
  }

  join: dt_close_count {
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_close_count.claimcontrol_id} ;;
  }

  join: dt_loss_location {
    view_label: "Loss Address"
    type: inner
    relationship: one_to_one
    sql_on: ${claim_control.claimcontrol_id} = ${dt_loss_location.claimcontrol_id} ;;
  }

  join: dt_policy_holder {
    view_label: "Policy Holder"
    type: left_outer
    relationship: one_to_many
    sql_on: ${dt_policy_holder.policy_id} = ${claim_control.policy_id};;
  }

  join: dt_weather_related {
    view_label: "Claim"
    type: inner
    relationship: one_to_many
    sql_on: ${dt_weather_related.claimcontrol_id} = ${claim_control.claimcontrol_id};;
  }

  join: claim_severity {
    type: inner
    relationship: one_to_many
    sql_on: ${claim_severity.claimseverity_id} = ${claim_control.claimseverity_id} ;;
  }

  join: claim_control_status {
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control_status.claimcontrolstatus_id} = ${claim_control.claimcontrolstatus_id} ;;
  }

  join: claim_fault {
    type: inner
    relationship: one_to_many
    sql_on: ${claim_fault.claimfault_id} = ${claim_control.claimfault_id} ;;
  }

  join: claim_loss_type {
    type: inner
    relationship: one_to_many
    sql_on: ${claim_loss_type.claimlosstype_id} = ${claim_control.claimlosstype_id} ;;
  }

  join: v_claim_detail_claimant {
    view_label: "Claimant"
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${v_claim_detail_claimant.claimcontrol_id} ;;
  }

  join: claimant {
    view_label: "Claimant"
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${claimant.claimcontrol_id} ;;
  }

  join: dt_claimant_phone_home {
    view_label: "Claimant"
    type: left_outer
    relationship: one_to_many
    sql_on: ${dt_claimant_phone_home.claimcontrol_id} = ${claimant.claimcontrol_id}
      and ${dt_claimant_phone_home.claimant_num} = 1 ;;
  }

  join: dt_claimant_phone_cellular {
    view_label: "Claimant"
    type: left_outer
    relationship: one_to_many
    sql_on: ${dt_claimant_phone_cellular.claimcontrol_id} = ${claimant.claimcontrol_id}
      and ${dt_claimant_phone_cellular.claimant_num} = 1 ;;
  }

  join: dt_coverage_financials_bi {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_bi.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_bi.claimant_num};;
  }

  join: dt_coverage_financials {
    view_label: "Feature Financials"
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials.claimant_num};;
  }

  join: dt_coverage_financials_pd {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_pd.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_pd.claimant_num};;
  }

  join: dt_coverage_financials_med {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_med.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_med.claimant_num};;
  }

  join: dt_coverage_financials_umbi {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_umbi.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_umbi.claimant_num};;
  }

  join: dt_coverage_financials_umpd {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_umpd.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_umpd.claimant_num};;
  }

  join: dt_coverage_financials_pip {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_pip.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_pip.claimant_num};;
  }

  join: dt_coverage_financials_comp {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_comp.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_comp.claimant_num};;
  }

  join: dt_coverage_financials_coll {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_coll.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_coll.claimant_num};;
  }

  join: dt_coverage_financials_rr {
    view_label: "Coverage Financials"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_rr.claimcontrol_id}
      and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_rr.claimant_num};;
  }

  join: dt_claim_inside_adjuster {
    view_label: "Claim"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_inside_adjuster.claimcontrol_id} ;;
  }

  join: dt_claim_outside_adjuster {
    view_label: "Claim"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_outside_adjuster.claimcontrol_id} ;;
  }

  join: dt_claim_supervisor {
    view_label: "Claim"
    type: left_outer
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_supervisor.claimcontrol_id} ;;
  }

  join: dt_all_claimants_per_claim {
    view_label: "Claim"
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_all_claimants_per_claim.claimcontrol_id};;
  }

  join: dt_insured_vehicle_driver {
    view_label: "Claim"
    type: inner
    relationship: one_to_many
    sql_on: ${claim_control.claimcontrol_id} = ${dt_insured_vehicle_driver.claimcontrol_id};;
  }

  join: v_claim_detail_feature {
    type: left_outer
    relationship: one_to_many
    sql_on: ${v_claim_detail_claimant.claimcontrol_id} = ${v_claim_detail_feature.claimcontrol_id}
              AND ${v_claim_detail_claimant.claimant_num} = ${v_claim_detail_feature.claimant_num}
              ;;
  }

  join: v_claim_detail_transaction {
    view_label: "Checks & Transactions"
    type: left_outer
    relationship: one_to_many
    sql_on: ${v_claim_detail_feature.claimcontrol_id} = ${v_claim_detail_transaction.claimcontrol_id}
              AND ${v_claim_detail_feature.claimant_num} = ${v_claim_detail_transaction.claimant_num}
              AND ${v_claim_detail_feature.claimfeature_num} = ${v_claim_detail_transaction.claimfeature_num}
              ;;
      #sql_where: ${v_claim_detail_transaction.check_number} between 1 and 99999999 ;;
    }

    join: dt_first_loss_payment {
      view_label: "Checks & Transactions"
      type: left_outer
      relationship: one_to_one
      sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_first_loss_payment.claimcontrol_id}
        and ${v_claim_detail_transaction.check_number} = ${dt_first_loss_payment.check_number}  ;;
    }

    join: claim_transaction {
      type: inner
      view_label: "Checks & Transactions"
      relationship: one_to_one
      sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${claim_transaction.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${claim_transaction.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${claim_transaction.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${claim_transaction.claimtransaction_num}  ;;
    }

    join: claim_transaction_payee {
      type: inner
      view_label: "Checks & Transactions Payee"
      relationship: one_to_many
      sql_on: ${claim_transaction_payee.claimcontrol_id} = ${claim_transaction.claimcontrol_id}
              and ${claim_transaction_payee.claimant_num} = ${claim_transaction.claimant_num}
              and ${claim_transaction_payee.claimfeature_num} = ${claim_transaction.claimfeature_num}
              and ${claim_transaction_payee.claimtransaction_num} = ${claim_transaction.claimtransaction_num} ;;
    }

    join: v1099_payee_list {
      view_label: "Checks & Transactions Payee"
      type: inner
      relationship: one_to_many
      sql_on: ${v1099_payee_list.claimpayee_id} = ${claim_transaction_payee.claimpayee_id} ;;
    }


    join: dt_claim_transactions_as_of {
      type: left_outer
      view_label: "Claim Financials (As of Date)"
      relationship: many_to_many
      sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_claim_transactions_as_of.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_claim_transactions_as_of.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_claim_transactions_as_of.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_claim_transactions_as_of.claimtransaction_num}
              and ${dt_claim_transactions_as_of.calc} = 1
              ;;
    }

    join: dt_transaction_payee_type {
      type: left_outer
      view_label: "Checks & Transactions"
      relationship: one_to_many
      sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_transaction_payee_type.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_transaction_payee_type.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_transaction_payee_type.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_transaction_payee_type.claimtransaction_num}
              ;;
    }

    join: dt_transaction_payee_address {
      type: left_outer
      view_label: "Checks & Transactions"
      relationship: one_to_many
      sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_transaction_payee_address.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_transaction_payee_address.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_transaction_payee_address.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_transaction_payee_address.claimtransaction_num}
              ;;
    }

    join: dt_claim_status_as_of {
      type: inner
      view_label: "Claim Financials (As of Date)"
      relationship: one_to_one
      sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_status_as_of.claimcontrol_id} ;;
    }

    join: claim_transaction_category {
      type: left_outer
      view_label: "Checks & Transactions"
      relationship: one_to_many
      sql_on: ${v_claim_detail_transaction.claimtransactioncategory_id} = ${claim_transaction_category.claimtransacationcategory_id} ;;
    }

    join: claim_pay_type {
      type: left_outer
      view_label: "Checks & Transactions"
      relationship: one_to_many
      sql_on: ${claim_transaction.claimpaytype_id} = ${claim_pay_type.claimpaytype_id} ;;
    }

    join: check_status {
      type: inner
      view_label: "Checks & Transactions"
      relationship: one_to_many
      sql_on: ${v_claim_detail_transaction.checkstatus_id} = ${check_status.checkstatus_id} ;;
    }

#     join: claim_catastrophe {
#       view_label: "Claim CAT"
#       type: left_outer
#       sql_on: ${claim_catastrophe.claimcatastrophe_id} = ${claim_control.claimcatastrophe_id} ;;
#       #sql_where: ${claim_catastrophe.claimcatastrophe_id} > 0 ;;
#       relationship: one_to_one
#     }

    join:  policy {
      view_label: "Policy"
      type: left_outer
      relationship: many_to_one
      sql_on: ${policy.policy_id} = ${claim_control.policy_id}  ;;
    }

    join: dt_policy_agency {
      view_label: "Policy"
      type: inner
      relationship: one_to_many
      sql_on: ${policy.policy_id} = ${dt_policy_agency.policy_id} ;;
    }

    join: policy_image {
      type: inner
      sql_on: ${claim_control.policy_id} = ${policy_image.policy_id} ;;
      relationship: many_to_many
    }

    join: version {
      type: inner
      sql_on: ${policy_image.version_id} = ${version.version_id} ;;
      relationship: many_to_one
    }

    join: company_state_lob {
      view_label: "Company"
      type: inner
      sql_on: ${version.companystatelob_id} = ${company_state_lob.companystatelob_id} ;;
      relationship: one_to_one
    }

    join: dt_claim_coverage {
      view_label: "Claim Coverage"
      type: left_outer
      sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_coverage.claimcontrol_id} ;;
      relationship: one_to_many
    }

    join: dt_days_to_first_loss_payment {
      view_label: "Checks & Transactions"
      type: inner
      sql_on: ${claim_control.claimcontrol_id} = ${dt_days_to_first_loss_payment.claimcontrol_id} ;;
      relationship: one_to_many
    }

    join: claim_clue_disp {
      view_label: "Claim"
      type: inner
      sql_on: ${claim_control.claimcluedisp_id} = ${claim_clue_disp.claimcluedisp_id} ;;
      relationship: many_to_one
    }

    join: dt_date_latest_indemnity_payment {
      view_label: "Checks & Transactions"
      type: left_outer
      sql_on: ${claim_control.claimcontrol_id} = ${dt_date_latest_indemnity_payment.claimcontrol_id} ;;
      relationship: one_to_one
    }
  }
  connection: "c76-reporting"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
