view: ua_device_tags {
  sql_table_name: PUBLIC.UA_DEVICE_TAGS ;;

  dimension: active_ind {
    type: string
    sql: ${TABLE}.ACTIVE_IND ;;
  }

  dimension: channel_id {
    type: string
    sql: ${TABLE}.CHANNEL_ID ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.PLATFORM ;;
  }

  dimension: tags {
    view_label: "original tags"
    type: string
    sql: ${TABLE}.TAGS ;;
  }

  dimension: tags_01 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[0]::string ;;
  }

  dimension: tags_02 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[1]::string ;;
  }

  dimension: tags_03 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[2]::string ;;
  }

  dimension: tags_04 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[3]::string ;;
  }

  dimension: tags_05 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[4]::string ;;
  }

  dimension: tags_06 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[5]::string ;;
  }

  dimension: tags_07 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[6]::string ;;
  }

  dimension: tags_08 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[7]::string ;;
  }

  dimension: tags_09 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[8]::string ;;
  }

  dimension: tags_10 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[9]::string ;;
  }

  dimension: tags_11 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[10]::string ;;
  }

  dimension: tags_12 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[11]::string ;;
  }

  dimension: tags_13 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[12]::string ;;
  }

  dimension: tags_14 {
    view_label: "original tags"
    sql: ${TABLE}.TAGS[13]::string ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
