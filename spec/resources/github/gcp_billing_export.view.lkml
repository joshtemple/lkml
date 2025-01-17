view: gcp_billing_export_config {
  extends: [gcp_billing_export_core]
  extension: required
}

view: gcp_billing_export_credits_config {
  extends: [gcp_billing_export_credits_core]
  extension: required
}

view: gcp_billing_export_labels_config {
  extends: [gcp_billing_export_labels_core]
  extension: required
}

view: gcp_billing_export_project_config {
  extends: [gcp_billing_export_project_core]
  extension: required
}

view: gcp_billing_export_service_config {
  extends: [gcp_billing_export_service_core]
  extension: required
}

view: gcp_billing_export_sku_config {
  extends: [gcp_billing_export_sku_core]
  extension: required
}

view: gcp_billing_export_usage_config {
  extends: [gcp_billing_export_usage_core]
  extension: required
}

################## SORTING DERIVED TABLES ##################

view: project_name_sort_config {
  extends: [project_name_sort_core]
  extension: required
}

view: service_name_sort_config {
  extends: [service_name_sort_core]
  extension: required
}
