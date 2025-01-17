view: mx_rankings_core {
  label: "Search Term Rankings"

  derived_table: {
    datagroup_trigger: dg_bc360_rankings

    sql: SELECT
            ROW_NUMBER() OVER () row_index,
            CAST(1 AS INT64) num_results_returned,
            *
          FROM `bc360-main.mx_rankings.mx_rankings_core`;;
  }

  dimension: row_index {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.row_index ;;
  }

  dimension: scan_month {
    view_label: "1. Timeframes"
    label: "Month Scanned"
    type: date
    hidden: yes
    sql: ${TABLE}.scan_month ;;
  }

  dimension_group: month {
    view_label: "1. Timeframes"
    label: "Scan Period"
    type: time

    timeframes: [
      month,
      quarter,
      year
    ]

    convert_tz: no
    datatype: date
    sql: ${TABLE}.scan_month ;;  }

  dimension: directory {
    view_label: "8. Page Results"
    label: "Page - Directory"
    description: "Top level directory under Domain: '/services', '/treatments', etc."

    type: string
    sql: ${TABLE}.directory ;;
  }

  dimension: domain {
    view_label: "8. Page Results"
    label: "Page - Domain"

    type: string
    sql: ${TABLE}.domain ;;
  }

  dimension: engine {
    view_label: "2. Channel Parameters"
    label: "Search Engine"

    type: string
    sql: ${TABLE}.engine ;;
  }

  dimension: location {
    view_label: "2. Channel Parameters"
    label: "Search Location"

    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: path_full {
    view_label: "8. Page Results"
    label: "Page - Full Path"

    type: string
    sql: ${TABLE}.path_full ;;
  }

  dimension: path_page {
    view_label: "8. Page Results"
    label: "Page - Path"
    type: string
    sql: ${TABLE}.path_page ;;
  }

  dimension: path_relative {
    view_label: "8. Page Results"
    label: "Page - Relative"

    type: string
    sql: ${TABLE}.path_relative ;;
    link: {
      label: "VISIT: {{ mx_rankings_core.page_title._value }}"
      url: "{{ mx_rankings_core.result_url._value }}"
    }
  }

  dimension: page_title {
    view_label: "8. Page Results"
    label: "Page Title"

    type: string
    sql: ${TABLE}.page_title ;;
  }

  dimension: rank {
    view_label: "8. Page Results"
    label: "Page - Rank"
    description: "For use as a row or column"

    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: rank_binned {
    view_label: "8. Page Results"
    label: "Rank - Binned"

    type: string
    case: {
      when: {
        sql: ${TABLE}.rank = 1 ;;
        label: "Top Result"
      }
      when: {
        sql: ${TABLE}.rank <= 3 ;;
        label: "Top Three Results"
      }
      when: {
        sql: ${TABLE}.rank <= 10 ;;
        label: "First Page"
      }
      when: {
        sql: ${TABLE}.rank <= 20 ;;
        label: "Second Page"
      }
      when: {
        sql: ${TABLE}.rank <= 30 ;;
        label: "Third Page"
      }
      when: {
        sql: ${TABLE}.rank <= 40 ;;
        label: "Fourth Page"
      }
      when: {
        sql: ${TABLE}.rank <= 50 ;;
        label: "Fifth Page"
      }
      else: "[Unranked]"
      }
  }

  measure: rank_max {
    view_label: "8. Page Results"
    label: "Rank - Max"

    type: min
    sql: ${TABLE}.rank ;;
  }

  dimension: result_url {
    view_label: "8. Page Results"
    label: "Result URL"

    type: string
    sql: ${TABLE}.result_url ;;
  }

  measure: result_urls_total {
    view_label: "8. Page Results"
    label: "# Pages Returned (Total)"
    description: "Total count of Page URLs returned (includes dupes)"

    type: number
    sql: COUNT(${TABLE}.result_url) ;;
  }

  measure: result_urls_unique {
    view_label: "8. Page Results"
    label: "# Pages Returned (Unique)"
    description: "Count of unique Page URLs returned (no dupes)"

    type: number

    sql: COUNT(DISTINCT ${TABLE}.result_url) ;;
    }

  dimension: search_term {
    view_label: "7. Search Term Results"
    label: "# Search Terms Returned (Total)"
    description: "Total count of search terms that returned results"

    type: string
    sql: ${TABLE}.search_term ;;
  }

  measure: search_terms_unique {
    view_label: "7. Search Term Results"
    label: "# Search Terms Returned (Unique)"
    description: "Count of unique search terms that returned results"

    type: count_distinct
    sql: ${TABLE}.search_term ;;
  }

  dimension: search_type {
    view_label: "7. Search Term Results"
    label: "Search Type"

    type: string
    sql: ${TABLE}.search_type ;;
  }

  measure: results_per_term {
    view_label: "7. Search Term Results"
    label: "# Results / Term"
    description: "Avg Unique Pages Returns per Unique Term"

    type: number
    value_format_name: decimal_1

    sql: SAFE_DIVIDE(${result_urls_unique},${search_terms_unique}) ;;
  }

}
