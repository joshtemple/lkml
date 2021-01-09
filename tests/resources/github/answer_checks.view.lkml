view: answers_test_results_vis_config {
  extends: [answer_check_base]
}

view: answers_test_results_limit {
  extends: [answer_check_base]
}

view: answers_test_results_num_rows {
  extends: [answer_check_base]
}

view: answers_test_results_filters {
  extends: [answer_check_base]
}

view: answers_test_results_fields {
  extends: [answer_check_base]
}

view: answers_test_results_pivots {
  extends: [answer_check_base]
}

view: answers_test_results_sorts {
  extends: [answer_check_base]
}

view: answer_check_base {
  extension: required
  view_label: "2) Answer Checks"
  dimension: check { type: yesno sql: ${TABLE}.check ;; group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }} Check"}
  dimension: wrong { type: yesno sql: NOT ${TABLE}.check ;; group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }} Wrong"}

  dimension: reason {
    group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }} Reason"
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: reason_wrong {
    group_label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }}" label: "{{ _view._name | replace: 'answers_test_results_', '' | replace: '_', ' ' | capitalize }} Reason Wrong"
    type: string
    sql: CASE WHEN ${wrong} THEN ${reason} END ;;
  }
}


view: answers_test_results {
  view_label: "2) Answer Checks"
  dimension: fields {
    hidden: yes
    sql: ${TABLE}.fields ;;
  }

  dimension: filters {
    hidden: yes
    sql: ${TABLE}.filters ;;
  }

  dimension: limit {
    hidden: yes
    sql: ${TABLE}.`limit` ;;
  }

  dimension: num_rows {
    hidden: yes
    sql: ${TABLE}.num_rows ;;
  }

  dimension: pivots {
    hidden: yes
    sql: ${TABLE}.pivots ;;
  }

  dimension: sorts {
    hidden: yes
    sql: ${TABLE}.sorts ;;
  }

  dimension: vis_config {
    hidden: yes
    sql: ${TABLE}.vis_config ;;
  }
}
