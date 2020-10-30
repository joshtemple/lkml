view: device_orders {
  sql_table_name: `buoyant-site-244113.demo.device_orders`
    ;;

  dimension: acct_num {
    view_label: "Customer"
    label: "Account Number"
    type: number
    sql: ${TABLE}.ACCT_NUM ;;
  }

  dimension_group: activity {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.activity_dt ;;
  }

  dimension: age {
    view_label: "Customer"
    type: string
    sql: ${TABLE}.AGE ;;
  }

  dimension: amonth {
    hidden: yes
    type: number
    sql: ${TABLE}.AMONTH ;;
  }

  dimension: aweek_day {
    view_label: "Other"
    type: number
    sql: ${TABLE}.AWEEK_DAY ;;
  }

  dimension_group: aweek_end {
    view_label: "Other"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.AWEEK_END ;;
  }

  dimension_group: aweek_start {
    view_label: "Other"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.AWEEK_START ;;
  }

  dimension: brand_pref {
    view_label: "Customer"
    label: "Brand Preference"
    type: string
    sql: ${TABLE}.BRAND_PREF ;;
  }

  dimension: byod {
    label: "Bring Your Own Device"
    type: yesno
    sql: ${TABLE}.BYOD ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.CHANNEL ;;
  }

  dimension: channel_pref {
    view_label: "Customer"
    label: "Channel Preferences"
    type: string
    sql: ${TABLE}.CHANNEL_PREF ;;
  }

  dimension: curr_contract_term {
    label: "Current Contract Term"
    view_label: "Plan"
    type: string
    sql: ${TABLE}.CURR_CONTRACT_TERM ;;
  }

  dimension: curr_device {
    view_label: "Device"
    label: "Current Device"
    type: string
    sql: ${TABLE}.CURR_DEVICE ;;
  }

  dimension: curr_device_manf {
    view_label: "Device"
    label: "Current Device Manufacturer"
    type: string
    sql: ${TABLE}.CURR_DEVICE_MANF ;;
  }

  dimension: cust_id {
    label: "Customer ID"
    view_label: "Customer"
    type: number
    sql: ${TABLE}.CUST_ID ;;
    link: {
      label: "Customer Lookup"
      url:"/dashboards-next/19?Customer+ID={{ value | encode_uri }}"
      icon_url: "http://www.google.com/s2/favicons?domain=www.verizon.com"
      # URL for Looker favicon --> icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: cust_line_seq_id {
    label: "Customer Line Sequence ID"
    view_label: "Customer"
    type: number
    sql: ${TABLE}.CUST_LINE_SEQ_ID ;;
  }

  dimension: cust_status_ind {
    label: "Customer Status Indicator"
    view_label: "Customer"
    type: string
    sql: ${TABLE}.CUST_STATUS_IND ;;
  }

  dimension: data_tier {
    view_label: "Plan"
    type: string
    sql: ${TABLE}.DATA_TIER ;;
  }

  dimension: device_brand_nm {
    view_label: "Device"
    type: string
    sql: ${TABLE}.DEVICE_BRAND_NM ;;
  }

  dimension: device_generation {
    label: "Generation"
    view_label: "Device"
    type: string
    sql: ${TABLE}.DEVICE_GENERATION ;;
  }

  dimension: device_grouping {
    label: "Grouping"
    view_label: "Device"
    type: string
    sql: ${TABLE}.DEVICE_GROUPING ;;
  }

  dimension: device_prod_nm {
    label: "Product Number"
    view_label: "Device"
    type: string
    sql: ${TABLE}.DEVICE_PROD_NM ;;
  }

  dimension: previous_device_is_android_or_iphone {
    type: string
    sql: case when ${device_prod_nm_prev} LIKE '%IPHONE%' then 'iPhone'
              when ${device_prod_nm_prev} = '?' then null
              else 'Android' end ;;
  }

  dimension: device_prod_nm_prev {
    label: "Previous Product Number"
    view_label: "Device"
    type: string
    sql: ${TABLE}.DEVICE_PROD_NM_PREV ;;
  }

  dimension: early_elig_upg_cd {
    label: "Early Eligible Upgrade Code"
    view_label: "Customer"
    type: string
    sql: ${TABLE}.EARLY_ELIG_UPG_CD ;;
  }

  dimension: eqp_class_desc {
    view_label: "Other"
    type: string
    sql: ${TABLE}.eqp_class_desc ;;
  }

  dimension: eqp_prod_nm {
    view_label: "Other"
    type: string
    sql: ${TABLE}.eqp_prod_nm ;;
  }

  dimension: ethnic_descent {
    view_label: "Customer"
    type: string
    sql: ${TABLE}.ETHNIC_DESCENT ;;
  }

  dimension: ethnicity_segmt {
    view_label: "Customer"
    label: "Ethnicity Segment"
    type: string
    sql: ${TABLE}.ETHNICITY_SEGMT ;;
    drill_fields: [lifestage]
  }

  dimension: gross_qty {
    type: number
    hidden: yes
    sql: ${TABLE}.GROSS_QTY ;;
  }

  dimension: lifestage {
    view_label: "Customer"
    type: string
    sql: ${TABLE}.LIFESTAGE ;;
  }

  dimension: line_status_ind {
    label: "Line Status Indicator"
    type: string
    sql: ${TABLE}.LINE_STATUS_IND ;;
  }

  dimension: mtn {
    primary_key: yes
    type: number
    sql: ${TABLE}.MTN ;;
  }

  dimension: net_qty {
    hidden: yes
    type: number
    sql: ${TABLE}.NET_QTY ;;
  }

  dimension: new_qty {
    hidden: yes
    type: number
    sql: ${TABLE}.NEW_QTY ;;
  }

  dimension: plan {
    view_label: "Plan"
    label: ""
    type: string
    sql: ${TABLE}.PLAN ;;
  }

  dimension: plan_ctgry {
    view_label: "Plan"
    label: "Category"
    type: string
    sql: ${TABLE}.PLAN_CTGRY ;;
    drill_fields: [plan]
  }

  dimension: plan_data_group {
    view_label: "Plan"
    type: string
    sql: ${TABLE}.PLAN_DATA_GROUP ;;
    drill_fields: [plan]
  }

  dimension: plan_feat_pref {
    view_label: "Plan"
    type: string
    sql: ${TABLE}.PLAN_FEAT_PREF ;;
  }

  dimension: port_carrier_cd {
    view_label: "Plan"
    type: string
    sql: ${TABLE}.PORT_CARRIER_CD ;;
  }

  dimension: port_service_provider {
    view_label: "Plan"
    type: string
    sql: ${TABLE}.PORT_SERVICE_PROVIDER ;;
  }

  dimension: port_status_desc {
    label: "Port Status Description"
    view_label: "Plan"
    type: string
    sql: ${TABLE}.PORT_STATUS_DESC ;;
  }

  dimension: prepaid_ind {
    view_label: "Plan"
    type: yesno
    sql: ${TABLE}.prepaid_ind ;;
  }

  dimension: purchase_behav {
    view_label: "Customer"
    label: "Purchase Behavior"
    type: string
    sql: ${TABLE}.PURCHASE_BEHAV ;;
  }

  dimension: refund_qty {
    hidden: yes
    type: number
    sql: ${TABLE}.REFUND_QTY ;;
  }

  dimension: response_behav {
    view_label: "Customer"
    label: "Response Behavior"
    type: string
    sql: ${TABLE}.RESPONSE_BEHAV ;;
  }

  dimension_group: rpt_mth {
    view_label: "Other"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.RPT_MTH ;;
  }

  dimension: segment {
    view_label: "Customer"
    type: string
    sql: ${TABLE}.Segment ;;
  }

  dimension: service_pref {
    view_label: "Customer"
    label: "Service Preference"
    type: string
    sql: ${TABLE}.SERVICE_PREF ;;
  }

  dimension: sold_price_amt {
    hidden: yes
    value_format_name: usd
    type: number
    sql: ${TABLE}.SOLD_PRICE_AMT ;;
  }

  dimension: st_cd {
    label: "State"
    map_layer_name: us_states
    view_label: "Customer"
    type: string
    sql: ${TABLE}.ST_CD ;;
  }

  dimension: subscr_tenure {
    view_label: "Customer"
    label: "Subscription Tenure"
    type: string
    sql: ${TABLE}.SUBSCR_TENURE ;;
  }

  dimension: tailored_comm_pref {
    type: string
    sql: ${TABLE}.TAILORED_COMM_PREF ;;
  }

  dimension: upg_qty {
    type: number
    hidden: yes
    sql: ${TABLE}.UPG_QTY ;;
  }

  dimension: purchase_type {
    type: string
    sql: case when ${new_qty} = 1 then 'New'
              when ${upg_qty} = 1 then 'Upgrade'
              when ${refund_qty} = 1 then 'Refund'
              else 'New'
              end;;
    drill_fields: [plan_ctgry, plan]
  }

  measure: total_purchases {
    type: count
    filters: [purchase_type: "New, Upgrade"]
    drill_fields: [detail_drill*]
  }

  measure: total_new_purchases {
    type: count
    filters: [purchase_type: "New"]
    drill_fields: [detail_drill*]
  }

  measure: total_upgrades {
    type: count
    filters: [purchase_type: "Upgrade"]
    drill_fields: [detail_drill*]
  }

  measure: count {
    type: count
    drill_fields: [detail_drill*]
  }

  measure: customer_count {
    view_label: "Customer"
    type: count_distinct
    sql: ${cust_id} ;;
    drill_fields: [detail_drill*]
  }

  measure: total_sold_amount {
    type: sum
    sql: ${sold_price_amt} ;;
    value_format_name: usd_0
    drill_fields: [detail_drill*]
    filters: [sold_price_amt: ">0"]
  }

  measure: average_sold_amount {
    type: average
    sql: ${sold_price_amt} ;;
    value_format_name: usd_0
    drill_fields: [detail_drill*]
    filters: [sold_price_amt: ">0"]
  }

  set: detail_drill {
    fields: [mtn, cust_id, purchase_type, activity_date, total_sold_amount]
  }
}
