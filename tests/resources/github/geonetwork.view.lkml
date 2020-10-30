#############################################################################################################
# Purpose: Defines the fields within the geonetwork struct in google analytics. Is extending into ga_sessions.view.lkml
#          and should not be joined into GA sessions explore as an independent view file.
#############################################################################################################

include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/geonetwork.view.lkml"

view: geonetwork {
  extends: [geonetwork_config]
}

view: geonetwork_core {
  extension: required

  ########## DIMENSIONS ##########

  dimension: approximate_network_location {
    view_label: "Audience"
    group_label: "Geo"
    label: "Approx. Network Location"
    description: "Approximate location based on rounded latitude and longitude returned by IP address."
    type: location
    sql_latitude: ROUND(${latitude},1) ;;
    sql_longitude: ROUND(${longitude},1) ;;
    drill_fields: [networkLocation]
  }

  dimension: city {
    view_label: "Audience"
    group_label: "Geo"
    description: "Users' city, derived from their IP addresses or Geographical IDs."
    sql: ${TABLE}.geoNetwork.city ;;
    drill_fields: [metro,approximate_networkLocation,networkLocation]
  }

  dimension: city_id {
    view_label: "Audience"
    group_label: "Geo"
    description: "Users' city ID, derived from their IP addresses or Geographical IDs. The city IDs are the same as the Criteria IDs found at https://developers.google.com/analytics/devguides/collection/protocol/v1/geoid."
    sql: ${TABLE}.geoNetwork.cityid ;;
  }

  dimension: continent {
    view_label: "Audience"
    group_label: "Geo"
    description: "Users' continent, derived from users' IP addresses or Geographical IDs."
    sql: ${TABLE}.geoNetwork.continent ;;
    drill_fields: [subcontinent,country,region,city,metro,approximate_networkLocation,networkLocation]
  }

  dimension: country {
    view_label: "Audience"
    group_label: "Geo"
    description: "Users' country, derived from their IP addresses or Geographical IDs."
    map_layer_name: countries
    sql: ${TABLE}.geoNetwork.country ;;
    drill_fields: [region,metro,city,approximate_networkLocation,networkLocation]
  }

  dimension: latitude {
    view_label: "Audience"
    group_label: "Geo"
    description: "The approximate latitude of users' city, derived from their IP addresses or Geographical IDs. Locations north of the equator have positive latitudes and locations south of the equator have negative latitudes."
    type: number
    hidden: yes
    sql: SAFE_CAST(${TABLE}.geoNetwork.latitude as FLOAT64);;
  }

  dimension: location {
    view_label: "Audience"
    group_label: "Geo"
    description: "Location based on latitude and longitude returned by IP address."
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: longitude {
    view_label: "Audience"
    group_label: "Geo"
    description: "The approximate longitude of users' city, derived from their IP addresses or Geographical IDs. Locations east of the prime meridian have positive longitudes and locations west of the prime meridian have negative longitudes."
    type: number
    hidden: yes
    sql: SAFE_CAST(${TABLE}.geoNetwork.longitude as FLOAT64);;
  }

  dimension: metro {
    view_label: "Audience"
    group_label: "Geo"
    description: "The Designated Market Area (DMA) from where traffic arrived."
    sql: ${TABLE}.geoNetwork.metro ;;
    drill_fields: [city,approximate_networkLocation,networkLocation]
  }

  dimension: network_domain {
    view_label: "Audience"
    group_label: "Geo"
    description: "The domain name of users' ISP, derived from the domain name registered to the ISP's IP address."
    sql: ${TABLE}.geoNetwork.networkDomain ;;
  }

  dimension: network_location {
    view_label: "Audience"
    group_label: "Geo"
    label: "Service Provider"
    description: "The names of the service providers used to reach the property. For example, if most users of the website come via the major cable internet service providers, its value will be these service providers' names."
    sql: ${TABLE}.geoNetwork.networkLocation ;;
  }

  dimension: region {
    view_label: "Audience"
    group_label: "Geo"
    description: "Users' region, derived from their IP addresses or Geographical IDs. In U.S., a region is a state, New York, for example."
    map_layer_name: us_states
    sql: ${TABLE}.geoNetwork.region ;;
    drill_fields: [metro,city,approximate_networkLocation,networkLocation]
  }

  dimension: subcontinent {
    view_label: "Audience"
    group_label: "Geo"
    description: "Users' sub-continent, derived from their IP addresses or Geographical IDs. For example, Polynesia or Northern Europe."
    sql: ${TABLE}.geoNetwork.subcontinent ;;
    drill_fields: [country,region,city,metro,approximate_networkLocation,networkLocation]
  }
}
