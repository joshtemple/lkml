#################### THIS VIEW IS NEEDED TO LIMIT THE SCHOOLS AVAILABLE IN ALL LEVELS TO ONLY THOSE THAT MEET THE CORE GATEWAY COMBINED ANNUAL REGISTRATION THRESHOLD #######################

include: "__zcm_coregateway_view.view.lkml"
#include: "/webassign/*.model.lkml"
include: "fact_registration_zcm.view.lkml"
include: "//webassign/dim_discipline.view.lkml"
#include: "/zcm_webassign/redesign_test.explore.lkml"
include: "_redesign_multiview_fields.view.lkml"
include: "_zcm_instructor_filter.view.lkml"

view: _zcm_school_filter {
  derived_table: {
    sql:
        SELECT
                  DISTINCT dim_school_id
        FROM ${__zcm_coregateway_view.SQL_TABLE_NAME}
          WHERE zeroifnull(annual_cg_reg) >= {% parameter __zcm_coregateway_view.accgr_threshold %}
          AND ay_value >= -{% parameter _zcm_school_filter.core_gateway_threshold_range %}
              ;;
}

dimension: dim_school_id {
  hidden: yes
  primary_key: yes
}

parameter: core_gateway_threshold_range {
  type: number
  label: "AYs Included for ACCGR Threshold"
  description: "Select the number of Academic Years back (not including the current in-progress year) to be included in assessing if a school meets the
                Core Gateway Combined Annual Enrollments Threshold. Schools that do not meet this threshold will be excluded completely from any analysis."
  view_label: "           Parameters & Filters"
  default_value: "1"
}
}


#     explore_source: __zcm_coregateway_view {
#       filters: {
#         field: __zcm_coregateway_view.meets_accgr_threshold
#         value: "Yes"
#       }
#       filters: {
#         field: __zcm_coregateway_view.ay_value
#         value: "> -{% parameter _zcm_school_filter.core_gateway_threshold_range %}"
#       }
#       column: dim_school_id {
#        field: __zcm_coregateway_view.dim_school_id
#    }

#  }