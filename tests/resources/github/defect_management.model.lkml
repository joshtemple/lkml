#connection: "appcenter"
connection: "kaboodle_hazard"

include: "*.view"

explore: defects {
  label: "Defect Analytics"
  view_label: "Defect"
  group_label: "Defect Analytics"  #Grouping in the EXPLORE Dropdown
  from: defects
  view_name: defects
  sql_table_name: dbo.defects ;;

  join: defect_root_causes {
    view_label: "Defect Root Cause"
    relationship: many_to_one
    type: left_outer
    sql_on: ${defects.defect_num} = ${defect_root_causes.defect_number} ;;
  }

  join: root_cause_types {
    view_label: "Root Cause Type"
    relationship: many_to_one
    type: left_outer
    sql_on: ${defect_root_causes.rootcausetype_id} = ${root_cause_types.rootcausetype_id} ;;
  }

  join: users_defects {
    view_label: "Defect Users"
    relationship: many_to_one
    type: left_outer
    sql_on:  ${defect_root_causes.user_id} = ${users_defects.users_id} ;;
  }

  join: custmval_customer {
    view_label: "Company"
    relationship: many_to_one
    type: inner
    sql_on: ${defects.id_record} = ${custmval_customer.parent_id} ;;
    sql_where: ${custmval_customer.id_cust_rec} = 114 ;;
  }

  join: fldcustm_companyname {
    view_label: "Company"
    relationship: many_to_one
    type: inner
    sql_on: ${fldcustm_companyname.id_record} = ${custmval_customer.cust_value} ;;
  }

  join: custmval_servicetype {
    view_label: "Service Type"
    relationship: many_to_one
    type: inner
    sql_on: ${defects.id_record} = ${custmval_servicetype.parent_id} ;;
    sql_where: ${custmval_servicetype.id_cust_rec} = 763 ;;
  }

  join: fldcustm_servicetype {
    view_label: "Service Type"
    relationship: many_to_one
    type: inner
    sql_on: ${fldcustm_servicetype.id_record} = ${custmval_servicetype.cust_value} ;;
  }
}
