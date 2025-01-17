connection: "nd_snowflake_analytics"
#connection: "next_prd_redshift"

persist_for: "12 hours"

# include all views in this project
include: "t*.view"
#include: "nxtu_age_gender.view"
include: "sql_users_both_age_gender.view"
include: "pdt_user_active_days.view"
include: "pdt_user_product_active_days.view"

# include all dashboards in this project
include: "*.dashboard"

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# - explore: order_items
#   joins:
#     - join: orders
#       sql_on: ${orders.id} = ${order_items.order_id}
#     - join: users
#       sql_on: ${users.id} = ${orders.user_id}

explore: t8000_content {}

explore: t8001_user_crossref {
  view_label: "User Cross-reference"
  join: t8003_user_product {
    view_label: "User Product"
    sql_on: ${t8001_user_crossref.c8001_nxtu_or_did} = ${t8003_user_product.c8003_nxtuid}  ;;
    relationship: one_to_many
    type: left_outer
  }
  join: t8014_user_campaign {
    view_label: "Campaign Gender and Age Data"
    sql_on: ${t8001_user_crossref.c8001_nxtu_or_did} = ${t8014_user_campaign.c8014_nxtu_or_did} ;;
    relationship: one_to_many
    type: left_outer
  }
}

explore: t8003_user_product {
  join: t8001_user_crossref {
    view_label: "User Cross Reference"
    sql_on: ${t8003_user_product.c8003_nxtuid} = ${t8001_user_crossref.c8001_nxtu_or_did} ;;
    relationship: many_to_one
    type: left_outer
  }
 }

explore: t8014_user_campaign {}

#explore: t8002_contentview {}

explore: t8002_contentview_curr_day {
  view_label: "Curr Day Content Views"
}

explore: t1016_cid_title {}

explore: t4003_animated_cid {
  sql_always_where: ${c4003_imp_type} = 'V' ;;

  join: t8000_content {
    view_label: "Content Object Meta Data"
    sql_on: ${t4003_animated_cid.c4003_cid} = ${t8000_content.c8000_cid} ;;
    relationship: one_to_one
    type: left_outer
  }
}

#explore: t8050_user_content_by_day {
#  sql_always_where:{% condition t8050_user_content_by_day.filter_view_date %} ${t8050_user_content_by_day.view_date} {% endcondition %}  ;;
#}

explore: t1021_cid_title_day {}

explore: t8015_contentview_agg {}

explore: t1023_animated_video {}

explore:  t1025_reg_prod_cid_title {}

#  joins:
#  - join: t3016_seg_agg_cid_day
#    view_label: Platform
#    sql_on: ${t1023_animated_video.c1023_cid} = ${t3016_seg_agg_cid_day.c3016_cid} and ${t3016_seg_agg_cid_day.c3016_imp_type} = 'V' and ${t3016_seg_agg_cid_day.c3016_product} = ${t1023_animated_video.c1023_product} and ${t3016_seg_agg_cid_day.c3016_region} = ${t1023_animated_video.c1023_region} and ${t3016_seg_agg_cid_day.c3016_date_id_date} = ${t1023_animated_video.c1023_date_id_date}
#    relationship: many_to_one
#    type: left_outer
#  - join: t1021_cid_title_day
#    view_label: Title
#    sql_on: ${t1023_animated_video.c1023_cid} = ${t1021_cid_title_day.c1021_cid} and ${t1021_cid_title_day.c1021_imp_type} = 'V' # and ${t1021_cid_title_day.c1021_product} = ${t1023_animated_video.c1023_product} and ${t1021_cid_title_day.c1021_region} = ${t1023_animated_video.c1023_region} and ${t1021_cid_title_day.c1021_update_date} = ${t1023_animated_video.c1023_date_id_date}
#    relationship: many_to_one
#    type: left_outer

