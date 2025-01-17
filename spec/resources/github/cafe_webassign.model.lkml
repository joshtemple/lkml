connection: "snowflake_prod"
# # include: "*.view.lkml"         # include all views in this project
# include: "//core/common.lkml"
# include: "//core/access_grants_file.view"                      # include all views in this project
# # include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
# include: "cafe_webassign.view.lkml"
# include: "/views/cu_user_analysis/merged_cu_user_info.view.lkml"
# include: "/views/cu_user_analysis/cu_user_info.view.lkml"
# include: "//core/access_grants_file.view"
# include: "/views/cu_user_analysis/live_subscription_status.view.lkml"
# include: "/views/cu_user_analysis/raw_subscription_event_sap.view.lkml"
#
# explore: cafe_webassign {
#
#   required_access_grants: [can_view_CU_dev_data]
#
#   join: live_subscription_status {
#     relationship: one_to_one
#     sql_on: ${cafe_webassign.merged_guid} = ${live_subscription_status.user_sso_guid} ;;
#   }
#
#   join: merged_cu_user_info {
#     relationship: one_to_one
#     sql_on: ${cafe_webassign.merged_guid} = ${merged_cu_user_info.user_sso_guid} ;;
#   }
# }
