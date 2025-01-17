connection: "data_warehouse"

include: "finance_cashflow.view.lkml"
include: "finance_revenue_forecast.view.lkml"
include: "finance_hr_forecast.view.lkml"
include: "sales_quota_summary_2017h2.view.lkml"
include: "sales_productivity.view.lkml"
include: "sf__opportunit*[!.][!z].view.lkml"
include: "sf__accounts.view.lkml"
include: "sf__campaigns.view.lkml"
include: "sf__users.view.lkml"
include: "sf__contacts.view.lkml"
include: "sf__campaign_members.view.lkml"
include: "sf__leads.view.lkml"
include: "vena*[!.][!z].view.lkml"

# Define the Fiscal Year offset
fiscal_month_offset:  -11 # starts in February

explore: cashflow {
  from: finance_cashflow
}

explore: sales_productivity {}

explore: revenue_forecast {
  from: finance_revenue_forecast
}

explore: headcount_forecast {
  from: finance_hr_forecast
}

explore: vena_report {
  always_filter: {
    filters: {
      field: snapshot_date
      value: "Most Recent Snapshot"
    }
  }
}

explore: sales_quota {
  from: sales_quota_summary_2017h2
}

explore: sf__opportunities {
  view_label: "Opportunities"
  label: "Opportunities"
  sql_always_where: NOT ${sf__opportunities.is_deleted} ;;

  join: sf__accounts {
    view_label: "Accounts"
    sql_on: ${sf__opportunities.account_id} = ${sf__accounts.id} ;;
    relationship: many_to_one
  }

  join: account_owners {
    from: sf__users
    sql_on: ${sf__accounts.owner_id} = ${account_owners.id} ;;
    relationship: many_to_one
  }

  join: opportunity_contacts {
    from: sf__opportunity_contact_role
    sql_on: ${opportunity_contacts.opportunity_id} = ${sf__opportunities.id} ;;
    relationship: many_to_one
  }

  join: contacts {
    from: sf__contacts
    sql_on: ${contacts.id} = ${opportunity_contacts.contact_id} ;;
    relationship: many_to_one
  }

  join: campaign_members {
    from:  sf__campaign_members
    sql_on: ${contacts.id} = ${campaign_members.contact_id} ;;
    relationship: one_to_many
  }

  join: campaigns {
    from:  sf__campaigns
    sql_on: ${campaign_members.campaign_id} = ${campaigns.id} ;;
    relationship: many_to_one
  }

  join: opportunity_owners {
    from: sf__users
    sql_on: ${sf__opportunities.owner_id} = ${opportunity_owners.id} ;;
    relationship: many_to_one
  }

  join: opportunity_products {
    from: sf__opportunity_products
    sql_on: ${sf__opportunities.id} = ${opportunity_products.opportunity_id} ;;
    relationship: one_to_many
  }

  join: finance_revenue_forecast {
    view_label: "Revenue Forecast"
    sql_on: ${finance_revenue_forecast.forecast_month} = ${sf__opportunities.close_month} ;;
    relationship: one_to_many
  }

  join: sales_quota_summary_2017h2 {
    view_label: "Sales Quota"
    sql_on: ${sales_quota_summary_2017h2.name} = ${opportunity_owners.name} OR  ${sales_quota_summary_2017h2.email} = ${opportunity_owners.email};;
    relationship: one_to_many
  }
  join: sf__leads {
    view_label: "Leads"
    sql_on: ${sf__leads.converted_opportunity_id} = ${sf__opportunities.id} ;;
    relationship: one_to_one
  }
}
