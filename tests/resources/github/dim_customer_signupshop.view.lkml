view: customer_signupshop {
  derived_table: {
    datagroup_trigger: midnight_refresh

    sql:
          WITH customers AS (
            SELECT
              dim_customer.ACCOUNT_STATUS,
              dim_customer.ACCOUNT_TYPE,
              dim_customer.BRAND_SEQ,
              dim_customer.CONNECT_CARD_NUMBER,
              dim_customer.CURRENT_FOBT_VIP_FLAG,
              dim_customer.CURRENT_IMS_VIP_LEVEL,
              dim_customer.CURRENT_OTC_VIP_FLAG,
              dim_customer.CURRENT_RISK_BAND,
              dim_customer.CURRENT_RISK_RATING,
              dim_customer.CUST_SHOP_ID,
              dim_customer.CUSTOMER_SEQ,
              dim_customer.DATE_OF_BIRTH,
              dim_customer.DCMS_SRC_ID,
              dim_customer.EMAIL,
              dim_customer.FIRST_CARD_REG_DATE,
              dim_customer.FIRST_DEPOSIT_CHANNEL,
              dim_customer.first_deposit_date,
              dim_customer.FIRST_NAME,
              dim_customer.first_online_bet_date,
              dim_customer.first_overall_bet_date,
              dim_customer.FIRST_PROD_GROUP,
              dim_customer.first_retail_bet_date,
              dim_customer.IMS_ID,
              dim_customer.KYC_FAILED_DATE,
              dim_customer.KYC_IN_PROGRESS_DATE,
              dim_customer.KYC_PASSED_DATE,
              dim_customer.KYC_STATUS,
              dim_customer.LAST_ACTIVITY_DATE,
              dim_customer.LAST_LOGIN_DATE,
              dim_customer.LAST_ONLINE_BET_PRE_CONNECT,
              dim_customer.LAST_VERIFICATION_DATE,
              dim_customer.MC_CUST_TYPE,
              dim_customer.MC_REG_DATE,
              dim_customer.MC_SIGNUP_SHOP,
              dim_customer.NDP_COMMENT_1,
              dim_customer.NDP_COMMENT_2,
              dim_customer.NOM_DE_PLUME_NAME,
              dim_customer.ONLINE_REG_DATE,
              dim_customer.OPTED_IN_FOR_EMAIL,
              dim_customer.OPTED_IN_FOR_SMS,
              dim_customer.OPTED_IN_FOR_TELEPHONE,
              dim_customer.OPTOUT_DATE_FOR_EMAIL,
              dim_customer.OPTOUT_DATE_FOR_SMS,
              dim_customer.OPTOUT_DATE_FOR_TELEPHONE,
              dim_customer.OVERALL_VIP,
              dim_customer.PHONE_NUMBER,
              dim_customer.POSTCODE,
              dim_customer.PREDICTED_CHURN_VALUE,
              dim_customer.PREDICTED_LTV,
              dim_customer.REGISTRATION_PLATFORM,
              dim_customer.second_deposit_date,
              dim_customer.second_online_bet_date,
              dim_customer.SIGNUP_SHOP,
              dim_customer.SURNAME,
              dim_customer.third_deposit_date,
              dim_customer.third_online_bet_date,
              dim_customer.USERNAME
            FROM etl.DimCustomer  AS dim_customer
            GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57
            )

        SELECT
          customers.*,

          shops.Area  AS Area,
          shops.Brand  AS Brand,
          shops.Competitive_flag  AS Competitive_flag,
          shops.Competitive_group  AS Competitive_group,
          shops.l4l_flag  AS l4l_flag,
          shops.No_of_competitors  AS No_of_competitors,
          shops.No_of_ssbts  AS No_of_ssbts,
          shops.Postcode  AS Shop_Postcode,
          shops.Region  AS Region,
          shops.Shop  AS Shop,
          shops.Status  AS Status,
          shops.Subregion  AS Subregion

        FROM customers
        LEFT JOIN etl.DimShop  AS shops ON customers.MC_SIGNUP_SHOP = shops.Shop
         ;;
  }


################## CUSTOMERS DIMENSIONS ################

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
    primary_key: yes
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


################## SHOP DIMENSIONS ################

  dimension: area {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Area ;;
    drill_fields: [shop]
  }

  dimension: brand {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Brand ;;
  }

  dimension: competitive_flag {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Competitive_flag ;;
  }

  dimension: competitive_group {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Competitive_group ;;
  }

  dimension: l4l_flag {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.l4l_flag ;;
  }

  dimension: no_of_competitors {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.No_of_competitors ;;
  }

  dimension: no_of_ssbts {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.No_of_ssbts ;;
  }

  dimension: shop_postcode {
    view_label: "Signup Shop"
    label: "postcode"
    type: string
    sql: ${TABLE}.shop_postcode ;;
  }

  dimension: postcode_area {
    view_label: "Signup Shop"
    type: string
    sql: UPPER(
        CASE WHEN REGEXP_CONTAINS(SUBSTR(${shop_postcode}, 1, 2), "^*[0-9]") THEN SUBSTR(${shop_postcode}, 1, 1)
        ELSE SUBSTR(${shop_postcode}, 1, 2) END)  ;;
    map_layer_name: uk_postcode_areas
  }

  dimension: region {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Region ;;
    drill_fields: [subregion,area,shop]
  }

  dimension: shop {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Shop ;;
    link: {
      label: "Shop Details"
      url: "/dashboards/4?Shop%20ID={{value}}"
      icon_url: "https://www.looker.com/favicon.ico"
    }
  }

  dimension: status {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: subregion {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Subregion ;;
    drill_fields: [area,shop]
  }

  dimension: shop_location_comparison {
    view_label: "Signup Shop"
    type: string
    sql:
      CASE

      WHEN  ${shop} = ${shop_info.shop}
      THEN CONCAT('(1) ',${shop})

      WHEN  ${area} = ${shop_info.area}
      THEN CONCAT('(2) Rest of ',${area})

      WHEN  ${region} = ${shop_info.region}
      THEN CONCAT('(3) Rest of ',${region})

      ELSE '(4) Rest Of Population'

      END;;
  }



# MEASURES

  measure: number_customers {
    view_label: "Customers"
    type: count_distinct
    sql: ${username} ;;
  }

  measure: shop_count {
    view_label: "Signup Shop"
    type: count_distinct
    sql: ${shop} ;;
    drill_fields: [shop]
  }


}
