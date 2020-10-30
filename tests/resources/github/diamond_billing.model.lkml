connection: "c76-prod"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday

explore: billing_cash {
  group_label: "Diamond Analytics (PROD)"
  label: "Billing"
  view_label: "Billing"

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
}
