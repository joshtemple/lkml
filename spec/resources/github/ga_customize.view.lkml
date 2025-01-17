include: "ga_block.view.lkml"

named_value_format: duration_hms {
  value_format: "hh:mm:ss"
}

named_value_format: duration_hms_full {
  value_format: "h \h\r\s m \m\i\n\s s \s\e\c\s"
}

explore: ga_sessions_block {
  extends: [ga_sessions_base]
  extension: required

}

view: ga_sessions {
  extends: [ga_sessions_base]

  dimension: partition_date {
    type: date_time
    sql: TIMESTAMP(PARSE_DATE('%Y%m%d', CONCAT('2', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d{7}$'))))  ;;
  }
  # The SQL_TABLE_NAME must be replaced here for date partitioned queries to work properly.

#   sql_table_name: `115907067.ga_sessions_*` ;;
# {% if plat contains 'MindTap' %} `titanium-kiln-120918.157271542.ga_realtime_sessions_2*`

  sql_table_name: {% assign plat = ga_sessions.platform_selector._sql %}
                  {% if plat contains 'MindTap' %} `titanium-kiln-120918.157271542.ga_sessions_*`
                  {% elsif plat contains 'Aplia' %} `titanium-kiln-120918.116189617.ga_sessions_*`
                  {% elsif plat contains 'SAM' %} `titanium-kiln-120918.117564478.ga_sessions_*`
                  {% elsif plat contains 'MindTap Mobile' %} `titanium-kiln-120918.92812344.ga_sessions_*`
                  {% elsif plat contains 'CNow V7' %} `titanium-kiln-120918.121361627.ga_sessions_*`
                  {% elsif plat contains 'CNow V8' %} `titanium-kiln-120918.116197107.ga_sessions_*`
                  {% elsif plat contains 'CNow MindApp' %} `titanium-kiln-120918.59849884.ga_sessions_*`
                  {% elsif plat contains 'Math Foundations' %} `titanium-kiln-120918.130478431.ga_sessions_*`
                  {% elsif plat contains 'CU Dashboard - Non Prod' %} `nth-station-121323.175946426.ga_sessions_*`
                  {% elsif plat contains 'WebAssign' %} `nth-station-121323.109606989.ga_sessions_*`
                  {% elsif plat contains 'CU Dashboard' %} `titanium-kiln-120918.120306540.ga_sessions_*`
                  {% elsif plat contains 'GA Reference Property'%} `nth-station-121323.154104704.ga_realtime_sessions_view_*`
                  {% elsif plat contains 'Realtime Dashboard' %} `titanium-kiln-120918.120306540.ga_realtime_sessions_*`
                  {% elsif plat contains 'Milady' %} `titanium-kiln-120918.116935769.ga_sessions_*`
                  {% elsif plat contains 'Delmar' %} `titanium-kiln-120918.31584948.ga_sessions_*`
                  {% endif %}
                  ;;

  filter: platform_picker {
    suggestions: [
      "MindTap"
      ,"CU Dashboard"
      #,"CU Dashboard - Non Prod"
      ,"Aplia"
      ,"SAM"
      ,"WebAssign"
      ,"CNow V7 - broken awaiting PII confirmation"
      ,"CNow V8 - broken awaiting PII confirmation"
      ,"CNow MindApp - broken awaiting PII confirmation"
      ,"Math Foundations"
      ,"GA Reference Property"
      ,"Realtime Dashboard"
      ,"Milady - bigquery linked but not working"
      ,"Delmar"
      ]

  }

  dimension: platform_selector {
    type: string
    hidden: no
    sql: {% parameter platform_picker %} ;;
  }

  # dimension: custom_dimension_2 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=2) ;;
  # }

  # dimension: custom_dimension_3 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=3) ;;
  # }
}

view: geoNetwork {
  extends: [geoNetwork_base]
}

view: totals {
  extends: [totals_base]

  #measure: timeonsite_total {hidden: yes}

  measure: timeonsite_total {
    label: "Time On Site"
    type: sum
    sql: ${TABLE}.timeonsite / 60 / 60 / 24 ;;
    value_format: "hh:mm:ss"
  }

  dimension: timeonsite_tier {
    label: "Time On Site Tier"
    type: tier
    sql: ${TABLE}.timeonsite ;;
    tiers: [0,15,30,60,90,120,180,240,300,600]
    style: relational
    value_format_name: duration_hms_full
  }
  measure: timeonsite_average_per_session {
    label: "Time On Site Average Per Session"
    type: number
    sql: 1.0 * ${timeonsite_total} / NULLIF(${ga_sessions.session_count},0) ;;
    value_format_name: duration_hms_full
  }
}

view: trafficSource {
  extends: [trafficSource_base]
}

view: device {
  extends: [device_base]
}

view: hits {
  extends: [hits_base]

  measure: latest_hit {
    type: date_time
    sql: max(${hit_raw}) ;;
  }
}

view: hits_page {
  extends: [hits_page_base]

  measure: pagePath_example {
    type: string
    sql: ANY_VALUE(${pagePath}) ;;
  }
}

# -- Ecommerce Fields

view: hits_transaction {
  #extends: [hits_transaction_base]  # Comment out to remove fields
}

view: hits_item {
  #extends: [hits_item_base]
}

# -- Advertising Fields

view: adwordsClickInfo {
  #extends: [adwordsClickInfo_base]
}

view: hits_publisher {
  #extends: [hits_publisher_base]   # Comment out this line to remove fields
}

#  We only want some of the interaction fields.
view: hits_social {
  extends: [hits_social_base]

  dimension: socialInteractionNetwork {hidden: yes}

  dimension: socialInteractionAction {hidden: yes}

  dimension: socialInteractions {hidden: yes}

  dimension: socialInteractionTarget {hidden: yes}

  #dimension: socialNetwork {hidden: yes}

  dimension: uniqueSocialInteractions {hidden: yes}

  #dimension: hasSocialSourceReferral {hidden: yes}

  dimension: socialInteractionNetworkAction {hidden: yes}
}


view: hits_appInfo {
  extends: [hits_appInfo_base]
}

view: hits_eventInfo {
  extends: [hits_eventInfo_base]
  dimension: play {
    sql: ${eventAction} = "play" ;;
    type: yesno
  }
  measure: eventAction_example {
    label: "Event Action (example value)"
    sql: any_value(${eventAction});;
  }
  measure: eventAction_unique {
    type: number
    label: "Event Action (unique values)"
    sql: count(distinct ${eventAction});;
  }
  measure: eventAction_null {
    type: number
    label: "Event Action (blank or null values)"
    sql: count(case when ${eventAction} is null or ${eventAction} = '' then 1 end )
      / count(*) ;;
    value_format_name: percent_1
  }
  measure: eventLabel_example {
    label: "Event Label (example value)"
    sql: any_value(${eventLabel});;
  }
  measure: eventLabel_unique {
    type: number
    label: "Event Label (unique values)"
    sql: count(distinct ${eventLabel});;
  }
  measure: eventLabel_null {
    type: number
    label: "Event Label (blank or null values)"
    sql: count(case when ${eventLabel} is null or ${eventLabel} = '' then 1 end )
      / count(*) ;;
    value_format_name: percent_1
  }
  measure: eventValue_example {
    label: "Event Value (example value)"
    sql: any_value(${eventValue});;
  }
  measure: eventValue_unique {
    type: number
    label: "Event Value (unique values)"
    sql: count(distinct ${eventValue});;
  }
  measure: eventValue_null {
    type: number
    label: "Event Value (blank or null values)"
    sql: count(case when ${eventValue} is null or SAFE_CAST(${eventValue} AS STRING) = '' then 1 end )
      / count(*) ;;
    value_format_name: percent_1
  }
  dimension: search_term {
    type: string
    sql: case when ${eventAction} = 'Search Term | First Result | ISBN' then SPLIT(${eventLabel}, '|')[OFFSET(0)] end ;;
  }

  dimension: search_term_cat {
    type: string
    sql: case
          when ${search_term} like '9____________' then 'Specific ISBN'
          when ${search_term} like '1-__-_____-_' then 'Specific ISBN 2'
          else ${search_term} end   ;;
  }

}

view: hits_customDimensions {
  extends: [hits_customDimensions_base]

  dimension: id {
    sql: ${hits.id} ;;
    primary_key: yes
    hidden: yes
  }

  dimension: index {
    sql: safe_cast(hits_customDimensions.index as string) ;;
  }

  dimension: eventCategory {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.eventCategory') ;;
  }

  dimension: eventAction {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.eventAction') ;;
  }

  dimension: event {
    sql: CONCAT(COALESCE(CONCAT(NULLIF(${eventAction}, ${eventCategory}), ' '), ''), ${eventCategory})  ;;
  }

  dimension: eventLabel {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.eventLabel') ;;
  }

  dimension: userRole {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.userRole') ;;
  }

  dimension: coreTextISBN {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.coreTextISBN') ;;
  }

  dimension: localTime {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.localTime') ;;
  }

  dimension: userssoguid {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.userSSOGuid') ;;
  }

  dimension: readingPageView {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.readingPageView') ;;
  }

  dimension: readingPageCount {
    sql: JSON_EXTRACT_SCALAR(${value}, '$.readingPageCount') ;;
  }

  dimension: userSSOGuid {
    type: string
    sql: JSON_EXTRACT_SCALAR(${value}, '$.userSSOGuid') ;;
    hidden: yes
  }

  dimension: courseKey {
    type: string
    sql: JSON_EXTRACT_SCALAR(${value}, '$.courseKey') ;;
  }

  dimension: eventValue {
    type: number
    sql: SAFE_CAST(JSON_EXTRACT_SCALAR(${value}, '$.eventValue') AS INT64) ;;
  }

  measure: eventValue_total {
    type: sum
    sql: ${eventValue} ;;
  }

  measure: user_count {
    type: count_distinct
    sql: ${userSSOGuid} ;;
  }

  measure: eventValue_average {
    type: average
    sql: ${eventValue} ;;
  }

}

view: hits_customVariables {
  extends: [hits_customVariables_base]
}
