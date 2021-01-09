 connection: "edw"
# include: "*.view"         # include all views in this project

# label: "Property Pace Inntopia (dev)"

# datagroup: model_caching_dg {
#   sql_trigger: select max( dw_update_dt ) from pedw.dev.inntopia_res_property_f ;;
#   max_cache_age: "8 hours"
# }

# explore: inntopia_res_property_f {
#   from: inntopia_res_property_f
#   sql_table_name: pedw.dev.inntopia_res_property_f ;;
#   group_label: "***Development***"
#   label: "Property Pace Inntopia (dev)"
#   persist_with: model_caching_dg

#   access_filter: {
#     field: user_property_fdm.user_id
#     user_attribute: looker_ldap_user_id
#   }

#   join: user_property_fdm {
#     from:  user_property_fdm
#     sql_on: ${user_property_fdm.property_key} = ${inntopia_res_property_f.propertykey} ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: inntopia_res_property_f_msr_ty {
#     from: inntopia_res_property_f_msr_ty
#     view_label: "    TY"
#     type: cross
#     relationship: one_to_one
#   }

#   join: inntopia_res_property_f_msr_ly {
#     from: inntopia_res_property_f_msr_ly
#     view_label: "   LY"
#     type: cross
#     relationship: one_to_one
#   }

#   join: inntopia_res_property_f_msr_toly {
#     from: inntopia_res_property_f_msr_toly
#     view_label: "    TY"
#     type: cross
#     relationship: one_to_one
#   }

#   join: stay_date_dm {
#     from: date_dm
#     view_label: "  Stay Date"
#     sql_on: ${stay_date_dm.date_sid} = ${inntopia_res_property_f.stay_date_sid};;
#     sql_where: {% parameter stay_date_dm.available_timeperiod %} = ''
#       or utl..udf_period_trunc_dt( {% parameter stay_date_dm.available_timeperiod %}, ${stay_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter stay_date_dm.available_timeperiod %}  ) ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: booking_date_dm {
#     from: date_dm
#     view_label: "  Booking Date"
#     sql_on: ${booking_date_dm.date_sid} = ${inntopia_res_property_f.booking_date_sid};;
#     sql_where: {% parameter booking_date_dm.available_timeperiod %} = ''
#       or utl..udf_period_trunc_dt( {% parameter booking_date_dm.available_timeperiod %}, ${booking_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter booking_date_dm.available_timeperiod %}  ) ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: property_dm {
#     from: property_dm
#     view_label: " Property"
#     sql_on: ${property_dm.property_key} = ${inntopia_res_property_f.propertykey} ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: inntopia_dimcustomer {
#     view_label: "  Measures"
#     sql_on: ${inntopia_res_property_f.customerkey} = ${inntopia_dimcustomer.CUSTOMERKEY} ;;
#     type: inner
#     relationship: many_to_one
#   }
# }
