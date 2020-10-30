include: "//@{CONFIG_PROJECT_NAME}/*.view.lkml"

############## FINAL LAYER OF VIEWS ##############

view: bigquery_data_access {
  extends: [bigquery_data_access_config]
}

view: bigquery_data_access_resource {
  extends: [bigquery_data_access_resource_config]
}

view: bigquery_data_access_resource_labels {
  extends: [bigquery_data_access_resource_labels_config]
}

view: bigquery_data_access_http_request {
  extends: [bigquery_data_access_http_request_config]
}

view: bigquery_data_access_source_location {
  extends: [bigquery_data_access_source_location_config]
}

view: bigquery_data_access_operation {
  extends: [bigquery_data_access_operation_config]
}

view: bigquery_data_access_request_metadata {
  extends: [bigquery_data_access_request_metadata_config]
}

view: bigquery_data_access_authentication_info {
  extends: [bigquery_data_access_authentication_info_config]
}

view: bigquery_data_authorization_info {
  extends: [bigquery_data_authorization_info_config]
}

view: bigquery_data_access_payload {
  extends: [bigquery_data_access_payload_config]
}

view: bigquery_data_access_table_data_list_request {
  extends: [bigquery_data_access_table_data_list_request_config]
}

view: bigquery_data_access_job_completed_event {
  extends: [bigquery_data_access_job_completed_event_config]
}

view: bigquery_data_access_job_name {
  extends: [bigquery_data_access_job_name_config]
}

view: bigquery_data_access_job_status {
  extends: [bigquery_data_access_job_status_config]
}

view: bigquery_data_access_job_status_error {
  extends: [bigquery_data_access_job_status_error_config]
}

view: bigquery_data_access_job_statistics {
  extends: [bigquery_data_access_job_statistics_config]
}

view: bigquery_data_access_job_configuration {
  extends: [bigquery_data_access_job_configuration_config]
}

view: bigquery_data_access_query_destination_table {
  extends: [bigquery_data_access_query_destination_table_config]
}

view: bigquery_data_access_query_table_definitions {
  extends: [bigquery_data_access_query_table_definitions_config]
}

view: bigquery_data_access_query {
  extends: [bigquery_data_access_query_config]
}

view: bigquery_data_access_query_default_dataset {
  extends: [bigquery_data_access_query_default_dataset_config]
}

view: bigquery_data_access_protopayload_auditlog_status {
  extends: [bigquery_data_access_protopayload_auditlog_status_config]
}

view: bigquery_data_access_servicedata {
  extends: [bigquery_data_access_servicedata_config]
}

view: bigquery_data_access_job {
  extends: [bigquery_data_access_job_config]
}

###################################################

