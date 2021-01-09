connection: "arc-prod"

# include all the views
include: "*.view"

datagroup: arc_analysis_prod_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: arc_analysis_prod_default_datagroup

explore: bby_items {}

explore: bby_locs {}

explore: multiline_sourcing {

  conditionally_filter: {
    filters: {
      field: partitionTime_date
      value: "1 days ago for 1 day"
    }
  }

  join: MULTILINE_SOURCING__order_lines {
    view_label: "Multiline Sourcing: Orderlines"
    sql: LEFT JOIN UNNEST(${multiline_sourcing.order_lines}) as MULTILINE_SOURCING__order_lines ;;
    relationship: one_to_many
  }

  join: MULTILINE_SOURCING__order_lines__consolidation {
    view_label: "Multiline Sourcing: Orderlines Consolidation"
    sql: LEFT JOIN UNNEST([${MULTILINE_SOURCING__order_lines.consolidation}]) as MULTILINE_SOURCING__order_lines__consolidation ;;
    relationship: one_to_one
  }

  join: MULTILINE_SOURCING__order_lines__locations {
    view_label: "Multiline Sourcing: Orderlines Locations"
    sql: LEFT JOIN UNNEST(${MULTILINE_SOURCING__order_lines.locations}) as MULTILINE_SOURCING__order_lines__locations ;;
    relationship: one_to_many
  }
}

