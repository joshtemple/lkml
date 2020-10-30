connection: "mc_panoply"

include: "/Adwords/**/*.view.lkml"
include: "/DCM/**/*.view.lkml"
include: "/Facebook/**/*.view.lkml"
include: "/Google_Analytics/**/*.view.lkml"
include: "/TrueView/**/*.view.lkml"

label: "Workspace"                     #label in drop down

######## Adwords Search ########
explore: mam_sem{                      #name of explore
  view_name: mam_sem_gdn               #view data is attached too
  always_filter: {                     #specifies a filter that is required
    filters: {
      field: advertising_channel       #declares the field to be filtered (make a dimenison in view)
      value: "Search"
    }
  }
  label: "Adwords Search (Test)"              ## name in dropdown for explore menu
  view_label: "Adowrds Search (Test)"         ## name in field picker
  group_label: "Workspace"             ## title for group in drop down

  join: mam_ga_onsite {
      view_label: "Google Analytics"
    type: left_outer
    sql_on: ${mam_sem_gdn.join_id} = ${mam_ga_onsite.join_id} ;;
    relationship: many_to_one
  }
}
######## Adwords Display ########
explore: mam_gdn {
  view_name: mam_sem_gdn
  always_filter: {
    filters: {
      field: advertising_channel
      value: "Display"
    }
  }

  label: "Adwords Display (Test)"
  view_label: "Adwords Display (Test)"
  group_label: "Workspace"

  join: mam_ga_onsite {
    view_label: "Google Analytics"
    type: left_outer
    sql_on: ${mam_sem_gdn.join_id} = ${mam_ga_onsite.join_id} ;;
    relationship: many_to_one
  }
}

######## Facebook ########

explore: mam_fb_view {
  label: "Facebook (Test)"
  view_label: "Facebook (Test)"
  group_label: "Workspace"        ## title for group in drop down

  join: facebookads__visit_mammoth_actions {
    view_label: "Facebook Actions"
    type: left_outer
    fields: []
    sql: ${mam_fb_view.id} = ${facebookads__visit_mammoth_actions.facebookads__visit_mammoth_id};;
    relationship: many_to_one
  }

  join: facebookads__visit_mammoth_video_p100_watched_actions {
    view_label: "Vid Completes"
    type: left_outer
    fields: []
    sql:${mam_fb_view.id} = ${facebookads__visit_mammoth_video_p100_watched_actions.facebookads__visit_mammoth_id}   ;;
    relationship: many_to_one
  }
  join: facebookads__visit_mammoth_video_p95_watched_actions {
    view_label: "Vid Completes"
    type: left_outer
    fields: []
    sql: ${mam_fb_view.id} = ${facebookads__visit_mammoth_video_p95_watched_actions.facebookads__visit_mammoth_id}  ;;
    relationship: many_to_one
  }
  join: facebookads__visit_mammoth_video_p75_watched_actions {
    view_label: "Vid Completes"
    type: left_outer
    fields: []
    sql:${mam_fb_view.id} = ${facebookads__visit_mammoth_video_p75_watched_actions.facebookads__visit_mammoth_id} ;;
    relationship: many_to_one
  }
  join: facebookads__visit_mammoth_video_p50_watched_actions {
    view_label: "Vid Completes"
    type: left_outer
    fields: []
    sql:${mam_fb_view.id} = ${facebookads__visit_mammoth_video_p50_watched_actions.facebookads__visit_mammoth_id} ;;
    relationship: many_to_one
  }
  join: facebookads__visit_mammoth_video_p25_watched_actions{
    view_label: "Vid Completes"
    type: left_outer
    fields: []
    sql:${mam_fb_view.id} = ${facebookads__visit_mammoth_video_p25_watched_actions.facebookads__visit_mammoth_id};;
    relationship: many_to_one
  }

  join: mam_ga_onsite {
    view_label: "Google Analytics- Onsite"
    type: left_outer
    fields: []
    sql: ${mam_fb_view.comp_key} = ${mam_ga_onsite.join_id} ;;
    relationship: one_to_many
  }
  join: mam_ga_events {
    view_label: "Google Analytics- Events"
    type: left_outer
    sql: ${mam_fb_view.comp_key} = ${mam_ga_events.join_id} ;;
    relationship: one_to_many
  }
  join: mam_ga_pageinfo {
    view_label: "Google Analytics- Page Info"
    type: left_outer
    sql: ${mam_fb_view.comp_key} = ${mam_ga_pageinfo.join_id} ;;
    relationship: one_to_many
  }
  join: mam_ga_userinfo {
    view_label: "Google Analytics- User Info"
    type: left_outer
    sql: ${mam_fb_view.comp_key} = ${mam_ga_userinfo.join_id} ;;
    relationship: one_to_many
  }
  join: mam_ga_goals {
    view_label: "Google Analytics- Goals"
    type: left_outer
    sql: ${mam_fb_view.comp_key} = ${mam_ga_goals.join_id} ;;
    relationship: one_to_many
  }
}

######## Exploring YouTube Data #########

explore: mam_trueview {
  label: "YouTube (Test)"
  view_label: "YouTube"
  group_label: "Workspace"          ## title for group in drop down
}


explore: mam_dcm_view {
  label: "DoubleClick (Test)"
  view_label:"DoubleClick (Test)"
  group_label: "Workspace"
}
