connection: "mc_panoply"

# include all the views
# include: "/AdWords/*.view"
# include: "/DCM/**/*.view"
# include: "/Facebook/**/*.view"
# include: "/Google_Analytics/**/*.view"
# include: "/TrueView/**/*.view"
# include: "/Derived_Tables/**/*.view"
# # include: "publisher_ndt.view"
#
#
# datagroup: mam_default_datagroup {
#   sql_trigger: SELECT current_date;;
#   max_cache_age: "24 hours"
# }
#
# label: "Mammoth Lakes Tourism"
#
# persist_with: mam_default_datagroup

#### Exploring AdWords Search Data #####

# explore: mam_sem {
#   view_name: mam_sem_gdn
#   always_filter: {
#     filters: {
#       field: advertising_channel
#       value: "Search"
#     }
#   }
#   label: "AdWords Search"
#   view_label: "AdWords Search"
#   group_label: "Mammoth Lakes Tourism"
#
#   join: mam_ga_onsite {
#     view_label: "Google Analytics"
#     type: left_outer
#     fields: []
#     sql_on: ${mam_sem_gdn.join_id} = ${mam_ga_onsite.adwords_join_id} ;;
#     relationship: many_to_one
#   }
# }


#### Exploring AdWords Display Data #####

# explore: mam_gdn {
#   view_name: mam_sem_gdn
#   always_filter: {
#     filters: {
#       field: advertising_channel
#       value: "Display"
#     }
#   }
#   label: "AdWords Display"
#   view_label: "AdWords Display"
#   group_label: "Mammoth Lakes Tourism"
#
#   join: mam_ga_onsite {
#     view_label: "Google Analytics"
#     type: left_outer
#     fields: []
#     sql_on: ${mam_sem_gdn.join_id} = ${mam_ga_onsite.adwords_join_id} ;;
#     relationship: many_to_one
#   }
# }

#### Exploring Facebook Data #####

# explore: mam_fb_view {
#   label: "Facebook"
#   view_label: "Facebook"
#   group_label: "Mammoth Lakes Tourism"
#
#   join: facebookads__visit_mammoth_actions {
#     view_label: "Facebook Actions"
#     type: left_outer
#     fields: []
#     sql_on: ${facebookads__visit_mammoth_actions.facebookads__visit_mammoth_id} = ${mam_fb_view.id} ;;
#     relationship: many_to_one
#   }
#
#   join: facebookads__visit_mammoth_video_p100_watched_actions {
#     view_label: "Vid Completes"
#     type: left_outer
#     fields: []
#     sql_on: ${facebookads__visit_mammoth_video_p100_watched_actions.facebookads__visit_mammoth_id} = ${mam_fb_view.id} ;;
#     relationship: many_to_one
#   }
#
#   join: facebookads__visit_mammoth_video_p75_watched_actions {
#     view_label: "Vid Completes"
#     type: left_outer
#     fields: []
#     sql_on: ${facebookads__visit_mammoth_video_p75_watched_actions.facebookads__visit_mammoth_id} = ${mam_fb_view.id} ;;
#     relationship: many_to_one
#   }
#
#   join: facebookads__visit_mammoth_video_p50_watched_actions {
#     view_label: "Vid Completes"
#     type: left_outer
#     fields: []
#     sql_on: ${facebookads__visit_mammoth_video_p50_watched_actions.facebookads__visit_mammoth_id} = ${mam_fb_view.id} ;;
#     relationship: many_to_one
#   }
#
#   join: facebookads__visit_mammoth_video_p25_watched_actions {
#     view_label: "Vid Completes"
#     type: left_outer
#     fields: []
#     sql_on: ${facebookads__visit_mammoth_video_p25_watched_actions.facebookads__visit_mammoth_id} = ${mam_fb_view.id} ;;
#     relationship: many_to_one
#   }
#
#   join: mam_ga_onsite {
#     view_label: "Google Analytics"
#     type: left_outer
#     fields: []
#     sql_on: ${mam_fb_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_userinfo {
#     view_label: "Google Analytics - User Info"
#     type: left_outer
#     sql_on: ${mam_fb_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_pageinfo {
#     view_label: "Google Analytics - Page Info"
#     type: left_outer
#     sql_on: ${mam_fb_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_events {
#     view_label: "Google Analytics - Events"
#     type: left_outer
#     sql_on: ${mam_fb_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_goals {
#     view_label: "Google Analytics - Goals"
#     type: left_outer
#     sql_on: ${mam_fb_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
# }

######## Exploring DCM Data #########

# explore: mam_dcm_view {
#   label: "DoubleClick"
#   view_label: "DoubleClick"
#   group_label: "Mammoth Lakes Tourism"
#
#   join: mam_ga_onsite {
#     view_label: "Google Analytics"
#     type: left_outer
#     fields: []
#     sql_on: ${mam_dcm_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_userinfo {
#     view_label: "Google Analytics - User Info"
#     type: left_outer
#     sql_on: ${mam_dcm_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_pageinfo {
#     view_label: "Google Analytics - Page Info"
#     type: left_outer
#     sql_on: ${mam_dcm_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_events {
#     view_label: "Google Analytics - Events"
#     type: left_outer
#     sql_on: ${mam_dcm_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
#
#   join: mam_ga_goals {
#     view_label: "Google Analytics - Goals"
#     type: left_outer
#     sql_on: ${mam_dcm_view.comp_key} = ${mam_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
# }

######## Exploring YouTube Data #########

# explore: mam_trueview {
#   label: "YouTube"
#   view_label: "YouTube"
#   group_label: "Mammoth Lakes Tourism"
# }

#### Exploring Air Service ####

# explore: mam_winter_air_service_campaign {
#   #persist_with: vca_dream365_datagroup
#   label: "Winter Air Service"
#   view_label: "Winter Air Service"
#   group_label: "Mammoth Lakes Tourism"
#   hidden: yes
# }


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
