connection: "nd_snowflake_analytics"
#connection: "next_prd_redshift"

persist_for: "12 hours"

# include all views in this project
include: "t*.view"
include: "dashboard_headers.view"
include: "view_agg_with_article.view"

# include all dashboards in this project
include: "*.dashboard"


explore: t3016_seg_agg_cid_day {
  label: "1) Content Imp Summary (historical by day)"
  view_label: "1. CID Views"
  join: t1025_reg_prod_cid_title_join {
    view_label: "2. Current Title & Author"
    sql_on: c3016_cid  = ${t1025_reg_prod_cid_title_join.c1025_cid} and c3016_product = ${t1025_reg_prod_cid_title_join.c1025_product} and c3016_region = ${t1025_reg_prod_cid_title_join.c1025_region} and c3016_imp_type = t1025_reg_prod_cid_title_join.c1025_imp_type  ;;
    relationship: many_to_one
    type: inner
  }
}
#  joins:
#      - join: t1021_cid_title_day
#        view_label: Animated Title
#        sql_on: ${t3016_seg_agg_cid_day.c3016_cid} = ${t1021_cid_title_day.c1021_cid} and ${t1021_cid_title_day.c1021_imp_type} = 'V' and ${t3016_seg_agg_cid_day.c3016_region} = ${t1021_cid_title_day.c1021_region} and ${t3016_seg_agg_cid_day.c3016_product} = ${t1021_cid_title_day.c1021_product}
#        relationship: many_to_one
#        type: left_outer
#      - join: t4003_animated_cid
#        view_label: Animated Indicator (preaug16)
#        sql_on: ${t3016_seg_agg_cid_day.c3016_cid} = ${t4003_animated_cid.c4003_cid} and ${t4003_animated_cid.c4003_imp_type} = 'V'
#        relationship: many_to_one
#        type: left_outer
#      - join: t1016_cid_title
#        view_label: Most Used Title
#        sql_on: ${t3016_seg_agg_cid_day.c3016_cid} = ${t1016_cid_title.c1016_cid} and ${t3016_seg_agg_cid_day.c3016_imp_type} = ${t1016_cid_title.c1016_imp_type}
#        relationship: many_to_one
#        type: left_outer

#- explore: view_agg_with_article_video
#  label: 7) Animated Video Views - Summary
#  view_label: Animated Video Views - Summary
#  sql_always_where:  ${c8002_action} = 'VIDEOVIEW'
#  joins:
#      - join: t4003_animated_cid
#        view_label: Animated Video
#        sql_on: ${view_agg_with_article_video.c8002_cid} = ${t4003_animated_cid.c4003_cid}
#        relationship: many_to_one
#        type: left_outer
#      - join: t1016_cid_title
#        view_label: Most Used Title
#        sql_on: ${view_agg_with_article_video.c8002_cid} = ${t1016_cid_title.c1016_cid}
#        relationship: many_to_one
#        type: left_outer

# - explore: content
#   view_label: Content

