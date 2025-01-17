#############################################################################################################
# Purpose: Defines the fields within the traffic source struct in google analytics. Is extending into ga_sessions.view.lkml
#          and should not be joined into GA sessions explore as an independent view file.
#############################################################################################################
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/traffic_source.view.lkml"

view: traffic_source {
  extends: [traffic_source_config]
}


view: traffic_source_core {
  extension: required

  ########## DIMENSIONS ############

  dimension: adcontent {
    view_label: "Acquisition"
    group_label: "Advertising"
    label: "Ad Content"
    description: "The ad content of the traffic source. Can be set by the utm_content URL parameter."
    sql: ${TABLE}.trafficsource.adContent ;;

    drill_fields: [campaign, keyword, source, source_medium]
  }

  dimension: campaign {
    view_label: "Acquisition"
    group_label: "Advertising"
    description: "The campaign value. Usually set by the utm_campaign URL parameter."
    type: string
    sql: ${TABLE}.trafficsource.campaign ;;
    drill_fields: [ad_content, keyword, source, source_medium]
  }

  dimension: campaigncode {
    hidden: yes
    view_label: "Acquisition"
    group_label: "Advertising"
    label: "Campaign Code"
    description: "Value of the utm_id campaign tracking parameter, used for manual campaign tracking."
    type: string
    sql: ${TABLE}.trafficsource.campaignCode ;;
  }


  dimension: full_referrer {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The full referring URL including the hostname and path."
    type: string
    sql:IF(${medium} = "referral", CONCAT(${source}, ${referralpath}), NULL);;
  }

  dimension: keyword {
    view_label: "Acquisition"
    group_label: "Advertising"
    description: "The keyword of the traffic source, usually set when the trafficSource.medium is 'organic' or 'cpc'. Can be set by the utm_term URL parameter."
    type: string
    sql: ${TABLE}.trafficsource.keyword ;;

   drill_fields: [ad_content, campaign, source, source_medium]
  }

  dimension: medium {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The medium of the traffic source. Could be 'organic', 'cpc', 'referral', or the value of the utm_medium URL parameter."
    type: string
    sql: ${TABLE}.trafficsource.medium ;;

   drill_fields: [ad_content, campaign, keyword, source, source_medium]
  }

  dimension: referralpath {
    label: "Referral Path"
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "If medium is 'referral', then this is set to the path of the referrer. (The host name of the referrer is in source.)"
    sql: ${TABLE}.trafficsource.referralPath ;;

    drill_fields: [source]
  }

  dimension: source {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The source of the traffic source. Could be the name of the search engine, the referring hostname, or a value of the utm_source URL parameter."
    type: string
    sql: ${TABLE}.trafficsource.source ;;

   drill_fields: [ad_content, campaign, keyword, source_medium]
  }

  dimension: source_medium {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    label: "Source / Medium"
    description: "Combined values of source and medium."
    type: string
    sql: CONCAT(${source}, ' / ', ${medium}) ;;

   drill_fields: [ad_content, campaign, keyword, source]
  }

  ########## MEASURES ############

  measure: keyword_count {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "Counts distinct keywords grouped by specified dimension."
    type: count_distinct
    sql: ${keyword} ;;
    drill_fields: [keyword, totals.hits, totals.pageviews]
  }

  measure: source_count {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "Counts distinct sources grouped by specified dimension."
    type: count_distinct
    sql: ${source} ;;
    drill_fields: [source, totals.hits, totals.pageviews]
  }

  measure: source_list {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "Concatenates a list from the source field grouped on specified dimension."
    type: list
    list_field: source
  }
}
