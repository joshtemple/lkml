connection: "mc_panoply"

include: "/Derived_Tables/Fall_Drive_Market/*.view.lkml"
include: "/Google_Analytics/*.view"
include: "/AdWords/*.view"
include: "/DCM/*.view"
include: "/Facebook/*.view"
include: "/Pinterest/*.view"

datagroup: sdt_falldrivemarket_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: pdt_fy21_drivemarket_campaign {
  label: "FY21 Fall Drive Market"
  view_label: "FY21 Fall Drive Market"
  group_label: "San Diego Tourism"
  hidden: no
}
