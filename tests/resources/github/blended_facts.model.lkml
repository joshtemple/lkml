connection: "thelook_events_redshift"

#goal is to demonstrate proper way to create an explore for two fact tables
#can't just join on the available keys. This leads to problems with facts with different granularity
#traditional solution by BI tools is to aggregate each side, then join ('Blending')
#That is difficult in looker as it would require dynamic specification of join logic (and select logic from each fact)
#The approach below uses Outer Join On False and it looks pretty practical

### Fact Tables {
view: sales_fact {
  #hard-coded derived tables defined elsewhere.  These should most likely be physical fact tables
  derived_table: {sql:select * from ${sales_fact_sample_data.SQL_TABLE_NAME} ;;}
  dimension: sales_row_id {primary_key:yes view_label:"to be hidden"}
  dimension: agent_id {view_label:"to be hidden"}
  dimension: month_id {view_label:"to be hidden"}
  dimension: sales {view_label:"to be hidden"}
  measure: total_sales {
    type: sum
    sql: ${sales} ;;
  }
}

view: costs_fact {
  derived_table: {sql:select * from ${costs_fact_sample_data.SQL_TABLE_NAME} ;;}
  dimension: costs_row_id {primary_key:yes view_label:"to be hidden"}
  dimension: month_id {view_label:"to be hidden"}
  dimension: vendor_id {view_label:"to be hidden"}
  dimension: costs {view_label:"to be hidden"}
  measure: total_costs {
    type: sum
    sql: ${costs} ;;
  }
}
###} END Fact Tables


### Special View that coalesces EVERY key from amongst your included fact tables
view: conform_dimensions {
  #For every fact table you add, you must consider each key in your fact table
  # # Create a new entry here OR append to the coalesce list for that key if it already exists
  dimension: month_id {sql: coalesce(${costs_fact.month_id},${sales_fact.month_id}) ;;}
  dimension: agent_id {sql: coalesce(${sales_fact.agent_id});;}
  dimension: vendor_id {sql:coalesce(${costs_fact.vendor_id});;}
}

### Then we have 'normal' dimensional views.  We'll join to these using 'to-one' lookups from our fact tables (the corresponding coalesced key)
# Dimensional fields should only be visible from these conformed views
view: conformed_month_lookup {
  derived_table: {sql: select * from ${conformed_month_lookup_sample_data.SQL_TABLE_NAME};;}
  dimension: month_id {primary_key:yes view_label:"to be hidden"}
  dimension: month_label {}
  #...other dimensions on your conformed dimension table
}
view: conformed_agent_lookup {
  derived_table:{sql:select * from ${conformed_agent_lookup_sample_data.SQL_TABLE_NAME};;}
  dimension: agent_id {primary_key:yes view_label:"to be hidden"}
  dimension: agent_label {}
}
view: conformed_vendor_lookup {
  derived_table:{sql:select * from ${conformed_vendor_lookup_sample_data.SQL_TABLE_NAME};;}
  dimension: vendor_id {primary_key:yes view_label:"to be hidden"}
  dimension: vendor_label {}
  dimension: vendor_type {
    case: {
      when: {
        sql: ${vendor_label} like 'Test%' ;;
        label: "Test"
      }
      else: "Other"
    }
  }
}

#####
## BAD - Naive explore definition {
explore: mutliple_fact_tables_naive {
  view_name: sales_fact
  #allows pulling costs by agent which gives misleading results
  join: costs_fact {
    type: left_outer
    relationship: many_to_one
    sql_on: ${costs_fact.month_id}=${sales_fact.month_id} ;;
  }
}
## } End BAD - Naive explore definition


#######
## Recommended Explore design {
##explore using outer join on false and conformed dimension tables
explore: mutliple_fact_tables_recommendation {
  #start with most commonly used fact
  view_name: sales_fact

  #join other facts using outer join on false
  join: costs_fact {
    relationship: one_to_one
    #full outer join on false... made these ids not overlap
    sql: full outer join costs_fact on ${costs_fact.costs_row_id}=${sales_fact.sales_row_id}  ;;
  }

  #join in the special view that coalesces id fields
  join: conform_dimensions {
    view_label: "to be hidden"
    # sql_on: ${sales_fact.month}=${conformed_month.month} ;;
    # relationship: many_to_one
    # type: left_outer
    relationship: one_to_one
    sql:  ;;
  }

  #join in your conformed dimension tables
  join: conformed_month_lookup {
    sql_on: ${conformed_month_lookup.month_id}=${conform_dimensions.month_id} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: conformed_agent_lookup {
    sql_on: ${conformed_agent_lookup.agent_id}=${conform_dimensions.agent_id} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: conformed_vendor_lookup {
    sql_on: ${conformed_vendor_lookup.vendor_id}=${conform_dimensions.vendor_id};;
    relationship: many_to_one
    type: left_outer
  }

}
##}  End Recommended Explore design


#######
#### Hardcoded Test/Sample data {
view: sales_fact_sample_data {
  derived_table: {
    sql:
    Select 1001 as sales_row_id,1 as agent_id, 1 as month_id, 1 as sales union all
    Select 1002 as sales_row_id,1 as agent_id, 2 as month_id, 11 as sales union all
    Select 1003 as sales_row_id,2 as agent_id, 1 as month_id, 2 as sales union all
    Select 1004 as sales_row_id,2 as agent_id, 2 as month_id, 22 as sales
    --union all
        ;;
  }
}
view: costs_fact_sample_data {
  derived_table: {
    sql:
    Select 1 as costs_row_id,1 as month_id, 1 as vendor_id, 1 as costs union all
    Select 2 as costs_row_id,1 as month_id, 2 as vendor_id, 2 as costs union all
    Select 3 as costs_row_id,2 as month_id, 1 as vendor_id, 2 as costs union all
    Select 4 as costs_row_id,2 as month_id, 2 as vendor_id, 202 as costs
    --union all
            ;;
  }
}
view: conformed_month_lookup_sample_data {
  derived_table: {sql:
    Select 1 as month_id, 'Jan 2019' as month_label union all
    Select 2 as month_id, 'Feb 2019' as month_label
    --union all
        ;;
  }
}

view: conformed_agent_lookup_sample_data {
  derived_table: {sql:
    Select 1 as agent_id, 'Kevin' as agent_label union all
    Select 2 as agent_id, 'John' as agent_label
    --union all
        ;;
  }
}

view: conformed_vendor_lookup_sample_data {
  derived_table: {sql:
        Select 1 as vendor_id, 'Test: Vendor' as vendor_label union all
        Select 2 as vendor_id, 'Google' as vendor_label
        --union all
            ;;
  }
}
####} END Hardcoded Test/Sample data
