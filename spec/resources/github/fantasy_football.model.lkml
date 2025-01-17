connection: "fantasy"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: fantasy_football_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: fantasy_football_default_datagroup

explore: regular_season_2017 {
  label: "2018 Projections & 2017 Stats"
  view_label: "2017 Stats"
  join: projections_2018 {
    view_label: "2018 Projections"
    sql_on: ${regular_season_2017.player_id} = ${projections_2018.player_id} ;;
    relationship: one_to_one
    type: full_outer
  }
  join: fourfour_2018_projections {
    view_label: "2018 Projections"
    sql_on: ${projections_2018.name} = ${fourfour_2018_projections.player}
    and ${projections_2018.team} = ${fourfour_2018_projections.team}
    and ${projections_2018.position} = ${fourfour_2018_projections.pos};;
    relationship: one_to_one
    type: left_outer
    fields: [fourfour_2018_projections.gc_difference,fourfour_2018_projections.pts_proj,fourfour_2018_projections.average_pts,fourfour_2018_projections.total_pts]
  }
  join: position_ranking_4for4 {
    view_label: "2018 Projections"
    sql_on: ${projections_2018.name} = ${position_ranking_4for4.player}
    and ${projections_2018.team} = ${position_ranking_4for4.team}
    and ${projections_2018.position} = ${position_ranking_4for4.pos};;
    relationship: one_to_one
    type: left_outer
    fields: [position_rank,position_ranking_4for4.position_rank_diff,position_ranking_4for4.average_position_rank]
  }
  join: adp_2018 {
    view_label: "2018 Projections"
    sql_on: ${projections_2018.player_id} = ${adp_2018.player_id} ;;
    relationship: one_to_one
    type: full_outer
  }
  join: adp_2017 {
    view_label: "2017 Stats"
    sql_on: ${regular_season_2017.player_id} = ${adp_2017.player_id} ;;
    relationship: one_to_one
    type: full_outer
  }
  join: snap_counts_2017 {
    view_label: "2017 Team Snap Counts"
    sql_on: ${regular_season_2017.player_id} = ${snap_counts_2017.player_id} ;;
    relationship: one_to_one
    type: full_outer
  }
  join: game_log_2017 {
    view_label: "2017 Game Log"
    sql_on: ${regular_season_2017.player_id} = ${game_log_2017.player_id} ;;
    relationship: many_to_one
    type: full_outer
  }
  join: game_log_2018 {
    view_label: "2018 Game Log (Proj.)"
    sql_on: ${projections_2018.player_id} = ${game_log_2018.player_id} ;;
#     and ${game_log_2017.week} = ${game_log_2018.week} ;;
    relationship: many_to_one
    type: full_outer
  }
  join: position_ranking {
    view_label: "2018 Projections"
    sql_on: ${projections_2018.player_id} = ${position_ranking.playerid};;
    relationship: one_to_one
    type: left_outer
    fields: [position_rank,average_position_rank]
  }
  join: position_ranking_2017 {
    view_label: "2017 Stats"
    sql_on: ${regular_season_2017.player_id} = ${position_ranking_2017.playerid};;
    relationship: one_to_one
    type: left_outer
    fields: [position_rank]
  }
  join: players {
    view_label: "2018 Projections"
    sql_on:  ${projections_2018.player_id} = ${players.id};;
    relationship: one_to_one
    type: left_outer
  }

}
