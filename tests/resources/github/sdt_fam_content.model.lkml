connection: "mc_panoply"

include: "/Publisher_Passback/*/*.view"
include: "*.view.lkml"
include: "/Facebook/*.view"
include: "/TrueView/*.view"
include: "/AdWords/*.view"
include: "/Google_Analytics/*.view"
include: "/DCM/*.view"

datagroup: sdt_fam_content_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: pdt_fam_content_campaign {
  label: "Family Content"
  view_label: "Family Content"
  group_label: "San Diego Tourism"
  hidden: yes
}
