view: mn_comb_pg_rp_comp_dim {
  derived_table: {
    sql: SELECT  RQB.PROGRAM_QUAL_BEN_WID AS COMPONENT_KEY,
        RQB.PROGRAM_QUAL_BEN_WID,
        NULL AS PG_TB_WID,
        RQB.PROGRAM_WID AS PROGRAM_KEY,
        --RQB.SRC_SYS_QUAL_BEN_ID AS SRC_SYS_COMPONENT_ID,
        RQB.NAME,
        RQB.COMPONENT_TYPE,
        RQB.COMPONENT_NAME,
        RPT.SPREADSHEET_TYPE,
        RQB.DESCRIPTION,
        RQB.STRATEGY_BASED_FLAG,
        lvls.NUM_TIERS,
        RQB.SALE_LINE_TYPE,
        RQB.ITEM_OVERRIDE_FLAG,
        RPT.ALT_UOM,
        RPT.ENABLE_NETTING_FLAG,
        RPT.CALC_PRICE_BASIS,
        RPT.PRICE_REF_DATE,
        RPT.QTY_BASIS,
        RPT.FORMULARY_MB_WID,
        RPT.FORMULARY_PRODUCT_WID,
        RPT.CONDITION_1,
        RPT.CONDITION_2,
        RPT.CONDITION_3,
        RPT.CONDITION_4,
        RPT.CONDITION_5,
        RPT.FORMULARY_OPERATOR,
        RPT.MS_BASIS,
        RPT.UNIT_BASIS,
        RPT.SCHEDULE_BASIS,
        RPT.MCO_VOL_BASIS,
        RPT.GROWTH_TYPE,
        RPT.BASELINE_PERIOD,
        RPT.BASE_DOS,
        RPT.SEGMENT,
        RPT.PRICE_RES_METHOD,
        RPT.BASE_PRICE_REF_DATE,
        RPT.MAX_INCREASE,
        RPT.PRICE_LIST_TYPE,
        RPT.IS_ROUND_QTY_FLAG,
        RPT.MANUAL_BASELINE_VAL,
        RPT.NUMBER_OF_WEEKS_SPAN,
        RQB.VER_NUM,
        RQB.END_VER_NUM,
        RQB.VER_START_DATE,
        RQB.VER_END_DATE,
        RQB.CONTRACT_TYPE,
        RPT.TIER_FLAG,
        lvls.EFF_START_DATE,
        lvls.EFF_END_DATE,
        lvls.TIER1_VALUE,
        lvls.TIER2_VALUE,
        lvls.TIER3_VALUE,
        lvls.TIER4_VALUE,
        lvls.TIER5_VALUE,
        lvls.TIER6_VALUE,
        lvls.TIER7_VALUE,
        lvls.TIER8_VALUE,
        lvls.TIER9_VALUE,
        NULL AS SOURCE_SYSTEM_ID,
        NULL AS DATE_CREATED,
        NULL AS DATE_UPDATED,
        IS_QUAL_COMPONENT AS IS_QUAL_COMP_FLAG,
        NULL AS IS_MB_COMPONENT,
        NULL AS SRC_SYS_DATE_UPDATED,
        NULL AS CALC_OBJ_TYPE,
        NULL AS MODULE_TYPE,
        NULL AS CALC_LEVEL,
        NULL AS USE_STRAT_FILTER_FLAG,
        NULL AS BASIS_TYPE,
        NULL AS UNITS,
        NULL AS UOM,
        NULL AS BASIS_DESC,
        NULL AS SEPARATE_TB_PROD_FLAG,
        NULL AS BASIS_UNIT,
        NULL AS ORDER_INDEX,
        NULL AS RUN_ID,
        NULL AS COMPONENT_TYPE_FLAG,
        'Rebate Program' as PROGRAM_TYPE,
        2 AS PROGRAM_TYPE_NUM,
        CASE WHEN IS_QUAL_COMPONENT = 'Y' THEN 'RP QUAL' ELSE 'RP BEN' END AS ELIG_COMPONENT_TYPE,
        CASE WHEN IS_QUAL_COMPONENT = 'Y' THEN 1 ELSE 2 END AS ELIG_COMP_TYPE_NUM,
        TOTAL_DISC_CAP_PERCENT,
        IS_DEPENDENT,
        ENABLE_CUSTOM_RESET,
        ENABLE_BEP_CALC,
        CAP_PERCENT,
        INCLUDE_ADMIN_FEE,
        CUMULATION_FREQ,
        PP_SCHEDULE_BASIS,
        PP_TYPE,
        SCH_BASIS_CUSTOM_DATE,
        ADHOC_DATE,
        PP_THRESHOLD,
        RPT.PMON_ALT_UOM,
        RPT.PMON_BENEFIT_TYPE,
        RPT.PMON_CALC_PRICE_BASIS,
        RPT.PMON_ESTIMATED_VAL,
        RPT.PMON_MCO_VOL_BASIS,
        RPT.PMON_PL_TYPE,
        RPT.PMON_PRICE_RES_METHOD
      FROM MN_RBT_PROG_QUAL_BEN_DIM_VW RQB
      LEFT JOIN MN_RBT_PROG_QUAL_BEN_SD_RPT_VW RPT ON RPT.PROGRAM_QUAL_BEN_WID = RQB.PROGRAM_QUAL_BEN_WID
           LEFT JOIN (
           SELECT PROGRAM_QUAL_BEN_WID,
              NUM_TIERS,
              NULLIF(EFF_START_DATE, To_Date('07/03/1776','mm/dd/yyyy')) AS EFF_START_DATE,
              NULLIF(EFF_END_DATE, To_Date('12/31/4700','mm/dd/yyyy')) AS EFF_END_DATE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=1 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER1_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=2 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER2_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=3 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER3_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=4 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER4_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=5 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER5_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=6 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER6_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=7 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER7_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=8 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER8_VALUE,
              MAX(CASE WHEN  NVL(TIER_IDX,1)=9 THEN NVL(TIER_LOW_VALUE, TIER_LOW_VAL_STRING) ELSE NULL END) AS TIER9_VALUE
          FROM MN_RBT_PROG_QUAL_BEN_SD_RPT_VW WHERE TIER_FLAG ='Y'
          GROUP BY PROGRAM_QUAL_BEN_WID,
              NUM_TIERS,
              NULLIF(EFF_START_DATE, To_Date('07/03/1776','mm/dd/yyyy')),
              NULLIF(EFF_END_DATE, To_Date('12/31/4700','mm/dd/yyyy'))
              )
          lvls ON lvls.PROGRAM_QUAL_BEN_WID = RQB.PROGRAM_QUAL_BEN_WID
      WHERE RPT.TIER_FLAG ='N' AND SPREADSHEET_NAME IS NULL

      UNION ALL

      SELECT
          PGQB.PG_TB_WID AS COMPONENT_KEY,
          NULL AS PROGRAM_QUAL_BEN_WID,
          PGQB.PG_TB_WID,
          PGQB.PG_WID AS PROGRAM_KEY,
          --PGQB.SRC_SYS_TB_ID AS SRC_SYS_COMPONENT_ID,
          PGQB.NAME,
          PGQB.COMPONENT_TYPE,
          PGQB.COMPONENT_NAME,
          NULL AS SPREADSHEET_TYPE,
          NULL AS DESCRIPTION,
          PGQB.STRATEGY_BASED_FLAG,
          PGQB.NUM_TIERS,
          PGQB.SALE_LINE_TYPE,
          NULL AS ITEM_OVERRIDE_FLAG,
          NULL AS ALT_UOM,
          NULL AS ENABLE_NETTING_FLAG,
          NULL AS CALC_PRICE_BASIS,
          NULL AS PRICE_REF_DATE,
          NULL AS QTY_BASIS,
          NULL AS FORMULARY_MB_WID,
          NULL AS FORMULARY_PRODUCT_WID,
          NULL AS CONDITION_1,
          NULL AS CONDITION_2,
          NULL AS CONDITION_3,
          NULL AS CONDITION_4,
          NULL AS CONDITION_5,
          NULL AS FORMULARY_OPERATOR,
          NULL AS MS_BASIS,
          NULL AS UNIT_BASIS,
          NULL AS SCHEDULE_BASIS,
          NULL AS MCO_VOL_BASIS,
          NULL AS GROWTH_TYPE,
          NULL AS BASELINE_PERIOD,
          NULL AS BASE_DOS,
          NULL AS SEGMENT,
          NULL AS PRICE_RES_METHOD,
          NULL AS BASE_PRICE_REF_DATE,
          NULL AS MAX_INCREASE,
          NULL AS PRICE_LIST_TYPE,
          NULL AS IS_ROUND_QTY_FLAG,
          NULL AS MANUAL_BASELINE_VAL,
          NULL AS NUMBER_OF_WEEKS_SPAN,
          PGQB.VER_NUM,
          PGQB.END_VER_NUM,
          PGQB.VER_START_DATE,
          PGQB.VER_END_DATE,
          NULL AS CONTRACT_TYPE,
          NULL AS TIER_FLAG,
          NVL(lvls.EFF_START_DATE,PGQB.EFF_START_DATE) AS EFF_START_DATE,
          NVL(lvls.EFF_END_DATE,PGQB.EFF_END_DATE) AS EFF_END_DATE,
          NVL(lvls.TIER1_VALUE,PGQB.TIER1_VALUE) AS TIER1_VALUE,
          NVL(lvls.TIER2_VALUE,PGQB.TIER2_VALUE) AS TIER2_VALUE,
          NVL(lvls.TIER3_VALUE,PGQB.TIER3_VALUE) AS TIER3_VALUE,
          NVL(lvls.TIER4_VALUE,PGQB.TIER4_VALUE) AS TIER4_VALUE,
          NVL(lvls.TIER5_VALUE,PGQB.TIER5_VALUE) AS TIER5_VALUE,
          NVL(lvls.TIER6_VALUE,PGQB.TIER6_VALUE) AS TIER6_VALUE,
          NVL(lvls.TIER7_VALUE,PGQB.TIER7_VALUE) AS TIER7_VALUE,
          NVL(lvls.TIER8_VALUE,PGQB.TIER8_VALUE) AS TIER8_VALUE,
          NVL(lvls.TIER9_VALUE,PGQB.TIER9_VALUE) AS TIER9_VALUE,
          PGQB.SOURCE_SYSTEM_ID,
          PGQB.DATE_CREATED,
          PGQB.DATE_UPDATED,
          PGQB.IS_QUAL_COMP_FLAG,
          PGQB.IS_MB_COMPONENT,
          PGQB.SRC_SYS_DATE_UPDATED,
          PGQB.CALC_OBJ_TYPE,
          PGQB.MODULE_TYPE,
          PGQB.CALC_LEVEL,
          PGQB.USE_STRAT_FILTER_FLAG,
          NVL(PGQB.BASIS_TYPE, PGQSD.BASIS_TYPE) AS BASIS_TYPE,
          PGQSD.UNITS AS UNITS,
          PGQSD.UOM AS UOM,
          PGQB.BASIS_DESC,
          PGQB.SEPARATE_TB_PROD_FLAG,
          NVL(PGQB.BASIS_UNIT, PGQSD.BASIS_UNIT) AS BASIS_UNIT,
          PGQB.ORDER_INDEX,
          PGQB.RUN_ID,
          CASE WHEN NVL(PGQB.BASIS_TYPE, PGQSD.BASIS_TYPE) in
                (
                      'Free Good Revenue Across Order',
                      'Revenue by Price Program',
                      'Free Goods Revenue Capitation' ,
                      'Step Revenue'
                ) THEN 'Revenue'
              ELSE
                (
                  CASE WHEN NVL(PGQB.BASIS_TYPE, PGQSD.BASIS_TYPE) in
                    (
                      'Volume by Price Program',
                      'Quantity In Tier Basis',
                      'Quantity By Line Item',
                      'Free Goods Volume Across Order',
                      'Recurring Volume',
                      'Free Goods volume Capitation',
                      'Step Volume',
                      'Volume by line item'
                    ) THEN 'Volume' ELSE null end
                  ) END AS COMPONENT_TYPE_FLAG,
                  'Price Program' as PROGRAM_TYPE,
          1 AS PROGRAM_TYPE_NUM,
          CASE WHEN IS_QUAL_COMP_FLAG = 'Y' THEN 'PP QUAL' ELSE 'PP BEN' END AS ELIG_COMPONENT_TYPE,
          CASE WHEN IS_QUAL_COMP_FLAG = 'Y' THEN 3 ELSE 4 END AS ELIG_COMP_TYPE_NUM,
          NULL AS TOTAL_DISC_CAP_PERCENT,
          NULL AS IS_DEPENDENT,
          NULL AS ENABLE_CUSTOM_RESET,
          NULL AS ENABLE_BEP_CALC,
          NULL AS CAP_PERCENT,
          NULL AS INCLUDE_ADMIN_FEE,
          NULL AS CUMULATION_FREQ,
          NULL AS PP_SCHEDULE_BASIS,
          NULL AS PP_TYPE,
          NULL AS SCH_BASIS_CUSTOM_DATE,
          NULL AS ADHOC_DATE,
          NULL AS PP_THRESHOLD,
          NULL AS PMON_ALT_UOM,
          NULL AS PMON_BENEFIT_TYPE,
          NULL AS PMON_CALC_PRICE_BASIS,
          NULL AS PMON_ESTIMATED_VAL,
          NULL AS PMON_MCO_VOL_BASIS,
          NULL AS PMON_PL_TYPE,
          NULL AS PMON_PRICE_RES_METHOD
          FROM  MN_PG_QUAL_BEN_DIM_VW PGQB
          LEFT JOIN MN_PG_QUAL_BEN_SD_RPT_VW PGQSD ON PGQSD.PG_TB_WID=PGQB.PG_TB_WID AND PGQB.IS_QUAL_COMP_FLAG='Y' AND PGQSD.SPREADSHEET_TYPE<>'GENERIC' AND PGQSD.TIER_FLAG ='N' AND PGQSD.SPREADSHEET_NAME IS NULL
          LEFT JOIN (
               SELECT PG_TB_WID,
                  NULLIF(EFF_START_DATE, To_Date('07/03/1776','mm/dd/yyyy')) AS EFF_START_DATE,
                  NULLIF(EFF_END_DATE, To_Date('12/31/4700','mm/dd/yyyy')) AS EFF_END_DATE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=1 THEN TIER_VALUE ELSE NULL END) AS TIER1_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=2 THEN TIER_VALUE ELSE NULL END) AS TIER2_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=3 THEN TIER_VALUE ELSE NULL END) AS TIER3_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=4 THEN TIER_VALUE ELSE NULL END) AS TIER4_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=5 THEN TIER_VALUE ELSE NULL END) AS TIER5_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=6 THEN TIER_VALUE ELSE NULL END) AS TIER6_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=7 THEN TIER_VALUE ELSE NULL END) AS TIER7_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=8 THEN TIER_VALUE ELSE NULL END) AS TIER8_VALUE,
                  MAX(CASE WHEN  NVL(TIER_IDX,1)=9 THEN TIER_VALUE ELSE NULL END) AS TIER9_VALUE
              FROM MN_PG_QUAL_BEN_SD_RPT_VW WHERE TIER_FLAG ='Y'
              GROUP BY PG_TB_WID,
                  NULLIF(EFF_START_DATE, To_Date('07/03/1776','mm/dd/yyyy')),
                  NULLIF(EFF_END_DATE, To_Date('12/31/4700','mm/dd/yyyy'))
                  )
          lvls ON lvls.PG_TB_WID = PGQSD.PG_TB_WID
 ;;
  }


  dimension: component_key {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPONENT_KEY ;;
  }

  dimension: program_qual_ben_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PROGRAM_QUAL_BEN_WID ;;
  }

  dimension: price_program_qual_ben_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.PROGRAM_QUAL_BEN_WID ;;
  }

  dimension: program_key {
    type: number
    hidden: yes
    sql: ${TABLE}.PROGRAM_KEY ;;
  }

  dimension: formulary_mb_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.FORMULARY_MB_WID ;;
  }

  dimension: formulary_product_wid {
    type: number
    hidden: yes
    sql: ${TABLE}.FORMULARY_PRODUCT_WID ;;
  }

  dimension: ver_num {
    type: number
    hidden: yes
    sql: ${TABLE}.VER_NUM ;;
  }

  dimension: end_ver_num {
    type: number
    hidden: yes
    sql: ${TABLE}.END_VER_NUM ;;
  }

  dimension_group: ver_start_date {
    type: time
    hidden: yes
    sql: ${TABLE}.VER_START_DATE ;;
  }

  dimension_group: ver_end_date {
    type: time
    hidden: yes
    sql: ${TABLE}.VER_END_DATE ;;
  }

  dimension: contract_type {
    type: string
    hidden: yes
    sql: ${TABLE}.CONTRACT_TYPE ;;
  }

  dimension: source_system_id {
    type: string
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: date_created {
    type: time
    hidden: yes
    sql: ${TABLE}.DATE_CREATED ;;
  }

  dimension_group: date_updated {
    type: time
    hidden: yes
    sql: ${TABLE}.DATE_UPDATED ;;
  }

  dimension_group: src_sys_date_updated {
    type: time
    hidden: yes
    sql: ${TABLE}.SRC_SYS_DATE_UPDATED ;;
  }

  dimension: calc_obj_type {
    type: string
    hidden: yes
    sql: ${TABLE}.CALC_OBJ_TYPE ;;
  }

  dimension: run_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RUN_ID ;;
  }

  dimension: program_type {
    type: string
    hidden: yes
    sql: ${TABLE}.PROGRAM_TYPE ;;
  }

  dimension: elig_component_type {
    type: string
    hidden: yes
    sql: ${TABLE}.ELIG_COMPONENT_TYPE ;;
  }

  dimension: num_tiers {
    type: number
    view_label: "Pricing Program Tier Basis"
    label: "# of Tiers"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.NUM_TIERS ELSE NULL END ;;
  }

  dimension: basis_desc {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Component Description"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.BASIS_DESC ELSE NULL END ;;
  }

  dimension: component_name {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Component Name"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.COMPONENT_NAME ELSE NULL END ;;
  }

  dimension: component_type {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Component Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.COMPONENT_TYPE ELSE NULL END ;;
  }

  dimension: component_type_flag {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Component Type Flag"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.COMPONENT_TYPE_FLAG ELSE NULL END ;;
  }

  dimension: separate_tb_prod_flag {
    type: number
    view_label: "Pricing Program Tier Basis"
    label: "Define Seperate Product Set?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.SEPARATE_TB_PROD_FLAG ELSE NULL END ;;
  }

  dimension: calc_level {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Dimension"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.CALC_LEVEL ELSE NULL END ;;
  }

  dimension_group: eff_start {
    type: time
    view_label: "Pricing Program Tier Basis"
    label: "Effective Start"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.EFF_START_DATE ELSE NULL END ;;
  }

  dimension_group: eff_end {
    type: time
    view_label: "Pricing Program Tier Basis"
    label: "Effective End"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.EFF_END_DATE ELSE NULL END ;;
  }

  dimension: is_mb_comp_yn {
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.IS_MB_COMPONENT = 'Y' THEN 'Yes'
      WHEN ${TABLE}.IS_MB_COMPONENT = 'N' THEN 'No' ELSE NULL END  ;;
  }

  dimension: is_mb_component {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Is MB Component ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${mn_comb_pg_rp_comp_dim.is_mb_comp_yn} ELSE NULL END ;;
  }


  dimension: is_qual_comp_flag {
    type: string
    hidden: yes
    sql: ${TABLE}.IS_QUAL_COMP_FLAG ;;
  }

  dimension: is_qual_comp_yn {
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.IS_QUAL_COMP_FLAG = 'Y' THEN 'Yes'
      WHEN ${TABLE}.IS_QUAL_COMP_FLAG = 'N' THEN 'No' ELSE NULL END ;;
  }

  dimension: is_qual_componenet {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Is Qualification Component?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${mn_comb_pg_rp_comp_dim.is_qual_comp_yn} ELSE NULL END ;;
  }

  dimension: module_type {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Module Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.MODULE_TYPE ELSE NULL END ;;
  }

  dimension: name {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Name"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.NAME ELSE NULL END ;;
  }

  dimension: order_index {
    type: number
    view_label: "Pricing Program Tier Basis"
    label: "Order Index"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.ORDER_INDEX ELSE NULL END ;;
  }

  dimension: sale_line_type {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Sales Line Types"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.SALE_LINE_TYPE ELSE NULL END ;;
  }

  dimension: strategy_based_yn {
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.STRATEGY_BASED_FLAG = 'Y' THEN 'Yes'
      WHEN ${TABLE}.STRATEGY_BASED_FLAG = 'N' THEN 'No' ELSE Null END ;;
  }

  dimension: strategy_based_flag {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Is Strategy Based ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${mn_comb_pg_rp_comp_dim.strategy_based_yn} ELSE NULL END ;;
  }

  dimension: tier1_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER1_VALUE ELSE NULL END ;;
  }

  dimension: tier2_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER2_VALUE ELSE NULL END ;;
  }

  dimension: tier3_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER3_VALUE ELSE NULL END ;;
  }

  dimension: tier4_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER4_VALUE ELSE NULL END ;;
  }

  dimension: tier5_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER5_VALUE ELSE NULL END ;;
  }

  dimension: tier6_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER6_VALUE ELSE NULL END ;;
  }

  dimension: tier7_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER7_VALUE ELSE NULL END ;;
  }

  dimension: tier8_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER8_VALUE ELSE NULL END ;;
  }

  dimension: tier9_value {
    type: number
    view_label: "Pricing Program Tier Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.TIER9_VALUE ELSE NULL END ;;
  }

  dimension: basis_type {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.BASIS_TYPE ELSE NULL END ;;
  }

  dimension: basis_unit {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Unit"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.BASIS_UNIT ELSE NULL END ;;
  }

  dimension: uom {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Unit of Measure"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.UOM ELSE NULL END ;;
  }

  dimension: units {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Units"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.UNITS ELSE NULL END ;;
  }

  dimension: use_strat_filter_flag {
    type: string
    view_label: "Pricing Program Tier Basis"
    label: "Use Strategy Filters"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 3 THEN  ${TABLE}.USE_STRAT_FILTER_FLAG ELSE NULL END ;;
  }
