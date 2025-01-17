connection: "bigquery"

# include all the views
include: "/views/**/*.view"
include: "/*.dashboard.lookml"

datagroup: the_superior_qm_block_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: the_superior_qm_block_default_datagroup

explore: base_table {
  join: first_referrer {
    view_label: "First Referrer"
    sql: LEFT JOIN UNNEST([${base_table.first_referrer}]) as first_referrer ;;
    relationship: one_to_one
  }

  join: first_referrer__url {
    view_label: "First Referrer Url"
    sql: LEFT JOIN UNNEST([${first_referrer.url}]) as first_referrer__url ;;
    relationship: one_to_one
  }

  join: locale {
    view_label: "Locale"
    sql: LEFT JOIN UNNEST([${base_table.locale}]) as locale ;;
    relationship: one_to_one
  }

  join: last_url {
    view_label: "Last Url"
    sql: LEFT JOIN UNNEST([${base_table.last_url}]) as last_url ;;
    relationship: one_to_one
  }

  join: os {
    view_label: "Os"
    sql: LEFT JOIN UNNEST([${base_table.os}]) as os ;;
    relationship: one_to_one
  }

  join: landing_url {
    view_label: "Landing Url"
    sql: LEFT JOIN UNNEST([${base_table.landing_url}]) as landing_url ;;
    relationship: one_to_one
  }

  join: hits {
    view_label: "Hits"
    sql: LEFT JOIN UNNEST(${base_table.hits}) as hits ;;
    relationship: one_to_many
  }

  join: hits_errors {
    from: hits
    view_label: "Errors"
    sql: LEFT JOIN UNNEST(${base_table.hits}) as hits ;;
    relationship: one_to_many
  }

  join: hits__ajax {
    view_label: "Hits Ajax"
    sql: LEFT JOIN UNNEST(${hits.ajax}) as hits__ajax ;;
    relationship: one_to_many
  }

  join: hits__measures {
    view_label: "Hits Measures"
    sql: LEFT JOIN UNNEST(${hits.measures}) as hits__measures ;;
    relationship: one_to_many
  }

  join: hits__events {
    view_label: "Hits Events"
    sql: LEFT JOIN UNNEST(${hits.events}) as hits__events ;;
    relationship: one_to_many
  }

  join: hits__events_errors {
    view_label: "Hits Events Errors"
    sql: LEFT JOIN UNNEST(${hits.events}) as hits__events_errors ON ${hits__events_errors.is_error} ;;
    fields: [hits__events_errors.for_extension*]
    relationship: one_to_many
  }

  join: hits__events_successes {
    view_label: "Hits Events Successes"
    sql: LEFT JOIN UNNEST(${hits.events}) as hits__events_successes ON NOT COALESCE(${hits__events_errors.is_error} , FALSE) ;;
    fields: [hits__events_successes.for_extension*]
    relationship: one_to_many
  }

  join: hits__click {
    view_label: "Hits Click"
    sql: LEFT JOIN UNNEST(${hits.click}) as hits__click ;;
    relationship: one_to_many
  }

  join: hits__long_tasks {
    view_label: "Hits Long Tasks"
    sql: LEFT JOIN UNNEST(${hits.long_tasks}) as hits__long_tasks ;;
    relationship: one_to_many
  }

  join: hits__resources {
    view_label: "Hits Resources"
    sql: LEFT JOIN UNNEST(${hits.resources}) as hits__resources ;;
    relationship: one_to_many
  }

  join: hits__url {
    view_label: "Hits Url"
    sql: LEFT JOIN UNNEST([${hits.url}]) as hits__url ;;
    relationship: one_to_one
  }

  join: hits__referrer {
    view_label: "Hits Referrer"
    sql: LEFT JOIN UNNEST([${hits.referrer}]) as hits__referrer ;;
    relationship: one_to_one
  }

  join: hits__referrer__url {
    view_label: "Hits Referrer Url"
    sql: LEFT JOIN UNNEST([${hits__referrer.url}]) as hits__referrer__url ;;
    relationship: one_to_one
  }

  join: hits__markers {
    view_label: "Hits Markers"
    sql: LEFT JOIN UNNEST(${hits.markers}) as hits__markers ;;
    relationship: one_to_many
  }

  join: hits__forms {
    view_label: "Hits Forms"
    sql: LEFT JOIN UNNEST(${hits.forms}) as hits__forms ;;
    relationship: one_to_many
  }

  join: hits__forms__fields {
    view_label: "Hits Forms Fields"
    sql: LEFT JOIN UNNEST(${hits__forms.fields}) as hits__forms__fields ;;
    relationship: one_to_many
  }

  join: referrer {
    view_label: "Referrer"
    sql: LEFT JOIN UNNEST([${base_table.referrer}]) as referrer ;;
    relationship: one_to_one
  }

  join: referrer__url {
    view_label: "Referrer Url"
    sql: LEFT JOIN UNNEST([${referrer.url}]) as referrer__url ;;
    relationship: one_to_one
  }

  join: user {
    view_label: "User"
    sql: LEFT JOIN UNNEST([${base_table.user}]) as quinnmurray__user ;;
    relationship: one_to_one
  }

  join: device {
    view_label: "Device"
    sql: LEFT JOIN UNNEST([${base_table.device}]) as quinnmurray__device ;;
    relationship: one_to_one
  }

  join: session_facts {
    sql_on: ${base_table.id} = ${session_facts.session_id} ;;
    relationship: many_to_one
  }
}
