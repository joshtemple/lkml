connection: "mc_panoply"

include: "*.view.lkml"
include: "/Facebook/*.view"
include: "/TrueView/*.view"
include: "/DCM/*.view"
include: "/Publisher_Passback/*/*.view"

datagroup: sdt_brand_digital_video_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: pdt_brand_digital_video_campaign {
  #persist_with: vca_dream365_datagroup
  label: "Digtal Video"
  view_label: "Digital Video"
  group_label: "San Diego Tourism"
  hidden: yes
}

explore: pdt_brand_digital_video_cbs {
  label: "CBS"
  view_label: "CBS Digital Video"
  group_label: "San Diego Tourism"
  hidden: yes
}