#   Price Program Tier Basis dimension group attributes - End


#   Rebate Program Benefit dimension group attributes - Start
  dimension: rpb_num_tiers {
    type: number
    view_label: "Rebate Program Benefit"
    label: "# of Tiers"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.NUM_TIERS ELSE NULL END ;;
  }

  dimension_group: adhoc_date {
    type: time
    view_label: "Rebate Program Benefit"
    label: "Adhoc"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.ADHOC_DATE ELSE NULL END ;;
  }

  dimension: alt_uom {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Alternate UOM"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.ALT_UOM ELSE NULL END ;;
  }

  dimension: base_dos {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Base DOS"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.BASE_DOS ELSE NULL END ;;
  }

  dimension: base_price_ref_date {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Base Price Reference Date"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.BASE_PRICE_REF_DATE ELSE NULL END ;;
  }

  dimension: baseline_period {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Baseline Period"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.BASELINE_PERIOD ELSE NULL END ;;
  }

  dimension: calc_price_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Calculation Price Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.CALC_PRICE_BASIS ELSE NULL END ;;
  }

  dimension: rpb_component_type {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Component Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.COMPONENT_TYPE ELSE NULL END ;;
  }

  dimension: rpb_component_name {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Component Name"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.COMPONENT_NAME ELSE NULL END ;;
  }
  dimension: condition_1 {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Condition 1"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.CONDITION_1 ELSE NULL END ;;
  }

  dimension: condition_2 {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Condition 2"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.CONDITION_2 ELSE NULL END ;;
  }

  dimension: condition_3 {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Condition 3"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.CONDITION_3 ELSE NULL END ;;
  }

  dimension: condition_4 {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Condition 4"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.CONDITION_4 ELSE NULL END ;;
  }

  dimension: condition_5 {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Condition 5"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.CONDITION_5 ELSE NULL END ;;
  }

  dimension: description {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Description"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.DESCRIPTION ELSE NULL END ;;
  }

  dimension_group: rpb_eff_start {
    type: time
    view_label: "Rebate Program Benefit"
    label: "Effective Start"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.EFF_START_DATE ELSE NULL END ;;
  }

  dimension_group: rpb_eff_end {
    type: time
    view_label: "Rebate Program Benefit"
    label: "Effective End"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.EFF_END_DATE ELSE NULL END ;;
  }


  dimension: enable_bp_calc {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Enable Custom Benefit Effectivity"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.ENABLE_BEP_CALC ELSE NULL END ;;
  }

  dimension: enable_cust_reset {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Enable Custom Reset Or Cumulation"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.ENABLE_CUSTOM_RESET ELSE NULL END ;;
  }

  dimension: enable_netting_yn {
    type: string
    hidden: yes
    view_label: "Rebate Program Benefit"
    sql: CASE WHEN ${TABLE}.ENABLE_NETTING_FLAG = 1 THEN 'True'
      WHEN ${TABLE}.ENABLE_NETTING_FLAG = 0 THEN 'False' ELSE Null END ;;
  }

  dimension: enable_netting {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Enable Netting"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${mn_comb_pg_rp_comp_dim.enable_netting_yn} ELSE NULL END ;;
  }

  dimension: formulary_operator {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Formulary Operator"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.FORMULARY_OPERATOR ELSE NULL END ;;
  }

  dimension: growth_type {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Growth Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.GROWTH_TYPE ELSE NULL END ;;
  }

  dimension: rpb_strategy_based {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Is Strategy Based ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${mn_comb_pg_rp_comp_dim.strategy_based_yn} ELSE NULL END ;;
  }

  dimension: incl_admin_fee {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Include Admin Fee"
    value_format_name: usd
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.INCLUDE_ADMIN_FEE ELSE NULL END ;;
  }

  dimension: is_dependent {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Is Dependent ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.IS_DEPENDENT ELSE NULL END ;;
  }


  dimension: item_override_flag_yn {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.ITEM_OVERRIDE_FLAG = 1 THEN 'Yes'
      WHEN ${TABLE}.ITEM_OVERRIDE_FLAG = 0 THEN 'No' ELSE Null END ;;
  }

  dimension: item_override_flag {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Is Item Override ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${mn_comb_pg_rp_comp_dim.item_override_flag_yn} ELSE NULL END ;;
  }

  dimension: is_round_qty_flag_yn {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.IS_ROUND_QTY_FLAG = 1 THEN 'Yes'
      WHEN ${TABLE}.IS_ROUND_QTY_FLAG = 0 THEN 'No' ELSE Null END ;;
  }

  dimension: is_round_qty_flag {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Is Round Quantity ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${mn_comb_pg_rp_comp_dim.is_round_qty_flag_yn} ELSE NULL END ;;
  }

  dimension: manual_baseline_val {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Manual Baseline Value"
    value_format_name: usd
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.MANUAL_BASELINE_VAL ELSE NULL END ;;
  }

  dimension: ms_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Market Share Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.MS_BASIS ELSE NULL END ;;
  }

  dimension: max_increase {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Max Increase"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.MAX_INCREASE ELSE NULL END ;;
  }

  dimension: mco_vol_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "MCO Volume Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.MCO_VOL_BASIS ELSE NULL END ;;
  }

  dimension: rpb_name {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Name"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.NAME ELSE NULL END ;;
  }

  dimension: number_of_weeks_span {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Number Of Weeks Span"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.NUMBER_OF_WEEKS_SPAN ELSE NULL END ;;
  }

  dimension: pmon_alt_uom {
    type: string
    view_label: "Rebate Program Benefit"
    label: "PMon Alternate UOM"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PMON_ALT_UOM ELSE NULL END ;;
  }

  dimension: pmon_benefit_type {
    type: string
    view_label: "Rebate Program Benefit"
    label: "PMon Benefit Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PMON_BENEFIT_TYPE ELSE NULL END ;;
  }

  dimension: pmon_calc_price_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "PMon Calculation Price Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PMON_CALC_PRICE_BASIS ELSE NULL END ;;
  }

  dimension: pmon_est_val_calc {
    type: string
    hidden: yes
    sql:  CASE  WHEN ${TABLE}.PMON_BENEFIT_TYPE = '%' THEN CONCAT(${TABLE}.PMON_ESTIMATED_VAL*100,'%')
      WHEN ${TABLE}.PMON_BENEFIT_TYPE = 'Amount Per Unit' THEN CONCAT('$',${TABLE}.PMON_ESTIMATED_VAL) ELSE NULL END ;;
  }

  dimension: pmon_est_val {
    type: string
    view_label: "Rebate Program Benefit"
    label: "PMon Estimated Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${mn_comb_pg_rp_comp_dim.pmon_est_val_calc} ELSE NULL END ;;
  }

  dimension: pmon_mco_vol_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "PMon MCO Volume Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PMON_MCO_VOL_BASIS ELSE NULL END ;;
  }

  dimension: pmon_pl_type {
    type: string
    view_label: "Rebate Program Benefit"
    label: "PMon Price List Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PMON_PL_TYPE ELSE NULL END ;;
  }

  dimension: pmon_price_res_method {
    type: string
    view_label: "Rebate Program Benefit"
    label: "PMon Price Resolution Method"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PMON_PRICE_RES_METHOD ELSE NULL END ;;
  }

  dimension: price_list_type {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Price List Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PRICE_LIST_TYPE ELSE NULL END ;;
  }

  dimension: price_ref_date {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Price Reference Date"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PRICE_REF_DATE ELSE NULL END ;;
  }

  dimension: price_res_method {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Price Resolution Method"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.PRICE_RES_METHOD ELSE NULL END ;;
  }

  dimension: qty_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Quantity Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.QTY_BASIS ELSE NULL END ;;
  }

  dimension: rpb_sale_line_type {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Sales Line Types"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.SALE_LINE_TYPE ELSE NULL END ;;
  }

  dimension: schedule_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Schedule Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.SCHEDULE_BASIS ELSE NULL END ;;
  }

  dimension_group: sch_basis_custom {
    type: time
    view_label: "Rebate Program Benefit"
    label: "Schedule Basis Custom"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.SCH_BASIS_CUSTOM_DATE ELSE NULL END ;;
  }


  dimension: segment {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Segment"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.SEGMENT ELSE NULL END ;;
  }

  dimension: spreadsheet_type {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Spreadsheet Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.SPREADSHEET_TYPE ELSE NULL END ;;
  }

  dimension: tier_flag_yn {
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.TIER_FLAG = 'Y' THEN 'Yes'
      WHEN ${TABLE}.TIER_FLAG = 'N' THEN 'No' ELSE Null END ;;
  }

  dimension: tier_flag {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Tier Flag"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${mn_comb_pg_rp_comp_dim.tier_flag_yn} ELSE NULL END ;;
  }

  dimension: rpb_tier1_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier1 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER1_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier2_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier2 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER2_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier3_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier3 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER3_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier4_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier4 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER4_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier5_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier5 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER5_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier6_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier6 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER6_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier7_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier7 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER7_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier8_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier8 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER8_VALUE ELSE NULL END ;;
  }

  dimension: rpb_tier9_value {
    type: number
    view_label: "Rebate Program Benefit"
    label: "Tier9 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.TIER9_VALUE ELSE NULL END ;;
  }

  dimension: unit_basis {
    type: string
    view_label: "Rebate Program Benefit"
    label: "Unit Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 2 THEN  ${TABLE}.UNIT_BASIS ELSE NULL END ;;
  }

