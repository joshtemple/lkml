connection: "thelook_events_redshift"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

view: users_liquid {
  sql_table_name: public.users ;;
  parameter: metric_chooser {
    type: string
    allowed_value: {
      label: "Metric 1"
      value: "m1"
    }
    allowed_value: {
      label: "Metric 2"
      value: "m2"
    }
  }

  parameter: color_threshold {
    type: number
  }
  dimension: color_test {
    type: number
    sql: ${TABLE}.age ;;
    html:
    {% assign color_threshold_as_number = color_threshold._parameter_value | times:1.0 %}
    <div style="background-color:
      {% if value >= color_threshold_as_number %}green
      {% else %}red
      {%endif%}
    ">{{value}}</div>
    ;;
  }


  dimension: a_field_for_filtering{sql:'test';;}
  dimension: parameters_value {
    sql: {% condition a_field_for_filtering %}sometest{%endcondition%} ;;
  }

  measure: dynamic_metric {
    type: number
#   html: {% if  metric_chooser._parameter_value == 'm1'%}
#     1: {{metric_1._rendered_value}}
#     {% else %}
#     2: {{metric_2._rendered_value}} {{metric_chooser._parameter_value}}
#     {% endif %}
#     ;;
    html: {% assign x = metric_chooser._parameter_value %}test:{{x}}-
      {% if  metric_chooser._parameter_value == "'m1'" %}
           1: {{metric_1._rendered_value}}
           {% else %}
           2: {{metric_2._rendered_value}} {{metric_chooser._parameter_value}}
           {% endif %}
           ;;
    sql: CASE WHEN {% parameter metric_chooser %} = 'm1' THEN ${metric_1} ELSE ${metric_2} END;;
  }
  measure: metric_1 {
    type: sum
    sql: 1  ;;
  }
  measure: metric_2 {
    type: sum
    sql: 2  ;;
  }
  measure: count {
    type: count
    drill_fields: [metric_1]
  }
  measure: m2 {
    sql: 1 ;;
    html: {{count._link}} ;;
  }

  dimension: list_of_values {
    sql: 'v1,v2' ;;
    html:
{% assign my_array = value | split: ',' %}
{% for my_array_element in my_array %}
  this element: {{my_array_element}}
{% endfor %}
    ;;

  }


}


explore: users_liquid {}

view: split_input {
  dimension: input {sql:t^2;;}
  dimension: input_sql_holder {sql:1/*${input}*/;;}#need to use a looker reference in view so that it gets fully converted to corresponding sql.  Uses comments so that this field doesn't change query results
  dimension: parsed_input1 {
    required_fields: [input_sql_holder] #required for this field to be able to read sql correctly
    sql:
    {% assign my_array = input_sql_holder._sql | remove: '1/*(' | remove: ')*/' | split: '^' %}
    {% assign firstsql = my_array.first %}
    {{firstsql}}
    ;;
  }
  dimension: parsed_input2 {
    required_fields: [input_sql_holder]
    sql:
    {% assign my_array = input_sql_holder._sql | remove: '1/*(' | remove: ')*/' | split: '^' %}
    {% assign lastsql = my_array.last %}
    {{lastsql}}
    ;;
  }
}
view: for_multiply {extends:[split_input]}
view: for_multiply2 {extends:[split_input]}

view: multiply {
  extends: [for_multiply]
  sql_table_name:  ;;
dimension: multiply_input {sql: 1*2;;}
dimension: input {sql:${multiply_input};;}
dimension: multiply {sql: ${parsed_input1}*${parsed_input2};;}
}
view: multiply2 {
  extends:[for_multiply2]
  dimension: multiply_input2 {sql:;;}
dimension: input {sql:${multiply_input2};;}
dimension: multiply2 {sql: ${parsed_input1}*${parsed_input2};;}

}
view: uas2 {
  sql_table_name: public.users ;;
  extends: [multiply,multiply2]
  dimension: id {primary_key:yes}
  dimension: age {}
  dimension: multiply_input {sql:${age}^5;;}
  # dimension: multiply {type:number} # comes from extension
  dimension: my_special_field {sql:${multiply};;}
  dimension: multiply_input2 {sql:${age}^6;;}
  dimension: my_special_field2 {sql:${multiply2};;}
}

view: split_input_remote_multiply {
  extends: [parse_input,output]
  # dimension: multiply {
  #   type: number
  #   sql: ${parsed_input1}*${parsed_input2} ;;
  # }
  dimension: output {
    type: number
    sql: ${parsed_input1}*${parsed_input2} ;;
  }
}
















view: users_view {
  sql_table_name: public.users ;;
  dimension: id {primary_key:yes}
  dimension: age {}
  dimension_group: created
  {
    type:time
    timeframes: [raw,date,day_of_year,month_num,day_of_month,week_of_year,month]
    sql:${TABLE}.created_at;;
  }
  dimension_group: now {
    datatype: timestamp
    type: time
    timeframes: [raw,date,day_of_year,month_num,day_of_month,week_of_year,month]
    sql: getdate() ;;
  }

  dimension_group: now_liquid {
    datatype: timestamp
    type: time
    timeframes: [raw,date,day_of_year,month_num,day_of_month,week_of_year,month]
    sql:
    {% assign minute = "now" | date: "%Y%m%d%H%M" %}
    {% assign ten_minutes = minute | modulo: 10 %}
    {%if ten_minutes <= 5 %}
      select {{ten_minutes}}
    {%else %}
      select 11
    {% endif %}
    ;;
  }

  dimension: days_since_joined {
    type: duration_day
    sql_start:  ${created_date};;
    sql_end: ${now_date} ;;
  }
  dimension: years_since_joined {
    type: duration_year
    sql_start:  ${created_date};;
    sql_end: ${now_date} ;;
  }
}


