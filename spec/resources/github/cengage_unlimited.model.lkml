include: "//core/common.lkml"
include: "//cube/ga_mobiledata.view"
include: "//core/access_grants_file.view"

include: "/views/cu_user_analysis/*.view.lkml"
include: "/views/cu_user_analysis/cohorts/*.view.lkml"
include: "/views/strategy/*.view.lkml"
include: "/views/uploads/*.view.lkml"
include: "/views/cu_ebook/*.view.lkml"
include: "/views/customer_support/*.view.lkml"
include: "/views/fair_use/*.view.lkml"
include: "/views/discounts/*.view.lkml"
include: "/views/spring_review/*.view.lkml"
include: "/views/sales_order_forecasting/*.view.lkml"
include: "/views/kpi_dashboards/*.view.lkml"
include: "/views/uploads/covid19_trial_shutoff_schedule.view"

include: "/models/shared_explores.lkml"

connection: "snowflake_prod"

case_sensitive: no

######################### Start of PROD Explores #########################################################################

view: current_date {

  view_label: "** Date Filters **"
  derived_table: {
    sql: select date_part(week, current_date()) as current_week_of_year;;
  }

  dimension: current_week_of_year {type: number hidden:yes}
}

explore: course_sections {
  extends: [dim_course, learner_profile_cohorts]
  from: dim_course
  view_name: dim_course

  label: "Course Sections"

  join: user_courses {
    view_label: "Course / Section Students"
    sql_on: ${dim_course.olr_course_key} = ${user_courses.olr_course_key} ;;
    relationship: one_to_many
  }

  join: merged_cu_user_info {
    view_label: "Course / Section Students"
    sql_on:  ${user_courses.user_sso_guid} = ${merged_cu_user_info.user_sso_guid}  ;;
    relationship: one_to_one
  }

  join: learner_profile {
    sql_on: ${user_courses.user_sso_guid} = ${learner_profile.user_sso_guid} ;;
    relationship: many_to_one
  }

  join: live_subscription_status {
    sql_on: ${user_courses.user_sso_guid} = ${live_subscription_status.user_sso_guid} ;;
    relationship: many_to_one
  }

  join: raw_olr_provisioned_product {
    fields: []
    view_label: "Provisioned Products"
    sql_on: ${raw_olr_provisioned_product.user_sso_guid} = ${live_subscription_status.user_sso_guid};;
    relationship: many_to_one
  }

  join: gateway_institution {
    view_label: "Institution"
    sql_on: ${dim_institution.entity_no}::string = ${gateway_institution.entity_no};;
    relationship: many_to_one
  }

  join: current_date {
    sql_on:  1=1 ;;
    relationship: one_to_one
  }

  join: covid19_trial_shutoff_schedule {
    sql_on: ${user_courses.entity_id} = ${covid19_trial_shutoff_schedule.entity_no} ;;
    relationship: many_to_one
  }

  join: gateway_lms_course_sections {
    sql_on: ${dim_course.context_id} = ${gateway_lms_course_sections.olr_context_id};;
    relationship: one_to_one
    view_label: "Course / Section Details"
  }


}


explore: active_users {
  hidden: yes
  from: guid_platform_date_active
}

explore: strategy_ecom_sales_orders {
  label: "Revenue"
  view_label: "Revenue"
  join: dim_date {
    sql_on: ${strategy_ecom_sales_orders.invoice_dt_raw} = ${dim_date.datevalue} ;;
    relationship: many_to_one
  }
  join: dim_product {
    sql_on: ${strategy_ecom_sales_orders.isbn_13} = ${dim_product.isbn13} ;;
    relationship: many_to_one
  }
}



explore: cu_ebook_usage {}




################################################# End of PROD Explores ###########################################


explore: courseware_usage_tiers_csms {}




explore: products_v {}



######## User Experience Journey End PROD ###################



