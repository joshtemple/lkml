include: "../client.view.lkml"

view: +client {

  measure: client_count {
    group_label: "Counts"
    view_label: "Analysis - General"
    label: "Client count"
    type: count_distinct


    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: distinct_client_count {
    group_label: "Counts"
    view_label: "Analysis - General"
    label: "Distinct client count"
    type: count_distinct


    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_afghanistanoef {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD AfghanistanOEF"
    type: count_distinct

    filters: [
      client.AfghanistanOEF: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_amindaknative {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD AmIndAKNative"
    type: count_distinct

    filters: [
      client.AmIndAKNative: "-0,-1,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_asian {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD Asian"
    type: count_distinct

    filters: [
      client.Asian: "-0,-1,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_blackafamerican {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD BlackAfAmerican"
    type: count_distinct

    filters: [
      client.BlackAfAmerican: "-0,-1,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_desertstorm {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD DesertStorm"
    type: count_distinct

    filters: [
      client.DesertStorm: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_dischargestatus {
    group_label: "NonHUD"
    view_label: "Analysis - Major"
    label: "Non HUD DischargeStatus"
    type: count_distinct

    filters: [
      client.DischargeStatus: "-1,-2,-4,-5,-6,-7,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_dobdataquality {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD DOBDataQuality"
    type: count_distinct

    filters: [
      client.DOBDataQuality: "-1,-2,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_ethnicity {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD Ethnicity"
    type: count_distinct

    filters: [
      client.Ethnicity: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_gender {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD Gender"
    type: count_distinct

    filters: [
      client.Gender: "-0,-1,-2,-3,-4,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_iraqoif {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD IraqOIF"
    type: count_distinct

    filters: [
      client.IraqOIF: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_iraqond {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD IraqOND"
    type: count_distinct

    filters: [
      client.IraqOND: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_koreanwar {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD KoreanWar"
    type: count_distinct

    filters: [
      client.KoreanWar: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_militarybranch {
    group_label: "NonHUD"
    view_label: "Analysis - Major"
    label: "Non HUD MilitaryBranch"
    type: count_distinct

    filters: [
      client.MilitaryBranch: "-1,-2,-3,-4,-6,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_namedataquality {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD NameDataQuality"
    type: count_distinct

    filters: [
      client.NameDataQuality: "-1,-2,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_nativehiotherpacific {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD NativeHIOtherPacific"
    type: count_distinct

    filters: [
      client.NativeHIOtherPacific: "-0,-1,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_othertheater {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD OtherTheater"
    type: count_distinct

    filters: [
      client.OtherTheater: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_racenone {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD RaceNone"
    type: count_distinct

    filters: [
      client.RaceNone: "-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_ssndataquality {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD SSNDataQuality"
    type: count_distinct

    filters: [
      client.SSNDataQuality: "-1,-2,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_veteranstatus {
    group_label: "NonHUD"
    view_label: "Analysis - Major"
    label: "Non HUD VeteranStatus"
    type: count_distinct

    filters: [
      client.VeteranStatus: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_vietnamwar {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD VietnamWar"
    type: count_distinct

    filters: [
      client.VietnamWar: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_white {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD White"
    type: count_distinct

    filters: [
      client.White: "-0,-1,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: non_hud_worldwarii {
    group_label: "NonHUD"
    view_label: "Analysis - Minor"
    label: "Non HUD WorldWarII"
    type: count_distinct

    filters: [
      client.WorldWarII: "-0,-1,-8,-9,-99,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_amindaknative {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null AmIndAKNative"
    type: count_distinct

    filters: [
      client.AmIndAKNative: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_asian {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null Asian"
    type: count_distinct

    filters: [
      client.Asian: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_blackafamerican {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null BlackAfAmerican"
    type: count_distinct

    filters: [
      client.BlackAfAmerican: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_datecreated {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null DateCreated"
    type: count_distinct

    filters: [
      client.DateCreated: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_dateupdated {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null DateUpdated"
    type: count_distinct

    filters: [
      client.DateUpdated: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_dobdataquality {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null DOBDataQuality"
    type: count_distinct

    filters: [
      client.DOBDataQuality: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_ethnicity {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null Ethnicity"
    type: count_distinct

    filters: [
      client.Ethnicity: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_exportid {
    group_label: "Null"
    view_label: "Analysis - Dq"
    label: "Null ExportID"
    type: count_distinct

    filters: [
      client.ExportID: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_gender {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null Gender"
    type: count_distinct

    filters: [
      client.Gender: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_namedataquality {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null NameDataQuality"
    type: count_distinct

    filters: [
      client.NameDataQuality: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_nativehiotherpacific {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null NativeHIOtherPacific"
    type: count_distinct

    filters: [
      client.NativeHIOtherPacific: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_personalid {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null PersonalID"
    type: count_distinct

    filters: [
      client.PersonalID: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_ssndataquality {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null SSNDataQuality"
    type: count_distinct

    filters: [
      client.SSNDataQuality: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_userid {
    group_label: "Null"
    view_label: "Analysis - Dq"
    label: "Null UserID"
    type: count_distinct

    filters: [
      client.UserID: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_veteranstatus {
    group_label: "Null"
    view_label: "Analysis - Major"
    label: "Null VeteranStatus"
    type: count_distinct

    filters: [
      client.VeteranStatus: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: null_white {
    group_label: "Null"
    view_label: "Analysis - Dq"
    label: "Null White"
    type: count_distinct

    filters: [
      client.White: "NULL,EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: clients_where_all_races_are_no_but_racenone_is_not_client_doesnt_know__client_refused__or_data_not_collected {
    group_label: "dqClient"
    view_label: "Analysis - Dq"
    label: "Clients where all races are No but RaceNone is not Client Doesn't Know, Client Refused, or Data Not Collected"
    type: count_distinct

    filters: [
      client.RaceNone: "-8,-9,-99",
      client.AmIndAKNative: "0,99",
      client.Asian: "0,99",
      client.BlackAfAmerican: "0,99",
      client.NativeHIOtherPacific: "0,99",
      client.White: "0,99"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

#   measure: clients_where_either_client_doesnt_know__client_refused__or_data_not_collected_is_selected_for_racenone_but_there_is_a_value_for_one_of_the_race_columns {
#     group_label: "dqClient"
#     view_label: "Analysis - Dq"
#     label: "Clients where either Client Doesn't Know, Client Refused, or Data Not Collected is selected for RaceNone but there is a value for one of the Race columns"
#     type: count_distinct
#
#
#     drill_fields: [client_queries_drill_fields*]
#     sql: ${PersonalID} ;;
#   }

#   measure: clients_distinct_with_a_yes_for_at_least_one_of_the_race_columns {
#     group_label: "Counts"
#     view_label: "Analysis - General"
#     label: "Clients (distinct) with a Yes for at least one of the race columns"
#     type: count_distinct
#
#
#     drill_fields: [client_queries_drill_fields*]
#     sql: ${PersonalID} ;;
#   }

  measure: clients_with_yes_for_one_of_the_theaters_but_do_not_have_a_yes_for_veteranstatus {
    group_label: "dqClient"
    view_label: "Analysis - Dq"
    label: "Clients with Yes for one of the theaters but do not have a Yes for VeteranStatus"
    type: count_distinct


    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: clients_with_a_dob_that_is_after_the_datecreated {
    group_label: "dqClient"
    view_label: "Analysis - Dq"
    label: "Clients with a DOB that is after the DateCreated"
    type: count_distinct


    drill_fields: [client_queries_drill_fields*, client.DOB]
    sql: ${PersonalID} ;;
  }

  measure: clients_where_dobdataquality_is_data_not_collected_but_there_is_a_value_for_dob {
    group_label: "dqClient"
    view_label: "Analysis - Dq"
    label: "Clients where DOBDataQuality is Data Not Collected but there is a value for DOB"
    type: count_distinct

    filters: [
      client.DOBDataQuality: "99",
      client.DOB: "-EMPTY,-NULL"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: clients_where_ssndataquality_is_data_not_collected_but_there_is_a_value_for_ssn {
    group_label: "dqClient"
    view_label: "Analysis - Dq"
    label: "Clients where SSNDataQuality is Data Not Collected but there is a value for SSN"
    type: count_distinct

    filters: [
      client.SSNDataQuality: "99",
      client.SSN: "-000%,-111%,-222%,-333%,-444%,-555%,-666%,-777%,-888%,-999%,-NULL,-EMPTY"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: clients_enrolled_in_a_va_project_with_a_value_for_yearenteredservice_or_yearseparated_but_do_not_have_a_yes_for_veteranstatus {
    group_label: "dqClient"
    view_label: "Analysis - Dq"
    label: "Clients enrolled in a VA project with a value for YearEnteredService or YearSeparated but do not have a Yes for VeteranStatus"
    type: count_distinct


    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: invalid_date_formatting_for_dob_in_client.csv {
    group_label: "DateFormatting"
    view_label: "Analysis - Major"
    label: "Invalid Date Formatting for DOB in Client.csv"
    type: count_distinct

    filters: [
      client.DOB: "-____-__-__"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: invalid_date_formatting_for_datecreated_in_client.csv {
    group_label: "DateFormatting"
    view_label: "Analysis - Major"
    label: "Invalid Date Formatting for DateCreated in Client.csv"
    type: count_distinct

    filters: [
      client.DateCreated: "-____-__-__ __:__:__"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: invalid_date_formatting_for_dateupdated_in_client.csv {
    group_label: "DateFormatting"
    view_label: "Analysis - Major"
    label: "Invalid Date Formatting for DateUpdated in Client.csv"
    type: count_distinct

    filters: [
      client.DateUpdated: "-____-__-__ __:__:__"
    ]

    drill_fields: [client_queries_drill_fields*]
    sql: ${PersonalID} ;;
  }

  measure: dob_after_datecreated {
    group_label: "dqClient"
    view_label: "Dq"
    label: "DOB After DateCreated"
    type: count_distinct

    drill_fields: [client_queries_drill_fields*]
    sql:  CASE
            WHEN ${DOB_date} < ${DateCreated_date} THEN ${PersonalID}
            ELSE NULL
          END ;;
  }


  set: client_queries_drill_fields {
    fields: [
      PersonalID
    ]
  }











}
