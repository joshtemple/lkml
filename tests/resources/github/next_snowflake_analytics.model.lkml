connection: "nd_snowflake_analytics"

include: "t*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "view_agg_with_article.view"

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: t3016_seg_agg_cid_day {
  label: "1) Content Imp Summary (historical by day) - Snowflake"
  view_label: "CID Views"
}

explore: view_agg_with_article {
  label: "2) Content Summary by CID (2 mths by day) - Snowflake"
  view_label: "Article & Video Views - Summary "
  join: t1025_reg_prod_cid_title_join {
    view_label: "Content Title"
    sql_on: c8002_cid  = ${t1025_reg_prod_cid_title_join.c1025_cid} and c8002_product = ${t1025_reg_prod_cid_title_join.c1025_product} and c8002_region = ${t1025_reg_prod_cid_title_join.c1025_region} and ${view_agg_with_article.view_type} = ${t1025_reg_prod_cid_title_join.imp_type}  ;;
    relationship: many_to_one
    type: left_outer
  }
  #      - join: t1021_cid_title_day
  #        view_label: Animated Title
  #        sql_on: c8002_cid = ${t1021_cid_title_day.c1021_cid} and ${t1021_cid_title_day.c1021_imp_type} = 'V' and c8002_region = ${t1021_cid_title_day.c1021_region} and c8002_product = ${t1021_cid_title_day.c1021_product}
  #        relationship: many_to_one
  #        type: left_outer
  #      - join: t4003_animated_cid
  #        view_label: Animated Indicator (preaug16)
  #        sql_on: c8002_cid = ${t4003_animated_cid.c4003_cid} and ${t4003_animated_cid.c4003_imp_type} = 'V'
  #        relationship: many_to_one
  #        type: left_outer
  #      - join: t1016_cid_title
  #        view_label: Most Used Title
  #        sql_on: c8002_cid = ${t1016_cid_title.c1016_cid} and ${t1016_cid_title.c1016_imp_type} = 'V'
  #        relationship: many_to_one
  #        type: left_outer
  join: content {
    view_label: "Content Object Meta Data"
    sql_on: c8002_cid = ${content.cid} and c8002_region = ${content.region} and c8002_product = ${content.product} and ${content.video_length} > 0 ;;
    relationship: many_to_one
    type: left_outer
  }
}


explore: contentview {
  label: "3) Content Views Detail (2 mths by time) - Snowflake"
  view_label: "All Content Views"

  join: content {
    view_label: "Content Object Meta Data"
    sql_on: ${contentview.cid} = ${content.cid} and ${contentview.region} = ${content.region} and ${contentview.product} = ${content.product} and ${content.video_length} > 0 ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: t8050_user_content_by_day {
  label: "4) Content Summary by Users (2 mths by day)."
  view_label: "Content & Users"
  join: t1025_reg_prod_cid_title_join {
    view_label: "Content Title"
#    sql_on: ${t8050_user_content_by_day.content_id} = ${t1025_reg_prod_cid_title.c1025_cid} and ${t8050_user_content_by_day.product} = ${t1025_reg_prod_cid_title.c1025_product} and ${t8050_user_content_by_day.region} = ${t1025_reg_prod_cid_title.c1025_region} and ${t8050_user_content_by_day.view_type} = ${t1025_reg_prod_cid_title.imp_type}  ;;
    sql_on: ${t8050_user_content_by_day.content_id} = ${t1025_reg_prod_cid_title_join.c1025_cid} and ${t8050_user_content_by_day.product} = ${t1025_reg_prod_cid_title_join.c1025_product} and ${t8050_user_content_by_day.region} = ${t1025_reg_prod_cid_title_join.c1025_region} and ${t8050_user_content_by_day.view_type} =  decode(t1025_reg_prod_cid_title_join.c1025_imp_type,'I','PAGEVIEW','V','VIDEOVIEW','unknown') ;;
    relationship: many_to_one
    type: left_outer
  }
  #      - join: t1021_cid_title_day
  #        view_label: Animated Title
  #        sql_on: c8002_cid = ${t1021_cid_title_day.c1021_cid} and ${t1021_cid_title_day.c1021_imp_type} = 'V' and c8002_region = ${t1021_cid_title_day.c1021_region} and c8002_product = ${t1021_cid_title_day.c1021_product}
  #        relationship: many_to_one
  #        type: left_outer
  #      - join: t4003_animated_cid
  #        view_label: Animated Indicator (preaug16)
  #        sql_on: c8002_cid = ${t4003_animated_cid.c4003_cid} and ${t4003_animated_cid.c4003_imp_type} = 'V'
  #        relationship: many_to_one
  #        type: left_outer
  #      - join: t1016_cid_title
  #        view_label: Most Used Title
  #        sql_on: c8002_cid = ${t1016_cid_title.c1016_cid} and ${t1016_cid_title.c1016_imp_type} = 'V'
  #        relationship: many_to_one
  #        type: left_outer
  join: content {
    view_label: "Content Object Meta Data"
    sql_on: c8050_cid = ${content.cid} and c8050_product = ${content.product} and c8050_region = ${content.region} and ${content.video_length} > 0 ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: t8002_contentview {}

explore: t8001_user_crossref {}

explore: t8000_content {}

#explore: t3016_seg_agg_cid_day {}

explore: t1025_reg_prod_cid_title {}

explore: t4006_dashboard_rt_hour {}

explore: t4007_dashboard_yesterday {}

explore: contentview_us_can {}

explore: t8014_user_campaign {}

explore: t8020_user_content_preference {}

explore: t8021_user_churning_prediction {}

explore: t8023_user_segments {}

explore: t8024_content_preference_control {}

explore: t8025_user_gender_prediction {}

explore: t8026_user_age_prediction {}

explore: t4005_etw_event {}

explore: t8050_user_content_by_day_gen {}

#explore: t8050_user_content_by_day {}

#explore: view_agg_with_article {}
