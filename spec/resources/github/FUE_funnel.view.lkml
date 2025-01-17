
include: "/views/**/events.view"
include: "/views/**/scene_load_time/**/scene_load_time.view"

view: fue_funnel {
  extends: [events]
  extends: [scene_load_time]


  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: fue_step {
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,"$.current_FueStep"),'"','') ;;
  }

  dimension: fue_step_hierarchy {
    type: string
    sql:
    CASE WHEN ${event_name} = "TitleScreenAwake" THEN "1. TitleScreenAwake"
         WHEN ${fue_step} = "FIRST_PLAY" THEN "2. FIRST PLAY"
         WHEN ${fue_step} = "BINGO_CARD_INTRO" THEN "3. BINGO_CARD_INTRO"
         WHEN ${fue_step} = "BINGO_CARD_FIRST_NODE_COMPLETE" THEN "4. BINGO_CARD_FIRST_NODE_COMPLETE"
         WHEN ${fue_step} = "BINGO_CARD_KEEP_PLAYING" THEN "5. BINGO_CARD_KEEP_PLAYING"
         WHEN ${fue_step} = "BINGO_CARD_FIRST_REWARD" THEN "6. BINGO_CARD_FIRST_REWARD"
         WHEN ${fue_step} = "BINGO_CARD_FUE_END" THEN "7. BINGO_CARD_FUE_END"
         WHEN ${fue_step} = "STORE_UNLOCK" THEN "8. STORE_UNLOCK"
         WHEN ${fue_step} = "USE_BOOSTS" THEN "9. USE_BOOSTS"
        ELSE ${fue_step}
        END
        ;;
  }

  dimension: ChoreographyStepId {
    type: number
    sql: REPLACE(JSON_EXTRACT(extra_json,"$.current_ChoreographyStepId"),'"','') ;;
  }
}

view: funnel_steps {
  derived_table: {
    sql:
    SELECT * FROM ${fue_step001.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step002.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step003.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step004.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step005.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step006.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step007.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step008.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step009.SQL_TABLE_NAME} ;;
  }
  dimension: step {}
  measure: count_players {
    type: count_distinct
    sql: ${TABLE}.player_id ;;
  }
  dimension: ChoreographyStepId {
    type: number
  }
}

view: fue_step001 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "1. TitleScreenAwake" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "1. TitleScreenAwake"
      }
    }
  }
}

view: fue_step002 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "2. FIRST PLAY" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "2. FIRST PLAY"
      }
    }
  }
}

view: fue_step003 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "3. BINGO_CARD_INTRO" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "3. BINGO_CARD_INTRO"
      }
    }
  }
}

view: fue_step004 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "4. BINGO_CARD_FIRST_NODE_COMPLETE" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "4. BINGO_CARD_FIRST_NODE_COMPLETE"
      }
    }
  }
}

view: fue_step005 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "5. BINGO_CARD_KEEP_PLAYING" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "5. BINGO_CARD_KEEP_PLAYING"
      }
    }
  }
}

view: fue_step006 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "6. BINGO_CARD_FIRST_REWARD" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "6. BINGO_CARD_FIRST_REWARD"
      }
    }
  }
}

view: fue_step007 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "7. BINGO_CARD_FUE_END" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "7. BINGO_CARD_FUE_END"
      }
    }
  }
}

view: fue_step008 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "8. STORE_UNLOCK" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "8. STORE_UNLOCK"
      }
    }
  }
}

view: fue_step009 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "9. USE_BOOSTS" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "9. USE_BOOSTS"
      }
    }
  }
}