explore: orderline_sourcing {
  join: ORDERLINE_SOURCING__req_details {
    view_label: "Orderline Sourcing: Req Details"
    sql: LEFT JOIN UNNEST([${orderline_sourcing.req_details}]) as ORDERLINE_SOURCING__req_details ;;
    relationship: one_to_one
  }

  join: ORDERLINE_SOURCING__locations {
    view_label: "Orderline Sourcing: Locations"
    sql: LEFT JOIN UNNEST(${orderline_sourcing.locations}) as ORDERLINE_SOURCING__locations ;;
    relationship: one_to_many
  }

  join: ORDERLINE_SOURCING__locations__location_attributes_data {
    view_label: "Orderline Sourcing: Locations Locationattributesdata"
    sql: LEFT JOIN UNNEST([${ORDERLINE_SOURCING__locations.location_attributes_data}]) as ORDERLINE_SOURCING__locations__location_attributes_data ;;
    relationship: one_to_one
  }

  join: ORDERLINE_SOURCING__locations__los_configuration_data {
    view_label: "Orderline Sourcing: Locations Losconfigurationdata"
    sql: LEFT JOIN UNNEST([${ORDERLINE_SOURCING__locations.los_configuration_data}]) as ORDERLINE_SOURCING__locations__los_configuration_data ;;
    relationship: one_to_one
  }

  join: ORDERLINE_SOURCING__locations__sku_location_attributes_data {
    view_label: "Orderline Sourcing: Locations Skulocationattributesdata"
    sql: LEFT JOIN UNNEST([${ORDERLINE_SOURCING__locations.sku_location_attributes_data}]) as ORDERLINE_SOURCING__locations__sku_location_attributes_data ;;
    relationship: one_to_one
  }

  join: ORDERLINE_SOURCING__locations__sku_attributes_data {
    view_label: "Orderline Sourcing: Locations Skuattributesdata"
    sql: LEFT JOIN UNNEST([${ORDERLINE_SOURCING__locations.sku_attributes_data}]) as ORDERLINE_SOURCING__locations__sku_attributes_data ;;
    relationship: one_to_one
  }

  join: ORDERLINE_SOURCING__locations__cost_pattern_data {
    view_label: "Orderline Sourcing: Locations Costpatterndata"
    sql: LEFT JOIN UNNEST([${ORDERLINE_SOURCING__locations.cost_pattern_data}]) as ORDERLINE_SOURCING__locations__cost_pattern_data ;;
    relationship: one_to_one
  }

  join: ORDERLINE_SOURCING__locations__carrier_data {
    view_label: "Orderline Sourcing: Locations Carrierdata"
    sql: LEFT JOIN UNNEST([${ORDERLINE_SOURCING__locations.carrier_data]) as ORDERLINE_SOURCING__locations__carrier_data ;;
    relationship: one_to_one
  }
}

explore: view_today_backorder {
  join: VIEW_TODAY_BACKORDER__req_details {
    view_label: "View Today Backorder: Req Details"
    sql: LEFT JOIN UNNEST([${view_today_backorder.req_details}]) as VIEW_TODAY_BACKORDER__req_details ;;
    relationship: one_to_one
  }
}

explore: view_today_consolidation_details {}

explore: view_today_multiline {
  join: VIEW_TODAY_MULTILINE__orderline_req_details {
    view_label: "View Today Multiline: Orderline Req Details"
    sql: LEFT JOIN UNNEST([${view_today_multiline.orderline_req_details}]) as VIEW_TODAY_MULTILINE__orderline_req_details ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_MULTILINE__orderline_locations_location_attributes_data {
    view_label: "View Today Multiline: Orderline Locations Locationattributesdata"
    sql: LEFT JOIN UNNEST([${view_today_multiline.orderline_locations_location_attributes_data}]) as VIEW_TODAY_MULTILINE__orderline_locations_location_attributes_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_MULTILINE__orderline_locations_carrier_data {
    view_label: "View Today Multiline: Orderline Locations Carrierdata"
    sql: LEFT JOIN UNNEST([${view_today_multiline.orderline_locations_carrier_data}]) as VIEW_TODAY_MULTILINE__orderline_locations_carrier_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_MULTILINE__orderline_locations {
    view_label: "View Today Multiline: Orderline Locations"
    sql: LEFT JOIN UNNEST([${view_today_multiline.orderline_locations}]) as VIEW_TODAY_MULTILINE__orderline_locations ;;
    relationship: one_to_one
  }
}

explore: view_today_multiline_1 {
  join: VIEW_TODAY_MULTILINE_1__orderline_req_details {
    view_label: "View Today Multiline 1: Orderline Req Details"
    sql: LEFT JOIN UNNEST([${view_today_multiline_1.orderline_req_details}]) as VIEW_TODAY_MULTILINE_1__orderline_req_details ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_MULTILINE_1__orderline_locations_carrier_data {
    view_label: "View Today Multiline 1: Orderline Locations Carrierdata"
    sql: LEFT JOIN UNNEST([${view_today_multiline_1.orderline_locations_carrier_data}]) as VIEW_TODAY_MULTILINE_1__orderline_locations_carrier_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_MULTILINE_1__multiline_locations {
    view_label: "View Today Multiline 1: Multiline Locations"
    sql: LEFT JOIN UNNEST(${view_today_multiline_1.multiline_locations}) as VIEW_TODAY_MULTILINE_1__multiline_locations ;;
    relationship: one_to_many
  }
}

explore: view_today_multiline_loc_ranking {}

explore: view_today_orderline {
  join: VIEW_TODAY_ORDERLINE__req_details {
    view_label: "View Today Orderline: Req Details"
    sql: LEFT JOIN UNNEST([${view_today_orderline.req_details}]) as VIEW_TODAY_ORDERLINE__req_details ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_ORDERLINE__t0_locations {
    view_label: "View Today Orderline: T0 Locations"
    sql: LEFT JOIN UNNEST([${view_today_orderline.t0_locations}]) as VIEW_TODAY_ORDERLINE__t0_locations ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_ORDERLINE__t0_locations__location_attributes_data {
    view_label: "View Today Orderline: T0 Locations Locationattributesdata"
    sql: LEFT JOIN UNNEST([${VIEW_TODAY_ORDERLINE__t0_locations.location_attributes_data}]) as VIEW_TODAY_ORDERLINE__t0_locations__location_attributes_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_ORDERLINE__t0_locations__los_configuration_data {
    view_label: "View Today Orderline: T0 Locations Losconfigurationdata"
    sql: LEFT JOIN UNNEST([${VIEW_TODAY_ORDERLINE__t0_locations.los_configuration_data}]) as VIEW_TODAY_ORDERLINE__t0_locations__los_configuration_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_ORDERLINE__t0_locations__sku_location_attributes_data {
    view_label: "View Today Orderline: T0 Locations Skulocationattributesdata"
    sql: LEFT JOIN UNNEST([${VIEW_TODAY_ORDERLINE__t0_locations.sku_location_attributes_data}]) as VIEW_TODAY_ORDERLINE__t0_locations__sku_location_attributes_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_ORDERLINE__t0_locations__sku_attributes_data {
    view_label: "View Today Orderline: T0 Locations Skuattributesdata"
    sql: LEFT JOIN UNNEST([${VIEW_TODAY_ORDERLINE__t0_locations.sku_attributes_data}]) as VIEW_TODAY_ORDERLINE__t0_locations__sku_attributes_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_ORDERLINE__t0_locations__cost_pattern_data {
    view_label: "View Today Orderline: T0 Locations Costpatterndata"
    sql: LEFT JOIN UNNEST([${VIEW_TODAY_ORDERLINE__t0_locations.cost_pattern_data}]) as VIEW_TODAY_ORDERLINE__t0_locations__cost_pattern_data ;;
    relationship: one_to_one
  }

  join: VIEW_TODAY_ORDERLINE__t0_locations__carrier_data {
    view_label: "View Today Orderline: T0 Locations Carrierdata"
    sql: LEFT JOIN UNNEST([${VIEW_TODAY_ORDERLINE__t0_locations.carrier_data}]) as VIEW_TODAY_ORDERLINE__t0_locations__carrier_data ;;
    relationship: one_to_one
  }
}

explore: zipcode_details {}
