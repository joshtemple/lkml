include: "/Facebook/**/*.view"
include: "/Google_Analytics/**/*.view"

  explore: vnv_fb {
    view_name: vnv_fb_ga_view
    hidden: yes
    label: "Facebook"
    view_label: "Facebook"
    group_label: "Visit Napa Valley"

#     join: facebookads__visit_napa_valley_actions {
#       type: left_outer
#       fields: []
#       sql_on: ${facebookads__visit_napa_valley_actions.facebookads__visit_napa_valley_id} = ${vnv_fb_view.id} ;;
#       relationship: many_to_one
#     }
#
#     join: facebookads__visit_napa_valley_video_p100_watched_actions {
#       type: left_outer
#       fields: []
#       sql_on: ${facebookads__visit_napa_valley_video_p100_watched_actions.facebookads__visit_napa_valley_id} = ${vnv_fb_view.id} ;;
#       relationship: many_to_one
#     }
#
#     join: facebookads__visit_napa_valley_video_p75_watched_actions {
#       type: left_outer
#       fields: []
#       sql_on: ${facebookads__visit_napa_valley_video_p75_watched_actions.facebookads__visit_napa_valley_id} = ${vnv_fb_view.id} ;;
#       relationship: many_to_one
#     }
#
#     join: facebookads__visit_napa_valley_video_p50_watched_actions {
#       type: left_outer
#       fields: []
#       sql_on: ${facebookads__visit_napa_valley_video_p50_watched_actions.facebookads__visit_napa_valley_id} = ${vnv_fb_view.id} ;;
#       relationship: many_to_one
#     }
#
#     join: facebookads__visit_napa_valley_video_p25_watched_actions {
#       type: left_outer
#       fields: []
#       sql_on: ${facebookads__visit_napa_valley_video_p25_watched_actions.facebookads__visit_napa_valley_id} = ${vnv_fb_view.id} ;;
#       relationship: many_to_one
#     }
#
#     join: vnv_fb_thruplays {
#       type: left_outer
#       fields: []
#       sql_on: ${vnv_fb_view.thruplay_join_id} = ${vnv_fb_thruplays.thruplay_join} ;;
#       relationship: one_to_many
#     }
#
#   join: vnv_ga_onsite {
#     view_label: "Google Analytics"
#     type: left_outer
#     fields: []
#     sql_on: ${vnv_fb_view.comp_key} = ${vnv_ga_onsite.join_id} ;;
#     relationship: one_to_many
#   }
  }
