connection: "mc_panoply"

include: "*.view.lkml"
include: "/AdWords/*.view"
include: "/Google_Analytics/**/*.view"
include: "/Facebook/**/*.view"
include: "/DCM/**/*.view"
include: "/TrueView/**/*.view"
include: "/Pinterest/**/*.view"

datagroup: mam_winter_seasonal_datagroup {
  sql_trigger: SELECT current_date;;
  max_cache_age: "24 hours"
}

explore: ndt_winter_seasonal_campaign {
 label: "FY20 Winter Seasonal"
  view_label: "Winter Seasonal"
  hidden: no
  group_label: "Mammoth Lakes Tourism"}
