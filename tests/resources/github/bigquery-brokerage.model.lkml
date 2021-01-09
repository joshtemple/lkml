connection: "bigquery-brokerage"

include: "trade.view.lkml"
include: "customer.view.lkml"
include: "status.view.lkml"
include: "security.view.lkml"
include: "trade_type.view.lkml"
include: "employee.view.lkml"
include: "manager.view.lkml"

label: "BigQuery Brokerage"

explore: trade {
  join: customer {
    relationship: many_to_one
    type: inner
    sql_on: ${trade.customer_account_id} = ${customer.customer_id}
            and customer_id <> 0
            and customer_id is not null
            and ${customer.customer_rank} = 1 ;;
  }
  join: status {
    relationship: many_to_one
    type: inner
    sql_on: ${trade.status_type} = ${status.status_id} ;;
  }
  join: security {
    relationship: many_to_one
    type: inner
    sql_on: ${trade.stock_symbol} = ${security.symbol} ;;
  }
  join: trade_type {
    relationship: many_to_one
    type: inner
    sql_on: trade.trade_type = ${trade_type.trade_id} ;;
  }
}

explore: hr {
  view_name: trade
  extends: [trade]
  join: employee {
    relationship: many_to_one
    type: inner
    sql_on: ${trade.executor_id} = ${employee.employee_id} ;;
  }
  join: manager {
    relationship: many_to_one
    type: inner
    sql_on: ${employee.manager_id} = ${manager.employee_id} ;;
  }
}
