view: cost_and_usage {
  sql_table_name: aws_billing_report.my_cur_report ;;
  suggestions: no

  dimension: bill_billing_entity {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_billingentity ;;
  }

  dimension_group: billing_period_end {
    view_label: "Billing Info"
    type: time
    timeframes: [time,date,week,month,year]
    sql: from_iso8601_timestamp(${TABLE}.bill_billingperiodenddate);;
  }

  dimension_group: billing_period_start {
    view_label: "Billing Info"
    type: time
    timeframes: [time,date,week,month,year]
    sql: from_iso8601_timestamp(${TABLE}.bill_billingperiodstartdate) ;;
  }


  dimension: billtype {
    label: "Type"
    view_label: "Billing Info"
    type: string
    sql: ${TABLE}.bill_billtype ;;
  }

  dimension: bill_invoiceid {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_invoiceid ;;
  }

  dimension: bill_payeraccountid {
    type: string
    hidden: yes
    sql: ${TABLE}.bill_payeraccountid ;;
  }

  dimension: identity_lineitemid {
    type: string
    hidden: yes
    sql: ${TABLE}.identity_lineitemid ;;
  }

  dimension: identity_timeinterval {
    type: string
    hidden: yes
    sql: ${TABLE}.identity_timeinterval ;;
  }

  dimension: lineitem_availabilityzone {
    type: string
    hidden: yes
    sql: ${TABLE}.lineitem_availabilityzone ;;
  }

  dimension: lineitem_blendedcost {
    hidden: yes
    type: number
    sql: CAST(${TABLE}.lineitem_blendedcost as double) ;;
  }

  dimension: blended_rate {
    view_label: "Line Items (Individual Charges)"
    description: "The rate applied to this line item for a consolidated billing account in an organization."
    type: number
    sql: ${TABLE}.lineitem_blendedrate ;;
  }

  dimension: lineitem_currencycode {
    label: "Currency Code"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.lineitem_currencycode ;;
  }

  dimension: description {
    view_label: "Line Items (Individual Charges)"
    description: "A description of the pricing tier covered by this line item"
    type: string
    sql: ${TABLE}.lineitem_lineitemdescription ;;
  }


#### TYPES OF CHARGES ####

  dimension: type {
    view_label: "Line Items (Individual Charges)"
    description: "Fee is one-time RI expense for all-upfront or partial-upfront. RI Fee is recurring RI expense for partial-upfront and no-upfront RI expenses."
    type: string
    sql: ${TABLE}.lineitem_lineitemtype ;;
  }

  dimension: type_ri_fee_upfront {
    view_label: "Reserved Units"
    description: "Fee is one-time RI expense for all-upfront or partial-upfront."
    type: string
    sql: CASE WHEN ${TABLE}.lineitem_lineitemtype = 'Fee' THEN 'Fee' ELSE 'Other' END ;;
  }

  dimension: type_ri_fee_on_demand {
    view_label: "Reserved Units"
    description: "RI Fee is recurring RI expense for partial-upfront and no-upfront RI expenses."
    type: string
    sql: CASE WHEN ${TABLE}.lineitem_lineitemtype = 'RIFee' THEN 'RI Fee' ELSE 'Other' END ;;
  }

  dimension: type_discounted_usage {
    view_label: "Reserved Units"
    description: "Describes the instance usage that recieved a matching RI discount benefit. It is added to the bill once a reserved instance experiences usage. Cost will always be zero because it's been accounted for with Fee and RI Fee."
    type: string
    sql: CASE WHEN ${TABLE}.lineitem_lineitemtype = 'DiscountedUsage' THEN 'Discounted Usage' ELSE 'Other' END ;;
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

  dimension: normalization_factor {
    view_label: "Line Items (Individual Charges)"
    description: "Degree of instance size flexibility provided by RIs"
    type: number
    sql: ${TABLE}.lineitem_normalizationfactor ;;
  }

  dimension: lineitem_normalizedusageamount {
    hidden: yes
    type: number
    sql: ${TABLE}.lineitem_normalizedusageamount ;;
  }

  dimension: line_item_operation {
    label: "Operation"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.lineitem_operation ;;
  }

  dimension: product_code {
    description: "The AWS product/service being used"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.lineitem_productcode ;;
  }

  dimension: lineitem_resourceid {
    type: string
    hidden: no
    sql: ${TABLE}.lineitem_resourceid ;;
    tags: ["aws_resource_id"]
  }

  dimension: lineitem_taxtype {
    label: "Tax Type"
    view_label: "Line Items (Individual Charges)"
    type: string
    sql: ${TABLE}.lineitem_taxtype ;;
  }

  dimension: lineitem_unblendedcost {
    type: number
    hidden: yes
    sql: CAST(${TABLE}.lineitem_unblendedcost as double) ;;
  }

  dimension: unblended_rate {
    view_label: "Line Items (Individual Charges)"
    description: "The rate that this line item would have been charged for an unconsolidated account."
    type: number
    sql: ${TABLE}.lineitem_unblendedrate ;;
  }

  dimension: lineitem_usageaccountid {
    view_label: "Line Items (Individual Charges)"
    label: "Account ID"
    description: "RIs can span multiple accounts - this dimensions related to usage"
    type: string
    # hidden: yes
    sql: ${TABLE}.lineitem_usageaccountid ;;
  }

  dimension: lineitem_usageamount {
    type: number
    hidden: yes
    sql: ${TABLE}.lineitem_usageamount ;;
  }

  dimension_group: usage_end {
    view_label: "Line Items (Individual Charges)"
    type: time
    timeframes: [raw, time,time_of_day,hour,date,week,day_of_week,month,month_name,year]
    sql: from_iso8601_timestamp(${TABLE}.lineitem_usageenddate) ;;
  }

  dimension_group: usage_start {
    view_label: "Line Items (Individual Charges)"
    type: time
    timeframes: [raw, time,time_of_day,hour,date,week,day_of_week,month,month_name,year]
    sql: from_iso8601_timestamp(${TABLE}.lineitem_usagestartdate);;
  }

  dimension: usage_hours {
    view_label: "Line Items (Individual Charges)"
    sql: date_diff('hour', ${usage_start_raw}, ${usage_end_raw}) ;;
  }

  measure: total_usage_hours {
    view_label: "Billing Info"
    type: sum
    sql: ${usage_hours} ;;
  }


  dimension: lineitem_usagetype {
    label: "Usage Type"
    view_label: "Line Items (Individual Charges)"
    description: "The type of usage covered by this line item. If you paid for a Reserved Instance, the report has one line that shows the monthly committed cost, and multiple lines that show a charge of 0."
    type: string
    sql: ${TABLE}.lineitem_usagetype ;;
  }

  dimension: product_accountassistance {
    label: "Account Assistance"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_accountassistance ;;
  }

  dimension: product_architecturalreview {
    label: "Architecture Review"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_architecturalreview ;;
  }

  dimension: product_architecturesupport {
    label: "Architecture Support"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_architecturesupport ;;
  }

  dimension: product_availability {
    label: "Availability"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_availability ;;
  }

  dimension: product_bestpractices {
    hidden: yes
    type: string
    sql: ${TABLE}.product_bestpractices ;;
  }

  dimension: product_cacheengine {
    hidden: yes
    type: string
    sql: ${TABLE}.product_cacheengine ;;
  }

  dimension: product_caseseverityresponsetimes {
    hidden: yes
    type: string
    sql: ${TABLE}.product_caseseverityresponsetimes ;;
  }

  dimension: product_clockspeed {
    hidden: yes
    type: string
    sql: ${TABLE}.product_clockspeed ;;
  }

  dimension: product_currentgeneration {
    hidden: yes
    type: string
    sql: ${TABLE}.product_currentgeneration ;;
  }

  dimension: product_customerserviceandcommunities {
    hidden: yes
    type: string
    sql: ${TABLE}.product_customerserviceandcommunities ;;
  }

  dimension: product_databaseedition {
    label: "Database Edition"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_databaseedition ;;
  }

  dimension: product_databaseengine {
    label: "Database Engine"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_databaseengine ;;
  }

  dimension: product_dedicatedebsthroughput {
    label: "Dedicated EBS Throughput"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_dedicatedebsthroughput ;;
  }

  dimension: product_deploymentoption {
    view_label: "Product Info"
    hidden: yes
    type: string
    sql: ${TABLE}.product_deploymentoption ;;
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

  dimension: product_ebsoptimized {
    hidden: yes
    type: string
    sql: ${TABLE}.product_ebsoptimized ;;
  }

  dimension: product_ecu {
    hidden: yes
    type: string
    sql: ${TABLE}.product_ecu ;;
  }

  dimension: endpoint_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_endpointtype ;;
  }

  dimension: engine_code {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_enginecode ;;
  }

  dimension: product_enhancednetworkingsupported {
    view_label: "Product Info"
    hidden: yes
    type: string
    sql: ${TABLE}.product_enhancednetworkingsupported ;;
  }

  dimension: execution_frequency {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_executionfrequency ;;
  }

  dimension: execution_location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_executionlocation ;;
  }

  dimension: product_feecode {
    type: string
    hidden: yes
    sql: ${TABLE}.product_feecode ;;
  }

  dimension: product_feedescription {
    type: string
    hidden: yes
    sql: ${TABLE}.product_feedescription ;;
  }

  dimension: product_freequerytypes {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_freequerytypes ;;
  }

  dimension: free_trial {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_freetrial ;;
  }

  dimension: product_frequencymode {
    hidden: yes
    type: string
    sql: ${TABLE}.product_frequencymode ;;
  }

  dimension: from_location {
    view_label: "Product Info"
    type: string
#     map_layer_name: countries
    sql: ${TABLE}.product_fromlocation ;;
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
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Mumbai)' THEN '19.075984'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Seoul)' THEN '37.566535'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Singapore)' THEN '1.352083'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Sydney)' THEN '-33.868820'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Tokyo)' THEN '35.689487'
        WHEN ${TABLE}.product_fromlocation = 'Australia' THEN '-25.274398'
        WHEN ${TABLE}.product_fromlocation = 'Canada' THEN '56.130366'
        WHEN ${TABLE}.product_fromlocation = 'Canada (Central)' THEN '56.130366'
        WHEN ${TABLE}.product_fromlocation = 'EU (Frankfurt)' THEN '50.110922'
        WHEN ${TABLE}.product_fromlocation = 'EU (Ireland)' THEN '53.142367'
        WHEN ${TABLE}.product_fromlocation = 'India' THEN '20.593684'
        WHEN ${TABLE}.product_fromlocation = 'Japan' THEN '36.204824'
        WHEN ${TABLE}.product_fromlocation = 'South America (Sao Paulo)' THEN '-23.550520'
        WHEN ${TABLE}.product_fromlocation = 'South America' THEN '-23.550520'
        WHEN ${TABLE}.product_fromlocation = 'US East (N. Virginia)' THEN '37.431573'
        WHEN ${TABLE}.product_fromlocation = 'US East (Ohio)' THEN '40.417287'
        WHEN ${TABLE}.product_fromlocation = 'US West (N. California)' THEN '38.837522'
        WHEN ${TABLE}.product_fromlocation = 'US WEST (Oregon)' THEN '43.804133'
        ELSE 'Not labeled'
        END
        ;;
  }

  dimension: from_location_long {
    hidden: yes
    type: string
    sql: CASE
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Mumbai)' THEN '72.877656'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Seoul)' THEN '126.977969'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Singapore)' THEN '103.819836'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Sydney)' THEN '151.209296'
        WHEN ${TABLE}.product_fromlocation = 'Asia Pacific (Tokyo)' THEN '139.691706'
        WHEN ${TABLE}.product_fromlocation = 'Australia' THEN '133.775136'
        WHEN ${TABLE}.product_fromlocation = 'Canada' THEN '-106.346771'
        WHEN ${TABLE}.product_fromlocation = 'Canada (Central)' THEN '-106.346771'
        WHEN ${TABLE}.product_fromlocation = 'EU (Frankfurt)' THEN '8.682127'
        WHEN ${TABLE}.product_fromlocation = 'EU (Ireland)' THEN '-7.692054'
        WHEN ${TABLE}.product_fromlocation = 'India' THEN '78.962880'
        WHEN ${TABLE}.product_fromlocation = 'Japan' THEN '138.252924'
        WHEN ${TABLE}.product_fromlocation = 'South America (Sao Paulo)' THEN '-46.633309'
        WHEN ${TABLE}.product_fromlocation = 'South America' THEN '-46.633309'
        WHEN ${TABLE}.product_fromlocation = 'US East (N. Virginia)' THEN '-78.656894'
        WHEN ${TABLE}.product_fromlocation = 'US East (Ohio)' THEN '-82.907123'
        WHEN ${TABLE}.product_fromlocation = 'US West (N. California)' THEN '-120.895824'
        WHEN ${TABLE}.product_fromlocation = 'US West (Oregon)' THEN '-120.554201'
        ELSE 'Not labeled'
        END
        ;;
  }


  dimension: to_location_lat {
    hidden: yes
    type: string
    sql: CASE
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Mumbai)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Mumbai)' THEN '19.075984'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Seoul)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Seoul)' THEN '37.566535'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Singapore)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Singapore)' THEN '1.352083'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Sydney)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Sydney)' THEN '-33.868820'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Tokyo)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Tokyo)' THEN '35.689487'
    WHEN ${TABLE}.product_tolocation = 'Australia' OR ${TABLE}.product_tolocationtype = 'Australia' THEN '-25.274398'
    WHEN ${TABLE}.product_tolocation = 'Canada' OR ${TABLE}.product_tolocationtype = 'Canada' THEN '56.130366'
    WHEN ${TABLE}.product_tolocation = 'Canada (Central)' OR ${TABLE}.product_tolocationtype = 'Canada (Central)' THEN '56.130366'
    WHEN ${TABLE}.product_tolocation = 'EU (Frankfurt)' OR ${TABLE}.product_tolocationtype = 'EU (Frankfurt)' THEN '50.110922'
    WHEN ${TABLE}.product_tolocation = 'EU (Ireland)' OR ${TABLE}.product_tolocationtype = 'EU (Ireland)' THEN '53.142367'
    WHEN ${TABLE}.product_tolocation = 'India' OR ${TABLE}.product_tolocationtype = 'India' THEN  '20.593684'
    WHEN ${TABLE}.product_tolocation = 'Japan' OR ${TABLE}.product_tolocationtype = 'Japan' THEN '36.204824'
    WHEN ${TABLE}.product_tolocation = 'South America (Sao Paulo)' OR ${TABLE}.product_tolocationtype = 'South America (Sao Paulo)' THEN '-23.550520'
    WHEN ${TABLE}.product_tolocation = 'South America' OR ${TABLE}.product_tolocationtype = 'South America' THEN  '-23.550520'
    WHEN ${TABLE}.product_tolocation = 'US East (N. Virginia)' OR ${TABLE}.product_tolocationtype = 'US East (N. Virginia)' THEN '37.431573'
    WHEN ${TABLE}.product_tolocation = 'US East (Ohio)' OR ${TABLE}.product_tolocationtype = 'US East (Ohio)' THEN '40.417287'
    WHEN ${TABLE}.product_tolocation = 'US West (N. California)' OR ${TABLE}.product_tolocationtype = 'US West (N. California)' THEN '38.837522'
    WHEN ${TABLE}.product_tolocation = 'US WEST (Oregon)' OR ${TABLE}.product_tolocationtype = 'US WEST (Oregon)' THEN '43.804133'
    ELSE 'Not labeled'
    END
        ;;
  }

  dimension: to_location_long {
    description: "Should ONLY be used for visualization purposes"
    hidden: yes
    type: string
    sql: CASE
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Mumbai)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Mumbai)' THEN '72.877656'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Seoul)' OR  ${TABLE}.product_tolocationtype = 'Asia Pacific (Seoul)' THEN '126.977969'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Singapore)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Singapore)' THEN '103.819836'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Sydney)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Sydney)' THEN '151.209296'
    WHEN ${TABLE}.product_tolocation = 'Asia Pacific (Tokyo)' OR ${TABLE}.product_tolocationtype = 'Asia Pacific (Tokyo)' THEN '139.691706'
    WHEN ${TABLE}.product_tolocation = 'Australia' OR ${TABLE}.product_tolocationtype = 'Australia' THEN '133.775136'
    WHEN ${TABLE}.product_tolocation = 'Canada' OR ${TABLE}.product_tolocationtype  = 'Canada' THEN  '-106.346771'
    WHEN ${TABLE}.product_tolocation = 'Canada (Central)' OR ${TABLE}.product_tolocationtype = 'Canada (Central)' THEN '-106.346771'
    WHEN ${TABLE}.product_tolocation = 'EU (Frankfurt)' OR ${TABLE}.product_tolocationtype = 'EU (Frankfurt)' THEN '8.682127'
    WHEN ${TABLE}.product_tolocation = 'EU (Ireland)' OR ${TABLE}.product_tolocationtype = 'EU (Ireland)' THEN '-7.692054'
    WHEN ${TABLE}.product_tolocation = 'India' OR ${TABLE}.product_tolocationtype = 'India' THEN '78.962880'
    WHEN ${TABLE}.product_tolocation = 'Japan' OR ${TABLE}.product_tolocationtype = 'Japan' THEN '138.252924'
    WHEN ${TABLE}.product_tolocation = 'South America (Sao Paulo)' OR ${TABLE}.product_tolocationtype = 'South America (Sao Paulo)' THEN '-46.633309'
    WHEN ${TABLE}.product_tolocation = 'South America' OR ${TABLE}.product_tolocationtype = 'South America' THEN '-46.633309'
    WHEN ${TABLE}.product_tolocation = 'US East (N. Virginia)' OR ${TABLE}.product_tolocationtype = 'US East (N. Virginia)' THEN '-78.656894'
    WHEN ${TABLE}.product_tolocation = 'US East (Ohio)' OR ${TABLE}.product_tolocationtype = 'US East (Ohio)' THEN '-82.907123'
    WHEN ${TABLE}.product_tolocation = 'US West (N. California)' OR ${TABLE}.product_tolocationtype = 'US West (N. California)' THEN '-120.895824'
    WHEN ${TABLE}.product_tolocation = 'US West (Oregon)' OR ${TABLE}.product_tolocationtype = 'US West (Oregon)' THEN '-120.554201'
    ELSE 'Not labeled'
    END
        ;;
  }

  dimension: from_location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_fromlocationtype ;;
  }

  dimension: product_group {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_group ;;
  }

  dimension: group_description {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_groupdescription ;;
  }

  dimension: product_includedservices {
    hidden: yes
    type: string
    sql: ${TABLE}.product_includedservices ;;
  }

  dimension: product_instancefamily {
    type: string
    hidden: yes
    sql: ${TABLE}.product_instancefamily ;;
  }

  dimension: instance_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_instancetype ;;
  }

  dimension: product_io {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_io ;;
  }

  dimension: product_launchsupport {
    hidden: yes
    type: string
    sql: ${TABLE}.product_launchsupport ;;
  }

  dimension: product_licensemodel {
    hidden: yes
    type: string
    sql: ${TABLE}.product_licensemodel ;;
  }

  dimension: location {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_location ;;
  }

  dimension: location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_locationtype ;;
  }

  dimension: product_maximumstoragevolume {
    hidden: yes
    type: string
    sql: ${TABLE}.product_maximumstoragevolume ;;
  }

  dimension: product_maxiopsburstperformance {
    hidden: yes
    type: string
    sql: ${TABLE}.product_maxiopsburstperformance ;;
  }

  dimension: product_maxiopsvolume {
    hidden: yes
    type: string
    sql: ${TABLE}.product_maxiopsvolume ;;
  }

  dimension: max_throughput_volume {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_maxthroughputvolume ;;
  }

  dimension: product_maxvolumesize {
    type: string
    hidden: yes
    sql: ${TABLE}.product_maxvolumesize ;;
  }

  dimension: product_memory {
    type: string
    view_label: "Product Info"
    sql: ${TABLE}.product_memory ;;
  }

  dimension: product_messagedeliveryfrequency {
    type: string
    hidden: yes
    sql: ${TABLE}.product_messagedeliveryfrequency ;;
  }

  dimension: product_messagedeliveryorder {
    type: string
    hidden: yes
    sql: ${TABLE}.product_messagedeliveryorder ;;
  }

  dimension: product_minimumstoragevolume {
    type: string
    hidden: yes
    sql: ${TABLE}.product_minimumstoragevolume ;;
  }

  dimension: product_minvolumesize {
    hidden: yes
    type: string
    sql: ${TABLE}.product_minvolumesize ;;
  }

  dimension: network_performance {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_networkperformance ;;
  }

  dimension: operating_system {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_operatingsystem ;;
  }

  dimension: product_operation {
    label: "Operation"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_operation ;;
  }

  dimension: product_operationssupport {
    type: string
    hidden: yes
    sql: ${TABLE}.product_operationssupport ;;
  }

  dimension: product_physicalprocessor {
    type: string
    hidden: yes
    sql: ${TABLE}.product_physicalprocessor ;;
  }

  dimension: product_preinstalledsw {
    type: string
    hidden: yes
    sql: ${TABLE}.product_preinstalledsw ;;
  }

  dimension: product_proactiveguidance {
    type: string
    hidden: yes
    sql: ${TABLE}.product_proactiveguidance ;;
  }

  dimension: product_processorarchitecture {
    type: string
    hidden: yes
    sql: ${TABLE}.product_processorarchitecture ;;
  }

  dimension: product_processorfeatures {
    type: string
    hidden: yes
    sql: ${TABLE}.product_processorfeatures ;;
  }

  dimension: productfamily {
    label: "Family"
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_productfamily ;;
  }


