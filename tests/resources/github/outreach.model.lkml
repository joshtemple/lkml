connection: "happyco_bq"

# include all the views
include: "*.view"

datagroup: outreach_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: outreach_default_datagroup

explore: outreach_mailings {
  label: "Mailings"

  join: outreach_prospects {
    view_label: "Prospects"
    sql_on: ${outreach_prospects.id} =  ${outreach_mailings.prospect_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_mailboxes {
    view_label: "Mailboxes"
    sql_on: ${outreach_mailboxes.id} =  ${outreach_mailings.mailbox_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_tasks {
    view_label: "Tasks"
    sql_on: ${outreach_tasks.id} =  ${outreach_mailings.task_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_sequences {
    view_label: "Sequences"
    sql_on: ${outreach_sequences.id} =  ${outreach_mailings.sequence_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_templates {
    view_label: "Templates"
    sql_on: ${outreach_templates.id} =  ${outreach_mailings.template_id}  ;;
    relationship: one_to_many
    type:  inner
  }
}

explore: outreach_calls {
  label: "Calls"

  join: outreach_prospects {
    view_label: "Prospects"
    sql_on: ${outreach_prospects.id} =  ${outreach_calls.prospect_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_users {
    view_label: "Users"
    sql_on: ${outreach_users.id} =  ${outreach_calls.user_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_tasks {
    view_label: "Tasks"
    sql_on: ${outreach_tasks.id} =  ${outreach_calls.task_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_sequences {
    view_label: "Sequences"
    sql_on: ${outreach_sequences.id} =  ${outreach_calls.sequence_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }
}

explore: outreach_tasks {
  label: "Tasks"

  join: outreach_users {
    view_label: "Completers"
    sql_on: ${outreach_users.id} =  ${outreach_tasks.completer_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }

  join: outreach_sequences {
    view_label: "Sequences"
    sql_on: ${outreach_sequences.id} =  ${outreach_tasks.sequence_id}  ;;
    relationship: one_to_many
    type:  left_outer
  }
}


  explore: outreach_events {
    label: "Events"

    join: outreach_users {
      view_label: "Users"
      sql_on: ${outreach_users.id} =  ${outreach_events.user_id}  ;;
      relationship: one_to_many
      type:  left_outer
    }

    join: outreach_prospects {
      view_label: "Prospects"
      sql_on: ${outreach_prospects.id} =  ${outreach_events.prospect_id}  ;;
      relationship: one_to_many
      type:  left_outer
    }

    join: outreach_mailings {
      view_label: "Mailings"
      sql_on: ${outreach_mailings.id} =  ${outreach_events.mailing_id}  ;;
      relationship: one_to_many
      type:  left_outer
    }
}
