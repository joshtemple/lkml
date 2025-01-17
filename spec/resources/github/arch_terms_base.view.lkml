view: arch_terms_base {
  label: "Search Term Architecture"

  derived_table: {
    datagroup_trigger: dg_bc360_rankings

    sql: SELECT
          ROW_NUMBER() OVER () row_index,
          *
        FROM `bc360-main.mx_rankings.flat_terms`;;
  }

  dimension: row_index {
    hidden: yes
    type: number
    primary_key: yes
  }

  dimension: scan_month {
    view_label: "6. Search Term Parameters"
    label: "Month Scanned"
    type: date
    hidden: yes
    sql: ${TABLE}.scan_month ;;
  }

  dimension: funnel_position {
    view_label: "6. Search Term Parameters"
    label: "Funnel Position"

    type: string
    sql: ${TABLE}.funnel_position ;;
  }

  dimension: offering {
    view_label: "5. Services"
    group_item_label: "Service Offering"

    type: string
    sql: ${TABLE}.offering ;;
  }

  dimension: search_term {
    view_label: "6. Search Term Parameters"
    group_item_label: "Search Term"

    type: string
    sql: ${TABLE}.search_term ;;
  }

  dimension: search_term_status {
    view_label: "6. Search Term Parameters"
    group_item_label: "Search Term Status"

    type: string
    sql: ${TABLE}.status ;;
    }

  measure: search_terms_scanned {
    view_label: "6. Search Term Parameters"
    label: "# Terms Scanned (Unique)"
    description: "Count of unique terms in scanned set"

    type: sum
    sql: ${TABLE}.num_terms_scanned ;;
  }

  dimension: service {
    view_label: "5. Services"
    group_item_label: "Service Line"

    type: string
    sql: ${TABLE}.service ;;
  }

  dimension: specialty {
    view_label: "5. Services"
    group_item_label: "Service Specialty"

    type: string
    sql: ${TABLE}.specialty ;;
  }

  dimension: tier {
    view_label: "6. Search Term Parameters"
    group_item_label: "Tier"

    type: string
    sql: ${TABLE}.tier ;;
  }

}