##### Innaccurate labeling on part of AWS - use product code instead ####

  dimension: product_name {
    type: string
    description: "Innaccurate labeling on part of AWS - use product code instead"
    hidden: yes
    view_label: "Product Info"
    sql: ${TABLE}.product_productname ;;
  }

#####
  dimension: product_programmaticcasemanagement {
    hidden: yes
    type: string
    sql: ${TABLE}.product_programmaticcasemanagement ;;
  }

  dimension: product_provisioned {
    hidden: yes
    type: string
    sql: ${TABLE}.product_provisioned ;;
  }

  dimension: product_queuetype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_queuetype ;;
  }

  dimension: product_requestdescription {
    hidden: yes
    type: string
    sql: ${TABLE}.product_requestdescription ;;
  }

  dimension: product_requesttype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_requesttype ;;
  }

  dimension: product_routingtarget {
    hidden: yes
    type: string
    sql: ${TABLE}.product_routingtarget ;;
  }

  dimension: product_routingtype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_routingtype ;;
  }

  dimension: product_servicecode {
    hidden: yes
    type: string
    sql: ${TABLE}.product_servicecode ;;
  }

  dimension: product_sku {
    hidden: yes
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension: product_softwaretype {
    hidden: yes
    type: string
    sql: ${TABLE}.product_softwaretype ;;
  }

  dimension: product_storage {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storage ;;
  }

  dimension: product_storageclass {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storageclass ;;
  }

  dimension: product_storagemedia {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storagemedia ;;
  }

  dimension: product_technicalsupport {
    hidden: yes
    type: string
    sql: ${TABLE}.product_technicalsupport ;;
  }

  dimension: tenancy {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_tenancy ;;
  }

  dimension: product_thirdpartysoftwaresupport {
    hidden: yes
    type: string
    sql: ${TABLE}.product_thirdpartysoftwaresupport ;;
  }

  dimension: to_location {
    view_label: "Product Info"
#     map_layer_name: countries
    type: string
    sql: ${TABLE}.product_tolocation ;;
  }

  dimension: to_location_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_tolocationtype ;;
  }

  dimension: training {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_training ;;
  }

  dimension: transfer_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_transfertype ;;
  }

  dimension: usage_family {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_usagefamily ;;
  }

  dimension: data_transfer {
    view_label: "Line Items (Individual Charges)"
    type: yesno
    sql: REGEXP_LIKE(${usage_type}, 'DataTransfer')   ;;
  }

  dimension: data_transfer_outbound {
    view_label: "Line Items (Individual Charges)"
    type: yesno
    sql: REGEXP_LIKE(${usage_type}, 'DataTransfer-Out')   ;;
  }

  dimension: data_transfer_inbound {
    view_label: "Line Items (Individual Charges)"
    type: yesno
    sql: REGEXP_LIKE(${usage_type}, 'DataTransfer-In')   ;;
  }

  dimension: usage_type {
    view_label: "Product Info"
    type: string
    sql: ${TABLE}.product_usagetype ;;
  }

  dimension: product_vcpu {
    hidden: yes
    type: string
    sql: ${TABLE}.product_vcpu ;;
  }

  dimension: product_version {
    hidden: yes
    type: string
    sql: ${TABLE}.product_version ;;
  }

  dimension: product_volumetype {
    type: string
    hidden: yes
    sql: ${TABLE}.product_volumetype ;;
  }

  dimension: product_whocanopencases {
    hidden: yes
    type: string
    sql: ${TABLE}.product_whocanopencases ;;
  }

  dimension: pricing_leasecontractlength {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_leasecontractlength ;;
  }

  dimension: pricing_offeringclass {
    hidden: yes
    type: string
    sql: ${TABLE}.product_storageclass ;;
  }

  dimension: pricing_purchaseoption {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_purchaseoption ;;
  }

  dimension: pricing_publicondemandcost {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_publicondemandcost ;;
  }

  dimension: pricing_publicondemandrate {
    hidden: yes
    type: string
    sql: ${TABLE}.pricing_publicondemandrate ;;
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

  dimension: reservation_availabilityzone {
    hidden: yes
    type: string
    sql: ${TABLE}.reservation_availabilityzone ;;
  }

  dimension: reservation_unitsperreservation {
    type: string
    hidden: yes
    sql: ${TABLE}.reservation_normalizedunitsperreservation ;;
  }

  dimension: reservation_numberofreservations {
    type: number
    hidden: yes
    sql: ${TABLE}.reservation_numberofreservations ;;
  }

  dimension: reservation_arn {
    view_label: "Reserved Units"
    description: "When an RI benefit discount is applied to a matching line item of usage, the ARN value in the reservation/ReservationARN column for the initial upfront fees and recurring monthly charges matches the ARN value in the discounted usage line items."
    type: string
    sql: ${TABLE}.reservation_reservationarn ;;
  }

  dimension: reservation_totalreservednormalizedunits {
    hidden: yes
    type: string
    sql: ${TABLE}.reservation_totalreservednormalizedunits ;;
  }

  dimension: reservation_totalreservedunits {
    view_label: "Reserved Units"
    description: "The total number of total number of hours across all reserved instances in the subscription."
    type: number
    hidden: yes
    sql: ${TABLE}.reservation_totalreservedunits ;;
  }



  ### ENABLE FOR CUSTOM TAGS ###

  dimension: user_name {
    view_label: "Custom Resource Tagging"
    type: string
    sql: ${TABLE}.resourcetags_username ;;
  }

  dimension: user_cost_category {
    view_label: "Custom Resource Tagging"
    type: string
    sql: ${TABLE}.resourcetags_usercostcategory ;;
  }

  dimension: customer_segment {
    view_label: "Custom Resource Tagging"
    type: string
    sql: CASE
          WHEN ${user_cost_category} = '744.00000000' THEN 'SMB'
          WHEN ${user_cost_category} = '' THEN 'Mid-Market'
          WHEN ${user_cost_category} = 'internal' THEN 'Enterprise'
          ELSE 'Enterprise'
          END
          ;;
  }

  ### END EMNABLE FOR CUSTOM TAGS ###


  measure: count_line_items {
    view_label: "Line Items (Individual Charges)"
    type: count
  }



  ### LINE ITEM AGGREGATIONS ###

  measure: total_unblended_cost {
    view_label: "Line Items (Individual Charges)"
    description: "The cost of all aggregated line items after tiered pricing and discounted usage have been processed."
    type: sum
    sql: ${lineitem_unblendedcost} ;;
    value_format_name: usd_0
  }

  measure: average_unblended_rate {
    label: "Unblended Rate"
    view_label: "Line Items (Individual Charges)"
    description: "The average cost of all aggregated line items after tiered pricing and discounted usage have been processed."
    type: average
    sql: ${unblended_rate} ;;
    value_format_name: usd_0
  }

  measure: total_blended_cost {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    drill_fields: [common*, total_blended_cost,  total_measures*]
  }

  measure: total_data_transfer_cost {
    view_label: "Line Items (Individual Charges)"
    description: "Total charges for data transfers"
    type: sum
    sql: ${lineitem_blendedcost} ;;
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
    sql: ${lineitem_unblendedcost} ;;
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
    sql: ${lineitem_blendedcost} ;;
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
    sql: ${lineitem_blendedcost} ;;
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
    sql: ${lineitem_blendedcost};;
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
    sql: ${lineitem_blendedcost} ;;
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
    sql: ${lineitem_unblendedcost} ;;
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
#     hidden: yes
    type: count_distinct
    sql: ${usage_start_month} ;;
    drill_fields: [billing_period_start_month, total_measures*]
  }

  measure: average_blended_cost_all_time {
    view_label: "Line Items (Individual Charges)"
    description: "How much all aggregated line items are charged to a consolidated billing account in an organization"
    type: average
    sql: ${lineitem_blendedcost} ;;
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
    sql: ${blended_rate} ;;
    value_format_name: usd
    drill_fields: [common*, basic_blended_measures*]
  }

  measure: total_usage_amount {
    view_label: "Line Items (Individual Charges)"
    description: "The amount of usage incurred by the customer. For all reserved units, use the Total Reserved Units column instead."
    type: sum
    sql: ${lineitem_usageamount} ;;
    value_format_name: decimal_0
    drill_fields: [common*, basic_blended_measures*]
  }

  ### PRODUCT SPECIFIC COST MEASURES ###

  measure: EC2_usage_amount {
    label: "EC2 Usage Amount"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonEC2"
    }
    drill_fields: [common*, EC2_usage_amount, ec2_measures*]
  }

  measure: cloudfront_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonCloudFront"
    }
    drill_fields: [common*, cloudfront_usage_amount]
  }

  measure: cloudtrail_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AWSCloudTrail"
    }
    drill_fields: [common*, cloudtrail_usage_amount]
  }
  measure: S3_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonS3"
    }
    drill_fields: [common*, S3_usage_amount]
  }

  measure: redshift_usage_amount {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonRedshift"
    }
    drill_fields: [common*, redshift_usage_amount]
  }

  measure: rds_usage_amount {
    label: "RDS Usage Amount"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_usageamount} ;;
    filters: {
      field: product_code
      value: "AmazonRDS"
    }
    drill_fields: [common*, rds_usage_amount]
  }

  measure: EC2_blended_cost {
    label: "EC2 Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonEC2"
    }
    drill_fields: [common*, EC2_blended_cost, ec2_measures*]
  }

  measure: EC2_reserved_blended_cost {
    label: "EC2 Reserved Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
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
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
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
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonCloudFront"
    }
    drill_fields: [common*, cloudtrail_blended_cost]
  }

  measure: cloudtrail_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AWSCloudTrail"
    }
    drill_fields: [common*, cloudtrail_blended_cost]
  }
  measure: S3_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonS3"
    }
    drill_fields: [common*, S3_blended_cost]
  }

  measure: redshift_blended_cost {
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonRedshift"
    }
    drill_fields: [common*, redshift_blended_cost]
  }

  measure: rds_blended_cost {
    label: "RDS Blended Cost"
    view_label: "Product Info"
    type: sum
    sql: ${lineitem_blendedcost} ;;
    value_format_name: usd_0
    filters: {
      field: product_code
      value: "AmazonRDS"
    }
    drill_fields: [common*, rds_blended_cost]
  }



  ### RESERVED UNIT AGGREGATIONS ###

  measure: number_of_reservations {
    view_label: "Reserved Units"
    description: "The number of reservations covered by this subscription. For example, one Reserved Instance (RI) subscription may have four associated RI reservations."
    type: sum
    sql: ${reservation_numberofreservations} ;;
    drill_fields: [common*, number_of_reservations, total_measures*]
  }

