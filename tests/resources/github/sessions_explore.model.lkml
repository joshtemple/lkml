explore: pdt_sessions_from_events{
  label: "Session-based Site Behavior"
  view_label: "(1) Sessions"
  join: view_collection {
    view_label: "(2) View Collection Page"
    relationship: one_to_one
    type: left_outer
    sql_on: ${pdt_sessions_from_events.user_id} = ${view_collection.user_id}
      and ${pdt_sessions_from_events.session_start_raw} <= ${view_collection.event_raw}
      and ${pdt_sessions_from_events.session_end_raw} >= ${view_collection.event_raw} ;;
  }
  join: view_product {
    view_label: "(3) View Product Page"
    relationship: one_to_one
    type: left_outer
    sql_on: ${pdt_sessions_from_events.user_id} = ${view_product.user_id}
      and ${pdt_sessions_from_events.session_start_raw} <= ${view_product.event_raw}
        and ${pdt_sessions_from_events.session_end_raw} >= ${view_product.event_raw} ;;
  }
  join: add_to_cart {
    view_label: "(4) Add to Cart Page"
    relationship: one_to_one
    type: left_outer
    sql_on: ${pdt_sessions_from_events.user_id} = ${add_to_cart.user_id}
      and ${pdt_sessions_from_events.session_start_raw} <= ${add_to_cart.event_raw}
        and ${pdt_sessions_from_events.session_end_raw} >= ${add_to_cart.event_raw}  ;;
  }
  join: confirmed_order {
    view_label: "(5) Confirmed Order"
    relationship: many_to_many
    type: left_outer
    sql_on: ${pdt_sessions_from_events.user_id} = ${confirmed_order.user_id}
        and ${pdt_sessions_from_events.session_start_raw} <= ${confirmed_order.event_raw}
        and ${pdt_sessions_from_events.session_end_raw} >= ${confirmed_order.event_raw} ;;
  }
}