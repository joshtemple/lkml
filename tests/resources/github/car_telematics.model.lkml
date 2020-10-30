connection: "intelematics_redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

# explore: intelematics_devices {}

# explore: intelematics_push_admin_events {}

# explore: intelematics_push_dtcs {}

# explore: intelematics_trips {}

# explore: intelematics_vehicles {}

# explore: intelematics_trip_IDs {}

 explore: car_telematics {
   view_name: intelematics_devices
    view_label: "Devices"

  join: intelematics_trip_IDs {
    type: inner
    sql_on: ${intelematics_devices.id} = ${intelematics_trip_IDs.deviceid} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: intelematics_vehicles {
    view_label: "Vehicles"
    type: inner
    sql_on: ${intelematics_trip_IDs.vehicleid} = ${intelematics_vehicles.id} ;;
    relationship: one_to_one
    type: left_outer
  }

  join: intelematics_trips {
    view_label: "Trips"
    type: inner
    sql_on: ${intelematics_devices.id} = ${intelematics_trips.deviceid} AND ${intelematics_trip_IDs.vehicleid} = ${intelematics_trips.vehicleid}  AND ${intelematics_trip_IDs.driverid} = ${intelematics_trips.driverid};;
    relationship: one_to_many
    type: left_outer
  }

  join: intelematics_push_dtcs {
    view_label: "Diagnostic Trouble Codes"
    type: inner
    sql_on: ${intelematics_trips.id} = ${intelematics_push_dtcs.tripid} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: intelematics_push_events {
    view_label: "Events"
    type: inner
    sql_on: ${intelematics_devices.id} = ${intelematics_push_events.deviceid} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: intelematics_push_event_attributes {
    view_label: "Event Attributes"
    type: inner
    sql_on: ${intelematics_push_events.rs_id} = ${intelematics_push_event_attributes.rs_pusheventid} ;;
    relationship: one_to_many
    type: left_outer
  }

  join: intelematics_push_admin_events {
    view_label: "Admin Events"
    type: inner
    sql_on: ${intelematics_devices.id} = ${intelematics_push_admin_events.deviceid} ;;
    relationship: one_to_many
    type: left_outer
  }

 }
