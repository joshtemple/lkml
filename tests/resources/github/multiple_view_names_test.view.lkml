# #If you need to break up a single view into multiple view labels v
# view: multiple_view_names_test {
#   derived_table: {
#     sql:
#     select 1 as id, 'a' as value, 'x' as another_field union all
#     select 2 as id, 'b' as value, 'y' as another_field union all
#     select 3 as id, 'c' as value, 'z' as another_field
#     ;;
#   }
#   dimension: id {type:number sql:multiple_view_names_test.id;;}#hardcode the actual table name in, so it is not overridden by the view name
#   dimension: value {sql:multiple_view_names_test.value;;}
#   dimension: another_field {sql:multiple_view_names_test.another_field;;}
#   set: multiple_view_names_test {fields:[id,value]}
#   set: alternate_table_name {fields:[another_field]}
# }
# view: alternate_table_name {
#   extends: [multiple_view_names_test]
#   sql_table_name:;;
# }#extend to make the fields available under a seperate view label

# explore: multiple_view_names_test {#don't use true base table so that we can easily include only the set we want for the base table
#   fields: [ALL_FIELDS*,-multiple_view_names_test.alternate_table_name*]
#   join: alternate_table_name {
#     fields: [alternate_table_name*]
#     relationship: one_to_one
#     sql:  ;;#blank sql so there's not really any join
#   }
# }


# view: test {derived_table:{sql: select null as id;;}}
# explore: test {#don't use true base table so that we can easily include only the set we want for the base table
#   join: multiple_view_names_test {
#     fields: [multiple_view_names_test*]
#     relationship: one_to_one
#     type: cross #cross join on the first table only
#   }
#   join: alternate_table_name {
#     fields: [alternate_table_name*]
#     relationship: one_to_one
#     sql:  ;;#blank sql so there's not really any join
#   }
# }
