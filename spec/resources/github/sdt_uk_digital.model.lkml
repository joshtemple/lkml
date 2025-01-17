connection: "mc_panoply"

include: "*.view.lkml"
include: "/Facebook/*.view"
include: "/TrueView/*.view"
include: "/AdWords/*.view"
include: "/Google_Analytics/*.view"
include: "/Publisher_Passback/*/*.view"
include: "/DCM/*.view"

datagroup: sdt_uk_digital_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: ndt_uk_digital_campaign {
  label: "UK Digital"
  view_label: "UK Digital"
  group_label: "San Diego Tourism"
  hidden: yes
}

explore: ndt_uk_digital_lastminute {
  label: "Last minute"
  view_label: "UK Digital"
  group_label: "San Diego Tourism"
  hidden: yes
}
