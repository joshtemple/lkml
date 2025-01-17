view: experiment_session_facts {
  derived_table: {
#     sql_trigger_value: select count(*) from ${experiment.SQL_TABLE_NAME} ;;
    sql_trigger_value: SELECT FLOOR((TIMESTAMP_DIFF(CURRENT_TIMESTAMP(),'1970-01-01 00:00:00',SECOND)) / (3*60*60)) ;;
    sql:

select
  e.session_id
  ,e.experiment_id
  ,e.variant_id
  ,e.looker_visitor_id

  ,s.is_guest_at_session
  ,s.is_pre_outlinked_at_session
  ,s.is_pre_purchase_at_session

  ,s.session_start_at
  ,s.session_duration_minutes

  ,s.count_engaged
  ,s.count_discovery_engaged
  ,s.count_cashback_engaged

  ,s.count_product_list_viewed
  ,s.count_product_viewed
  ,s.number_of_signed_up_events
  ,s.count_outlinked
  ,s.count_concierge_clicked
  ,s.count_added_to_wishlist

  ,s.count_order_completed
  ,s.order_value

from ${session_facts.SQL_TABLE_NAME} AS s
join ${experiment_sessions.SQL_TABLE_NAME} AS e ON e.session_id = s.session_id
join ${experiment_facts.SQL_TABLE_NAME} as ef on ef.experiment_id=e.experiment_id
where s.session_start_at >= '2019-10-09'
and s.session_start_at between ef.experiment_start_at and ef.experiment_end_at
;;

  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }
  dimension: experiment_id {
    type: string
    sql: ${TABLE}.experiment_id ;;
  }
  dimension: variant_id {
    type: string
    sql: ${TABLE}.variant_id ;;
  }
  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension: is_guest_at_session {
    group_label: "Session Flags"
    type: yesno
    sql: ${TABLE}.is_guest_at_session ;;
  }
  dimension: is_pre_purchase_at_session {
    type: yesno
    sql: ${TABLE}.is_pre_purchase_at_session ;;
    group_label: "Session Flags"
  }
  dimension: is_pre_outlinked_at_session {
    type: yesno
    sql: ${TABLE}.is_pre_outlinked_at_session ;;
    group_label: "Session Flags"
  }

  dimension_group: start {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.session_start_at ;;
  }
  dimension: session_duration_minutes {
    type: number
    sql: ${TABLE}.session_duration_minutes ;;
  }

  dimension: engaged {
    type: number
    sql: ${TABLE}.count_engaged ;;
    group_label: "Event Counts"
  }
  dimension: product_discovery {
    type: number
    sql: ${TABLE}.count_discovery_engaged ;;
    group_label: "Event Counts"
    description: "Viewed Search, Category, Brand, Hashtag, New, Sale Product List"
  }
  dimension: cashback_engaged {
    type: number
    sql: ${TABLE}.count_cashback_engaged ;;
    group_label: "Event Counts"
    description: "Viewed Cashback related pages"
  }

  dimension: product_lists_viewed {
    type: number
    sql: ${TABLE}.count_product_list_viewed ;;
    group_label: "Event Counts"
  }
  dimension: products_viewed {
    type: number
    sql: ${TABLE}.count_product_viewed ;;
    group_label: "Event Counts"
  }
  dimension: number_of_signed_up_events {
    type:  number
    sql: ${TABLE}.number_of_signed_up_events ;;
    group_label: "Event Counts"
  }
  dimension: outlinked {
    type: number
    sql: ${TABLE}.count_outlinked ;;
    group_label: "Event Counts"
  }
  dimension: concierge_clicked {
    type: number
    sql: ${TABLE}.count_concierge_clicked ;;
    group_label: "Event Counts"
  }
  dimension: added_to_wishlist {
    type: number
    sql: ${TABLE}.count_added_to_wishlist ;;
    group_label: "Event Counts"
  }

  dimension: order_completed {
    type: number
    sql: ${TABLE}.count_order_completed ;;
    group_label: "Event Counts"
  }
  dimension: order_value {
    type: number
    sql: ${TABLE}.order_value ;;
    value_format_name: decimal_0
    group_label: "Event Counts"
  }


#Session
  measure: count_visitor_0 {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
  }
  measure: count_visitor_1 {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
  }
  measure: count_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
  }
  measure: count_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
  }


