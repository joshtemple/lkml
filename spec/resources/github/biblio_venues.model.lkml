connection: "fivetran-bigquery"

# include: "*.view.lkml"                       # include all views in this project

include: "/*/*.view"

# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


explore: audienceview_venue_facts {
  label: "AudienceView Venue Facts"
  group_label: "Project Biblio"
  view_label: "AudienceView Venue Facts"

  join: sf_accounts {
    view_label: "SF Accounts"
    type: inner
    relationship: one_to_one
    sql_on: ${audienceview_venue_facts.sf_account_id}=${sf_accounts.looker_join_id_c} AND ${sf_accounts.is_deleted}= FALSE ;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }
}

explore: created_orders {
  label: "AudienceView Created Orders"
  group_label: "Project Biblio"
  view_label: "AudienceView Created Orders"
  }

explore: av_arr_acv {
  label: "AudienceView  ARR/ACV by State"
  group_label: "Project Biblio"
  view_label: "AudienceView  ARR/ACV by State"
}

explore: unlimited_payments_summary {
  label: "Unlimited Payments Summary"
  group_label: "Project Biblio"
  view_label: "Unlimited Payments Summary"
}

  explore: pos_usage {
    label: "Unlimited POS Usage"
    group_label: "Project Biblio"
    view_label: "Unlimited POS Usage"
  }

#--------------------------
