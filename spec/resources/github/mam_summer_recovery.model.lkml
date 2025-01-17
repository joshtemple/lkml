connection: "mc_panoply"

include: "*.view.lkml"
include: "/AdWords/*.view"
include: "/Google_Analytics/**/*.view"
include: "/Facebook/**/*.view"
include: "/DCM/**/*.view"
include: "/TrueView/**/*.view"

datagroup: mam_summer_recovery_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: pdt_summer_recovery_campaign {
  label: "FY21 Recovery"
  view_label: "FY21 Recovery"
  hidden: no
  group_label: "Mammoth Lakes Tourism"
}