### UNTIL DISCREPENCY IS RESOLVED, USING A MANUAL CALCULATION
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
    sql: ${reservation_totalreservednormalizedunits} ;;
    drill_fields: [common*, total_normalized_reserved_units, total_measures*]
  }

  measure: units_per_reservation {
    label: "Units per Reservation (Hours Reserved)"
    view_label: "Reserved Units"
    description: "The number of usage units reserved by a single reservation in a given subscription, such as how many hours a single Amazon EC2 RI has reserved."
    type: sum
    sql: ${reservation_unitsperreservation} ;;
    drill_fields: [common*, units_per_reservation, total_measures*]
  }

  set: common {fields: [lineitem_resourceid, line_item_operation,   type, bill_payeraccountid, description]}
  set: total_measures {fields: [total_data_transfer_cost_unblended, total_data_transfer_cost, total_blended_cost, total_unblended_cost]  }
  set: inbound_outbound {fields: [total_data_transfer_cost_unblended, total_data_transfer_cost, total_outbound_data_transfer_cost, total_inbound_data_transfer_cost]}
  set: basic_blended_measures {fields: [average_blended_cost_per_month, average_blended_rate, total_usage_amount]}
  set: ec2_measures {fields: [EC2_blended_cost,EC2_reserved_blended_cost,EC2_non_reserved_blended_cost,EC2_usage_amount]}

}
