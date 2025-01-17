connection: "mightyhive_corporate_looker_poc"

# include all the views
include: "*.view*"
# =include: "data_tests.lkml"

# include all the dashboards
include: "*.dashboard"


#explore: audience_meta_data {
 # label: "audience meta data"
#}

# explore: user_list {}

explore: ga_sessions {
  label: "GA 360 Sessions"
  extends: [ga_sessions_block]
}

explore: ga_sessions_block {
  extends: [ga_sessions_base]
  extension: required

  always_filter: {
    filters: {
      field: ga_sessions.partition_date
      value: "7 days ago for 7 days"
      ## Partition Date should always be set to a recent date to avoid runaway queries
    }
  }
}

explore: ga_sessions_base {

  # sql_always_where: ${hits_page.hostName} like  '%.ca' ;;

  persist_for: "1 hour"
  extension: required

  view_name: ga_sessions
  view_label: "Session"

  join: totals {
    view_label: "Session"
    sql: LEFT JOIN UNNEST([${ga_sessions.totals}]) as totals ;;
    relationship: one_to_one
  }

  join: trafficSource {
    view_label: "Session: Traffic Source"
    sql: LEFT JOIN UNNEST([${ga_sessions.trafficSource}]) as trafficSource ;;
    relationship: one_to_one
  }

  join: device {
    view_label: "Session: Device"
    sql: LEFT JOIN UNNEST([${ga_sessions.device}]) as device ;;
    relationship: one_to_one
  }

  join: geoNetwork {
    view_label: "Session: Geo Network"
    sql: LEFT JOIN UNNEST([${ga_sessions.geoNetwork}]) as geoNetwork ;;
    relationship: one_to_one
  }

  join: hits {
    view_label: "Session: Hits"
    sql: LEFT JOIN UNNEST(${ga_sessions.hits}) as hits ;;
    relationship: one_to_many
  }

  join: hits_page {
    view_label: "Session: Hits: Page"
    sql: LEFT JOIN UNNEST([${hits.page}]) as hits_page ;;
    relationship: one_to_one
  }

  join: hits_transaction {
    view_label: "Session: Hits: Transaction"
    sql: LEFT JOIN UNNEST([${hits.transaction}]) as hits_transaction ;;
    relationship: one_to_one
  }

  join: hits_item {
    view_label: "Session: Hits: Item"
    sql: LEFT JOIN UNNEST([${hits.item}]) as hits_item ;;
    relationship: one_to_one
  }


  join: hits_product {
    view_label: "Session: Hits: product"
    sql: LEFT JOIN UNNEST(${hits.product}) as hits_product ;;
    relationship: one_to_one
  }

  join: user_list{
    relationship: one_to_many
   sql_on:    ${ga_sessions.clientId} = ${user_list.clientId}
          AND ${ga_sessions.partition_date} = ${user_list.partition_date};;
#    sql_where:
#   (((${user_list.partition_raw} ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -364 DAY)))
#   AND (${user_list.partition_raw} ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -364 DAY), INTERVAL 365 DAY))))) ;;
#  (((${user_list.partition_date} ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -365 DAY)))
#       AND (${user_list.partition_date} ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -365 DAY), INTERVAL 365 DAY)))))
  }

  join: audience_meta_data{
    relationship: one_to_many
    sql_on:  ${user_list.audience_id} = ${audience_meta_data.audience_id};;
  }

  join: ga360_product_hierarchy {
    relationship: one_to_one
    sql_on: ${hits_product.productSKU} = ${ga360_product_hierarchy.product_sku} ;;
  }

  join: hits_social {
    view_label: "Session: Hits: Social"
    sql: LEFT JOIN UNNEST([${hits.social}]) as hits_social ;;
    relationship: one_to_one
  }

  join: hits_publisher {
    view_label: "Session: Hits: Publisher"
    sql: LEFT JOIN UNNEST([${hits.publisher}]) as hits_publisher ;;
    relationship: one_to_one
  }

  join: hits_appInfo {
    view_label: "Session: Hits: App Info"
    sql: LEFT JOIN UNNEST([${hits.appInfo}]) as hits_appInfo ;;
    relationship: one_to_one
  }

  join: hits_eventInfo{
    view_label: "Session: Hits: Events Info"
    sql: LEFT JOIN UNNEST([${hits.eventInfo}]) as hits_eventInfo ;;
    relationship: one_to_one
  }

  # join: hits_sourcePropertyInfo {
  #   view_label: "Session: Hits: Property"
  #   sql: LEFT JOIN UNNEST([hits.sourcePropertyInfo]) as hits_sourcePropertyInfo ;;
  #   relationship: one_to_one
  #   required_joins: [hits]
  # }

  # join: hits_eCommerceAction {
  #   view_label: "Session: Hits: eCommerce"
  #   sql: LEFT JOIN UNNEST([hits.eCommerceAction]) as  hits_eCommerceAction;;
  #   relationship: one_to_one
  #   required_joins: [hits]
  # }

  join: hits_customDimensions {
    view_label: "Session: Hits: Custom Dimensions"
    sql: LEFT JOIN UNNEST(${hits.customDimensions}) as hits_customDimensions ;;
    relationship: one_to_many
  }
  join: hits_customVariables{
    view_label: "Session: Hits: Custom Variables"
    sql: LEFT JOIN UNNEST(${hits.customVariables}) as hits_customVariables ;;
    relationship: one_to_many
  }
  join: first_hit {
    from: hits
    sql: LEFT JOIN UNNEST(${ga_sessions.hits}) as first_hit ;;
    relationship: one_to_one
    sql_where: ${first_hit.hitNumber} = 1 ;;
    fields: [first_hit.page]
  }
  join: first_page {
    view_label: "Session: First Page Visited"
    from: hits_page
    sql: LEFT JOIN UNNEST([${first_hit.page}]) as first_page ;;
    relationship: one_to_one
  }

  join: audience_selector {
    view_label: "Audience (OR)"
    type: inner
    relationship: many_to_many
    sql_on:
          ${ga_sessions.fullVisitorId} = ${audience_selector.fullvisitorID}
      AND ${ga_sessions.partition_date} = ${audience_selector.partition_date}
      ;;
      # and {%condition audience_selector.audience_selection%}audience_selector.audience{%endcondition%}
#          1=1
#       and strpos(coalesce(${audience_selector.hostname},${hits_page.hostName}), ${hits_page.hostName} )>0
#       -- and strpos(coalesce(cast(${audience_selector.medium} as string),${trafficSource.medium}), ${trafficSource.medium} )>0
#       -- and strpos(coalesce(cast(${audience_selector.source} as string),${trafficSource.source}), ${trafficSource.source} )>0
#       and strpos(coalesce(${audience_selector.usertype},${ga_sessions.usertype}), ${ga_sessions.usertype} )>0
#       -- and strpos(coalesce(cast(${audience_selector.dim63} as string),${ga_sessions.custom_dimension_63}), ${ga_sessions.custom_dimension_63} )>0
#       -- and strpos(coalesce(cast(${audience_selector.dim66} as string),${ga_sessions.custom_dimension_66}), ${ga_sessions.custom_dimension_66} )>0
    }

    join: audience_selector_and {
      from: audience_selector
      view_label: "Audience (AND)"
      type: inner
      relationship: many_to_many
      sql_on:
        ${ga_sessions.fullVisitorId} = ${audience_selector.fullvisitorID}
    AND ${ga_sessions.partition_date} = ${audience_selector.partition_date}
    ;;
      # and {%condition audience_selector.audience_selection%}audience_selector.audience{%endcondition%}
      }
    }

    persist_with: once_weekly

### PDT Timeframes

    datagroup: once_daily {
      max_cache_age: "24 hours"
      sql_trigger: SELECT current_date() ;;
    }

    datagroup: once_weekly {
      max_cache_age: "168 hours"
      sql_trigger: SELECT extract(week from current_date()) ;;
    }

    datagroup: once_monthly {
      max_cache_age: "720 hours"
      sql_trigger: SELECT extract(month from current_date()) ;;
    }

    datagroup: once_yearly {
      max_cache_age: "9000 hours"
      sql_trigger: SELECT extract(year from current_date()) ;;
    }
