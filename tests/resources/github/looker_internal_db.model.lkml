connection: "looker_meta_db"
aggregate_awareness:  yes

# include all the views
include: "*.view"

explore: failed_login_attempts{
  hidden: yes
  from: login_attempt
}

explore: history {
  hidden: no
  join: user {
    sql_on: ${history.user_id} = ${user.id} ;;
    relationship: many_to_one
  }
}

#### FLATTENING EAV SCHEMA
explore: export_queries_events {
  hidden: yes
  from: event
  sql_always_where:${export_queries_events.name} = 'export_query' ;;
  view_label: "Export Queries Events"
  join: export_format {
    from: event_attribute
    sql_on: ${export_queries_events.id} = ${export_format.event_id} ;;
    sql_where:${export_format.name} = 'export_format'  ;;
    fields: [export_format.value]
    view_label: "Export Queries Event Attributes"
    relationship: one_to_many
  }
  join: query_params {
    from: event_attribute
    sql_on: ${export_queries_events.id} = ${query_params.event_id} ;;
    relationship: one_to_many
    sql_where: ${query_params.name} = 'query_params'  ;;
    fields: [query_params.value]
    view_label: "Export Queries Event Attributes"
  }
  join: source {
    from: event_attribute
    sql_on: ${export_queries_events.id} = ${source.event_id} ;;
    relationship: one_to_many
    sql_where: ${source.name} = 'source'  ;;
    fields: [source.value]
    view_label: "Export Queries Event Attributes"
  }
  join: history_id {
    from: event_attribute
    sql_on: ${export_queries_events.id} = ${history_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${history_id.name} = 'history_id'  ;;
    fields: [history_id.value]
    view_label: "Export Queries Event Attributes"
  }
  join: history {
    sql_on: ${history_id.value} = ${history.id} ;;
    relationship: many_to_one
    fields: ["history.link"]
    view_label: "Export Queries Event Attributes"
  }
  join: user {
    sql_on: ${export_queries_events.user_id} = ${user.id} ;;
    relationship: many_to_one
    fields: ["user.name"]
    view_label: "Export Queries Event Attributes"
  }
}

explore: scheduler_delivery_events  {
  hidden: yes
  from:  event
  sql_always_where: ${scheduler_delivery_events.name} = 'scheduler_deliver' ;;
  view_label: "Scheduler Delivery Events"
  join: scheduled_plan_id {
    from: event_attribute
    sql_on: ${scheduler_delivery_events.id} = ${scheduled_plan_id.event_id} ;;
    relationship: one_to_many
    sql_where:  ${scheduled_plan_id.name} = 'scheduled_plan_id';;
    fields: ["scheduled_plan_id.value", "scheduled_plan_id.schedule_plan_history_link"]
    view_label: "Scheduler Delivery Event Attributes"
  }
  join: scheduled_plan_destination {
    sql_on: ${scheduled_plan_id.value} = ${scheduled_plan_destination.scheduled_plan_id} ;;
    relationship: many_to_one
    fields: ["scheduled_plan_destination.address" ]
    view_label: "Scheduler Delivery Event Attributes"
  }
  join: user_id {
    from: event_attribute
    sql_on: ${scheduler_delivery_events.id} = ${user_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${user_id.name} = 'user_id';;
    fields: ["user_id.value"]
    view_label: "Scheduler Delivery Event Attributes"
  }
  join: user {
    sql_on: ${user_id.value} = ${user.id} ;;
    relationship: many_to_one
    fields: ["user.name"]
    view_label: "Scheduler Delivery Event Attributes"
    }
  join: format {
    from: event_attribute
    sql_on: ${scheduler_delivery_events.id} = ${format.event_id} ;;
    relationship: one_to_many
    sql_where: ${format.name} = 'format';;
    fields: ["format.value"]
    view_label: "Scheduler Delivery Event Attributes"
  }
  join: destination_types {
    from: event_attribute
    sql_on: ${scheduler_delivery_events.id} = ${destination_types.event_id} ;;
    relationship: one_to_many
    sql_where:  ${destination_types.name} = 'destination_types';;
    fields: ["destination_types.value"]
    view_label: "Scheduler Delivery Event Attributes"
  }
  join: status {
    from: event_attribute
    sql_on: ${scheduler_delivery_events.id} = ${status.event_id} ;;
    relationship: one_to_many
    sql_where:  ${status.name} = 'status';;
    fields: ["status.value"]
    view_label: "Scheduler Delivery Event Attributes"
  }
}

explore: update_role_user_events {
  hidden: yes
  from: event
  sql_always_where: ${update_role_user_events.name} = 'update_role_users'  ;;
  view_label: "Update Role Users Events"
  join: update_role_user_old_user_ids {
    from: event_attribute
    sql_on: ${update_role_user_events.id} = ${update_role_user_old_user_ids.event_id} ;;
    relationship: one_to_many
    sql_where:${update_role_user_old_user_ids.name} = 'old_user_ids' ;;
    fields: [update_role_user_old_user_ids.value]
    view_label: "Update Role Users Event Attributes"
  }
  join: user {
    sql_on: ${update_role_user_events.user_id} = ${user.id} ;;
    relationship: many_to_one
    fields: ["user.name"]
    view_label: "Update Role Users Event Attributes"
  }
  join: update_role_role_id {
    from: event_attribute
    sql_on: ${update_role_user_events.id} = ${update_role_role_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${update_role_role_id.name} = 'role_id' ;;
    fields: [update_role_role_id.value]
    view_label: "Update Role Users Event Attributes"
  }
  join: old_user_names {
    from: flattened_old_user_names
    sql_on: ${update_role_user_old_user_ids.id} = ${old_user_names.event_attribute_id} ;;
    fields: [old_user_names.old_user_names]
    view_label: "Update Role Users Event Attributes"
    relationship: one_to_one
  }
  join: update_role_user_new_user_ids {
    from: event_attribute
    sql_on: ${update_role_user_events.id} = ${update_role_user_new_user_ids.event_id} ;;
    relationship: one_to_many
    sql_where: ${update_role_user_new_user_ids.name} = 'new_user_ids' ;;
    fields: [update_role_user_new_user_ids.value]
    view_label: "Update Role Users Event Attributes"
  }
  join: new_user_names {
    from: flattened_new_user_names
    sql_on: ${update_role_user_new_user_ids.id} = ${new_user_names.event_attribute_id} ;;
    view_label: "Update Role Users Event Attributes"
    relationship: one_to_one
  }
  join: role {
    sql_on: ${update_role_role_id.value} = ${role.id} ;;
    relationship: many_to_one
    fields: ["role.name"]
    view_label: "Update Role Users Event Attributes"
  }
}

explore: update_permission_set_events {
  hidden: yes
  from: event
  sql_always_where:${update_permission_set_events.name} = 'update_permission_set';;
  view_label: "Update Permission Set Events"
  join: update_permission_set_permission_set_id {
    from: event_attribute
    sql_on: ${update_permission_set_events.id} = ${update_permission_set_permission_set_id.event_id} ;;
    relationship: one_to_many
    sql_where:${update_permission_set_permission_set_id.name} = 'permission_set_id' ;;
    fields: [update_permission_set_permission_set_id.value]
    view_label: "Update Permission Set Event Attributes"
  }
  join: permission_set {
    sql_on: ${update_permission_set_permission_set_id.value}  = ${permission_set.id} ;;
    relationship: many_to_one
    fields: ["permission_set.name"]
    view_label: "Update Permission Set Event Attributes"
  }
  join: user {
    sql_on: ${update_permission_set_events.user_id} = ${user.id} ;;
    relationship: many_to_one
    fields: ["user.name"]
    view_label: "Update Permission Set Event Attributes"
  }
  join: update_permission_set_old_permissions {
    from: event_attribute
    sql_on: ${update_permission_set_events.id} = ${update_permission_set_old_permissions.event_id} ;;
    relationship: one_to_many
    sql_where: ${update_permission_set_old_permissions.name} = 'old_permissions' ;;
    fields: [update_permission_set_old_permissions.value]
    view_label: "Update Permission Set Event Attributes"
  }
  join: update_permission_set_new_permissions {
    from: event_attribute
    sql_on: ${update_permission_set_events.id} = ${update_permission_set_new_permissions.event_id} ;;
    relationship: one_to_many
    sql_where: ${update_permission_set_new_permissions.name} = 'new_permissions' ;;
    fields: [update_permission_set_new_permissions.value]
    view_label: "Update Permission Set Event Attributes"
  }

}

explore: update_role_events  {
  hidden: yes
  from:  event
  sql_always_where: ${update_role_events.name} = 'update_role' ;;
  view_label: "Update Role Events"
  join: user {
    sql_on: ${update_role_events.user_id} = ${user.id} ;;
    relationship: many_to_one
    fields: ["user.name"]
    view_label: "Update Role Events Attributes"
  }
  join: role_id {
    from: event_attribute
    sql_on: ${update_role_events.id} = ${role_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${role_id.name} = 'role_id';;
    fields: ["role_id.value"]
    view_label: "Update Role Event Attributes"
  }
  join: role {
    sql_on: ${role_id.value} = ${role.id} ;;
    relationship: many_to_one
    fields: ["role.name"]
    view_label: "Update Role Event Attributes"
  }
  join: old_model_set_id {
    from: event_attribute
    sql_on: ${update_role_events.id} = ${old_model_set_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${old_model_set_id.name} = 'old_model_set_id';;
    fields: ["old_model_set_id.value"]
    view_label: "Update Role Event Attributes"
  }
  join: new_model_set_id {
    from: event_attribute
    sql_on: ${update_role_events.id} = ${new_model_set_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${new_model_set_id.name} = 'new_model_set_id';;
    fields: ["new_model_set_id.value"]
    view_label: "Update Role Event Attributes"
  }
  join: new_model_set {
    from: model_set
    sql_on: ${new_model_set_id.value} = ${new_model_set.id} ;;
    relationship: many_to_one
    fields: ["new_model_set.new_model_set_name"]
    view_label: "Update Role Event Attributes"
  }
  join: old_model_set {
    from: model_set
    sql_on: ${old_model_set_id.value} = ${old_model_set.id} ;;
    relationship: many_to_one
    fields: ["old_model_set.old_model_set_name"]
    view_label: "Update Role Event Attributes"
  }

  join: new_permission_set_id {
    from: event_attribute
    sql_on: ${update_role_events.id} = ${new_permission_set_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${new_permission_set_id.name} = 'new_permission_set_id';;
    fields: ["new_permission_set_id.value"]
    view_label: "Update Role Event Attributes"
  }
  join: new_permission_set {
    from: permission_set
    sql_on: ${new_permission_set_id.value} = ${new_permission_set.id} ;;
    relationship: many_to_one
    fields: ["new_permission_set.new_permission_set_name"]
    view_label: "Update Role Event Attributes"
  }
  join: old_permission_set_id {
    from: event_attribute
    sql_on: ${update_role_events.id} = ${old_permission_set_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${old_permission_set_id.name} = 'old_permission_set_id';;
    fields: ["old_permission_set_id.value"]
    view_label: "Update Role Event Attributes"
  }
  join: old_permission_set {
    from: permission_set
    sql_on: ${old_permission_set_id.value} = ${old_permission_set.id} ;;
    relationship: many_to_one
    fields: ["old_permission_set.old_permission_set_name"]
    view_label: "Update Role Event Attributes"
  }

}

explore: add_group_user_events{
  hidden: yes
  from:  event
  sql_always_where: ${add_group_user_events.name} = 'add_group_user' ;;
  view_label: "Add Group User Events"
  join: user {
    sql_on: ${add_group_user_events.user_id} = ${user.id} ;;
    relationship: many_to_one
    fields: ["user.name"]
    view_label: "Add Group User Event Attributes"
  }
  join: group_id {
    from: event_attribute
    sql_on: ${add_group_user_events.id} = ${group_id.event_id} ;;
    relationship: one_to_many
    sql_where:  ${group_id.name} = 'group_id' ;;
    fields: ["group_id.value"]
    view_label: "Add Group User Event Attributes"
  }
  join: group {
    sql_on: ${group_id.value} = ${group.id} ;;
    relationship: many_to_one
    fields: ["group.name"]
    view_label: "Add Group User Event Attributes"
  }
  join: added_user_id {
    from: event_attribute
    sql_on: ${add_group_user_events.id} = ${added_user_id.event_id} ;;
    relationship: one_to_many
    sql_where: ${added_user_id.name} = 'user_id' ;;
    fields: ["added_user_id.value"]
    view_label: "Add Group User Event Attributes"
  }
  join: added_user {
    from: user
    sql_on: ${added_user_id.value} = ${added_user.id} ;;
    relationship: many_to_one
    fields: ["added_user.added_user_name"]
    view_label: "Add Group User Event Attributes"
  }
}
