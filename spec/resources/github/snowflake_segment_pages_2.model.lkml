connection: "snowflake_landing_zone"

# include all views in this project
# - include: "*.dashboard.lookml"  # include all dashboards in this project
include: "*.view"

# - explore: pages

explore: event_facts {
  view_label: "Events"
  label: "Events"

  join: pages {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.timestamp = pages.timestamp
      and event_facts.anonymous_id = pages.anonymous_id
       ;;
    relationship: one_to_one
  }

  join: tracks {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.event_id = cast(tracks.timestamp AS string) ||  tracks.anonymous_id ||  '-t'
      and event_facts.timestamp = tracks.timestamp
      and event_facts.anonymous_id = tracks.anonymous_id
       ;;
    relationship: one_to_one
    fields: []
  }

  join: order_completed {
    view_label: "Order Completed Detail"
    type: inner
    sql_on: ${tracks.id} = ${order_completed.id} ;;
    relationship: one_to_one
  }

  join: order_summary {
    view_label: "Orders and Customers"
    type: inner
    sql_on: ${order_summary.orderid} = ${order_completed.order_id} ;;
    relationship: many_to_one
  }

  join: product_added {
    view_label: "Product Added Detail"
    type: inner
    sql_on: ${tracks.id} = ${product_added.id} ;;
    relationship: one_to_one
  }

  join: product_viewed {
    view_label: "Product Viewed Detail"
    type: inner
    sql_on: ${tracks.id} = ${product_viewed.id} ;;
    relationship: one_to_one
  }


  join: page_facts {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.event_id = page_facts.event_id and
      event_facts.timestamp = page_facts.timestamp and
      event_facts.looker_visitor_id = page_facts.looker_visitor_id
       ;;
    relationship: one_to_one
  }

  join: sessions_pg_trk {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${event_facts.session_id} = ${sessions_pg_trk.session_id} ;;
    relationship: many_to_one
  }

  join: session_pg_trk_facts {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${event_facts.session_id} = ${session_pg_trk_facts.session_id} ;;
    relationship: many_to_one
  }


}
  explore: sessions_pg_trk {
    view_label: "Sessions"
    label: "Sessions"
  }

  explore: event_facts2 {
    from: event_facts
    label: "Event Detailed Facts"


  }
