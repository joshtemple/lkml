# Purpose of file is to generate distinct values from nested fields to be used in filter fields
include: "ga_sessions.view.lkml"
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/filter_suggestions.view.lkml"

explore: event_actions {
  hidden: yes
}

view: event_actions {
  extends: [event_actions_config]
}

view: event_actions_core {
  extension: required
  derived_table: {
    explore_source: ga_sessions {
      column: event_action { field: hits.event_action }

      filters: [ga_sessions.partition_date: "@{PDT_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }

  dimension: event_action {
  }
}

explore: event_labels {
  extends: [event_labels_config]
}

explore: event_labels_core {
  hidden: yes
  extension: required
}

view: event_labels {
  extends: [event_labels_config]
}

view: event_labels_core {
  extension: required
  derived_table: {
    explore_source: ga_sessions {
      column: event_label { field: hits.event_label }

      filters: [ga_sessions.partition_date: "@{PDT_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }

  dimension: event_label {
  }
}

explore: event_categories {
  extends: [event_categories_config]
  extension: required
}

explore: event_categories_core {
  hidden: yes
  extension: required
}

view: event_categories {
  extends: [event_categories_config]
}
view: event_categories_core {
  extension: required
  derived_table: {
    explore_source: ga_sessions {
      column: event_category { field: hits.event_category }

      filters: [ga_sessions.partition_date: "@{PDT_DATE_FILTER}"]
    }
    persist_for: "24 hours"
  }

  dimension: event_category {
  }
}

explore: top_pages {
  extends: [top_pages_config]
}

explore: top_pages_core {
  hidden: yes
  extension: required
}
view: top_pages {
  extends: [top_pages_config]
}
view: top_pages_core {
  extension: required
  derived_table: {
    explore_source: ga_sessions {
      column: page_path { field: hits.page_path_formatted }
      column: page_count { field: hits.page_count }

      filters: [ga_sessions.partition_date: "@{PDT_DATE_FILTER}"]
      sorts: [hits.page_count: desc]
      limit: 50
    }
    persist_for: "24 hours"
  }

  dimension: page_path {
  }
}
