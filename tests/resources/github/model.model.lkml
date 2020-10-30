connection: "qubit-livetap"
include:    "q_*.view"
persist_for: "24 hours"
case_sensitive:  no

explore: q_view {
  group_label: "Qubit"
  extension: required
  fields: [ALL_FIELDS*]
  view_name: q_view_v01
  from: q_view_v01
  label: "Qubit Analytics"
  view_label: "Views"
  persist_for: "24 hours"

  join:  q_session_v01 {
    view_label: "Sessions"
    relationship: many_to_one
    sql_on: ${q_session_v01.session_id} = ${q_view_v01.session_id} ;;
  }

  join:  q_entrance_v01 {
    view_label: "Entrances"
    relationship: many_to_one
    sql_on: ${q_entrance_v01.entrance_id} = ${q_view_v01.entrance_id} ;;
  }

  join: q_transaction_v01 {
    view_label: "Transactions"
    foreign_key:q_view_v01.view_id
    relationship:  one_to_one
  }

  join: q_product_v01 {
    view_label: "Product Interaction and Sales"
    relationship: one_to_many
    sql_on: ${q_product_v01.view_id} = ${q_view_v01.view_id} ;;
  }

  join: q_segment_v01 {
    view_label: "Segment Membership"
    foreign_key:q_view_v01.view_id
    relationship: one_to_many
  }

  join: q_experience_v01 {
    view_label: "Experiences"
    foreign_key:q_view_v01.view_id
    relationship: one_to_many
  }

  join:  q_experience_meta_data_v01 {
    relationship: many_to_one
    sql_on: q_experience_v01.experienceId = q_experience_meta_data_v01.experienceId ;;
  }

  join: q_goal_achieved_v01 {
    view_label: "Goal Achieved"
    foreign_key:q_view_v01.view_id
    relationship: one_to_many
  }

  join: q_goal_achieved_meta_data_v01 {
    relationship: many_to_one
    sql_on: q_goal_achieved_v01.experienceId = q_goal_achieved_meta_data_v01.experienceId ;;
  }

  join: q_attribution_v01 {
    view_label: "Attribution"
    relationship: many_to_one
    sql_on: (q_attribution_v01.context_id = q_view_v01.context_id
              AND q_attribution_v01.context_sessionNumber = q_view_v01.context_sessionNumber
              AND q_attribution_v01.context_entranceNumber = q_view_v01.context_entranceNumber
              AND q_attribution_v01.context_conversionNumber = q_view_v01.context_conversionNumber
              ) ;;
  }

  join: q_visitor_pulse_v01 {
    view_label: "Visitor Pulse"
    foreign_key:q_view_v01.view_id
    relationship: one_to_many
  }

  join: q_user_action_v01 {
    view_label: "User Action"
    foreign_key: q_view_v01.view_id
    relationship: one_to_many
  }
}
