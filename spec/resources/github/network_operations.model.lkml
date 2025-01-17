connection: "joyent"

# include all the views
include: "*.view"
include: "*.dashboard.lookml"


  # sql_trigger: SELECT MAX(id) FROM etl_log;;
datagroup: network_operations_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: network_operations_default_datagroup

explore: Events {
  from:  events
  group_label: "Opennms Events"
  view_label: "Sorted Events"
  description: "All events broken down by datacenter"
  join: az{
    view_label: "RegionDetails"
    sql_on: ${Events.azid}=${az.azid} ;;
    type: left_outer
    relationship: many_to_one
    fields: [az.region]
  }
}

explore: TimeSeries {
  from:  check
  group_label: "ISP Bandwidth"
  view_label: "Check"
  description: "Bandwidth Timseries 5min increments"

  join: bandwidthio {
    view_label: "Traffic"
    sql_on: ${TimeSeries.checkid}=${bandwidthio.checkid} ;;
    type: inner
    relationship: many_to_one
  }

  join: az{
    view_label: "RegionDetails"
    sql_on: ${TimeSeries.azid}=${az.azid} ;;
    type: inner
    relationship: many_to_one
  }
  join: isp {
    view_label: "ISPDetails"
    sql_on: ${TimeSeries.ispid}=${isp.ispid} ;;
    type: inner
    relationship: many_to_one
  }
}

explore: By_ISP_AGG{
  from: ispaggregate
  description: "ISP Bandwidth data by ISP"
  group_label: "ISP Bandwidth"
  view_label: "Bandwidth By ISP"
}

explore: Telia_Global_AGG{
  from: ispglobal
  description: "ISP Bandwidth data by ISP"
  group_label: "ISP Bandwidth"
  view_label: "Bandwidth By ISP"
}
