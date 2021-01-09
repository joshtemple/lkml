label: "Data Quality"

connection: "thelook"

# include below listed views in this model. #[ERXLPS-6444][ERXDWPS-5122]
include: "dq_*.view"
include: "sync_*.view"
include: "chain.view"
include: "store.view"
include: "store_alignment.view"
include: "store_contact_information.view"
include: "store_to_time_zone_cross_ref.view"
include: "source_system.view"
include: "eps_stage_symmetric_load.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
include: "exploredx_symmetric_chain_health*.dashboard"


#persist_for: "6 hours" #[ERXLPS-6444]

#[ERXLPS-6444]
persist_with: etl_cache_info

datagroup: etl_cache_info {
  sql_trigger: SELECT MAX(event_id) FROM etl_manager.event ;; # for every new ETL run the cache would get expired and come from DB irrespective of Explore
  max_cache_age: "25 hours"
}

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# converts values to upper case for data search
case_sensitive: no

############################################################# This model is to analyze the Data Quality Issues in Enterprise Data Warehouse and PDX Source Systems ################
############################################################ This model should be used only when custom SQL is required to better analyze a DQ issue #############################

explore: dq_active_rx_tx_eps_classic_missing_state {
  label: "EPS & Classic Missing Transactions Analysis"
  view_label: "EPS & Classic Missing Transactions Analysis"

  always_filter: {
    filters: {
      field: sold_date
      value: ""
    }

    filters: {
      field: filled_date
      value: ""
    }

    filters: {
      field: reportable_sales_date
      value: ""
    }
  }
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]

  description: "This view is used for analyzing missing transactions from both EPS & Classic system. Provides greater insight on whether a transaction exist in both the Systems. Note: Classic transactions are currently processed from EPR"

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${dq_active_rx_tx_eps_classic_missing_state.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${dq_active_rx_tx_eps_classic_missing_state.chain_id} = ${store.chain_id} AND ${dq_active_rx_tx_eps_classic_missing_state.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }
}

explore: dq_edw_missing_records_by_source_system {
  label: "EDW Missing Dataset Analysis"
  view_label: "EDW Missing Dataset Analysis"

  always_filter: {
    filters: {
      field: source_date
      value: ""
    }

    filters: {
      field: process_date
      value: ""
    }
  }
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]

  description: "This view is used for analyzing missing records in EDW. Ideally this view should always produce 0 records which indicates there are 0 un-processed records in EDW"

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${dq_edw_missing_records_by_source_system.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${dq_edw_missing_records_by_source_system.chain_id} = ${store.chain_id} AND ${dq_edw_missing_records_by_source_system.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: source_system {
    view_label: "BI Source System"
    type: inner
    sql_on: ${dq_edw_missing_records_by_source_system.source_system_id} = ${source_system.source_system_id} ;;
    relationship: many_to_one
  }
}

explore: dq_etl_missing_job_chain_entry {
  label: "ETL Missing Job Chain Entry"
  view_label: "ETL Missing Job Chain Entry"
  description: "This view is used for analyzing missing chain entry in ETL_JOB_CHAIN_REFRESH_FREQUENCY and ETL_JOB_HIGH_WATER_MARK table"

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${dq_etl_missing_job_chain_entry.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: source_system {
    view_label: "BI Source System"
    type: inner
    sql_on: ${dq_etl_missing_job_chain_entry.source_system_id} = ${source_system.source_system_id} ;;
    relationship: many_to_one
  }
}

explore: dq_sanity_check_src_tgt_data_count {
  label: "EDW Sanity Count"
  view_label: "EDW Sanity Count"
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]
  #   always_filter:
  #     source_date:
  #     process_date:
  #   description: "This view is used for analyzing missing records in EDW. Ideally this view should always produce 0 records which indicates there are 0 un-processed records in EDW"

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${dq_sanity_check_src_tgt_data_count.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${dq_sanity_check_src_tgt_data_count.chain_id} = ${store.chain_id} AND ${dq_sanity_check_src_tgt_data_count.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

#[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: source_system {
    view_label: "BI Source System"
    type: inner
    sql_on: ${dq_sanity_check_src_tgt_data_count.source_system_id} = ${source_system.source_system_id} ;;
    relationship: many_to_one
  }
}

######################################################## Symmetric Initial load - EPS_STAGE ##################################################################################

explore: eps_stage_symmetric_load {
  label: "Initial Load"
  view_label: "Initial Load"

  always_filter: {
    filters: {
      field: process_timestamp_filter
      value: "last 7 days"
    }

    filters: {
      field: chain.chain_id
      value: ""
    }
  }
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]

  description: "Displays information pertaining to Symmetric Initial Load's, for tables that are available in SnowFlake EPS_STAGE. IMPORTANT: SnowFlake EPS STAGE is purged every 30 days. Data is only available via this explore if it is within the last 30 days."

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${eps_stage_symmetric_load.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    type: inner
    view_label: "Pharmacy"
    sql_on: ${eps_stage_symmetric_load.chain_id} = ${store.chain_id}  AND ${eps_stage_symmetric_load.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }
}

######################################################## Symmetric Sunc Lag #################################################################################################

explore: eps_symmetric_sync_status {
  label: "Stage Data Availability"
  view_name: store
  view_label: "Pharmacy"
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${store.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${store.source_system_id} = 5 AND ${store.store_registration_status} = 'REGISTERED' AND ${chain.chain_deactivated_date} is null ;;
    relationship: many_to_one
  }

  join: store_to_time_zone_cross_ref {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_to_time_zone_cross_ref.chain_id} AND ${store.nhin_store_id} = ${store_to_time_zone_cross_ref.nhin_store_id} AND ${store.store_registration_status} = 'REGISTERED' AND ${store.deactivated_date} IS NULL ;;
    relationship: many_to_one
  }

  join: sync_lag_eps {
    view_label: "EPS Stage"
    type: left_outer
    sql_on: ${sync_lag_eps.chain_id} = ${store.chain_id} AND ${sync_lag_eps.nhin_store_id} = ${store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: sync_lag_epr {
    view_label: "EPR Stage"
    type: left_outer
    sql_on: ${sync_lag_epr.chain_id} = ${store.chain_id} AND ${sync_lag_epr.nhin_store_id} = ${store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: sync_lag_host {
    view_label: "Host Stage"
    type: left_outer
    sql_on: ${sync_lag_host.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: sync_lag_nhin {
    view_label: "NHIN Stage"
    type: left_outer
    sql_on: ${sync_lag_nhin.chain_id} = 3000 ;;
    relationship: many_to_one
  }
}

explore: dq_edw_records_missing_parent_by_source_system {
  label: "EDW Records Missing Parent Dataset Analysis"
  view_label: "EDW Records Missing Parent Dataset Analysis"

  always_filter: {
    filters: {
      field: source_date
      value: ""
    }
  }
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]

  description: "This view is used for analyzing missing records in EDW. Ideally this view should always produce 0 records which indicates there are 0 un-processed records in EDW"

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${dq_edw_records_missing_parent_by_source_system.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${dq_edw_records_missing_parent_by_source_system.chain_id} = ${store.chain_id} AND ${dq_edw_records_missing_parent_by_source_system.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: source_system {
    view_label: "BI Source System"
    type: inner
    sql_on: ${dq_edw_records_missing_parent_by_source_system.source_system_id} = ${source_system.source_system_id} ;;
    relationship: many_to_one
  }
}
