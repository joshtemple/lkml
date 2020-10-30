connection: "ml-metrics-dev"

# include all the views
include: "*.view"

datagroup: ml_metrics_dev_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ml_metrics_dev_default_datagroup

explore: metric_events {}

explore: metric_property {}

explore: event_import_jobs_last_1_hour {}

explore: event_import_last_5_mins {}

explore: event_import_last_24_hours {}

explore: last_2_hours_view {}

explore: calculated_last_2hours_view {}

explore: calculated_last_1_hour_view {}

explore: calculated_last_24_hours_view {}

explore: calculated_last_5_mins_view {}

explore: calculated_last_5_mins_with_site_id {}
