view: tl_touchpoint_data {
  sql_table_name: bc360_mx_downstream.tl_touchpoint_data ;;

  dimension: campaign_service {
    view_label: "Tea Leaves"
    label: "Campaign/Service" #

    type: string
    sql: ${TABLE}.campaign_service ;;
  }

  dimension: direct_indirect {
    view_label: "Tea Leaves"
    label: "Direct/Indirect"

    type: string
    sql: ${TABLE}.direct_indirect ;;
  }

  ##### Time Dimensions {

  dimension_group: date {
    view_label: "4. Timeframes"
    label: "Timeframes"
    description: "Optional complex dimension for managing timeframes"

    type: time

    timeframes: [
      raw,
      date,
      day_of_week_index,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]

    convert_tz: no
    datatype: date
    sql: ${TABLE}.encounter_date ;;  }

  measure: date_start {
    view_label: "4. Timeframes"
    label: "Start Date"

    type: date

    sql: MIN(${date_date})::DATE ;;  }

  measure: date_end {
    view_label: "4. Timeframes"
    label: "End Date"

    type: date

    sql: MAX(${date_date})::DATE ;;  }

  dimension: encounter_year {
    view_label: "Tea Leaves"
    label: "Encounter Year"

    type: string

    sql: ${TABLE}.encounter_year ;;
  }

  # Time Dimensions } #####

  dimension: financial_class {
    view_label: "Tea Leaves"
    label: "Financial Class"

    type: string

    sql: ${TABLE}.financial_class ;;
  }

  dimension: patient_type {
    view_label: "Tea Leaves"
    label: "Patient Type"

    type: string

    sql: ${TABLE}.patient_type ;;
  }

  dimension: person_type {
    view_label: "Tea Leaves"
    label: "Person Type"

    type: string

    sql: ${TABLE}.person_type ;;
  }

  dimension: service_area {
    view_label: "Tea Leaves"
    label: "Service Area"

    type: string

    sql: ${TABLE}.service_area ;;
  }

  dimension: service_location {
    view_label: "Tea Leaves"
    label: "Service Location"

    type: string

    sql: ${TABLE}.service_location ;;
  }

  dimension: subtype_list {
    view_label: "Tea Leaves"
    label: "Subtype List"

    type: string

    sql: ${TABLE}.subtype_list ;;
  }

  dimension: success_criteria {
    view_label: "Tea Leaves"
    label: "Success Criteria"

    type: string

    sql: ${TABLE}.success_criteria ;;
  }

  dimension: touchpoint_matchtype {
    view_label: "Tea Leaves"
    label: "Match Type"

    type: string

    sql: ${TABLE}.touchpoint_matchtype ;;
  }

  dimension: touchpoint_subtype {
    view_label: "Tea Leaves"
    label: "Subtype"

    type: string

    sql: ${TABLE}.touchpoint_subtype ;;
  }

  dimension: touchpoint_type {
    view_label: "Tea Leaves"
    label: "TP Type"

    type: string

    sql: ${TABLE}.touchpoint_type ;;
  }

  measure: charges_sum {
    view_label: "Tea Leaves"
    label: "$ Charges"

    type: sum
    value_format_name: usd_0

    sql: ${TABLE}.charges_sum ;;
  }
  measure: encounters_num {
    view_label: "Tea Leaves"
    label: "# Encounters"

    type: sum
    value_format_name: decimal_0

    sql: ${TABLE}.individual_unique_count ;;
  }

  measure: individual_unique_num {
    view_label: "Tea Leaves"
    label: "# Individuals"

    type: sum
    value_format_name: decimal_0

    sql: ${TABLE}.individual_unique_count ;;
  }

  measure: payments_sum {
    view_label: "Tea Leaves"
    label: "$ Payments"

    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.payments_sum ;;
  }

  measure: charges_unpaid {
    view_label: "Tea Leaves"
    label: "$ Unpaid"

    type: number
    value_format_name: usd_0
    sql: ${charges_sum} - ${payments_sum} ;;
    }

  measure: charges_per_individual {
    view_label: "Tea Leaves"
    label: "$ Charges/Individual"

    type: number
    value_format_name:  usd
    sql: 1.0*(${charges_sum}) / nullif(${individual_unique_num},0) ;;
  }

  measure: payments_per_individual {
    view_label: "Tea Leaves"
    label: "$ Payments/Individual"

    type: number
    value_format_name: usd
    sql: 1.0*(${payments_sum}) / nullif(${individual_unique_num},0) ;;
  }

  measure: unpaid_per_individual {
    view_label: "Tea Leaves"
    label: "$ Unpaid/Individual"

    type: number
    value_format_name: usd
    sql: 1.0*(${charges_unpaid}) / nullif(${individual_unique_num},0) ;;
    }

}
