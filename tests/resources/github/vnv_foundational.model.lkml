connection: "mc_panoply"

include: "*.view.lkml"
include: "/AdWords/*.view"
include: "/TrueView/*.view"
include: "/Pinterest/*.view"
include: "/Facebook/**/*.view"
include: "/Google_Analytics/*.view"

datagroup: vnv_foundational_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: pdt_foundational_campaign {
  #persist_with: vca_dream365_datagroup
  label: "FY20 Foundational"
  view_label: "Foundational"
  group_label: "Visit Napa Valley"
  hidden: no
}
