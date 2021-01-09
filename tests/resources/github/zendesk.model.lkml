connection: "getdata"

# include all the views
include: "*.view"

explore: users {
  join: organizations {
    type: left_outer
    sql_on: ${users.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: tickets {
  fields: [
    ALL_FIELDS*,
    -tickets.getaround_trip_dependent_fields*
  ]
  join: ticket_custom_fields {
    type: left_outer
    foreign_key: tickets.id
    relationship: one_to_one
  }

  join: ticket_facts {
    view_label: "Ticket Fact"
    type: left_outer
    foreign_key: tickets.id
    relationship: one_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: requesters {
    from: users
    type: left_outer
    sql_on: ${tickets.requester_id} = ${requesters.id} ;;
    relationship: many_to_one
  }

  join: assignees {
    from: users
    type: left_outer
    sql_on: ${tickets.assignee_id} = ${assignees.id} ;;
    relationship: many_to_one
  }

  join: ticket_metrics {
    type: left_outer
    sql_on: ${tickets.id} = ${ticket_metrics.ticket_id} ;;
    relationship: one_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${tickets.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: ticket__tags {
    type: left_outer
    sql_on: ${tickets.id} = ${ticket__tags.ticket_id} ;;
    relationship: one_to_many
  }

  join: ticket_touches {
    type: left_outer
    sql_on: ${tickets.id} = ${ticket_touches.ticket_id} ;;
    relationship: one_to_one
  }

  join: ticket_first_assignee {
    view_label: "Ticket First Touch"
    from: users
    type: left_outer
    sql_on: ${ticket_touches.first_touch_agent_id} = ${ticket_first_assignee.id} ;;
    relationship: many_to_one
  }

  join: ticket_last_assignee {
    view_label: "Ticket Last Touch"
    from: users
    type: left_outer
    sql_on: ${ticket_touches.last_touch_agent_id} = ${ticket_last_assignee.id} ;;
    relationship: many_to_one
  }

  join: ticket_group_touches {
    type: left_outer
    sql_on: ${tickets.id} = ${ticket_group_touches.ticket_id} ;;
    relationship: one_to_one
  }

  join: ticket_call {
    view_label: "Ticket Call"
    type: left_outer
    sql_on: ${tickets.id} = ${ticket_call.ticket_id} ;;
    relationship: many_to_one
  }

  join: ticket_call_assignee {
    view_label: "Ticket Call Assignee"
    from: users
    type: left_outer
    sql_on: ${ticket_call.agent_id} = ${ticket_call_assignee.id} ;;
    relationship: many_to_one
  }

  join: agent_touch {
    view_label: "Agent Touch"
    sql_on: ${tickets.id} = ${agent_touch.ticket_id} ;;
    relationship: one_to_many
  }

#   join: satisfaction_ratings {
#     view_label: "CSAT Ratings"
#     type: left_outer
#     sql_on: ${tickets.id} = ${satisfaction_ratings.ticket_id} ;;
#     relationship: many_to_one
#   }
#
#   join: satisfaction_ratings_requesters {
#     view_label: "CSAT Ratings Requester"
#     from: users
#     type: left_outer
#     sql_on: ${satisfaction_ratings.requester_id} = ${satisfaction_ratings_requesters.id} ;;
#     relationship: many_to_one
#   }
#
#   join: satisfaction_ratings_assignees {
#     view_label: "CSAT Ratings Assignee"
#     from: users
#     type: left_outer
#     sql_on: ${satisfaction_ratings.assignee_id} = ${satisfaction_ratings_assignees.id} ;;
#     relationship: many_to_one
#   }
#
#   join: satisfaction_ratings_group {
#     view_label: "CSAT Ratings Group"
#     from: groups
#     type: left_outer
#     sql_on: ${satisfaction_ratings.group_id} = ${satisfaction_ratings_group.id} ;;
#     relationship: many_to_one
#   }
}
