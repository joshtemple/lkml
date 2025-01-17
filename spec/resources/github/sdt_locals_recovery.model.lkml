connection: "mc_panoply"

include: "*.view.lkml"
include: "/AdWords/*.view"
include: "/Google_Analytics/*.view"
include: "/Publisher_Passback/*/*.view"
include: "/DCM/*.view"

datagroup: sdt_locals_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: pdt_locals_campaign {
  label: "FY21 Locals Recovery"
  view_label: "FY21 Locals Recovery"
  group_label: "San Diego Tourism"
  hidden: no
}
