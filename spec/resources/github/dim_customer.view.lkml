view: customers {
  sql_table_name: etl.DimCustomer ;;

  dimension: account_status {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.ACCOUNT_STATUS ;;
  }

  dimension: account_type {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.ACCOUNT_TYPE ;;
  }

  dimension: brand_seq {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.BRAND_SEQ ;;
  }

  dimension: connect_card_number {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.CONNECT_CARD_NUMBER ;;
  }

  dimension: current_fobt_vip_flag {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.CURRENT_FOBT_VIP_FLAG ;;
  }

  dimension: current_ims_vip_level {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.CURRENT_IMS_VIP_LEVEL ;;
  }

  dimension: current_otc_vip_flag {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.CURRENT_OTC_VIP_FLAG ;;
  }

  dimension: current_risk_band {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.CURRENT_RISK_BAND ;;
  }

  dimension: current_risk_rating {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.CURRENT_RISK_RATING ;;
  }

  dimension: cust_shop_id {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.CUST_SHOP_ID ;;
  }

  dimension: customer_seq {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.CUSTOMER_SEQ ;;
  }

  dimension: date_of_birth {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.DATE_OF_BIRTH ;;
  }

  dimension: dcms_src_id {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.DCMS_SRC_ID ;;
  }

  dimension: email {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: first_card_reg_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.FIRST_CARD_REG_DATE ;;
  }

  dimension: first_deposit_channel {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.FIRST_DEPOSIT_CHANNEL ;;
  }

  dimension: first_deposit_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.first_deposit_date ;;
  }

  dimension: first_name {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: first_online_bet_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.first_online_bet_date ;;
  }

  dimension: first_overall_bet_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.first_overall_bet_date ;;
  }

  dimension: first_prod_group {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.FIRST_PROD_GROUP ;;
  }

  dimension: first_retail_bet_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.first_retail_bet_date ;;
  }

  dimension: ims_id {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.IMS_ID ;;
  }

  dimension: kyc_failed_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.KYC_FAILED_DATE ;;
  }

  dimension: kyc_in_progress_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.KYC_IN_PROGRESS_DATE ;;
  }

  dimension: kyc_passed_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.KYC_PASSED_DATE ;;
  }

  dimension: kyc_status {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.KYC_STATUS ;;
  }

  dimension: last_activity_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.LAST_ACTIVITY_DATE ;;
  }

  dimension: last_login_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.LAST_LOGIN_DATE ;;
  }

  dimension: last_online_bet_pre_connect {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.LAST_ONLINE_BET_PRE_CONNECT ;;
  }

  dimension: last_verification_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.LAST_VERIFICATION_DATE ;;
  }

  dimension: mc_cust_type {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.MC_CUST_TYPE ;;
  }

#   dimension: mc_reg_date {
#   view_label: "Customers"
#     type: string
#     sql: ${TABLE}.MC_REG_DATE,10 ;;
#   }

  dimension: mc_signup_shop {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.MC_SIGNUP_SHOP ;;
  }

  dimension: ndp_comment_1 {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.NDP_COMMENT_1 ;;
  }

  dimension: ndp_comment_2 {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.NDP_COMMENT_2 ;;
  }

  dimension: nom_de_plume_name {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.NOM_DE_PLUME_NAME ;;
  }

  dimension: online_reg_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.ONLINE_REG_DATE ;;
  }

  dimension: opted_in_for_email {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.OPTED_IN_FOR_EMAIL ;;
  }

  dimension: opted_in_for_sms {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.OPTED_IN_FOR_SMS ;;
  }

  dimension: opted_in_for_telephone {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.OPTED_IN_FOR_TELEPHONE ;;
  }

  dimension: optout_date_for_email {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.OPTOUT_DATE_FOR_EMAIL ;;
  }

  dimension: optout_date_for_sms {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.OPTOUT_DATE_FOR_SMS ;;
  }

  dimension: optout_date_for_telephone {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.OPTOUT_DATE_FOR_TELEPHONE ;;
  }

  dimension: overall_vip {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.OVERALL_VIP ;;
  }

  dimension: phone_number {
    view_label: "Customers"
#     hidden: yes
    type: string
    sql: ${TABLE}.PHONE_NUMBER ;;
  }

  dimension: postcode {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.POSTCODE ;;
  }

  dimension: predicted_churn_value {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.PREDICTED_CHURN_VALUE ;;
  }

  dimension: predicted_ltv {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.PREDICTED_LTV ;;
  }

  dimension: registration_platform {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.REGISTRATION_PLATFORM ;;
  }

  dimension: second_deposit_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.second_deposit_date ;;
  }

  dimension: second_online_bet_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.second_online_bet_date ;;
  }

  dimension: signup_shop {
    view_label: "Customers"
    hidden: yes
    type: string
    sql: ${TABLE}.SIGNUP_SHOP ;;
  }

  dimension: surname {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.SURNAME ;;
  }

  dimension: third_deposit_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.third_deposit_date ;;
  }

  dimension: third_online_bet_date {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.third_online_bet_date ;;
  }

  dimension: username {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.USERNAME ;;
  }

  dimension_group: mc_registration {
    view_label: "Customers"
    type: time
    timeframes: [date, week, month, year, day_of_week, day_of_month]
    sql: cast(substr(${TABLE}.mc_reg_date,1,10) as timestamp) ;;
  }

# MEASURES

  measure: number_customers {
    view_label: "Customers"
    type: count_distinct
    sql: ${username} ;;
  }
}