view: bigquery_data_access_core {
  derived_table: {
    sql:
      SELECT
        *
      FROM
        `@{SCHEMA_NAME}.@{AUDIT_LOG_EXPORT_TABLE_NAME}`
      WHERE
        {% condition date_filter %} PARSE_TIMESTAMP('%E4Y%m%d', _TABLE_SUFFIX) {% endcondition %} ;;
  }

  filter: date_filter {
    type: date
  }

  dimension: http_request {
    hidden: yes
    sql: ${TABLE}.httpRequest ;;
  }

  dimension: insert_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.insertId ;;
  }

  dimension: log_name {
    type: string
    sql: ${TABLE}.logName;;
  }

  dimension: operation {
    hidden: yes
    sql: ${TABLE}.operation ;;
  }

  dimension: protopayload_auditlog {
    hidden: yes
    sql: ${TABLE}.protopayload_auditlog ;;
  }

  dimension_group: receive_timestamp {
    hidden: yes
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
    sql: ${TABLE}.receiveTimestamp ;;
  }

  dimension: resource {
    hidden: yes
    sql: ${TABLE}.resource ;;
  }

  dimension: severity {
    type: string
    sql: ${TABLE}.severity ;;
  }

  dimension: source_location {
    hidden: yes
    sql: ${TABLE}.sourceLocation ;;
  }

  dimension_group: timestamp {
    hidden: yes
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
    sql: ${TABLE}.timestamp ;;
  }

  dimension: trace {
    type: string
    sql: ${TABLE}.trace ;;
  }

  measure: number_of_queries {
    view_label: "BigQuery Data Access: Query Statistics"
    type: count
    drill_fields: [bigquery_data_access_authentication_info.user_id
                  , bigquery_data_access_job_statistics.start_time
                  , bigquery_data_access_resource_labels.project_id
                  , bigquery_data_access_query.query
                  , bigquery_data_access_job_statistics.billed_gigabytes
                  , bigquery_data_access_job_statistics.query_runtime
                  , bigquery_data_access_job_statistics.query_cost
                  , bigquery_data_access_job_status_error.code
                  , bigquery_data_access_job_status_error.message]
  }

  measure: number_of_expensive_queries {
    view_label: "BigQuery Data Access: Query Statistics"
    description: "Number of queries with over 30 billed gigabytes"
    type: count
    filters: {
      field: bigquery_data_access_job_statistics.billed_gigabytes
      value: ">30"
    }
    drill_fields: [bigquery_data_access_authentication_info.user_id
                  , bigquery_data_access_job_statistics.start_time
                  , bigquery_data_access_resource_labels.project_id
                  , bigquery_data_access_query.query
                  , bigquery_data_access_job_statistics.billed_gigabytes
                  , bigquery_data_access_job_statistics.query_runtime
                  , bigquery_data_access_job_statistics.query_cost
                  , bigquery_data_access_job_status_error.code
                  , bigquery_data_access_job_status_error.message]
  }
}

