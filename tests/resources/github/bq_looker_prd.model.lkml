connection: "phish_thesis"
label: "Mobile Master Data"
#{
include: "/views/firebase_bq/*.view.lkml"
#}
week_start_day: sunday

# Not queried last 90 days and duplicated from bq_looker_poc
# explore: migration_data_validation {
#   label: "Migration_validation"
#   hidden: yes
# }

explore: migration_validation_prd {
  label: "Migration_validation_ prd"
  hidden: yes
}

explore: bq_master_events {
  label: "Master Firebase Events"
  view_label: "Event"
  #repeated
  join: events__user_properties{
    view_label: "Event: User Properties"
    sql: LEFT JOIN UNNEST(${bq_master_events.user_properties}) as events__user_properties;;
    relationship: one_to_many
  }
  join: events__user_properties__value{
    view_label: "Event: User Properties: Value"
    sql: LEFT JOIN UNNEST([${events__user_properties.value}]) as events__user_properties__value;;
    relationship: one_to_one
  }
  join: events__traffic_source {
    view_label: "Event: Traffic Source"
    sql: LEFT JOIN UNNEST([${bq_master_events.traffic_source}]) as events__traffic_source;;
    relationship: one_to_one
  }
  #repeated
  join: events__event_params {
    view_label: "Event: Event Parameters"
    sql: left join unnest(${bq_master_events.event_params}) as events__event_params;;
    relationship: one_to_many
  }
  join: events__event_params__value {
    view_label: "Event: Event Parameters: Value"
    sql: left join unnest([${events__event_params.value}]) as events__event_params__value;;
    relationship: one_to_one
  }
  join: events__geo {
    view_label: "Event: Geo"
    sql: LEFT JOIN UNNEST([${bq_master_events.geo}]) as events__geo;;
    relationship: one_to_one
  }
  join: events__app_info {
    view_label: "Event: App Info"
    sql: LEFT JOIN unnest([${bq_master_events.app_info}]) as events__app_info ;;
    relationship: one_to_one
  }
  join: events__device {
    view_label: "Event: Device"
    sql: LEFT JOIN unnest([${bq_master_events.device}]) as events__device;;
    relationship: one_to_one
  }
  join: events__device__web_info {
    view_label: "Event: Device: Web Info"
    sql: LEFT JOIN unnest([${events__device.web_info}]) as events__device__web_info ;;
    relationship: one_to_one
  }
  join: events__event_dimensions {
    view_label: "Event: Event Dimensions"
    sql: LEFT JOIN UNNEST([${bq_master_events.event_dimensions}]) as events__event_dimensions ;;
    relationship: one_to_one
  }
}
explore: bq_sub_events_table {
  label: "Table Subset Firebase Events"
  view_label: "Firebase: Sub Events"
}

explore: firebase_tcvr {
  label: "Firebase tCVR"
  hidden: no
}

explore: quality_check_feed {
  label:"Feed_quality_check"
}

explore: firebase_funnel {
  label: "Firebase Funnel"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}

explore: firebase_funnels {
  label: "Firebase Funnels"
  hidden: no
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}


explore: firebase_event_users_share {
  label: "Firebase event users share"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}

explore: firebase_events_sequence {
  label: "Firebase events sequences"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}



explore: firebase_events_sequence_backwards {
  label: "Firebase events sequences backwards"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}



explore: firebase_event_retention {
  label: "Firebase event retention"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}

explore: firebase_session_length_distribution {
  label: "Firebase session length distribution"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}

explore: firebase_sessions_by_length {
  label: "Firebase sessions by length"
  hidden: no
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}

explore: firebase_first_event_based_retention {
  label: "Firebase First Event Based Retention"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}

explore: firebase_users_distribution_by_event_frequency {
  label: "Firebase Users Distribution by Event Frequency"
  hidden: yes
  always_filter: {
    filters: {
      field: platform
      value: "iOS"
    }
    filters: {
      field: application
      value: "NOAA Radar"
    }
  }
}

explore: firebase_adjust_discrepancy {
  label: "Firebase and Adjust discrepancy"
  hidden:  no
}



explore: firebase_purchases {
  label: "Firebase purchase by source"
  hidden:  no
}


explore: firebase_purchases_eventdate {
  label: "Firebase purchases by eventdate"
  hidden:  no
}

explore: firebase_follow_flight {
  description: "followed flights per month (per user)"
  label: "Followed Fligts"
  hidden: no}