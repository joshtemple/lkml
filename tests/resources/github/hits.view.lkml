#############################################################################################################
# Purpose: Defines the fields within the hits struct in google analytics. A hit can be either a Page View or Event that occurs on a page.
# This view is joined to the ga_sessions explore by unnesting this view.
# See documentation on Nested fields in BigQuery here: https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays#querying_nested_arrays
#############################################################################################################
include: "Custom_Views/goals.view.lkml"
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/hits.view.lkml"

view: hits {
  extends: [hits_config]
}

view: hits_core {
  extension: required
  extends: [goals]
  view_label: "Hits"
  ########## PRIMARY KEYS ##########

  dimension: id {
    primary_key: yes
    view_label: "Session"
    label: "Hit ID"
    group_label: "ID"
    description: "Unique Session ID | Hit Number"
    sql: CONCAT(${ga_sessions.id},'|',FORMAT('%05d',${hit_number})) ;;
  }

  ########## DIMENSIONS ##########

  dimension: custom_dimensions {
    description: "Used for unnesting the custom dimension struct in the table. This dimension should not be queried directly"
    hidden: yes
    sql: ${TABLE}.customdimensions ;;
  }

  dimension: custom_variables {
    description: "Used for unnesting the custom dimension struct in the table. This dimension should not be queried directly"
    hidden: yes
    sql: ${TABLE}.customvariables ;;
  }

  dimension: data_source {
    group_label: "Platform or Device"
    description: "The data source of a hit. By default, hits sent from analytics.js are reported as 'web' and hits sent from the mobile SDKs are reported as 'app'. These values can be overridden in the Measurement Protocol."
    type: string
    sql: ${TABLE}.dataSource ;;
  }

  dimension: event_action {
    view_label: "Behavior"
    group_label: "Event Tracking"
    description: "Action tied to event"
    type: string
    sql: ${TABLE}.eventInfo.eventAction ;;

    drill_fields: [event_category, event_label, event_value]
  }

  dimension: event_category {
    view_label: "Behavior"
    group_label: "Event Tracking"
    description: "The event category"
    type: string
    sql: ${TABLE}.eventInfo.eventCategory ;;

    drill_fields: [event_action, event_label, event_value]
  }

  dimension: event_label {
    view_label: "Behavior"
    group_label: "Event Tracking"
    description: "Label tied to event"
    type: string
    sql: ${TABLE}.eventInfo.eventLabel ;;

    drill_fields: [event_action, event_category, event_value]
  }
  dimension: event_value {
    view_label: "Behavior"
    group_label: "Event Tracking"
    description: "Total value of web events for the profile."
    type: number
    sql: ${TABLE}.eventInfo.eventValue ;;

    drill_fields: [event_action, event_category, event_label]
  }

  dimension: full_event {
    view_label: "Behavior"
    group_label: "Event Tracking"
    description: "Concatenation of Event Category, Event Label, Event Action, and Page. Each are only included if there is a value."
    type: string
    sql: CONCAT(
          IF(${event_category} IS NOT NULL, CONCAT(${event_category}, ": "), "")
          , IF(${event_action} IS NOT NULL, CONCAT(${event_action}, " "), "")
          , IF(${event_label} IS NOT NULL, CONCAT(${event_label}, " "), "")
          , IF(${page_path_formatted} IS NOT NULL, CONCAT("on ", ${page_path_formatted}), "")
        );;
  }

  dimension: full_page_url {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Full Page URL"
    description: "The full URL including the hostname and path."
    type: string
    sql: CONCAT(${host_name}, ${page_path_formatted});;

    link: {
      label: "Go to Page"
      url: "https://{{ value }}"
    }
  }

  dimension: full_page_url_parameters {
    view_label: "Behavior"
    group_label: "Pages (with Parameters)"
    label: "Full Page URL (with Parameters)"
    description: "The full URL including the hostname and path."
    type: string
    sql: CONCAT(${host_name}, ${page_path});;

    link: {
      label: "Go to Page"
      url: "https://{{ value }}"
    }
  }

  dimension_group: hit {
    timeframes: [time, date]
    type: time
    sql: TIMESTAMP_MILLIS(${ga_sessions.visit_start_seconds}*1000 + ${time}) ;;
    convert_tz: no
  }

  dimension: hit_number {
    description: "The sequenced hit number. For the first hit of each session, this is set to 1."
    type: number
    sql: ${TABLE}.hitNumber ;;
  }

  dimension: host_name {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Hostname"
    description: "The hostname from which the tracking request was made."
    sql: ${TABLE}.page.hostName ;;

    link: {
      label: "Go To Link"
      url: "https://{{ value }}"
    }
  }

  dimension: hour {
    view_label: "Hits"
    group_label: "Hit Date"
    description: "The hour in which the hit occurred (0 to 23) in the timezone configured for the account."
    type: number
    sql: ${TABLE}.hour ;;
  }

  dimension: is_entrance {
    view_label: "Behavior"
    group_label: "Page Filters"
    label: "Is Landing Page"
    description: "Use to filter for first pageview of a session. Use with Page dimensions."
    type: yesno
    sql: ${TABLE}.isEntrance ;;
  }

  dimension: is_exit {
    view_label: "Behavior"
    group_label: "Page Filters"
    description: "If this hit was the last pageview or screenview hit of a session, this is set to true."
    type: yesno
    sql: ${TABLE}.isExit ;;
  }

  dimension: is_interaction {
    view_label: "Behavior"
    group_label: "Page Filters"
    description: "If this hit was an interaction, this is set to true. If this was a non-interaction hit (i.e., an event with interaction set to false), this is false."
    type: yesno
    sql: ${TABLE}.isInteraction ;;
  }

  dimension: minute {
    view_label: "Hits"
    group_label: "Hit Date"
    description: "Returns the minutes, between 00 and 59, in the hour."
    type: number
    sql: ${TABLE}.minute ;;
  }

  dimension: page_path {
    view_label: "Behavior"
    group_label: "Pages (with Parameters)"
    label: "Page (with Parameters)"
    description: "A page on the website specified by path and/or query parameters. Use this with hostname to get the page's full URL."
    sql: ${TABLE}.page.pagePath ;;
  }

  dimension: page_path_formatted {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Page"
    description: "The url of the page."
    type: string
    sql: SPLIT(${page_path}, '?')[OFFSET(0)];;
  }

  dimension: page_path_level_1 {
    view_label: "Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths in the first hierarchical level in pagePath."
    sql: ${TABLE}.page.pagePathLevel1 ;;
  }

  dimension: page_path_level_2 {
    view_label: "Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths in the second hierarchical level in pagePath."
    sql: ${TABLE}.page.pagePathLevel2 ;;
  }

  dimension: page_path_level_3 {
    view_label: "Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths in the third hierarchical level in pagePath."
    sql: ${TABLE}.page.pagePathLevel3 ;;
  }

  dimension: page_path_level_4 {
    view_label: "Behavior"
    group_label: "Pages"
    description: "This dimension rolls up all the page paths into hierarchical levels. Up to 4 pagePath levels maybe specified. All additional levels in the pagePath hierarchy are also rolled up in this dimension."
    sql: ${TABLE}.page.pagePathLevel4 ;;
  }

  dimension: page_title {
    view_label: "Behavior"
    group_label: "Pages"
    description: "The page's title. Multiple pages might have the same page title."
    sql: ${TABLE}.page.pageTitle ;;

    drill_fields: [page_path]
  }

  dimension: referer {
    description: "The previous page that directed the user to this page"
    hidden: yes
    type: string
    sql: ${TABLE}.referer ;;
  }

  dimension: search_category {
    view_label: "Behavior"
    group_label: "Internal Site Search"
    label: "Site Search Category"
    description: "The category used for the internal search if site search categories are enabled in the view. For example, the product category may be electronics, furniture, or clothing."
    sql: ${TABLE}.page.searchCategory ;;
  }

  dimension: search_keyword {
    view_label: "Behavior"
    group_label: "Internal Site Search"
    label: "Search Term"
    description: "Search term used within the property."
    sql: ${TABLE}.page.searchKeyword ;;
  }

  dimension: social_interaction_action {
    hidden: yes
    group_label: "Social Interactions"
    label: "Social Action"
    description: "For social interactions, this is the social action (e.g., +1, bookmark) being tracked."
    type: string
    sql: ${TABLE}.social.socialInteractionAction ;;
  }

  dimension: social_interaction_network {
    hidden: yes
    group_label: "Social Interactions"
    description: "For social interactions, this represents the social network being tracked."
    type: string
    sql: ${TABLE}.social.socialInteractionNetwork ;;
  }

  dimension: social_interaction_target {
    hidden: yes
    group_label: "Social Interactions"
    label: "Social Entity"
    description: "For social interactions, this is the URL (or resource) which receives the social network action."
    type: string
    sql: ${TABLE}.social.socialInteractionTarget ;;
  }

  dimension: social_network {
    view_label: "Acquisition"
    group_label: "Traffic Sources"
    description: "The social network name. This is related to the referring social network for traffic sources; e.g., Google+, Blogger."
    type: string
    sql: ${TABLE}.social.socialNetwork ;;
  }

  dimension: social_network_and_action {
    hidden: yes
    group_label: "Social Interactions"
    description: "For social interactions, this is the concatenation of the socialInteractionNetwork and socialInteractionAction action (e.g., Google: +1) being tracked at this hit level."
    type: string
    sql: ${TABLE}.social.socialInteractionNetworkAction ;;
  }

  dimension: time {
    label: "Time Elapsed Since Session Start"
    group_label: "Hit Date"
    description: "The time elapsed since the Session Start Date when this hit was registered. The first hit in a session has a value of 0"
    type: number
    sql: ${TABLE}.time ;;
  }

  dimension: type {
    label: "Hit Type"
    description: "The type of hit: PAGE or EVENT"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unique_social_interactions {
    description: "Number of unique social interactions"
    hidden: yes
    type: number
    sql: ${TABLE}.social.uniqueSocialInteractions ;;
  }

  ########## MEASURES ##########

  measure: count {
    group_label: "Hits"
    label: "Hits"
    description: "Total number of hits within the session."
    type: count

    value_format_name: formatted_number
    drill_fields: [detail*]
  }

  measure: entrance_pageviews_total {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Entrances"
    description: "The number of entrances to the property measured as the first pageview in a session, typically used with landingPagePath."
    type: count_distinct
    sql: ${id} ;;

    filters: {
      field: is_entrance
      value: "Yes"
    }

    value_format_name: formatted_number
    drill_fields: [detail*]
  }
  measure: entrance_rate {
    view_label: "Behavior"
    group_label: "Pages"
    description: "The percentage of pageviews in which this page was the entrance."
    type: number
    sql: ${entrance_pageviews_total}/NULLIF(${page_count}, 0) ;;
    value_format_name: percent_2
  }

  measure: event_count {
    view_label: "Behavior"
    group_label: "Events"
    label: "Total Events"
    description: "The total number of web events for the event."
    type: count_distinct
    sql: ${id} ;;

    filters: {
      field: type
      value: "EVENT"
    }

    value_format_name: formatted_number
    drill_fields: [event_category, event_action, event_label, event_value, event_count, unique_event_count]
  }

  measure: exit_pageviews_total {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Exits"
    description: "The number of exits from the property."
    type: count_distinct
    sql: ${id} ;;

    filters: {
      field: is_exit
      value: "Yes"
    }

    value_format_name: formatted_number
    drill_fields: [detail*]
  }

  measure: exit_rate {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Exit Rate"
    description: "Exit is (number of exits) / (number of pageviews) for the page or set of pages. It indicates how often users exit from that page or set of pages when they view the page(s)."
    type: number
    sql: ${exit_pageviews_total}/NULLIF(${page_count}, 0) ;;

    value_format_name: percent_2
  }

  measure: page_count {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Pageviews"
    description: "The total number of pageviews for the property."
    type: count_distinct
    sql: ${id} ;;

    filters: {
      field: type
      value: "PAGE"
    }

    value_format_name: formatted_number
    drill_fields: [ga_sessions.visit_start_date, unique_page_count, entrance_pageviews_total, exit_pageviews_total, time_on_page.average_time_on_page]
  }

  measure: events_per_session {
    view_label: "Session"
    group_label: "Session"
    label: "Events / Sessions"
    description: "The average number of web events per session (with web event)."
    type: number
    sql: ${event_count}/NULLIF(${sessions_with_events},0);;

    value_format_name: decimal_2
    drill_fields: [detail*]
  }

  measure: sessions_with_events {
    view_label: "Session"
    group_label: "Session"
    description: "The total number of sessions with web events."
    type: count_distinct
    sql: ${ga_sessions.id} ;;

    filters: {
      field: type
      value: "EVENT"
    }

    value_format_name: formatted_number
    drill_fields: [detail*]
  }

  measure: unique_page_count {
    view_label: "Behavior"
    group_label: "Pages"
    label: "Unique Pageviews"
    description: "Unique Pageviews are the number of sessions during which the specified page was viewed at least once. A unique pageview is counted for each page URL + page title combination."
    type: count_distinct
    sql: CONCAT(${ga_sessions.id}, ${page_path}, ${page_title});;

    filters: {
      field: type
      value: "PAGE"
    }

    value_format_name: formatted_number
    drill_fields: [event_category, event_action, event_label, event_value, event_count, unique_event_count]
  }

  measure: unique_event_count {
    view_label: "Behavior"
    group_label: "Events"
    label: "Unique Events"
    description: "Unique Events are interactions with content by a single user within a single session that can be tracked separately from pageviews or screenviews."
    type: count_distinct
    sql: CONCAT(${ga_sessions.id}, COALESCE(${event_action},""), COALESCE(${event_category},""), COALESCE(${event_label},"")) ;;

    filters: {
      field: type
      value: "EVENT"
    }

    value_format_name: formatted_number
    drill_fields: [detail*]
  }

  ########## SETS ##########

  set: detail {
    fields: [
      ga_sessions.id
      , ga_sessions.visitnumber
      , hit_number
      , page_path
      , page_title
      , event_category
      , event_action
      , event_label
      , event_value
      , ga_sessions.session_count
    ]
  }
}
