connection: "thelook_events_redshift"

view: original_view {
  sql_table_name: public.users ;;# sql_table_name: public.foobar ;;
  dimension: foo {hidden:yes}
  dimension: bar {hidden:yes}
  dimension: city {hidden:yes}
}

view: ndt {
  derived_table: {
    explore_source: test { # explore_source: original_view {
      column: city {field:original_view.city} # column: foo {}
      derived_column: rank_among_filtered_cities {sql:row_number() over();;}
      bind_filters: {
        from_field: sql_dt.bar
        to_field: original_view.city # to_field: original_view.bar
      }

    }
  }
  dimension: city {hidden:yes} # dimension: foo {}
  dimension: rank_among_filtered_cities {hidden:yes}
}

view: sql_dt {
  derived_table: {
    sql: SELECT * FROM ${ndt.SQL_TABLE_NAME} ;;
  }
  dimension: city {}#dimension: foo {}
  dimension: rank_among_filtered_cities {}
  filter: bar {}
}

#no row table from which to full outer join on false
view: dummy {derived_table: {sql: select ''::text as dummy_join from (select 1) where 1=0 ;;}}

#ndt needs to be in the same explore we are using in order to utilize with bind filters
explore: test {
  ### support views ###
  view_name: dummy
  join: original_view {
    type: full_outer
    relationship: one_to_one
    sql_on: dummy.dummy_join=original_view.city;; #outer join on false
  }
  join: ndt {
    type: full_outer
    relationship: one_to_one
    sql_on: dummy.dummy_join=ndt.city;;
  }

  ### actual views we'll use ###
  join: sql_dt {
    type: full_outer
    relationship: one_to_one
    sql_on: dummy.dummy_join=sql_dt.city;; #outer join on false
  }
}
