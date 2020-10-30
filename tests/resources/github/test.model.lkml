connection: "test"

include: "inventory_locations.view"
include: "inventory_transfers.view"
include: "orders.view"
include: "order_items.view"
include: "products.view"
include: "web_sessions.view" # unused include

explore: orders {

  join: order_items {
    type: inner
    relationship: one_to_many
    sql_on: orders.id = order_items.order_id ;; # raw sql reference in join
  }

  join: products {
    type: inner
    relationship: one_to_one
    sql_on: ${products.id} = ${order_items.product_id} ;;
  }
}

explore: inventory_transfers {

  join: source_location {
    from: inventory_locations
    type: inner
    relationship: one_to_one
    sql_on: ${source_location.id} = ${inventory_transfers.source_location_id} ;;
  }

  join: destination_location {
    from: inventory_locations
    type: inner
    relationship: one_to_one
    sql_on: ${destination_location.id} = ${inventory_transfers.destination_location_id} ;;
  }
}

test: something {
  explore_source: orders {
    column: id {
      field: orders.id
    }
    filters: {
      field: order_items.unit_cost_usd
      value: "100"
    }
  }
  assert: something {
    expression: ${orders.id} == 123 ;;
  }
}
