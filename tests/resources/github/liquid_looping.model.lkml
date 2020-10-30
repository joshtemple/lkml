connection: "thelook_events_redshift"

# view: liquid_looping_on_users_data {
#   sql_table_name: public.users ;;

# ## basic fields {
#   dimension: id {primary_key: yes}
#   dimension: age {type: number}
#   dimension: city {}
#   dimension: country {map_layer_name: countries}
#   dimension_group: created {
#     type: time
#     timeframes: [raw,time,date,week,month,quarter,year]
#     sql: ${TABLE}.created_at ;;
#   }
#   dimension: email {}
#   dimension: first_name {}
#   dimension: gender {}
#   dimension: last_name {}
#   dimension: latitude {type: number}
#   dimension: longitude {type: number}
#   dimension: state {map_layer_name:us_states}
#   dimension: traffic_source {}
#   dimension: zip {type: zipcode}
#   measure: count {type:count}
# ##} end basic fields

#   # will use count measures for simplicity. Focusing on liquid in HTML
#   measure: s1_creating_any_variable {type: count
#     html:
#     {% comment %}
#       This is liquid comment syntax
#       Let's create a variable to do examples on.  Most often, you'll do similar logic but set variables to (or use directly) looker's liquid variables: value/other_field._value, rendered_value/other_field._rended_value,link/other_field._link
#       This example could easily come from a listagg type field, and it would be useful to iterate through values
#     {% endcomment %}
#     {% assign my_example_variable  = '2000,2004,2019' %}
#     when testing, literal text note can help trouble shooting the dynamic content: {{my_example_variable}}
# <br>
#     {% comment %}
#       Let's say we want to make leap years blue
#       We want to break the values appart an check each individually
#       Create arrays from strings, by using the split liquid function
#     {% endcomment %}
#     {% assign years_array = my_example_variable | split: ','%}
#     years is now an array of the values between the commas: {{years_array}}
# <br>
#     note: reference specific elements of an array as follows: 1st:{{years_array[0]}}, 2nd:{{years_array[1]}},etc. or also there's this: {{years_array.last}}
# <br>
#     {% comment %}
#       we can iterate through the array directly with a for loop as follows
#       we are creating a new variable which will be set to the next element automatically on each iteration of the array
#     {% endcomment %}
#     {% for year in years_array %}
#       This array element is:{{year}}.
#       {% if year == '2004' or year == '2008' or year == '2012' or year == '2016' or year == '2020' %}
#         <font color='blue'>{{year}}</font>
#       {%else%}
#         <font color='red'>{{year}}</font>
#       {%endif%}
#     {% endfor %}
# <br>
#     {% comment %}
#       can also generate a loop that runs on an iterating counter
#       could use this to fill missing values, etc
#     {% endcomment %}
#     Years List
#     {% for another_year_variable in (2000..2020) %}
#       <br>this iteration value:{{another_year_variable}}.
#     {%endfor%}
# <br>
#     {% assign green_value = 0 %}
#     {% assign blue_value = 0 %}
#     {% for green_value in (1..25)%}
#       {% for blue_value in (1..25)%}<span style='background-color:rgb(125,{{green_value |times:10}},{{blue_value | times:10}})'>-</span>{%endfor%}
#       <br>
#     {%endfor%}



#     ;;
#   }
#   dimension: test_description_liquid {
#     description: "{{_user_attributes['name']}}"
#     sql: '1' ;;
#   }
# #
# }

# explore: liquid_looping_on_users_data {}


# connection: "thelook_events_redshift"

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
#       --_view:{{_view}}
#       --_view._name:{{_view._name}}
#       --_view._inspect{{_view._inspect}}
#       --_view.inspect{{_view['inspect']}}
#       --_view.inspect{{_view.inspect[]}}
#       --_view.inspect{{_view['to_s']}}
#       --_view.inspect{{_view._to_s}}
#       --_view.on{{_view.on}}
#       --_view.on{{_view._on}}
#       --_view.on{{_view['on']}}
#       --.on?{{_view}}
#       --_view.to_s{{_view.to_s}}
#       --t{{_view._view}}
#       --mode:{{_view.['@mode']}}
#       /*
#       {{_connection}}
#       {{_dialect}}
#       {{_field}}
#       {{_view}}
#       {{_base_view}}
#       {{_explore}}
#       {{_model}}
#       {{_query}}

#       {{_table}}
#       {{_user_attributes}}
#       {{_localization}}
#       */
#       --_query._view_map:{{_query[].view_map[]}}
#       --{{_user_attributes['name']._NUMBER}}
#       --_query._dictionary:{{_query['dictionary']}}

#       --field:{{_field}}
#       --field:{{_field._name}}
#       --field:{{_field._condition}}
#       --field:{{_field['condition']}}
#       --age condition:{% condition age %}x{% endcondition%}

#       --{% date_end taylor_q_restriction_from_scheduling.created_date %}x
#       --{% concat %}t{%endconcat%}

#       --line:{{_field._field_file_and_line_num}}

#           ;;
#           #--{% table_date_range_last taylor_q_restriction_from_scheduling.created_date %}x
#       #{{_filters}}


#     }

#   }



#   explore: taylor_q_restriction_from_scheduling2 {
#     view_name: taylor_q_restriction_from_scheduling

#     sql_always_where: 1=1
#       --{{_dialect}}
#       --{{_dialect[]}}
#       --{{_dialect['_name']}}
#       --{{_dialect._name}}
#       --{{_dialect['_sql_FromNothing']}}
#       --{{_dialect['sql_FromNothing']}}
#       --{{_dialect['_from_nothing']}}
#       --{{_dialect['from_nothing']}}
#       --{{_dialect._as}}
#       --{{_dialect._from_nothing}}
#       --q{{_dialect._query._dialect]}}

#       --{{_connection}}
#       --{{_connection._database}}
#       --{{_connection._schema}}
#       --{{_connection._temp}}
#       --{{_connection._pdt_connection_registration}}

#       --{{_query}}
#       --{{_query._query_timezone}}
#       --{{_query._query._query_timezone}}



#       --{{@_query._dictionary._name}}



#       ;;
#       #localization not enabled

# #             --{{_localization}}
# #       --{{_localization[_query]}}
# #       --{{_localization[@_query]}}
# #       --{{_localization['_field_drop_map']}}
# #
#   }
