connection: "youtubeconsumer1"

# include all the views
include: "*.view"

explore: ytcvariable_fact {
  label: "YouTube Consumer for Users"
  view_name: ytcvariable_fact
  view_label: "YouTube Consumer for Users"

  join: ytcdemographic {
    view_label: "YouTube Consumer for Users"
    type: inner
    relationship: many_to_one
    sql_on: ${ytcvariable_fact.unique_id} = ${ytcdemographic.unique_id};;
  }

  join: ytccategory_master {
    view_label: "YouTube Consumer for Users"
    type: inner
    relationship: many_to_one
    sql_on: ${ytcvariable_fact.category_id} = ${ytccategory_master.category_id};;
  }

  join: ytccategory_map {
    view_label: "YouTube Consumer for Users"
    type: inner
    relationship: many_to_one
    sql_on: ${ytcvariable_fact.category_id} = ${ytccategory_map.string_field_2};;
  }
}


explore: ytcvariable_eav {
  label: "YouTube Consumer Crosstab"
  view_name: ytcvariable_eav
  view_label: "YouTube Consumer Crosstab"
  sql_always_where: ${value} is not null;;

  join: ytcdemographic_2 {
    view_label: "YouTube Consumer Crosstab"
    type: inner
    relationship: many_to_one
    sql_on: ${ytcvariable_eav.unique_id} = ${ytcdemographic_2.unique_id};;
  }

  join: ytcvariable_master {
    view_label: "YouTube Consumer Crosstab"
    type: inner
    relationship: one_to_one
    sql_on: ${ytcvariable_eav.variable_id} = ${ytcvariable_master.variable_id};;
  }

  join: ytcvalue_master {
    view_label: "YouTube Consumer Crosstab"
    type: inner
    relationship: one_to_one
    sql_on: ${ytcvariable_eav.variable_id} = ${ytcvalue_master.variable_id};;
  }

  join: ytccategory_master {
    view_label: "YouTube Consumer Crosstab"
    type: inner
    relationship: many_to_one
    sql_on: ${ytcvariable_eav.category_id} = ${ytccategory_master.category_id};;
  }

  join: ytccategory_map_2 {
    view_label: "YouTube Consumer Crosstab"
    type: inner
    relationship: many_to_one
    sql_on: ${ytcvariable_eav.category_id} = ${ytccategory_map_2.string_field_2};;
  }
}
