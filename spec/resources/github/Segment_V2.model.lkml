connection: "segment"

# include all views in this project
# - include: ".dashboard.lookml"  # include all dashboards in this project
include: "*.view"

explore: completed_order {}

explore: experiments {
  view_label: "A/B Tests"

  join: completed_order {
    sql_on: ${experiments.anonymous_id} = ${completed_order.anonymous_id} ;;
    relationship: one_to_one
  }

}

explore: event_facts {
  view_label: "Events"
  label: "Events"

  join: pages {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.event_id = concat(${pages.event_id}, '-p') ;;
    relationship: one_to_one
  }

  #       and event_facts.received_at = pages.received_at
  #       and event_facts.anonymous_id = pages.anonymous_id

  join: tracks {
    view_label: "Events"
    type: left_outer
    sql_on: event_facts.event_id = concat(${tracks.event_id}, '-t') ;;
    relationship: one_to_one
    fields: []
  }

  join: sessions_pg_trk {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${event_facts.session_id} = ${sessions_pg_trk.session_id} ;;
    relationship: many_to_one
  }
}

#           and event_facts.received_at = tracks.received_at
#       and event_facts.anonymous_id = tracks.anonymous_id

#   - join: page_facts
#     view_label: Events
#     type: left_outer
#     sql_on: |
#       event_facts.event_id = page_facts.event_id and
#       event_facts.received_at = page_facts.received_at and
#       event_facts.glossier_visitor_id = page_facts.glossier_visitor_id
#     relationship: one_to_one
#
#
#   - join: session_pg_trk_facts
#     view_label: Sessions
#     type: left_outer
#     sql_on: ${event_facts.session_id} = ${session_pg_trk_facts.session_id}
#     relationship: many_to_one
