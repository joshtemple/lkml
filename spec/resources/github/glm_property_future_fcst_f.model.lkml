connection: "edw"

include: "*.view.lkml"                       # include all views in this project


label: "GL Monthly w/ Forecast"

datagroup: model_caching_dg {
  sql_trigger: select max( dw_update_dt ) from pedw.fact.glm_property_f ;;
  max_cache_age: "8 hours"
}


explore: glm_property_future_fcst_f {
  from: glm_property_future_fcst_f
  sql_table_name: pedw.fact.glm_property_f ;;
  sql_always_where: ${glm_property_future_fcst_f.date_sid} >= utl..udf_date_to_julian( date_trunc( year, dateadd(year, -6, current_date()))) ;;
  group_label: "***User Acceptance Testing***"
  label: "GL Monthly w/ Forecast (uat)"
  description: "**Includes forecasts loaded in current month
  **Compares Actuals/Forecast to LY and Budget
  **Past is replaced with actuals
  **Future shows zero if current month forecast not loaded"
  persist_with: model_caching_dg
  case_sensitive: no


  access_filter: {
    field: user_property_fdm.user_id
    user_attribute: looker_ldap_user_id
  }

  join: user_property_fdm {
    from:  user_property_fdm
    sql_on: ${user_property_fdm.property_key} = ${glm_property_future_fcst_f.property_key} ;;
    type: inner
    relationship: many_to_one
  }

  join: glm_property_future_fcst_f_ly {
    from: glm_property_future_fcst_f_ly
    view_label: "     LY"
    type: cross
    relationship: one_to_one
  }

  join: glm_property_future_fcst_f_bdgt {
    from: glm_property_future_fcst_f_bdgt
    view_label: "   Bdgt"
    type: cross
    relationship: one_to_one
  }

  join: glm_property_future_fcst_f_ty {
    from: glm_property_future_fcst_f_ty
    view_label: "      TY"
    type: cross
    relationship: one_to_one
  }

  join: glm_property_future_fcst_f_toly {
    from: glm_property_future_fcst_f_toly
    view_label: "      TY"
    type: cross
    relationship: one_to_one
  }

  join: glm_property_future_fcst_f_tobdgt {
    from: glm_property_future_fcst_f_tobdgt
    view_label: "      TY"
    type: cross
    relationship: one_to_one
  }

  join: date_dm {
    from: date_dm
    view_label: " Date"
    sql_on: ${date_dm.date_sid} = ${glm_property_future_fcst_f.date_sid};;
    sql_where: {% parameter date_dm.available_timeperiod %} = ''
      or utl..udf_period_trunc_dt( {% parameter date_dm.available_timeperiod %}, ${date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter date_dm.available_timeperiod %}  ) ;;
    type: inner
    relationship: many_to_one
  }

  join: property_dm {
    from: property_dm
    view_label: " Property"
    sql_on: ${property_dm.property_key} = ${glm_property_future_fcst_f.property_key} ;;
    type: inner
    relationship: many_to_one
  }

}
