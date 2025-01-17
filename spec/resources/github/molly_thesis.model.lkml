connection: "lookerdata_publicdata"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: molly_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: molly_thesis_default_datagroup



explore: flow {
  label: "Spinner Demographics"


  join: props {
    view_label: "Props"
    sql_on:  ${flow.PK} = ${props.PK} ;;
    type: left_outer
    relationship: many_to_one

}

  join: relationships {
    view_label: "Relationship Status"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${relationships.PK} ;;
}

  join: religion {
    view_label: "Spinner Religions"
    type: left_outer
    relationship: many_to_one
    sql_on:  ${flow.PK} = ${religion.PK} ;;
  }

  join: ethnicities {
  view_label: "Spinner Ethnicity"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${ethnicities.PK} ;;
  }

  join: professional_events {
    view_label: "Professional Events"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${professional_events.PK} ;;
  }

  join: festivals {
    view_label: "Festivals"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${festivals.PK} ;;
  }

  join: purchasing {
    view_label: "Purchase Criteria"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${purchasing.PK} ;;
  }

  join: video {
    view_label: "Video Watching Criteria"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${video.PK} ;;
  }

  join: learning {
    view_label: "Learning Methods"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${learning.PK} ;;
  }

  join: platformz {
    view_label: "Platforms"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${platformz.PK} ;;
  }

  join: devices {
    view_label: "Devices"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${flow.PK} = ${devices.PK} ;;
  }

  join: bq_logrecno_bg_map {
    type: left_outer
    relationship: many_to_many
    sql_on: ${bq_logrecno_bg_map.stusab}=${flow.state} ;;
  }


}
