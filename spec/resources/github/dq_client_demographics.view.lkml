include: "client_demographics.view.lkml"
view: dq_client_demographics {

  extends: [client_demographics]
  sql_table_name: client_demographics ;;

  set: dq_client_demographics_drills {
    fields: [data_quality.id, dq_client_programs.id]
  }

  dimension: id {
    hidden: yes
    sql: ${TABLE}.ref_client ;;
  }

  dimension: ethnicity_error {
    view_label: "DQ Client UDE"
    label: "Ethnicity Error"
    description: "Error in @{hmis_ref_num_ethnicity_text}: Ethnicity"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${TABLE}.ethnicity IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${TABLE}.ethnicity LIKE "8" ;;
        label: "Client doesn't know"
      }
      when: {
        sql: ${TABLE}.ethnicity LIKE "9" ;;
        label: "Client Refused"
      }
      when: {
        sql: ${TABLE}.ethnicity LIKE "99" ;;
        label: "Data not collected"
      }
      when: {
        sql:  ${TABLE}.ethnicity != "0"
          AND ${TABLE}.ethnicity != "1"
          AND ${TABLE}.ethnicity != "8"
          AND ${TABLE}.ethnicity != "9"
          AND ${TABLE}.ethnicity != "99" ;;
        label: "Invalid ethnicity selected"
      }
      else: "None"
    }
  }

  dimension: gender_error {
    view_label: "DQ Client UDE"
    label: "Gender Error"
    description: "Error in @{hmis_ref_num_gender_text}: Gender"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${TABLE}.gender IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${TABLE}.gender LIKE "8" ;;
        label: "Client doesn't know"
      }
      when: {
        sql: ${TABLE}.gender LIKE "9" ;;
        label: "Client Refused"
      }
      when: {
        sql: ${TABLE}.gender LIKE "99" ;;
        label: "Data not collected"
      }
      when: {
        sql:  ${TABLE}.gender != "0"
          AND ${TABLE}.gender != "1"
          AND ${TABLE}.gender != "2"
          AND ${TABLE}.gender != "3"
          AND ${TABLE}.gender != "4"
          AND ${TABLE}.gender != "8"
          AND ${TABLE}.gender != "9"
          AND ${TABLE}.gender != "99" ;;
        label: "Invalid gender selected"
      }
      else: "None"
    }
  }

  dimension: veteran_status_error {
    view_label: "DQ Client UDE"
    label: "Veteran Status Error"
    description: "Error in @{hmis_ref_num_veteran_text}: Veteran Status"
    alpha_sort: yes

    allow_fill: no
    case: {
      when: {
        sql:  ${dq_client_program_demographics.age} >= 18
              AND ${TABLE}.veteran IS NULL ;;
        label: "Null"
      }
      when: {
        sql: ${dq_client_program_demographics.age} >= 18
              AND ${TABLE}.veteran LIKE "8" ;;
        label: "Client doesn't know"
      }
      when: {
        sql: ${dq_client_program_demographics.age} >= 18
              AND ${TABLE}.veteran LIKE "9" ;;
        label: "Client Refused"
      }
      when: {
        sql: ${dq_client_program_demographics.age} >= 18
              AND ${TABLE}.veteran LIKE "99" ;;
        label: "Data not collected"
      }
      when: {
        sql:  ${dq_client_program_demographics.age} >= 18
          AND ${TABLE}.veteran != "0"
          AND ${TABLE}.veteran != "1"
          AND ${TABLE}.veteran != "8"
          AND ${TABLE}.veteran != "9"
          AND ${TABLE}.veteran != "99" ;;
        label: "Invalid veteran status selected"
      }
      else: "None"
    }
  }

  dimension: race_error {
    view_label: "DQ Client UDE"
    description: "Error in @{hmis_ref_num_veteran_text}A-E: Race"

    # # Search for all races at the beginning of the string
    # # as it is faster than NOT LIKE %race%

    allow_fill: no
    case: {
      when: {
        sql:  ${TABLE}.race IS NULL ;;
        label: "Null"
      }
      when: {
        # We get the 8s and 9s in another case
        sql:  ${TABLE}.race NOT LIKE "1%"
          AND ${TABLE}.race NOT LIKE "2%"
          AND ${TABLE}.race NOT LIKE "3%"
          AND ${TABLE}.race NOT LIKE "4%"
          AND ${TABLE}.race NOT LIKE "5%"
          AND ${TABLE}.race NOT LIKE "8%"
          AND ${TABLE}.race NOT LIKE "9%";; #Gets 99 as well.
        label: "Invalid race selected"
      }
      when: {
        sql: ${TABLE}.race LIKE "8" ;;
        label: "Client doesn't know"
      }
      when: {
        sql: ${TABLE}.race LIKE "9" ;;
        label: "Client Refused"
      }
      when: {
        sql: ${TABLE}.race LIKE "99" ;;
        label: "Data not collected"
      }
      else: "None"
    }
    alpha_sort: yes
  }


  measure: veteran_status_error_count {
    description: "Error in @{hmis_ref_num_veteran_text}: Veteran Status"
    view_label: "DQ Client UDE"
    group_label: ""
    type: count_distinct
    filters: {
      field: veteran_status_error
      value: "-None"
    }
    drill_fields: [dq_client_demographics_drills*, veteran_status_error]
    sql: ${id};;
  }

  measure: race_error_count {
    view_label: "DQ Client UDE"
    group_label: ""
    type: count_distinct
    filters: {
      field: race_error
      value: "-None"
    }
    drill_fields: [dq_client_demographics_drills*, race_error]
    sql: ${id};;
  }

  measure: gender_error_count {
    description: "Error in @{hmis_ref_num_gender_text}: Gender"
    view_label: "DQ Client UDE"
    group_label: ""
    type: count_distinct
    filters: {
      field: gender_error
      value: "-None"
    }
    drill_fields: [dq_client_demographics_drills*, gender_error]
    sql: ${id};;
  }

  measure: ethnicity_error_count {
    description: "Error in @{hmis_ref_num_ethnicity_text}: Ethnicity"
    view_label: "DQ Client UDE"
    group_label: ""
    type: count_distinct
    filters: {
      field: ethnicity_error
      value: "-None"
    }
    drill_fields: [dq_client_demographics_drills*, ethnicity_error]
    sql: ${id};;
  }

  measure: total_dq_client_demographics_count {
    hidden: yes
    type: number
    sql:   ${veteran_status_error_count} +
           ${race_error_count} +
           ${gender_error_count} +
           ${ethnicity_error_count}
          ;;

      drill_fields: [
        veteran_status_error_count,
        race_error_count,
        gender_error_count,
        ethnicity_error_count
      ]
  }



  dimension: ethnicity  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: ethnicity_text  {
    hidden: yes
    label: "Ethnicity"
    view_label: "Clients"
  }

  dimension: name_middle  {
    hidden: yes
    label: "Middle Name"
    view_label: "Clients"
  }

  dimension: gender  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: gender_text  {
    hidden: yes
    label: "Gender"
    view_label: "Clients"
  }

  dimension: race  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: race_text  {
    hidden: yes
    label: "Race"
    view_label: "Clients"
  }

  dimension: race_1_text  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: race_2_text  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: race_3_text  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: race_4_text  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: race_5_text  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: ref_agency  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: ref_client  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_text  {
    hidden: yes
    label: "Veteran Status"
    view_label: "Clients"
  }

  dimension: veteran_branch  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_discharge  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_duration  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_entered  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_era  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_fire  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_separated  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_afg  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_iraq1  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_iraq2  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_kw  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_other  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_pg  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_vw  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_theater_ww2  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_warzone  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_warzone_duration  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: veteran_warzone_is  {
    hidden: yes
    view_label: "Clients"
  }

  dimension: zipcode  {
    hidden: yes
    view_label: "Clients"
  }

  measure: count {
    hidden: yes
    view_label: "Clients"
  }


}
