connection: "ny_athena"

include: "*.view.lkml"                       # include all views in this project
include: "/metadata/bidder_sync_names.view.lkml"   # including bidder sync names view

# NEW REVISED LOOKS #

explore: c_identity_agg_hems_total {
  label: "Connected LI HEMs (Overall)"
  description: "Uniques across the entire dataset"
}

explore: c_identity_agg_partner_ids_total {
  label: "Connected Partner IDs"
  description: "Unique third party IDs connected to sellable HEMs"

  join: bidder_names_with_sellable_partner_link {
    fields: [bidder_names_with_sellable_partner_link.name]
    sql_on: ${c_identity_agg_partner_ids_total.cookiedomain} = ${bidder_names_with_sellable_partner_link.pub_or_app_id} ;;
    type: left_outer
    relationship: many_to_one
    view_label: "C Identity Agg Partner Ids Total"
  }
}

explore: c_identity_agg_partner_ids_domain {
  label: "Connected LI HEMs (Domain)"
  description: "Uniques with cookie domain granularity"

  join: bidder_names_with_sellable_partner_link {
    fields: [bidder_names_with_sellable_partner_link.name]
    sql_on: ${c_identity_agg_partner_ids_domain.cookiedomain} = ${bidder_names_with_sellable_partner_link.pub_or_app_id} ;;
    type: left_outer
    relationship: many_to_one
    view_label: "C Identity Agg Partner Ids Domain"
  }
}

explore: c_identity_domain_relations {
  label: "Connections Between Partner IDs"
  join: primary {
    from: bidder_names_with_sellable_partner_link
    type: left_outer
    relationship: many_to_one
    sql_on: ${c_identity_domain_relations.primary_cdomain} = ${primary.pub_or_app_id} ;;
    view_label: "Primary Cookie Domain"
  }
  join: secondary {
    from: bidder_names_with_sellable_partner_link
    type: left_outer
    relationship: many_to_one
    sql_on: ${c_identity_domain_relations.secondary_cdomain} = ${secondary.pub_or_app_id} ;;
    view_label: "Secondary Cookie Domain"
  }
  hidden: yes
  # This seems redundant to me? and a lot less used than the other connections explore
}

explore: c_identity_domain_relations_latest {
  label: "Overlaps between Partner Domains"
  description: "Shared HEMs and pairs associated between domains"
  join: primary {
    from: bidder_names_with_sellable_partner_link
    type: left_outer
    relationship: many_to_one
    sql_on: ${c_identity_domain_relations_latest.primary_cdomain} = ${primary.pub_or_app_id} ;;
    view_label: "Primary Cookie Domain"
  }
  join: secondary {
    from: bidder_names_with_sellable_partner_link
    type: left_outer
    relationship: many_to_one
    sql_on: ${c_identity_domain_relations_latest.secondary_cdomain} = ${secondary.pub_or_app_id} ;;
    view_label: "Secondary Cookie Domain"
  }
}


explore: c_identity_base_agg {
  label: "Core Aggregate"
  description: "Pairs with additional dimensions"

  join: bidder_names_with_sellable_partner_link {
    fields: [bidder_names_with_sellable_partner_link.name]
    sql_on: ${c_identity_base_agg.cookiedomain} = ${bidder_names_with_sellable_partner_link.pub_or_app_id} ;;
    type: left_outer
    relationship: many_to_one
    view_label: "C Identity Base Agg"
  }
}
