connection: "jonallenbq"
label: "Jon Allen Uh Oh I Broke It"
datagroup: f1_datagroup {
  max_cache_age: "168 hours"
  sql_trigger: SELECT MAX(resultId) FROM `ruddypangolin.f1.results` ;;
}
include: "circuits.view.lkml"
include: "constructor_facts.view.lkml"
include: "constructor_results.view.lkml"
include: "constructor_standings.view.lkml"
include: "constructors.view.lkml"
include: "driver.view.lkml"
include: "driver_facts.view.lkml"
include: "driver_lineup.view.lkml"
include: "driver_standings.view.lkml"
include: "lap_times.view.lkml"
include: "pit_stops.view.lkml"
include: "qualifying.view.lkml"
include: "race_facts.view.lkml"
include: "season_facts.view.lkml"
include: "races.view.lkml"
include: "results.view.lkml"
include: "seasons.view.lkml"
include: "status.view.lkml"
include: "circuit_dt.view.lkml"

# include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: circuit_dt {
  join: circuits {
    relationship: many_to_one
    sql_on: ${circuits.circuit_id} = circuit_dt.circuitid ;;
  }
}

explore: results {
  label: "F1"
  join: driver {
    type: left_outer
    relationship: many_to_one
    sql_on: ${driver.driver_id} = ${results.driver_id} ;;
  }
  join: driver_standings {
    type: left_outer
    relationship: one_to_many
    sql_on: ${driver_standings.driver_id} = ${driver.driver_id} AND ${driver_standings.race_id} = ${races.race_id} ;;
  }
  join: constructors {
    type: left_outer
    relationship: many_to_one
    sql_on: ${constructors.constructor_id} = ${results.constructor_id} ;;
  }
  join: constructor_facts {
    type: left_outer
    relationship: one_to_one
    sql_on: ${constructor_facts.constructor_id} = ${constructors.constructor_id} ;;
  }
  join: constructor_standings {
    type: left_outer
    relationship: one_to_many
    sql_on: ${constructor_standings.constructor_id} = ${constructors.constructor_id} AND ${constructor_standings.race_id} = ${races.race_id} ;;
  }
  join: races {
    type: full_outer
    relationship: many_to_one
    sql_on: ${races.race_id} = ${results.race_id} ;;
  }
  join: race_facts{
    type: full_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }
  join: season_facts {
    type: left_outer
    relationship: one_to_one
    sql_on: ${seasons.year} = ${season_facts.year} ;;
  }
  join: circuits {
    type: left_outer
    relationship: many_to_one
    sql_on: ${circuits.circuit_id} = ${races.circuit_id} ;;
  }
  join: status {
    type: left_outer
    relationship: many_to_one
    sql_on: ${status.status_id} = ${results.status_id} ;;
  }
  join: lap_times {
    type: left_outer
    relationship: one_to_many
    sql_on: ${lap_times.race_id} = ${races.race_id} AND ${lap_times.driver_id} = ${driver.driver_id}  ;;
  }
  join: pit_stops {
    type: left_outer
    relationship: many_to_one
    sql_on: ${pit_stops.race_id} = ${races.race_id} AND ${pit_stops.driver_id} = ${driver.driver_id} ;;
  }
  join: driver_facts {
    type: left_outer
    relationship: one_to_one
    sql_on: ${driver_facts.driver_id} = ${driver.driver_id} ;;
  }
  join: qualifying {
    relationship: one_to_many
    sql_on: ${qualifying.driver_id} = ${driver.driver_id} AND ${qualifying.constructor_id} = ${constructors.constructor_id} AND ${races.race_id} = ${qualifying.race_id} ;;
  }
  join: seasons {
    relationship: many_to_one
    sql_on: ${seasons.year} = ${races.race_year} ;;
  }
}
