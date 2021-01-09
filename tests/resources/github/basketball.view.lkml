view: basketball {
  sql_table_name: fantasy.Basketball ;;

  dimension: team {
    type: string
    description: "Name of Team"
    sql: ${TABLE}.Team ;;
  }

  measure: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  measure: 3_pointers {
    type: number
    sql: ${TABLE}.3PM ;;
  }

  measure: assists {
    type: number
    sql: ${TABLE}.AST ;;
  }

  measure: blocks {
    type: number
    sql: ${TABLE}.BLK ;;
  }

  measure: field_goal_pct {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.`FG_PCT` ;;
  }

  measure: free_throw_pct {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.`FT_PCT` ;;
  }

  measure: points {
    type: number
    sql: ${TABLE}.PTS ;;
  }

  measure: rebounds {
    type: number
    sql: ${TABLE}.REB ;;
  }

  measure: steals {
    type: number
    sql: ${TABLE}.STL ;;
  }

  measure: total_pts {
    view_label: "Category Points"
    type: number
    sql: ${basketball_pts_steals.steal_pts}+${basketball_pts_rebounds.rebound_pts}+
         ${basketball_pts_assists.assist_pts}+${basketball_pts_points.point_pts}+
         ${basketball_pts_blocks.block_pts}+${basketball_pts_3_pointers.3_pointer_pts}+
         ${basketball_pts_fg_pct.fg_pct_pts}+${basketball_pts_ft_pct.ft_pct_pts} ;;
  }
#   measure: count {
#     type: count
#     drill_fields: []
#   }
}

view: basketball_pts_steals {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS Steal_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY STL ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: steal_pts {
    view_label: "Category Points"
    sql: ${TABLE}.Steal_Pts ;;
    type: number
  }
}

view: basketball_pts_rebounds {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS Rebound_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY REB ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: rebound_pts {
    view_label: "Category Points"
    sql: ${TABLE}.Rebound_Pts ;;
    type: number
  }
}

view: basketball_pts_points {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS Point_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY PTS ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: point_pts {
    view_label: "Category Points"
    sql: ${TABLE}.Point_Pts ;;
    type: number
  }
}

view: basketball_pts_3_pointers {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS 3_Pointer_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY 3PM ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: 3_pointer_pts {
    view_label: "Category Points"
    sql: ${TABLE}.3_Pointer_Pts ;;
    type: number
  }
}

view: basketball_pts_assists {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS Assist_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY AST ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: assist_pts {
    view_label: "Category Points"
    sql: ${TABLE}.Assist_Pts ;;
    type: number
  }
}

view: basketball_pts_fg_pct {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS FG_Pct_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY FG_PCT ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: fg_pct_pts {
    view_label: "Category Points"
    sql: ${TABLE}.FG_Pct_Pts ;;
    type: number
  }
}

view: basketball_pts_ft_pct {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS FT_Pct_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY FT_PCT ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: ft_pct_pts {
    view_label: "Category Points"
    sql: ${TABLE}.FT_Pct_Pts ;;
    type: number
  }
}

view: basketball_pts_blocks {
  derived_table: {
    sql:
      SELECT Team, @curRank := @curRank + 1 AS Block_Pts
      FROM basketball, (SELECT @curRank := 0) r
      ORDER BY BLK ASC
    ;;
  }

  dimension: team {
    hidden: yes
    sql: ${TABLE}.team;;
  }

  measure: block_pts {
    view_label: "Category Points"
    sql: ${TABLE}.Block_Pts ;;
    type: number
  }
}
