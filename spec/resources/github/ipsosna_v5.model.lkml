connection: "bdg1"

# include all the views
include: "/**/*.view"

datagroup: ipsosna_v5_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ipsosna_v5_default_datagroup

explore: shopper_events {
  label: "BDG User Explore"
  view_name: shopper_events
  view_label: "BDG User Explore"

  join: media_events {
    view_label: "BDG User Explore"
    type: inner
    relationship: one_to_many
    sql_on: ${shopper_events.panelist_key} = ${media_events.panelist_key};;
  }

  join: app_events {
    view_label: "BDG User Explore"
    type: inner
    relationship: one_to_many
    sql_on: ${shopper_events.panelist_key} = ${app_events.panelist_key};;
  }

  join: web_events {
    view_label: "BDG User Explore"
    type: inner
    relationship: one_to_many
    sql_on: ${shopper_events.panelist_key} = ${web_events.panelist_key};;
  }
}

  explore: sequence_event_shopper {
    label: "BDG User Explore2"
    view_name: sequence_event_shopper
    view_label: "sequence_event_shopper"

    join: shopper_events {
      view_label: "shopper_events"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sequence_event_shopper.record_id} = ${shopper_events.record_id} and ${sequence_event_shopper.panelist_key} = ${shopper_events.panelist_key};;
    }

  join: product_category {
    type: inner
    relationship: one_to_many
    sql_on: ${shopper_events.product_code} = ${product_cat_split.product_code};;}

    join: product_cat_split {
      type: inner
      relationship: one_to_many
      sql_on: ${shopper_events.product_code} = ${product_cat_split.product_code};;
    }}
