connection: "mightyhive_corporate_looker_poc"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: mightyhive_corp_site_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: mightyhive_corp_site_default_datagroup

explore: all_ga_sessions {
  join: all_ga_sessions_custom_dimensions
  { view_label: "Custom Dimensions"
    sql: LEFT join UNNEST(${all_ga_sessions.custom_dimensions}) as all_ga_sessions_custom_dimensions
      ;; relationship: one_to_many
  }
  join: all_ga_sessions_totals
  { view_label: "Totals"
    sql: LEFT join UNNEST([${all_ga_sessions.totals}]) as all_ga_sessions_totals
      ;; relationship: one_to_one
  }
  join: all_ga_sessions_hits__publisher_infos
  { view_label: "Hits Publisher Infos"
    sql: LEFT join UNNEST(${all_ga_sessions_hits.publisher_infos}) as all_ga_sessions_hits__publisher_infos
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits
  { view_label: "Hits"
    sql: LEFT join UNNEST(${all_ga_sessions.hits}) as all_ga_sessions_hits
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__custom_dimensions
  { view_label: "Hits Custom Dimensions"
    sql: LEFT join UNNEST(${all_ga_sessions_hits.custom_dimensions}) as all_ga_sessions_hits__custom_dimensions
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__app_info
  { view_label: "Hits App Info"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.app_info}]) as all_ga_sessions_hits__app_info
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__content_group
  { view_label: "Hits Content Group"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.content_group}]) as all_ga_sessions_hits__content_group
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__content_info
  { view_label: "Hits Content Info"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.content_info}]) as all_ga_sessions_hits__content_info
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__custom_variables
  { view_label: "Hits Custom Variables"
    sql: LEFT join UNNEST(${all_ga_sessions_hits.custom_variables}) as all_ga_sessions_hits__custom_variables
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__custom_metrics
  { view_label: "Hits Custom Metrics"
    sql: LEFT join UNNEST(${all_ga_sessions_hits.custom_metrics}) as all_ga_sessions_hits__custom_metrics
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__experiment
  { view_label: "Hits Experiment"
    sql: LEFT join UNNEST(${all_ga_sessions_hits.experiment}) as all_ga_sessions_hits__experiment
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__e_commerce_action
  { view_label: "Hits E Commerce Action"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.e_commerce_action}]) as all_ga_sessions_hits__e_commerce_action
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__promotion_action_info
  { view_label: "Hits Promotion Action Info"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.promotion_action_info}]) as all_ga_sessions_hits__promotion_action_info
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__source_property_info
  { view_label: "Hits Source Property Info"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.source_property_info}]) as all_ga_sessions_hits__source_property_info
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__item
  { view_label: "Hits Item"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.item}]) as all_ga_sessions_hits__item
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__product
  { view_label: "Hits Product"
    sql: LEFT join UNNEST(${all_ga_sessions_hits.product}) as all_ga_sessions_hits__product
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__product__custom_dimensions
  { view_label: "Hits Product Custom Dimensions"
    sql: LEFT join UNNEST(${all_ga_sessions_hits__product.custom_dimensions}) as all_ga_sessions_hits__product__custom_dimensions
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__product__custom_metrics
  { view_label: "Hits Product Custom Metrics"
    sql: LEFT join UNNEST(${all_ga_sessions_hits__product.custom_metrics}) as all_ga_sessions_hits__product__custom_metrics
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__social
  { view_label: "Hits Social"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.social}]) as all_ga_sessions_hits__social
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__event_info
  { view_label: "Hits Event Info"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.event_info}]) as all_ga_sessions_hits__event_info
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__latency_tracking
  { view_label: "Hits Latency Tracking"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.latency_tracking}]) as all_ga_sessions_hits__latency_tracking
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__publisher
  { view_label: "Hits Publisher"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.publisher}]) as all_ga_sessions_hits__publisher
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__page
  { view_label: "Hits Page"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.page}]) as all_ga_sessions_hits__page
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__transaction
  { view_label: "Hits Transaction"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.transaction}]) as all_ga_sessions_hits__transaction
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__exception_info
  { view_label: "Hits Exception Info"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.exception_info}]) as all_ga_sessions_hits__exception_info
      ;; relationship: one_to_one
  } join: all_ga_sessions_hits__promotion
  { view_label: "Hits Promotion"
    sql: LEFT join UNNEST(${all_ga_sessions_hits.promotion}) as all_ga_sessions_hits__promotion
      ;; relationship: one_to_many
  } join: all_ga_sessions_hits__refund
  { view_label: "Hits Refund"
    sql: LEFT join UNNEST([${all_ga_sessions_hits.refund}]) as all_ga_sessions_hits__refund
      ;; relationship: one_to_one
  } join: all_ga_sessions_geo_network
  { view_label: "Geo Network"
    sql: LEFT join UNNEST([${all_ga_sessions.geo_network}]) as all_ga_sessions_geo_network
      ;; relationship: one_to_one
  } join: all_ga_sessions_traffic_source
  { view_label: "Traffic Source"
    sql: LEFT join UNNEST([${all_ga_sessions.traffic_source}]) as all_ga_sessions_traffic_source
      ;; relationship: one_to_one
  } join: all_ga_sessions_traffic_source__adwords_click_info
  { view_label: "Traffic Source Adwords Click Info"
    sql: LEFT join UNNEST([${all_ga_sessions_traffic_source.adwords_click_info}]) as all_ga_sessions_traffic_source__adwords_click_info
      ;; relationship: one_to_one
  } join: all_ga_sessions_traffic_source__adwords_click_info__targeting_criteria
  { view_label: "Traffic Source Adwords Click Info Targeting Criteria"
    sql: LEFT join UNNEST([${all_ga_sessions_traffic_source__adwords_click_info.targeting_criteria}]) as all_ga_sessions_traffic_source__adwords_click_info__targeting_criteria
      ;; relationship: one_to_one
  } join: all_ga_sessions_device
  { view_label: "Device"
    sql: LEFT join UNNEST([${all_ga_sessions.device}]) as all_ga_sessions_device
      ;; relationship: one_to_one
  }
}
