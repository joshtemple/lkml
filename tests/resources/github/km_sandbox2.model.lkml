connection: "thelook_events_redshift"

include: "user_creation_support.view.lkml"
include: "user_creation_support2.view.lkml"
explore: user_creation_support2 {}

include: "trank.view.lkml"
explore: trank {}

#
# # include all the views
# include: "*.view"
#
# # include all the dashboards
# include: "*.dashboard"
#
# datagroup: km_sandbox_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }
#
# persist_with: km_sandbox_default_datagroup
#
# # explore: order_items_symm_aggs {
# #   view_name: order_items
# #   join: users {
# #     type: left_outer
# #     sql_on: ${order_items.user_id} = ${users.id} ;;
# #     relationship: many_to_one
# #   }
# # }
#
# explore: users_explore {
#   view_name: users
#   from: users
# }
#
# explore: order_items_dynamic_labels_testing {}
#
# explore: order_items {
#   view_label: "test-user_attribtes['emai']"
#   join: users {
#     type: left_outer
#     sql_on: ${order_items.user_id} = ${users.id} ;;
#     relationship: one_to_one
#   }
#
# #   join: double_count_checker {
# #     sql_on: ${double_count_checker.users_id}=${order_items.user_id} ;;
# #     relationship: one_to_one
# #   }
#
#
# #   join: inventory_items {
# #     type: left_outer
# #     sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
# #     relationship: many_to_one
# #
# #
# #   join: products {
# #     type: left_outer
# #     sql_on: ${inventory_items.product_id} = ${products.id} ;;
# #     relationship: many_to_one
# #   }
# #
# #   join: distribution_centers {
# #     type: left_outer
# #     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
# #     relationship: many_to_one
# #   }
# # }
# #
# # explore: products {
# #   join: distribution_centers {
# #     type: left_outer
# #     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
# #     relationship: many_to_one
# #   }
#
# join: ndt {
#   sql_on: ${ndt.users_id}=${users.id} ;;
#   type: left_outer
#   relationship: one_to_one
# }
#
# }
# #
# # explore: users {}
#
# # If necessary, uncomment the line below to include explore_source.
# # include: "km_sandbox.model.lkml"
#
# view: ndt {
#   derived_table: {
#     explore_source: order_items {
#       column: users_id { field: order_items.user_id }
#       column: users_id_count { field: users.count }
#       column: count {}
# #       filters: {
# #         field: order_items.user_id
# # #         value: "66354,86143"
# # #         value: "_filters['ndt.users_id']"
# #           value: "{% parameter ndt.users_id %}"
# #       }
#       bind_filters: {
#         to_field: order_items.user_id
#         from_field: ndt.users_id
#       }
#     }
#   }
#   dimension: users_id {type: number primary_key:yes}
#   dimension: users_id_count {type: number}
#   measure: total_users_id_count {type:sum sql:${users_id_count};;}
# #   dimension: count {type: number}
#   measure: age_corrected {type:number sql:sum(${users.age}/(1.0*${users_id_count}));;value_format_name:decimal_0}
# }
include: "functions.*"
#
include:"create_users_data.view.lkml"

explore: create_users_data {}
include: "order_items.view"
include: "users.view"
# explore: order_items2 {
#   view_name: order_items
#   join: functions               {fields:[]                    sql:;;relationship:one_to_one}
# always_join: [users]
# join: users {
#   sql_on: ${order_items.user_id}=${users.id} ;;
#   relationship: many_to_one
# }

# }
include: "summary_measures.view"
include: "variables_and_templates.view"
# explore: users_summary_measures {
#   join: variables_and_templates {sql:;;relationship:one_to_one}
#
# }

explore: users {
  join: variables_and_templates {                                                     sql:;;relationship:one_to_one}
join: demo_summary_measures   {from:summary_measures                                sql:;;relationship:one_to_one fields:[gender_summary,age_summary,full_name_summary]}
join: city_summary_measures   {from:summary_measures                                sql:;;relationship:one_to_one fields:[city_summary]}
# join: functions               {fields:[function_add,safe_divide]                    sql:;;relationship:one_to_one}
join: order_items             {relationship:one_to_one           type:left_outer   sql_on: ${order_items.user_id}=${users.id} ;;}

#seeing how easy it is to implement friendly custom filters.  not too hard but ugly with timezones and whatnot.
#   sql_always_where:
#     {% if users.friendly_created_date_filter._parameter_value == "'none_selected'" %}
#       1=1/*no filter, nothing happens*/
#     {% elsif users.friendly_created_date_filter._parameter_value == "'Yesterday'" %}
# /*((((users.created_at ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,-6, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) )))) AND (users.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,7, DATEADD(day,-6, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) ) ))))))) AND yesterdayfilter*/
# (((${users.created_raw} >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,-6, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) )))) AND (users.created_at ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,7, DATEADD(day,-6, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) ) )))))))
#     {% elsif users.friendly_created_date_filter._parameter_value == "'Last_1_Week'" %}
#       ${users.in_last_7_days}='Yes'
#     {% else %}1=1/*something else happens*/{% parameter users.friendly_created_date_filter %}
#     {% endif %}
#     ;;
# conditionally_filter: {
#   filters: {
#     field: created_date
#     value: "1 week"
#   }
#   unless: [users.hidden_filter]
# }
# # access_filter: {
# #   field: created_date
# #   user_attribute: first_name
# # }
# # always_filter: {
# #   filters: {
# #     field: users.hidden_param
# #     value: "{% friendly_created_date_filter._parameter_value %}"
# #   }
# # }
# sql_always_where: {% date_start users.created_date %} ;;
}


# explore: functions_explore {
#   view_name: functions2
#   from: functions
#   join: function_use {sql:;; relationship:one_to_one}
#   join: field_for_extending {from:field_for_extending sql:;;relationship:one_to_one
#     view_label: "Function Use"
#   }
# }


include: "gender_user_dt.view.lkml"
explore: gender_user_dt {}

include: "test_mintz.view"
explore: test_mintz {}

include: "timeline_viz_testing.view"
explore: timeline_viz_testing {}


#20181121 datagroup dependency test
# datagroup: dg_1 {
#   sql_trigger: select current_date() ;;
# }

# view: dt_1 {
#   derived_table: {
#     sql: select current_time() as t ;;
#     datagroup_trigger: dg_1
#   }
# }

# datagroup: dg_2 {
#   sql_trigger: select max(t) from ${dt_1.SQL_TABLE_NAME} ;;
# }

# view: dt_2 {
#   derived_table: {
#   sql: select 1 as a_number ;;
#   datagroup_trigger: dg_2
#   }
# }


explore: users2 {
  fields: [ALL_FIELDS*,-users.revenue__filtered_on_week,-users.revenue__filtered_on_week_female,-users.revenue__filtered_on_week_male]
  view_name: users
  always_filter: {
    filters: {
      field: users.created_date
      value: "7 days ago for 7 days"
    }
  }
}

explore: order_items {}

#intentionally reproduced errors when extending a field to a different type
# include: "test_date_for_tpx.view.lkml"
# explore: extending_test_date_for_tpx {}
