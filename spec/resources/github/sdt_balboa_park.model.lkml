connection: "mc_panoply"

include: "*.view.lkml"
include: "/Google_Analytics/*.view"
include: "/DCM/*.view"
include: "/AdWords/*.view"
include: "/Publisher_Passback/**/*.view"

datagroup: sdt_bp_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: ndt_bp_campaign {
  #persist_with: vca_dream365_datagroup
  label: "Balboa Park Digital"
  view_label: "Balboa Park Digital"
  group_label: "San Diego Tourism"
  hidden: yes
}
