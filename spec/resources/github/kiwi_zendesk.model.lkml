connection: "kiwi_zendesk"

# include all the views
include: "*.view"

# # include all the dashboards
# include: "*.dashboard"

datagroup: kiwi_zendesk_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kiwi_zendesk_default_datagroup

explore: activities {
  join: users {
    type: left_outer
    sql_on: ${activities.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${users.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: activities_view {
  join: users {
    type: left_outer
    sql_on: ${activities_view.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${users.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: attachments {}

explore: attachments_view {}

explore: groups {}

explore: groups_view {}

explore: organizations {}

explore: organizations_view {}

explore: satisfaction_ratings {
  join: tickets {
    type: left_outer
    sql_on: ${satisfaction_ratings.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${satisfaction_ratings.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: satisfaction_ratings_view {
  join: groups {
    type: left_outer
    sql_on: ${satisfaction_ratings_view.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: tickets {
    type: left_outer
    sql_on: ${satisfaction_ratings_view.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: satisfaction_ratings {
    type: left_outer
    sql_on: ${tickets.satisfaction_rating_id} = ${satisfaction_ratings.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_events {
  join: tickets {
    type: left_outer
    sql_on: ${ticket_events.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${ticket_events.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${ticket_events.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: satisfaction_ratings {
    type: left_outer
    sql_on: ${tickets.satisfaction_rating_id} = ${satisfaction_ratings.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_events_view {
  join: tickets {
    type: left_outer
    sql_on: ${ticket_events_view.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${ticket_events_view.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${ticket_events_view.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: ticket_events {
    type: left_outer
    sql_on: ${ticket_events_view.ticket_event_id} = ${ticket_events.ticket_event_id} ;;
    relationship: many_to_one
  }

  join: satisfaction_ratings {
    type: left_outer
    sql_on: ${tickets.satisfaction_rating_id} = ${satisfaction_ratings.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_fields {}

explore: ticket_fields_view {}

explore: ticket_metrics {
  join: tickets {
    type: left_outer
    sql_on: ${ticket_metrics.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: satisfaction_ratings {
    type: left_outer
    sql_on: ${tickets.satisfaction_rating_id} = ${satisfaction_ratings.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${tickets.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_metrics_view {
  join: tickets {
    type: left_outer
    sql_on: ${ticket_metrics_view.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: satisfaction_ratings_view {
    type: left_outer
    sql_on: trim(${ticket_metrics_view.ticket_id}) = trim(${satisfaction_ratings_view.ticket_id}) ;;
    relationship: many_to_many
  }

  join: groups {
    type: left_outer
    sql_on: ${tickets.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: tickets {
  join: satisfaction_ratings {
    type: left_outer
    sql_on: ${tickets.satisfaction_rating_id} = ${satisfaction_ratings.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${tickets.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: users {
    type:  left_outer
    sql_on:  CAST(${tickets.submitter_id} AS STRING) = ${users.id} ;;
    relationship: one_to_one
  }
}

explore: tickets_view {
  join: satisfaction_ratings {
    type: left_outer
    sql_on: ${tickets_view.satisfaction_rating_id} = ${satisfaction_ratings.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${tickets_view.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets_view.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: tickets {
    type: left_outer
    sql_on: ${satisfaction_ratings.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  join: organizations {
    type: left_outer
    sql_on: ${users.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: users_view {
  join: organizations {
    type: left_outer
    sql_on: ${users_view.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}
