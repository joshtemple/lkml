connection: "thelook_events_redshift"
include: "/views/*.view"

explore: order_items {
  from: order_items
#   view_name: order_items
  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }

  join: inventory_items {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id};;
  }

  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
  }

  join:user_id_custom_tiers {sql:;;relationship:one_to_one}

}


###################################################
### Additional 'Apply a Feature Using Extends' examples
###################################################

#### Advanced: Re-use the same feature on the same view ##
## To use a feature twice on the same view, you'll need to create a separate view (exact same view_name.field_name cannot be re-used in an explore).
## You can create a placeholder view with fully qualified reference(s) to field(s), and 'bare join'(s) it to the explore
view: user_id_custom_tiers {
  #no source table required
  view_label: "Users" #make this appears in the appropriate section of field picker
  extends: [custom_tiers]
  dimension: field_to_tier {
    label: "User ID Tier"
    sql: ${users.id} ;;#fully qualified reference
  }
}
# #add this 'bare join' to the explore.  Blank SQL allows us to join in our new fields without changing the from clause
# join:user_id_custom_tiers {sql:;;relationship:one_to_one}

####################
## Tooltipify feature example:
###### Feature Template with placeholders for input and output fields.
view: tooltipify {
  measure: my_measure {
    hidden:yes
    type: number
  }
  measure: tooltip_for_my_measure {
    hidden:yes
  }
  measure: output_measure {
    sql: ${my_measure} ;;
    type: number
    html: {{my_measure._rendered_value}}<br><div align="center" style="width:100%; color:white; background:gray">({{tooltip_for_my_measure._rendered_value}})</div> ;;
  }
}
##### Instantiate my feature, #1
view: user_count__with_created_date_tooltip {
  view_label: "Users"
  extends: [tooltipify]
  measure: my_measure {sql: ${users.count} ;;} ##must fully qualify input fields, and fields reference must be valid in the explore
  measure: tooltip_for_my_measure {sql: 'note: includes users created between ' || min(${users.created_date}) || ' and ' || max(${users.created_date}) ;;}
  measure: output_measure {label: "User Count with Created Date Tooltip"}
}
##### Instantiate my feature again, using a different base field
view: user_count__with_avg_age_tooltip {
  view_label: "Users"
  extends: [tooltipify]
  measure: my_measure {sql: ${users.count} ;;}
  measure: tooltip_for_my_measure {sql: 'note: avg age ' || avg(${users.age}) ;;}
  measure: output_measure {label: "User Count with Avg Age Tooltip"}
}
#explore that uses the tooltipfied measures
explore: users_with_tooltipified_measures{
  view_name: users
  from: users
  join: user_count__with_created_date_tooltip {sql:;; relationship:one_to_one}
join: user_count__with_avg_age_tooltip {sql:;; relationship:one_to_one}
}

####################
## Rank one thing by another (e.g. Transaction Sequence Number, etc):
# include: "/features/sequence_transaction.view.lkml" #remove reference
# include: "/km_tt_for_join_lab.model.lkml" #the model your explore is in
#
# # (BB Step 1): Update the dimensions named below, for the sequencing you want
# # (BB Step 2): Update the view name just above, replacing [the templated name] (the text up to '__view') with the [name you want for this anaylysis]
# # (BB Step 3): Find and replace occurrences of [the templated name] with your updated name. (varios references to ...__view, ...__ndt, and ...__explore
# # (BB Step 4): Update 'my_explore' in __explore to match the explore you want to use this with
# # (BB Step 5): Update your main explore by extending with [name you want for this anaylysis]__explore
# view: sequence_input__order_item_for_gender__view {#?name by the parent/child combination?
#   extends: [sequence_input]
#   #Update with fields that are valid together in an explore:
#   dimension: input_parent_unique_id__dimension  {sql:${users.gender};;}
#   dimension: input_child_unique_id__dimension   {sql:${order_items.id};;}
#   dimension: order_by_dimension                 {sql:${order_items.created_raw};;}#must be same as child field or have a one_to_one relationship (ie id and created_time is ok)
#   # measure:   order_by_measure                   {sql:null;;}#optional measure input
#
#   #bind dimension references can be added here if necessary. Will have to list each explicitly here and in corresponding bind_filters parameter of the ranking view
#   #dimension: age_and_gender_combo {sql:${users.age_and_gender_combo};;}
# }
#
# view: rank__order_item__for__gender {
#   extends:[sequencing_ndt]
#   derived_table: {
#     #update with the name of the input explore you defined
#     explore_source: rank__order_item__for__gender__explore {
#       column: parent_unique_id  {field:sequence_input__order_item_for_gender__view.input_parent_unique_id__dimension}
#       column: child_unique_id   {field:sequence_input__order_item_for_gender__view.input_child_unique_id__dimension}#
#       column: order_by_dimension {field:sequence_input__order_item_for_gender__view.order_by_dimension}
#       column: order_by_measure {field:sequence_input__order_item_for_gender__view.order_by_measure}
#       #bind filters can be added here if necessary. List
#       #bind_filters: {from_field: users.age_and_gender_combo to_field: sequence_input__order_item_for_gender__view.age_and_gender_combo} #bind filters where necessary... no way to pre-emptively bind all filters
#     }
#   }
# }
#
# ###sequence
# explore: rank__order_item__for__gender__explore {#name by the parent/child combination?
#   #update 'my_explore' to your explore name
#   extends:[order_items]
#   #?may need to explicitly mention base view name of my_explore (if it's not set explicitly in the base). not sure if that's the case though. further testing required
#   #update the from to match the input view name above
#   join: sequence_input__order_item_for_gender__view {sql:;;relationship:one_to_one}
# #update the join name to match the ranking view defined above, and update the references to mach that same join name
#   join: rank__order_item__for__gender {
#     sql_on:
#     ${rank__order_item__for__gender.child_unique_id}   =${sequence_input__order_item_for_gender__view.input_child_unique_id__dimension} and
#     ${rank__order_item__for__gender.parent_unique_id}  =${sequence_input__order_item_for_gender__view.input_parent_unique_id__dimension} and
#     ${rank__order_item__for__gender.order_by_dimension}=${sequence_input__order_item_for_gender__view.order_by_dimension};;
#     relationship: many_to_one}# dev note:in case the unique_id field isn't really unique, this is more accurate. don't plan to measure things on the sequencing, so symmetric aggregates wont be invoked
# }
# #####
