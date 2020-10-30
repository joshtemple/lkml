 connection: "edw"
# include: "*.view"         # include all views in this project

# label: "Inntopia"

# datagroup: model_caching_dg {
#   sql_trigger: select max( dw_update_dt ) from pedw.dev.inntopia_campaign_property_f ;;
#   max_cache_age: "8 hours"
# }

# explore: inntopia_campaign_property_f {
#   group_label: "***Development***"
#   label: "Inntopia Campaign (dev)"
#   view_label: "  Measures"
#   persist_with: model_caching_dg
#   case_sensitive: no

#   access_filter: {
#     field: user_property_fdm.user_id
#     user_attribute: looker_ldap_user_id
#   }

#   join: user_property_fdm {
#     from:  user_property_fdm
#     sql_on: ${user_property_fdm.property_key} = ${inntopia_campaign_property_f.property_key} ;;
#     type: inner
#     relationship: many_to_one
#   }

#   join: inntopia_campaign_property_f_msr_ty {
#     from: inntopia_campaign_property_f_msr_ty
#     view_label: "    TY"
#     type: cross
#     relationship: one_to_one
#   }

#   join: inntopia_campaign_property_f_msr_ly {
#     from: inntopia_campaign_property_f_msr_ly
#     view_label: "   LY"
#     type: cross
#     relationship: one_to_one
#   }

#   join: inntopia_campaign_property_f_msr_toly {
#     from: inntopia_campaign_property_f_msr_toly
#     view_label: "    TY"
#     type: cross
#     relationship: one_to_one
#   }

#   join: first_open_date_dm{
#     from: date_dm
#     view_label: " First Opened Date"
#     sql_on: ${first_open_date_dm.date_sid} = ${inntopia_campaign_property_f.FIRSTOPENEDDATE_SID}  ;;
#     sql_where: {% parameter first_open_date_dm.available_timeperiod %} = ''
#     or utl..udf_period_trunc_dt( {% parameter first_open_date_dm.available_timeperiod %}, ${first_open_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter first_open_date_dm.available_timeperiod %}  ) ;;
#     type: inner
#     relationship: many_to_one
#   }
#   join: first_click_date_dm{
#     from: date_dm
#     view_label: " First Clicked Date"
#     sql_on: ${first_click_date_dm.date_sid} = ${inntopia_campaign_property_f.FIRSTCLICKEDDATE_SID} ;;
#     sql_where: {% parameter first_click_date_dm.available_timeperiod %} = ''
#     or utl..udf_period_trunc_dt( {% parameter first_click_date_dm.available_timeperiod %}, ${first_click_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter first_click_date_dm.available_timeperiod %}  ) ;;
#     type: inner
#     relationship: many_to_one
#   }
#   join: last_event_date_dm{
#     from: date_dm
#     view_label: " Last Event Date"
#     sql_on: ${last_event_date_dm.date_sid} = ${inntopia_campaign_property_f.LASTEVENTDATE_SID} ;;
#     sql_where: {% parameter last_event_date_dm.available_timeperiod %} = ''
#     or utl..udf_period_trunc_dt( {% parameter last_event_date_dm.available_timeperiod %}, ${last_event_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter last_event_date_dm.available_timeperiod %}  ) ;;
#     type: inner
#     relationship: many_to_one
#   }
#   join: mailing_sent_date_dm{
#     from: date_dm
#     view_label: " Mailing Sent Date"
#     sql_on: ${mailing_sent_date_dm.date_sid} = ${inntopia_campaign_property_f.MAILINGSENTDATE_SID} ;;
#     sql_where: {% parameter mailing_sent_date_dm.available_timeperiod %} = ''
#     or utl..udf_period_trunc_dt( {% parameter mailing_sent_date_dm.available_timeperiod %}, ${mailing_sent_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter mailing_sent_date_dm.available_timeperiod %}  ) ;;
#     type: inner
#     relationship: many_to_one
#   }
#   join: property_dm {
#     from: property_dm
#     view_label: " Property"
#     sql_on: ${property_dm.property_key} = ${inntopia_campaign_property_f.property_key} ;;
#     type: inner
#     relationship: many_to_one
#   }
# }