explore: customer_support_cases {
  label: "CU User Analysis Customer Support Cases"
  description: "One time upload of customer support cases joined with CU user analysis to analyze support cases in the context of CU"
  extends: [session_analysis]

  join: customer_support_all {
    view_label: "Customer Support Cases"
    sql_on: ${learner_profile.user_sso_guid} = ${customer_support_all.sso_guid}::STRING ;;
    relationship: one_to_many
  }
  fields: [
    learner_profile.marketing_fields*
    ,all_events.marketing_fields*
    ,live_subscription_status.marketing_fields*
    ,merged_cu_user_info.marketing_fields*
    ,dim_institution.marketing_fields*
    ,dim_product.marketing_fields*
    ,dim_productplatform.productplatform
    ,dim_course.marketing_fields*
#     ,instiution_star_rating.marketing_fields*
    ,course_section_facts.total_noofactivations
    ,courseinstructor.marketing_fields*
    ,dim_start_date.marketing_fields*
    ,olr_courses.instructor_name
#     ,subscription_term_products_value.marketing_fields*
#     ,subscription_term_cost.marketing_fields*
    ,user_courses.marketing_fields*
    ,customer_support_all.detail*]
}





##### Raw Snowflake Tables #####
explore: provisioned_product {
  label: "VitalSource events"
  from: raw_olr_provisioned_product
  join: raw_subscription_event {
    sql_on: ${provisioned_product.user_sso_guid} = ${raw_subscription_event.user_sso_guid} ;;
    relationship: many_to_one
  }

  join:  raw_vitalsource_event {
    sql_on: ${provisioned_product.user_sso_guid} = ${raw_vitalsource_event.user_sso_guid} ;;
    relationship: many_to_many
  }
}

explore: raw_subscription_event {
  label: "Raw Subscription Events"
  view_name: raw_subscription_event
  view_label: "Subscription Status"
  join: raw_olr_provisioned_product {
    sql_on: ${raw_olr_provisioned_product.merged_guid} = ${raw_subscription_event.merged_guid};;
    relationship: many_to_one
  }
  join: products_v {
    sql_on: ${raw_olr_provisioned_product.iac_isbn} = ${products_v.isbn13};;
    relationship: many_to_one
  }
  join: dim_date {
    sql_on: ${raw_subscription_event.subscription_start_date}::date = ${dim_date.datevalue} ;;
    relationship: many_to_one
  }
#   join: sub_actv {
#     sql_on: ${raw_subscription_event.user_sso_guid} = ${sub_actv.user_sso_guid} ;;
#     relationship: many_to_one
#   }
}


##### END  Raw Snowflake Tables #####



##### Dashboard #####
explore: ga_dashboarddata {
  label: "CU Dashboard"
  join: raw_subscription_event {
    sql_on: ${ga_dashboarddata.userssoguid} = ${raw_subscription_event.user_sso_guid} ;;
    type: full_outer
    relationship: many_to_one
  }
  join: raw_olr_provisioned_product {
    sql_on: ${raw_olr_provisioned_product.user_sso_guid} = ${raw_subscription_event.user_sso_guid};;
    relationship: many_to_one
  }

  join: cu_product_category {
    view_label: "Product Category (PRoc)"
    sql_on: ${cu_product_category.isbn_13} = ${raw_olr_provisioned_product.iac_isbn} ;;
    relationship: many_to_one
  }

  join: cu_user_info {
    sql_on:  ${ga_dashboarddata.userssoguid} = ${cu_user_info.merged_guid}  ;;
    relationship: many_to_one
  }

  join: instiution_star_rating {
    sql_on: ${cu_user_info.entity_id} = ${instiution_star_rating.entity_} ;;
    relationship: many_to_one
  }
  join: dashboard_use_over_time {
    sql_on: ${ga_dashboarddata.userssoguid} = ${dashboard_use_over_time.user_sso_guid} ;;
    relationship: many_to_one
  }
  join: dashboard_use_over_time_bucketed {
    sql_on: ${ga_dashboarddata.userssoguid} = ${dashboard_use_over_time_bucketed.user_sso_guid} ;;
    relationship: many_to_one
  }

  join: products_v {
    sql_on: ${raw_olr_provisioned_product.iac_isbn} = ${products_v.isbn13};;
    relationship: many_to_one
  }
}

explore: ga_dashboarddata_merged_2 {
  label: "CU Dashboard mapped"
  join: raw_subscription_event_merged_2 {
    sql_on: ${ga_dashboarddata_merged_2.mapped_guid} = ${raw_subscription_event_merged_2.mapped_guid} ;;
    type: full_outer
    relationship: many_to_one
  }
  }

