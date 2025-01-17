connection: "thelook_events_redshift"

# include: "*.view.lkml"                       # include all views in this project
# # include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# view:  taylor_q_restriction_from_scheduling {
#   extends: [basic_users]

# #   dimension: age {hidden:yes}
#   dimension: restricted_copy_of_age {
#     sql: concat('hashed for security',MD5(${age})) ;;
#     html: {{_user_attributes['name']}},{{age._rendered_value}} , {{_query['_query_timezone']}} ,{{_query['_query_source']}},{{_query['result_source']}},{{_query[] | join:','}};;
#   }
#   dimension: now_date {
#     sql: getdate() ;;
#     html: {{now_date._label}} ;;
#   }

#   measure: liquid_drops {
#     type: max
#     filters: {
#       field: age
#       value: "20"
#     }
#     sql: 1
# --_view:{{_view}}
# --_view._name:{{_view._name}}
# --_view._inspect{{_view._inspect}}
# --_view.inspect{{_view['inspect']}}
# --_view.inspect{{_view.inspect[]}}
# --_view.inspect{{_view['to_s']}}
# --_view.inspect{{_view._to_s}}
# --_view.on{{_view.on}}
# --_view.on{{_view._on}}
# --_view.on{{_view['on']}}
# --.on?{{_view}}
# --_view.to_s{{_view.to_s}}
# --t{{_view._view}}
# --mode:{{_view.['@mode']}}
# /*
# {{_connection}}
# {{_dialect}}
# {{_field}}
# {{_view}}
# {{_base_view}}
# {{_explore}}
# {{_model}}
# {{_query}}

# {{_table}}
# {{_user_attributes}}
# {{_localization}}
# */
# --_query._view_map:{{_query[].view_map[]}}
# --{{_user_attributes['name']._NUMBER}}
# --_query._dictionary:{{_query['dictionary']}}

# --field:{{_field}}
# --field:{{_field._name}}
# --field:{{_field._condition}}
# --field:{{_field['condition']}}
# --age condition:{% condition age %}x{% endcondition%}

# --{% date_end taylor_q_restriction_from_scheduling.created_date %}x
# --{% concat %}t{%endconcat%}

# --line:{{_field._field_file_and_line_num}}

#     ;;
#     #--{% table_date_range_last taylor_q_restriction_from_scheduling.created_date %}x
# #{{_filters}}


#   }

# }



# explore: taylor_q_restriction_from_scheduling2 {
# view_name: taylor_q_restriction_from_scheduling
# #   sql_always_where: '{{'now' | date: "%Y-%m-%d %H:%M:%S"}} +0000'=${taylor_q_restriction_from_scheduling.now_date}
# #   --and {{_query['_query_timezone']}} and
# #   ;;
# # 2019-12-11 14:59:56 +0000
# #'2019-12-11 15:01'
# sql_always_where: 1=1
# --{{_dialect}}
# --{{_dialect[]}}
# --{{_dialect['_name']}}
# --{{_dialect._name}}
# --{{_dialect['_sql_FromNothing']}}
# --{{_dialect['sql_FromNothing']}}
# --{{_dialect['_from_nothing']}}
# --{{_dialect['from_nothing']}}
# --{{_dialect._as}}
# --{{_dialect._from_nothing}}
# --{{_dialect._query._dialect}}

# --{{_connection}}
# --{{_connection._database}}
# --{{_connection._schema}}
# --{{_connection._temp}}
# --{{_connection._pdt_connection_registration}}

# --{{_query}}
# --{{_query._query_timezone}}
# --{{_query._query._query_timezone}}



# --{{@_query._dictionary._name}}



# ;;

# # --{{_localization}}
# # --{{_localization[_query]}}
# # --{{_localization[@_query]}}
# # --{{_localization['_field_drop_map']}}
# }
