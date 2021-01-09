connection: "mc_panoply"

include: "/Derived_Tables/US_Pull-Through/FY_20_21/*.view.lkml"
include: "/Derived_Tables/US_Pull-Through/FY_19_20/*.view.lkml"
include: "/Google_Analytics/*.view"
include: "/AdWords/*.view"
include: "/DCM/*.view"
include: "/Facebook/*.view"
include: "/Pinterest/*.view"

datagroup: sdt_us_pullthrough_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: ndt_us_pullthrough_campaign {
  label: "FY20 US Pull-Through"
  view_label: "FY20 US Pull-Through"
  group_label: "San Diego Tourism"
  hidden: yes
}

explore: pdt_fy21_pullthrough_campaign {
  label: "FY21 US Pull-Through"
  view_label: "FY21 US Pull-Through"
  group_label: "San Diego Tourism"
  hidden: no
}