explore: dashboard_use_over_time_bucketed {
  label: "Dashboard Use Over Time Binned"
  join: raw_subscription_event {
    sql_on: ${raw_subscription_event.user_sso_guid} = ${dashboard_use_over_time_bucketed.user_sso_guid} ;;
    relationship: one_to_many
    type: left_outer
  }
  join: cu_user_info {
    sql_on:  ${dashboard_use_over_time_bucketed.user_sso_guid} = ${cu_user_info.merged_guid}  ;;
    relationship: many_to_one
  }
}

explore: dashboardbuckets {
  label: "CU Dashboard Actions Bucketed"
  join: ga_dashboarddata {
    sql_on: ${ga_dashboarddata.userssoguid}=${dashboardbuckets.userssoguid} ;;
    relationship: many_to_many
    type: left_outer
  }
}

explore: CU_Sandbox {
  label: "CU Sandbox"
  extends: [ebook_usage]
  join: ga_dashboarddata {
    sql_on: ${raw_subscription_event.user_sso_guid} = ${ga_dashboarddata.userssoguid} ;;
    relationship: one_to_many
 }
}

##### End Dashboard #####




##### Ebook Usage #####
  explore: ebook_usage {
    label: "Ebook Usage"
    extends: [raw_subscription_event]
    join: ebook_usage_actions {
      sql_on:  ${raw_subscription_event.user_sso_guid} = ${ebook_usage_actions.user_sso_guid} ;;
      type: left_outer
      relationship: one_to_many
    }

     join: ebook_mapping {
       type: left_outer
       sql_on: ${ebook_usage_actions.event_action} = ${ebook_mapping.action}  AND ${ebook_usage_actions.source} = ${ebook_mapping.source} AND ${ebook_usage_actions.event_category} = ${ebook_mapping.event_category};;
       relationship: many_to_one
     }
  }

explore: ebook_usage_aggregated {}
##### End Ebook Usage #####


#### Raw enrollment for Prod research #####
explore: raw_olr_enrollment {
  label: "Raw Enrollments"
#   join: raw_olr_provisioned_product {
#     type: left_outer
#     relationship: many_to_many
#     sql_on: ${raw_olr_enrollment.user_sso_guid} = ${raw_olr_provisioned_product.user_sso_guid} AND ${raw_olr_enrollment.course_key} = ${raw_olr_provisioned_product.context_id} ;;
#   }
}

# MT Mobile Data

