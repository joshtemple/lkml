view: dfp_comp_viz {
  sql_table_name: SANDBOXQBIZ.DFP_COMP_VIZ ;;

##@@@@@@@@@@
##@@@@@@@@@@
##DIMENSIONS
##@@@@@@@@@@
##@@@@@@@@@@
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: sql: CONCAT(${TABLE}.AD_UNIT,'  ', ${TABLE}.PERIOD, '  ', LEFT(${TABLE}.END_DATE,10)) ;;
  }

  dimension: period {
    type: string
    hidden: yes
    sql: ${TABLE}.PERIOD ;;
  }

  dimension_group: end {
    type: time
    hidden: yes
    timeframes: [date]
    sql: ${TABLE}.END_DATE ;;
  }

  dimension: site {
    type: string
    hidden: yes
    sql: ${TABLE}.SITE ;;
  }

  dimension: site_name {
    type: string
    hidden: yes
    sql: ${TABLE}.SITE_NAME ;;
  }

  dimension: page {
    type: string
    hidden: yes
    sql: ${TABLE}.PAGE ;;
  }

  dimension: page_name {
    type: string
    hidden: yes
    sql: ${TABLE}.PAGE_NAME ;;
  }

  dimension: placement {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT ;;
  }

  dimension: placement_name {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_NAME ;;
  }

  dimension: ad_unit {
    type: string
    hidden: yes
    sql: ${TABLE}.AD_UNIT ;;
  }

##@@@@@@@@@@
##@@@@@@@@@@
##HIDDEN DIMENSIONS - USED INSIDE MEASURES
##@@@@@@@@@@
##@@@@@@@@@@

  dimension: adex_clicks {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADEX_CLICKS ;;
  }

  dimension: adex_clicks_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADEX_CLICKS_PREV ;;
  }

  dimension: adex_revenue {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADEX_REVENUE ;;
  }

  dimension: adex_revenue_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADEX_REVENUE_PREV ;;
  }

  dimension: adex_view_imp {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADEX_VIEW_IMP ;;
  }

  dimension: adex_view_imp_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADEX_VIEW_IMP_PREV ;;
  }

  dimension: adserv_clicks {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADSERV_CLICKS ;;
  }

  dimension: adserv_clicks_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADSERV_CLICKS_PREV ;;
  }

  dimension: adserv_view_imp {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADSERV_VIEW_IMP ;;
  }

  dimension: adserv_view_imp_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.ADSERV_VIEW_IMP_PREV ;;
  }

  dimension: tot_clicks {
    type: number
    hidden:  yes
    sql: ${TABLE}.TOTAL_CLICKS ;;
  }

  dimension: tot_clicks_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.TOTAL_CLICKS_PREV ;;
  }

  dimension: tot_cpm_cpc_cpd_vcpm {
    type: number
    hidden:  yes
    sql: ${TABLE}.TOTAL_CPM_CPC_CPD_VCPM ;;
  }

  dimension: tot_cpm_cpc_cpd_vcpm_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.TOTAL_CPM_CPC_CPD_VCPM_PREV ;;
  }

  dimension: tot_imp {
    type: number
    hidden:  yes
    sql: ${TABLE}.TOTAL_IMP ;;
  }

  dimension: tot_imp_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.TOTAL_IMP_PREV ;;
  }

  dimension: unfilled_imp {
    type: number
    hidden:  yes
    sql: ${TABLE}.UNFILLED_IMP ;;
  }

  dimension: unfilled_imp_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.UNFILLED_IMP_PREV ;;
  }

  dimension: view_imp {
    type: number
    hidden:  yes
    sql: ${TABLE}.VIEW_IMP ;;
  }

  dimension: view_imp_prev {
    type: number
    hidden:  yes
    sql: ${TABLE}.VIEW_IMP_PREV ;;
  }

##@@@@@@@@@@
##@@@@@@@@@@
##MEASURES
##@@@@@@@@@@
##@@@@@@@@@@

  measure: ad_exchange_clicks {
    type: sum
    value_format: "0.0,\" K\""
    sql: ${adex_clicks} ;;
  }

  measure: ad_exchange_revenue {
    type: sum
    value_format: "$#.00,\" K\""
    sql: ${adex_revenue} ;;
  }

  measure: ad_exchange_view_impressions {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${adex_view_imp} ;;
  }

  measure: ad_server_clicks {
    type: sum
    value_format: "0.0,\" K\""
    sql: ${adserv_clicks} ;;
  }

  measure: ad_server_view_impressions {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${adserv_view_imp} ;;
  }

  measure: total_clicks {
    type: sum
    value_format: "0.0,\" K\""
    sql: ${tot_clicks} ;;
  }

  measure: total_cpm_cpc_cpd_vcpm {
    type: sum
    value_format: "$#,##0.00"
    sql: ${tot_cpm_cpc_cpd_vcpm} ;;
  }

  measure: total_impressions {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${tot_imp} ;;
  }

  measure: unfilled_impressions {
    type: sum
    value_format: "$#,##0.00"
    sql: ${unfilled_imp} ;;
  }

  measure: view_impressions {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${view_imp} ;;
  }

  measure: count {
    hidden:  yes
    type: count
    drill_fields: [placement_name, page_name, site_name]
  }

##@@@@@@@@@@
##@@@@@@@@@@
##CALCULATED MEASURES
##@@@@@@@@@@
##@@@@@@@@@@

  measure: vCTR {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${view_impressions} > 0 THEN (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0*(${total_clicks}/${view_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: non_view_impressions {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${TABLE}.TOTAL_IMP - ${TABLE}.VIEW_IMP ;;
  }

  measure: CTR {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_impressions} > 0 THEN (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0*(${total_clicks}/${total_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_server_clicks_pcnt {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_clicks} > 0 THEN (CASE WHEN 1.0*${ad_server_clicks} > 0 THEN 1.0*(${ad_server_clicks}/${total_clicks}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_clicks_pcnt {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_clicks} > 0 THEN (CASE WHEN 1.0*${ad_exchange_clicks} > 0 THEN 1.0*(${ad_exchange_clicks}/${total_clicks}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: unfilled_impressions_pcnt {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_impressions} > 0 THEN (CASE WHEN 1.0*${unfilled_impressions} > 0 THEN 1.0*(${unfilled_impressions}/${total_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${unfilled_impressions} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }
}
