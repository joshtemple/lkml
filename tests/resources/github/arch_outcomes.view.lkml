view: arch_outcomes {
  # sql_table_name: bc360_arch_marketing.arch_outcomes ;;

  derived_table: {
   datagroup_trigger: dg_bc360_bq

   sql:  SELECT
           outcome_tracker_id,
           outcome_intent,
           outcome_mechanism,
           outcome_quality,
           outcome_score,
           outcome_type,
           outcome_type_name
         FROM bc360_arch_marketing.arch_outcomes ao;;
  }

##########  METADATA  ##########

  dimension: outcome_tracker_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Outcome Tracker ID [Arch_Outcomes]"

    primary_key: yes
    type: string
    hidden: no

    sql: ${TABLE}.outcome_tracker_id ;;
  }


  ##########  DIMENSIONS  ##########

  dimension: outcome_intent {
    view_label: "6. Outcomes"
    label: "Outcome Intent"

    type: string
    sql: ${TABLE}.outcome_intent ;;
  }

  dimension: outcome_mechanism {
    view_label: "6. Outcomes"
    label: "Outcome Mechanism"

    type: string
    sql: ${TABLE}.outcome_mechanism ;;
  }

  dimension: outcome_quality {
    view_label: "6. Outcomes"
    label: "Outcome Quality"

    type: string
    case: {
      when: {
        sql: ${TABLE}.outcome_quality = 'Referrals' ;;
        label: "Referrals"
      }
      when: {
        sql: ${TABLE}.outcome_quality = 'Leads' ;;
        label: "Leads"
      }
      else: "Outcomes"
    }

  }

  dimension: outcome_score {
    view_label: "6. Outcomes"
    label: "Outcome Score"

    type: number
    sql: ${TABLE}.outcome_score ;;
  }

  dimension: outcome_type_category {
    view_label: "6. Outcomes"
    label: "Outcome Type - Category"

    type: string

    case: {
      when: {
        sql: ${outcome_type} LIKE 'LP%' ;;
        label: "LP Visits"
      }
      when: {
        sql: ${outcome_type} LIKE 'Ad%' ;;
        label: "Direct Calls"
      }
      when: {
        sql: ${outcome_type} LIKE '%FAD%' ;;
        label: "FAD Visits"
      }
      when: {
        sql: ${outcome_type} LIKE '%MyChart%' ;;
        label: "MyChart Visits"
      }
      else: "Uncategorized Type"
    }
  }

  dimension: outcome_type {
    view_label: "6. Outcomes"
    label: "Outcome Type"

    type: string
    sql: ${TABLE}.outcome_type ;;
  }

  dimension: outcome_type_name {
    view_label: "6. Outcomes"
    label: "Outcome Type Name"

    type: string
    sql: ${TABLE}.outcome_type_name ;;
  }
}