#   Rebate Program Benefit dimension group attributes - End

#   Rebate Program Qualification dimension group attributes - Start

  dimension: rpq_num_tiers {
    type: number
    view_label: "Rebate Program Qualification"
    label: "# of Tiers"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.NUM_TIERS ELSE NULL END ;;
  }

  dimension: rpq_alt_uom {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Alternate UOM"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.ALT_UOM ELSE NULL END ;;
  }

  dimension: rpq_base_dos {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Base DOS"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.BASE_DOS ELSE NULL END ;;
  }

  dimension: rpq_base_price_ref_date {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Base Price Reference Date"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.BASE_PRICE_REF_DATE ELSE NULL END ;;
  }

  dimension: rpq_baseline_period {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Baseline"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.BASELINE_PERIOD ELSE NULL END ;;
  }

  dimension: rpq_calc_price_basis {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Calculation Price Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.CALC_PRICE_BASIS ELSE NULL END ;;
  }

  dimension: rpq_rpb_component_type {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Component Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.COMPONENT_TYPE ELSE NULL END ;;
  }

  dimension: rpq_description {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Description"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.DESCRIPTION ELSE NULL END ;;
  }

  dimension: rpq_rpb_component_name {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Component Name"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.COMPONENT_NAME ELSE NULL END ;;
  }
  dimension: rpq_condition_1 {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Condition 1"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.CONDITION_1 ELSE NULL END ;;
  }

  dimension: rpq_condition_2 {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Condition 2"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.CONDITION_2 ELSE NULL END ;;
  }

  dimension: rpq_condition_3 {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Condition 3"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.CONDITION_3 ELSE NULL END ;;
  }

  dimension: rpq_condition_4 {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Condition 4"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.CONDITION_4 ELSE NULL END ;;
  }

  dimension: rpq_condition_5 {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Condition 5"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.CONDITION_5 ELSE NULL END ;;
  }

  dimension_group: rpq_eff_start {
    type: time
    view_label: "Rebate Program Qualification"
    label: "Effective Start"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.EFF_START_DATE ELSE NULL END ;;
  }

  dimension_group: rpq_eff_end {
    type: time
    view_label: "Rebate Program Qualification"
    label: "Effective End"
    timeframes: [
      raw,
      time,
      date,
      week_of_year,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.EFF_END_DATE ELSE NULL END ;;
  }

  dimension: rpq_enable_netting_yn {
    type: string
    hidden: yes
    view_label: "Rebate Program Qualification"
    sql: CASE WHEN ${TABLE}.ENABLE_NETTING_FLAG = 1 THEN 'True'
      WHEN ${TABLE}.ENABLE_NETTING_FLAG = 0 THEN 'False' ELSE Null END ;;
  }

  dimension: rpq_enable_netting {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Enable Netting"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${mn_comb_pg_rp_comp_dim.enable_netting_yn} ELSE NULL END ;;
  }

  dimension: rpq_formulary_operator {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Formulary Operator"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.FORMULARY_OPERATOR ELSE NULL END ;;
  }

  dimension: rpq_growth_type {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Growth Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.GROWTH_TYPE ELSE NULL END ;;
  }

  dimension: rpq_strategy_based {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Is Strategy Based ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${mn_comb_pg_rp_comp_dim.strategy_based_yn} ELSE NULL END ;;
  }

  dimension: rpq_item_override_flag_yn {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.ITEM_OVERRIDE_FLAG = 1 THEN 'Yes'
      WHEN ${TABLE}.ITEM_OVERRIDE_FLAG = 0 THEN 'No' ELSE Null END ;;
  }

  dimension: rpq_item_override_flag {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Is Item Override ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${mn_comb_pg_rp_comp_dim.item_override_flag_yn} ELSE NULL END ;;
  }

  dimension: rpq_is_round_qty_flag_yn {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.IS_ROUND_QTY_FLAG = 1 THEN 'Yes'
      WHEN ${TABLE}.IS_ROUND_QTY_FLAG = 0 THEN 'No' ELSE Null END ;;
  }

  dimension: rpq_is_round_qty_flag {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Is Round Quantity ?"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${mn_comb_pg_rp_comp_dim.is_round_qty_flag_yn} ELSE NULL END ;;
  }

  dimension: rpq_manual_baseline_val {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Manual Baseline Value"
    value_format_name: usd
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.MANUAL_BASELINE_VAL ELSE NULL END ;;
  }

  dimension: rpq_ms_basis {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Market Share Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.MS_BASIS ELSE NULL END ;;
  }

  dimension: rpq_max_increase {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Max Increase"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.MAX_INCREASE ELSE NULL END ;;
  }

  dimension: rpq_mco_vol_basis {
    type: string
    view_label: "Rebate Program Qualification"
    label: "MCO Volume Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.MCO_VOL_BASIS ELSE NULL END ;;
  }

  dimension: rpq_name {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Name"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.NAME ELSE NULL END ;;
  }

  dimension: rpq_number_of_weeks_span {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Number Of Weeks Span"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.NUMBER_OF_WEEKS_SPAN ELSE NULL END ;;
  }

  dimension: rpq_price_list_type {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Price List Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.PRICE_LIST_TYPE ELSE NULL END ;;
  }

  dimension: rpq_price_ref_date {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Price Reference Date"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.PRICE_REF_DATE ELSE NULL END ;;
  }

  dimension: rpq_price_res_method {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Price Resolution Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.PRICE_RES_METHOD ELSE NULL END ;;
  }

  dimension: rpq_qty_basis {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Quantity Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.QTY_BASIS ELSE NULL END ;;
  }

  dimension: rpq_sale_line_type {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Sales Line Types"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.SALE_LINE_TYPE ELSE NULL END ;;
  }

  dimension: rpq_schedule_basis {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Schedule Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.SCHEDULE_BASIS ELSE NULL END ;;
  }

  dimension: rpq_segment {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Segment"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.SEGMENT ELSE NULL END ;;
  }

  dimension: rpq_spreadsheet_type {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Spreadsheet Type"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.SPREADSHEET_TYPE ELSE NULL END ;;
  }

  dimension: rpq_tier_flag_yn {
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.TIER_FLAG = 'Y' THEN 'Yes'
      WHEN ${TABLE}.TIER_FLAG = 'N' THEN 'No' ELSE Null END ;;
  }

  dimension: rpq_tier_flag {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Tier Flag"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${mn_comb_pg_rp_comp_dim.tier_flag_yn} ELSE NULL END ;;
  }

  dimension: rpq_tier1_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier1 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER1_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier2_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier2 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER2_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier3_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier3 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER3_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier4_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier4 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER4_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier5_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier5 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER5_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier6_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier6 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER6_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier7_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier7 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER7_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier8_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier8 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER8_VALUE ELSE NULL END ;;
  }

  dimension: rpq_tier9_value {
    type: number
    view_label: "Rebate Program Qualification"
    label: "Tier9 Value"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.TIER9_VALUE ELSE NULL END ;;
  }

  dimension: rpq_unit_basis {
    type: string
    view_label: "Rebate Program Qualification"
    label: "Unit Basis"
    sql: CASE WHEN ${TABLE}.ELIG_COMP_TYPE_NUM = 1 THEN  ${TABLE}.UNIT_BASIS ELSE NULL END ;;
  }

  #   Rebate Program Qualification dimension group attributes - End

  dimension: elg_comp_name {
    type: string
    view_label: "Contract Eligible Customer"
    label: "Component Name"
    sql: ${TABLE}.COMPONENT_NAME ;;
  }

}
