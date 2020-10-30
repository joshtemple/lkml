view: profile {
  sql_table_name: salesforce.profile ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.created_by_id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_date ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: last_modified_by_id {
    type: string
    sql: ${TABLE}.last_modified_by_id ;;
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
    sql: ${TABLE}.last_modified_date ;;
  }

  dimension_group: last_referenced {
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
    sql: ${TABLE}.last_referenced_date ;;
  }

  dimension_group: last_viewed {
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
    sql: ${TABLE}.last_viewed_date ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: permissions_access_cmc {
    type: yesno
    sql: ${TABLE}.permissions_access_cmc ;;
  }

  dimension: permissions_activate_contract {
    type: yesno
    sql: ${TABLE}.permissions_activate_contract ;;
  }

  dimension: permissions_activate_order {
    type: yesno
    sql: ${TABLE}.permissions_activate_order ;;
  }

  dimension: permissions_allow_email_ic {
    type: yesno
    sql: ${TABLE}.permissions_allow_email_ic ;;
  }

  dimension: permissions_allow_view_edit_converted_leads {
    type: yesno
    sql: ${TABLE}.permissions_allow_view_edit_converted_leads ;;
  }

  dimension: permissions_api_enabled {
    type: yesno
    sql: ${TABLE}.permissions_api_enabled ;;
  }

  dimension: permissions_api_user_only {
    type: yesno
    sql: ${TABLE}.permissions_api_user_only ;;
  }

  dimension: permissions_assign_permission_sets {
    type: yesno
    sql: ${TABLE}.permissions_assign_permission_sets ;;
  }

  dimension: permissions_assign_topics {
    type: yesno
    sql: ${TABLE}.permissions_assign_topics ;;
  }

  dimension: permissions_author_apex {
    type: yesno
    sql: ${TABLE}.permissions_author_apex ;;
  }

  dimension: permissions_bulk_api_hard_delete {
    type: yesno
    sql: ${TABLE}.permissions_bulk_api_hard_delete ;;
  }

  dimension: permissions_bulk_macros_allowed {
    type: yesno
    sql: ${TABLE}.permissions_bulk_macros_allowed ;;
  }

  dimension: permissions_campaign_influence_2 {
    type: yesno
    sql: ${TABLE}.permissions_campaign_influence_2 ;;
  }

  dimension: permissions_can_approve_feed_post {
    type: yesno
    sql: ${TABLE}.permissions_can_approve_feed_post ;;
  }

  dimension: permissions_can_insert_feed_system_fields {
    type: yesno
    sql: ${TABLE}.permissions_can_insert_feed_system_fields ;;
  }

  dimension: permissions_can_use_new_dashboard_builder {
    type: yesno
    sql: ${TABLE}.permissions_can_use_new_dashboard_builder ;;
  }

  dimension: permissions_chatter_compose_ui_codesnippet {
    type: yesno
    sql: ${TABLE}.permissions_chatter_compose_ui_codesnippet ;;
  }

  dimension: permissions_chatter_edit_own_post {
    type: yesno
    sql: ${TABLE}.permissions_chatter_edit_own_post ;;
  }

  dimension: permissions_chatter_edit_own_record_post {
    type: yesno
    sql: ${TABLE}.permissions_chatter_edit_own_record_post ;;
  }

  dimension: permissions_chatter_file_link {
    type: yesno
    sql: ${TABLE}.permissions_chatter_file_link ;;
  }

  dimension: permissions_chatter_internal_user {
    type: yesno
    sql: ${TABLE}.permissions_chatter_internal_user ;;
  }

  dimension: permissions_chatter_invite_external_users {
    type: yesno
    sql: ${TABLE}.permissions_chatter_invite_external_users ;;
  }

  dimension: permissions_chatter_own_groups {
    type: yesno
    sql: ${TABLE}.permissions_chatter_own_groups ;;
  }

  dimension: permissions_config_custom_recs {
    type: yesno
    sql: ${TABLE}.permissions_config_custom_recs ;;
  }

  dimension: permissions_connect_org_to_environment_hub {
    type: yesno
    sql: ${TABLE}.permissions_connect_org_to_environment_hub ;;
  }

  dimension: permissions_content_administrator {
    type: yesno
    sql: ${TABLE}.permissions_content_administrator ;;
  }

  dimension: permissions_convert_leads {
    type: yesno
    sql: ${TABLE}.permissions_convert_leads ;;
  }

  dimension: permissions_create_customize_dashboards {
    type: yesno
    sql: ${TABLE}.permissions_create_customize_dashboards ;;
  }

  dimension: permissions_create_customize_filters {
    type: yesno
    sql: ${TABLE}.permissions_create_customize_filters ;;
  }

  dimension: permissions_create_customize_reports {
    type: yesno
    sql: ${TABLE}.permissions_create_customize_reports ;;
  }

  dimension: permissions_create_dashboard_folders {
    type: yesno
    sql: ${TABLE}.permissions_create_dashboard_folders ;;
  }

  dimension: permissions_create_multiforce {
    type: yesno
    sql: ${TABLE}.permissions_create_multiforce ;;
  }

  dimension: permissions_create_report_folders {
    type: yesno
    sql: ${TABLE}.permissions_create_report_folders ;;
  }

  dimension: permissions_create_topics {
    type: yesno
    sql: ${TABLE}.permissions_create_topics ;;
  }

  dimension: permissions_create_update_sdddataset {
    type: yesno
    sql: ${TABLE}.permissions_create_update_sdddataset ;;
  }

  dimension: permissions_create_update_sddstory {
    type: yesno
    sql: ${TABLE}.permissions_create_update_sddstory ;;
  }

  dimension: permissions_create_work_badge_definition {
    type: yesno
    sql: ${TABLE}.permissions_create_work_badge_definition ;;
  }

  dimension: permissions_create_workspaces {
    type: yesno
    sql: ${TABLE}.permissions_create_workspaces ;;
  }

  dimension: permissions_custom_mobile_apps_access {
    type: yesno
    sql: ${TABLE}.permissions_custom_mobile_apps_access ;;
  }

  dimension: permissions_custom_sidebar_on_all_pages {
    type: yesno
    sql: ${TABLE}.permissions_custom_sidebar_on_all_pages ;;
  }

  dimension: permissions_customize_application {
    type: yesno
    sql: ${TABLE}.permissions_customize_application ;;
  }

  dimension: permissions_data_export {
    type: yesno
    sql: ${TABLE}.permissions_data_export ;;
  }

  dimension: permissions_delegated_two_factor {
    type: yesno
    sql: ${TABLE}.permissions_delegated_two_factor ;;
  }

  dimension: permissions_delete_activated_contract {
    type: yesno
    sql: ${TABLE}.permissions_delete_activated_contract ;;
  }

  dimension: permissions_delete_topics {
    type: yesno
    sql: ${TABLE}.permissions_delete_topics ;;
  }

  dimension: permissions_distribute_from_pers_wksp {
    type: yesno
    sql: ${TABLE}.permissions_distribute_from_pers_wksp ;;
  }

  dimension: permissions_edit_activated_orders {
    type: yesno
    sql: ${TABLE}.permissions_edit_activated_orders ;;
  }

  dimension: permissions_edit_brand_templates {
    type: yesno
    sql: ${TABLE}.permissions_edit_brand_templates ;;
  }

  dimension: permissions_edit_case_comments {
    type: yesno
    sql: ${TABLE}.permissions_edit_case_comments ;;
  }

  dimension: permissions_edit_event {
    type: yesno
    sql: ${TABLE}.permissions_edit_event ;;
  }

  dimension: permissions_edit_html_templates {
    type: yesno
    sql: ${TABLE}.permissions_edit_html_templates ;;
  }

  dimension: permissions_edit_my_dashboards {
    type: yesno
    sql: ${TABLE}.permissions_edit_my_dashboards ;;
  }

  dimension: permissions_edit_my_reports {
    type: yesno
    sql: ${TABLE}.permissions_edit_my_reports ;;
  }

  dimension: permissions_edit_opp_line_item_unit_price {
    type: yesno
    sql: ${TABLE}.permissions_edit_opp_line_item_unit_price ;;
  }

  dimension: permissions_edit_public_documents {
    type: yesno
    sql: ${TABLE}.permissions_edit_public_documents ;;
  }

  dimension: permissions_edit_public_templates {
    type: yesno
    sql: ${TABLE}.permissions_edit_public_templates ;;
  }

  dimension: permissions_edit_readonly_fields {
    type: yesno
    sql: ${TABLE}.permissions_edit_readonly_fields ;;
  }

  dimension: permissions_edit_task {
    type: yesno
    sql: ${TABLE}.permissions_edit_task ;;
  }

  dimension: permissions_edit_topics {
    type: yesno
    sql: ${TABLE}.permissions_edit_topics ;;
  }

  dimension: permissions_email_administration {
    type: yesno
    sql: ${TABLE}.permissions_email_administration ;;
  }

  dimension: permissions_email_mass {
    type: yesno
    sql: ${TABLE}.permissions_email_mass ;;
  }

  dimension: permissions_email_single {
    type: yesno
    sql: ${TABLE}.permissions_email_single ;;
  }

  dimension: permissions_email_template_management {
    type: yesno
    sql: ${TABLE}.permissions_email_template_management ;;
  }

  dimension: permissions_enable_notifications {
    type: yesno
    sql: ${TABLE}.permissions_enable_notifications ;;
  }

  dimension: permissions_export_report {
    type: yesno
    sql: ${TABLE}.permissions_export_report ;;
  }

  dimension: permissions_flow_uflrequired {
    type: yesno
    sql: ${TABLE}.permissions_flow_uflrequired ;;
  }

  dimension: permissions_force_two_factor {
    type: yesno
    sql: ${TABLE}.permissions_force_two_factor ;;
  }

  dimension: permissions_get_smart_data_discovery {
    type: yesno
    sql: ${TABLE}.permissions_get_smart_data_discovery ;;
  }

  dimension: permissions_govern_networks {
    type: yesno
    sql: ${TABLE}.permissions_govern_networks ;;
  }

  dimension: permissions_identity_connect {
    type: yesno
    sql: ${TABLE}.permissions_identity_connect ;;
  }

  dimension: permissions_identity_enabled {
    type: yesno
    sql: ${TABLE}.permissions_identity_enabled ;;
  }

  dimension: permissions_import_custom_objects {
    type: yesno
    sql: ${TABLE}.permissions_import_custom_objects ;;
  }

  dimension: permissions_import_leads {
    type: yesno
    sql: ${TABLE}.permissions_import_leads ;;
  }

  dimension: permissions_import_personal {
    type: yesno
    sql: ${TABLE}.permissions_import_personal ;;
  }

  dimension: permissions_inbound_migration_tools_user {
    type: yesno
    sql: ${TABLE}.permissions_inbound_migration_tools_user ;;
  }

  dimension: permissions_install_multiforce {
    type: yesno
    sql: ${TABLE}.permissions_install_multiforce ;;
  }

  dimension: permissions_lightning_experience_user {
    type: yesno
    sql: ${TABLE}.permissions_lightning_experience_user ;;
  }

  dimension: permissions_manage_analytic_snapshots {
    type: yesno
    sql: ${TABLE}.permissions_manage_analytic_snapshots ;;
  }

  dimension: permissions_manage_auth_providers {
    type: yesno
    sql: ${TABLE}.permissions_manage_auth_providers ;;
  }

  dimension: permissions_manage_business_hour_holidays {
    type: yesno
    sql: ${TABLE}.permissions_manage_business_hour_holidays ;;
  }

  dimension: permissions_manage_call_centers {
    type: yesno
    sql: ${TABLE}.permissions_manage_call_centers ;;
  }

  dimension: permissions_manage_cases {
    type: yesno
    sql: ${TABLE}.permissions_manage_cases ;;
  }

  dimension: permissions_manage_categories {
    type: yesno
    sql: ${TABLE}.permissions_manage_categories ;;
  }

  dimension: permissions_manage_chatter_messages {
    type: yesno
    sql: ${TABLE}.permissions_manage_chatter_messages ;;
  }

  dimension: permissions_manage_content_permissions {
    type: yesno
    sql: ${TABLE}.permissions_manage_content_permissions ;;
  }

  dimension: permissions_manage_content_properties {
    type: yesno
    sql: ${TABLE}.permissions_manage_content_properties ;;
  }

  dimension: permissions_manage_content_types {
    type: yesno
    sql: ${TABLE}.permissions_manage_content_types ;;
  }

  dimension: permissions_manage_custom_permissions {
    type: yesno
    sql: ${TABLE}.permissions_manage_custom_permissions ;;
  }

  dimension: permissions_manage_custom_report_types {
    type: yesno
    sql: ${TABLE}.permissions_manage_custom_report_types ;;
  }

  dimension: permissions_manage_dashbds_in_pub_folders {
    type: yesno
    sql: ${TABLE}.permissions_manage_dashbds_in_pub_folders ;;
  }

  dimension: permissions_manage_data_categories {
    type: yesno
    sql: ${TABLE}.permissions_manage_data_categories ;;
  }

  dimension: permissions_manage_data_integrations {
    type: yesno
    sql: ${TABLE}.permissions_manage_data_integrations ;;
  }

  dimension: permissions_manage_email_client_config {
    type: yesno
    sql: ${TABLE}.permissions_manage_email_client_config ;;
  }

  dimension: permissions_manage_exchange_config {
    type: yesno
    sql: ${TABLE}.permissions_manage_exchange_config ;;
  }

  dimension: permissions_manage_health_check {
    type: yesno
    sql: ${TABLE}.permissions_manage_health_check ;;
  }

  dimension: permissions_manage_interaction {
    type: yesno
    sql: ${TABLE}.permissions_manage_interaction ;;
  }

  dimension: permissions_manage_internal_users {
    type: yesno
    sql: ${TABLE}.permissions_manage_internal_users ;;
  }

  dimension: permissions_manage_ip_addresses {
    type: yesno
    sql: ${TABLE}.permissions_manage_ip_addresses ;;
  }

  dimension: permissions_manage_leads {
    type: yesno
    sql: ${TABLE}.permissions_manage_leads ;;
  }

  dimension: permissions_manage_login_access_policies {
    type: yesno
    sql: ${TABLE}.permissions_manage_login_access_policies ;;
  }

  dimension: permissions_manage_mobile {
    type: yesno
    sql: ${TABLE}.permissions_manage_mobile ;;
  }

  dimension: permissions_manage_networks {
    type: yesno
    sql: ${TABLE}.permissions_manage_networks ;;
  }

  dimension: permissions_manage_password_policies {
    type: yesno
    sql: ${TABLE}.permissions_manage_password_policies ;;
  }

  dimension: permissions_manage_profiles_permissionsets {
    type: yesno
    sql: ${TABLE}.permissions_manage_profiles_permissionsets ;;
  }

  dimension: permissions_manage_pvt_rpts_and_dashbds {
    type: yesno
    sql: ${TABLE}.permissions_manage_pvt_rpts_and_dashbds ;;
  }

  dimension: permissions_manage_quotas {
    type: yesno
    sql: ${TABLE}.permissions_manage_quotas ;;
  }

  dimension: permissions_manage_remote_access {
    type: yesno
    sql: ${TABLE}.permissions_manage_remote_access ;;
  }

  dimension: permissions_manage_reports_in_pub_folders {
    type: yesno
    sql: ${TABLE}.permissions_manage_reports_in_pub_folders ;;
  }

  dimension: permissions_manage_roles {
    type: yesno
    sql: ${TABLE}.permissions_manage_roles ;;
  }

  dimension: permissions_manage_sandboxes {
    type: yesno
    sql: ${TABLE}.permissions_manage_sandboxes ;;
  }

  dimension: permissions_manage_session_permission_sets {
    type: yesno
    sql: ${TABLE}.permissions_manage_session_permission_sets ;;
  }

  dimension: permissions_manage_sharing {
    type: yesno
    sql: ${TABLE}.permissions_manage_sharing ;;
  }

  dimension: permissions_manage_smart_data_discovery {
    type: yesno
    sql: ${TABLE}.permissions_manage_smart_data_discovery ;;
  }

  dimension: permissions_manage_smart_data_discovery_model {
    type: yesno
    sql: ${TABLE}.permissions_manage_smart_data_discovery_model ;;
  }

  dimension: permissions_manage_solutions {
    type: yesno
    sql: ${TABLE}.permissions_manage_solutions ;;
  }

  dimension: permissions_manage_synonyms {
    type: yesno
    sql: ${TABLE}.permissions_manage_synonyms ;;
  }

  dimension: permissions_manage_two_factor {
    type: yesno
    sql: ${TABLE}.permissions_manage_two_factor ;;
  }

  dimension: permissions_manage_unlisted_groups {
    type: yesno
    sql: ${TABLE}.permissions_manage_unlisted_groups ;;
  }

  dimension: permissions_manage_users {
    type: yesno
    sql: ${TABLE}.permissions_manage_users ;;
  }

  dimension: permissions_mass_inline_edit {
    type: yesno
    sql: ${TABLE}.permissions_mass_inline_edit ;;
  }

  dimension: permissions_merge_topics {
    type: yesno
    sql: ${TABLE}.permissions_merge_topics ;;
  }

  dimension: permissions_moderate_chatter {
    type: yesno
    sql: ${TABLE}.permissions_moderate_chatter ;;
  }

  dimension: permissions_moderate_network_users {
    type: yesno
    sql: ${TABLE}.permissions_moderate_network_users ;;
  }

  dimension: permissions_modify_all_data {
    type: yesno
    sql: ${TABLE}.permissions_modify_all_data ;;
  }

  dimension: permissions_new_report_builder {
    type: yesno
    sql: ${TABLE}.permissions_new_report_builder ;;
  }

  dimension: permissions_outbound_migration_tools_user {
    type: yesno
    sql: ${TABLE}.permissions_outbound_migration_tools_user ;;
  }

  dimension: permissions_override_forecasts {
    type: yesno
    sql: ${TABLE}.permissions_override_forecasts ;;
  }

  dimension: permissions_password_never_expires {
    type: yesno
    sql: ${TABLE}.permissions_password_never_expires ;;
  }

  dimension: permissions_publish_multiforce {
    type: yesno
    sql: ${TABLE}.permissions_publish_multiforce ;;
  }

  dimension: permissions_reset_passwords {
    type: yesno
    sql: ${TABLE}.permissions_reset_passwords ;;
  }

  dimension: permissions_run_flow {
    type: yesno
    sql: ${TABLE}.permissions_run_flow ;;
  }

  dimension: permissions_run_reports {
    type: yesno
    sql: ${TABLE}.permissions_run_reports ;;
  }

  dimension: permissions_sales_console {
    type: yesno
    sql: ${TABLE}.permissions_sales_console ;;
  }

  dimension: permissions_schedule_job {
    type: yesno
    sql: ${TABLE}.permissions_schedule_job ;;
  }

  dimension: permissions_schedule_reports {
    type: yesno
    sql: ${TABLE}.permissions_schedule_reports ;;
  }

  dimension: permissions_select_files_from_salesforce {
    type: yesno
    sql: ${TABLE}.permissions_select_files_from_salesforce ;;
  }

  dimension: permissions_send_announcement_emails {
    type: yesno
    sql: ${TABLE}.permissions_send_announcement_emails ;;
  }

  dimension: permissions_send_sit_requests {
    type: yesno
    sql: ${TABLE}.permissions_send_sit_requests ;;
  }

  dimension: permissions_share_smart_data_discovery_story {
    type: yesno
    sql: ${TABLE}.permissions_share_smart_data_discovery_story ;;
  }

  dimension: permissions_show_company_name_as_user_badge {
    type: yesno
    sql: ${TABLE}.permissions_show_company_name_as_user_badge ;;
  }

  dimension: permissions_social_insights_logo_admin {
    type: yesno
    sql: ${TABLE}.permissions_social_insights_logo_admin ;;
  }

  dimension: permissions_solution_import {
    type: yesno
    sql: ${TABLE}.permissions_solution_import ;;
  }

  dimension: permissions_submit_macros_allowed {
    type: yesno
    sql: ${TABLE}.permissions_submit_macros_allowed ;;
  }

  dimension: permissions_subscribe_to_lightning_reports {
    type: yesno
    sql: ${TABLE}.permissions_subscribe_to_lightning_reports ;;
  }

  dimension: permissions_transfer_any_case {
    type: yesno
    sql: ${TABLE}.permissions_transfer_any_case ;;
  }

  dimension: permissions_transfer_any_entity {
    type: yesno
    sql: ${TABLE}.permissions_transfer_any_entity ;;
  }

  dimension: permissions_transfer_any_lead {
    type: yesno
    sql: ${TABLE}.permissions_transfer_any_lead ;;
  }

  dimension: permissions_two_factor_api {
    type: yesno
    sql: ${TABLE}.permissions_two_factor_api ;;
  }

  dimension: permissions_use_smart_data_discovery {
    type: yesno
    sql: ${TABLE}.permissions_use_smart_data_discovery ;;
  }

  dimension: permissions_use_team_reassign_wizards {
    type: yesno
    sql: ${TABLE}.permissions_use_team_reassign_wizards ;;
  }

  dimension: permissions_view_all_activities {
    type: yesno
    sql: ${TABLE}.permissions_view_all_activities ;;
  }

  dimension: permissions_view_all_data {
    type: yesno
    sql: ${TABLE}.permissions_view_all_data ;;
  }

  dimension: permissions_view_all_forecasts {
    type: yesno
    sql: ${TABLE}.permissions_view_all_forecasts ;;
  }

  dimension: permissions_view_all_users {
    type: yesno
    sql: ${TABLE}.permissions_view_all_users ;;
  }

  dimension: permissions_view_case_interaction {
    type: yesno
    sql: ${TABLE}.permissions_view_case_interaction ;;
  }

  dimension: permissions_view_content {
    type: yesno
    sql: ${TABLE}.permissions_view_content ;;
  }

  dimension: permissions_view_data_assessment {
    type: yesno
    sql: ${TABLE}.permissions_view_data_assessment ;;
  }

  dimension: permissions_view_data_categories {
    type: yesno
    sql: ${TABLE}.permissions_view_data_categories ;;
  }

  dimension: permissions_view_encrypted_data {
    type: yesno
    sql: ${TABLE}.permissions_view_encrypted_data ;;
  }

  dimension: permissions_view_event_log_files {
    type: yesno
    sql: ${TABLE}.permissions_view_event_log_files ;;
  }

  dimension: permissions_view_health_check {
    type: yesno
    sql: ${TABLE}.permissions_view_health_check ;;
  }

  dimension: permissions_view_help_link {
    type: yesno
    sql: ${TABLE}.permissions_view_help_link ;;
  }

  dimension: permissions_view_my_teams_dashboards {
    type: yesno
    sql: ${TABLE}.permissions_view_my_teams_dashboards ;;
  }

  dimension: permissions_view_public_dashboards {
    type: yesno
    sql: ${TABLE}.permissions_view_public_dashboards ;;
  }

  dimension: permissions_view_public_reports {
    type: yesno
    sql: ${TABLE}.permissions_view_public_reports ;;
  }

  dimension: permissions_view_setup {
    type: yesno
    sql: ${TABLE}.permissions_view_setup ;;
  }

  dimension_group: received {
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
    sql: ${TABLE}.received_at ;;
  }

  dimension_group: system_modstamp {
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
    sql: ${TABLE}.system_modstamp ;;
  }

  dimension: user_license_id {
    type: string
    sql: ${TABLE}.user_license_id ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension: uuid {
    type: number
    value_format_name: id
    sql: ${TABLE}.uuid ;;
  }

  dimension_group: uuid_ts {
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
    sql: ${TABLE}.uuid_ts ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, users.count]
  }
}
