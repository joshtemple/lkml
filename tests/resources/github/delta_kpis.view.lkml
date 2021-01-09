view: dfp_delta {
  sql_table_name: SANDBOXQBIZ.DFP_DELTA ;;

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
##MEASURES - CURRENT PERIOD
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

##@@@@@@@@@@
##@@@@@@@@@@
##MEASURES - PREVIOUS PERIOD
##@@@@@@@@@@
##@@@@@@@@@@

  measure: ad_exchange_clicks_prev {
    type: sum
    value_format: "0.0,\" K\""
    sql: ${adex_clicks_prev} ;;
  }

  measure: ad_exchange_revenue_prev {
    type: sum
    value_format: "$#.00,\" K\""
    sql: ${adex_revenue_prev} ;;
  }

  measure: ad_exchange_view_impressions_prev {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${adex_view_imp_prev} ;;
  }

  measure: ad_server_clicks_prev {
    type: sum
    value_format: "0.0,\" K\""
    sql: ${adserv_clicks_prev} ;;
  }

  measure: ad_server_view_impressions_prev {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${adserv_view_imp_prev} ;;
  }

  measure: total_clicks_prev {
    type: sum
    value_format: "0.0,\" K\""
    sql: ${tot_clicks_prev} ;;
  }

  measure: total_cpm_cpc_cpd_vcpm_prev {
    type: sum
    value_format: "$#,##0.00"
    sql: ${tot_cpm_cpc_cpd_vcpm_prev} ;;
  }

  measure: total_impressions_prev {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${tot_imp_prev} ;;
  }

  measure: unfilled_impressions_prev {
    type: sum
    value_format: "$#,##0.00"
    sql: ${unfilled_imp_prev} ;;
  }

  measure: view_impressions_prev {
    type: sum
    value_format: "0.0,,\" M\""
    sql: ${view_imp_prev} ;;
  }

##@@@@@@@@@@
##@@@@@@@@@@
##CALCULATED MEASURES - RATIOS (CURRENT AND PREVIOUS)
##@@@@@@@@@@
##@@@@@@@@@@

  measure: vCTR {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${view_impressions} > 0 THEN (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0*(${total_clicks}/${view_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: vCTR_prev {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${total_clicks_prev} > 0 THEN 1.0*(${total_clicks_prev}/${view_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_clicks_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: view_impressions_pcnt {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_impressions} > 0 THEN (CASE WHEN 1.0*${view_impressions} > 0 THEN 1.0*(${view_impressions}/${total_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${view_impressions} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: view_impressions_pcnt_prev {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_impressions_prev} > 0 THEN (CASE WHEN 1.0*${view_impressions_prev} > 0 THEN 1.0*(${view_impressions_prev}/${total_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${view_impressions_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ecpmv {
    type: number
    value_format: "$#.00"
    sql: CASE WHEN 1.0*${view_impressions} > 0 THEN (CASE WHEN 1.0*${total_cpm_cpc_cpd_vcpm} > 0 THEN 1.0*(${total_cpm_cpc_cpd_vcpm}/(${view_impressions}/1000)) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_cpm_cpc_cpd_vcpm} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ecpmv_prev {
    type: number
    value_format: "$#.00"
    sql: CASE WHEN 1.0*${view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${total_cpm_cpc_cpd_vcpm_prev} > 0 THEN 1.0*(${total_cpm_cpc_cpd_vcpm_prev}/(${view_impressions_prev}/1000)) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_cpm_cpc_cpd_vcpm_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_server_vCTR {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_server_view_impressions} > 0 THEN (CASE WHEN 1.0*${ad_server_clicks} > 0 THEN 1.0*(${ad_server_clicks}/${ad_server_view_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_server_vCTR_prev {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_server_view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${ad_server_clicks_prev} > 0 THEN 1.0*(${ad_server_clicks_prev}/${ad_server_view_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_clicks_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_vCTR {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_exchange_view_impressions} > 0 THEN (CASE WHEN 1.0*${ad_exchange_clicks} > 0 THEN 1.0*(${ad_exchange_clicks}/${ad_exchange_view_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_vCTR_prev {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_exchange_view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${ad_exchange_clicks_prev} > 0 THEN 1.0*(${ad_exchange_clicks_prev}/${ad_exchange_view_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_clicks_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_server_revenue {
    type: sum
    value_format: "$#.00,\" K\""
    sql: ${TABLE}.TOTAL_CPM_CPC_CPD_VCPM - ${TABLE}.ADEX_REVENUE ;;
  }

  measure: ad_server_revenue_prev {
    type: sum
    value_format: "$#.00,\" K\""
    sql: ${TABLE}.TOTAL_CPM_CPC_CPD_VCPM_PREV - ${TABLE}.ADEX_REVENUE_PREV ;;
  }

  measure: ad_server_ecpmv {
    type: number
    value_format: "$#.00"
    sql: CASE WHEN 1.0*${ad_server_view_impressions} > 0 THEN (CASE WHEN 1.0*${ad_server_revenue} > 0 THEN 1.0*(${ad_server_revenue}/(${ad_server_revenue}/1000)) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_revenue} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_server_ecpmv_prev {
    type: number
    value_format: "$#.00"
    sql: CASE WHEN 1.0*${ad_server_view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${ad_server_revenue_prev} > 0 THEN 1.0*(${ad_server_revenue_prev}/(${ad_server_revenue_prev}/1000)) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_revenue_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_ecpmv {
    type: number
    value_format: "$#.00"
    sql: CASE WHEN 1.0*${ad_exchange_view_impressions} > 0 THEN (CASE WHEN 1.0*${ad_exchange_revenue} > 0 THEN 1.0*(${ad_exchange_revenue}/(${ad_exchange_revenue}/1000)) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_revenue} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_ecpmv_prev {
    type: number
    value_format: "$#.00"
    sql: CASE WHEN 1.0*${ad_exchange_view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${ad_exchange_revenue_prev} > 0 THEN 1.0*(${ad_exchange_revenue_prev}/(${ad_exchange_revenue_prev}/1000)) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_revenue_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: unfilled_impressions_pcnt {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_impressions} > 0 THEN (CASE WHEN 1.0*${unfilled_impressions} > 0 THEN 1.0*(${unfilled_impressions}/${total_impressions}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${unfilled_impressions} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: unfilled_impressions_pcnt_prev {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_impressions_prev} > 0 THEN (CASE WHEN 1.0*${unfilled_impressions_prev} > 0 THEN 1.0*(${unfilled_impressions_prev}/${total_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${unfilled_impressions_prev} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

##@@@@@@@@@@
##@@@@@@@@@@
##CALCULATED MEASURES - DELTAS
##@@@@@@@@@@
##@@@@@@@@@@

  measure: total_impressions_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_impressions_prev} > 0 THEN (CASE WHEN 1.0*${total_impressions} > 0 THEN 1.0*((${total_impressions}-${total_impressions_prev})/${total_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_impressions} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: total_clicks_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${total_clicks_prev} > 0 THEN (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0*((${total_clicks}-${total_clicks_prev})/${total_clicks_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${total_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: view_impressions_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${view_impressions} > 0 THEN 1.0*((${view_impressions}-${view_impressions_prev})/${view_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${view_impressions} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: vCTR_delta {
    type: number
    value_format: "0.00%"
    sql:  ${vCTR} - ${vCTR_prev};;
  }

  measure: view_impressions_pcnt_delta {
    type: number
    value_format: "0.00%"
    sql:  ${view_impressions_pcnt} - ${view_impressions_pcnt_prev};;
  }

  measure: ecpmv_delta {
    type: number
    value_format: "0.00%"
    sql:  ${ecpmv} - ${ecpmv_prev};;
  }

  measure: ad_server_view_impressions_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_server_view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${ad_server_view_impressions} > 0 THEN 1.0*((${ad_server_view_impressions}-${ad_server_view_impressions_prev})/${ad_server_view_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_view_impressions} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_view_impressions_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_exchange_view_impressions_prev} > 0 THEN (CASE WHEN 1.0*${ad_exchange_view_impressions} > 0 THEN 1.0*((${ad_exchange_view_impressions}-${ad_exchange_view_impressions_prev})/${ad_exchange_view_impressions_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_view_impressions} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_server_clicks_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_server_clicks_prev} > 0 THEN (CASE WHEN 1.0*${ad_server_clicks} > 0 THEN 1.0*((${ad_server_clicks}-${ad_server_clicks_prev})/${ad_server_clicks_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_clicks_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_exchange_clicks_prev} > 0 THEN (CASE WHEN 1.0*${ad_exchange_clicks} > 0 THEN 1.0*((${ad_exchange_clicks}-${ad_exchange_clicks_prev})/${ad_exchange_clicks_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_clicks} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_server_vCTR_delta {
    type: number
    value_format: "0.00%"
    sql:  ${ad_server_vCTR} - ${ad_server_vCTR_prev};;
  }

  measure: ad_exchange_vCTR_delta {
    type: number
    value_format: "0.00%"
    sql:  ${ad_exchange_vCTR} - ${ad_exchange_vCTR_prev};;
  }

  measure: ad_server_ecpmv_delta {
    type: number
    value_format: "0.00%"
    sql:  ${ad_server_ecpmv} - ${ad_server_ecpmv_prev};;
  }

  measure: ad_exchange_ecpmv_delta {
    type: number
    value_format: "0.00%"
    sql:  ${ad_exchange_ecpmv} - ${ad_exchange_ecpmv_prev};;
  }

  measure: ad_server_revenue_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_server_revenue_prev} > 0 THEN (CASE WHEN 1.0*${ad_server_revenue} > 0 THEN 1.0*((${ad_server_revenue}-${ad_server_revenue_prev})/${ad_server_revenue_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_server_revenue} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: ad_exchange_revenue_delta {
    type: number
    value_format: "0.00%"
    sql: CASE WHEN 1.0*${ad_exchange_revenue_prev} > 0 THEN (CASE WHEN 1.0*${ad_exchange_revenue} > 0 THEN 1.0*((${ad_exchange_revenue}-${ad_exchange_revenue_prev})/${ad_exchange_revenue_prev}) ELSE 0.0 END) ELSE (CASE WHEN 1.0*${ad_exchange_revenue} > 0 THEN 1.0 ELSE 0.0 END) END ;;
  }

  measure: unfilled_impressions_pcnt_delta {
    type: number
    value_format: "0.00%"
    sql:  ${unfilled_impressions_pcnt} - ${unfilled_impressions_pcnt_prev};;
  }

}
