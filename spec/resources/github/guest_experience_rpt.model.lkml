connection: "edw"
include: "*.view"         # include all views in this project

label: "Guest Experience"

datagroup: model_caching_dg {
  sql_trigger: select max( dw_update_dt ) from pedw.fact.guest_experience_f ;;
  max_cache_age: "8 hours"
}

explore: guest_experience_rpt {
  group_label: "Property"
  label: "Revinate Detail"
  persist_with: model_caching_dg
  view_label: "    Measures"
  case_sensitive: no

  access_filter: {
    field: user_property_fdm.user_id
    user_attribute: looker_ldap_user_id
  }

  join: user_property_fdm {
    from:  user_property_fdm
    sql_on: ${user_property_fdm.property_key} = ${guest_experience_rpt.property_key} ;;
    type: inner
    relationship: many_to_one
  }

  join: response_date_dm {
    from: date_dm
    view_label: "  Date Response"
    sql_on: ${response_date_dm.date_sid} = ${guest_experience_rpt.response_date_sid};;
    sql_where: {% parameter response_date_dm.available_timeperiod %} = ''
      or utl..udf_period_trunc_dt( {% parameter response_date_dm.available_timeperiod %}, ${response_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter response_date_dm.available_timeperiod %}  ) ;;
    type: inner
    relationship: many_to_one
  }
#
#   join: response_date_dm {
#     from: date_dm
#     view_label: "  Date Response"
#     sql_on: ${response_date_dm.date_sid} = ${guest_experience_rpt.response_date_sid};;
#     type: inner
#     relationship: many_to_one
#   }

  join: checkin_date_dm {
    from: date_dm
    view_label: "  Date Checkin"
    sql_on: ${checkin_date_dm.date_sid} = ${guest_experience_rpt.checkin_date_sid};;
    sql_where: {% parameter checkin_date_dm.available_timeperiod %} = ''
      or utl..udf_period_trunc_dt( {% parameter checkin_date_dm.available_timeperiod %}, ${checkin_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter checkin_date_dm.available_timeperiod %}  ) ;;
    type: inner
    relationship: many_to_one
  }
#
#   join: checkin_date_dm {
#     from: date_dm
#     view_label: "  Date Checkin"
#     sql_on: ${checkin_date_dm.date_sid} = ${guest_experience_rpt.checkin_date_sid};;
#     type: inner
#     relationship: many_to_one
#   }

  join: checkout_date_dm {
    from: date_dm
    view_label: "  Date Checkout"
    sql_on: ${checkout_date_dm.date_sid} = ${guest_experience_rpt.checkout_date_sid};;
    sql_where: {% parameter checkout_date_dm.available_timeperiod %} = ''
      or utl..udf_period_trunc_dt( {% parameter checkout_date_dm.available_timeperiod %}, ${checkout_date_dm.cal_dt} ) = utl..udf_period_dt( {% parameter checkout_date_dm.available_timeperiod %}  ) ;;
    type: inner
    relationship: many_to_one
  }
#
#   join: checkout_date_dm {
#     from: date_dm
#     view_label: "  Date Checkout"
#     sql_on: ${checkout_date_dm.date_sid} = ${guest_experience_rpt.checkout_date_sid};;
#     type: inner
#     relationship: many_to_one
#   }

  join: property_dm {
    from: property_dm
    view_label: " Property"
    sql_on: ${property_dm.property_key} = ${guest_experience_rpt.property_key} ;;
    type: inner
    relationship: many_to_one
  }

  join: dt_revinate_review_word_cnt {
    from: dt_revinate_review_word_cnt
    view_label: " Derived"
    sql_on: ${dt_revinate_review_word_cnt.property_key} = ${guest_experience_rpt.property_key}
          and ${dt_revinate_review_word_cnt.review_id} = ${guest_experience_rpt.review_id}
          ;;
    type: left_outer
    relationship: many_to_one
  }
}
