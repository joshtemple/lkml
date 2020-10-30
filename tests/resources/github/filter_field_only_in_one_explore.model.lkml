connection: "thelook_events_redshift"

view: user_derived_for_filter_field_only_in_one_explore{
  derived_table: {
    sql:
select *
from public.users
where
1=1
{%if _explore._name == 'user_derived_for_filter_field_only_in_one_explore'%}
and
{%condition other_view_order_items_for_filter_field_only_in_one_explore.age_filter_from_other_view %}age{%endcondition%}
{%endif%}
;;
  }
  dimension: id {primary_key: yes}
  dimension: age {}
}

view: other_view_order_items_for_filter_field_only_in_one_explore{
    sql_table_name: public.order_items ;;
    dimension: id {primary_key: yes}
    dimension: sale_price {type:number}
    dimension: user_id {}
    filter: age_filter_from_other_view {
      type:number}
    measure: total_sale_price {
      type:sum
      sql:${TABLE}.sale_price;;
    }
}

explore: user_derived_for_filter_field_only_in_one_explore {
  join: other_view_order_items_for_filter_field_only_in_one_explore {
    type: left_outer
    sql_on: ${other_view_order_items_for_filter_field_only_in_one_explore.user_id}= ${user_derived_for_filter_field_only_in_one_explore.id};;
    relationship: one_to_many
  }
}

explore: user_derived_for_filter_field_only_in_one_explore__2 {
  view_name: user_derived_for_filter_field_only_in_one_explore
}
