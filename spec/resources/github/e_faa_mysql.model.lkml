connection: "faa"

# include all the views
include: "/views/*.view"
include: "/dashboards/*.dashboard.lookml"

datagroup: e_faa_mysql_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: e_faa_mysql_default_datagroup

explore: flights {
  view_name: flights
#  view_label: "flight_info"
# extension: required
   }

explore: flights_enhanced {
  view_name: flights
#  view_label: "flight_info"
# extension: required
}


explore: testing_extends {
  view_name: extending_view
}
explore: extended_explore {
  extends: [flights]
 # fields: [flights.number_of_engines,flights.event_date]
  }

#


#
#
#
# explore: aircraft {
#   extension: required
#   view_name: aircraft
#   view_label: "Aircraft"
# }
#
# explore: to_extend {
#   extends: [aircraft]
# #   join: aircraft_engine_types {
# #     type: left_outer
# #     sql_on: ${aircraft.aircraft_engine_type_id} = ${aircraft_engine_types.aircraft_engine_type_id} ;;
# #     relationship: many_to_one
# #   }
# #
# }
#
#


















# explore: aircraft_engine_types {
# #   view_name: aircraft_engine_types
# #   view_label: "Engine Types"
#   extends: [flights]
# }
#


#


explore: aircraft {
  join: aircraft_types {
    type: left_outer
    sql_on: ${aircraft.aircraft_type_id} = ${aircraft_types.aircraft_type_id} ;;
    relationship: many_to_one
  }

  join: aircraft_engine_types {
    type: left_outer
    sql_on: ${aircraft.aircraft_engine_type_id} = ${aircraft_engine_types.aircraft_engine_type_id} ;;
    relationship: many_to_one
  }
}


explore: aircraft_engines {
  join: aircraft_engine_types {
    type: left_outer
    sql_on: ${aircraft_engines.aircraft_engine_type_id} = ${aircraft_engine_types.aircraft_engine_type_id} ;;
    relationship: many_to_one
  }
}

explore: aircraft_models {
  join: aircraft_types {
    type: left_outer
    sql_on: ${aircraft_models.aircraft_type_id} = ${aircraft_types.aircraft_type_id} ;;
    relationship: many_to_one
  }

  join: aircraft_engine_types {
    type: left_outer
    sql_on: ${aircraft_models.aircraft_engine_type_id} = ${aircraft_engine_types.aircraft_engine_type_id} ;;
    relationship: many_to_one
  }
}

explore: aircraft_types {}

explore: airport_remarks {}

explore: airports {}

explore: carriers {}

explore: exceptions {}

explore: ontime {}

explore: states {}

explore: zipcodes {}