#Session Duration
##Avg
  measure: avg_session_duration_0 {
    type: average
    sql: ${session_duration_minutes} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    group_label: "Session Duration"
  }
  measure: avg_session_duration_1 {
    type: average
    sql: ${session_duration_minutes} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    group_label: "Session Duration"
  }
  measure: var_session_duration_0 {
    type: number
    sql: var_samp(case when ${variant_id}="0" then ${session_duration_minutes} else null end) ;;
    group_label: "Session Duration"
  }
  measure: var_session_duration_1 {
    type: number
    sql: var_samp(case when ${variant_id}="1" then ${session_duration_minutes} else null end) ;;
    group_label: "Session Duration"
  }
  measure: t_score_avg_session_duration {
    type: number
    sql: (${avg_session_duration_0}-${avg_session_duration_1}) /
    sqrt( ( ( ((${count_session_0}-1)*${var_session_duration_0})+((${count_session_1}-1)*${var_session_duration_1}) ) / ( (${count_session_0}-1)+(${count_session_1}-1) ) ) * ((1/${count_session_0}) + (1/${count_session_1})) ) ;;
    group_label: "Session Duration"
  }
  measure: significance_avg_session_duration {
    sql: if(abs(${t_score_avg_session_duration})>1.960,'0.05 Significant level','Insignificant');;
    group_label: "Session Duration"
  }
  measure: improvement_avg_session_duration {
    type: number
    sql: (${avg_session_duration_1}-${avg_session_duration_0})/nullif(${avg_session_duration_0},0);;
    value_format_name: percent_1
    group_label: "Session Duration"
  }
  measure: sig_imp_avg_session_duration {
    type: number
    sql:  if(${significance_avg_session_duration}='0.05 Significant level',${improvement_avg_session_duration},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Session Duration"
  }


#Engaged
##Conversion
  measure: count_engaged_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: engaged
      value: ">0"
    }
    group_label: "Engaged"
  }
  measure: count_engaged_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: engaged
      value: ">0"
    }
    group_label: "Engaged"
  }
  measure: conversion_engaged_0 {
    type: number
    sql:  ${count_engaged_session_0}/nullif(${count_session_0},0);;
    value_format_name: percent_1
    group_label: "Engaged"
  }
  measure: conversion_engaged_1 {
    type: number
    sql:  ${count_engaged_session_1}/nullif(${count_session_1},0);;
    value_format_name: percent_1
    group_label: "Engaged"
  }
  measure: chi_value_conversion_engaged {
    type: number
    sql:
if(
  ${count_session_0}+${count_session_1}=${count_engaged_session_0}+${count_engaged_session_1},
  0,
  (power( ${count_engaged_session_0}-( ${count_session_0}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_0}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1}) ))
  +(power( ${count_engaged_session_1}-( ${count_session_1}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_1}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1}) ))
  +(power( ${count_session_0}-${count_engaged_session_0}-( ${count_session_0}-(${count_session_0}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_0}-(${count_session_0}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1})) ))
  +(power( ${count_session_1}-${count_engaged_session_1}-( ${count_session_1}-(${count_session_1}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_1}-(${count_session_1}*(${count_engaged_session_0}+${count_engaged_session_1})/(${count_session_0}+${count_session_1})) ))
)
    ;;
    group_label: "Engaged"
  }
  measure: significance_conversion_engaged {
    sql: if(abs(${chi_value_conversion_engaged})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Engaged"
  }
  measure: improvement_conversion_engaged {
    type: number
    sql: if(${conversion_engaged_1}-${conversion_engaged_0}=0,0,(${conversion_engaged_1}-${conversion_engaged_0})/nullif(${conversion_engaged_0},0));;
    value_format_name: percent_1
    group_label: "Engaged"
  }
  measure: sig_imp_conversion_engaged {
    type: number
    sql:  if(${significance_conversion_engaged}='0.05 Significant level',${improvement_conversion_engaged},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Engaged"
  }


#Discovery Engaged
##Conversion
  measure: count_discovery_engaged_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: product_discovery
      value: ">0"
    }
    group_label: "Discovery Engaged"
  }
  measure: count_discovery_engaged_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: product_discovery
      value: ">0"
    }
    group_label: "Discovery Engaged"
  }
  measure: conversion_discovery_engaged_0 {
    type: number
    sql:  ${count_discovery_engaged_session_0}/nullif(${count_session_0},0);;
    value_format_name: percent_1
    group_label: "Discovery Engaged"
  }
  measure: conversion_discovery_engaged_1 {
    type: number
    sql:  ${count_discovery_engaged_session_1}/nullif(${count_session_1},0);;
    value_format_name: percent_1
    group_label: "Discovery Engaged"
  }
  measure: chi_value_conversion_discovery_engaged {
    type: number
    sql:
if(
  ${count_session_0}+${count_session_1}=${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1},
  0,
  (power( ${count_discovery_engaged_session_0}-( ${count_session_0}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_0}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1}) ))
  +(power( ${count_discovery_engaged_session_1}-( ${count_session_1}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_1}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1}) ))
  +(power( ${count_session_0}-${count_discovery_engaged_session_0}-( ${count_session_0}-(${count_session_0}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_0}-(${count_session_0}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1})) ))
  +(power( ${count_session_1}-${count_discovery_engaged_session_1}-( ${count_session_1}-(${count_session_1}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_1}-(${count_session_1}*(${count_discovery_engaged_session_0}+${count_discovery_engaged_session_1})/(${count_session_0}+${count_session_1})) ))
)
;;
    group_label: "Discovery Engaged"
  }
  measure: significance_conversion_discovery_engaged {
    sql: if(abs(${chi_value_conversion_discovery_engaged})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Discovery Engaged"
  }
  measure: improvement_conversion_discovery_engaged {
    type: number
    sql: if(${conversion_discovery_engaged_1}-${conversion_discovery_engaged_0}=0,0,(${conversion_discovery_engaged_1}-${conversion_discovery_engaged_0})/nullif(${conversion_discovery_engaged_0},0));;
    value_format_name: percent_1
    group_label: "Discovery Engaged"
  }
  measure: sig_imp_conversion_discovery_engaged {
    type: number
    sql:  if(${significance_conversion_discovery_engaged}='0.05 Significant level',${improvement_conversion_discovery_engaged},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Discovery Engaged"
  }


#Product View
##Conversion
  measure: count_product_view_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: products_viewed
      value: ">0"
    }
    group_label: "Product Viewed"
  }
  measure: count_product_view_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: products_viewed
      value: ">0"
    }
    group_label: "Product Viewed"
  }
  measure: conversion_product_view_0 {
    type: number
    sql:  ${count_product_view_session_0}/nullif(${count_session_0},0);;
    value_format_name: percent_1
    group_label: "Product Viewed"
  }
  measure: conversion_product_view_1 {
    type: number
    sql:  ${count_product_view_session_1}/nullif(${count_session_1},0);;
    value_format_name: percent_1
    group_label: "Product Viewed"
  }
  measure: chi_value_conversion_product_view {
    type: number
    sql:
if(${count_session_0}+${count_session_1}=${count_product_view_session_0}+${count_product_view_session_1},0,
(power( ${count_product_view_session_0}-( ${count_session_0}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_0}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1}) ))
+(power( ${count_product_view_session_1}-( ${count_session_1}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_1}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1}) ))
+(power( ${count_session_0}-${count_product_view_session_0}-( ${count_session_0}-(${count_session_0}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_0}-(${count_session_0}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1})) ))
+(power( ${count_session_1}-${count_product_view_session_1}-( ${count_session_1}-(${count_session_1}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_1}-(${count_session_1}*(${count_product_view_session_0}+${count_product_view_session_1})/(${count_session_0}+${count_session_1})) ))
)
;;
    group_label: "Product Viewed"
  }
  measure: significance_conversion_product_view {
    sql: if(abs(${chi_value_conversion_product_view})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Product Viewed"
  }
  measure: improvement_conversion_product_view {
    type: number
    sql: if(${conversion_product_view_1}-${conversion_product_view_0}=0,0,(${conversion_product_view_1}-${conversion_product_view_0})/nullif(${conversion_product_view_0},0));;
    value_format_name: percent_1
    group_label: "Product Viewed"
  }
  measure: sig_imp_conversion_product_view {
    type: number
    sql:  if(${significance_conversion_product_view}='0.05 Significant level',${improvement_conversion_product_view},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Product Viewed"
  }


#Product View
##Avg
  measure: total_product_view_0 {
    type: sum
    sql: ${products_viewed} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    group_label: "Product Viewed"
  }
  measure: total_product_view_1 {
    type: sum
    sql: ${products_viewed} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    group_label: "Product Viewed"
  }
  measure: avg_product_view_0 {
    type: number
    sql: ${total_product_view_0}/nullif(${count_product_view_session_0},0) ;;
    value_format_name: decimal_2
    group_label: "Product Viewed"
  }
  measure: avg_product_view_1 {
    type: number
    sql: ${total_product_view_1}/nullif(${count_product_view_session_1},0) ;;
    value_format_name: decimal_2
    group_label: "Product Viewed"
  }
  measure: var_product_view_0 {
    type: number
    sql: var_samp(case when ${variant_id}="0" then ${products_viewed} else null end) ;;
    group_label: "Product Viewed"
  }
  measure: var_product_view_1 {
    type: number
    sql: var_samp(case when ${variant_id}="1" then ${products_viewed} else null end) ;;
    group_label: "Product Viewed"
  }
  measure: t_score_avg_product_view {
    type: number
    sql: (${avg_product_view_0}-${avg_product_view_1}) / sqrt( ( ( ((${count_product_view_session_0}-1)*${var_product_view_0})+((${count_product_view_session_1}-1)*${var_product_view_1}) ) / ( (${count_product_view_session_0}-1)+(${count_product_view_session_1}-1) ) ) * ((1/${count_product_view_session_0}) + (1/${count_product_view_session_1})) ) ;;
    group_label: "Product Viewed"
  }
  measure: significance_avg_product_view {
    sql: if(abs(${t_score_avg_product_view})>1.960,'0.05 Significant level','Insignificant');;
    group_label: "Product Viewed"
  }
  measure: improvement_avg_product_view {
    type: number
    sql: (${avg_product_view_1}-${avg_product_view_0})/nullif(${avg_product_view_0},0);;
    value_format_name: percent_1
    group_label: "Product Viewed"
  }
  measure: sig_imp_avg_product_view {
    type: number
    sql:  if(${significance_avg_product_view}='0.05 Significant level',${improvement_avg_product_view},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Product Viewed"
  }



#SignUp
##Conversion
  measure: count_guest_0 {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_guest_at_session
      value: "yes"
    }
    group_label: "Signed Up"
  }
  measure: count_guest_1 {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_guest_at_session
      value: "yes"
    }
    group_label: "Signed Up"
  }
  measure: count_signup_visitor_0 {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_guest_at_session
      value: "yes"
    }
    filters: {
      field: number_of_signed_up_events
      value: ">0"
    }
    group_label: "Signed Up"
  }
  measure: count_signup_visitor_1 {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_guest_at_session
      value: "yes"
    }
    filters: {
      field: number_of_signed_up_events
      value: ">0"
    }
    group_label: "Signed Up"
  }
  measure: conversion_signup_0 {
    type: number
    sql:  ${count_signup_visitor_0}/nullif(${count_guest_0},0);;
    value_format_name: percent_1
    group_label: "Signed Up"
  }
  measure: conversion_signup_1 {
    type: number
    sql:  ${count_signup_visitor_1}/nullif(${count_guest_1},0);;
    value_format_name: percent_1
    group_label: "Signed Up"
  }
  measure: chi_value_conversion_signup {
    type: number
    sql:
      (power( ${count_signup_visitor_0}-( ${count_guest_0}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1}) ) ,2) / ( ${count_guest_0}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1}) ))
      +(power( ${count_signup_visitor_1}-( ${count_guest_1}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1}) ) ,2) / ( ${count_guest_1}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1}) ))
      +(power( ${count_guest_0}-${count_signup_visitor_0}-( ${count_guest_0}-(${count_guest_0}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1})) ) ,2) / ( ${count_guest_0}-(${count_guest_0}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1})) ))
      +(power( ${count_guest_1}-${count_signup_visitor_1}-( ${count_guest_1}-(${count_guest_1}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1})) ) ,2) / ( ${count_guest_1}-(${count_guest_1}*(${count_signup_visitor_0} + ${count_signup_visitor_1})/(${count_guest_0} + ${count_guest_1})) ))
      ;;
    group_label: "Signed Up"
  }
  measure: significance_conversion_signup {
    sql: if(abs(${chi_value_conversion_signup})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Signed Up"
  }
  measure: improvement_conversion_signup {
    type: number
    sql: (${conversion_signup_1}-${conversion_signup_0})/nullif(${conversion_signup_0},0);;
    value_format_name: percent_1
    group_label: "Signed Up"
  }
  measure: sig_imp_conversion_signup {
    type: number
    sql:  if(${significance_conversion_signup}='0.05 Significant level',${improvement_conversion_signup},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Signed Up"
  }

#Outlink
##Conversion
  measure: count_outlink_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: outlinked
      value: ">0"
    }
    group_label: "Outlinked"
  }
  measure: count_outlink_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: outlinked
      value: ">0"
    }
    group_label: "Outlinked"
  }
  measure: conversion_outlink_0 {
    type: number
    sql:  ${count_outlink_session_0}/nullif(${count_session_0},0);;
    value_format_name: percent_1
    group_label: "Outlinked"
  }
  measure: conversion_outlink_1 {
    type: number
    sql:  ${count_outlink_session_1}/nullif(${count_session_1},0);;
    value_format_name: percent_1
    group_label: "Outlinked"
  }
  measure: chi_value_conversion_outlink {
    type: number
    sql:
if(${count_session_0}+${count_session_1}=${count_outlink_session_0}+${count_outlink_session_1},0,
(power( ${count_outlink_session_0}-( ${count_session_0}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_0}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1}) ))
+(power( ${count_outlink_session_1}-( ${count_session_1}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_1}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1}) ))
+(power( ${count_session_0}-${count_outlink_session_0}-( ${count_session_0}-(${count_session_0}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_0}-(${count_session_0}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1})) ))
+(power( ${count_session_1}-${count_outlink_session_1}-( ${count_session_1}-(${count_session_1}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_1}-(${count_session_1}*(${count_outlink_session_0}+${count_outlink_session_1})/(${count_session_0}+${count_session_1})) ))
)
;;
    group_label: "Outlinked"
  }
  measure: significance_conversion_outlink {
    sql: if(abs(${chi_value_conversion_outlink})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Outlinked"
  }
  measure: improvement_conversion_outlink {
    type: number
    sql: (${conversion_outlink_1}-${conversion_outlink_0})/nullif(${conversion_outlink_0},0);;
    value_format_name: percent_1
    group_label: "Outlinked"
  }
  measure: sig_imp_conversion_outlink {
    type: number
    sql:  if(${significance_conversion_outlink}='0.05 Significant level',${improvement_conversion_outlink},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Outlinked"
  }


#Outlink First
##Conversion
  measure: count_pre_outlink_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "yes"
    }
    group_label: "Outlinked First"
  }
  measure: count_pre_outlink_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "yes"
    }
    group_label: "Outlinked First"
  }
  measure: count_first_outlink_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "yes"
    }
    filters: {
      field: outlinked
      value: ">0"
    }
    group_label: "Outlinked First"
  }
  measure: count_first_outlink_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "yes"
    }
    filters: {
      field: outlinked
      value: ">0"
    }
    group_label: "Outlinked First"
  }
  measure: conversion_first_outlink_0 {
    type: number
    sql:  ${count_first_outlink_session_0}/nullif(${count_pre_outlink_session_0},0);;
    value_format_name: percent_1
    group_label: "Outlinked First"
  }
  measure: conversion_first_outlink_1 {
    type: number
    sql:  ${count_first_outlink_session_1}/nullif(${count_pre_outlink_session_1},0);;
    value_format_name: percent_1
    group_label: "Outlinked First"
  }
  measure: chi_value_conversion_first_outlink {
    type: number
    sql:
      (power( ${count_first_outlink_session_0}-( ${count_pre_outlink_session_0}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1}) ) ,2) / ( ${count_pre_outlink_session_0}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1}) ))
      +(power( ${count_first_outlink_session_1}-( ${count_pre_outlink_session_1}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1}) ) ,2) / ( ${count_pre_outlink_session_1}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1}) ))
      +(power( ${count_pre_outlink_session_0}-${count_first_outlink_session_0}-( ${count_pre_outlink_session_0}-(${count_pre_outlink_session_0}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1})) ) ,2) / ( ${count_pre_outlink_session_0}-(${count_pre_outlink_session_0}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1})) ))
      +(power( ${count_pre_outlink_session_1}-${count_first_outlink_session_1}-( ${count_pre_outlink_session_1}-(${count_pre_outlink_session_1}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1})) ) ,2) / ( ${count_pre_outlink_session_1}-(${count_pre_outlink_session_1}*(${count_first_outlink_session_0}+${count_first_outlink_session_1})/(${count_pre_outlink_session_0}+${count_pre_outlink_session_1})) ))
       ;;
    group_label: "Outlinked First"
  }
  measure: significance_conversion_first_outlink {
    sql: if(abs(${chi_value_conversion_first_outlink})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Outlinked First"
  }
  measure: improvement_conversion_first_outlink {
    type: number
    sql: (${conversion_first_outlink_1}-${conversion_first_outlink_0})/nullif(${conversion_first_outlink_0},0);;
    value_format_name: percent_1
    group_label: "Outlinked First"
  }
  measure: sig_imp_conversion_first_outlink {
    type: number
    sql:  if(${significance_conversion_first_outlink}='0.05 Significant level',${improvement_conversion_first_outlink},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Outlinked First"
  }


#Outlink Repeat
##Conversion
  measure: count_post_outlink_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "no"
    }
    group_label: "Outlinked Repeat"
  }
  measure: count_post_outlink_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "no"
    }
    group_label: "Outlinked Repeat"
  }
  measure: count_repeat_outlink_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "no"
    }
    filters: {
      field: outlinked
      value: ">0"
    }
    group_label: "Outlinked Repeat"
  }
  measure: count_repeat_outlink_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_outlinked_at_session
      value: "no"
    }
    filters: {
      field: outlinked
      value: ">0"
    }
    group_label: "Outlinked Repeat"
  }
  measure: conversion_repeat_outlink_0 {
    type: number
    sql:  ${count_repeat_outlink_session_0}/nullif(${count_post_outlink_session_0},0);;
    value_format_name: percent_1
    group_label: "Outlinked Repeat"
  }
  measure: conversion_repeat_outlink_1 {
    type: number
    sql:  ${count_repeat_outlink_session_1}/nullif(${count_post_outlink_session_1},0);;
    value_format_name: percent_1
    group_label: "Outlinked Repeat"
  }
  measure: chi_value_conversion_repeat_outlink {
    type: number
    sql:
(power( ${count_repeat_outlink_session_0}-( ${count_post_outlink_session_0}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1}) ) ,2) / ( ${count_post_outlink_session_0}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1}) ))
+(power( ${count_repeat_outlink_session_1}-( ${count_post_outlink_session_1}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1}) ) ,2) / ( ${count_post_outlink_session_1}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1}) ))
+(power( ${count_post_outlink_session_0}-${count_repeat_outlink_session_0}-( ${count_post_outlink_session_0}-(${count_post_outlink_session_0}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1})) ) ,2) / ( ${count_post_outlink_session_0}-(${count_post_outlink_session_0}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1})) ))
+(power( ${count_post_outlink_session_1}-${count_repeat_outlink_session_1}-( ${count_post_outlink_session_1}-(${count_post_outlink_session_1}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1})) ) ,2) / ( ${count_post_outlink_session_1}-(${count_post_outlink_session_1}*(${count_repeat_outlink_session_0}+${count_repeat_outlink_session_1})/(${count_post_outlink_session_0}+${count_post_outlink_session_1})) ))
 ;;
    group_label: "Outlinked Repeat"
  }
  measure: significance_conversion_repeat_outlink {
    sql: if(abs(${chi_value_conversion_repeat_outlink})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Outlinked Repeat"
  }
  measure: improvement_conversion_repeat_outlink {
    type: number
    sql: (${conversion_repeat_outlink_1}-${conversion_repeat_outlink_0})/nullif(${conversion_repeat_outlink_0},0);;
    value_format_name: percent_1
    group_label: "Outlinked Repeat"
  }
  measure: sig_imp_conversion_repeat_outlink {
    type: number
    sql:  if(${significance_conversion_repeat_outlink}='0.05 Significant level',${improvement_conversion_repeat_outlink},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Outlinked Repeat"
  }

#Order
##Conversion
  measure: count_order_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: order_completed
      value: ">0"
    }
    group_label: "Order"
  }
  measure: count_order_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: order_completed
      value: ">0"
    }
    group_label: "Order"
  }
  measure: conversion_order_0 {
    type: number
    sql:  ${count_order_session_0}/nullif(${count_session_0},0);;
    value_format_name: percent_1
    group_label: "Order"
  }
  measure: conversion_order_1 {
    type: number
    sql:  ${count_order_session_1}/nullif(${count_session_1},0);;
    value_format_name: percent_1
    group_label: "Order"
  }
  measure: chi_value_conversion_order {
    type: number
    sql:
if(${count_session_0}+${count_session_1}=${count_order_session_0}+${count_order_session_1},0,
(power( ${count_order_session_0}-( ${count_session_0}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_0}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1}) ))
+(power( ${count_order_session_1}-( ${count_session_1}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1}) ) ,2) / ( ${count_session_1}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1}) ))
+(power( ${count_session_0}-${count_order_session_0}-( ${count_session_0}-(${count_session_0}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_0}-(${count_session_0}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1})) ))
+(power( ${count_session_1}-${count_order_session_1}-( ${count_session_1}-(${count_session_1}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1})) ) ,2) / ( ${count_session_1}-(${count_session_1}*(${count_order_session_0}+${count_order_session_1})/(${count_session_0}+${count_session_1})) ))
)
;;
    group_label: "Order"
  }
  measure: significance_conversion_order {
    sql: if(abs(${chi_value_conversion_order})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Order"
  }
  measure: improvement_conversion_order {
    type: number
    sql: (${conversion_order_1}-${conversion_order_0})/nullif(${conversion_order_0},0);;
    value_format_name: percent_1
    group_label: "Order"
  }
  measure: sig_imp_conversion_order {
    type: number
    sql:  if(${significance_conversion_order}='0.05 Significant level',${improvement_conversion_order},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Order"
  }

#Order First
##Conversion
  measure: count_pre_order_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "yes"
    }
    group_label: "Order First"
  }
  measure: count_pre_order_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "yes"
    }
    group_label: "Order First"
  }
  measure: count_first_order_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "yes"
    }
    filters: {
      field: order_completed
      value: ">0"
    }
    group_label: "Order First"
  }
  measure: count_first_order_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "yes"
    }
    filters: {
      field: order_completed
      value: ">0"
    }
    group_label: "Order First"
  }
  measure: conversion_first_order_0 {
    type: number
    sql:  ${count_first_order_session_0}/nullif(${count_pre_order_session_0},0);;
    value_format_name: percent_1
    group_label: "Order First"
  }
  measure: conversion_first_order_1 {
    type: number
    sql:  ${count_first_order_session_1}/nullif(${count_pre_order_session_1},0);;
    value_format_name: percent_1
    group_label: "Order First"
  }
  measure: chi_value_conversion_first_order {
    type: number
    sql:
      (power( ${count_first_order_session_0}-( ${count_pre_order_session_0}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1}) ) ,2) / ( ${count_pre_order_session_0}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1}) ))
      +(power( ${count_first_order_session_1}-( ${count_pre_order_session_1}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1}) ) ,2) / ( ${count_pre_order_session_1}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1}) ))
      +(power( ${count_pre_order_session_0}-${count_first_order_session_0}-( ${count_pre_order_session_0}-(${count_pre_order_session_0}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1})) ) ,2) / ( ${count_pre_order_session_0}-(${count_pre_order_session_0}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1})) ))
      +(power( ${count_pre_order_session_1}-${count_first_order_session_1}-( ${count_pre_order_session_1}-(${count_pre_order_session_1}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1})) ) ,2) / ( ${count_pre_order_session_1}-(${count_pre_order_session_1}*(${count_first_order_session_0}+${count_first_order_session_1})/(${count_pre_order_session_0}+${count_pre_order_session_1})) ))
       ;;
    group_label: "Order First"
  }
  measure: significance_conversion_first_order {
    sql: if(abs(${chi_value_conversion_first_order})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Order First"
  }
  measure: improvement_conversion_first_order {
    type: number
    sql: (${conversion_first_order_1}-${conversion_first_order_0})/nullif(${conversion_first_order_0},0);;
    value_format_name: percent_1
    group_label: "Order First"
  }
  measure: sig_imp_conversion_first_order {
    type: number
    sql:  if(${significance_conversion_first_order}='0.05 Significant level',${improvement_conversion_first_order},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Order First"
  }


#Order Repeat
##Conversion
  measure: count_post_order_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "no"
    }
    group_label: "Order Repeat"
  }
  measure: count_post_order_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "no"
    }
    group_label: "Order Repeat"
  }
  measure: count_repeat_order_session_0 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "0"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "no"
    }
    filters: {
      field: order_completed
      value: ">0"
    }
    group_label: "Order Repeat"
  }
  measure: count_repeat_order_session_1 {
    type: count_distinct
    sql: ${session_id} ;;
    filters: {
      field: variant_id
      value: "1"
    }
    filters: {
      field: is_pre_purchase_at_session
      value: "no"
    }
    filters: {
      field: order_completed
      value: ">0"
    }
    group_label: "Order Repeat"
  }
  measure: conversion_repeat_order_0 {
    type: number
    sql:  ${count_repeat_order_session_0}/nullif(${count_post_order_session_0},0);;
    value_format_name: percent_1
    group_label: "Order Repeat"
  }
  measure: conversion_repeat_order_1 {
    type: number
    sql:  ${count_repeat_order_session_1}/nullif(${count_post_order_session_1},0);;
    value_format_name: percent_1
    group_label: "Order Repeat"
  }
  measure: chi_value_conversion_repeat_order {
    type: number
    sql:
      (power( ${count_repeat_order_session_0}-( ${count_post_order_session_0}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1}) ) ,2) / ( ${count_post_order_session_0}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1}) ))
      +(power( ${count_repeat_order_session_1}-( ${count_post_order_session_1}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1}) ) ,2) / ( ${count_post_order_session_1}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1}) ))
      +(power( ${count_post_order_session_0}-${count_repeat_order_session_0}-( ${count_post_order_session_0}-(${count_post_order_session_0}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1})) ) ,2) / ( ${count_post_order_session_0}-(${count_post_order_session_0}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1})) ))
      +(power( ${count_post_order_session_1}-${count_repeat_order_session_1}-( ${count_post_order_session_1}-(${count_post_order_session_1}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1})) ) ,2) / ( ${count_post_order_session_1}-(${count_post_order_session_1}*(${count_repeat_order_session_0}+${count_repeat_order_session_1})/(${count_post_order_session_0}+${count_post_order_session_1})) ))
       ;;
    group_label: "Order Repeat"
  }
  measure: significance_conversion_repeat_order {
    sql: if(abs(${chi_value_conversion_repeat_order})>3.8414,'0.05 Significant level','Insignificant');;
    group_label: "Order Repeat"
  }
  measure: improvement_conversion_repeat_order {
    type: number
    sql: (${conversion_repeat_order_1}-${conversion_repeat_order_0})/nullif(${conversion_repeat_order_0},0);;
    value_format_name: percent_1
    group_label: "Order Repeat"
  }
  measure: sig_imp_conversion_repeat_order {
    type: number
    sql:  if(${significance_conversion_repeat_order}='0.05 Significant level',${improvement_conversion_repeat_order},null);;
    value_format_name: percent_2 #sig_imp
    group_label: "Order Repeat"
  }



}
