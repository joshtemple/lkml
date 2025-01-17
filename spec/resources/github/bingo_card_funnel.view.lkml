
include: "/views/**/events.view"

view: bingo_card_funnel {
  extends: [events]

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: current_card {
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,"$.card_id"),'"','') ;;
  }

  dimension: card_step_hierarchy {
    type: string
    sql:
    CASE WHEN ${current_card} = "card_001" THEN "CARD 001"
         WHEN ${current_card} = "card_002" THEN "CARD 002"
         WHEN ${current_card} = "card_003" THEN "CARD 003"
         WHEN ${current_card} = "card_004" THEN "CARD 004"
         WHEN ${current_card} = "card_005" THEN "CARD 005"
         WHEN ${current_card} = "card_006" THEN "CARD 006"
         WHEN ${current_card} = "card_007" THEN "CARD 007"
         WHEN ${current_card} = "card_008" THEN "CARD 008"
         WHEN ${current_card} = "card_009" THEN "CARD 009"
         WHEN ${current_card} = "card_010" THEN "CARD 010"
        ELSE ${current_card}
        END
        ;;
  }

  dimension: card_state {
    type: number
    sql: CAST(ARRAY_LENGTH(REGEXP_EXTRACT_ALL(JSON_EXTRACT(extra_json, "$.card_state"), ",")) AS INT64) + 1;;
  }
}

view: card_steps {
  derived_table: {
    sql:
    SELECT * FROM ${card_step001.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step002.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step003.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step004.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step005.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step006.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step007.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step008.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step009.SQL_TABLE_NAME} ;;
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

view: card_step001 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 001" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 001"
      }
    }
  }
}

view: card_step002 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 002" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 002"
      }
    }
  }
}

view: card_step003 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 003" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 003"
      }
    }
  }
}

view: card_step004 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 004" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 004"
      }
    }
  }
}

view: card_step005 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 005" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 005"
      }
    }
  }
}

view: card_step006 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 006" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 006"
      }
    }
  }
}

view: card_step007 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 007" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 007"
      }
    }
  }
}

view: card_step008 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 008" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 008"
      }
    }
  }
}

view: card_step009 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 009" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 009"
      }
    }
  }
}

view: card_step010 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "CARD 010" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "CARD 010"
      }
    }
  }
}
