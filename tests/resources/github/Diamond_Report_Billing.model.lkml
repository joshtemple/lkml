connection: "c76-reporting"

# include all the views
include: "/views/*.view"
include: "*.view"



fiscal_month_offset: 0
week_start_day: sunday

explore: billing_cash_detail {
  group_label: "Diamond Analytics (REPORT)"
  label: "Billing"
  view_label: "Cash Detail"

  join: billing_cash {
    view_label: "Cash Payment"
    type: inner
    relationship: many_to_one
    sql_on: ${billing_cash.policy_id} = ${billing_cash_detail.policy_id}
    AND ${billing_cash.billingcash_num} = ${billing_cash_detail.billingcash_num};;
  }

  join: billing_cash_detail_type {
    view_label: "Cash Detail Type"
    type: inner
    relationship: one_to_many
    sql_on: ${billing_cash_detail_type.billingcashdetailtype_id} = ${billing_cash_detail.billingcashdetailtype_id};;
  }

  join: billing_cash_mchg_detail {
    view_label: "Cash Detail Misc"
    type: left_outer
    relationship: one_to_many
    sql_on: ${billing_cash_detail.policy_id} = ${billing_cash_mchg_detail.policy_id}
      AND ${billing_cash_mchg_detail.billingcashdetail_num} = ${billing_cash_detail.billingcashdetail_num};;
  }

  join: billing_charge_credit {
    view_label: "Charge Credit"
    type: left_outer
    relationship: one_to_many
    sql_on: ${billing_cash_mchg_detail.policy_id} = ${billing_charge_credit.policy_id}
      AND ${billing_cash_mchg_detail.billingchargecredit_num} = ${billing_charge_credit.billingchargecredit_num};;
  }

  join: billing_charges_credits_type {
    view_label: "Charge Credit Type"
    type: left_outer
    relationship: one_to_many
    sql_on: ${billing_charges_credits_type.billingchargescreditstype_id} = ${billing_charge_credit.billingchargescreditstype_id};;
  }

  join: dt_policyimage_num_unique {
    view_label: "Min_PolicyImage_Num"
    type: left_outer
    relationship: one_to_many
    sql_on: ${dt_policyimage_num_unique.policy_id} = ${billing_cash_detail.policy_id}
    AND ${dt_policyimage_num_unique.renewal_ver} = ${billing_cash_detail.renewal_ver};;
  }

  join: policy_image {
    view_label: "Policy"
    type: left_outer
    relationship: one_to_many
    sql_on: ${policy_image.policy_id} = ${dt_policyimage_num_unique.policy_id}
      AND ${policy_image.renewal_ver} = ${billing_cash_detail.renewal_ver};;
  }

  join: reinsurance_treaty {
    view_label: "Treaty"
    type:  left_outer
    relationship: one_to_many
    sql_on: ${policy_image.eff_date} between ${reinsurance_treaty.effective_date} AND
    ${reinsurance_treaty.expiration_date};;

  }
  join: policy {
    view_label: "Policy"
    fields: [policy.current_policy,policy.first_eff_date_date]
    type: left_outer
    relationship: one_to_many
    sql_on: ${policy.policy_id} = ${billing_cash.policy_id} ;;
  }

  join: v_users {
    view_label: "Billing"
    type: inner
    relationship: one_to_many
    sql_on: ${v_users.users_id} = ${billing_cash.users_id} ;;
  }

  join: billing_cash_in_source {
    view_label: "Billing"
    type: inner
    relationship: one_to_many
    sql_on: ${billing_cash_in_source.billingcashinsource_id} = ${billing_cash.billingcashinsource_id} ;;
  }

  join: billing_cash_in_source_category {
    view_label: "Billing"
    type: inner
    relationship: one_to_many
    sql_on: ${billing_cash_in_source_category.billingcashinsourcecategory_id} = ${billing_cash_in_source.billingcashinsourcecategory_id} ;;
  }

  join: billing_cash_type {
    view_label: "Billing"
    type: inner
    relationship: one_to_many
    sql_on: ${billing_cash_type.billingcashtype_id} = ${billing_cash.billingcashtype_id} ;;
  }

  join: billing_reason {
    view_label: "Billing"
    type: inner
    relationship: one_to_many
    sql_on: ${billing_reason.billingreason_id} = ${billing_cash.billingreason_id} ;;
  }
  join: payment_processor_payment_audit {
    view_label: "Billing"
    type: left_outer
    relationship: one_to_many
    sql_on: ${payment_processor_payment_audit.policy_id} = ${billing_cash.policy_id} AND
    ${billing_cash.billingcash_num} = ${payment_processor_payment_audit.billingcash_num};;
  }
}
