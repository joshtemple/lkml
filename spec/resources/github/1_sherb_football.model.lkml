connection: "jesse_bigquery"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

persist_for: "120 hours"

explore: projected_stats_adp {
  group_label: "Fantasy Football"
  label: "Stats, Odds, and Scores"
  view_label: "Projected Stats"
  join: admin_players {
    view_label: "Players"
    relationship: one_to_one
    sql_on: ${projected_stats_adp.player_id} = ${admin_players.player_id} ;;
  }
  join: admin_teams {
    view_label: "Teams"
    relationship: one_to_one
    sql_on: ${admin_players.team} = ${admin_teams.key} ;;
  }
  join: week_stats {
    view_label: "Weekly Stats"
    relationship: one_to_many
    sql_on: ${admin_players.player_id} = ${week_stats.player_id} ;;
  }
  join: week_standings {
    view_label: "Current Standings"
    relationship: many_to_one
    sql_on: ${admin_teams.team_id} = ${week_standings.team_id} ;;
  }
#   join: team_week_scores {
#     from: week_scores
#     view_label: "Weekly Scores"
#     relationship: one_to_many
#     sql_on: ${admin_teams.team_id} = ${team_week_scores.home_team_id}
#           AND ${admin_teams.team_id} = ${team_week_scores.away_team_id};;
#   }
#   join: away_team_week_scores_2018 {
#     from: 2018_scores
#     view_label: "2018 Scores (Away Team)"
#     relationship: one_to_many
#     sql_on: ${admin_teams.team_id} = ${away_team_week_scores_2018.away_team_id} ;;
#   }
#   join: team_week_scores_2018 {
#     from: scores_2018
#     view_label: "2018 Scores"
#     relationship: one_to_many
#     sql_on: ${admin_teams.team_id} = ${team_week_scores_2018.home_team_id}
#           AND ${admin_teams.team_id} = ${team_week_scores_2018.away_team_id};;
#   }
  join: stats_2018 {
    view_label: "2018 Season Stats"
    relationship: one_to_one
    sql_on: ${admin_players.player_id} = ${stats_2018.player_id} ;;
  }
  join: standings_2018 {
    view_label: "2018 Standings"
    relationship: many_to_one
    sql_on: ${admin_teams.team_id} = ${standings_2018.team_id} ;;
  }
}

explore: dfs_optimizer {
  label: "DFS Optimizer"
  from: admin_players
}
