view: view_files {
  sql_table_name: LOOKML.VIEW_FILES ;;
  view_label: "View Files"

  # There may be multiple Views in one View File
  dimension: view_file_pk {
    label: "View File PK"
    type: string
    primary_key: yes
    hidden: yes
    sql: ${git_owner} || '-' || ${git_repository} || '-' || ${path} ;;
  }

  dimension_group: _sdc_batched {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._SDC_BATCHED_AT ;;
    hidden: yes
  }

  dimension_group: _sdc_extracted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._SDC_EXTRACTED_AT ;;
    hidden: yes
  }

  dimension_group: _sdc_received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._SDC_RECEIVED_AT ;;
    hidden: yes
  }

  dimension: _sdc_sequence {
    type: number
    sql: ${TABLE}._SDC_SEQUENCE ;;
    hidden: yes
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._SDC_TABLE_VERSION ;;
    hidden: yes
  }

  dimension: download_url {
    group_label: "URLs"
    label: "Download URL"
    type: string
    sql: ${TABLE}.DOWNLOAD_URL ;;
  }

  dimension: encoding {
    label: "Content Encoding"
    type: string
    sql: ${TABLE}.ENCODING ;;
  }

  dimension: git_owner {
    label: "Git Owner"
    type: string
    sql: ${TABLE}.GIT_OWNER ;;
  }

  dimension: git_repository {
    label: "Git Repository"
    type: string
    sql: ${TABLE}.GIT_REPOSITORY ;;
  }

  dimension: git_url {
    group_label: "URLs"
    label: "Git URL"
    type: string
    sql: ${TABLE}.GIT_URL ;;
  }

  dimension: html_url {
    group_label: "URLs"
    label: "HTML URL"
    type: string
    sql: ${TABLE}.HTML_URL ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.LAST_MODIFIED ;;
  }

  dimension: view_file_name {
    label: "View File Name"
    description: "Short file name without the extension"
    link: {
      label: "Review on GitHub"
      url: "{{ html_url }}"
    }
    sql: SPLIT_PART(${name}, '.', 1) ;;
  }

  dimension: name {
    label: "View File Full Name"
    description: "Long file name with the extension"
    type: string
    link: {
      label: "Review on GitHub"
      url: "{{ html_url }}"
    }
    sql: ${TABLE}.NAME ;;
  }

  dimension: path {
    label: "View Path"
    type: string
    link: {
      label: "Review on GitHub"
      url: "{{ html_url }}"
    }
    sql: ${TABLE}.PATH ;;
  }

  dimension: sha {
    label: "View SHA"
    description: "Unique hash key based on file contents"
    type: string
    sql: ${TABLE}.SHA ;;
  }

  dimension: size {
    label: "File Size"
    type: number
    sql: ${TABLE}.SIZE ;;
  }

  dimension: type {
    label: "Type"
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension: url {
    group_label: "URLs"
    label: "URL"
    type: string
    sql: ${TABLE}.URL ;;
  }

  measure: count {
    label: "Number of View Files"
    type: count
  }

  set: detail {
    fields: [
      name,
      name,
      path,
      size,
      last_modified_time
    ]
  }
}
