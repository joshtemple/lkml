view: pvc_view {
  derived_table: {
    sql:SELECT
conversion_time,
impression_time,
click_time,
advertiser_id,
campaign_id,
line_item_id,
order_id,
upa,
conversion_window,
conversion_type
FROM (
SELECT
conversion_time,
impression_time,
click_time,
advertiser_id,
campaign_id,
line_item_id,
order_id,
upa,
conversion_window,
conversion_type
FROM (
SELECT
PARSE_DATETIME('%F %T', a.root.request.datetime) conversion_time,
--PARSE_DATETIME('%F %T', a.root.impression_dt) impression_time,
cast('1900-01-01 00:00:00.000' as datetime) impression_time, -- intermediate solution 8/1/19 impression time not available in table
PARSE_DATETIME('%F %T', b.root.request.datetime) click_time,
a.root.demand.advertiser_id advertiser_id,
a.root.demand.campaign_id campaign_id,
a.root.demand.line_item_id line_item_id,
a.root.order_id order_id,
a.root.upa upa,
"PCC" conversion_window,
"PCC" conversion_type
FROM `elite-contact-671.userver_logs_dsp.conversion_*` a
LEFT JOIN `elite-contact-671.userver_logs_dsp.click_*` b ON a.root.bid.id = b.root.bid.id
GROUP BY 1,2,3,4,5,6,7,8,9
)
GROUP BY 1,2,3,4,5,6,7,8,9,10
UNION ALL
SELECT
conversion_time,
impression_time,
click_time,
advertiser_id,
campaign_id,
line_item_id,
order_id,
upa,
conversion_window,
conversion_type
FROM
(
SELECT
PARSE_DATETIME('%F %T', pvc.root.request.datetime) conversion_time,
PARSE_DATETIME('%F %T', pvc.root.impression_time)  impression_time,
PARSE_DATETIME('%F %T', bpcv.root.request.datetime) click_time,
pvc.root.demand.advertiser_id advertiser_id,
pvc.root.demand.campaign_id campaign_id,
pvc.root.demand.line_item_id line_item_id,
pvc.root.order_id order_id,
pvc.root.upa upa,
case when pvc.root.pvc_1h = 1 then "PVC within 1h" when pvc.root.pvc_24h = 1 then "PVC within 24h"
when pvc.root.pvc_72h = 1 then "PVC within 72h" when pvc.root.pvc_over_72h = 1 then "PVC over 72h" else "error" end as conversion_window,
"PVC" conversion_type
FROM
  `elite-contact-671.userver_logs_dsp.pv_conversion_*` pvc
LEFT JOIN `elite-contact-671.userver_logs_dsp.click_*` bpcv ON pvc.root.bid.id = bpcv.root.bid.id
INNER JOIN (
SELECT
root.bid.id bid_id,
root.request.datetime max_time
FROM
  `elite-contact-671.userver_logs_dsp.pv_conversion_*`
  GROUP BY 1,2) dt
ON pvc.root.bid.id = dt.bid_id
AND pvc.root.request.datetime = dt.max_time)
GROUP BY 1,2,3,4,5,6,7,8,9,10
)
ORDER BY 1 ASC

             ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    view_label: "Post View Conversions"
  }

  dimension: conversion_date {
    type: date
    sql: CAST(${TABLE}.conversion_time AS TIMESTAMP);;
    view_label: "Post View Conversions"
    group_label: "Order Metadata"
    label: "Conversion Date"
  }

  dimension_group: conversion {
    type: time
    timeframes: [time]
    sql:CAST(${TABLE}.conversion_time AS TIMESTAMP);;
    view_label: "Post View Conversions"
    label: "Conversion"
    group_label: "Order Metadata"
  }


  dimension: impression_date {
    type: date
    sql:CAST(${TABLE}.impression_time AS TIMESTAMP);;
    #sql: TIMESTAMP(${TABLE}.impression_time) ;;
    view_label: "Post View Conversions"
    label: "Impression Date"
    group_label: "Order Metadata"
    hidden: yes
  }

  dimension_group: impression {
    type: time
    timeframes: [time]
    sql:CAST(${TABLE}.impression_time AS TIMESTAMP);;
    view_label: "Post View Conversions"
    label: "Impression"
    group_label: "Order Metadata"
    hidden: yes
  }

  dimension: click_date {
    type: date
    sql:CAST(${TABLE}.click_time AS TIMESTAMP);;
    #sql: TIMESTAMP(${TABLE}.impression_time) ;;
    view_label: "Post View Conversions"
    label: "Click Date"
    group_label: "Order Metadata"
  }

  dimension_group: click {
    type: time
    timeframes: [time]
    sql:CAST(${TABLE}.click_time AS TIMESTAMP);;
    view_label: "Post View Conversions"
    label: "Click"
    group_label: "Order Metadata"
  }


  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    view_label:  "Post View Conversions"
    group_label: "Demand Metadata"
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
    view_label:  "Post View Conversions"
    group_label: "Demand Metadata"
  }

  dimension: line_item_id {
    type: number
    sql: ${TABLE}.line_item_id ;;
    view_label:  "Post View Conversions"
    group_label: "Demand Metadata"
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
    view_label: "Post View Conversions"
    group_label: "Order Metadata"
  }

  dimension: upa_hidden {
    type: number
    sql: ${TABLE}.upa ;;
    hidden: yes
  }

  measure: upa {
    type: sum
    sql: ${upa_hidden} ;;
    view_label: "Post View Conversions"
    group_label: "Order Metadata"
    label: "UPA"
    value_format_name: usd
  }

  dimension: conversion_window {
    type: string
    sql: ${TABLE}.conversion_window ;;
    view_label: "Post View Conversions"
    group_label: "Order Metadata"
  }

  dimension: conversion_type {
    type: string
    sql: ${TABLE}.conversion_type ;;
    view_label: "Post View Conversions"
    group_label: "Order Metadata"
  }

  set: detail {
    fields: [
      conversion_time,
      impression_time,
      advertiser_id,
      campaign_id,
      line_item_id,
      order_id,
      upa,
      conversion_window,
      conversion_type
    ]
  }
}
