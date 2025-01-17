# include: "//block-bigquery-optimization/bigquery_data_access_core.view.lkml"

view: bigquery_data_access_config {
  extends: [bigquery_data_access_core]
  extension: required
}

view: bigquery_data_access_resource_config {
  extends: [bigquery_data_access_resource_core]
  extension: required
}

view: bigquery_data_access_resource_labels_config {
  extends: [bigquery_data_access_resource_labels_core]
  extension: required
}

view: bigquery_data_access_http_request_config {
  extends: [bigquery_data_access_http_request_core]
  extension: required
}

view: bigquery_data_access_source_location_config {
  extends: [bigquery_data_access_source_location_core]
  extension: required
}

view: bigquery_data_access_operation_config {
  extends: [bigquery_data_access_operation_core]
  extension: required
}

view: bigquery_data_access_request_metadata_config {
  extends: [bigquery_data_access_request_metadata_core]
  extension: required
}

view: bigquery_data_access_authentication_info_config {
  extends: [bigquery_data_access_authentication_info_core]
  extension: required
}

view: bigquery_data_authorization_info_config {
  extends: [bigquery_data_authorization_info_core]
  extension: required
}

view: bigquery_data_access_payload_config {
  extends: [bigquery_data_access_payload_core]
  extension: required
}

view: bigquery_data_access_table_data_list_request_config {
  extends: [bigquery_data_access_table_data_list_request_core]
  extension: required
}

view: bigquery_data_access_job_completed_event_config {
  extends: [bigquery_data_access_job_completed_event_core]
  extension: required
}

view: bigquery_data_access_job_name_config {
  extends: [bigquery_data_access_job_name_core]
  extension: required
}

view: bigquery_data_access_job_status_config {
  extends: [bigquery_data_access_job_status_core]
  extension: required
}

view: bigquery_data_access_job_status_error_config {
  extends: [bigquery_data_access_job_status_error_core]
  extension: required
}

view: bigquery_data_access_job_statistics_config {
  extends: [bigquery_data_access_job_statistics_core]
  extension: required
}

view: bigquery_data_access_job_configuration_config {
  extends: [bigquery_data_access_job_configuration_core]
  extension: required
}

view: bigquery_data_access_query_destination_table_config {
  extends: [bigquery_data_access_query_destination_table_core]
  extension: required
}

view: bigquery_data_access_query_table_definitions_config {
  extends: [bigquery_data_access_query_table_definitions_core]
  extension: required
}

view: bigquery_data_access_query_config {
  extends: [bigquery_data_access_query_core]
  extension: required
}

view: bigquery_data_access_query_default_dataset_config {
  extends: [bigquery_data_access_query_default_dataset_core]
  extension: required
}

view: bigquery_data_access_protopayload_auditlog_status_config {
  extends: [bigquery_data_access_protopayload_auditlog_status_core]
  extension: required
}

view: bigquery_data_access_servicedata_config {
  extends: [bigquery_data_access_servicedata_core]
  extension: required
}

view: bigquery_data_access_job_config {
  extends: [bigquery_data_access_job_core]
  extension: required
}
