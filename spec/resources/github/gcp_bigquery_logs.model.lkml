connection: "sandbox"

include: "*.view.lkml"         # include all views in this project
include: "bigquery_audit.dashboard.lookml"  # include all dashboards in this project

explore: bigquery_data_access {
  view_label: "BigQuery Data Access"
  label: "BigQuery Data Access Logs"

  always_filter: {
    filters: {
      field: bigquery_data_access_payload.service_name
      value: "bigquery.googleapis.com"
    }
    filters: {
      field: bigquery_data_access_payload.method_name
      value: "jobservice.jobcompleted"
    }
    filters: {
      field: bigquery_data_access_job_completed_event.event_name
      value: "query_job_completed"
    }
  }

  join: bigquery_data_access_payload {
    view_label: "BigQuery Data Access"
    sql: LEFT JOIN UNNEST([${bigquery_data_access.protopayload_auditlog}]) as bigquery_data_access_payload ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_resource {
    view_label: "BigQuery Data Access: Resource"
    sql: LEFT JOIN UNNEST([${bigquery_data_access.resource}]) AS bigquery_data_access_resource ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_resource_labels {
    view_label: "BigQuery Data Access: Resource Labels"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_resource.labels}]) as bigquery_data_access_resource_labels ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_servicedata {
    view_label: "BigQuery Data Access: Service Data"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_payload.servicedata_v1_bigquery}]) AS bigquery_data_access_servicedata;;
    relationship: one_to_one
  }

  join: bigquery_data_access_job_completed_event {
    view_label: "BigQuery Data Access: Query Data"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_servicedata.job_completed_event}]) AS bigquery_data_access_job_completed_event ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_job {
    view_label: "BigQuery Data Access: Query Data"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_job_completed_event.job}]) AS bigquery_data_access_job ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_job_statistics {
    view_label: "BigQuery Data Access: Query Statistics"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_job.job_statistics}]) AS bigquery_data_access_job_statistics ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_job_configuration {
    view_label: "BigQuery Data Access: Config"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_job.job_configuration}]) AS bigquery_data_access_job_configuration ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_query {
    view_label: "BigQuery Data Access: Query"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_job_configuration.query}]) AS bigquery_data_access_query ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_query_destination_table {
    view_label: "BigQuery Data Access: Query"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_query.destination_table}]) AS bigquery_data_access_query_destination_table ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_job_status {
    view_label: "BigQuery Data Access: Status"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_job.job_status}]) AS bigquery_data_access_job_status ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_job_status_error {
    view_label: "BigQuery Data Access: Status"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_job_status.error}]) AS bigquery_data_access_job_status_error ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_authentication_info {
    view_label: "BigQuery Data Access"
    sql: LEFT JOIN UNNEST([${bigquery_data_access_payload.authentication_info}]) AS bigquery_data_access_authentication_info ;;
    relationship: one_to_one
  }

  join: bigquery_data_access_http_request {
    view_label: "BigQuery Data Access: Request"
    sql: LEFT JOIN UNNEST([${bigquery_data_access.http_request}]) AS bigquery_data_access_http_request ;;
    relationship: one_to_one
  }
}
