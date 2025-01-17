view: arch_clients_admin {
  view_label: "Client Architecture"

  derived_table: {
    datagroup_trigger: dg_bc360_clients

    sql:  SELECT
            ac.client_id,
            ac.organization_id,
            ac.client,
            ac.organization,
            ac.org_short
         FROM arch_clients.arch_clients_base ac;;
  }

##########  METADATA  ##########

  dimension: client_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Client ID"
    description: "ID for Primary BC360 Client Account"

    hidden: yes
    type: string

    sql: ${TABLE}.client_id ;;
  }

  dimension: organization_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Organization ID [Arch_Clients]"
    description: "ID for Organization Within MP360 Client Account"

    primary_key: yes
    hidden: no
    type: string

    sql: ${TABLE}.organization_id ;;
  }


  dimension: client_uid {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Client ID"
    description: "UID for Primary BC360 Client Account"

    hidden: yes
    type: string

    sql: ${TABLE}.client_uid ;;
  }

  dimension: organization_uid {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Organization ID [Arch_Clients]"
    description: "UID for Organization Within MP360 Client Account"

    hidden: yes
    type: string

    sql: ${TABLE}.organization_uid ;;
  }


  ##########  DIMENSIONS  ##########

  dimension: client {
    view_label: "1. Client/Account"
    label: "Client Account"
    description: "Primary BC360 Client Account"

    hidden: no
    type: string
    sql: ${TABLE}.client ;;
  }

  dimension: organization {
    view_label: "1. Client/Account"
    label: "Client Organization"
    description: "Internal Organization Within BC360 Client Account"

    hidden: no
    type: string
    sql: ${TABLE}.organization ;;
  }

  dimension: org_short {
    view_label: "1. Client/Account"
    label: "Client Org"
    description: "Short Name for Internal Organization"

    hidden: no
    type: string
    sql: ${TABLE}.org_short ;;
  }

  ##########  MEASURES  ##########
  measure: num_clients {
    view_label: "1. Client/Account"
    group_label: "Z - Category Counts"
    label: "# Clients"
    description: "Number of BC360 Client Accounts"

    hidden: yes
    type: count_distinct
    value_format_name: decimal_0

    sql: ${client_id} ;;
  }

  measure: num_orgs {
    view_label: "1. Client/Account"
    group_label: "Z - Category Counts"
    label: "# Organizations"
    description: "Number of BC360 Client Organizations"

    hidden: yes
    type: count_distinct
    value_format_name: decimal_0

    sql: ${organization_id} ;;
  }


}