view: bigquery_data_access_resource_core {
  dimension: labels {
    hidden: yes
    sql: ${TABLE}.labels ;;
  }

  dimension: type {
    hidden: yes
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: bigquery_data_access_resource_labels_core {
  dimension: project_id {
    view_label: "BigQuery Data Access"
    type: string
    sql: ${TABLE}.project_id ;;
  }
}

view: bigquery_data_access_http_request_core {
  dimension: cache_fill_bytes {
    type: number
    sql: ${TABLE}.cacheFillBytes ;;
  }

  dimension: cache_hit {
    type: yesno
    sql: ${TABLE}.cacheHit ;;
  }

  dimension: cache_lookup {
    type: yesno
    sql: ${TABLE}.cacheLookup ;;
  }

  dimension: cache_validated_with_origin_server {
    type: yesno
    sql: ${TABLE}.cacheValidatedWithOriginServer ;;
  }

  dimension: latency {
    type: number
    sql: ${TABLE}.latency ;;
  }

  dimension: protocol {
    type: string
    sql: ${TABLE}.protocol ;;
  }

  dimension: referer {
    type: string
    sql: ${TABLE}.referer ;;
  }

  dimension: remote_ip {
    type: string
    sql: ${TABLE}.remoteIp ;;
  }

  dimension: request_method {
    type: string
    sql: ${TABLE}.requestMethod ;;
  }

  dimension: request_size {
    type: number
    sql: ${TABLE}.requestSize ;;
  }

  dimension: request_url {
    type: string
    sql: ${TABLE}.requestUrl ;;
  }

  dimension: response_size {
    type: number
    sql: ${TABLE}.responseSize ;;
  }

  dimension: server_ip {
    type: string
    sql: ${TABLE}.serverIp ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: user_agent {
    type: string
    sql: ${TABLE}.userAgent ;;
  }
}

view: bigquery_data_access_source_location_core {
  dimension: file {
    type: string
    sql: ${TABLE}.file ;;
  }

  dimension: function {
    type: string
    sql: ${TABLE}.function ;;
  }

  dimension: line {
    type: number
    sql: ${TABLE}.line ;;
  }
}

view: bigquery_data_access_operation_core {
  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: first {
    type: yesno
    sql: ${TABLE}.first ;;
  }

  dimension: last {
    type: yesno
    sql: ${TABLE}.last ;;
  }

  dimension: producer {
    type: string
    sql: ${TABLE}.producer ;;
  }
}

view: bigquery_data_access_request_metadata_core {
  dimension: caller_ip {
    type: string
    sql: ${TABLE}.callerIp ;;
  }

  dimension: caller_supplied_user_agent {
    type: string
    sql: ${TABLE}.callerSuppliedUserAgent ;;
  }
}

view: bigquery_data_access_authentication_info_core {
  dimension: authority_selector {
    hidden: yes
    type: string
    sql: ${TABLE}.authoritySelector ;;
  }

  dimension: user_id {
    label: "User ID"
    type: string
    sql: ${TABLE}.principalEmail ;;
  }

  dimension: is_service_account {
    type: yesno
    sql: (${user_id} LIKE '%gserviceaccount%') ;;

  }

  measure: number_of_active_users {
    description: "Excludes Service Accounts"
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: is_service_account
      value: "no"
    }
    drill_fields: [user_id]
  }
}

view: bigquery_data_authorization_info_core {
  dimension: granted {
    type: yesno
    sql: ${TABLE}.granted ;;
  }

  dimension: permission {
    type: string
    sql: ${TABLE}.permission ;;
  }

  dimension: resource {
    type: string
    sql: ${TABLE}.resource ;;
  }
}

view: bigquery_data_access_payload_core {
  dimension: authentication_info {
    hidden: yes
    sql: ${TABLE}.authenticationInfo ;;
  }

  dimension: authorization_info {
    hidden: yes
    sql: ${TABLE}.authorizationInfo ;;
  }

  dimension: method_name {
    type: string
    sql: ${TABLE}.methodName ;;
  }

  dimension: num_response_items {
    type: number
    sql: ${TABLE}.numResponseItems ;;
  }

  dimension: request_metadata {
    hidden: yes
    sql: ${TABLE}.requestMetadata ;;
  }

  dimension: resource_name {
    type: string
    sql: ${TABLE}.resourceName ;;
  }

  dimension: service_name {
    type: string
    sql: ${TABLE}.serviceName ;;
  }

  dimension: servicedata_v1_bigquery {
    hidden: yes
    sql: ${TABLE}.servicedata_v1_bigquery ;;
  }

  dimension: status {
    hidden: yes
    sql: ${TABLE}.status ;;
  }
}

view: bigquery_data_access_table_data_list_request_core {
  dimension: max_results {
    type: number
    sql: ${TABLE}.maxResults ;;
  }

  dimension: start_row {
    type: number
    sql: ${TABLE}.startRow ;;
  }
}

view: bigquery_data_access_job_completed_event_core {
  dimension: event_name {
    type: string
    sql: ${TABLE}.eventName ;;
  }

  dimension: job {
    hidden: yes
    sql: ${TABLE}.job ;;
  }
}

view: bigquery_data_access_job_name_core {
  dimension: job_id {
    type: string
    sql: ${TABLE}.jobId ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.projectId ;;
  }
}

view: bigquery_data_access_job_status_core {
  dimension: error {
    hidden: yes
    sql: ${TABLE}.error ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: query_failed {
    type: yesno
    sql: ${error} IS NOT NULL ;;
}
}

view: bigquery_data_access_job_status_error_core {
  dimension: code {
    type: number
    sql: ${TABLE}.code ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

}

view: bigquery_data_access_job_statistics_core {
  dimension: billing_tier {
    type: number
    sql: ${TABLE}.billingTier ;;
  }

  dimension_group: create {
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
    sql: ${TABLE}.createTime ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.endTime ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.startTime ;;
  }

  dimension: billed_bytes {
    type: number
    sql: ${TABLE}.totalBilledBytes ;;
  }

  dimension: processed_bytes {
    type: number
    sql: ${TABLE}.totalProcessedBytes ;;
  }

  dimension: billed_gigabytes {
    type: number
    sql: 1.0*${billed_bytes}/1000000000 ;;
  }

  dimension: billed_terabytes {
    type: number
    sql: 1.0*${billed_bytes}/1000000000000 ;;
  }

  measure: total_billed_gigabytes {
    type: sum
    view_label: "BigQuery Data Access: Query Statistics"
    sql: ${billed_gigabytes} ;;
    value_format_name: decimal_2
    drill_fields: [bigquery_data_access_authentication_info.user_id
      , bigquery_data_access_job_statistics.start_time
      , bigquery_data_access_resource_labels.project_id
      , bigquery_data_access_query.query
      , bigquery_data_access_job_statistics.billed_gigabytes
      , bigquery_data_access_job_statistics.query_runtime
      , bigquery_data_access_job_statistics.query_cost
      , bigquery_data_access_job_status_error.code
      , bigquery_data_access_job_status_error.message]
  }

  measure: total_billed_terabytes {
    type: sum
    view_label: "BigQuery Data Access: Query Statistics"
    sql: ${billed_terabytes} ;;
    value_format_name: decimal_2
    drill_fields: [bigquery_data_access_authentication_info.user_id
      , bigquery_data_access_job_statistics.start_time
      , bigquery_data_access_resource_labels.project_id
      , bigquery_data_access_query.query
      , bigquery_data_access_job_statistics.billed_gigabytes
      , bigquery_data_access_job_statistics.query_runtime
      , bigquery_data_access_job_statistics.query_cost
      , bigquery_data_access_job_status_error.code
      , bigquery_data_access_job_status_error.message]
  }

  measure: average_billed_gigabytes {
    type: average
    view_label: "BigQuery Data Access: Query Statistics"
    sql: ${billed_gigabytes} ;;
    value_format_name: decimal_2
    drill_fields: [bigquery_data_access_authentication_info.user_id
      , bigquery_data_access_job_statistics.start_time
      , bigquery_data_access_resource_labels.project_id
      , bigquery_data_access_query.query
      , bigquery_data_access_job_statistics.billed_gigabytes
      , bigquery_data_access_job_statistics.query_runtime
      , bigquery_data_access_job_statistics.query_cost
      , bigquery_data_access_job_status_error.code
      , bigquery_data_access_job_status_error.message]
  }

  measure: average_billed_terabytes {
    type: average
    view_label: "BigQuery Data Access: Query Statistics"
    sql: ${billed_terabytes} ;;
    value_format_name: decimal_2
    drill_fields: [bigquery_data_access_authentication_info.user_id
      , bigquery_data_access_job_statistics.start_time
      , bigquery_data_access_resource_labels.project_id
      , bigquery_data_access_query.query
      , bigquery_data_access_job_statistics.billed_gigabytes
      , bigquery_data_access_job_statistics.query_runtime
      , bigquery_data_access_job_statistics.query_cost
      , bigquery_data_access_job_status_error.code
      , bigquery_data_access_job_status_error.message]
  }

  dimension: query_cost {
    type: number
    sql: 5.0*${billed_bytes}/1000000000000 ;;
    value_format_name: usd
  }

  measure: total_query_cost {
    type: sum
    sql: ${query_cost} ;;
    value_format_name: usd
    drill_fields: [bigquery_data_access_authentication_info.user_id
      , bigquery_data_access_job_statistics.start_time
      , bigquery_data_access_resource_labels.project_id
      , bigquery_data_access_query.query
      , bigquery_data_access_job_statistics.billed_gigabytes
      , bigquery_data_access_job_statistics.query_runtime
      , bigquery_data_access_job_statistics.query_cost
      , bigquery_data_access_job_status_error.code
      , bigquery_data_access_job_status_error.message]
  }

  measure: average_query_cost {
    type: average
    sql: ${query_cost} ;;
    value_format_name: usd
    drill_fields: [bigquery_data_access_authentication_info.user_id
      , bigquery_data_access_job_statistics.start_time
      , bigquery_data_access_resource_labels.project_id
      , bigquery_data_access_query.query
      , bigquery_data_access_job_statistics.billed_gigabytes
      , bigquery_data_access_job_statistics.query_runtime
      , bigquery_data_access_job_statistics.query_cost
      , bigquery_data_access_job_status_error.code
      , bigquery_data_access_job_status_error.message]
  }

  dimension: query_runtime {
    type: number
    sql: 1.0*TIMESTAMP_DIFF(${end_raw}, ${start_raw}, MILLISECOND)/1000 ;;
    value_format_name: decimal_1
  }

  measure: average_query_runtime {
    type: average
    sql: ${query_runtime} ;;
    value_format_name: decimal_1
    drill_fields: [bigquery_data_access_authentication_info.user_id
      , bigquery_data_access_job_statistics.start_time
      , bigquery_data_access_resource_labels.project_id
      , bigquery_data_access_query.query
      , bigquery_data_access_job_statistics.billed_gigabytes
      , bigquery_data_access_job_statistics.query_runtime
      , bigquery_data_access_job_statistics.query_cost
      , bigquery_data_access_job_status_error.code
      , bigquery_data_access_job_status_error.message]
  }
}

view: bigquery_data_access_job_configuration_core {
  dimension: dry_run {
    type: yesno
    sql: ${TABLE}.dryRun ;;
  }

  dimension: query {
    hidden: yes
    sql: ${TABLE}.query ;;
  }
}

view: bigquery_data_access_query_destination_table_core {
  dimension: dataset_id {
    type: string
    sql: ${TABLE}.datasetId ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.projectId ;;
  }

  dimension: table_id {
    type: string
    sql: ${TABLE}.tableId ;;
  }
}

view: bigquery_data_access_query_table_definitions_core {
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: source_uris {
    type: string
    sql: ${TABLE}.sourceUris ;;
  }
}

view: bigquery_data_access_query_core {

  filter: query_text_filter {
    type: string
  }

  dimension: query_text_selector {
    type: string
    case: {
      when: {
        sql: {% condition query_text_filter %} ${query} {% endcondition %} ;;
        label: "Queries with Specified Pattern"
      }
      else: "All Other Queries"
    }
  }

  dimension: create_disposition {
    type: string
    sql: ${TABLE}.createDisposition ;;
  }

  dimension: default_dataset {
    hidden: yes
    sql: ${TABLE}.defaultDataset ;;
  }

  dimension: destination_table {
    hidden: yes
    sql: ${TABLE}.destinationTable ;;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }

  dimension: table_definitions {
    hidden: yes
    sql: ${TABLE}.tableDefinitions ;;
  }

  dimension: write_disposition {
    type: string
    sql: ${TABLE}.writeDisposition ;;
  }
}

view: bigquery_data_access_query_default_dataset_core {
  dimension: dataset_id {
    type: string
    sql: ${TABLE}.datasetId ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.projectId ;;
  }
}

view: bigquery_data_access_protopayload_auditlog_status_core {
  dimension: code {
    type: number
    sql: ${TABLE}.code ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }
}

view: bigquery_data_access_servicedata_core {
  dimension: job_completed_event {
    hidden: yes
    sql: ${TABLE}.jobCompletedEvent ;;
  }

  dimension: job_get_query_results_request {
    hidden: yes
    sql: ${TABLE}.jobGetQueryResultsRequest ;;
  }

  dimension: job_get_query_results_response {
    hidden: yes
    sql: ${TABLE}.jobGetQueryResultsResponse ;;
  }

  dimension: job_insert_request {
    hidden: yes
    sql: ${TABLE}.jobInsertRequest ;;
  }

  dimension: job_insert_response {
    hidden: yes
    sql: ${TABLE}.jobInsertResponse ;;
  }

  dimension: job_query_request {
    hidden: yes
    sql: ${TABLE}.jobQueryRequest ;;
  }

  dimension: job_query_response {
    hidden: yes
    sql: ${TABLE}.jobQueryResponse ;;
  }

  dimension: table_data_list_request {
    hidden: yes
    sql: ${TABLE}.tableDataListRequest ;;
  }
}


view: bigquery_data_access_job_core {
  dimension: job_configuration {
    hidden: yes
    sql: ${TABLE}.jobConfiguration ;;
  }

  dimension: job_name {
    hidden: yes
    sql: ${TABLE}.jobName ;;
  }

  dimension: job_statistics {
    hidden: yes
    sql: ${TABLE}.jobStatistics ;;
  }

  dimension: job_status {
    hidden: yes
    sql: ${TABLE}.jobStatus ;;
  }
}
