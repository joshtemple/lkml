connection: "edw"
include: "*.view"         # include all views in this project

label: "AR Aging Metrics"

datagroup: model_caching_dg {
  sql_trigger: select max( dw_update_dt ) from pedw.fact.glm_property_ar_aging_f ;;
  max_cache_age: "8 hours"
}

explore: glm_property_ar_aging_f {
  group_label: "Portfolio"
  label: "AR Aging Metrics (uat)"
  persist_with: model_caching_dg
  view_label: "    Measures"

  access_filter: {
    field: user_property_fdm.user_id
    user_attribute: looker_ldap_user_id
  }

  join: user_property_fdm {
    from:  user_property_fdm
    sql_on: ${user_property_fdm.property_key} = ${glm_property_ar_aging_f.property_key} ;;
    type: inner
    relationship: many_to_one
  }

  always_filter: {
    filters: {
      field: period_type_dm.period_type_name
      value: "YTD"
    }
  }


  join: glm_property_ar_aging_f_ty {
    from: glm_property_ar_aging_f_ty
    view_label: "      TY"
    type: cross
    relationship: one_to_one
  }


  join: date_dm {
    from: date_dm
    view_label: "  Date"
    sql_on: ${date_dm.date_sid} = ${glm_property_ar_aging_f.month_date_sid};;
    sql_where: {% parameter date_dm.available_timeperiod %} = ''
      or utl..udf_period_trunc_dt( {% parameter date_dm.available_timeperiod %}, ${date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter date_dm.available_timeperiod %}  ) ;;
    type: inner
    relationship: many_to_one
  }
#
#   join: date_dm{
#   from: date_dm
#     view_label: "  Date"
#     fields: [ date_dm.cal_dt
#             , date_dm.cal_month_dt
#             , date_dm.month
#             , date_dm.month_num
#             , date_dm.month_name
#             , date_dm.quarter
#             , date_dm.quarter_of_year
#             , date_dm.year
#             , current_period_qtd
#             , current_period_ytd
#             ]
#     sql_on: ${date_dm.date_sid} = ${mm_property_kpi_f.month_date_sid}  ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: date_month_parameter{
#     view_label: "  Date"
#     sql_on: ${date_month_parameter.date_sid} = ${mm_property_kpi_f.month_date_sid};;
#     type: inner
#     relationship: many_to_one
#   }

  join: period_type_dm {
    view_label: "Aggregation Type"
    sql_on: ${period_type_dm.period_type_shk} = ${glm_property_ar_aging_f.period_type_shk} ;;
    type: inner
    relationship: many_to_one
  }

  join: property_dm {
    view_label: " Property"
    sql_on: ${glm_property_ar_aging_f.property_key} = ${property_dm.property_key} ;;
    type: inner
    relationship: many_to_one
  }


}
