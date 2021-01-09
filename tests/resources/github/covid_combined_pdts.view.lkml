####################
### Max Dates
####################
view: max_date_covid_config {
  extends: [max_date_covid_core]
  extension: required

  # Add view customizations here

}

view: max_date_tracking_project_config {
  extends: [max_date_tracking_project_core]
  extension: required

  # Add view customizations here


}


####################
### Ranks
####################
view: country_rank_config {
  extends: [country_rank_core]
  extension: required

  # Add view customizations here
}

view: state_rank_config {
  extends: [state_rank_core]
  extension: required

  # Add view customizations here

}

view: fips_rank_config {
  extends: [fips_rank_core]
  extension: required

  # Add view customizations here

}


####################
### Growth Rate / Days to Double
####################
view: prior_days_cases_covid_config {
  extends: [prior_days_cases_covid_core]
  extension: required

  # Add view customizations here

}

####################
### Compare Geographies
####################
view: kpis_by_county_by_date_config {
  extends: [kpis_by_county_by_date_core]
  extension: required

  # Add view customizations here

}

view: kpis_by_state_by_date_config {
  extends: [kpis_by_state_by_date_core]
  extension: required

  # Add view customizations here

}

view: kpis_by_country_by_date_config {
  extends: [kpis_by_country_by_date_core]
  extension: required

  # Add view customizations here

}

view: kpis_by_entity_by_date_config {
  extends: [kpis_by_entity_by_date_core]
  extension: required

  # Add view customizations here

}
