view: mn_price_list_fact {
  sql_table_name: MN_PRICE_LIST_FACT_VW ;;

  dimension: customer_wid {
    hidden: yes
    type: number
    sql: ${TABLE}.CUSTOMER_WID ;;
  }

  dimension_group: date_created {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DATE_CREATED ;;
  }

  dimension_group: date_updated {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DATE_UPDATED ;;
  }

  dimension: exchange_rate {
    type: string
    sql: ${TABLE}.EXCHANGE_RATE ;;
  }

  dimension_group: period_end {
    type: time
    label: "Expiration"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.PERIOD_END_DATE ;;
  }

  dimension: period_end_date_wid {
    hidden: yes
    type: number
    sql: ${TABLE}.PERIOD_END_DATE_WID ;;
  }

  dimension_group: period_start {
    type: time
    label: "Effective"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.PERIOD_START_DATE ;;
  }

  dimension: period_start_date_wid {
    hidden: yes
    type: string
    sql: ${TABLE}.PERIOD_START_DATE_WID ;;
  }

  dimension: price {
    type: number
    label: "Amount"
    value_format_name: usd
    sql: ${TABLE}.PRICE ;;
  }

  dimension: price_base {
    type: number
    hidden: yes
    sql: ${TABLE}.PRICE_BASE ;;
  }

  dimension: price_curr {
    type: string
    hidden: yes
    sql: ${TABLE}.PRICE_CURR ;;
  }

  dimension: price_list_wid {
    hidden: yes
    type: number
    sql: ${TABLE}.PRICE_LIST_WID ;;
  }

  dimension: product_wid {
    hidden: yes
    type: number
    sql: ${TABLE}.PRODUCT_WID ;;
  }

   dimension: price_list_primary_key {
     type: string
     label: "Price List Fact Primary Key"
     primary_key: yes
     hidden: yes
     sql: ${price_list_wid} ||' '||${product_wid} ||' '|| ${period_start_date_wid} ||' '|| ${period_end_date_wid};;
   }

  dimension: run_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RUN_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: mcd_pl_prod_price {
    type: number
    label: "Price"
    value_format_name: usd_6
    sql: ${price} ;;
  }

  dimension_group: mcd_pl_period_end {
    type: time
    label: "Product Effective End"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.PERIOD_END_DATE ;;
  }

  dimension_group: mcd_pl_period_start {
    type: time
    label: "Product Effective Start"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.PERIOD_START_DATE ;;
  }

  dimension: boqawp {
    type: number
    label: "BOQAWP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.BOQAWP ;;
  }

  dimension: eoqawp {
    type: number
    label: "EOQAWP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.EOQAWP ;;
  }

  dimension: boqwac {
    type: number
    label: "BOQWAC"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.BOQWAC ;;
  }

  dimension: eoqwac {
    type: number
    label: "EOQWAC"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.EOQWAC ;;
  }

  dimension: pa_prior_amp {
    type: number
    label: "PAPriorAMP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.PA_PRIOR_AMP ;;
  }

  dimension: disc_cap_rate {
    type: number
    label: "Medicaid Discount Cap"
    view_label: "URA Drilldown"
    value_format_name: decimal_2
    sql: ${TABLE}.DISC_CAP_RATE ;;
  }

  dimension: sidrug_min_rate {
    type: number
    label: "Medicaid Minimum Rates: Single Source/Innovator Products"
    view_label: "URA Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.SIDRUG_MIN_RATE ;;
  }

  dimension: cfpdrug_min_rate {
    type: number
    label: "Medicaid Minimum Rates: Clotting Factor/Pediatric Rate"
    view_label: "URA Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.CFPDRUG_MIN_RATE ;;
  }

  dimension: ndrug_min_rate {
    type: number
    label: "Medicaid Minimum Rates: Non-Innovator Products"
    view_label: "URA Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.NDRUG_MIN_RATE ;;
  }

  dimension: cpiu {
    type: number
    label: "CPIU"
    view_label: "URA Drilldown"
    value_format_name: decimal_3
    sql: ${TABLE}.CPIU ;;
  }

  dimension: bcpiu {
    type: number
    label: "BCPIU"
    view_label: "URA Drilldown"
    value_format_name: decimal_3
    sql: ${TABLE}.BCPIU ;;
  }

  dimension: pacpiu {
    type: number
    label: "PACPIU"
    view_label: "URA Drilldown"
    value_format_name: decimal_3
    sql: ${TABLE}.PACPIU ;;
  }

  dimension: pa_prior_cpiu {
    type: number
    label: "PAPriorCPIU"
    view_label: "URA Drilldown"
    value_format_name: decimal_3
    sql: ${TABLE}.PA_PRIOR_CPIU ;;
  }

  dimension: prog_amt_1 {
    type: number
    label: "Program Amount 1"
    view_label: "URA Drilldown"
    value_format_name: usd
    sql: ${TABLE}.PROG_AMT_1 ;;
  }

  dimension: prog_amt_2 {
    type: number
    label: "Program Amount 2"
    view_label: "URA Drilldown"
    value_format_name: usd
    sql: ${TABLE}.PROG_AMT_2 ;;
  }

  dimension: prog_amt_3 {
    type: number
    label: "Program Amount 3"
    view_label: "URA Drilldown"
    value_format_name: usd
    sql: ${TABLE}.PROG_AMT_3 ;;
  }

  dimension: prog_perc_1 {
    type: number
    label: "Program Percent 1"
    view_label: "URA Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.PROG_PERC_1 ;;
  }

  dimension: prog_perc_2 {
    type: number
    label: "Program Percent 2"
    view_label: "URA Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.PROG_PERC_2 ;;
  }

  dimension: prog_perc_3 {
    type: number
    label: "Program Percent 3"
    view_label: "URA Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.PROG_PERC_3 ;;
  }

  dimension: initial_amp {
    type: number
    label: "InitialAMP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.INITIAL_AMP ;;
  }

  dimension: initial_bamp {
    type: number
    label: "InitialBAMP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.INITIAL_BAMP ;;
  }

  dimension: initial_bp {
    type: number
    label: "InitialBP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.INITIAL_BP ;;
  }

  dimension: amp {
    type: number
    label: "AMP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.AMP ;;
  }

  dimension: bp {
    type: number
    label: "BP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.BP ;;
  }

  dimension: bamp {
    type: number
    label: "BAMP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.BAMP ;;
  }

  dimension: asp {
    type: number
    label: "ASP"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.ASP ;;
  }

  dimension: external_ura {
    type: number
    label: "External URA"
    view_label: "URA Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.EXTERNAL_URA ;;
  }

  ############################## Federal URA Aliasing ###########################
  dimension: fed_ura_disc_cap_rate {
    type: number
    label: "Medicaid Discount Cap"
    group_label: "Drilldown"
    value_format_name: decimal_2
    sql: ${TABLE}.DISC_CAP_RATE ;;
  }

  dimension: fed_ura_sidrug_min_rate {
    type: number
    label: "Medicaid Minimum Rates: Single Source/Innovator Products"
    group_label: "Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.SIDRUG_MIN_RATE ;;
  }

  dimension: fed_ura_cfpdrug_min_rate {
    type: number
    label: "Medicaid Minimum Rates: Clotting Factor/Pediatric Rate"
    group_label: "Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.CFPDRUG_MIN_RATE ;;
  }

  dimension: fed_ura_ndrug_min_rate {
    type: number
    label: "Medicaid Minimum Rates: Non-Innovator Products"
    group_label: "Drilldown"
    value_format_name: percent_2
    sql: ${TABLE}.NDRUG_MIN_RATE ;;
  }

  dimension: fed_ura_cpiu {
    type: number
    label: "CPIU"
    group_label: "Drilldown"
    value_format_name: decimal_3
    sql: ${TABLE}.CPIU ;;
  }

  dimension: fed_ura_bcpiu {
    type: number
    label: "BCPIU"
    group_label: "Drilldown"
    value_format_name: decimal_3
    sql: ${TABLE}.BCPIU ;;
  }

  dimension: fed_ura_amp {
    type: number
    label: "AMP"
    group_label: "Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.AMP ;;
  }

  dimension: fed_ura_bp {
    type: number
    label: "BP"
    group_label: "Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.BP ;;
  }

  dimension: fed_ura_bamp {
    type: number
    label: "BAMP"
    group_label: "Drilldown"
    value_format_name: usd_6
    sql: ${TABLE}.BAMP ;;
  }

  set: providerpricelistfact_set {
    fields: [exchange_rate,period_end_raw,period_end_time,period_end_date,period_end_week_of_year,
      period_end_month,period_end_quarter,period_end_year,period_start_raw,period_start_time,period_start_date,
      period_start_week_of_year,period_start_month,period_start_quarter,period_start_year,price]
  }

  set: mcdpricelistfact_set {
    fields: [mcd_pl_prod_price,boqawp,eoqawp,boqwac,eoqwac,pa_prior_amp,disc_cap_rate,sidrug_min_rate,cfpdrug_min_rate,ndrug_min_rate,cpiu,bcpiu,
      pacpiu,pa_prior_cpiu,prog_amt_1,prog_amt_2,prog_amt_3,prog_perc_1,prog_perc_2,prog_perc_3,initial_amp,initial_bamp,initial_bp,amp,bp,bamp,asp,external_ura]
  }

  set: fed_ura_pricelistfact_set {
    fields: [fed_ura_disc_cap_rate,fed_ura_sidrug_min_rate,fed_ura_cfpdrug_min_rate,fed_ura_ndrug_min_rate,fed_ura_cpiu,fed_ura_bcpiu,fed_ura_amp,fed_ura_bp,fed_ura_bamp]
  }

  measure: count {
    type: count
    drill_fields: []
  }


  measure: avg_price {
    type: average
    value_format_name: decimal_2
    sql:  ${price} ;;
    drill_fields: []
  }

}