explore: mobiledata {
  from: dim_course
  view_name: dim_course
  label: "MT Mobile GA Data"
  extends: [dim_course]

  join: ga_mobiledata {
    sql_on: ${dim_course.coursekey} = ${ga_mobiledata.coursekey};;
    relationship: many_to_one
  }

  join: learner_profile {
    sql_on: ${ga_mobiledata.userssoguid}= ${learner_profile.user_sso_guid} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: user_courses {
    sql_on: ${dim_course.olr_course_key} = ${user_courses.olr_course_key}
          and ${learner_profile.user_sso_guid} = ${user_courses.user_sso_guid};;
    relationship: one_to_one
  }

  join: live_subscription_status {
    view_label: "Learner Profile"
    sql_on: ${ga_mobiledata.userssoguid}= ${live_subscription_status.user_sso_guid} ;;
    type: left_outer
    relationship: many_to_one
  }


  join: raw_olr_provisioned_product {
    sql_on: ${ga_mobiledata.userssoguid}= ${raw_olr_provisioned_product.user_sso_guid} ;;
    type: left_outer
    relationship: many_to_one
  }

# join: cu_user_info {
#   sql_on: ${ga_mobiledata.userssoguid} = ${cu_user_info.guid} ;;
#   relationship: many_to_one
# }

}

################ MApped guids ###########################

# explore: vw_subscription_event_mapped_guids {}
explore: active_users_sam {
  join: raw_subscription_event {
    type: inner
    relationship: one_to_one
    sql_on: ${active_users_sam.user_guid}=${raw_subscription_event.user_sso_guid} ;;
  }
}



############################ Discount email campaign ##################################

# explore: looker_output_test_1000_20190214_final {}
# explore: email_discount_campaign {
#   label: "Email Discount Campaign"
#   view_label: "Live subscription status"
#   from: live_subscription_status
#
#   join: students_email_campaign_criteria {
#     relationship: one_to_one
#     sql_on: ${email_discount_campaign.user_sso_guid} = ${students_email_campaign_criteria.user_guid} ;;
#   }
#   join: discount_info {
#     relationship: one_to_one
#     sql_on: ${email_discount_campaign.user_sso_guid} = ${discount_info.user_sso_guid} ;;
#   }
#   join: merged_cu_user_info {
#     relationship: one_to_one
#     sql_on: ${email_discount_campaign.user_sso_guid} = ${merged_cu_user_info.user_sso_guid} ;;
#   }
#   # join: upgrade_campaign_user_info_latest_20192021 {
#   #   relationship: one_to_one
#   #   sql_on: ${email_discount_campaign.user_sso_guid} = ${upgrade_campaign_user_info_latest_20192021.guid} ;;
#   # }
#    join: discount_email_control_groups {
#     relationship:  one_to_one
#     sql_on: ${email_discount_campaign.user_sso_guid} =  ${discount_email_control_groups.students_email_campaign_criteria_user_guid};;
#   }
# }
# explore: discount_info {}
# #explore: discount_email_campaign_control_groups {}
#
# explore: students_email_campaign_criteria {
#   join: discount_info {
#     sql_on: ${students_email_campaign_criteria.user_guid} = ${discount_info.user_sso_guid}  ;;
#     relationship: one_to_one
#   }
# }



# --------------------------- Spring Review ----------------------------------

explore: renewed_vs_not_renewed_cu_user_usage_fall_2019 {
}



# ------ Sales order explore -------------------------------------


explore: sales_orders_forecasting {
  label: "Sales Order Forecasting"

join: activations_sales_order_forecasting {
  sql_on: ${sales_orders_forecasting.adoption_key} = ${activations_sales_order_forecasting.adoption_key}
          AND ${sales_orders_forecasting.fiscalyearvalue} = ${activations_sales_order_forecasting.fiscalyear};;
  relationship: many_to_many
}

join: ebook_consumed_salesorder_forecasting {
  sql_on: ${sales_orders_forecasting.adoption_key} = ${ebook_consumed_salesorder_forecasting.adoption_key}
          AND ${sales_orders_forecasting.fiscalyearvalue} = ${ebook_consumed_salesorder_forecasting.fiscalyear};;
  relationship: many_to_many
}

join: ia_adoptions_salesorder_forecasting {
  sql_on:  ${sales_orders_forecasting.adoption_key} = ${ia_adoptions_salesorder_forecasting.adoption_key}
            AND ${sales_orders_forecasting.fiscalyearvalue} = ${ia_adoptions_salesorder_forecasting.fiscalyear};;
  relationship: many_to_one
}

join: cui_adoptions_salesorders {
  sql_on: ${sales_orders_forecasting.institution_nm} = ${cui_adoptions_salesorders.institution_name}
          AND ${sales_orders_forecasting.fiscalyearvalue} = ${cui_adoptions_salesorders.fiscalyear};;
  relationship: many_to_many
}

}

explore: sales_order_adoption_base {}



# **************************************** KPI Dashboard *************************************

explore: z_kpi_sf_activations {
  join: dim_date {
    sql_on: ${z_kpi_sf_activations.actv_dt} = ${dim_date.datevalue} ;;
    relationship: many_to_one
  }
}

explore: dm_activations {
  join: dim_date {
    sql_on: ${dm_activations.actv_dt} = ${dim_date.datevalue} ;;
    relationship: one_to_one

  }
}




#account_creation

#account_creation

explore: account_creation {
  label: "Account creation"
  extends: [session_analysis]
  join: jia_account_creation {
    view_label: "account creation F19"
    sql_on: ${jia_account_creation.user_sso_guid} = ${live_subscription_status.user_sso_guid};;
    relationship: one_to_one
  }
  join: account_link_creation_cohort {
    view_label: "account link creation cohort"
    sql_on: ${account_link_creation_cohort.user_sso_guid} = ${live_subscription_status.user_sso_guid};;
    relationship: one_to_one
  }
}


explore: adoption_usage_analysis {
  label: "Adoption Usage Analysis"
  extends: [session_analysis]
  join: adoption_platform_pivot {
    view_label: "Adoption Platform Pivot"
    sql_on:  ${products.prod_family_cd} = ${adoption_platform_pivot.product_family_code} ;;
    relationship: one_to_one
  }

  join: entity_names {
    view_label: "Entity Names"
    sql_on: ${dim_institution.entity_no}::string =  ${entity_names.entity_no}::string;;
    relationship: one_to_one
  }

  join: cw_adoption_driver_20191217 {
    view_label: "Courseware Adoption Driver"
    sql_on: ${cw_adoption_driver_20191217.adoption_key} = ${entity_names.institution_nm} || '|' ||  ${entity_names.state_cd} || '|' || ${adoption_platform_pivot.course_code_description} ||  '|' ||  ${dim_product.publicationseries}
    ;;
    relationship: one_to_many
  }
}

view: date_ty_ly {

  parameter: offset {
    view_label: "Filters"
    description: "Offset (days/weeks/months depending on metric) to use when comparing vs prior year, can be positive to move prior year values forwards or negative to shift prior year backwards"
    type: number
    default_value: "0"
  }

  derived_table: {
    sql:
    select datevalue, datevalue as date, date as ty_date, null as ly_date from prod.dm_common.dim_date_legacy_cube
    union all
    select datevalue, DATEADD(day, {% parameter offset %},dateadd(year, -1, datevalue)) as date, null, date from prod.dm_common.dim_date_legacy_cube ;;
  }

  dimension: datevalue {type: date_raw hidden:yes}
  dimension: date {type: date_raw hidden:yes primary_key:yes}
  dimension: ty_date {type:date_raw hidden:yes}
  dimension: ly_date {type:date_raw hidden:yes}

}

explore: kpi_user_stats {
  persist_with: daily_refresh
  from: dim_date

  view_label: "Date"
  fields: [ALL_FIELDS*
    ,-kpi_user_counts.user_sso_guid, -kpi_user_counts.organization, -kpi_user_counts.region, -kpi_user_counts.platform, -kpi_user_counts.user_type
    ,-kpi_user_counts_ly.user_sso_guid, -kpi_user_counts_ly.organization, -kpi_user_counts_ly.region, -kpi_user_counts_ly.platform, -kpi_user_counts_ly.user_type]

  join: date_ty_ly {
    sql_on: ${kpi_user_stats.datevalue_raw} = ${date_ty_ly.datevalue} ;;
    relationship: one_to_many
  }
  join: combinations {
    view_label: "Filters"
    from: kpi_user_counts_filter_combinations_agg
    # sql_on: ${kpi_user_stats.datevalue_raw} = ${combinations.date}
    #     OR DATEADD(year, -1, ${kpi_user_stats.datevalue_raw}) = ${combinations.date}
    #    ;;
    sql_on: ${date_ty_ly.date} = ${combinations.date} ;;
    type: inner
    relationship: one_to_many
  }

   join: kpi_user_counts {
    from: kpi_user_counts_agg
    view_label: "User Counts"
    sql_on: ${date_ty_ly.ty_date} = ${kpi_user_counts.date_raw}
        AND ${combinations.date} = ${kpi_user_counts.date_raw}
        AND ${combinations.user_sso_guid} = ${kpi_user_counts.user_sso_guid}
        AND ${combinations.platform} = ${kpi_user_counts.platform}
        AND ${combinations.organization} = ${kpi_user_counts.organization}
        AND ${combinations.region} = ${kpi_user_counts.region}
        AND ${combinations.user_type} = ${kpi_user_counts.user_type}
    ;;
    relationship: one_to_many
   }

  join: kpi_user_counts_ly {
    from: kpi_user_counts_agg
    view_label: "User Counts - Prior Year"
    sql_on:${date_ty_ly.ly_date} = ${kpi_user_counts_ly.date_raw}
        AND ${combinations.date} = ${kpi_user_counts_ly.date_raw}
        AND ${combinations.user_sso_guid} = ${kpi_user_counts_ly.user_sso_guid}
        AND ${combinations.platform} = ${kpi_user_counts_ly.platform}
        AND ${combinations.organization} = ${kpi_user_counts_ly.organization}
        AND ${combinations.region} = ${kpi_user_counts_ly.region}
        AND ${combinations.user_type} = ${kpi_user_counts_ly.user_type}
    ;;
    relationship: one_to_many

  }

  join: yru {
    view_label: "User Counts"
    sql_on: ${date_ty_ly.ty_date} = ${yru.date_raw};;
    relationship: many_to_one
    type: left_outer
  }

  join: yru_ly {
    from: yru
    view_label: "User Counts - Prior Year"
    sql_on: ${date_ty_ly.ly_date} =  ${yru_ly.date_raw}
    ;;
    relationship: many_to_one
    type: left_outer
  }

}

# access_grant: access_grant_test {
#   user_attribute: test_attribute
#   allowed_values: [ "yes" ]
# }
