#X# Note: failed to preserve comments during New LookML conversion


label: "Demo"

connection: "thelook"

include: "*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

include: "explore.base_dss"

persist_for: "72 hours"

week_start_day: sunday

case_sensitive: no

# ERXDWPS-5795 Changes
access_grant: can_view_genrx_specific_fields {
  user_attribute: allowed_chain
  allowed_values: [ "553", ">0 AND <> 119080", ">0", "NOT NULL" ]
}

explore: looker_data_dictionary {
  fields: [
    ALL_FIELDS*,
    -looker_data_dictionary.customer_field_exclusion_list*]
  extends: [looker_data_dictionary_base]
  sql_always_where: model_name = 'CUSTOMER_DEMO' and field_hidden = 'false' ;;
}

explore: master_code {
  extends: [master_code_base]
}

explore: store {
  view_name: bi_demo_store
  label: "Pharmacy"
  view_label: "Pharmacy Central"
  fields: [
    bi_demo_chain.chain_name,
    bi_demo_store.bi_demo_nhin_store_id,
    bi_demo_store.store_number,
    bi_demo_store.store_name,
    bi_demo_store.store_client_type,
    bi_demo_store.store_client_version,
    bi_demo_store.store_category,
    bi_demo_store.count,
    bi_demo_store.deactivated,
    bi_demo_store_state_location.zip_code,
    bi_demo_store_state_location.store_location,
    bi_demo_store_state_location.state_abbreviation,
    bi_demo_store_state_location.store_zip_code_primary_city,
    bi_demo_store_state_location.store_zip_code_estimated_population,
    bi_demo_store_state_location.store_zip_code_area_land,
    bi_demo_store_state_location.store_zip_code_population_count_100,
    bi_demo_store_state_location.store_zip_code_white_population,
    bi_demo_store_state_location.store_zip_code_black_or_african_american_population,
    bi_demo_store_state_location.store_zip_code_indian_or_alaskan_native_population,
    bi_demo_store_state_location.store_zip_code_asian_population,
    bi_demo_store_state_location.store_zip_code_native_hawaiian_and_other_pacific_islander_population,
    bi_demo_store_state_location.store_zip_code_other_race_population,
    bi_demo_store_state_location.store_zip_code_two_or_more_races_population,
    bi_demo_store_state_location.store_zip_code_male_population,
    bi_demo_store_state_location.store_zip_code_female_population,
    bi_demo_store_state_location.store_zip_code_population_under_10,
    bi_demo_store_state_location.store_zip_code_population_10_to_19,
    bi_demo_store_state_location.store_zip_code_population_20_to_29,
    bi_demo_store_state_location.store_zip_code_population_30_to_39,
    bi_demo_store_state_location.store_zip_code_population_40_to_49,
    bi_demo_store_state_location.store_zip_code_population_50_to_59,
    bi_demo_store_state_location.store_zip_code_population_60_to_69,
    bi_demo_store_state_location.store_zip_code_population_70_to_79,
    bi_demo_store_state_location.store_zip_code_population_80_plus,
    bi_demo_region.division,
    bi_demo_region.region,
    bi_demo_region.district,
    store_file_date.explore_rx_file_date_4_12_candidate_list*, #[ERXDWPS-5319]
    store_file_date_history.explore_rx_file_date_history_4_13_candidate_list* #[ERXDWPS-5319]

  ]
  description: "Displays information of store's demographic information, registration status, client information, and communication information"

  join: bi_demo_chain {
    view_label: "Pharmacy Central"
    type: inner
    sql_on: ${bi_demo_store.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store_state_location {
    view_label: "Pharmacy Central"
    type: left_outer
    sql_on: ${bi_demo_store.store_id} = ${bi_demo_store_state_location.contact_info_store_id} ;;
    relationship: one_to_one
  }

  join: bi_demo_region {
    view_label: "Pharmacy Central"
    type: inner
    sql_on: ${bi_demo_store_state_location.state_abbreviation} = ${bi_demo_region.store_state} ;;
    relationship: one_to_one
  }

  join: store_file_date {
    view_label: "Pharmacy File Update"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_file_date.chain_id} AND  ${bi_demo_store.nhin_store_id} = ${store_file_date.nhin_store_id} ;;
    relationship: one_to_many
  }

 #[ERXDWPS-5319] added as a part of
  join: store_file_date_history {
    view_label: "Pharmacy File Update History"
    type: left_outer
    sql_on: ${store_file_date.chain_id} = ${store_file_date_history.chain_id} AND  ${store_file_date.nhin_store_id} = ${store_file_date_history.nhin_store_id} AND ${store_file_date.file_date_id} = ${store_file_date_history.file_date_id};;
    relationship: one_to_many
  }

}

explore: prescriber {
  view_name: prescriber
  view_label: "Prescriber"
  sql_always_where: ${prescriber.deleted} = 'N' AND ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.

  fields: [
    prescriber.count,
    prescriber.id,
    prescriber.npi_number_deidentified,
    prescriber.dea_number_deidentified,
    prescriber.name_deidentified,
    bi_demo_chain.chain_name,
    bi_demo_store.bi_demo_nhin_store_id,
    bi_demo_store.store_number,
    bi_demo_store.store_name,
    bi_demo_store.store_client_type,
    bi_demo_store.store_client_version,
    bi_demo_store.store_category,
    bi_demo_store.count,
    bi_demo_store.deactivated,
    us_zip_code.zip_code,
    us_zip_code.location,
    us_zip_code.state_abbreviation,
    us_zip_code.city,
    us_state_county_fips.state_county_fips_code
  ]
  description: "Displays information pertaining to the prescribing caregiver, i.e. Doctor, Physician's Assistant, Nurse Practitioner, etc."

  join: bi_demo_chain {
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${prescriber.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    type: left_outer
    view_label: "Pharmacy - Central"
    sql_on: ${prescriber.chain_id} = ${bi_demo_store.chain_id}  AND ${prescriber.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_prescriber_zip_code {
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${prescriber.zip_code} = ${bi_demo_prescriber_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${bi_demo_prescriber_zip_code.zip_code_bi_demo_mapping} = ${us_zip_code.zip_code} ;;
    relationship: one_to_one
  }

  join: us_state_county_fips {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${us_zip_code.state_abbreviation} = ${us_state_county_fips.state} AND ${us_zip_code.county} = ${us_state_county_fips.county_name} ;;
    relationship: one_to_one
  }

}

explore: rx_tx {
  view_name: bi_demo_rx_tx
  label: "Prescription Transaction"
  view_label: "Prescription Transaction"

  always_filter: {
    filters: {
      field: bi_demo_rx_tx.sold_date_filter
      value: ""
    }

    filters: {
      field: bi_demo_rx_tx.filled_date_filter
      value: ""
    }

    filters: {
      field: bi_demo_rx_tx.reportable_sales_date_filter
      value: ""
    }

    filters: {
      field: bi_demo_rx_tx.this_year_last_year_filter
      value: "No"
    }
  }

  sql_always_where: ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.

  fields: [
    ALL_FIELDS*,
    -bi_demo_rx_tx.chain_id,
    -bi_demo_rx_tx.nhin_store_id,
    -bi_demo_rx_tx.store_rx_tx_fill_count,
    -rx_tx_cred.tx_cred_user_initials,
    -bi_demo_rx_tx.rx_number,
    -bi_demo_rx_tx.group_code,
    -bi_demo_rx_tx.other_nhin_store_id,
    -bi_demo_rx_tx.pv_initials,
    -bi_demo_rx_tx.rph_counselling_initials,
    -bi_demo_rx_tx.tech_initials,
    -bi_demo_rx_tx.initials,
    -bi_demo_rx_tx.order_initials,
    -bi_demo_rx_tx.pv_initials,
    -bi_demo_rx_tx.rx_tx_print_drug_name,
    -bi_demo_rx_tx.new_rx_number,
    -bi_demo_rx_tx.old_rx_number,
    -bi_demo_rx_tx.cancel_reason,
    -bi_demo_rx_tx.tx_message
  ]
  description: "Displays information pertaining to each dispensing of a prescription"

  join: bi_demo_chain {
    fields: [chain_name]
    view_label: "Pharmacy"
    type: inner
    sql_on: ${bi_demo_rx_tx.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    fields: [
      bi_demo_nhin_store_id,
      store_number,
      store_name,
      store_client_type,
      store_client_version,
      store_category,
      count,
      deactivated
    ]
    view_label: "Pharmacy"
    type: inner
    sql_on: ${bi_demo_rx_tx.chain_id} = ${bi_demo_store.chain_id} AND ${bi_demo_rx_tx.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store_state_location {
    fields: [
      zip_code,
      store_location,
      state_abbreviation,
      store_zip_code_primary_city,
      store_zip_code_estimated_population,
      store_zip_code_area_land,
      store_zip_code_population_count_100,
      store_zip_code_white_population,
      store_zip_code_black_or_african_american_population,
      store_zip_code_indian_or_alaskan_native_population,
      store_zip_code_asian_population,
      store_zip_code_native_hawaiian_and_other_pacific_islander_population,
      store_zip_code_other_race_population,
      store_zip_code_two_or_more_races_population,
      store_zip_code_male_population,
      store_zip_code_female_population,
      store_zip_code_population_under_10,
      store_zip_code_population_10_to_19,
      store_zip_code_population_20_to_29,
      store_zip_code_population_30_to_39,
      store_zip_code_population_40_to_49,
      store_zip_code_population_50_to_59,
      store_zip_code_population_60_to_69,
      store_zip_code_population_70_to_79,
      store_zip_code_population_80_plus
    ]
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${bi_demo_store.store_id} = ${bi_demo_store_state_location.contact_info_store_id} ;;
    relationship: one_to_one
  }

  join: bi_demo_region {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${bi_demo_store_state_location.state_abbreviation} = ${bi_demo_region.store_state} ;;
    relationship: one_to_one
  }

  join: prescriber {
    fields: [count, prescriber.npi_number_deidentified, prescriber.dea_number_deidentified, prescriber.name_deidentified]
    type: left_outer
    sql_on: ${bi_demo_rx_tx.prescriber_id} = ${prescriber.id} AND ${bi_demo_rx_tx.chain_id} = ${prescriber.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_prescriber_zip_code {
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${prescriber.zip_code} = ${bi_demo_prescriber_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    fields: [us_zip_code.zip_code, us_zip_code.location, us_zip_code.state_abbreviation, us_zip_code.city]
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${bi_demo_prescriber_zip_code.zip_code_bi_demo_mapping} = ${us_zip_code.zip_code} ;;
    relationship: one_to_one
  }

  join: us_state_county_fips {
    view_label: "Prescriber"
    fields: [us_state_county_fips.state_county_fips_code]
    type: left_outer
    sql_on: ${us_zip_code.state_abbreviation} = ${us_state_county_fips.state} AND ${us_zip_code.county} = ${us_state_county_fips.county_name} ;;
    relationship: one_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [patient_age_tier, patient_count,rx_com_id_deidentified]
    type: inner
    sql_on: ${bi_demo_rx_tx.chain_id} = ${patient.chain_id} AND ${bi_demo_rx_tx.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    fields: []
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many
  }

  join: bi_demo_patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${bi_demo_patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: patient_us_state_county_fips {
    from: us_state_county_fips
    view_label: "Patient - Central"
    fields: [state_county_fips_code]
    type: left_outer
    sql_on: ${bi_demo_patient_zip_code.state_abbreviation} = ${patient_us_state_county_fips.state} AND ${bi_demo_patient_zip_code.county} = ${patient_us_state_county_fips.county_name} ;;
    relationship: one_to_one
  }

  join: bi_demo_rx_tx_drug_cost_hist {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${bi_demo_rx_tx.chain_id} = ${bi_demo_rx_tx_drug_cost_hist.chain_id} AND ${bi_demo_rx_tx.nhin_store_id} = ${bi_demo_rx_tx_drug_cost_hist.nhin_store_id} AND ${bi_demo_rx_tx.eps_rx_tx_id} = ${bi_demo_rx_tx_drug_cost_hist.rx_tx_id} ;;
    relationship: one_to_one
  }

  join: rx_tx_cred {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${bi_demo_rx_tx.chain_id} = ${rx_tx_cred.chain_id} AND ${bi_demo_rx_tx.rx_tx_id}= ${rx_tx_cred.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_diagnosis_code {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${bi_demo_rx_tx.chain_id} = ${rx_tx_diagnosis_code.chain_id} AND ${bi_demo_rx_tx.rx_tx_id} = ${rx_tx_diagnosis_code.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_lot_number {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${bi_demo_rx_tx.chain_id} = ${rx_tx_lot_number.chain_id} AND ${bi_demo_rx_tx.rx_tx_id} = ${rx_tx_lot_number.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: tx_tp {
    view_label: "Prescription Transaction"
    fields: [sum_tx_tp_paid_amount, count]
    type: left_outer
    sql_on: ${bi_demo_rx_tx.chain_id} = ${tx_tp.chain_id} AND ${bi_demo_rx_tx.rx_tx_id}= ${tx_tp.rx_tx_id} AND ${tx_tp.tp_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${bi_demo_rx_tx.store_dispensed_drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: drug {
    view_label: "NHIN Drug"
    fields: [
      drug_ndc,
      drug_ndc_9,
      drug_bin_storage_type,
      drug_category,
      drug_class,
      drug_ddid,
      drug_dosage_form,
      drug_full_generic_name,
      drug_full_name,
      drug_generic_name,
      drug_individual_container_pack,
      drug_integer_pack,
      drug_manufacturer,
      drug_brand_generic,
      drug_name,
      drug_schedule,
      drug_schedule_2,
      drug_schedule_category,
      drug_strength,
      count
    ]
    type: left_outer
    sql_on: ${bi_demo_rx_tx.store_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "NHIN Drug"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-2058] Removed medical_condition
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  #[ERXLPS-2058] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "NHIN GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 AND ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.source_system_id} = 6
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.source_system_id} = 6
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.source_system_id} = 6
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.source_system_id} = 6
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.
}

explore: inventory {
  label: "Inventory"
  view_label: "Pharmacy Drug"
  view_name: store_drug
  sql_always_where: ${store_drug.source_system_id} = 4 AND ${store_drug.deleted_reference} = 'N' AND ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXLPS-2064] #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.

  fields: [
    ALL_FIELDS*,
    -eps_rx_tx.on_time,
    -eps_rx_tx.is_on_time,
    -store_purchase_order.purchase_order_acknowledgement_received_employee_number,
    -store_purchase_order.purchase_order_applied_to_inventory_employee_number,
    -store_purchase_order.purchase_order_transmit_employee_number,
    -store_purchase_order.purchase_order_control_number,
    -store_purchase_order.purchase_order_dea_tracking_number,
    -store_drug_local_setting.sum_drug_local_setting_on_hand,
    -eps_rx_tx.rx_tx_fill_quantity,
    -eps_rx_tx.rx_tx_price,
    -eps_rx_tx.rx_tx_uc_price,
    -store_drug.prescribed_drug_name,
    -eps_rx_tx.bi_demo_time_in_will_call,
    -eps_rx_tx.bi_demo_sum_time_in_will_call,
    -eps_rx_tx.bi_demo_avg_time_in_will_call,
    -eps_rx_tx.bi_demo_median_time_in_will_call,
    -eps_rx_tx.bi_demo_max_time_in_will_call,
    -eps_rx_tx.bi_demo_min_time_in_will_call,
    -eps_rx_tx.time_in_will_call,
    -eps_rx_tx.sum_time_in_will_call,
    -eps_rx_tx.avg_time_in_will_call,
    -eps_rx_tx.median_time_in_will_call,
    -eps_rx_tx.max_time_in_will_call,
    -eps_rx_tx.min_time_in_will_call,
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -store_drug_cost_type.store_drug_cost_type, -store_drug_cost_type.store_drug_cost_type_description, #[ERXLPS-1927]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_vendor.Store_vendor_name, #[ERXLPS-1878]
    #[ERXLPS-2064] Excluding drug subject area deleted dimension from Inventory and sales explore
    -drug.drug_deleted,-drug_cost.deleted,-drug_cost_type.cost_type_deleted,-store_drug_cost.store_drug_cost_deleted,
    -customer_host_drug.drug_deleted,-customer_host_drug_cost.deleted,-customer_host_drug_cost_type.cost_type_deleted,
    -drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*, #[ERXLPS-2064] excluding metadata dimension from inventory explore.
    -customer_host_drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*, #[ERXLPS-2064] excluding metadata dimension from inventory explore.
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -customer_host_drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -drug_cost.explore_rx_drug_cost_metadata_candidate_list*,#[ERXLPS-2114]
    -gpi.explore_rx_gpi_metadata_candidate_list*, #[ERXLPS-2114]
    -drug.explore_rx_drug_metadata_candidate_list*, #[ERXLPS-2114]
    -customer_host_drug.explore_rx_drug_metadata_candidate_list*, #[ERXLPS-2114]
    -customer_host_gpi.explore_rx_gpi_metadata_candidate_list*, #[ERXLPS-2114]
    -customer_host_drug_cost.explore_rx_drug_cost_metadata_candidate_list*, #[ERXLPS-2114]
    -eps_rx_tx.active_archive_filter, #[ERX-6185]
    -eps_rx_tx.active_archive_filter_input, #[ERX-6185]
    -gpi.explore_dx_gpi_levels_candidate_list*, #[ERXDWPS-1454]
    -customer_host_gpi.explore_dx_gpi_levels_candidate_list*, #[ERXDWPS-1454]
    -store_user_license.store_user_license_number, #[ERXDWPS-5731]
    -eps_rx_tx.exclude_eps_rx_tx_fields*,  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]
  description: "Displays information pertaining to Pharmacy Drug and its associated Inventory, Purchase Order, Drug Orders, Reorders, Return And Adjustment and Drug Movement information"


  join: bi_demo_chain {
    fields: [chain_name]
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${store_drug.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    fields: [
      bi_demo_nhin_store_id,
      store_number,
      store_name,
      store_client_type,
      store_client_version,
      store_category,
      count,
      deactivated
    ]
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${store_drug.chain_id} = ${bi_demo_store.chain_id} AND ${store_drug.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store_state_location {
    fields: [
      zip_code,
      store_location,
      state_abbreviation,
      store_zip_code_primary_city,
      store_zip_code_estimated_population,
      store_zip_code_area_land,
      store_zip_code_population_count_100,
      store_zip_code_white_population,
      store_zip_code_black_or_african_american_population,
      store_zip_code_indian_or_alaskan_native_population,
      store_zip_code_asian_population,
      store_zip_code_native_hawaiian_and_other_pacific_islander_population,
      store_zip_code_other_race_population,
      store_zip_code_two_or_more_races_population,
      store_zip_code_male_population,
      store_zip_code_female_population,
      store_zip_code_population_under_10,
      store_zip_code_population_10_to_19,
      store_zip_code_population_20_to_29,
      store_zip_code_population_30_to_39,
      store_zip_code_population_40_to_49,
      store_zip_code_population_50_to_59,
      store_zip_code_population_60_to_69,
      store_zip_code_population_70_to_79,
      store_zip_code_population_80_plus
    ]
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${bi_demo_store.store_id} = ${bi_demo_store_state_location.contact_info_store_id} ;;
    relationship: one_to_one
  }

  join: bi_demo_region {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${bi_demo_store_state_location.state_abbreviation} = ${bi_demo_region.store_state} ;;
    relationship: one_to_one
  }

  #[ERXLPS-2448] - Join to get Price Region from store_setting table.
  join: store_setting_price_code_region {
    from: store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_setting_price_code_region.chain_id} AND  ${bi_demo_store.nhin_store_id} = ${store_setting_price_code_region.nhin_store_id} AND upper(${store_setting_price_code_region.store_setting_name}) = 'STOREDESCRIPTION.PRICEREGION' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-1925]
  join: store_drug_cost_region {
    from:  store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_drug_cost_region.chain_id} AND ${bi_demo_store.nhin_store_id} = ${store_drug_cost_region.nhin_store_id} AND UPPER(${store_drug_cost_region.store_setting_name}) = 'STOREDESCRIPTION.DRUGREGION' ;;
    relationship: one_to_one
    fields: [ ] #[ERXLPS-6333] Excluding store setting columns exposed from this join.
  }

  #[ERXLPS-1925]
  join: host_vs_pharmacy_comp {
    from: store_drug
    view_label: "NHIN Vs. Pharmacy Drug" #[ERXLPS-2089] Renamed Host to NHIN. DEMO and Enterprise models are comparing NHIN vs Pharmacay.
    type: left_outer #[ERXDWPS-6164] changed join type from inner to left_outer
    fields: [explore_rx_host_vs_store_drug_comparison_candidate_list*]
    sql_on: ${store_drug.chain_id} = ${host_vs_pharmacy_comp.chain_id} AND ${store_drug.nhin_store_id} = ${host_vs_pharmacy_comp.nhin_store_id} AND ${store_drug.drug_id} = ${host_vs_pharmacy_comp.drug_id} AND ${host_vs_pharmacy_comp.deleted_reference} = 'N'  AND ${store_drug.source_system_id} = ${host_vs_pharmacy_comp.source_system_id} ;; #[ERXLPS-2064]
    relationship: one_to_one
  }

  join: store_drug_local_setting {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_local_setting.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_local_setting.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_local_setting.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_drug_local_setting.deleted} = 'N' ;;
    relationship: one_to_one
  }

  #[ERXLPS-946] - join with store_price_code to get Store drug price code information
  #[ERXLPS-2089] - View name renamed to store_drug_price_code. Removed from clause from join.
  join: store_drug_price_code {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_price_code.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_price_code.nhin_store_id} AND ${store_drug.price_code_id} = to_char(${store_drug_price_code.price_code_id}) AND ${store_drug_price_code.price_code_deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1942] - Join added to expose therapy class information from gpi_medical_condition_cross_ref view.
  join: gpi_medical_condition_cross_ref {
    view_label: "Pharmacy Drug"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${store_drug.source_system_id} = 4 AND ${store_drug.gpi_identifier} =  ${gpi_medical_condition_cross_ref.gpi};;
    relationship: many_to_many #many gpis in store_drug match with many gpis in gpi_medical_condition_cross_ref table.
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: store_return_and_adjustment {
    view_label: "Return And Adjustment"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_return_and_adjustment.chain_id} AND ${store_drug.nhin_store_id}= ${store_return_and_adjustment.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_return_and_adjustment.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_return_and_adjustment.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_adjustment_code {
    view_label: "Return And Adjustment Code"
    type: left_outer
    sql_on: ${store_return_and_adjustment.chain_id} = ${store_adjustment_code.chain_id} AND ${store_return_and_adjustment.nhin_store_id}= ${store_adjustment_code.nhin_store_id} AND ${store_return_and_adjustment.adjustment_code_id} = ${store_adjustment_code.adjustment_code_id} AND ${store_return_and_adjustment.deleted} = 'N' ;;
    relationship: many_to_one
  }

  join: store_adjustment_group {
    view_label: "Return And Adjustment Group"
    type: left_outer
    sql_on: ${store_return_and_adjustment.chain_id} = ${store_adjustment_group.chain_id} AND ${store_return_and_adjustment.nhin_store_id}= ${store_adjustment_group.nhin_store_id} AND ${store_return_and_adjustment.adjustment_group_id} = ${store_adjustment_group.adjustment_group_id} AND ${store_return_and_adjustment.deleted} = 'N' AND ${store_adjustment_group.deleted} = 'N' ;;
    relationship: many_to_many
  }

  join: store_user {
    from: bi_demo_store_user
    view_label: "Return And Adjustment User"
    type: left_outer
    sql_on: ${store_return_and_adjustment.chain_id} = ${store_user.chain_id}
        AND ${store_return_and_adjustment.nhin_store_id} = ${store_user.nhin_store_id}
        AND ${store_return_and_adjustment.return_and_adjustment_employee_number} = ${store_user.store_user_employee_number_reference}
        AND ${store_return_and_adjustment.source_system_id} = ${store_user.source_system_id} ;;
    relationship: many_to_one
  }

  join: store_user_group {
    view_label: "Return And Adjustment User"
    type: left_outer
    sql_on: ${store_user.chain_id} = ${store_user_group.chain_id} AND ${store_user.nhin_store_id} = ${store_user_group.nhin_store_id} AND ${store_user.user_id} = ${store_user_group.user_id} AND ${store_user.source_system_id} = 4 AND ${store_user_group.store_user_group_deleted_reference} = 'N' ;;
    relationship: many_to_many
  }

  join: store_group {
    view_label: "Return And Adjustment User"
    type: inner
    sql_on: ${store_user_group.chain_id} = ${store_group.chain_id} AND ${store_user_group.nhin_store_id} = ${store_group.nhin_store_id} AND ${store_user_group.group_id} = ${store_group.group_id} ;;
    relationship: many_to_one
  }

  join: store_user_license {
    view_label: "Return And Adjustment User"
    type: left_outer
    sql_on: ${store_user.chain_id} = ${store_user_license.chain_id} AND ${store_user.nhin_store_id} = ${store_user_license.nhin_store_id} AND ${store_user.user_id} = ${store_user_license.user_id} AND ${store_user.source_system_id} = 4 ;;
    relationship: one_to_many
  }

  join: store_user_license_type {
    view_label: "Return And Adjustment User"
    type: left_outer
    sql_on: ${store_user_license.chain_id} = ${store_user_license_type.chain_id} AND ${store_user_license.nhin_store_id} = ${store_user_license_type.nhin_store_id} AND ${store_user_license.user_license_type_id} = ${store_user_license_type.user_license_type_id} AND ${store_user_license.source_system_id} = ${store_user_license_type.source_system_id} ;;
    relationship: one_to_many
  }

  join: store_drug_reorder {
    view_label: "Pharmacy Drug Reorder"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_reorder.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_reorder.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_reorder.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_drug_reorder.deleted} = 'N' ;;
    relationship: one_to_many
  }

# ERXLPS-1912 Change
  join: store_drug_order {
    view_label: "Pharmacy Drug Order"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_order.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_order.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_order.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_drug_order.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_purchase_order {
    view_label: "Purchase Order"
    type: left_outer
    sql_on: ${store_drug_order.chain_id} = ${store_purchase_order.chain_id} AND ${store_drug_order.nhin_store_id}= ${store_purchase_order.nhin_store_id} AND ${store_drug_order.purchase_order_id} = ${store_purchase_order.purchase_order_id} AND ${store_drug_order.deleted} = 'N' AND ${store_purchase_order.deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1878] - Store_vendor added to inventory
  join: store_vendor {
    view_label: "Purchase Order"
    type: left_outer
    sql_on: ${store_purchase_order.chain_id} = ${store_vendor.chain_id} AND ${store_purchase_order.nhin_store_id} = ${store_vendor.nhin_store_id} AND ${store_purchase_order.vendor_id} = ${store_vendor.vendor_id} ;;
    relationship: many_to_one
  }

# ERXLPS-2216 - Updated relationship from many to one, to one to many between store_drug and eps_rx_tx
  join: eps_rx_tx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted} = 'N' AND ${eps_rx_tx.source_system_id} = 4 ;;
    fields: [eps_rx_tx.sum_acquisition_cost, #[ERXLPS-1283] Added Acquisition Cost.
      eps_rx_tx.rx_file_buy_flag, #[ERXLPS-1922]
      #[ERXLPS-2186] Exposing reuturn to stock dimensions.
      eps_rx_tx.return_to_stock_count,
      eps_rx_tx.return_to_stock_sales,
      return_to_stock_yesno,
      rx_tx_return_to_stock_date,
      rx_tx_return_to_stock_date_time,
      rx_tx_return_to_stock_date_date,
      rx_tx_return_to_stock_date_week,
      rx_tx_return_to_stock_date_month,
      rx_tx_return_to_stock_date_month_num,
      rx_tx_return_to_stock_date_year,
      rx_tx_return_to_stock_date_quarter,
      rx_tx_return_to_stock_date_quarter_of_year,
      rx_tx_return_to_stock_date_hour_of_day,
      rx_tx_return_to_stock_date_time_of_day,
      rx_tx_return_to_stock_date_hour2,
      rx_tx_return_to_stock_date_minute15,
      rx_tx_return_to_stock_date_day_of_week,
      rx_tx_return_to_stock_date_week_of_year,
      rx_tx_return_to_stock_date_day_of_week_index,
      rx_tx_return_to_stock_date_day_of_month,
      -eps_rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
      -eps_rx_tx.explore_rx_4_8_000_sf_deployment_candidate_list*,
      -eps_rx_tx.rx_tx_refill_source #[ERXLPS-896] Removed from 4.6 set to expose in WF Explore. Added here to exclude from Inventory Explore.
    ]
    relationship: one_to_many
  }

  #[ERXLPS-1922] - Added eps_rx join to inventory explore and exposing only File Buy Date
  join: eps_rx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
    fields: [rx_file_buy_date,
      rx_file_buy_date_time,
      rx_file_buy_date_date,
      rx_file_buy_date_week,
      rx_file_buy_date_month,
      rx_file_buy_date_month_num,
      rx_file_buy_date_year,
      rx_file_buy_date_quarter,
      rx_file_buy_date_quarter_of_year,
      rx_file_buy_date_hour_of_day,
      rx_file_buy_date_time_of_day,
      rx_file_buy_date_hour2,
      rx_file_buy_date_minute15,
      rx_file_buy_date_day_of_week,
      rx_file_buy_date_week_of_year,
      rx_file_buy_date_day_of_week_index,
      rx_file_buy_date_day_of_month]
    relationship: many_to_one
  }

  join: eps_line_item {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${eps_rx_tx.chain_id} = ${eps_line_item.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_line_item.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${eps_line_item.line_item_id} ;;
    relationship: one_to_one
  }

  join: drug {
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${store_drug.ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 AND ${drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: gpi {
    view_label: "NHIN GPI"
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: gpi_disease_cross_ref {
    view_label: "NHIN GPI"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  #[ERXLPS-1925] - Expose drug_cost view in inventory.
  join: drug_cost {
    view_label: "NHIN Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug_cost.source_system_id} = 6 AND ${drug_cost.chain_id} = 3000 AND ${drug_cost.deleted_reference} 'N' AND ${drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost.region}) ;;
    relationship: one_to_many
  }

  join: drug_cost_pivot {
    view_label: "NHIN Drug Cost"
    type: left_outer
    sql_on: ${drug.drug_ndc} = ${drug_cost_pivot.ndc} AND ${drug_cost_pivot.source_system_id} = 6 AND ${drug_cost_pivot.chain_id} = 3000 ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view. Corrected sql_on condition.
  }

  #ERXDWPS-7019 - Albertsons - Expose Medispan Drug Cost in Looker
  join: medispan_drug_cost_pivot {
    view_label: "Medispan Drug Cost"
    type: left_outer
    sql_on: ${store_drug.ndc} = ${medispan_drug_cost_pivot.ndc};;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  #[ERXLPS-2064] - Added drug_csot_type to Inventory explore.
  join: drug_cost_type {
    view_label: "NHIN Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost_type.source_system_id} = 6 AND ${drug_cost_type.chain_id} = 3000 AND ${drug_cost_type.cost_type_deleted_reference} = 'N' AND ${drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: customer_host_drug {
    from: drug
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${customer_host_drug.chain_id} AND ${store_drug.ndc} = ${customer_host_drug.drug_ndc} AND ${customer_host_drug.drug_source_system_id} = 0 AND ${customer_host_drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: customer_host_gpi {
    from: gpi
    view_label: "Host GPI"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${customer_host_gpi.chain_id} AND ${store_drug.gpi_identifier} = ${customer_host_gpi.gpi_identifier} AND ${customer_host_gpi.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: customer_host_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level1.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,2),'000000000000')  = ${customer_host_gpi_level1.gpi_identifier}
            AND ${customer_host_gpi_level1.gpi_level_custom} = 1
            AND ${customer_host_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level2.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,4),'0000000000')  = ${customer_host_gpi_level2.gpi_identifier}
            AND ${customer_host_gpi_level2.gpi_level_custom} = 2
            AND ${customer_host_gpi_level2.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level3.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,6),'00000000')  = ${customer_host_gpi_level3.gpi_identifier}
            AND ${customer_host_gpi_level3.gpi_level_custom} = 3
            AND ${customer_host_gpi_level3.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level4.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,10),'0000')  = ${customer_host_gpi_level4.gpi_identifier}
            AND ${customer_host_gpi_level4.gpi_level_custom} = 4
            AND ${customer_host_gpi_level4.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level5.chain_id}
            AND ${customer_host_drug.drug_gpi} = ${customer_host_gpi_level5.gpi_identifier}
            AND ${customer_host_gpi_level5.gpi_level_custom} = 5
            AND ${customer_host_gpi_level5.source_system_id} = 0 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-1925] - exposed drug_cost in inventory explore.
  join: customer_host_drug_cost {
    from: drug_cost
    view_label: "Host Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_drug_cost.chain_id} AND ${customer_host_drug.drug_ndc} = ${customer_host_drug_cost.ndc} AND ${customer_host_drug.drug_source_system_id} = 0 AND ${customer_host_drug_cost.source_system_id} = 0 AND ${customer_host_drug_cost.deleted_reference} 'N' AND ${customer_host_drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${customer_host_drug_cost.region}) ;;
    relationship: one_to_many
  }

  join: customer_host_drug_cost_pivot {
    from: drug_cost_pivot
    view_label: "Host Drug Cost"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_drug_cost_pivot.chain_id} AND ${customer_host_drug.drug_ndc} = ${customer_host_drug_cost_pivot.ndc} AND ${customer_host_drug_cost_pivot.source_system_id} = 0 ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view. Corrected sql_on condition.
  }

  #[ERXLPS-2064] - Added drug_cost_type to Inventory explore.
  join: customer_host_drug_cost_type {
    from: drug_cost_type
    view_label: "Host Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${customer_host_drug_cost.chain_id} = ${customer_host_drug_cost_type.chain_id} AND ${customer_host_drug_cost.cost_type} = ${customer_host_drug_cost_type.cost_type} AND ${customer_host_drug_cost_type.source_system_id} = 0 AND ${customer_host_drug_cost.source_system_id} = 0 AND ${customer_host_drug_cost_type.cost_type_deleted_reference} = 'N' AND ${customer_host_drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join #[ERXLPS-2064]
    relationship: many_to_one
  }

  #[ERXLPS_1212]
  join: store_compound {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound.chain_id} = ${store_drug.chain_id}  AND ${store_compound.nhin_store_id} = ${store_drug.nhin_store_id} AND to_char(${store_compound.compound_id}) = ${store_drug.drug_id} AND ${store_compound.compound_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_compound_ingredient {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient.chain_id} = ${store_compound.chain_id}  AND ${store_compound_ingredient.nhin_store_id} = ${store_compound.nhin_store_id} AND ${store_compound_ingredient.compound_id} = ${store_compound.compound_id} AND ${store_compound_ingredient.compound_ingredient_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_modifier {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_modifier.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_modifier.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_modifier.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_modifier.compound_ingredient_modifier_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_tx.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_tx.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_tx.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_tx.compound_ingredient_tx_deleted} = 'N' AND ${store_compound_ingredient_tx.chain_id} = ${eps_rx_tx.chain_id} AND ${store_compound_ingredient_tx.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${store_compound_ingredient_tx.rx_tx_id} = ${eps_rx_tx.rx_tx_id} ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx_lot {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_tx_lot.chain_id} = ${store_compound_ingredient_tx.chain_id}  AND ${store_compound_ingredient_tx_lot.nhin_store_id} = ${store_compound_ingredient_tx.nhin_store_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_id} = ${store_compound_ingredient_tx.compound_ingredient_tx_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_lot_deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXLPS-1927] - Added store_drug_cost, store_drug_cost_type and store_drug_pivot view joins to DEMO Model inventory explore.
  #[ERXLPS-1254] - Corrected the relationship from one_to_one to one_to_many.
  join: store_drug_cost {
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_cost.chain_id} AND ${store_drug.nhin_store_id} = ${store_drug_cost.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_cost.drug_id}) AND ${store_drug_cost.store_drug_cost_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: one_to_many
  }

  #[ERXLPS-1254] - Corrected the relationship from one_to_one to many_to_one. Revised the join condition.
  join: store_drug_cost_type {
    view_label: "Pharmacy Drug Cost Type"
    type: left_outer
    sql_on: ${store_drug_cost.chain_id} = ${store_drug_cost_type.chain_id} AND ${store_drug_cost.nhin_store_id} = ${store_drug_cost_type.nhin_store_id} AND ${store_drug_cost.drug_cost_type_id} = ${store_drug_cost_type.drug_cost_type_id} ;;
    relationship: many_to_one
  }

  join: store_drug_cost_pivot {
    from: bi_demo_store_drug_cost_pivot
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug_cost_pivot.chain_id} = ${store_drug.chain_id} AND ${store_drug_cost_pivot.nhin_store_id}= ${store_drug.nhin_store_id} AND to_char(${store_drug_cost_pivot.drug_id}) = ${store_drug.drug_id} ;;
    relationship: one_to_one
  }
}

#[ERXDWPS-2701] - Explore driver changed from eps_rx_tx to eps_order_entry. source_system_id = 4 check removed from sql_always_where clause and added at eps_rx_tx view join.
explore: eps_workflow_order_entry_rx_tx {
  label: "Workflow/Task History & Order Entry"
  view_label: "Order Entry"
  view_name: eps_order_entry
  sql_always_where: ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.

  fields: [
    ALL_FIELDS*,
    -eps_order_entry.order_entry_ivr_user_name,
    -eps_order_entry.order_entry_ship_to_first_name,
    -eps_order_entry.order_entry_ship_to_last_name,
    -eps_order_entry.order_entry_shipping_error,
    -eps_order_entry.order_entry_scope,
    -eps_line_item.line_item_basket,
    -eps_line_item.line_item_bin_code,
    -eps_line_item.line_item_rma_number,
    -eps_line_item.line_item_ltc_batch_identifier,
    -eps_line_item.line_item_slot_number,
    -eps_task_history.task_history_user_employee_number,
    -eps_task_history.task_history_user_login,
    -eps_task_history.task_history_station_label,
    -eps_task_history.count_user_employee_number,
    -eps_task_history.on_site_alt_site,
    -eps_shipment.shipment_created_by,
    -eps_rx_tx.prescription_fill_duration,
    -bi_demo_eps_task_history_rx_start_time.bi_demo_prescription_start,
    -eps_rx_tx.start,
    -eps_rx_tx.start_time,
    -eps_rx_tx.start_date,
    -eps_rx_tx.start_week,
    -eps_rx_tx.start_month,
    -eps_rx_tx.start_month_num,
    -eps_rx_tx.start_year,
    -eps_rx_tx.start_quarter,
    -eps_rx_tx.start_quarter_of_year,
    -eps_rx_tx.start_hour_of_day,
    -eps_rx_tx.start_time_of_day,
    -eps_rx_tx.start_hour2,
    -eps_rx_tx.start_minute15,
    -eps_rx_tx.start_day_of_week,
    -eps_rx_tx.start_week_of_year,
    -eps_rx_tx.start_day_of_week_index,
    -eps_rx_tx.start_day_of_month,
    -eps_rx_tx.sum_fill_duration,
    -eps_rx_tx.avg_fill_duration,
    -eps_rx_tx.median_fill_duration,
    -eps_rx_tx.max_fill_duration,
    -eps_rx_tx.min_fill_duration,
    -eps_rx_tx.is_on_time_fifteen,
    -eps_rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -eps_rx_tx.explore_rx_4_8_000_sf_deployment_candidate_list*,
    -eps_rx_tx.rx_tx_fill_quantity,
    -eps_rx_tx.rx_tx_price,
    -eps_rx_tx.rx_tx_uc_price,
    -eps_rx_tx.time_in_will_call,
    -eps_rx_tx.sum_time_in_will_call,
    -eps_rx_tx.avg_time_in_will_call,
    -eps_rx_tx.median_time_in_will_call,
    -eps_rx_tx.max_time_in_will_call,
    -eps_rx_tx.min_time_in_will_call,
    -eps_rx_tx.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -eps_rx_tx.sum_acquisition_cost, #[ERXLPS-1283] Expose only in Inventory explore.
    -store_reject_reason.reject_reason_text, #[ERXLPS-1310] Free text column and hiding in DEMO Model.
    -eps_rx_tx.pharmacy_comparable_flag, #[ERXLPS-1452]
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_drug.store_drug_cost_region, #[ERXLPS-1925]
    -store_user_group.explore_dx_store_user_group_candidate_list*, #[ERXLPS-2078]
    -store_user_license.store_user_license_number, #[ERXLPS-2078]
    -eps_task_history.avg_task_time, #[ERXDWPS-5833]
    -eps_task_history.task_history_task_start_time, #[ERXDWPS-5833]
    -store_user_license_type.count, #[ERXDWPS-6425]
    -eps_task_history.max_task_history_source_timestamp,
    -eps_rx_tx.exclude_eps_rx_tx_fields*,  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
    -patient_allergy.patient_allergy_nhin_store_id, #[ERXDWPS-8536] PHI.
    #[ERXDWPS-6802]
    -eps_order_entry.date_to_use_filter,
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales,
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*,
    -eps_order_entry.exploredx_eps_order_entry_analysis_cal_timeframes*,
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]
  description: "Displays information of every action performed for each workflow record, pertaining to each dispensing of a prescription along with Order Entry and its associated line item information. This explore is primarily used for Operational Reporting Purposes"

  always_filter: {
    #[ERX-3514] added to calculate gap time measures
    filters: {
      field: eps_rx_tx.rx_tx_fill_location
      value: ""
    }

    #[ERX-6185] uncomment the following to enable the filter
    #filters: {
    #  field: eps_rx_tx.active_archive_filter
    #  value: "Active Tables (Past 48 Complete Months Data)"
    #}

  }

  join: bi_demo_chain {
    fields: [chain_name]
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${eps_order_entry.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    fields: [
      bi_demo_nhin_store_id,
      store_number,
      store_name,
      store_client_type,
      store_client_version,
      store_category,
      count,
      deactivated
    ]
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${eps_order_entry.chain_id} = ${bi_demo_store.chain_id} AND ${eps_order_entry.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store_state_location {
    fields: [zip_code, store_location, state_abbreviation, store_zip_code_primary_city]
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${bi_demo_store.store_id} = ${bi_demo_store_state_location.contact_info_store_id} ;;
    relationship: one_to_one
  }

  join: bi_demo_region {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${bi_demo_store_state_location.state_abbreviation} = ${bi_demo_region.store_state} ;;
    relationship: one_to_one
  }

  #[ERXDWPS-2701] - Updated WF Explore Driver to Order entry. Modified join conditions to eps_line_item and eps_rx_tx view joins.
  #[ERXDWPS-2701] - Due to SF optimizer issues SF#38334, chain_id access filter confition added for eps_line_item.chain_id column. This will make sure only chain releated partitions are scanned when SQL runs.
  join: eps_line_item {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${eps_order_entry.chain_id} = ${eps_line_item.chain_id} AND ${eps_order_entry.nhin_store_id} = ${eps_line_item.nhin_store_id} AND ${eps_order_entry.order_entry_id} = ${eps_line_item.order_entry_id} AND ${eps_line_item.chain_id} IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %});;
    relationship: one_to_many
  }

  #[ERXDWPS-2701] - Due to SF optimizer issues SF#38334, chain_id access filter confition added for eps_rx_tx.chain_id column. This will make sure only chain releated partitions are scanned when SQL runs.
  join: eps_rx_tx {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${eps_line_item.chain_id} = ${eps_rx_tx.chain_id} AND ${eps_line_item.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${eps_line_item.line_item_id} = ${eps_rx_tx.rx_tx_id} AND ${eps_rx_tx.source_system_id} = 4 AND ${eps_rx_tx.chain_id} IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %}) ;;
    relationship: one_to_one
  }

  #[ERXLPS-1286] - Inclusion of Prescription Number
  join: eps_rx {
    fields: [explore_bi_demo_Workflow_taskhistory_candidate_list*] #[ERXLPS-1922]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6216] - joined pickup_type to workflow explore.
  join: store_pickup_type {
    view_label: "Order Entry"
    type: left_outer
    sql_on: ${eps_order_entry.chain_id} = ${store_pickup_type.chain_id} AND ${eps_order_entry.nhin_store_id} = ${store_pickup_type.nhin_store_id} AND ${eps_order_entry.order_entry_pickup_type_id_reference} = ${store_pickup_type.pickup_type_code} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-2701] - Changed join of eps_task_history_gap_time_per_transaction to use eps_line_item and added conditional filter against chain id.
  join: eps_task_history {
    view_label: "Task History"
    type: inner
    sql_on: ${eps_line_item.chain_id} = ${eps_task_history.chain_id} AND ${eps_line_item.nhin_store_id} = ${eps_task_history.nhin_store_id} AND ${eps_line_item.line_item_id} = ${eps_task_history.line_item_id} AND ${eps_task_history.chain_id} IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %}) ;;
    relationship: one_to_many
  }

  join: bi_demo_eps_task_history_task_time {
    view_label: "Task History"
    type: inner
    sql_on: ${eps_task_history.chain_id} = ${bi_demo_eps_task_history_task_time.chain_id} AND ${eps_task_history.nhin_store_id} = ${bi_demo_eps_task_history_task_time.nhin_store_id} AND ${eps_task_history.task_history_id} = ${bi_demo_eps_task_history_task_time.task_history_id} ;;
    relationship: one_to_one
  }

  join: bi_demo_eps_task_history_rx_start_time {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${bi_demo_eps_task_history_rx_start_time.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${bi_demo_eps_task_history_rx_start_time.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${bi_demo_eps_task_history_rx_start_time.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${bi_demo_eps_task_history_rx_start_time.rx_tx_refill_number} ;;
    relationship: many_to_one
  }

  #[ERX-3514] added to calculate gap time measures
  #[ERXDWPS-2701] - Changed join of eps_task_history_gap_time_per_transaction to use eps_line_item.
  join: eps_task_history_gap_time_per_transaction {
    from: bi_demo_eps_task_history_gap_time_per_transaction
    view_label: "Task History - Gap Time"
    type: left_outer
    sql_on: ${eps_line_item.chain_id} = ${eps_task_history_gap_time_per_transaction.chain_id} AND ${eps_line_item.nhin_store_id} = ${eps_task_history_gap_time_per_transaction.nhin_store_id} AND ${eps_line_item.line_item_id} = ${eps_task_history_gap_time_per_transaction.rx_tx_id} ;;
    relationship: one_to_one
  }

  #[ERX-3514] added to calculate gap time measures
  join: eps_task_history_gap_time_per_refill {
    from: bi_demo_eps_task_history_gap_time_per_refill
    view_label: "Task History - Gap Time"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_task_history_gap_time_per_refill.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_task_history_gap_time_per_refill.nhin_store_id}  AND ${eps_rx_tx.rx_id} = ${eps_task_history_gap_time_per_refill.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_task_history_gap_time_per_refill.rx_tx_refill_number} ;;
    relationship: many_to_one
  }

  #[ERXLPS-1286] - join with derived to view for script to skin requirement
  join: bi_demo_eps_rx_refill_received_to_will_call {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${bi_demo_eps_rx_refill_received_to_will_call.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${bi_demo_eps_rx_refill_received_to_will_call.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${bi_demo_eps_rx_refill_received_to_will_call.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${bi_demo_eps_rx_refill_received_to_will_call.rx_tx_refill_number} ;;
    relationship: many_to_one
  }

  join: epr_rx_tx {
    from: bi_demo_epr_rx_tx
    fields: []
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${epr_rx_tx.chain_id} AND ${eps_rx.nhin_store_id}= ${epr_rx_tx.nhin_store_id} AND ${eps_rx.rx_number}= ${epr_rx_tx.rx_number} AND ${eps_rx_tx.rx_tx_tx_number}= ${epr_rx_tx.tx_number} ;;
    relationship: one_to_one
  }

  join: prescriber {
    fields: [count, prescriber.npi_number_deidentified, prescriber.dea_number_deidentified, prescriber.name_deidentified]
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${prescriber.chain_id} AND ${epr_rx_tx.prescriber_id} = ${prescriber.id} ;;
    relationship: many_to_one
  }

  join: bi_demo_prescriber_zip_code {
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${prescriber.zip_code} = ${bi_demo_prescriber_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    fields: [zip_code, location, state_abbreviation, city]
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${bi_demo_prescriber_zip_code.zip_code_bi_demo_mapping} = ${us_zip_code.zip_code} ;;
    relationship: one_to_one
  }

  join: eps_workflow_state {
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_task_history.chain_id} = ${eps_workflow_state.chain_id} AND ${eps_task_history.nhin_store_id} = ${eps_workflow_state.nhin_store_id} AND ${eps_task_history.task_history_task_name} = ${eps_workflow_state.workflow_state_name} ;;
    relationship: many_to_one
    fields: [workflow_state_candidate_list*]
  }

  #[ERXDWPS-5990] - Exposing all columns from WF Token. Added liquid variable to dynamically choose workflow_token_deleted = N condition when user do not pull Workflow Token Deleted dimension into report.
  #[ERXDWPS-5990] - This logic is required to avoid impact on existing customer reports. Due to this dynamic join, all the existing reports will still pull current state information.
  #[ERXDWPS-5990] - Updated relation from one_to_one to one_to_many
  #[ERXDWPS-2701] - Changed join of eps_workflow_token to use eps_line_item.
  join: eps_workflow_token {
    view_label: "Workflow"
    type: left_outer
    fields: [explore_dx_workflow_token_bi_demo_candidate_list*]
    sql_on: ${eps_line_item.chain_id} = ${eps_workflow_token.chain_id}
            AND ${eps_line_item.nhin_store_id} = ${eps_workflow_token.nhin_store_id}
            AND ${eps_line_item.line_item_id} = ${eps_workflow_token.line_item_id}
            AND {% if eps_workflow_token.workflow_token_deleted._in_query %}
                1 = 1
                {% else %}
                ${eps_workflow_token.workflow_token_deleted_reference} = 'N'
                {% endif %} ;;
    relationship: one_to_many
  }

  join: eps_workflow_current_state {
    from: eps_workflow_state
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_workflow_token.chain_id} = ${eps_workflow_current_state.chain_id} AND ${eps_workflow_token.nhin_store_id} = ${eps_workflow_current_state.nhin_store_id} AND ${eps_workflow_token.workflow_state_id} = ${eps_workflow_current_state.workflow_state_id} ;;
    relationship: many_to_one
    fields: [workflow_current_state_name]
  }

  join: eps_shipment {
    view_label: "Shipment"
    type: left_outer
    sql_on: ${eps_shipment.chain_id} = ${eps_rx_tx.chain_id} AND ${eps_shipment.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${eps_shipment.shipment_id} = ${eps_rx_tx.rx_tx_shipment_id} ;;
    relationship: many_to_one
  }

  #[ERXLPS-1286] - Including Pharmacy Drug to sync with Customer Model & to support Script to Skin requirement in Demo Model
  join: store_drug {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-1310] - Exposed in DEMO Model
  #[ERXDWPS-2701] - Changed join of store_reject_reason to use eps_line_item.
  join:  store_reject_reason {
    view_label: "Prescription Transaction"
    type: left_outer
    fields: [explore_rx_reject_reason_4_13_candidate_list*] #[ERXLPS-1310]
    sql_on: ${eps_line_item.chain_id} = ${store_reject_reason.chain_id} AND ${eps_line_item.nhin_store_id}= ${store_reject_reason.nhin_store_id} AND ${eps_line_item.line_item_id} = ${store_reject_reason.rx_tx_id}  ;;
    relationship: one_to_many
  }

  join:  store_reject_reason_cause {
    view_label: "Prescription Transaction"
    type: left_outer
    fields: [explore_rx_reject_reason_cause_4_13_candidate_list*] #[ERXLPS-1310]
    sql_on: ${store_reject_reason.chain_id} = ${store_reject_reason_cause.chain_id} AND ${store_reject_reason.nhin_store_id}= ${store_reject_reason_cause.nhin_store_id} AND ${store_reject_reason.reject_reason_id} = ${store_reject_reason_cause.reject_reason_id}  ;;
    relationship: one_to_many
  }

#[ERXLPS-1430] - Add Patient dimensions to Workflow Explore.

  join: eps_patient {
    view_label: "Patient - Store"
    fields: []
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${eps_patient.chain_id} AND ${eps_rx.nhin_store_id} = ${eps_patient.nhin_store_id} AND ${eps_rx.rx_patient_id} = ${eps_patient.patient_id} AND ${eps_patient.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [patient_age_tier, patient_count, rx_com_id_deidentified, explore_dx_patient_age_tier_candidate_list*] #[ERXLPS-6239]
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient.chain_id} AND ${eps_patient.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    fields: []
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many #[ERXLPS-910] Corrected the relationship
  }

  join: bi_demo_patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${bi_demo_patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8536] - Patient Allergy info added to DEMO Model WF Explore. No PHI elements in Patient Allergy table.
  join: patient_allergy {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_allergy.chain_id} AND ${patient.rx_com_id} = ${patient_allergy.rx_com_id} AND ${patient_allergy.deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXLPS-2266][ERXLPS-2078] - Exposed all columns other than IDs and metadata columns from USER and GROUPS
  #[ERXLPS-1845] - Added deleted check in join.
  join: store_user {
    from: bi_demo_store_user
    view_label: "User"
    type: left_outer
    sql_on: ${eps_task_history.chain_id} = ${store_user.chain_id} AND ${eps_task_history.nhin_store_id} = ${store_user.nhin_store_id} AND ${eps_task_history.task_history_user_login} = ${store_user.store_user_login_reference} AND ${store_user.source_system_id} = 4 AND ${store_user.store_user_deleted_reference} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1845] - Added deleted check in join.
  join: store_user_group {
    view_label: "User"
    type: left_outer
    sql_on: ${store_user.chain_id} = ${store_user_group.chain_id} AND ${store_user.nhin_store_id} = ${store_user_group.nhin_store_id} AND ${store_user.user_id} = ${store_user_group.user_id} AND ${store_user.source_system_id} = 4 AND ${store_user_group.store_user_group_deleted_reference} = 'N' ;;
    relationship: many_to_many
  }

  join: store_group {
    view_label: "User"
    type: inner
    sql_on: ${store_user_group.chain_id} = ${store_group.chain_id} AND ${store_user_group.nhin_store_id} = ${store_group.nhin_store_id} AND ${store_user_group.group_id} = ${store_group.group_id} ;;
    relationship: many_to_one
  }

  join: store_user_license {
    view_label: "User"
    type: left_outer
    sql_on: ${store_user.chain_id} = ${store_user_license.chain_id} AND ${store_user.nhin_store_id} = ${store_user_license.nhin_store_id} AND ${store_user.user_id} = ${store_user_license.user_id} AND ${store_user.source_system_id} = 4 ;;
    relationship: one_to_many
  }

  #ERXDWPS-5156
  join: store_user_license_type {
    view_label: "User"
    type: left_outer
    sql_on: ${store_user_license.chain_id} = ${store_user_license_type.chain_id} AND ${store_user_license.nhin_store_id} = ${store_user_license_type.nhin_store_id} AND ${store_user_license.user_license_type_id} = ${store_user_license_type.user_license_type_id} AND ${store_user_license.source_system_id} = ${store_user_license_type.source_system_id} ;;
    relationship: one_to_many
  }
}

explore: drug {
  extends: [drug_base]
  fields: [ALL_FIELDS*,
          -drug_short_third_party.explore_rx_drug_short_tp_4_12_candidate_list*,
          -drug.ar_drug_brand_generic, #[ERXLPS-6148]
          -gpi.explore_dx_gpi_levels_candidate_list* #[ERXDWPS-1454]
  ]
}

explore: bi_demo_sales {
  view_name: bi_demo_sales
  label: "Sales"
  view_label: "Prescription Transaction"
  sql_always_where: ${bi_demo_sales.source_system_id} = 4 AND ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.  #[ERXLPS-2384]

  always_filter: {
    filters: {
      field: bi_demo_sales.history_filter
      value: "YES"
    }

    filters: {
      field: bi_demo_sales.report_period_filter
      value: "LAST MONTH"
    }

    filters: {
      field: bi_demo_sales.date_to_use_filter
      value: "REPORTABLE SALES"
    }

    filters: {
      field: bi_demo_sales.sales_rxtx_payor_summary_detail_analysis
      value: "SUMMARY"
    }

    filters: {
      field: show_after_sold_measure_values
      value: "NO"
    }
  }
  fields: [ALL_FIELDS*,
    -store_drug.prescribed_drug_name,
    -store_drug.drug_code,
    -store_drug.drug_name,
    -store_drug.drug_full_name,
    -store_drug.drug_user_defined_name,
    -store_drug.drug_other_code,
    -store_drug_prescribed.prescribed_drug_name,
    -store_reject_reason.reject_reason_text, #[ERXLPS-1310] Free text column and hiding in DEMO Model.
    -store_drug_cost_type.store_drug_cost_type, -store_drug_cost_type.store_drug_cost_type_description, #[ERXLPS-1927]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    #[ERXLPS-2064] Excluding drug subject area deleted dimension from Inventory and sales explore
    -drug.drug_deleted,-drug_cost.deleted,-drug_cost_type.cost_type_deleted,-store_drug_cost.store_drug_cost_deleted,
    -rx_tx_drug_cost_hist.explore_rx_drug_cost_hist_4_10_candidate_list*, #[ERXLPS-2295]
    -rx_tx_store_drug_cost_hist.explore_rx_store_drug_cost_hist_4_10_candidate_list*, #[ERXLPS-2295]
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*,#[ERXLPS-2114]
    -drug_cost.explore_rx_drug_cost_metadata_candidate_list*,#[ERXLPS-2114]
    -drug.explore_rx_drug_metadata_candidate_list*

  ]
  description: "The Sales Analysis contains sales information for all cash and third party transactions that were sold, credit returned, or cancelled on the date(s) you specify. Includes all new, refill, and downtime prescriptions that have a reportable sales date. If the transaction was cancelled or credit returned, the report will display records for both the sale information and the credit/cancel information."

  join: bi_demo_chain {
    fields: [chain_name]
    view_label: "Pharmacy -  Central"
    type: inner
    sql_on: ${bi_demo_sales.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    fields: [
      bi_demo_nhin_store_id,
      store_number,
      store_name,
      store_client_type,
      store_client_version,
      store_category,
      count,
      deactivated
    ]
    view_label: "Pharmacy -  Central"
    type: inner
    sql_on: ${bi_demo_sales.chain_id} = ${bi_demo_store.chain_id} AND ${bi_demo_sales.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store_state_location {
    fields: [
      zip_code,
      store_location,
      state_abbreviation,
      store_zip_code_primary_city,
      store_zip_code_estimated_population,
      store_zip_code_area_land,
      store_zip_code_population_count_100,
      store_zip_code_white_population,
      store_zip_code_black_or_african_american_population,
      store_zip_code_indian_or_alaskan_native_population,
      store_zip_code_asian_population,
      store_zip_code_native_hawaiian_and_other_pacific_islander_population,
      store_zip_code_other_race_population,
      store_zip_code_two_or_more_races_population,
      store_zip_code_male_population,
      store_zip_code_female_population,
      store_zip_code_population_under_10,
      store_zip_code_population_10_to_19,
      store_zip_code_population_20_to_29,
      store_zip_code_population_30_to_39,
      store_zip_code_population_40_to_49,
      store_zip_code_population_50_to_59,
      store_zip_code_population_60_to_69,
      store_zip_code_population_70_to_79,
      store_zip_code_population_80_plus
    ]
    view_label: "Pharmacy -  Central"
    type: left_outer
    sql_on: ${bi_demo_store.store_id} = ${bi_demo_store_state_location.contact_info_store_id} ;;
    relationship: one_to_one
  }

  join: bi_demo_region {
    view_label: "Pharmacy -  Central"
    type: inner
    sql_on: ${bi_demo_store_state_location.state_abbreviation} = ${bi_demo_region.store_state} ;;
    relationship: one_to_one
  }

  #[ERXLPS-2448] - Join to get Price Region from store_setting table.
  join: store_setting_price_code_region {
    from: store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_setting_price_code_region.chain_id} AND  ${bi_demo_store.nhin_store_id} = ${store_setting_price_code_region.nhin_store_id} AND upper(${store_setting_price_code_region.store_setting_name}) = 'STOREDESCRIPTION.PRICEREGION' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-1925]
  join: store_drug_cost_region {
    from:  store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_drug_cost_region.chain_id} AND ${bi_demo_store.nhin_store_id} = ${store_drug_cost_region.nhin_store_id} AND UPPER(${store_drug_cost_region.store_setting_name}) = 'STOREDESCRIPTION.DRUGREGION' ;;
    relationship: one_to_one
    fields: [ ] #[ERXLPS-2596]
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-1925]
  join: host_vs_pharmacy_comp {
    from: store_drug
    view_label: "NHIN Vs. Pharmacy Drug" #[ERXLPS-2089] Renamed Host to NHIN. DEMO and Enterprise models are comparing NHIN vs Pharmacy.
    type: left_outer #[ERXDWPS-6164] changed join type from inner to left_outer
    fields: [explore_rx_host_vs_store_drug_comparison_candidate_list*]
    sql_on: ${store_drug.chain_id} = ${host_vs_pharmacy_comp.chain_id} AND ${store_drug.nhin_store_id} = ${host_vs_pharmacy_comp.nhin_store_id} AND ${store_drug.drug_id} = ${host_vs_pharmacy_comp.drug_id} AND ${host_vs_pharmacy_comp.deleted_reference} = 'N' AND ${store_drug.source_system_id} = ${host_vs_pharmacy_comp.source_system_id} ;; #[ERXLPS-2064]
    relationship: one_to_one
  }

  join: store_setting {
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_setting.chain_id} AND  ${bi_demo_store.nhin_store_id} = ${store_setting.nhin_store_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1152] - Include "Scripts Converted" Yes/No Dimension in Sales Explore
  join: store_setting_conversionservice_run_date {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_setting_conversionservice_run_date.chain_id} AND  ${bi_demo_store.nhin_store_id} = ${store_setting_conversionservice_run_date.nhin_store_id} AND upper(${store_setting_conversionservice_run_date.store_setting_name}) = 'CONVERSIONSERVICE.RUN.DATE'  ;;
    relationship: one_to_one
    fields: []
  }

  join: eps_rx_tx {
    from: bi_demo_sales_eps_rx_tx
    fields: [explore_bi_demo_sales_candidate_list*]
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${bi_demo_sales.chain_id} = ${eps_rx_tx.chain_id} AND ${bi_demo_sales.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${bi_demo_sales.rx_tx_id} = ${eps_rx_tx.rx_tx_id} AND ${eps_rx_tx.rx_tx_tx_deleted} = 'N' AND ${eps_rx_tx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: eps_rx_tx_active_completion_fill {
    from: bi_demo_sales_eps_rx_tx
    fields: [] #Removed -ALL_FIELDS*, throwing error in DEMO Model
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx_tx_active_completion_fill.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_rx_tx_active_completion_fill.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx_tx_active_completion_fill.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_rx_tx_active_completion_fill.rx_tx_refill_number} AND ${eps_rx_tx.rx_tx_id} = ${eps_rx_tx_active_completion_fill.rx_tx_partial_rx_tx_id} AND ${eps_rx_tx.rx_tx_partial_fill_status_reference} = 'P' AND ${eps_rx_tx.rx_tx_tx_status_reference} = 'Y' AND ${eps_rx_tx_active_completion_fill.rx_tx_partial_fill_status_reference} = 'C' AND ${eps_rx_tx_active_completion_fill.rx_tx_tx_status_reference} = 'Y' AND ${eps_rx_tx_active_completion_fill.source_system_id} = 4 ;;
    relationship: one_to_one
  }

  join:  store_reject_reason {
    view_label: "Prescription Transaction"
    type: left_outer
    fields: [explore_rx_reject_reason_4_13_candidate_list*] #[ERXLPS-1310]
    sql_on: ${eps_rx_tx.chain_id} = ${store_reject_reason.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${store_reject_reason.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${store_reject_reason.rx_tx_id}  ;;
    relationship: one_to_many
  }

  join:  store_reject_reason_cause {
    view_label: "Prescription Transaction"
    type: left_outer
    fields: [explore_rx_reject_reason_cause_4_13_candidate_list*] #[ERXLPS-1310]
    sql_on: ${store_reject_reason.chain_id} = ${store_reject_reason_cause.chain_id} AND ${store_reject_reason.nhin_store_id}= ${store_reject_reason_cause.nhin_store_id} AND ${store_reject_reason.reject_reason_id} = ${store_reject_reason_cause.reject_reason_id}  ;;
    relationship: one_to_many
  }

  join: eps_rx {
    from: bi_demo_sales_eps_rx
    fields: [explore_bi_demo_sales_candidate_list*]
    view_label: "Prescription Transaction"
    type: left_outer #As part of sales_fiscal integration modified this join to left_outer. This is required to avoid issues with later arriving records. Please reach out to architects before you make any changes.
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: sales_tx_tp {
    from: bi_demo_sales_tx_tp
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${bi_demo_sales.chain_id} = ${sales_tx_tp.chain_id} AND ${bi_demo_sales.nhin_store_id} = ${sales_tx_tp.nhin_store_id} AND ${bi_demo_sales.rx_tx_id} = ${sales_tx_tp.rx_tx_id} ;;
    relationship: many_to_one
  }

  #[ERXLPS-1020] - Integration of TP Claim into Sales
  #[ERXLPS-1385] - Revised the join condition. Earlier the join was b/w sales and eps_tx_tp. Updated the join to eps_tx_tp and sales_tx_tp.
  join: eps_tx_tp {
    from: bi_demo_sales_eps_tx_tp
    view_label: "Claim"
    type: left_outer
    fields: [sales_tx_tp_dimension_candidate_list*,explore_sales_specific_candidate_list*]
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp.nhin_store_id} AND ${sales_tx_tp.rx_tx_id} = ${eps_tx_tp.rx_tx_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp.tx_tp_id} AND ${eps_tx_tp.source_system_id} = 4 ;; #[ERXLPS-2384]
    relationship: one_to_one #[ERXLPS-1282]
  }

  join: eps_tp_link {
    fields: [eps_tp_link.bi_demo_sales_transmit_queue_tp_link_dimension_candidate_list*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tp_link.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tp_link.nhin_store_id} AND ${sales_tx_tp.tx_tp_patient_tp_link_id} = ${eps_tp_link.tp_link_id} AND ${sales_tx_tp.source_system_id} = ${eps_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: many_to_one
  }

  join: eps_card {
    fields: [eps_card.bi_demo_sales_transmit_queue_card_dimension_candidate_list*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${eps_tp_link.chain_id} = ${eps_card.chain_id} AND ${eps_tp_link.nhin_store_id} = ${eps_card.nhin_store_id} AND ${eps_tp_link.card_id} = ${eps_card.card_id} AND ${eps_tp_link.source_system_id} = ${eps_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: eps_plan {
    #[ERXLPS-1618] - explore_sales_candidate_list set is used in other explore where store_plan_phone_number is not exposed. dimension added directly at join level until other explores are depricated.
    fields: [bi_demo_explore_sales_candidate_list*, store_plan_phone_number]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${eps_card.chain_id} = ${eps_plan.chain_id} AND ${eps_card.nhin_store_id} = ${eps_plan.nhin_store_id} AND ${eps_card.plan_id} = ${eps_plan.plan_id} AND ${eps_card.source_system_id} = ${eps_plan.source_system_id} ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: eps_plan_transmit {
    fields: [explore_sales_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${eps_plan.chain_id} = ${eps_plan_transmit.chain_id} AND ${eps_plan.nhin_store_id} = ${eps_plan_transmit.nhin_store_id} AND ${eps_plan.plan_id} = ${eps_plan_transmit.plan_id} AND ${eps_plan.source_system_id} = ${eps_plan_transmit.source_system_id} AND ${eps_plan_transmit.store_plan_transmit_deleted} = 'N' ;;  #ERXDWPS-5124
    relationship: many_to_one
  }

  #[ERXLPS-1618]
  join: eps_plan_phone {
    from: eps_phone
    fields: []
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${eps_plan.chain_id} = ${eps_plan_phone.chain_id} AND ${eps_plan.nhin_store_id} = ${eps_plan_phone.nhin_store_id} AND ${eps_plan.store_plan_phone_id} = ${eps_plan_phone.phone_id} AND ${eps_plan.source_system_id} = ${eps_plan_phone.source_system_id} ;;  #ERXDWPS-5124
    relationship: many_to_one
  }

  join: primary_payer_tx_tp {
    from: bi_demo_sales_tx_tp
    fields: []
    view_label: "Claim"
    type: left_outer
    sql_on: ${bi_demo_sales.chain_id} = ${primary_payer_tx_tp.chain_id} AND ${bi_demo_sales.nhin_store_id} = ${primary_payer_tx_tp.nhin_store_id} AND ${bi_demo_sales.rx_tx_id} = ${primary_payer_tx_tp.rx_tx_id} AND ${primary_payer_tx_tp.tx_tp_counter} = 0 ;;
    relationship: many_to_one
  }

  join: primary_tp_link {
    from: eps_tp_link
    fields: [] #Removed -ALL_FIELDS*, throwing error in DEMO Model
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${primary_payer_tx_tp.chain_id} = ${primary_tp_link.chain_id} AND ${primary_payer_tx_tp.nhin_store_id} = ${primary_tp_link.nhin_store_id} AND ${primary_payer_tx_tp.tx_tp_patient_tp_link_id} = ${primary_tp_link.tp_link_id} AND ${primary_payer_tx_tp.source_system_id} = ${primary_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: many_to_one
  }

  join: primary_payer_card {
    from: eps_card
    fields: [] #Removed -ALL_FIELDS*, throwing error in DEMO Model
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${primary_tp_link.chain_id} = ${primary_payer_card.chain_id} AND ${primary_tp_link.nhin_store_id} = ${primary_payer_card.nhin_store_id} AND ${primary_tp_link.card_id} = ${primary_payer_card.card_id} AND ${primary_tp_link.source_system_id} = ${primary_payer_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: primary_payer_plan {
    from: eps_plan
    fields: [bi_demo_explore_sales_primary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${primary_payer_card.chain_id} = ${primary_payer_plan.chain_id} AND ${primary_payer_card.nhin_store_id} = ${primary_payer_plan.nhin_store_id} AND ${primary_payer_card.plan_id} = ${primary_payer_plan.plan_id}  AND ${primary_payer_card.source_system_id} = ${primary_payer_plan.source_system_id};; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: primary_payer_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_sales_primary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${primary_payer_plan.chain_id} = ${primary_payer_plan_transmit.chain_id} AND ${primary_payer_plan.nhin_store_id} = ${primary_payer_plan_transmit.nhin_store_id} AND ${primary_payer_plan.plan_id} = ${primary_payer_plan_transmit.plan_id} AND ${primary_payer_plan.source_system_id} = ${primary_payer_plan_transmit.source_system_id} AND ${primary_payer_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  #[ERXLPS-1618]
  join: primary_payer_plan_phone {
    from: eps_phone
    fields: []
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${primary_payer_plan.chain_id} = ${primary_payer_plan_phone.chain_id} AND ${primary_payer_plan.nhin_store_id} = ${primary_payer_plan_phone.nhin_store_id} AND ${primary_payer_plan.store_plan_phone_id} = ${primary_payer_plan_phone.phone_id} AND ${primary_payer_plan.source_system_id} = ${primary_payer_plan_phone.source_system_id} ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  #[ERXLPS-1618]
  join: secondary_payer_tx_tp {
    from: sales_tx_tp
    fields: []
    view_label: "Claim"
    type: left_outer
    sql_on: ${bi_demo_sales.chain_id} = ${secondary_payer_tx_tp.chain_id} AND ${bi_demo_sales.nhin_store_id} = ${secondary_payer_tx_tp.nhin_store_id} AND ${bi_demo_sales.rx_tx_id} = ${secondary_payer_tx_tp.rx_tx_id} AND ${secondary_payer_tx_tp.tx_tp_counter} = 1 ;;
    relationship: many_to_one
  }

  join: secondary_tp_link {
    from: eps_tp_link
    fields: []
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${secondary_payer_tx_tp.chain_id} = ${secondary_tp_link.chain_id} AND ${secondary_payer_tx_tp.nhin_store_id} = ${secondary_tp_link.nhin_store_id} AND ${secondary_payer_tx_tp.tx_tp_patient_tp_link_id} = ${secondary_tp_link.tp_link_id} AND ${secondary_payer_tx_tp.source_system_id} = ${secondary_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: many_to_one
  }

  join: secondary_payer_card {
    from: eps_card
    fields: []
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${secondary_tp_link.chain_id} = ${secondary_payer_card.chain_id} AND ${secondary_tp_link.nhin_store_id} = ${secondary_payer_card.nhin_store_id} AND ${secondary_tp_link.card_id} = ${secondary_payer_card.card_id} AND ${secondary_tp_link.source_system_id} = ${secondary_payer_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: secondary_payer_plan {
    from: eps_plan
    fields: [bi_demo_explore_sales_secondary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${secondary_payer_card.chain_id} = ${secondary_payer_plan.chain_id} AND ${secondary_payer_card.nhin_store_id} = ${secondary_payer_plan.nhin_store_id} AND ${secondary_payer_card.plan_id} = ${secondary_payer_plan.plan_id} AND ${secondary_payer_card.source_system_id} = ${secondary_payer_plan.source_system_id} ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: secondary_payer_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_sales_secondary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${secondary_payer_plan.chain_id} = ${secondary_payer_plan_transmit.chain_id} AND ${secondary_payer_plan.nhin_store_id} = ${secondary_payer_plan_transmit.nhin_store_id} AND ${secondary_payer_plan.plan_id} = ${secondary_payer_plan_transmit.plan_id} AND ${secondary_payer_plan.source_system_id} = ${secondary_payer_plan_transmit.source_system_id} AND ${secondary_payer_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: secondary_payer_plan_phone {
    from: eps_phone
    fields: []
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${secondary_payer_plan.chain_id} = ${secondary_payer_plan_phone.chain_id} AND ${secondary_payer_plan.nhin_store_id} = ${secondary_payer_plan_phone.nhin_store_id} AND ${secondary_payer_plan.store_plan_phone_id} = ${secondary_payer_plan_phone.phone_id} AND ${secondary_payer_plan.source_system_id} = ${secondary_payer_plan_phone.source_system_id};; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: eps_patient {
    view_label: "Patient - Store"
    fields: [rx_com_id_deidentified,
      store_patient_count #[ERXLPS-4429]
    ] #Removed -ALL_FIELDS*, throwing error in DEMO Model
    type: left_outer
    #[ERXDWPS-1530][ERXDWPS-1532][ERXDWPS-5124] Removed source_system_id = 4 condition to keep it in sync with CUSTOMER Model.
    sql_on: ${eps_rx.chain_id} = ${eps_patient.chain_id} AND ${eps_rx.nhin_store_id} = ${eps_patient.nhin_store_id} AND ${eps_rx.rx_patient_id} = ${eps_patient.patient_id} ;;
    relationship: many_to_one
  }

  #[ERX-3541] Integration of EPS patient address subejct area Start
  join: eps_patient_address_link {
    view_label: "Patient Address - Store"
    fields: []
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${eps_patient_address_link.chain_id} AND ${eps_patient.nhin_store_id} = ${eps_patient_address_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${eps_patient_address_link.patient_id}) ;;
    relationship: many_to_many
  }

  #[ERXLPS-1024][ERXLPS-2420] - Store Patient Address information added to Sales Explore.
  join: store_patient_address {
    view_label: "Patient Address - Store"
    type: left_outer
    fields: [] #Not exposing any fields in DEMO Model due to PHI.
    sql_on: ${eps_patient_address_link.chain_id} = ${store_patient_address.chain_id} AND ${eps_patient_address_link.nhin_store_id} = ${store_patient_address.nhin_store_id} AND ${eps_patient_address_link.address_id} = ${store_patient_address.address_id} AND ${eps_patient_address_link.source_system_id} = ${store_patient_address.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: bi_demo_store_patient_zip_code {
    type: left_outer
    view_label: "Patient Address - Store"
    sql_on: ${store_patient_address.address_postal_code} = ${bi_demo_store_patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: store_patient_us_state_county_fips {
    from: us_state_county_fips
    view_label: "Patient Address - Store"
    fields: [state_county_fips_code]
    type: left_outer
    sql_on: ${bi_demo_store_patient_zip_code.state_abbreviation} = ${patient_us_state_county_fips.state} AND ${bi_demo_store_patient_zip_code.county} = ${patient_us_state_county_fips.county_name} ;;
    relationship: one_to_one
  }

  #[ERX-3488] joined payment SA tables
  join: eps_rx_tx_payment {
    view_label: "Payment"
    type:  left_outer
    fields: [explore_rx_rx_tx_payment_4_13_candidate_list*] #[ERXLPS-1211] Exposed to Customer and in Demo model.
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx_tx_payment.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_rx_tx_payment.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${eps_rx_tx_payment.rx_tx_id} ;;
    relationship: one_to_many
  }

  join: eps_payment_group_line_item_link {
    view_label: "Payment"
    type:  left_outer
    fields: [] #[ERXLPS-1211]
    sql_on: ${eps_rx_tx.chain_id} = ${eps_payment_group_line_item_link.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_payment_group_line_item_link.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${eps_payment_group_line_item_link.line_item_id} ;;
    relationship: one_to_many
  }

  join: eps_payment_group {
    view_label: "Payment"
    type:  left_outer
    fields: [explore_rx_payment_group_4_13_candidate_list*] #[ERXLPS-1211] Exposed to Customer and in Demo model.
    sql_on: ${eps_payment_group_line_item_link.chain_id} = ${eps_payment_group.chain_id} AND ${eps_payment_group_line_item_link.nhin_store_id} = ${eps_payment_group.nhin_store_id} AND ${eps_payment_group_line_item_link.payment_group_id} = ${eps_payment_group.payment_group_id} ;;
    relationship: many_to_one
  }

  join: eps_payment {
    view_label: "Payment"
    type:  left_outer
    fields: [explore_rx_payment_4_13_candidate_list*,
      -payment_write_off_manager_employee_number,
      -payment_check_number] #[ERXLPS-1211] Exposed to Customer and in Demo model.
    sql_on: ${eps_payment_group.chain_id} = ${eps_payment.chain_id} AND ${eps_payment_group.nhin_store_id} = ${eps_payment.nhin_store_id} AND ${eps_payment_group.payment_group_id} = ${eps_payment.payment_group_id} ;;
    relationship: one_to_many
  }

  join: eps_payment_adjustment {
    view_label: "Payment"
    type:  left_outer
    fields: [explore_rx_payment_adjustment_4_13_candidate_list*] #[ERXLPS-1211] Exposed to Customer and in Demo model.
    sql_on: ${eps_payment.chain_id} = ${eps_payment_adjustment.chain_id} AND ${eps_payment.nhin_store_id} = ${eps_payment_adjustment.nhin_store_id} AND ${eps_payment.payment_id} = ${eps_payment_adjustment.payment_id} ;;
    relationship: one_to_many
  }

  join: eps_payment_type {
    view_label: "Payment"
    type:  left_outer
    fields: [explore_rx_payment_type_4_13_candidate_list*] #[ERXLPS-1211] Exposed to Customer and in Demo model.
    sql_on: ${eps_payment.chain_id} = ${eps_payment_type.chain_id} AND ${eps_payment.nhin_store_id} = ${eps_payment_type.nhin_store_id} AND ${eps_payment.payment_type_id} = ${eps_payment_type.payment_type_id} ;;
    relationship: many_to_one
  }

  join: eps_credit_card {
    view_label: "Payment"
    type:  left_outer
    fields: [explore_rx_credit_card_4_13_candidate_list*] #[ERXLPS-1211] Exposed to Customer and in Demo model.
    sql_on: ${eps_payment.chain_id} = ${eps_credit_card.chain_id} AND ${eps_payment.nhin_store_id} = ${eps_credit_card.nhin_store_id} AND ${eps_payment.credit_card_id} = ${eps_credit_card.credit_card_id} ;;
    relationship: many_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [patient_age_tier, patient_count, rx_com_id_deidentified, explore_dx_patient_age_tier_candidate_list*] #[ERXLPS-6239]
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient.chain_id} AND ${eps_patient.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    fields: []
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many #[ERXLPS-910] Corrected the relationship
  }

  join: bi_demo_patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${bi_demo_patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: patient_us_state_county_fips {
    from: us_state_county_fips
    view_label: "Patient - Central"
    fields: [state_county_fips_code]
    type: left_outer
    sql_on: ${bi_demo_patient_zip_code.state_abbreviation} = ${patient_us_state_county_fips.state} AND ${bi_demo_patient_zip_code.county} = ${patient_us_state_county_fips.county_name} ;;
    relationship: one_to_one
  }

  join: chain_patient_phone_list {
    from:  bi_demo_chain_patient_phone_list
    view_label: "Patient - Central"
    type: left_outer
    fields: [] #No fields exposed. Need to perofmr analysis on PHI data.
    sql_on: ${patient.chain_id} = ${chain_patient_phone_list.chain_id} AND ${patient.rx_com_id} = ${chain_patient_phone_list.rx_com_id} ;;
    relationship: one_to_one
  }

  join: chain_patient {
    view_label: "Patient - Store"
    type: left_outer
    fields: [] #No fields exposed. Need to perofmr analysis on PHI data.
    sql_on: ${patient.chain_id} = ${chain_patient.chain_id} AND ${patient.rx_com_id} = ${chain_patient.rx_com_id} ;;
    relationship: one_to_one
  }

  #[ERXDWPS-7476][ERXDWPS-7987] - PDC flatten view US joins. Start.
  join: pdc_group_gpi_link {
    view_label: "Pharmacy Drug" #[ERXLPS-2101]
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${pdc_group_gpi_link.gpi} AND ${pdc_group_gpi_link.pdc_group_gpi_link_deleted_reference} = 'N' ;;
    relationship: many_to_many #many gpis in store_drug match with many gpis in pdc_group_gpi_link table.
  }

  join: gpi_medical_condition_cross_ref {
    from: pdc_group
    view_label: "Pharmacy Drug" #[ERXLPS-2101]
    type: left_outer
    fields: [medical_condition]
    sql_on: ${pdc_group_gpi_link.pdc_group_id} = ${gpi_medical_condition_cross_ref.pdc_group_id} ;;
    relationship: many_to_one #many pdc_group_id's in pdc_group_gpi_link table match with one pdc_group_id in pdc_group table.
  }

  join: patient_gpi_pdc {
    from: patient_pdc_summary_flatten
    view_label: "Patient PDC"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_gpi_pdc.chain_id}
        AND ${patient.rx_com_id} = ${patient_gpi_pdc.rx_com_id}
        AND ${patient_gpi_pdc.pdc_group_id} = ${gpi_medical_condition_cross_ref.pdc_group_id}
        AND (CASE WHEN {% parameter patient_gpi_pdc.latest_snapshot_filter %} = 'Yes' THEN ${patient_gpi_pdc.snapshot_date} = ${patient_gpi_pdc.latest_snapshot_date} ELSE 1 = 1 END);;
    relationship: one_to_many
  }

  join: bi_version_information {
    view_label: "Patient PDC Version"
    type: left_outer
    sql_on: ${patient_gpi_pdc.bi_version_id} = ${bi_version_information.bi_version_id} ;;
    relationship: many_to_one
  }
  #[ERXDWPS-7476][ERXDWPS-7987] - PDC flatten view US joins. End.

  join: epr_rx_tx {
    from: bi_demo_epr_rx_tx
    fields: []
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${epr_rx_tx.chain_id} AND ${eps_rx.nhin_store_id}= ${epr_rx_tx.nhin_store_id} AND ${eps_rx.rx_number}= ${epr_rx_tx.rx_number} AND ${eps_rx_tx.rx_tx_tx_number}= ${epr_rx_tx.tx_number} ;;
    relationship: one_to_one
  }

  join: prescriber {
    view_label: "Prescriber"
    fields: [count, prescriber.npi_number_deidentified, prescriber.dea_number_deidentified, prescriber.name_deidentified]
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${prescriber.chain_id} AND ${epr_rx_tx.prescriber_id} = ${prescriber.id} ;;
    relationship: many_to_one
  }

  join: bi_demo_prescriber_zip_code {
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${prescriber.zip_code} = ${bi_demo_prescriber_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    fields: [us_zip_code.zip_code, us_zip_code.location, us_zip_code.state_abbreviation, us_zip_code.city]
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${bi_demo_prescriber_zip_code.zip_code_bi_demo_mapping} = ${us_zip_code.zip_code} ;;
    relationship: one_to_one
  }

  join: us_state_county_fips {
    view_label: "Prescriber"
    fields: [us_state_county_fips.state_county_fips_code]
    type: left_outer
    sql_on: ${us_zip_code.state_abbreviation} = ${us_state_county_fips.state} AND ${us_zip_code.county} = ${us_state_county_fips.county_name} ;;
    relationship: one_to_one
  }

  join: store_drug {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${bi_demo_sales.chain_id} AND ${store_drug.nhin_store_id}= ${bi_demo_sales.nhin_store_id} AND ${store_drug.drug_id} = ${bi_demo_sales.sale_drug_dispensed_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: store_drug_prescribed {
    from: store_drug
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug_prescribed.chain_id} = ${eps_rx.chain_id} AND ${store_drug_prescribed.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${store_drug_prescribed.drug_id} = ${eps_rx.rx_prescribed_drug_id} AND ${store_drug_prescribed.deleted_reference} = 'N' ${store_drug_prescribed.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
    fields: [prescribed_drug_name]
  }

  #[ERXLPS-946] - join with store_price_code to get Store drug price code information
  #[ERXLPS-2089] - View name renamed to store_drug_price_code. Removed from clause from join.
  join: store_drug_price_code {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_price_code.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_price_code.nhin_store_id} AND ${store_drug.price_code_id} = to_char(${store_drug_price_code.price_code_id}) AND ${store_drug_price_code.price_code_deleted} = 'N' ;;
    relationship: many_to_one
  }

  join: store_drug_cost {
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_cost.chain_id} AND ${store_drug.nhin_store_id} = ${store_drug_cost.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_cost.drug_id}) AND ${store_drug_cost.store_drug_cost_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_drug_cost_type {
    view_label: "Pharmacy Drug Cost Type"
    type: left_outer
    sql_on: ${store_drug_cost.chain_id} = ${store_drug_cost_type.chain_id} AND ${store_drug_cost.nhin_store_id} = ${store_drug_cost_type.nhin_store_id} AND ${store_drug_cost.drug_cost_type_id} = ${store_drug_cost_type.drug_cost_type_id} AND ${store_drug_cost.store_drug_cost_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: store_drug_cost_pivot {
    from: bi_demo_store_drug_cost_pivot
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug_cost_pivot.chain_id} = ${store_drug.chain_id} AND ${store_drug_cost_pivot.nhin_store_id}= ${store_drug.nhin_store_id} AND to_char(${store_drug_cost_pivot.drug_id}) = ${store_drug.drug_id} ;;
    relationship: one_to_one
  }

  join: drug {
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${eps_rx_tx.rx_tx_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 AND ${drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  #[ERXLPS-1055] - RxTx integration into sales explore. Addition of measures from rx_tx_drug_cost_hist view
  join: rx_tx_drug_cost_hist {
    from: bi_demo_rx_tx_drug_cost_hist
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${rx_tx_drug_cost_hist.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${rx_tx_drug_cost_hist.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${rx_tx_drug_cost_hist.rx_tx_id} ;;
    relationship: one_to_one
  }

  #ERXDWPS-7019 - Albertsons - Expose Medispan Drug Cost in Looker
  join: medispan_rx_tx_drug_cost_hist {
    from: bi_demo_medispan_rx_tx_drug_cost_hist
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${medispan_rx_tx_drug_cost_hist.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${medispan_rx_tx_drug_cost_hist.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${medispan_rx_tx_drug_cost_hist.rx_tx_id} ;;
    relationship: one_to_one
  }

  #[ERXLPS-1246] - Removed join from DEVQA model and added to base explore
  join: rx_tx_store_drug_cost_hist {
    from: bi_demo_rx_tx_store_drug_cost_hist
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${rx_tx_store_drug_cost_hist.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${rx_tx_store_drug_cost_hist.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${rx_tx_store_drug_cost_hist.rx_tx_id} ;;
    relationship: one_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN Drug"
    fields: [gpi_disease_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_disease_rnk} = 1 AND ${drug.drug_source_system_id} = 6 ;;
    relationship: many_to_one
  }

  join: gpi_disease_duration_cross_ref {
    from: gpi_disease_cross_ref
    view_label: "NHIN Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_duration_cross_ref.gpi} and ${gpi_disease_duration_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: gpi {
    fields: [gpi_identifier, gpi_description, gpi_level, gpi_level_variance_flag] #[ERXLPS-1065] Added gpi_level_variance_flag #[ERXLPS-1942] Removed medical_condition
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi.chain_id} AND ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.source_system_id} = 6
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.source_system_id} = 6
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.source_system_id} = 6
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.source_system_id} = 6
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: drug_cost_pivot {
    view_label: "NHIN Drug Cost"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_cost_pivot.chain_id} AND ${drug.drug_ndc} = ${drug_cost_pivot.ndc} AND ${drug_cost_pivot.source_system_id} = 6 AND ${drug_cost_pivot.chain_id} = 3000 ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  join: drug_cost {
    view_label: "NHIN Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug_cost.source_system_id} = 6 AND ${drug_cost.chain_id} = 3000 AND ${drug_cost.deleted_reference} = 'N' AND ${drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost.region}) ;;
    relationship: one_to_many #[ERXLPS-1282] changed relationship from one_to_one to one_to_many
  }

  join: drug_cost_type {
    view_label: "NHIN Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost_type.source_system_id} = 6 AND ${drug_cost_type.chain_id} = 3000 AND ${drug_cost_type.cost_type_deleted_reference} = 'N' AND ${drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join #[ERXLPS-2064]
    relationship: many_to_one
  }

  #[ERXLPS-1845] - Added deleted check in join.
  #[ERXDWPS-7020] - Removed fileds: [sets] definition from joins. View cleaned up for Sales explore.
  join: eps_tx_tp_transmit_queue {
    from: bi_demo_sales_eps_tx_tp_transmit_queue
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${sales_tx_tp.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${sales_tx_tp.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_id} = ${sales_tx_tp.tx_tp_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  #ERXLPS-2455
  join: bi_demo_sales_eps_tx_tp_transmit_queue_latest_yesno {
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: ${bi_demo_sales_eps_tx_tp_transmit_queue_latest_yesno.chain_id} = ${eps_tx_tp_transmit_queue.chain_id} AND ${bi_demo_sales_eps_tx_tp_transmit_queue_latest_yesno.nhin_store_id} = ${eps_tx_tp_transmit_queue.nhin_store_id} AND ${bi_demo_sales_eps_tx_tp_transmit_queue_latest_yesno.tx_tp_transmit_queue_id} = ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} ;;
    relationship: one_to_one
  }

  #[ERX-8] Added Tx TP SA tables as a part of 4.13.000
  join: eps_tx_tp_transmit_reject {
    from: bi_demo_sales_eps_tx_tp_transmit_reject
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_transmit_reject.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_transmit_reject.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_transmit_reject.tx_tp_transmit_queue_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1845] - Added deleted check in join.
  join: eps_tx_tp_other_payer {
    from: bi_demo_sales_eps_tx_tp_other_payer
    view_label: "Other Payer"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp_other_payer.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp_other_payer.nhin_store_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp_other_payer.tx_tp_id} AND ${eps_tx_tp_other_payer.tx_tp_other_payer_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_other_payer_reject {
    from: bi_demo_sales_eps_tx_tp_other_payer_reject
    view_label: "Other Payer"
    type: left_outer
    sql_on: ${eps_tx_tp_other_payer.chain_id} = ${eps_tx_tp_other_payer_reject.chain_id} AND ${eps_tx_tp_other_payer.nhin_store_id} = ${eps_tx_tp_other_payer_reject.nhin_store_id} AND ${eps_tx_tp_other_payer.tx_tp_other_payer_id} = ${eps_tx_tp_other_payer_reject.tx_tp_other_payer_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1845] - Added deleted check in join.
  join: eps_tx_tp_other_payer_amount {
    from: bi_demo_sales_eps_tx_tp_other_payer_amount
    view_label: "Other Payer"
    type: left_outer
    sql_on: ${eps_tx_tp_other_payer.chain_id} = ${eps_tx_tp_other_payer_amount.chain_id} AND ${eps_tx_tp_other_payer.nhin_store_id} = ${eps_tx_tp_other_payer_amount.nhin_store_id} AND ${eps_tx_tp_other_payer.tx_tp_other_payer_id} = ${eps_tx_tp_other_payer_amount.tx_tp_other_payer_id} AND ${eps_tx_tp_other_payer_amount.tx_tp_other_payer_amount_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_dur {
    from: bi_demo_sales_eps_tx_tp_dur
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp_dur.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp_dur.nhin_store_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp_dur.tx_tp_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1845] - Added deleted check in join.
  join: eps_tx_tp_denial_clarification {
    from: bi_demo_sales_eps_tx_tp_denial_clarification
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp_denial_clarification.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp_denial_clarification.nhin_store_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp_denial_clarification.tx_tp_id} AND ${eps_tx_tp_denial_clarification.tx_tp_denial_clarification_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound.chain_id} = ${store_drug.chain_id}  AND ${store_compound.nhin_store_id} = ${store_drug.nhin_store_id} AND to_char(${store_compound.compound_id}) = ${store_drug.drug_id} AND ${store_compound.compound_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_compound_ingredient {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient.chain_id} = ${store_compound.chain_id}  AND ${store_compound_ingredient.nhin_store_id} = ${store_compound.nhin_store_id} AND ${store_compound_ingredient.compound_id} = ${store_compound.compound_id} AND ${store_compound_ingredient.compound_ingredient_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_modifier {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_modifier.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_modifier.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_modifier.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_modifier.compound_ingredient_modifier_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx {
    type: left_outer
    view_label: "Compound Transaction"
    fields: [explore_rx_store_compound_ingredient_tx_sales_4_10_candidate_list*]
    sql_on: ${store_compound_ingredient_tx.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_tx.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_tx.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_tx.compound_ingredient_tx_deleted} = 'N' AND ${store_compound_ingredient_tx.chain_id} = ${eps_rx_tx.chain_id} AND ${store_compound_ingredient_tx.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${store_compound_ingredient_tx.rx_tx_id} = ${eps_rx_tx.rx_tx_id} ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx_lot {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx_lot.chain_id} = ${store_compound_ingredient_tx.chain_id}  AND ${store_compound_ingredient_tx_lot.nhin_store_id} = ${store_compound_ingredient_tx.nhin_store_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_id} = ${store_compound_ingredient_tx.compound_ingredient_tx_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_lot_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: sales_rx_tx_transfer {
    from: bi_demo_sales_rx_tx_transfer
    view_label: "Transfers"
    type: left_outer
    sql_on: ${sales_rx_tx_transfer.chain_id} = ${eps_rx_tx.chain_id}
      AND ${sales_rx_tx_transfer.nhin_store_id} = ${eps_rx_tx.nhin_store_id}
      AND ${sales_rx_tx_transfer.rx_id} = ${eps_rx_tx.rx_id}
      AND coalesce(${sales_rx_tx_transfer.rx_tx_id}, ${eps_rx_tx.rx_tx_id}) = ${eps_rx_tx.rx_tx_id}
       ;;
    relationship: one_to_many
  }

  join: sales_rx_tx_transfer_prior_fill_dates {
    from: bi_demo_sales_rx_tx_transfer_prior_fill_dates
    view_label: "Transfers"
    type: left_outer
    sql_on: ${sales_rx_tx_transfer.chain_id} = ${sales_rx_tx_transfer_prior_fill_dates.chain_id} AND ${sales_rx_tx_transfer.nhin_store_id} = ${sales_rx_tx_transfer_prior_fill_dates.nhin_store_id} AND ${sales_rx_tx_transfer.transfer_id} = ${sales_rx_tx_transfer_prior_fill_dates.transfer_id} ;;
    relationship: one_to_many
  }

  join: sales_rx_tx_transfer_request_queue {
    from: bi_demo_sales_rx_tx_transfer_request_queue
    view_label: "Transfers"
    type: left_outer
    sql_on: ${sales_rx_tx_transfer_request_queue.chain_id} = ${eps_rx.chain_id}
      AND ${sales_rx_tx_transfer_request_queue.nhin_store_id} = ${eps_rx.nhin_store_id}
      AND nvl(${sales_rx_tx_transfer_request_queue.transfer_request_receiving_rx_summary_id}, ${sales_rx_tx_transfer_request_queue.transfer_request_sending_rx_number})
      =  nvl2(${sales_rx_tx_transfer_request_queue.transfer_request_receiving_rx_summary_id}, ${eps_rx.rx_id}, ${eps_rx.rx_number})
       ;;
    relationship: one_to_many
  }

  #[ERXLPS-1535]
  join: sales_rx_tx_transfer_pharmacy {
    from: eps_pharmacy
    view_label: "Transfers"
    type:  left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer_pharmacy.chain_id} = ${sales_rx_tx_transfer.chain_id}
      AND ${sales_rx_tx_transfer_pharmacy.nhin_store_id} = ${sales_rx_tx_transfer.nhin_store_id}
      AND ${sales_rx_tx_transfer_pharmacy.pharmacy_id} = ${sales_rx_tx_transfer.pharmacy_id} ;;
    relationship: many_to_one
  }

  join: sales_rx_tx_transfer_pharmacy_address {
    from: eps_address
    view_label: "Transfers"
    type:  left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer_pharmacy_address.chain_id} = ${sales_rx_tx_transfer_pharmacy.chain_id}
      AND ${sales_rx_tx_transfer_pharmacy_address.nhin_store_id} = ${sales_rx_tx_transfer_pharmacy.nhin_store_id}
      AND ${sales_rx_tx_transfer_pharmacy_address.address_id} = ${sales_rx_tx_transfer_pharmacy.pharmacy_address_id}
      AND ${sales_rx_tx_transfer_pharmacy_address.source_system_id} = ${sales_rx_tx_transfer_pharmacy.source_system_id} ;; #[ERXDWPS-5137]
    relationship: one_to_one
  }

  #[ERXLPS-1553] - Adding Other Pharmacy Phone Number for Transfer script
  join: sales_rx_tx_transfer_pharmacy_phone {
    from: eps_phone
    view_label: "Transfers"
    type:  left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer_pharmacy_phone.chain_id} = ${sales_rx_tx_transfer_pharmacy.chain_id}
      AND ${sales_rx_tx_transfer_pharmacy_phone.nhin_store_id} = ${sales_rx_tx_transfer_pharmacy.nhin_store_id}
      AND ${sales_rx_tx_transfer_pharmacy_phone.phone_id} = ${sales_rx_tx_transfer_pharmacy.pharmacy_phone_id} ;;
    relationship: one_to_one
  }

  #[ERXLPS-2599]
  join: store_transfer_reason {
    view_label: "Transfers"
    type: left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer.chain_id} = ${store_transfer_reason.chain_id}
      AND ${sales_rx_tx_transfer.nhin_store_id} = ${store_transfer_reason.nhin_store_id}
      AND ${sales_rx_tx_transfer.transfer_reason_id} = ${store_transfer_reason.transfer_reason_id}
       ;;
    relationship: one_to_one
  }

  #[ERXLPS-726] - tx_tp_response_detail and detail_amount integration to Sales explore
  #[ERXDWPS-7020] - Removed fileds: [sets] definition from joins. View cleaned up for Sales explore.
  join: eps_tx_tp_response_detail {
    from: bi_demo_sales_eps_tx_tp_response_detail
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_response_detail.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_response_detail.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_response_detail.tx_tp_response_detail_id} ;;
    relationship: one_to_one
  }

  #[ERXDWPS-7020] - Removed fileds: [sets] definition from joins. View cleaned up for Sales explore.
  join: eps_tx_tp_response_detail_amount {
    from: bi_demo_sales_eps_tx_tp_response_detail_amount
    view_label: "Response Detail"
    type: left_outer
#     fields: [] #4.13 sets. Not yet exposed to customer. Hidden in Demo model until exposed to customer.
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_response_detail_amount.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_response_detail_amount.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_response_detail_amount.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  #[ERX-8] added Tx Tp SA tables as a part of 4.13.000 release
  join: eps_tx_tp_resp_approval_message {
    from: bi_demo_sales_eps_tx_tp_resp_approval_message
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_resp_approval_message.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_resp_approval_message.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_resp_approval_message.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_resp_additional_message {
    from: bi_demo_sales_eps_tx_tp_resp_additional_message
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_resp_additional_message.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_resp_additional_message.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_resp_additional_message.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_response_preferred_product {
    from: bi_demo_sales_eps_tx_tp_response_preferred_product
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_response_preferred_product.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_response_preferred_product.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_response_preferred_product.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_submit_detail {
    from: bi_demo_sales_eps_tx_tp_submit_detail
    view_label: "Submit Detail"
    fields: [sales_tx_tp_submit_detial_dimension_candidate_list*,explore_sales_specific_candidate_list*]
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_submit_detail.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_submit_detail.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_submit_detail.tx_tp_submit_detail_id} ;;
    relationship: one_to_one
  }

  #[ERX-8] added Tx Tp SA tables as a part of 4.13.000 release
  join: eps_tx_tp_submit_detail_segment_code {
    from: bi_demo_sales_eps_tx_tp_submit_detail_segment_code
    view_label: "Submit Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_submit_detail.chain_id} = ${eps_tx_tp_submit_detail_segment_code.chain_id} AND ${eps_tx_tp_submit_detail.nhin_store_id} = ${eps_tx_tp_submit_detail_segment_code.nhin_store_id} AND ${eps_tx_tp_submit_detail.tx_tp_submit_detail_id} = ${eps_tx_tp_submit_detail_segment_code.tx_tp_submit_detail_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1599]
  join: eps_shipment {
    from: bi_demo_sales_eps_shipment
    view_label: "Shipment - Store"
    type: left_outer
    sql_on: ${eps_shipment.chain_id} = ${bi_demo_sales.chain_id} AND ${eps_shipment.nhin_store_id} = ${bi_demo_sales.nhin_store_id} AND ${eps_shipment.shipment_id} = ${bi_demo_sales.shipment_id} ;;
    relationship: many_to_one
  }

  #[ERXLPS-1438] - Patient Card Details
  join: patient_eps_tp_link {
    from: eps_tp_link
    view_label: "Patient Card - Store" #[ERXLPS-1024][ERXLPS-2420] - Renamed view label. (Appended with - Store)
    fields: [bi_demo_sales_patient_tp_link_dimension_candidate_list*]
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient_eps_tp_link.chain_id} AND ${eps_patient.nhin_store_id} = ${patient_eps_tp_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${patient_eps_tp_link.patient_id}) AND ${eps_patient.source_system_id} = ${patient_eps_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: one_to_many
  }

  join: patient_eps_card {
    from: eps_card
    fields: [eps_card_dates_menu_candidate_list*]
    view_label: "Patient Card - Store" #[ERXLPS-1024][ERXLPS-2420] - Renamed view label. (Appended with - Store)
    type: left_outer
    sql_on: ${patient_eps_tp_link.chain_id} = ${patient_eps_card.chain_id} AND ${patient_eps_tp_link.nhin_store_id} = ${patient_eps_card.nhin_store_id} AND ${patient_eps_tp_link.card_id} = ${patient_eps_card.card_id} AND ${patient_eps_tp_link.source_system_id} = ${patient_eps_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: patient_eps_plan {
    from: eps_plan
    fields: [bi_demo_explore_sales_patient_plan_candidate_list*]
    view_label: "Patient Plan - Store" #[ERXLPS-1024][ERXLPS-2420] - Renamed view label. (Appended with - Store)
    type: left_outer
    sql_on: ${patient_eps_card.chain_id} = ${patient_eps_plan.chain_id} AND ${patient_eps_card.nhin_store_id} = ${patient_eps_plan.nhin_store_id} AND ${patient_eps_card.plan_id} = ${patient_eps_plan.plan_id} AND ${patient_eps_card.source_system_id} = ${patient_eps_plan.source_system_id};; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: patient_eps_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_sales_patient_plan_candidate_list*]
    view_label: "Patient Plan - Store" #[ERXLPS-1024][ERXLPS-2420] - Renamed view label. (Appended with - Store)
    type: left_outer
    sql_on: ${patient_eps_plan.chain_id} = ${patient_eps_plan_transmit.chain_id} AND ${patient_eps_plan.nhin_store_id} = ${patient_eps_plan_transmit.nhin_store_id} AND ${patient_eps_plan.plan_id} = ${patient_eps_plan_transmit.plan_id} AND ${patient_eps_plan.source_system_id} = ${patient_eps_plan_transmit.source_system_id} AND ${patient_eps_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  #[ERXLPS-2321]
  join: sales_primary_payer_cost {
    from: bi_demo_sales_primary_payer_cost
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${sales_primary_payer_cost.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${sales_primary_payer_cost.nhin_store_id} AND ${sales_tx_tp.rx_tx_id} = ${sales_primary_payer_cost.rx_tx_id} ;;
    relationship: many_to_one
  }

  #ERXLPS-1349 #ERXLPS-1383
  join: bi_demo_sales_store_central_fill {
    view_label: "Central Fill - Store"
    type: left_outer
    sql_on: ${bi_demo_sales_store_central_fill.chain_id}         = ${bi_demo_sales.chain_id}
        and ${bi_demo_sales_store_central_fill.nhin_store_id}    = ${bi_demo_sales.nhin_store_id}
        and ${bi_demo_sales_store_central_fill.source_system_id} = ${bi_demo_sales.source_system_id}
        and ${bi_demo_sales_store_central_fill.central_fill_id}  = ${bi_demo_sales.rx_tx_id} ;;
    relationship: many_to_one
  }

  #ERXLPS-1349 #ERXLPS-1383
  join: bi_demo_sales_store_package_information {
    view_label: "Package Information - Store"
    type: left_outer
    sql_on: ${bi_demo_sales_store_package_information.chain_id}                     = ${bi_demo_sales_store_central_fill.chain_id}
        and ${bi_demo_sales_store_package_information.nhin_store_id}                = ${bi_demo_sales_store_central_fill.nhin_store_id}
        and ${bi_demo_sales_store_package_information.source_system_id}             = ${bi_demo_sales_store_central_fill.source_system_id}
        and ${bi_demo_sales_store_package_information.store_package_information_id} = ${bi_demo_sales_store_central_fill.package_information_id} ;;
    relationship: many_to_one
  }



  #[ERXDWPS-5091] - Store Price Code at Fill. Use same join name in CUSTOMER Model and explore_base to maintain standards.
  join: store_price_code_hist_listagg {
    from:  bi_demo_store_price_code_hist_listagg
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${bi_demo_sales.chain_id} = ${store_price_code_hist_listagg.chain_id}
        and ${bi_demo_sales.nhin_store_id} = ${store_price_code_hist_listagg.nhin_store_id}
        and ${bi_demo_sales.rx_tx_price_code_id} = ${store_price_code_hist_listagg.price_code_id}
        and ${bi_demo_sales.source_system_id} = ${store_price_code_hist_listagg.source_system_id} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-6197]
  join: store_rx_tx_tp_detail_flatten {
    from: bi_demo_sales_store_rx_tx_tp_detail_flatten
    view_label: "Prescription Transaction Claim Detail Flatten"
    type: left_outer
    sql_on: ${bi_demo_sales.chain_id} = ${store_rx_tx_tp_detail_flatten.chain_id}
        AND ${bi_demo_sales.nhin_store_id} = ${store_rx_tx_tp_detail_flatten.nhin_store_id}
        AND ${bi_demo_sales.rx_tx_id} = ${store_rx_tx_tp_detail_flatten.rx_tx_id}
        AND ${bi_demo_sales.source_system_id} = ${store_rx_tx_tp_detail_flatten.source_system_id} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8260] COSTCO SOW - Moving Average Cost - Sales Looker Dimensions and Measures
  join: store_rx_tx_detail_flatten {
    view_label: "Prescription Transaction Detail Flatten"
    type: left_outer
    sql_on: ${bi_demo_sales.chain_id} = ${store_rx_tx_detail_flatten.chain_id}
        AND ${bi_demo_sales.nhin_store_id} = ${store_rx_tx_detail_flatten.nhin_store_id}
        AND ${bi_demo_sales.rx_tx_id} = ${store_rx_tx_detail_flatten.rx_tx_id}
        AND ${bi_demo_sales.source_system_id} = ${store_rx_tx_detail_flatten.source_system_id} ;;
    relationship: many_to_one
  }

}

#[ERXLPS_1212]
explore: compound {
  view_name: store_compound
  view_label: "Compound"
  sql_always_where: ${store_compound.compound_deleted} = 'N' AND ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.
  description: "Displays information pertaining to drug compounds"

  join: bi_demo_chain {
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${store_compound.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${store_compound.chain_id} = ${bi_demo_store.chain_id}  AND ${store_compound.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: store_compound_ingredient {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient.chain_id} = ${store_compound.chain_id}  AND ${store_compound_ingredient.nhin_store_id} = ${store_compound.nhin_store_id} AND ${store_compound_ingredient.compound_id} = ${store_compound.compound_id} AND ${store_compound_ingredient.compound_ingredient_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_modifier {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_modifier.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_modifier.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_modifier.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_modifier.compound_ingredient_modifier_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_tx.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_tx.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_tx.compound_ingredient_tx_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx_lot {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx_lot.chain_id} = ${store_compound_ingredient_tx.chain_id}  AND ${store_compound_ingredient_tx_lot.nhin_store_id} = ${store_compound_ingredient_tx.nhin_store_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_id} = ${store_compound_ingredient_tx.compound_ingredient_tx_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_lot_deleted} = 'N' ;;
    relationship: one_to_many
  }
}


#[ERXLPS-1362]
explore: eps_prescriber_edi {
  label: "eScript"
  view_name:  bi_demo_eps_prescriber_edi
  view_label: "eScript"
  description: "Displays information pertaining to eScripts"
  sql_always_where: ${prescriber_edi_message_type_filter} IN ('NEWRX','REFRES','ERROR','CANRX') AND ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.

  always_filter: {
    filters: {
      field: rx_tx_fill_status_filter
      value: "NEW PRESCRIPTION"
    }

    filters: {
      field: rx_tx_tx_status_filter
      value: "NORMAL"
    }

    filters: {
      field: escript_message_approval_status_filter
      value: "NEW PRESCRIPTION MESSAGE,REFILL RESPONSE MESSAGE APPROVED,REFILL RESPONSE MESSAGE APPROVED WITH CHANGES"
    }

    filters: {
      field: received_to_rpt_sales_duration
      value: ">0"
    }
  }

  fields: [
    ALL_FIELDS*,
    -eps_rx_tx.explore_sales_specific_candidate_list*,
    -eps_rx_tx.gap_time_measures_candidate_list*,
    -eps_rx.rx_number,
    -eps_rx_tx.bi_demo_specific_candidate_list*,
    #-eps_rx_tx.is_on_time_filter,
    -eps_rx_tx.on_time,
    -eps_rx_tx.is_on_time,
    -eps_rx_tx.is_on_time_fifteen,
    -eps_rx_tx.prescription_fill_duration,
    -eps_rx_tx.sum_fill_duration,
    -eps_rx_tx.avg_fill_duration,
    -eps_rx_tx.median_fill_duration,
    -eps_rx_tx.max_fill_duration,
    -eps_rx_tx.min_fill_duration,
    -eps_rx_tx.start,
    -eps_rx_tx.start_date,
    -eps_rx_tx.start_day_of_month,
    -eps_rx_tx.start_day_of_week,
    -eps_rx_tx.start_day_of_week_index,
    -eps_rx_tx.start_hour2,
    -eps_rx_tx.start_hour_of_day,
    -eps_rx_tx.start_minute15,
    -eps_rx_tx.start_month,
    -eps_rx_tx.start_month_num,
    -eps_rx_tx.start_quarter,
    -eps_rx_tx.start_quarter_of_year,
    -eps_rx_tx.start_time,
    -eps_rx_tx.start_time_of_day,
    -eps_rx_tx.start_week,
    -eps_rx_tx.start_week_of_year,
    -eps_rx_tx.start_year,
    -eps_rx_tx.time_in_will_call,
    -eps_rx_tx.sum_time_in_will_call,
    -eps_rx_tx.avg_time_in_will_call,
    -eps_rx_tx.median_time_in_will_call,
    -eps_rx_tx.max_time_in_will_call,
    -eps_rx_tx.min_time_in_will_call,
    -eps_rx_tx.pharmacy_comparable_flag,
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_drug.store_drug_cost_region, #[ERXLPS-1925]
    -eps_rx_tx.active_archive_filter, #[ERX-6185]
    -eps_rx_tx.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -eps_rx.exploredx_eps_rx_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]

  join: bi_demo_chain {
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${bi_demo_eps_prescriber_edi.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    type: left_outer
    view_label: "Pharmacy - Central"
    sql_on: ${bi_demo_eps_prescriber_edi.chain_id} = ${bi_demo_store.chain_id}  AND ${bi_demo_eps_prescriber_edi.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  #[ERXLPS-2448] - Join to get Price Region from store_setting table.
  join: store_setting_price_code_region {
    from: store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${bi_demo_store.chain_id} = ${store_setting_price_code_region.chain_id} AND  ${bi_demo_store.nhin_store_id} = ${store_setting_price_code_region.nhin_store_id} AND upper(${store_setting_price_code_region.store_setting_name}) = 'STOREDESCRIPTION.PRICEREGION' ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: eps_rx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${bi_demo_eps_prescriber_edi.chain_id} = ${eps_rx.chain_id}
        AND ${bi_demo_eps_prescriber_edi.nhin_store_id} = ${eps_rx.nhin_store_id}
        AND ${bi_demo_eps_prescriber_edi.prescriber_edi_id} = ${eps_rx.rx_prescriber_edi_id}
        AND ${eps_rx.rx_number} IS NOT NULL
        AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: eps_rx_tx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${eps_rx_tx.chain_id}
        AND ${eps_rx.nhin_store_id} = ${eps_rx_tx.nhin_store_id}
        AND ${eps_rx.rx_id} = ${eps_rx_tx.rx_id}
        AND ${eps_rx_tx.rx_tx_refill_number} = 0
        AND ${eps_rx_tx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: eps_patient {
    view_label: "Patient- Store"
    fields: []
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${eps_patient.chain_id} AND ${eps_rx.nhin_store_id} = ${eps_patient.nhin_store_id} AND ${eps_rx.rx_patient_id} = ${eps_patient.patient_id} AND ${eps_patient.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [patient_age_tier, patient_count, rx_com_id_deidentified, explore_dx_patient_age_tier_candidate_list*] #[ERXLPS-6239]
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient.chain_id} AND ${eps_patient.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: epr_rx_tx {
    from: bi_demo_epr_rx_tx
    fields: []
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${epr_rx_tx.chain_id} AND ${eps_rx.nhin_store_id}= ${epr_rx_tx.nhin_store_id} AND ${eps_rx.rx_number}= ${epr_rx_tx.rx_number} AND ${eps_rx_tx.rx_tx_tx_number}= ${epr_rx_tx.tx_number} ;;
    relationship: one_to_one
  }

  join: prescriber {
    view_label: "Prescriber"
    fields: [count, prescriber.npi_number_deidentified, prescriber.dea_number_deidentified, prescriber.name_deidentified]
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${prescriber.chain_id} AND ${epr_rx_tx.prescriber_id} = ${prescriber.id} ;;
    relationship: many_to_one
  }

  join: store_drug {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: store_drug_prescribed {
    from: store_drug
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug_prescribed.chain_id} = ${eps_rx.chain_id} AND ${store_drug_prescribed.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${store_drug_prescribed.drug_id} = ${eps_rx.rx_prescribed_drug_id} AND ${store_drug_prescribed.deleted} = 'N' ${store_drug_prescribed.source_system_id} = 4 ;;
    relationship: many_to_one
    fields: [prescribed_drug_name]
  }

  join: store_drug_price_code {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_price_code.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_price_code.nhin_store_id} AND ${store_drug.price_code_id} = to_char(${store_drug_price_code.price_code_id}) AND ${store_drug_price_code.price_code_deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.
}

explore: hospital {
  view_name: hospital_general_information
  label: "Hospital"
  description: "Displays information of Hospital's demographic information, HCAHPS ratings for all hospitals and all other KPIs around infections received due to a stay at one of the health systems, types of care provided by these hopitals, average speding by hospital, State and National"

  always_filter: {
    filters: {
      field: hospital_general_information.hospital_name
      value: ""
    }

    filters: {
      field: hospital_measure_link.measure_name
      value: ""
    }

  }

  join: us_state_county_fips {
    view_label: "Hospital General Information"
    type: left_outer
    sql_on: ${hospital_general_information.state} = ${us_state_county_fips.state} AND ${hospital_general_information.county_name} = ${us_state_county_fips.county_name} ;;
    relationship: one_to_one
  }

  join: hospital_measure_link {
    view_label: "Hospital Measures"
    type: inner
    sql_on: ${hospital_general_information.provider_id} = ${hospital_measure_link.provider_id} ;;
    relationship: one_to_many
  }

  join: hcahps_hospital {
    view_label: "HCAHPS"
    type: left_outer
    sql_on: ${hospital_measure_link.provider_id} = ${hcahps_hospital.provider_id} AND ${hospital_measure_link.measure_id} = ${hcahps_hospital.hcahps_measure_id};;
    relationship: one_to_one
  }

#   join: hcahps_national {
#     view_label: "HCAPHS - National"
#     type: inner
#     sql_on: ${hcahps_national.hcahps_measure_id} = ${hcahps_hospital.hcahps_measure_id} ;;
#     relationship: many_to_one
#   }

  join: hai_hospital {
    view_label: "Healthcare Associated Infections"
    type: left_outer
    sql_on: ${hospital_measure_link.provider_id} = ${hai_hospital.provider_id} AND ${hospital_measure_link.measure_id} = ${hai_hospital.measure_id} ;;
    relationship: one_to_one
  }

  join: timely_and_effective_care_hospital {
    view_label: "Timely and Effective Care"
    type: left_outer
    sql_on: ${hospital_measure_link.provider_id} = ${timely_and_effective_care_hospital.provider_id} AND ${hospital_measure_link.measure_id} = ${timely_and_effective_care_hospital.measure_id};;
    relationship: one_to_one
  }

  join: medicare_hospital_spending_by_claim {
    view_label: "Medicare Hospital Spending by Claim"
    type: left_outer
    sql_on: ${hospital_measure_link.provider_id} = ${medicare_hospital_spending_by_claim.provider_id} AND ${hospital_measure_link.measure_id} = ${medicare_hospital_spending_by_claim.claim_type} ||' -- ' || ${medicare_hospital_spending_by_claim.period} AND ${medicare_hospital_spending_by_claim.claim_type} <> 'Total';;
    relationship: one_to_one
  }

}

#[ERXLPS-4396]
explore: plan {
  extends: [plan_nhin_base]
  fields: [ALL_FIELDS*,
    -plan.plan_name]
}

#[ERXDWPS-5883] - Task History Explore.
explore: eps_task_history {
  label: "Task History"
  view_name: eps_task_history
  view_label: "Task History"
  fields: [ALL_FIELDS*,
    -eps_task_history.count_user_employee_number,
    -eps_task_history.task_history_user_login,
    -eps_task_history.task_history_user_employee_number,
    -eps_task_history.on_site_alt_site,
    -eps_task_history.task_history_station_label,
    -eps_task_history.task_history_action_date_filter
  ]
  description: "Displays information relating to the tasks associated with processing prescriptions within the EPS system."

  sql_always_where: ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #[ERXDWPS-5419] Added to restrict the results always to DEMO Chains.

  always_filter: {
    filters: {
      field: eps_task_history.task_history_action_current_date
      value: "Last 30 Days"
    }
  }

  join: bi_demo_chain {
    type: inner
    fields: [chain_name]
    view_label: "Pharmacy - Central"
    sql_on: ${eps_task_history.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    type: left_outer
    fields: [
      bi_demo_nhin_store_id,
      store_number,
      store_name,
      store_client_type,
      store_client_version,
      store_category,
      count,
      deactivated
    ]
    view_label: "Pharmacy - Central"
    sql_on: ${eps_task_history.chain_id} = ${bi_demo_store.chain_id}  AND ${eps_task_history.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: store_user {
    from: bi_demo_store_user
    view_label: "User"
    type: left_outer
    sql_on: ${eps_task_history.chain_id} = ${store_user.chain_id} AND ${eps_task_history.nhin_store_id} = ${store_user.nhin_store_id} AND ${eps_task_history.task_history_user_login} = ${store_user.store_user_login_reference} AND ${store_user.source_system_id} = 4 AND ${store_user.store_user_deleted_reference} = 'N' ;;
    relationship: many_to_one
  }

  join: task_history_task_start_listagg {
    from: bi_demo_task_history_task_start_listagg
    view_label: "Task History"
    type: left_outer
    sql_on: ${eps_task_history.chain_id} = ${task_history_task_start_listagg.chain_id}
            AND ${eps_task_history.nhin_store_id} = ${task_history_task_start_listagg.nhin_store_id}
            AND ${eps_task_history.rx_tx_id} = ${task_history_task_start_listagg.rx_tx_id}
            AND ${eps_task_history.task_history_user_employee_number} = ${task_history_task_start_listagg.task_history_user_employee_number}
            AND ${eps_task_history.task_history_task_name} = ${task_history_task_start_listagg.task_history_task_name} ;;
    relationship: many_to_one
  }
}

#[ERXDWPS-6425] - User Explore.
explore: store_user {
  label: "User"
  view_name: bi_demo_store_user
  view_label: "User"
  fields: [ALL_FIELDS*,
          -store_user_group.explore_dx_store_user_group_candidate_list*, #[ERXDWPS-6425] Hiding store_user_group view information. This table acts as a brige betweem user and groups fo joins.
          -store_user_license_type.count,
          -store_user_license.store_user_license_number
          ]
  description: "Displays information pertaining to store users"

  sql_always_where: ${bi_demo_chain.bi_demo_chain_id} = 11111 ;; #Added to restrict the results always to DEMO Chains.

  join: bi_demo_chain {
    type: inner
    fields: [chain_name]
    view_label: "Pharmacy - Central"
    sql_on: ${bi_demo_store_user.chain_id} = ${bi_demo_chain.chain_id} ;;
    relationship: many_to_one
  }

  join: bi_demo_store {
    type: left_outer
    fields: [
      bi_demo_nhin_store_id,
      store_number,
      store_name,
      store_client_type,
      store_client_version,
      store_category,
      count,
      deactivated
    ]
    view_label: "Pharmacy - Central"
    sql_on: ${bi_demo_store_user.chain_id} = ${bi_demo_store.chain_id}  AND ${bi_demo_store_user.nhin_store_id} = ${bi_demo_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: store_user_group {
    view_label: "User"
    type: left_outer
    sql_on: ${bi_demo_store_user.chain_id} = ${store_user_group.chain_id} AND ${bi_demo_store_user.nhin_store_id} = ${store_user_group.nhin_store_id} AND ${bi_demo_store_user.user_id} = ${store_user_group.user_id} AND ${bi_demo_store_user.source_system_id} = 4 AND ${store_user_group.store_user_group_deleted_reference} = 'N' ;;
    relationship: many_to_many
  }

  join: store_group {
    view_label: "User"
    type: inner
    sql_on: ${store_user_group.chain_id} = ${store_group.chain_id} AND ${store_user_group.nhin_store_id} = ${store_group.nhin_store_id} AND ${store_user_group.group_id} = ${store_group.group_id} ;;
    relationship: many_to_one
  }

  join: store_user_license {
    view_label: "User License"
    type: left_outer
    sql_on: ${bi_demo_store_user.chain_id} = ${store_user_license.chain_id} AND ${bi_demo_store_user.nhin_store_id} = ${store_user_license.nhin_store_id} AND ${bi_demo_store_user.user_id} = ${store_user_license.user_id} AND ${bi_demo_store_user.source_system_id} = 4 ;;
    relationship: one_to_many
  }

  join: store_user_license_type {
    view_label: "User License"
    type: left_outer
    sql_on: ${store_user_license.chain_id} = ${store_user_license_type.chain_id} AND ${store_user_license.nhin_store_id} = ${store_user_license_type.nhin_store_id} AND ${store_user_license.user_license_type_id} = ${store_user_license_type.user_license_type_id} AND ${store_user_license.source_system_id} = ${store_user_license_type.source_system_id} ;;
    relationship: one_to_many
  }
}
