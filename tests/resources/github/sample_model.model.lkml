connection: "data_warehouse"

datagroup: sfdc_oppty_data {
  max_cache_age: "24 hours"
  sql_trigger:
    select DATE_PART('day',max(received_at)) || '-' || DATE_PART('hour',max(received_at)) as day_hour from salesforce.opportunities ;;
}
datagroup: sfdc_lead_and_contact_data {
  max_cache_age: "24 hours"
  sql_trigger:
    WITH leads_and_contacts as (select received_at from salesforce.leads UNION select received_at from salesforce.contacts )
    select DATE_PART('day',max(received_at)) || '-' || DATE_PART('hour',max(received_at)) as day_hour from leads_and_contacts ;;
}

# model-level access grants
access_grant: can_view_revenue_data {
  user_attribute: access_grant_revenue
  allowed_values: [ "yes" ]
}

# include extended views
include: "sf__*[!.][!z].view.lkml"
include: "stripe*[!.][!z].view.lkml"
include: "marketo*[!.][!z].view.lkml"
include: "reghub_dockeruser.view.lkml"
include: "ucp_*[!.][!z].view.lkml"
include: "dtr_*[!.][!z].view.lkml"
include: "finance_revenue_forecast.view.lkml"
include: "sf__opportunity_dockercon_renewals.view.lkml"

# include just SFDC-related LookML dashboards
include: "sf__marketing_leadership.dashboard.lookml"

# Define the Fiscal Year offset
fiscal_month_offset:  -11 # starts in February

explore: sf__accounts {
  persist_for: "24 hours"
  label: "Accounts"
  view_label: "Accounts"
  sql_always_where: NOT ${sf__accounts.is_deleted} ;;

  join: owner {
    from: sf__users
    sql_on: ${sf__accounts.owner_id} = ${owner.id} ;;
    relationship: many_to_one
  }

  join: sf__contacts {
    view_label: "Contacts"
    sql_on: ${sf__accounts.id} = ${sf__contacts.account_id} ;;
    relationship: one_to_many
  }

  join: sf__cases {
    view_label: "Cases"
    sql_on: ${sf__accounts.id} = ${sf__cases.account_id} ;;
    relationship: one_to_many
  }

  join: tam {
    view_label: "TAM"
    from: sf__users
    sql_on: ${sf__accounts.tam} = ${tam.id} ;;
    relationship: many_to_one
  }
}

#
# Explore joins SFDC account and lead objects on an engagio determined custom field
#
explore: sf__accounts_leads_engagio {
  label: "Accounts (Engagio)"
  # Base view of explore
  from: sf__accounts
  # Hide it from the main list -- still accessible via URL
  hidden: yes
  # Label the view in the Explore UI as Accounts (instead of the long explore name)
  view_label: "Accounts"
  # Add a convenient description to Explore
  description: "Accounts and associated leads as identified by engagio"
  # Ignore deleted accounts
  sql_always_where: NOT ${sf__accounts_leads_engagio.is_deleted}
    ;;

  join: sf__leads {
    view_label: "Leads"
    sql_on: ${sf__accounts_leads_engagio.id} = ${sf__leads.engagio_matched_account} ;;
    # One account will have many leads,
    # and a lead (from engagio's perspective) belongs to a single account
    relationship: one_to_many
  }
}
