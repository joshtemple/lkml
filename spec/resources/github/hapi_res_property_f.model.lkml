connection: "edw"
include: "*.view"         # include all views in this project

label: "Reservations-HAPI (alpha)"

datagroup: model_caching_dg {
  sql_trigger: select max( dw_update_dt ) from pedw.fact.hapi_res_property_f ;;
  max_cache_age: "8 hours"
}

explore: hapi_res_property_f_v {
  from: hapi_res_property_f_v
  sql_table_name: pedw.fact.hapi_res_property_f ;;
  group_label: "***User Acceptance Testing***"
  label: "Reservations-HAPI (uat)"
  persist_with: model_caching_dg

  access_filter: {
    field: user_property_fdm.user_id
    user_attribute: looker_ldap_user_id
  }

  join: hapi_res_property_f_v_msr_ty {
    from: hapi_res_property_f_v_msr_ty
    view_label: "    TY"
    type: cross
    relationship: one_to_one
  }

  join: hapi_res_property_f_v_msr_ly {
    from: hapi_res_property_f_v_msr_ly
    view_label: "   LY"
    type: cross
    relationship: one_to_one
  }

  join: hapi_res_property_f_v_msr_toly {
    from: hapi_res_property_f_v_msr_toly
    view_label: "    TY"
    type: cross
    relationship: one_to_one
  }

  join: user_property_fdm {
    from:  user_property_fdm
    sql_on: ${user_property_fdm.property_key} = ${hapi_res_property_f_v.property_key} ;;
    type: inner
    relationship: many_to_one
  }

  join: booked_date_dm {
    from: date_dm
    view_label: "  Booked Date"
    sql_on: ${booked_date_dm.date_sid} = ${hapi_res_property_f_v.booked_date_sid};;
    sql_where: {% parameter booked_date_dm.available_timeperiod %} = ''
      or utl..udf_period_trunc_dt( {% parameter booked_date_dm.available_timeperiod %}, ${booked_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter booked_date_dm.available_timeperiod %}  ) ;;
    type: inner
    relationship: many_to_one
  }

  join: stay_date_dm {
    from: date_dm
    view_label: "  Stay Date"
    sql_on: ${stay_date_dm.date_sid} = ${hapi_res_property_f_v.stay_date_sid};;
    sql_where: {% parameter booked_date_dm.available_timeperiod %} = ''
      or utl..udf_period_trunc_dt( {% parameter booked_date_dm.available_timeperiod %}, ${stay_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter booked_date_dm.available_timeperiod %}  ) ;;
    type: inner
    relationship: many_to_one
  }

  join: property_dm {
    from: property_dm
    view_label: " Property"
    sql_on: ${property_dm.property_key} = ${hapi_res_property_f_v.property_key} ;;
    type: inner
    relationship: many_to_one
  }

}
