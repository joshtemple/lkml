connection: "thelook_events_redshift"


access_grant: internal {
  user_attribute: is_internal
  allowed_values: ["internal"]
}
access_grant: external {
  user_attribute: is_internal
  allowed_values: ["external"]
}


explore: my_explore {
  view_name: dummy
  join: poc_internal {
    required_access_grants: [internal]
    relationship: one_to_one
    type: full_outer
    sql_on: 1=1  ;;
  }
  join: poc_external {
    required_access_grants: [external]
    relationship: one_to_one
    type: full_outer
    sql_on: 1=1  ;;
  }
}

view: dummy {
  derived_table: {
    sql: select null as placeholder ;;
  }
  dimension: placeholder {hidden:yes primary_key:yes}
}

view: poc_internal {
  view_label: "Common View Label"
  derived_table: {
    sql:
select 1 as id_internal, 101 as value_internal union all
select 2 as id_internal, 102 as value_internal
;;
  }
  dimension: id_internal {}
  dimension: value_internal {type:number}
  measure: sum_value {type:sum sql:${value_internal};;}
}

view: poc_external {
  view_label: "Common View Label"
  derived_table: {
    sql:
    select 1 as id, 101 as value union all
    select 2 as id, 102 as value
    ;;
  }
  dimension: id {}
  dimension: value {type:number}
  measure: sum_value {type:sum sql:${value};;}
}
