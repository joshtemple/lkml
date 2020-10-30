connection: "mc_panoply"

include: "/Derived_Tables/Always_On_Content/FY_20_21/*.view.lkml"
include: "/Derived_Tables/Always_On_Content/FY_19_20/*.view.lkml"
include: "/Facebook/*.view"
include: "/TrueView/*.view"
include: "/AdWords/*.view"
include: "/Google_Analytics/*.view"
include: "/Pinterest/*.view"
include: "/Publisher_Passback/*/*.view"
include: "/DCM/*.view"

datagroup: sdt_content_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: pdt_content_campaign {
  label: "FY20 Always On Content"
  view_label: "FY20 Always On Content"
  group_label: "San Diego Tourism"
  hidden: yes
}

explore: pdt_fy21_content_campaign {
  label: "FY21 Always On Content"
  view_label: "FY21 Always On Content"
  group_label: "San Diego Tourism"
  hidden: no
}
