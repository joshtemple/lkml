view: shops {
  sql_table_name: etl.DimShop ;;

  dimension: area {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Area ;;
    drill_fields: [shop]
  }

  dimension: brand {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Brand ;;
  }

  dimension: competitive_flag {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Competitive_flag ;;
  }

  dimension: competitive_group {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Competitive_group ;;
  }

  dimension: l4l_flag {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.l4l_flag ;;
  }

  dimension: no_of_competitors {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.No_of_competitors ;;
  }

  dimension: no_of_ssbts {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.No_of_ssbts ;;
  }

  dimension: postcode {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Postcode ;;
  }

  dimension: postcode_area {
    view_label: "Signup Shop"
    type: string
    sql: UPPER(
        CASE WHEN REGEXP_CONTAINS(SUBSTR(${postcode}, 1, 2), "^*[0-9]") THEN SUBSTR(${postcode}, 1, 1)
        ELSE SUBSTR(${postcode}, 1, 2) END)  ;;
    map_layer_name: uk_postcode_areas
  }

  dimension: region {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Region ;;
    drill_fields: [subregion,area,shop]
  }

  dimension: shop {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Shop ;;
    link: {
      label: "Shop Details"
      url: "/dashboards/4?Shop%20ID={{value}}"
      icon_url: "https://www.looker.com/favicon.ico"
    }
  }

  dimension: status {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: subregion {
    view_label: "Signup Shop"
    type: string
    sql: ${TABLE}.Subregion ;;
    drill_fields: [area,shop]
  }

  dimension: shop_location_comparison {
    view_label: "Signup Shop"
    type: string
    sql:
      CASE

      WHEN  ${shop} = ${shop_info.shop}
      THEN CONCAT('(1) ',${shop})

      WHEN  ${area} = ${shop_info.area}
      THEN CONCAT('(2) Rest of ',${area})

      WHEN  ${region} = ${shop_info.region}
      THEN CONCAT('(3) Rest of ',${region})

      ELSE '(4) Rest Of Population'

      END;;
  }

  measure: shop_count {
    view_label: "Signup Shop"
    type: count_distinct
    sql: ${shop} ;;
    drill_fields: [shop]
  }
}
