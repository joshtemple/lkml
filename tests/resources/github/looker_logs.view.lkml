# https://app.getguru.com/card/iMEK8GzT/See-a-detailed-breakdown-of-query-runtime
# Only one query summary per thread - make a new table

view: looker_logs {
  sql_table_name: public.looker_logs ;;

  dimension: index {
    type: number
    primary_key: yes
    sql: ${TABLE}."index" ;;
    link: {
      url: "@{log_lines}&f[looker_logs.index]=%5B{{value}}%2C+{{ix_plus_50._value}}%5D@{line_highlight}"
      label: "See next 50 lines"
    }
    link: {
      url: "@{log_lines}&f[looker_logs.index]=%5B{{ix_less_50._value}}%2C+{{value}}%5D@{line_highlight}"
      label: "See previous 50 lines"
    }
    link: {
      url: "@{log_lines}&f[looker_logs.index]=%5B{{ix_less_25._value}}%2C+{{ix_plus_25._value}}%5D@{line_highlight}"
      label: "See 25 lines either side"
    }
  }
  dimension: ix_plus_50 {hidden: yes type: number sql: ${index} + 50 ;;}
  dimension: ix_plus_25 {hidden: yes type: number sql: ${index} + 25 ;;}
  dimension: ix_less_50 {hidden: yes type: number sql: ${index} - 50 ;; }
  dimension: ix_less_25 {hidden: yes type: number sql: ${index} - 25 ;; }

  dimension: loglevel {
    type: string
    sql: ${TABLE}."loglevel" ;;
    label: "Log level"
    description: "One of DEBUG, INFO, WARN, ERROR or FATAL"
    html:
    {% if value == 'ERROR' %} <span style="color:red">{{rendered_value}}</span>
    {% elsif value == 'WARN' %} <span style="color:orange">{{rendered_value}}</span>
    {% elsif value == 'INFO' %} <span style="color:green">{{rendered_value}}</span>
    {% elsif value == 'FATAL' %} <span style="color:red; font-weight:bold">{{rendered_value}}</span>
    {% else %}{{rendered_value}}
    {% endif %}
    ;;
  }

  dimension: label {
    type:  string
    label: "Log Label"
    description: "This is the label applied at import"
  }

  dimension: query {
    label: "Raw Text"
    type: string
    sql: ${TABLE}."query" ;;
    description: "This is the text of the log line itself"
  }

  dimension: source {
    type: string
    sql: ${TABLE}."source" ;;
    description: "This is the type of Looker process that created the log line"
    link: {
      label: "Lookup source {{ value }}"
      url: "@{log_lines}&f[looker_logs.source]={{ value }}@{line_highlight}"
    }
  }

  dimension: thread {
    type: string
    sql: ${TABLE}."thread" ;;
    link: {
      label: "Lookup thread {{ value }}"
      url: "@{log_lines}&f[looker_logs.thread]={{ value }}@{line_highlight}"
    }
  }

  dimension_group: timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."timestamp" ;;
  }

  ## Query Summary
  dimension: query_summary {
    view_label: "Query Summary"
    sql:(CASE WHEN ${source} = 'query_summary' THEN ${TABLE}.query_summary ELSE NULL END) :: JSONB ;;
  }

  dimension: is_query_summary {
    type: yesno
    hidden: yes
    sql: ${source} = 'query_summary' ;;
  }

  measure: count_queries {
    type: count
    filters: {
      field: source
      value: "query_summary"
    }
  }

  measure: count_log_lines {
    type: count
  }

  dimension: acquire_connection {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'acquire_connection')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: cache_load {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'cache_load')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: dashboard_id {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'dashboard_id')::TEXT, '"', '') ;;
  }
  dimension: dashboard_session {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'dashboard_session')::TEXT, '"', '') ;;
  }
  dimension: dt {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'dt')::TEXT, '"', '') :: NUMERIC ;;
  }
  dimension: event {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'event')::TEXT, '"', '') ;;
  }
  dimension: execute_sql {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'execute_sql')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: grand_total {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'grand_total')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: init {
    group_label: "Components"
    description: "time taken to initialize the query and sanity check for labels, errors etc."
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'init')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: marshalled_cache_load {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'marshalled_cache_load')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: postprocess {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'postprocess')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: prepare {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'prepare')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: setup {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'setup')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: slug {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'slug')::TEXT, '"', '') ;;
    link: {
      label: "Lookup slug {{ value }}"
      url: "@{log_lines}&f[looker_logs.slug]={{ value }}@{line_highlight}"
    }
  }
  dimension: query_source {
    group_label: "Components"
    label: "Source"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'source')::TEXT, '"', '') ;;
  }
  dimension: stream {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'stream')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: stream_others {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'stream_others')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: stream_this {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'stream_this')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: stream_to_cache {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'stream_to_cache')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: total {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'total')::TEXT, '"', '') :: NUMERIC;;
  }
  dimension: unaccounted {
    group_label: "Components"
    view_label: "Query Summary"
    sql: REPLACE((${query_summary} -> 'unaccounted')::TEXT, '"', '') :: NUMERIC;;
  }
  measure: acquire_connection_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${acquire_connection} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: cache_load_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${cache_load} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: execute_sql_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${execute_sql} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: grand_total_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${grand_total} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: init_total {
    type: sum
    group_label: "Totals"
    description: "Total time taken to initialize the query and sanity check for labels, errors etc."
    view_label: "Query Summary"
    sql: ${init} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: marshalled_cache_load_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${marshalled_cache_load} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: postprocess_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${postprocess} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: prepare_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${prepare} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: setup_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${setup} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${stream} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_others_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${stream_others} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_this_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${stream_this} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_to_cache_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${stream_to_cache} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: total_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${total} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: unaccounted_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${unaccounted} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: dt_total {
    type: sum
    group_label: "Totals"
    view_label: "Query Summary"
    sql: ${dt} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: acquire_connection_avg {
    label: "Acquire Connection"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${acquire_connection} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: cache_load_avg {
    label: "Cache Load"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${cache_load} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: execute_sql_avg {
    label: "Execute SQL"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${execute_sql} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: grand_total_avg {
    label: "Grand Total"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${grand_total} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: init_avg {
    label: "Init"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    description: "Average time taken to initialize the query and sanity check for labels, errors etc."
    sql: ${init} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: marshalled_cache_load_avg {
    label: "Marshalled Cache Load"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${marshalled_cache_load} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: postprocess_avg {
    label: "Postprocess"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${postprocess} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: prepare_avg {
    label: "Prepare"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${prepare} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: setup_avg {
    label: "Setup"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${setup} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_avg {
    label: "Stream"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${stream} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_others_avg {
    label: "Stream_others"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${stream_others} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_this_avg {
    label: "Stream_this"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${stream_this} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: stream_to_cache_avg {
    label: "Stream_to_cache"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${stream_to_cache} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: total_avg {
    label: "Total"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${total} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: unaccounted_avg {
    label: "Unaccounted"
    type: average value_format_name: decimal_2
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${unaccounted} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }
  measure: dt_average {
    label: "DT"
    type: average
    group_label: "Averages"
    view_label: "Query Summary"
    sql: ${dt} ;;
    link: {label: "Show query summary data" url: "{{link}}@{queries_only}"} drill_fields: [query_summary_lines*]
  }

  set: log_lines {
    fields: [looker_logs.index,looker_logs.timestamp_time,looker_logs.thread,looker_logs.source,looker_logs.query]
  }
  set: query_summary_lines {
    fields: [looker_logs.index,looker_logs.timestamp_time,looker_logs.thread,looker_logs.source,looker_logs.query_source,looker_logs.event,looker_logs.slug,looker_logs.dashboard_id,looker_logs.dashboard_session,looker_logs.init_avg,looker_logs.prepare_avg,looker_logs.acquire_connection_avg,looker_logs.dt_average,looker_logs.execute_sql_avg,looker_logs.postprocess_avg,looker_logs.marshalled_cache_load_avg,looker_logs.setup_avg,looker_logs.total_avg,looker_logs.unaccounted_avg,looker_logs.stream_avg,looker_logs.stream_to_cache_avg,looker_logs.stream_this_avg,looker_logs.stream_others_avg,looker_logs.cache_load_avg,looker_logs.grand_total_avg]
  }

  measure: count_distinct_instances {
    type: count_distinct
    sql: ${label} ;;
  }
}