explore: t3016_seg_agg_cid_day {
  join: t1023_animated_video {
    view_label: "Animated Videos"
    sql_on: ${t3016_seg_agg_cid_day.c3016_cid} = ${t1023_animated_video.c1023_cid} and ${t3016_seg_agg_cid_day.c3016_imp_type} = 'V' and ${t3016_seg_agg_cid_day.c3016_product} = ${t1023_animated_video.c1023_product} and ${t3016_seg_agg_cid_day.c3016_region} = ${t1023_animated_video.c1023_region} and ${t3016_seg_agg_cid_day.c3016_date_id_date} = ${t1023_animated_video.c1023_date_id_date} ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: sql_users_both_age_gender {}

#explore: t5000_ua_connect_open {}

#explore: t5001_ua_connect_first_open {}

#explore: t5002_ua_connect_push_body {}

#explore: t5003_ua_connect_send {}

#explore: t5004_ua_connect_uninstall {}

#explore: t5005_ua_connect_tag_change {}

#explore: t5009_ua_device_crossref {}

#explore: t5010_ua_connect_event {}

explore: t8021_user_churning_prediction {
  join: t8001_user_crossref {
    view_label: "User Cross Reference"
    sql_on: ${t8021_user_churning_prediction.c8021_adid} = ${t8001_user_crossref.c8001_adid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: t8023_user_segments {
    view_label: "User Segments"
    sql_on: ${t8021_user_churning_prediction.c8021_adid} = ${t8023_user_segments.c8023_nxtuid} ;;
    relationship: one_to_one
    type: left_outer
  }
}

explore: t8025_user_gender_prediction {
  join: t8057_userprofile_age_gender {
    view_label: "UserProfile Age & Gender"
    sql_on: ${t8025_user_gender_prediction.c8025_nxtuid} = ${t8057_userprofile_age_gender.c8057_nxtuid} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: t8001_user_crossref {
    view_label: "User Cross Reference"
    sql_on: ${t8025_user_gender_prediction.c8025_nxtuid} = ${t8001_user_crossref.c8001_nxtu_or_did} ;;
      relationship: one_to_one
    type: left_outer
  }
  join: t8023_user_segments {
    view_label: "User Segments"
    sql_on: ${t8025_user_gender_prediction.c8025_nxtuid} = ${t8023_user_segments.c8023_nxtuid} ;;
    relationship: one_to_many
    type: left_outer
  }
}

explore: t8026_user_age_prediction {
  join: t8057_userprofile_age_gender {
    view_label: "UserProfile Age & Gender"
    sql_on: ${t8026_user_age_prediction.c8026_nxtuid} = ${t8057_userprofile_age_gender.c8057_nxtuid} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: t8001_user_crossref {
    view_label: "User Cross Reference"
    sql_on: ${t8026_user_age_prediction.c8026_nxtuid} = ${t8001_user_crossref.c8001_nxtu_or_did} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: t8023_user_segments {
    view_label: "User Segments"
    sql_on: ${t8026_user_age_prediction.c8026_nxtuid} = ${t8023_user_segments.c8023_nxtuid} ;;
    relationship: one_to_many
    type: left_outer
  }
}

#explore: content_preference_total_views {}

#explore: content_preference_unique_users {}

explore: t8020_user_content_preference {
  join: t8002_contentview {
    view_label: "Content View"
    sql_on: ${t8020_user_content_preference.c8020_nxtuid} = ${t8002_contentview.c8002_nxtu_or_did} ;;
    relationship: many_to_many
    type: inner
  }
  join: t8023_user_segments {
    view_label: "User Segments"
    sql_on: ${t8020_user_content_preference.c8020_nxtuid} = ${t8023_user_segments.c8023_nxtuid} ;;
    relationship: many_to_many
    type: inner
  }
}

#explore: t8020_user_content_preference_old {}

explore: t8002_contentview {}

explore: t8050_user_content_by_day {
#  join: t8023_user_segments {
#    view_label: "User Segments"
#    sql_on: ${t8023_user_segments.c8023_nxtuid} = &${t8050_user_content_by_day.nxtuid} ;;
#    relationship: many_to_many
#    type: inner
# }
}

explore: t8056_user_activity_by_day {
  view_label: "1. User Activity"
  join: t8022_user_segment_list {
    view_label: "2. Segment List"
    sql_on: ${t8022_user_segment_list.c8022_nxtuid} = ${t8056_user_activity_by_day.c8056_nxtuid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: t8057_userprofile_age_gender {
    view_label: "3. Age & Gender"
    sql_on: ${t8056_user_activity_by_day.c8056_nxtuid} = ${t8057_userprofile_age_gender.c8057_nxtuid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: pdt_user_active_days {
    view_label: "4. Active Days"
    sql_on: ${t8056_user_activity_by_day.c8056_nxtuid} = ${pdt_user_active_days.nxtuid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: pdt_user_product_active_days {
    view_label: "5. Product Active Days"
    sql_on: ${t8056_user_activity_by_day.c8056_region} = ${pdt_user_product_active_days.region}
        and ${t8056_user_activity_by_day.c8056_product} = ${pdt_user_product_active_days.product}
        and ${t8056_user_activity_by_day.c8056_platform} = ${pdt_user_product_active_days.platform}
        and ${t8056_user_activity_by_day.c8056_nxtuid} = ${pdt_user_product_active_days.nxtuid};;
    relationship: many_to_one
    type: left_outer
  }
}



#  join: t8024_content_preference_control {
#    view_label: "Segment Name"
#    sql_on: ${t8024_content_preference_control.c8024_id} = ${t8023_user_segments.c8023_segment ;;
#    relationship: many_to_one
#    type: inner
#  }


explore: pdt_user_active_days {
  view_label: "1. Active Days"
  join: t8022_user_segment_list {
    view_label: "2. Segment List"
    foreign_key: pdt_user_active_days.nxtuid
#    sql_on: ${t8022_user_segment_list.c8022_nxtuid} = ${pdt_user_active_days.nxtuid} ;;
#    relationship: one_to_one
#    type: left_outer
  }
  join: t8057_userprofile_age_gender {
    view_label: "3. Age & Gender"
    foreign_key: pdt_user_active_days.nxtuid
#    sql_on: ${pdt_user_active_days.nxtuid} = ${t8057_userprofile_age_gender.c8057_nxtuid} ;;
#    relationship: one_to_one
#    type: left_outer
  }
  join: t8056_user_activity_by_day {
    view_label: "4. User Activity by Day"
    sql_on:  ${t8056_user_activity_by_day.c8056_nxtuid} = ${pdt_user_active_days.nxtuid} ;;
    relationship: one_to_many
    type:  inner
  }
}

explore: pdt_user_product_active_days {
  view_label: "1. Product Active Days"
  join: t8022_user_segment_list {
    view_label: "2. Segment List"
    sql_on: ${t8022_user_segment_list.c8022_nxtuid} = ${pdt_user_product_active_days.nxtuid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: t8057_userprofile_age_gender {
    view_label: "3. Age & Gender"
    sql_on: ${pdt_user_product_active_days.nxtuid} = ${t8057_userprofile_age_gender.c8057_nxtuid} ;;
    relationship: many_to_one
    type: left_outer
  }
#  join: t8056_user_activty_by_day {
#    view_label: "4. User Activity by Day"
#    sql_on:   ${t8056_user_activty_by_day.c8056_region} = ${pdt_user_product_active_days.region}
#          and ${t8056_user_activty_by_day.c8056_product} = ${pdt_user_product_active_days.product}
#          and ${t8056_user_activty_by_day.c8056_platform} = ${pdt_user_product_active_days.platform}
#          and ${t8056_user_activty_by_day.c8056_nxtuid} = ${pdt_user_product_active_days.nxtuid} ;;
#    relationship: one_to_many
#    type: inner
#  }
}

explore: t8022_user_segment_list {
  view_label: "Segment List"
  join: t8056_user_activity_by_day {
    view_label: "User Activity"
    sql_on: ${t8022_user_segment_list.c8022_nxtuid} = ${t8056_user_activity_by_day.c8056_nxtuid} ;;
    relationship: one_to_many
    type: inner
  }
  join: t8057_userprofile_age_gender {
    view_label: "Age & Gender"
    sql_on: ${t8022_user_segment_list.c8022_nxtuid} =${t8057_userprofile_age_gender.c8057_nxtuid} ;;
    relationship: one_to_one
    type: inner
  }
}

explore: t8023_user_segments {
#  join: t8002_contentview {
#    view_label: "Content View"
#    sql_on: ${t8023_user_segments.c8023_nxtuid} = ${t8002_contentview.c8002_nxtu_or_did} ;;
#    relationship: many_to_many
#    type: inner
#  }
  join: t8057_userprofile_age_gender {
    view_label: "Age & Gender"
    sql_on: ${t8023_user_segments.c8023_nxtuid} = ${t8057_userprofile_age_gender.c8057_nxtuid} ;;
    relationship: many_to_one
    type: left_outer
  }
  join: t8024_content_preference_control {
    view_label: "UCP Name"
    sql_on: ${t8023_user_segments.c8023_segment} = ${t8024_content_preference_control.c8024_id} ;;
    relationship: many_to_one
    type: left_outer
  }
}

explore: t4006_dashboard_rt_hour {}

explore: t4007_dashboard_yesterday {}

explore: t8024_content_preference_control {}

explore: t8057_userprofile_age_gender {}

#explore: nxtu_age_gender  {}

explore: tb_superloyal {}

# explore: t4005_etw_event {}

#- explore: sql_runner_query_adid_analysis

#- explore: t8003_geo_location

#- explore: t8004_regestered_user

#- explore: t8005_content_consumption

#- explore: t8006_region_product

#- explore: t8007_site

#- explore: t8008_channel

#- explore: t8009_section

#- explore: t8010_subsection

#- explore: t8011_subsubsection

#- explore: t8012_app