explore: view_agg_with_article {
  label: "2) Content Summary by CID (2 mths by day)"
  view_label: "1. Article & Video Views - Summary"
  join: t1025_reg_prod_cid_title_join {
    view_label: "3. Current Title & Author"
    sql_on: c8002_cid  = ${t1025_reg_prod_cid_title_join.c1025_cid} and c8002_product = ${t1025_reg_prod_cid_title_join.c1025_product} and c8002_region = ${t1025_reg_prod_cid_title_join.c1025_region} and ${view_agg_with_article.view_type} = ${t1025_reg_prod_cid_title_join.imp_type}  ;;
    relationship: many_to_one
    type: inner
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
    view_label: "2. Content Object Meta Data"
    sql_on: c8002_cid = ${content.cid} and c8002_region = ${content.region} and c8002_product = ${content.product} and ${content.video_length} > 0 ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: contentview {
  label: "3) Content Views Detail (2 mths by time)"
  view_label: "1. All Content Views"
  join: content {
    view_label: "4. Content Object Meta Data"
    sql_on: ${contentview.cid} = ${content.cid} and ${contentview.region} = ${content.region} and ${contentview.product} = ${content.product} and ${content.video_length} > 0 ;;
    relationship: many_to_one
    type: left_outer
  }
  join: t1025_reg_prod_cid_title_join {
    view_label: "5. Current Title & Author"
    sql_on: c8002_cid  = ${t1025_reg_prod_cid_title_join.c1025_cid} and c8002_product = ${t1025_reg_prod_cid_title_join.c1025_product} and c8002_region = ${t1025_reg_prod_cid_title_join.c1025_region} and ${contentview.view_type} = ${t1025_reg_prod_cid_title_join.imp_type}  ;;
    relationship: many_to_one
    type: inner
  }
  join: t8021_user_churning_prediction {
    view_label: "6. Churning Prediction"
    sql_on: ${contentview.adid} = ${t8021_user_churning_prediction.c8021_adid}
    and TO_DATE(${contentview.view_date}) = TO_DATE( ${t8021_user_churning_prediction.c8021_predicted_date})
    and ${contentview.region} = 'HK'
    and ${contentview.product} = 'Apple Daily'
    and (${contentview.platform} = 'iPhone' or ${contentview.platform} = 'Android') ;;
    relationship: many_to_one
    type: inner
  }
}

explore: contentview_page {
  label: "4) Page Views Detail (2 mths by time)"
  view_label: "1. Page Views"
  sql_always_where: ${view_type} = 'PAGEVIEW' ;;
}

explore: contentview_video {
  label: "5) Video Views Detail (2 mths by time)"
  view_label: "1. Video Views"
  sql_always_where: ${view_type} = 'VIDEOVIEW' ;;
}

#  sql_always_where: ${lat} != 0 and ${lon} != 0 and ${view_type} = 'VIDEOVIEW'

#- explore: view_ahttps://nextdigitaljp.looker.com/projects/next_digital/files/t8050_user_content_by_day.view.lkmlggregate_tmp
explore: t8050_user_content_by_day {
  label: "6) Content Summary by Users (2 mths by day)."
  view_label: "1. Content & Users"
  join: t1025_reg_prod_cid_title_join {
    view_label: "3. Current Title & Author"
#    sql_on: ${t8050_user_content_by_day.content_id} = ${t1025_reg_prod_cid_title.c1025_cid} and ${t8050_user_content_by_day.product} = ${t1025_reg_prod_cid_title.c1025_product} and ${t8050_user_content_by_day.region} = ${t1025_reg_prod_cid_title.c1025_region} and ${t8050_user_content_by_day.view_type} = ${t1025_reg_prod_cid_title.imp_type}  ;;
    sql_on: ${t8050_user_content_by_day.content_id} = ${t1025_reg_prod_cid_title_join.c1025_cid} and ${t8050_user_content_by_day.product} = ${t1025_reg_prod_cid_title_join.c1025_product} and ${t8050_user_content_by_day.region} = ${t1025_reg_prod_cid_title_join.c1025_region} and ${t8050_user_content_by_day.view_type} =  decode(t1025_reg_prod_cid_title_join.c1025_imp_type,'I','PAGEVIEW','V','VIDEOVIEW','unknown') ;;
    relationship: many_to_one
    type: inner
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
    view_label: "2. Content Object Meta Data"
    sql_on: c8050_cid = ${content.cid} and c8050_product = ${content.product} and c8050_region = ${content.region} and ${content.video_length} > 0 ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: t8002_contentview_curr_day {
  label: "7) Current Day Content Views Detail "
  view_label: "1. Curr Day Content Views"
  join: content {
    view_label: "4. Content Object Meta Data"
    sql_on: ${t8002_contentview_curr_day.cid} = ${content.cid} and ${t8002_contentview_curr_day.region} = ${content.region} and ${t8002_contentview_curr_day.product} = ${content.product} and ${content.video_length} > 0 ;;
    relationship: many_to_one
    type: left_outer
  }
  join: t1025_reg_prod_cid_title_join {
    view_label: "5. Current Title & Author"
    sql_on: c8002_cid  = ${t1025_reg_prod_cid_title_join.c1025_cid} and c8002_product = ${t1025_reg_prod_cid_title_join.c1025_product} and c8002_region = ${t1025_reg_prod_cid_title_join.c1025_region} and ${t8002_contentview_curr_day.view_type} = ${t1025_reg_prod_cid_title_join.imp_type}  ;;
    relationship: many_to_one
    type: inner
  }
}



explore: dashboard_headers {
  label: "9) Dashboard Headers"
  hidden: yes
}

explore: contentview_us_can {
  label: "8) Content Views Detail for US & Canada"
  view_label: "1. All Content Views"
}

# - explore: user_crossref
