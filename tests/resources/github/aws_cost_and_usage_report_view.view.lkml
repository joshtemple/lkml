view: aws_cost_and_usage_report_view {
  sql_table_name: athenacurcfn_cost_usage_report.cost_usage_report ;;
  suggestions: no

  dimension: bill_bill_type {
    label: "Type"
    view_label: "Billing Info"
    type: string
    sql: ${TABLE}.bill_bill_type ;;
  }

  dimension: bill_billing_entity {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_billing_entity ;;
  }

  dimension_group: bill_billing_period_end {
    view_label: "Billing Info"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.bill_billing_period_end_date ;;
  }

  dimension_group: bill_billing_period_start {
    view_label: "Billing Info"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.bill_billing_period_start_date ;;
  }

  dimension: bill_invoice_id {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_invoice_id ;;
  }

  dimension: bill_payer_account_id {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_payer_account_id ;;
  }

  dimension: identity_line_item_id {
    type: string
    hidden: yes
    sql: ${TABLE}.identity_line_item_id ;;
  }

  dimension: identity_time_interval {
    type: string
    hidden: yes
    sql: ${TABLE}.identity_time_interval ;;
  }

  dimension: line_item_availability_zone {
    type: string
    hidden: yes
    sql: ${TABLE}.line_item_availability_zone ;;
  }

  dimension: line_item_blended_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.line_item_blended_cost ;;
  }

  dimension: line_item_blended_rate {
    view_label: "Line Items (Individual Charges)"
    description: "The rate applied to this line item for a consolidated billing account in an organization."
    type: number
    sql: ${TABLE}.line_item_blended_rate ;;
  }

  dimension: line_item_currency_code {
    label: "Currency Code"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.line_item_currency_code ;;
  }

  dimension: line_item_legal_entity {
    type: string
    sql: ${TABLE}.line_item_legal_entity ;;
  }

  dimension: line_item_line_item_description {
    view_label: "Line Items (Individual Charges)"
    description: "A description of the pricing tier covered by this line item"
    type: string
    sql: ${TABLE}.line_item_line_item_description ;;
  }

  #### TYPES OF CHARGES

  dimension: type {
    view_label: "Line Items (Individual Charges)"
    description: "Fee is one-time RI expense for all-upfront or partial-upfront. RI Fee is recurring RI expense for partial-upfront and no-upfront RI expenses."
    type: string
    sql: ${TABLE}.line_item_line_item_type ;;
  }

  dimension: type_ri_fee_upfront {
    view_label: "Reserved Units"
    description: "Fee is one-time RI expense for all-upfront or partial-upfront."
    type: string
    sql: CASE WHEN ${TABLE}.line_item_line_item_type = 'Fee' THEN 'Fee' ELSE 'Other' END ;;
  }

  dimension: type_ri_fee_on_demand {
    view_label: "Reserved Units"
    description: "RI Fee is recurring RI expense for partial-upfront and no-upfront RI expenses."
    type: string
    sql: CASE WHEN ${TABLE}.line_item_line_item_type = 'RIFee' THEN 'RI Fee' ELSE 'Other' END ;;
  }

  dimension: type_discounted_usage {
    view_label: "Reserved Units"
    description: "Describes the instance usage that recieved a matching RI discount benefit. It is added to the bill once a reserved instance experiences usage. Cost will always be zero because it's been accounted for with Fee and RI Fee."
    type: string
    sql: CASE WHEN ${TABLE}.line_item_line_item_type = 'DiscountedUsage' THEN 'Discounted Usage' ELSE 'Other' END ;;
  }

  dimension: ri_line_item {
    label: "RI Line Item (Yes/No)"
    view_label: "Reserved Units"
    description: "Inlcudes all cost and usage information for Reserved Instances."
    type: string
    sql: CASE
         WHEN ${type} = 'DiscountedUsage' THEN 'RI Line Item'
         WHEN ${type} = 'RIFee' THEN 'RI Line Item'
         WHEN ${type} = 'Fee' THEN 'RI Line Item'
         ELSE 'Non RI Line Item'
        END ;;
  }

  ####

  dimension: line_item_normalization_factor {
    view_label: "Line Items (Individual Charges)"
    description: "Degree of instance size flexibility provided by RIs"
    type: number
    sql: ${TABLE}.line_item_normalization_factor ;;
  }

  dimension: line_item_normalized_usage_amount {
    type: number
    hidden: yes
    sql: ${TABLE}.line_item_normalized_usage_amount ;;
  }

  dimension: line_item_operation {
    label: "Operation"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.line_item_operation ;;
  }

  dimension: line_item_product_code {
    description: "The AWS product/service being used"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.line_item_product_code ;;
  }

  dimension: line_item_resource_id {
    type: string
    hidden: no
    sql: ${TABLE}.line_item_resource_id ;;
    tags: ["aws_resource_id"]
  }

  dimension: line_item_tax_type {
    label: "Tax Type"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.line_item_tax_type ;;
  }

  dimension: line_item_unblended_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.line_item_unblended_cost ;;
  }

  dimension: line_item_unblended_rate {
    view_label: "Line Items (Individual Charges)"
    description: "The rate that this line item would have been charged for an unconsolidated account."
    type: number
    sql: ${TABLE}.line_item_unblended_rate ;;
  }

  dimension: line_item_usage_account_id {
    view_label: "Line Items (Individual Charges)"
    label: "Account ID"
    description: "RIs can span multiple accounts - this dimensions related to usage"
    type: string
    sql: ${TABLE}.line_item_usage_account_id ;;
  }

  dimension: line_item_usage_amount {
    type: number
    hidden: yes
    sql: ${TABLE}.line_item_usage_amount ;;
  }

  dimension_group: line_item_usage_end {
    view_label: "Line Items (Individual Charges)"
    type: time
    timeframes: [
      raw,
      time,
      time_of_day,
      hour,
      date,
      week,
      day_of_week,
      month,
      month_name,
      year
    ]
    sql: ${TABLE}.line_item_usage_end_date ;;
  }

  dimension_group: line_item_usage_start {
    view_label: "Line Items (Individual Charges)"
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
    sql: ${TABLE}.line_item_usage_start_date ;;
  }

  dimension: usage_hours {
    view_label: "Line Items (Individual Charges)"
    sql: date_diff('hour', ${line_item_usage_start_raw}, ${line_item_usage_end_raw}) ;;
  }

  measure: total_usage_hours {
    view_label: "Billing Info"
    type: sum
    sql: ${usage_hours} ;;
  }

  dimension: line_item_usage_type {
    label: "Usage Type"
    view_label: "Line Items (Individual Charges)"
    description: "The type of usage covered by this line item. If you paid for a Reserved Instance, the report has one line that shows the monthly committed cost, and multiple lines that show a charge of 0."
    type: string
    sql: ${TABLE}.line_item_usage_type ;;
  }

  dimension: product_account_assistance {
    label: "Account Assistance"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_account_assistance ;;
  }

  dimension: product_architectural_review {
    label: "Architecture Review"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_architectural_review ;;
  }

  dimension: product_architecture_support {
    label: "Architecture Support"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_architecture_support ;;
  }

  dimension: product_availability {
    label: "Availability"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_availability ;;
  }

  dimension: product_best_practices {
    type: string
    hidden: yes
    sql: ${TABLE}.product_best_practices ;;
  }

  dimension: product_cache_engine {
    hidden: yes
    type: string
    sql: ${TABLE}.product_cache_engine ;;
  }

  dimension: product_case_severityresponse_times {
    type: string
    hidden: yes
    sql: ${TABLE}.product_case_severityresponse_times ;;
  }

  dimension: product_current_generation {
    type: string
    hidden: yes
    sql: ${TABLE}.product_current_generation ;;
  }

  dimension: product_customer_service_and_communities {
    type: string
    hidden: yes
    sql: ${TABLE}.product_customer_service_and_communities ;;
  }

  dimension: product_database_edition {
    label: "Database Edition"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_database_edition ;;
  }

  dimension: product_database_engine {
    label: "Database Engine"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_database_engine ;;
  }

  dimension: product_dedicated_ebs_throughput {
    label: "Dedicated EBS Throughput"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_dedicated_ebs_throughput ;;
  }

  dimension: product_deployment_option {
    view_label: "Product Info"
    type: string
    hidden: yes
    sql: ${TABLE}.product_deployment_option ;;
  }

  dimension: product_description {
    label: "Description"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_description ;;
  }

  dimension: product_durability {
    label: "Durability"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_durability ;;
  }

  dimension: product_ebs_optimized {
    hidden: yes
    type: string
    sql: ${TABLE}.product_ebs_optimized ;;
  }

  dimension: product_ecu {
    type: string
    hidden: yes
    sql: ${TABLE}.product_ecu ;;
  }

  dimension: product_endpoint_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_endpoint_type ;;
  }

  dimension: product_engine_code {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_engine_code ;;
  }

  dimension: product_enhanced_networking_supported {
    view_label: "Product Info"
    type: string
    hidden: yes
    sql: ${TABLE}.product_enhanced_networking_supported ;;
  }

  dimension: product_execution_frequency {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_execution_frequency ;;
  }

  dimension: product_execution_location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_execution_location ;;
  }

  dimension: product_fee_code {
    type: string
    hidden: yes
    sql: ${TABLE}.product_fee_code ;;
  }

  dimension: product_fee_description {
    type: string
    hidden: yes
    sql: ${TABLE}.product_fee_description ;;
  }

  dimension: product_free_query_types {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_free_query_types ;;
  }

  dimension: free_trial {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_free_trial ;;
  }

  dimension: product_frequency_mode {
    type: string
    hidden: yes
    sql: ${TABLE}.product_frequency_mode ;;
  }

  dimension: from_location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_from_location ;;
  }

  dimension: from_location_viz {
    view_label: "Product Info"
    description: "Should ONLY be used for visualization purposes"
    type: location
    sql_latitude: ${from_location_lat} ;;
    sql_longitude: ${from_location_long} ;;
  }

  dimension: to_location_viz {
    view_label: "Product Info"
    description: "Should ONLY be used for visualization purposes"
    type: location
    sql_latitude: ${to_location_lat} ;;
    sql_longitude: ${to_location_long} ;;
  }


  dimension: from_location_lat {
    hidden: yes
    type: string
    sql: CASE
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Mumbai)' THEN '19.075984'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Seoul)' THEN '37.566535'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Singapore)' THEN '1.352083'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Sydney)' THEN '-33.868820'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Tokyo)' THEN '35.689487'
        WHEN ${TABLE}.product_from_location = 'Australia' THEN '-25.274398'
        WHEN ${TABLE}.product_from_location = 'Canada' THEN '56.130366'
        WHEN ${TABLE}.product_from_location = 'Canada (Central)' THEN '56.130366'
        WHEN ${TABLE}.product_from_location = 'EU (Frankfurt)' THEN '50.110922'
        WHEN ${TABLE}.product_from_location = 'EU (Ireland)' THEN '53.142367'
        WHEN ${TABLE}.product_from_location = 'India' THEN '20.593684'
        WHEN ${TABLE}.product_from_location = 'Japan' THEN '36.204824'
        WHEN ${TABLE}.product_from_location = 'South America (Sao Paulo)' THEN '-23.550520'
        WHEN ${TABLE}.product_from_location = 'South America' THEN '-23.550520'
        WHEN ${TABLE}.product_from_location = 'US East (N. Virginia)' THEN '37.431573'
        WHEN ${TABLE}.product_from_location = 'US East (Ohio)' THEN '40.417287'
        WHEN ${TABLE}.product_from_location = 'US West (N. California)' THEN '38.837522'
        WHEN ${TABLE}.product_from_location = 'US WEST (Oregon)' THEN '43.804133'
        ELSE 'Not labeled'
        END
        ;;
  }

  dimension: from_location_long {
    hidden: yes
    type: string
    sql: CASE
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Mumbai)' THEN '72.877656'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Seoul)' THEN '126.977969'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Singapore)' THEN '103.819836'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Sydney)' THEN '151.209296'
        WHEN ${TABLE}.product_from_location = 'Asia Pacific (Tokyo)' THEN '139.691706'
        WHEN ${TABLE}.product_from_location = 'Australia' THEN '133.775136'
        WHEN ${TABLE}.product_from_location = 'Canada' THEN '-106.346771'
        WHEN ${TABLE}.product_from_location = 'Canada (Central)' THEN '-106.346771'
        WHEN ${TABLE}.product_from_location = 'EU (Frankfurt)' THEN '8.682127'
        WHEN ${TABLE}.product_from_location = 'EU (Ireland)' THEN '-7.692054'
        WHEN ${TABLE}.product_from_location = 'India' THEN '78.962880'
        WHEN ${TABLE}.product_from_location = 'Japan' THEN '138.252924'
        WHEN ${TABLE}.product_from_location = 'South America (Sao Paulo)' THEN '-46.633309'
        WHEN ${TABLE}.product_from_location = 'South America' THEN '-46.633309'
        WHEN ${TABLE}.product_from_location = 'US East (N. Virginia)' THEN '-78.656894'
        WHEN ${TABLE}.product_from_location = 'US East (Ohio)' THEN '-82.907123'
        WHEN ${TABLE}.product_from_location = 'US West (N. California)' THEN '-120.895824'
        WHEN ${TABLE}.product_from_location = 'US West (Oregon)' THEN '-120.554201'
        ELSE 'Not labeled'
        END
        ;;
  }


  dimension: to_location_lat {
    hidden: yes
    type: string
    sql: CASE
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Mumbai)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Mumbai)' THEN '19.075984'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Seoul)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Seoul)' THEN '37.566535'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Singapore)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Singapore)' THEN '1.352083'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Sydney)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Sydney)' THEN '-33.868820'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Tokyo)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Tokyo)' THEN '35.689487'
          WHEN ${TABLE}.product_to_location = 'Australia' OR ${TABLE}.product_tolocationtype = 'Australia' THEN '-25.274398'
          WHEN ${TABLE}.product_to_location = 'Canada' OR ${TABLE}.product_tolocationtype = 'Canada' THEN '56.130366'
          WHEN ${TABLE}.product_to_location = 'Canada (Central)' OR ${TABLE}.product_tolocationtype = 'Canada (Central)' THEN '56.130366'
          WHEN ${TABLE}.product_to_location = 'EU (Frankfurt)' OR ${TABLE}.product_tolocationtype = 'EU (Frankfurt)' THEN '50.110922'
          WHEN ${TABLE}.product_to_location = 'EU (Ireland)' OR ${TABLE}.product_tolocationtype = 'EU (Ireland)' THEN '53.142367'
          WHEN ${TABLE}.product_to_location = 'India' OR ${TABLE}.product_tolocationtype = 'India' THEN  '20.593684'
          WHEN ${TABLE}.product_to_location = 'Japan' OR ${TABLE}.product_tolocationtype = 'Japan' THEN '36.204824'
          WHEN ${TABLE}.product_to_location = 'South America (Sao Paulo)' OR ${TABLE}.product_tolocationtype = 'South America (Sao Paulo)' THEN '-23.550520'
          WHEN ${TABLE}.product_to_location = 'South America' OR ${TABLE}.product_tolocationtype = 'South America' THEN  '-23.550520'
          WHEN ${TABLE}.product_to_location = 'US East (N. Virginia)' OR ${TABLE}.product_tolocationtype = 'US East (N. Virginia)' THEN '37.431573'
          WHEN ${TABLE}.product_to_location = 'US East (Ohio)' OR ${TABLE}.product_tolocationtype = 'US East (Ohio)' THEN '40.417287'
          WHEN ${TABLE}.product_to_location = 'US West (N. California)' OR ${TABLE}.product_tolocationtype = 'US West (N. California)' THEN '38.837522'
          WHEN ${TABLE}.product_to_location = 'US WEST (Oregon)' OR ${TABLE}.product_tolocationtype = 'US WEST (Oregon)' THEN '43.804133'
          ELSE 'Not labeled'
          END
              ;;
  }

  dimension: to_location_long {
    description: "Should ONLY be used for visualization purposes"
    hidden: yes
    type: string
    sql: CASE
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Mumbai)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Mumbai)' THEN '72.877656'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Seoul)' OR  ${TABLE}.product_tolocationtype = 'Asia Pacific (Seoul)' THEN '126.977969'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Singapore)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Singapore)' THEN '103.819836'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Sydney)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Sydney)' THEN '151.209296'
          WHEN ${TABLE}.product_to_location = 'Asia Pacific (Tokyo)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Tokyo)' THEN '139.691706'
          WHEN ${TABLE}.product_to_location = 'Australia' OR ${TABLE}.product_tolocationtype = 'Australia' THEN '133.775136'
          WHEN ${TABLE}.product_to_location = 'Canada' OR ${TABLE}.product_tolocationtype  = 'Canada' THEN  '-106.346771'
          WHEN ${TABLE}.product_to_location = 'Canada (Central)' OR ${TABLE}.product_tolocationtype = 'Canada (Central)' THEN '-106.346771'
          WHEN ${TABLE}.product_to_location = 'EU (Frankfurt)' OR ${TABLE}.product_tolocationtype = 'EU (Frankfurt)' THEN '8.682127'
          WHEN ${TABLE}.product_to_location = 'EU (Ireland)' OR ${TABLE}.product_tolocationtype = 'EU (Ireland)' THEN '-7.692054'
          WHEN ${TABLE}.product_to_location = 'India' OR ${TABLE}.product_tolocationtype = 'India' THEN '78.962880'
          WHEN ${TABLE}.product_to_location = 'Japan' OR ${TABLE}.product_tolocationtype = 'Japan' THEN '138.252924'
          WHEN ${TABLE}.product_to_location = 'South America (Sao Paulo)' OR ${TABLE}.product_tolocationtype = 'South America (Sao Paulo)' THEN '-46.633309'
          WHEN ${TABLE}.product_to_location = 'South America' OR ${TABLE}.product_tolocationtype = 'South America' THEN '-46.633309'
          WHEN ${TABLE}.product_to_location = 'US East (N. Virginia)' OR ${TABLE}.product_tolocationtype = 'US East (N. Virginia)' THEN '-78.656894'
          WHEN ${TABLE}.product_to_location = 'US East (Ohio)' OR ${TABLE}.product_tolocationtype = 'US East (Ohio)' THEN '-82.907123'
          WHEN ${TABLE}.product_to_location = 'US West (N. California)' OR ${TABLE}.product_tolocationtype = 'US West (N. California)' THEN '-120.895824'
          WHEN ${TABLE}.product_to_location = 'US West (Oregon)' OR ${TABLE}.product_tolocationtype = 'US West (Oregon)' THEN '-120.554201'
          ELSE 'Not labeled'
          END
              ;;
  }

  dimension: product_from_location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_from_location_type ;;
  }

  dimension: product_group {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_group ;;
  }

  dimension: group_description {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_group_description ;;
  }

  dimension: product_included_services {
    type: string
    hidden: yes
    sql: ${TABLE}.product_included_services ;;
  }

  dimension: product_instance_family {
    type: string
    hidden: yes
    sql: ${TABLE}.product_instance_family ;;
  }

  dimension: product_instance_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_instance_type ;;
  }

  dimension: product_io {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_io ;;
  }

  dimension: product_launch_support {
    type: string
    hidden: yes
    sql: ${TABLE}.product_launch_support ;;
  }

  dimension: product_license_model {
    type: string
    hidden: yes
    sql: ${TABLE}.product_license_model ;;
  }

  dimension: location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_location ;;
  }

  dimension: location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_location_type ;;
  }

  dimension: product_maximum_storage_volume {
    type: string
    hidden: yes
    sql: ${TABLE}.product_maximum_storage_volume ;;
  }
  dimension: product_max_iops_burst_performance {
    type: string
    hidden: yes
    sql: ${TABLE}.product_max_iops_burst_performance ;;
  }

  dimension: product_max_throughputvolume {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_max_throughputvolume ;;
  }

  dimension: product_max_volume_size {
    type: string
    hidden: yes
    sql: ${TABLE}.product_max_volume_size ;;
  }

  dimension: product_memory {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_memory ;;
  }

  dimension: product_message_delivery_frequency {
    type: string
    hidden: yes
    sql: ${TABLE}.product_message_delivery_frequency ;;
  }

  dimension: product_message_delivery_order {
    type: string
    hidden: yes
    sql: ${TABLE}.product_message_delivery_order ;;
  }

  dimension: product_minimum_storage_volume {
    type: string
    hidden: yes
    sql: ${TABLE}.product_minimum_storage_volume ;;
  }

  dimension: product_min_volume_size {
    type: string
    hidden: yes
    sql: ${TABLE}.product_min_volume_size ;;
  }

  dimension: network_performance {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_network_performance ;;
  }

  dimension: product_operation {
    label: "Operation"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_operation ;;
  }

  dimension: product_operations_support {
    type: string
    hidden: yes
    sql: ${TABLE}.product_operations_support ;;
  }

  dimension: product_physical_processor {
    type: string
    hidden: yes
    sql: ${TABLE}.product_physical_processor ;;
  }

  dimension: product_pre_installed_sw {
    type: string
    hidden: yes
    sql: ${TABLE}.product_pre_installed_sw ;;
  }

  dimension: product_proactive_guidance {
    type: string
    hidden: yes
    sql: ${TABLE}.product_proactive_guidance ;;
  }

  dimension: product_processor_architecture {
    type: string
    hidden: yes
    sql: ${TABLE}.product_processor_architecture ;;
  }

  dimension: product_processor_features {
    type: string
    hidden: yes
    sql: ${TABLE}.product_processor_features ;;
  }

  dimension: product_product_family {
    label: "Family"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_product_family ;;
  }

  ##### Innaccurate labeling on part of AWS - use product code instead #####

  dimension: product_product_name {
    view_label: "Product Info"
    description: "Innaccurate labeling on part of AWS - use product code instead"
    type: string
    hidden: yes
    sql: ${TABLE}.product_product_name ;;
  }

  #####

  dimension: product_programmatic_case_management {
    type: string
    hidden: yes
    sql: ${TABLE}.product_programmatic_case_management ;;
  }

  dimension: product_provisioned {
    type: string
    hidden: yes
    sql: ${TABLE}.product_provisioned ;;
  }

  dimension: product_queue_type {
    type: string
    hidden: yes
    sql: ${TABLE}.product_queue_type ;;
  }

  dimension: product_request_description {
    type: string
    hidden: yes
    sql: ${TABLE}.product_request_description ;;
  }

  dimension: product_request_type {
    type: string
    hidden: yes
    sql: ${TABLE}.product_request_type ;;
  }

  dimension: product_routing_target {
    type: string
    hidden: yes
    sql: ${TABLE}.product_routing_target ;;
  }

  dimension: product_routing_type {
    type: string
    hidden: yes
    sql: ${TABLE}.product_routing_type ;;
  }

  dimension: product_servicecode {
    type: string
    hidden: yes
    sql: ${TABLE}.product_servicecode ;;
  }

  dimension: product_sku {
    type: string
    hidden: yes
    sql: ${TABLE}.product_sku ;;
  }

  dimension: product_software_type {
    type: string
    hidden: yes
    sql: ${TABLE}.product_software_type ;;
  }

  dimension: product_storage {
    type: string
    hidden: yes
    sql: ${TABLE}.product_storage ;;
  }

  dimension: product_storage_class {
    type: string
    hidden: yes
    sql: ${TABLE}.product_storage_class ;;
  }

  dimension: product_storage_media {
    type: string
    hidden: yes
    sql: ${TABLE}.product_storage_media ;;
  }

  dimension: product_technical_support {
    type: string
    hidden: yes
    sql: ${TABLE}.product_technical_support ;;
  }

  dimension: product_tenancy {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_tenancy ;;
  }

  dimension: product_thirdparty_software_support {
    type: string
    hidden: yes
    sql: ${TABLE}.product_thirdparty_software_support ;;
  }

  dimension: to_location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_to_location ;;
  }

  dimension: to_location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_to_location_type ;;
  }

  dimension: training {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_training ;;
  }

  dimension: transfer_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_transfer_type ;;
  }

  dimension: usage_family {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_usage_family ;;
  }

  dimension: data_transfer {
    view_label: "Line Items (Individual Charges)"
    type: yesno
    sql: REGEXP_LIKE(${product_usagetype}, 'DataTransfer')   ;;
  }

  dimension: data_transfer_outbound {
    view_label: "Line Items (Individual Charges)"
    type: yesno
    sql: REGEXP_LIKE(${product_usagetype}, 'DataTransfer-Out')   ;;
  }

  dimension: data_transfer_inbound {
    view_label: "Line Items (Individual Charges)"
    type: yesno
    sql: REGEXP_LIKE(${product_usagetype}, 'DataTransfer-In')   ;;
  }

  dimension: product_usagetype {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_usagetype ;;
  }

  dimension: product_vcpu {
    type: string
    hidden: yes
    sql: ${TABLE}.product_vcpu ;;
  }

  dimension: product_version {
    type: string
    hidden: yes
    sql: ${TABLE}.product_version ;;
  }

  dimension: product_volume_type {
    type: string
    hidden: yes
    sql: ${TABLE}.product_volume_type ;;
  }

  dimension: product_who_can_open_cases {
    type: string
    hidden: yes
    sql: ${TABLE}.product_who_can_open_cases ;;
  }

  dimension: pricing_lease_contract_length {
    type: string
    hidden: yes
    sql: ${TABLE}.pricing_lease_contract_length ;;
  }

  dimension: pricing_offering_class {
    type: string
    hidden: yes
    sql: ${TABLE}.product_storage_class ;;
  }

  dimension: pricing_purchase_option {
    type: string
    hidden: yes
    sql: ${TABLE}.pricing_purchase_option ;;
  }

  dimension: pricing_public_on_demand_cost {
    type: string
    hidden: yes
    sql: ${TABLE}.pricing_public_on_demand_cost ;;
  }

  dimension: pricing_public_on_demand_rate {
    type: string
    hidden: yes
    sql: ${TABLE}.pricing_public_on_demand_rate ;;
  }

  dimension: pricing_term {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_term ;;
  }

  dimension: pricing_unit {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_unit ;;
  }

  dimension: reservation_availability_zone {
    type: string
    hidden: yes
    sql: ${TABLE}.reservation_availability_zone ;;
  }

  dimension: reservation_units_per_reservation {
    type: string
    hidden: yes
    sql: ${TABLE}.reservation_normalizedunitsperreservation ;;
  }

  dimension: reservation_number_of_reservations {
    type: number
    hidden: yes
    sql: ${TABLE}.reservation_number_of_reservations ;;
  }

  dimension: reservation_arn {
    view_label: "Reserved Units"
    description: "When an RI benefit discount is applied to a matching line item of usage, the ARN value in the reservation/ReservationARN column for the initial upfront fees and recurring monthly charges matches the ARN value in the discounted usage line items."
    type: string
    sql: ${TABLE}.reservation_reservation_arn ;;
  }

  dimension: reservation_total_reserved_normalized_units {
    type: string
    hidden: yes
    sql: ${TABLE}.reservation_totalreservednormalizedunits ;;
  }

  dimension: reservation_total_reserved_units {
    view_label: "Reserved Units"
    description: "The total number of total number of hours across all reserved instances in the subscription."
    type: number
    hidden: yes
    sql: ${TABLE}.reservation_total_reserved_units ;;
  }

  ##### ENABLE FOR CUSTOM TAGS #####

  dimension: resource_tags_aws_created_by {
    type: string
    sql: ${TABLE}.resource_tags_aws_created_by ;;
  }

  dimension: resource_tags_user_business {
    type: string
    sql: ${TABLE}.resource_tags_user_business ;;
  }

  dimension: resource_tags_user_environment {
    type: string
    sql: ${TABLE}.resource_tags_user_environment ;;
  }

  dimension: resource_tags_user_product {
    type: string
    sql: ${TABLE}.resource_tags_user_product ;;
  }

  dimension: resource_tags_user_team {
    type: string
    sql: ${TABLE}.resource_tags_user_team ;;
  }

  #####

  measure: count_line_items {
    view_label: "Line Items (Individual Charges)"
    type: count
  }

  ##### LINE ITEM AGGREGATIONS #####

  measure: total_unblended_cost {
    view_label: "Line Items (Individual Charges)"
    description: "The cost of all aggregated line items after tiered pricing and discounted usage have been processed."
    type: sum
    sql: ${line_item_unblended_cost} ;;
    value_format_name: usd_0
  }

  measure: average_unblended_rate {
    label: "Unblended Rate"
    view_label: "Line Items (Individual Charges)"
    description: "The average cost of all aggregated line items after tiered pricing and discounted usage have been processed."
    type: average
    sql: ${line_item_unblended_rate} ;;
    value_format_name: usd_0
  }

  measure: total_blended_cost {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    drill_fields: [common*, total_blended_cost,  total_measures*]
  }

  measure: total_data_transfer_cost {
    view_label: "Line Items (Individual Charges)"
    description: "Total charges for data transfers"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: data_transfer
      value: "Yes"
    }
    drill_fields: [common*, total_data_transfer_cost,  total_measures*]
  }

  measure: total_data_transfer_cost_unblended {
    view_label: "Line Items (Individual Charges)"
    description: "Total charges for data transfers"
    type: sum
    sql: ${line_item_unblended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: data_transfer
      value: "Yes"
    }
    drill_fields: [common*, total_data_transfer_cost_unblended,  total_measures*]
  }

  measure: total_outbound_data_transfer_cost {
    view_label: "Line Items (Individual Charges)"
    description: "Total charges for data transfers"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: data_transfer_outbound
      value: "Yes"
    }
    drill_fields: [common*, total_outbound_data_transfer_cost, inbound_outbound*]
  }


  measure: total_inbound_data_transfer_cost {
    view_label: "Line Items (Individual Charges)"
    description: "Total charges for data transfers"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: data_transfer_inbound
      value: "Yes"
    }
    drill_fields: [common*, total_inbound_data_transfer_cost, inbound_outbound*]
  }

  measure: total_reserved_blended_cost {
    view_label: "Reserved Units"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${line_item_blended_cost};;
    value_format_name: usd_0
    filters: {
      field: ri_line_item
      value: "RI Line Item"
    }
    drill_fields: [common*, total_reserved_blended_cost]
  }

  measure: total_non_reserved_blended_cost {
    view_label: "Reserved Units"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: ri_line_item
      value: "Non RI Line Item"
    }
    drill_fields: [common*, total_non_reserved_blended_cost]
  }

  measure: total_non_reserved_unblended_cost {
    view_label: "Reserved Units"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${line_item_unblended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: ri_line_item
      value: "Non RI Line Item"
    }
    drill_fields: [common*, total_non_reserved_unblended_cost]
  }

  measure: percent_spend_on_non_ris{
    view_label: "Reserved Units"
    type: number
    sql: 1.0 * ${total_non_reserved_blended_cost} / NULLIF(${total_blended_cost},0) ;;
    link: {
      label: "Explore Non Reserved Blended Cost"
      url: "{{total_non_reserved_blended_cost._link}}"
    }
    link: {
      label: "Explore Total Blended Cost"
      url: "{{total_blended_cost._link}}"
    }
    value_format_name: percent_2
  }

  measure: percent_spend_on_ris{
    view_label: "Reserved Units"
    label: "Blended RI Coverage"
    type: number
    sql: 1.0 * ${total_reserved_blended_cost} / NULLIF(${total_blended_cost},0) ;;
    value_format_name: percent_2
    link: {
      label: "Explore Reserved Blended Cost"
      url: "{{total_reserved_blended_cost._link}}"
    }
    link: {
      label: "Explore Total Blended Cost"
      url: "{{total_blended_cost._link}}"
    }
  }

  measure: unblended_percent_spend_on_ris{
    view_label: "Reserved Units"
    label: "Unblended RI Coverage"
    type: number
    sql: 1.0 * ${total_non_reserved_unblended_cost} / NULLIF(${total_unblended_cost},0) ;;
    value_format_name: percent_2
    link: {
      label: "Explore Non Reserved Unblended Cost"
      url: "{{total_non_reserved_unblended_cost._link}}"
    }
    link: {
      label: "Explore Total Blended Cost"
      url: "{{total_blended_cost._link}}"
    }
  }

  measure: percent_spend_data_transfers_unblended {
    view_label: "Reserved Units"
    label: "Unblended Data Transfer Cost Percent"
    type: number
    sql: 1.0 * ${total_data_transfer_cost_unblended} / NULLIF(${total_unblended_cost},0) ;;
    value_format_name: percent_2
    link: {
      label: "Explore Data Transfer Unblended Cost"
      url: "{{total_data_transfer_cost_unblended._link}}"
    }
    link: {
      label: "Explore Total Blended Cost"
      url: "{{total_blended_cost._link}}"
    }
  }

  measure: count_usage_months {
  type: count_distinct
  sql: ${line_item_usage_start_month} ;;
  drill_fields: [bill_billing_period_start_month, total_measures*]
}

  measure: average_blended_cost_all_time {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: average
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd
    drill_fields: [common*, basic_blended_measures*]
  }

  measure: average_blended_cost_per_month {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: number
    sql: ${total_blended_cost}/NULLIF(${count_usage_months},0) ;;
    value_format_name: usd_0
    link: {
      label: "Explore Total Blended Cost"
      url: "{{total_blended_cost._link}}"
    }
    link: {
      label: "Explore Months"
      url: "{{count_usage_months._link}}"
    }
  }

  measure: average_blended_rate {
    label: "Blended Rate"
    view_label: "Line Items (Individual Charges)"
    description: "The average rate applied to all aggregated line items for a consolidated billing account in an organization."
    type: average
    sql: ${line_item_blended_rate} ;;
    value_format_name: usd
    drill_fields: [common*, basic_blended_measures*]
  }

  measure: total_usage_amount {
    view_label: "Line Items (Individual Charges)"
    description: "The amount of usage incurred by the customer. For all reserved units, use the Total Reserved Units column instead."
    type: sum
    sql: ${line_item_usage_amount} ;;
    value_format_name: decimal_0
    drill_fields: [common*, basic_blended_measures*]
  }

  #####

  ### PRODUCT SPECIFIC COST MEASURES ###

  measure: EC2_usage_amount {
    label: "EC2 Usage Amount"
    view_label: "Product Info"
    type: sum
    sql: ${line_item_usage_amount} ;;
    filters: {
      field: line_item_product_code
      value: "AmazonEC2"
    }
    drill_fields: [common*, EC2_usage_amount, ec2_measures*]
  }

  measure: cloudfront_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_usage_amount} ;;
    filters: {
      field: line_item_product_code
      value: "AmazonCloudFront"
    }
    drill_fields: [common*, cloudfront_usage_amount]
  }

  measure: cloudtrail_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_usage_amount} ;;
    filters: {
      field: line_item_product_code
      value: "AWSCloudTrail"
    }
    drill_fields: [common*, cloudtrail_usage_amount]
  }
  measure: S3_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_usage_amount} ;;
    filters: {
      field: line_item_product_code
      value: "AmazonS3"
    }
    drill_fields: [common*, S3_usage_amount]
  }

  measure: redshift_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_usage_amount} ;;
    filters: {
      field: line_item_product_code
      value: "AmazonRedshift"
    }
    drill_fields: [common*, redshift_usage_amount]
  }

  measure: rds_usage_amount {
    label: "RDS Usage Amount"
    view_label: "Product Info"
    type: sum
    sql: ${line_item_usage_amount} ;;
    filters: {
      field: line_item_product_code
      value: "AmazonRDS"
    }
    drill_fields: [common*, rds_usage_amount]
  }

  measure: EC2_blended_cost {
    label: "EC2 Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AmazonEC2"
    }
    drill_fields: [common*, EC2_blended_cost, ec2_measures*]
  }

  measure: EC2_reserved_blended_cost {
    label: "EC2 Reserved Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AmazonEC2"
    }
    filters: {
      field: ri_line_item
      value: "RI Line Item"
    }
    drill_fields: [common*, EC2_reserved_blended_cost, ec2_measures*]
  }

  measure: EC2_non_reserved_blended_cost {
    label: "EC2 Non Reserved Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AmazonEC2"
    }
    filters: {
      field: ri_line_item
      value: "Non RI Line Item"
    }
    drill_fields: [common*, EC2_non_reserved_blended_cost, ec2_measures*]
  }

  measure: cloudfront_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AmazonCloudFront"
    }
    drill_fields: [common*, cloudtrail_blended_cost]
  }

  measure: cloudtrail_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AWSCloudTrail"
    }
    drill_fields: [common*, cloudtrail_blended_cost]
  }
  measure: S3_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AmazonS3"
    }
    drill_fields: [common*, S3_blended_cost]
  }

  measure: redshift_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AmazonRedshift"
    }
    drill_fields: [common*, redshift_blended_cost]
  }

  measure: rds_blended_cost {
    label: "RDS Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${line_item_blended_cost} ;;
    value_format_name: usd_0
    filters: {
      field: line_item_product_code
      value: "AmazonRDS"
    }
    drill_fields: [common*, rds_blended_cost]
  }

  #####

  ##### RESERVED UNIT AGGREGATIONS #####

  measure: number_of_reservations {
    view_label: "Reserved Units"
    description: "The number of reservations covered by this subscription. For example, one Reserved Instance (RI) subscription may have four associated RI reservations."
    type: sum
    sql: ${reservation_number_of_reservations} ;;
    drill_fields: [common*, number_of_reservations, total_measures*]
  }

  ##### UNTIL DISCREPENCY IS RESOLVED, USING A MANUAL CALCULATION

  measure: total_reserved_units_usage {
    label: "Total Reserved Unit Usage (Hours Used)"
    view_label: "Reserved Units"
    description: "The total number of hours across all reserved instances in the subscription."
    type: number
    sql: (COALESCE(SUM(cost_and_usage_raw.reservation_numberofreservations),0) * COALESCE(SUM(cost_and_usage_raw.reservation_normalizedunitsperreservation),0 ) );;
    drill_fields: [common*, total_reserved_units_usage, total_measures*]
  }

  measure: total_normalized_reserved_units {
    view_label: "Reserved Units"
    description: "The value for Usage Amount multiplied by the value for Normalization Factor"
    type: sum
    sql: ${reservation_total_reserved_normalized_units} ;;
    drill_fields: [common*, total_normalized_reserved_units, total_measures*]
  }

  measure: units_per_reservation {
    label: "Units per Reservation (Hours Reserved)"
    view_label: "Reserved Units"
    description: "The number of usage units reserved by a single reservation in a given subscription, such as how many hours a single Amazon EC2 RI has reserved."
    type: sum
    sql: ${reservation_units_per_reservation} ;;
    drill_fields: [common*, units_per_reservation, total_measures*]
  }

  set: common {fields: [line_item_resource_id, line_item_operation, type, bill_payer_account_id, line_item_line_item_description]}
  set: total_measures {fields: [total_data_transfer_cost_unblended, total_data_transfer_cost, total_blended_cost, total_unblended_cost]  }
  set: inbound_outbound {fields: [total_data_transfer_cost_unblended, total_data_transfer_cost, total_outbound_data_transfer_cost, total_inbound_data_transfer_cost]}
  set: basic_blended_measures {fields: [average_blended_cost_per_month, average_blended_rate, total_usage_amount]}
  set: ec2_measures {fields: [EC2_blended_cost,EC2_reserved_blended_cost,EC2_non_reserved_blended_cost,EC2_usage_amount]}

  #####
}
