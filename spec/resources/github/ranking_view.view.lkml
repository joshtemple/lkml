include: "/features/sequence_transaction.view.lkml" #remove reference
include: "/km_tt_for_join_lab.model.lkml" #the model your explore is in

# (BB Step 1): Update the dimensions named below, for the sequencing you want
# (BB Step 2): Update the view name just above, replacing [the templated name] (the text up to '__view') with the [name you want for this anaylysis]
# (BB Step 3): Find and replace occurrences of [the templated name] with your updated name. (varios references to ...__view, ...__ndt, and ...__explore
# (BB Step 4): Update 'my_explore' in __explore to match the explore you want to use this with
# (BB Step 5): Update your main explore by extending with [name you want for this anaylysis]__explore
view: sequence_input__order_item_for_gender__view {#?name by the parent/child combination?
  extends: [sequence_input]
  #Update with fields that are valid together in an explore:
  dimension: input_parent_unique_id__dimension  {sql:${users.gender};;}
  dimension: input_child_unique_id__dimension   {sql:${order_items.id};;}
  dimension: order_by_dimension                 {sql:${order_items.created_raw};;}#must be same as child field or have a one_to_one relationship (ie id and created_time is ok)
  # measure:   order_by_measure                   {sql:null;;}#optional measure input

  #bind dimension references can be added here if necessary. Will have to list each explicitly here and in corresponding bind_filters parameter of the ranking view
  #dimension: age_and_gender_combo {sql:${users.age_and_gender_combo};;}
}


view: rank__order_item__for__gender {
  extends:[sequencing_ndt]
  derived_table: {
    #update with the name of the input explore you defined
    explore_source: rank__order_item__for__gender__explore {
      column: parent_unique_id  {field:sequence_input__order_item_for_gender__view.input_parent_unique_id__dimension}
      column: child_unique_id   {field:sequence_input__order_item_for_gender__view.input_child_unique_id__dimension}#
      column: order_by_dimension {field:sequence_input__order_item_for_gender__view.order_by_dimension}
      column: order_by_measure {field:sequence_input__order_item_for_gender__view.order_by_measure}
      #bind filters can be added here if necessary. List
      #bind_filters: {from_field: users.age_and_gender_combo to_field: sequence_input__order_item_for_gender__view.age_and_gender_combo} #bind filters where necessary... no way to pre-emptively bind all filters
    }
  }
}


###sequence
explore: rank__order_item__for__gender__explore {#name by the parent/child combination?
  #update 'my_explore' to your explore name
  extends:[order_items]
  view_name: order_items ##

  #?may need to explicitly mention base view name of my_explore (if it's not set explicitly in the base). not sure if that's the case though. further testing required
  #update the from to match the input view name above
  join: sequence_input__order_item_for_gender__view {sql:;;relationship:one_to_one}
#update the join name to match the ranking view defined above, and update the references to mach that same join name
  join: rank__order_item__for__gender {
    sql_on:
    ${rank__order_item__for__gender.child_unique_id}   =${sequence_input__order_item_for_gender__view.input_child_unique_id__dimension} and
    ${rank__order_item__for__gender.parent_unique_id}  =${sequence_input__order_item_for_gender__view.input_parent_unique_id__dimension} and
    ${rank__order_item__for__gender.order_by_dimension}=${sequence_input__order_item_for_gender__view.order_by_dimension};;
    relationship: many_to_one}# dev note:in case the unique_id field isn't really unique, this is more accurate. don't plan to measure things on the sequencing, so symmetric aggregates wont be invoked
}
#####
