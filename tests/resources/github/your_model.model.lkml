connection: "sandbox"

# include all the views
include: "*.view"

explore: your_view_name {
#---- This is an example explore file


#---- Add in this sql_always_where clause replacing your_view_name
  sql_always_where:
  {% if your_view_name.current_date_range._is_filtered %}
    {% condition your_view_name.current_date_range %} ${event_raw} {% endcondition %}

    {% if your_view_name.previous_date_range._is_filtered or your_view_name.compare_to._in_query %}
      {% if your_view_name.comparison_periods._parameter_value == "2" %}
      or
      ${event_raw} between ${period_2_start} and ${period_2_end}

      {% elsif your_view_name.comparison_periods._parameter_value == "3" %}
        or
        ${event_raw} between ${period_2_start} and ${period_2_end}
        or
        ${event_raw} between ${period_3_start} and ${period_3_end}


      {% elsif your_view_name.comparison_periods._parameter_value == "4" %}
        or
        ${event_raw} between ${period_2_start} and ${period_2_end}
        or
        ${event_raw} between ${period_3_start} and ${period_3_end}
        or
        ${event_raw} between ${period_4_start} and ${period_4_end}

      {% else %} 1 = 1
      {% endif %}
    {% endif %}
  {% else %} 1 = 1
  {% endif %};;

  }
