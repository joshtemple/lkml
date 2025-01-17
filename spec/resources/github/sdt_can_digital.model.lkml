connection: "mc_panoply"

include: "*.view.lkml"
include: "/Facebook/*.view"
include: "/TrueView/*.view"
include: "/AdWords/*.view"
include: "/DCM/*.view"
include: "/Publisher_Passback/*/*.view"
include: "/Google_Analytics/*.view"

datagroup: sdt_can_digital_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: ndt_can_digital_campaign {
  #persist_with: vca_dream365_datagroup
  label: "Canada Digital"
  view_label: "Canada Digital"
  group_label: "San Diego Tourism"
  hidden: yes
}