#vvvvv Function Support #{

#no source tables used

view: parse_input {
  view_label: "for testing - {{_view._name}}"
  dimension: input {sql:;;}#input will be overriden by extending view
dimension: input_sql_holder {sql:0/*${input}*/;;}#need to use a looker reference in view so that it gets fully converted to corresponding sql.  Uses comments so that this field doesn't change query results
dimension: parsed_input1 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[0]}};; required_fields: [input_sql_holder]}
dimension: parsed_input2 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[1]}};; required_fields: [input_sql_holder]}
dimension: parsed_input3 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[2]}};; required_fields: [input_sql_holder]}
dimension: parsed_input4 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[3]}};; required_fields: [input_sql_holder]}
#vvv More slots{
# dimension: parsed_input5 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[4]}};; required_fields: [input_sql_holder]}
# dimension: parsed_input6 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[5]}};; required_fields: [input_sql_holder]}
# dimension: parsed_input7 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[6]}};; required_fields: [input_sql_holder]}
# dimension: parsed_input8 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[7]}};; required_fields: [input_sql_holder]}
# dimension: parsed_input9 {sql:{% assign my_array = input_sql_holder._sql | remove: '0/*(' | remove: ')*/' | split: '^^' %}{{my_array[8]}};; required_fields: [input_sql_holder]}
#}^^^
}

#can be used to check particular parameter values
view: parse_input_hidden {
  extends: [parse_input]
  dimension: input            {hidden:yes}
  dimension: input_sql_holder {hidden:yes}
  dimension: parsed_input1    {hidden:yes}
  dimension: parsed_input2    {hidden:yes}
  dimension: parsed_input3    {hidden:yes}
  dimension: parsed_input4    {hidden:yes}
#vvv More slots{
#   dimension: parsed_input5    {hidden:yes}
#   dimension: parsed_input6    {hidden:yes}
#   dimension: parsed_input7    {hidden:yes}
#   dimension: parsed_input8    {hidden:yes}
#   dimension: parsed_input9    {hidden:yes}
#}^^^
}

#defaults for the output field
view: output {
  dimension: output {
    label: "{{_view._name | replace: '_',' ' }}"
    sql: 'function error: this sql should be overridden' ;;#will be overriden
  }
}
#}<<<
#^^^^ END Function Support


#vvvv Functions {
#vvvv
view: safe_divide
{
  extends: [parse_input_hidden,output]
  dimension: output
  {
    sql:(${parsed_input1})*1.0/nullif(${parsed_input2},0) ;;
    type:number
    value_format_name:decimal_1
  }
}

view: acronymize {
  extends: [parse_input_hidden,output]
  dimension: output
  {
    sql:
{% assign v = parsed_input1._sql | size%}{% if v > 0  %}(left(${parsed_input1},1)){% endif %}
{% assign v = parsed_input2._sql | size%}{% if v > 0  %}||(left(${parsed_input2},1)){% endif %}
{% assign v = parsed_input3._sql | size%}{% if v > 0  %}||(left(${parsed_input3},1)){% endif %}
{% assign v = parsed_input4._sql | size%}{% if v > 0  %}||(left(${parsed_input4},1)){% endif %}
    ;;
    type:string
  }
}


#}<<<
#^^^^ End Functions



explore: uas2 {}
# view: age_times_3 {extends:[split_input_remote_multiply] dimension: input {sql:${uas2.age}^^3;;}}
# view: id_times_100{extends:[split_input_remote_multiply] dimension: input {sql:${users_view.id}^^100;;}}
# view: Age_Over_5{extends:[divide] dimension: input {sql:${users_view.age}^^5;;}}
view: id_over_age
{
  extends:[safe_divide]
  dimension: input {sql:${users_view.id}^^${users_view.age};;}#override with inputs, potentially with ^^ delimiter
  dimension: output #final override out output format and labels here
  {
    view_label:"Users View"
    # label: "[Override Default Label (this extending view's name)]"
    value_format_name: decimal_2
  }
}
view: acronymize1 {extends:[acronymize] dimension:input {sql:'Test'^^'another test'^^'Xavier';;}dimension:output{view_label:"Users View"}}
explore: users_view
{
  # join: age_times_3 {sql:;; relationship: one_to_one}
  # join: id_times_100 {view_label:"Users View" sql:;; relationship: one_to_one}
  # join: Age_Over_5 {view_label:"Users View" sql:;; relationship: one_to_one}

  join: id_over_age {sql:;; relationship: one_to_one}
  join: acronymize1 {sql:;; relationship: one_to_one}
}



view: liquid_nulls_test {
  sql_table_name: public.users ;;
  dimension: my_customer_value {
    # sql: 'value: {{_user_attributes['service_unit_name']}}';;
    sql: {% if _user_attributes['service_unit_name'] %}'found'{%else%}not found{%endif%} ;;

  }

}

explore: liquid_nulls_test {}

view: b1 {
  extends:[basic_users]
  dimension: in_query_check {
    sql: '{{basic_users2._is_selected}}' ;;
  }
}
include: "basic_users.view"
explore: b1 {
  join: basic_users2 {
    from: basic_users
    sql_on: ${b1.id}=${basic_users2.id} ;;
    type: left_outer
    relationship: one_to_one
  }
}




view: parse_integer {
  extends: [basic_users]
  dimension: id_and_name_concat {sql: ${id} || '__' || ${last_name} ;;}
  parameter: param_entry {suggest_dimension: id_and_name_concat}
  dimension: parsed_id{sql: {{param_entry._parameter_value | split: '__' | first | replace_first: "'", "" }};;}
}
explore: parse_integer {}
