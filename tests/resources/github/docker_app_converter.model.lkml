connection: "data_warehouse"

include: "docker_app_converter/*.view"
include: "ucp*[!.][!z].view.lkml"
include: "reghub*[!.][!z].view.lkml"

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: dac_tracks {
  label: "Tracked Events"
  view_label: "Tracked Events"
  join: dac_discovered_app {
    view_label: "Discovered App"
    relationship: one_to_one
    sql_on: ${dac_discovered_app.id} = ${dac_tracks.id} ;;
  }

  join: dac_discovered_installation {
    view_label: "Discovered Installation"
    relationship: one_to_one
    sql_on: ${dac_discovered_installation.id} = ${dac_tracks.id} ;;
  }

  join: dac_discovered_os {
    view_label: "Discovered OS"
    relationship: one_to_one
    sql_on: ${dac_discovered_os.id} = ${dac_tracks.id} ;;
  }

  join: dac_discover_start {
    view_label: "Discover Start"
    relationship: one_to_one
    sql_on: ${dac_discover_start.id} = ${dac_tracks.id} ;;
  }

  join: dac_discover_error {
    view_label: "Discover Error"
    relationship: one_to_one
    sql_on: ${dac_discover_error.id} = ${dac_tracks.id} ;;
  }

  join: dac_dockerize_error {
    view_label: "Dockerize Error"
    relationship: one_to_one
    sql_on: ${dac_dockerize_error.id} = ${dac_tracks.id} ;;
  }

  join: dac_dockerize_start {
    view_label: "Dockerize Start"
    relationship: one_to_one
    sql_on: ${dac_dockerize_start.id} = ${dac_tracks.id} ;;
  }

  join: dac_dockerized_app {
    view_label: "Dockerized app"
    relationship: one_to_one
    sql_on: ${dac_dockerized_app.id} = ${dac_tracks.id} ;;
  }

  join: dac_dockerized_installation {
    view_label: "Dockerized Installation"
    relationship: one_to_one
    sql_on: ${dac_dockerized_installation.id} = ${dac_tracks.id} ;;
  }

  join: license {
    from: ucp_licensing
    sql_on: ${license.license_key} = ${dac_tracks.user_id} ;;
    relationship: many_to_one
  }

  join: docker_users {
    from: reghub_dockeruser
    sql_on: ${license.hub_uuid} = replace(${docker_users.uuid}, '-','') ;;
    relationship: many_to_one
  }

}
