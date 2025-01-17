connection: "kerv_rs"

# include all the views
include: "/views/**/*.view"

explore: dwh_ds_summary {
  label: "Daily Stats"
  join: dwh_advertisers {
    view_label: "Advertisers"
    type: left_outer
    sql_on: ${dwh_advertisers.id} = ${dwh_ds_summary.advertiserid} ;;
    relationship: many_to_one
  }
  join: dwh_campaigns {
    view_label: "Campaigns"
    type: left_outer
    sql_on: ${dwh_campaigns.id} = ${dwh_ds_summary.campaignid} ;;
    relationship: many_to_one
  }

  join: dwh_creatives {
    view_label: "Creatives"
    type: left_outer
    sql_on: ${dwh_creatives.id} = ${dwh_ds_summary.creativeid} ;;
    relationship: many_to_one
  }

  join: dwh_distributions {
    view_label: "Distributions"
    type: left_outer
    sql_on: ${dwh_distributions.id} = ${dwh_ds_summary.distributionid} ;;
    relationship: many_to_one
  }

  join: dwh_lineitems {
    view_label: "Line Items"
    type: left_outer
    sql_on: ${dwh_lineitems.id} = ${dwh_ds_summary.lineitemid} ;;
    relationship: many_to_one
  }
}

explore: dwh_geo_summary {
  hidden: yes
  persist_with: geo_summary
  label: "Geo Summary"
  join: dwh_advertisers {
    view_label: "Advertisers"
    type: left_outer
    sql_on: ${dwh_advertisers.id} = ${dwh_geo_summary.advertiserid} ;;
    relationship: many_to_one
  }
  join: dwh_campaigns {
    view_label: "Campaigns"
    type: left_outer
    sql_on: ${dwh_campaigns.id} = ${dwh_geo_summary.campaignid} ;;
    relationship: many_to_one
  }

  join: dwh_creatives {
    view_label: "Creatives"
    type: left_outer
    sql_on: ${dwh_creatives.id} = ${dwh_geo_summary.creativeid} ;;
    relationship: many_to_one
  }

  join: dwh_distributions {
    view_label: "Distributions"
    type: left_outer
    sql_on: ${dwh_distributions.id} = ${dwh_geo_summary.distributionid} ;;
    relationship: many_to_one
  }

}

#optimized pdt explore
explore: geo_daily_summary_pdt {
  persist_with: pdt_daily_refresh
  label: "GEO Summary"
  view_label: "GEO Summary"
  join: dwh_advertisers {
    view_label: "GEO Summary"
    type: left_outer
    sql_on: ${dwh_advertisers.id} = ${geo_daily_summary_pdt.advertiserid} ;;
    relationship: many_to_one
  }

}


##### Caching Datagroups #####
datagroup: geo_summary {
  sql_trigger: SELECT max(day || hour) FROM public.dwh_geo_summary LIMIT 10;;
  #max_cache_age: "1 hour"
}

datagroup: pdt_daily_refresh {
  sql_trigger: select current_date ;;
}
