connection: "ryan_bq"

# include all the views
include: "*.view"

datagroup: personal_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: personal_thesis_default_datagroup

named_value_format: usd_in_millions_test {
  value_format: "$0.000,,\" M\""
}

explore: cards {
  join: cards__mechanics {
    view_label: "Cards: Mechanics"
    sql: LEFT JOIN UNNEST(${cards.mechanics}) as cards__mechanics ;;
    relationship: one_to_many
  }
  join: complexity{
    sql_on: ${cards.card_id} = ${complexity.id};;
    relationship:  one_to_one
  }
}

explore: games {
  join: games__card_history {
    view_label: "Games: Card History"
    sql: LEFT JOIN UNNEST(${games.card_history}) as games__card_history ;;
    relationship: one_to_many
  }

  join: games__card_history__card {
    view_label: "Games: Card History Card"
    sql: LEFT JOIN UNNEST(${games__card_history.card}) as games__card_history__card ;;
    relationship: one_to_many
  }
}

explore: all_cards_and_games {
  view_name: games
  join: games__card_history {
    view_label: "Games: Card History"
    sql: LEFT JOIN UNNEST(${games.card_history}) as games__card_history ;;
    relationship: one_to_many
  }

  join: games__card_history__card {
    view_label: "Games: Card History Card"
    sql: LEFT JOIN UNNEST(${games__card_history.card}) as games__card_history__card ;;
    relationship: one_to_many
  }
  join: cards {
    view_label: "Cards"
    type: full_outer
    sql_on: ${games__card_history__card.id} = ${cards.card_id} ;;
    relationship: many_to_one
  }
  join: cards__mechanics {
    view_label: "Cards: Mechanics"
    sql: LEFT JOIN UNNEST(${cards.mechanics}) as cards__mechanics ;;
    relationship: one_to_many
  }
  join: rank_by_plays {
    view_label: "Ranks"
    sql_on: ${cards.name} = ${rank_by_plays.name} ;;
    relationship: one_to_one
  }
  join: complexity{
    sql_on: ${cards.card_id} = ${complexity.id} ;;
    relationship:  one_to_one
  }
}

explore: dt_test {}
explore: dt_test_2 {}
