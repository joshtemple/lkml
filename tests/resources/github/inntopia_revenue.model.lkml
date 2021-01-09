 connection: "edw"
# include: "*.view"         # include all views in this project

# label: "Inntopia"

# datagroup: model_caching_dg {
#   sql_trigger: select max( dw_update_dt ) from pedw.dev.inntopia_event_property_f ;;
#   max_cache_age: "8 hours"
# }

#     explore: inntopia_event_property_f {
#     group_label: "***Development***"
#     label: "Inntopia Revenue (dev)"
#     view_label: "  Measures"
#     persist_with: model_caching_dg
#     case_sensitive: no

#     access_filter: {
#       field: user_property_fdm.user_id
#       user_attribute: looker_ldap_user_id
#     }

#     join: user_property_fdm {
#       from:  user_property_fdm
#       sql_on: ${user_property_fdm.property_key} = ${inntopia_event_property_f.property_key} ;;
#       type: inner
#       relationship: many_to_one
#     }

#     join: inntopia_event_property_f_msr_ty {
#       from: inntopia_event_property_f_msr_ty
#       view_label: "    TY"
#       type: cross
#       relationship: one_to_one
#     }

#     join: inntopia_event_property_f_msr_ly {
#       from: inntopia_event_property_f_msr_ly
#       view_label: "   LY"
#       type: cross
#       relationship: one_to_one
#     }

#     join: inntopia_event_property_f_msr_toly {
#       from: inntopia_event_property_f_msr_toly
#       view_label: "    TY"
#       type: cross
#       relationship: one_to_one
#     }

#   join: date_dm{
#     from: date_dm
#     view_label: " Event Date"
#     sql_on: ${date_dm.date_sid} = ${inntopia_event_property_f.EVENTDATE_SID}  ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: purchase_date_dm{
#     from: date_dm
#     view_label: " Purchase Date"
#     sql_on: ${purchase_date_dm.date_sid} = ${inntopia_event_property_f.PURCHASEDATE_SID}  ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: property_dm {
#     from: property_dm
#     view_label: " Property"
#     sql_on: ${property_dm.property_key} = ${inntopia_event_property_f.property_key} ;;
#     type: inner
#     relationship: many_to_one
#   }
# }
