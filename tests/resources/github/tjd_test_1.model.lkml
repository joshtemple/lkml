connection: "tjd-bigquery"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: tjd_test_1_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: tjd_test_1_default_datagroup

explore: active_products {}

explore: category {}

explore: category_copy {}

explore: category_hierarchies_copy {}

explore: flattened_products {}

explore: flattened_products_copy {}

explore: magellan_product_copy {
  join: magellan_product_copy__metadata {
    view_label: "Magellan Product Copy: Metadata"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.metadata}]) as magellan_product_copy__metadata ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__descriptions {
    view_label: "Magellan Product Copy: Descriptions"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.descriptions}]) as magellan_product_copy__descriptions ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__descriptions__bullets {
    view_label: "Magellan Product Copy: Descriptions Bullets"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__descriptions.bullets}) as magellan_product_copy__descriptions__bullets ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__specifications {
    view_label: "Magellan Product Copy: Specifications"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.specifications}) as magellan_product_copy__specifications ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__features {
    view_label: "Magellan Product Copy: Features"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.features}) as magellan_product_copy__features ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__links__self {
    view_label: "Magellan Product Copy: Links Self"
    sql: LEFT JOIN UNNEST([${magellan_product_copy__links.self}]) as magellan_product_copy__links__self ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__links__master {
    view_label: "Magellan Product Copy: Links Master"
    sql: LEFT JOIN UNNEST([${magellan_product_copy__links.master}]) as magellan_product_copy__links__master ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__images {
    view_label: "Magellan Product Copy: Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.images}) as magellan_product_copy__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__operational_attributes {
    view_label: "Magellan Product Copy: Operational Attributes"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.operational_attributes}) as magellan_product_copy__operational_attributes ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__editorial_reviews {
    view_label: "Magellan Product Copy: Editorial Reviews"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.editorial_reviews}) as magellan_product_copy__editorial_reviews ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__condition {
    view_label: "Magellan Product Copy: Condition"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.condition}]) as magellan_product_copy__condition ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__warranties {
    view_label: "Magellan Product Copy: Warranties"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.warranties}]) as magellan_product_copy__warranties ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__meta {
    view_label: "Magellan Product Copy: Meta"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.meta}]) as magellan_product_copy__meta ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__parties {
    view_label: "Magellan Product Copy: Parties"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.parties}) as magellan_product_copy__parties ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__parties__images {
    view_label: "Magellan Product Copy: Parties Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__parties.images}) as magellan_product_copy__parties__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__color {
    view_label: "Magellan Product Copy: Color"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.color}]) as magellan_product_copy__color ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__discs {
    view_label: "Magellan Product Copy: Discs"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.discs}) as magellan_product_copy__discs ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__discs__tracks {
    view_label: "Magellan Product Copy: Discs Tracks"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__discs.tracks}) as magellan_product_copy__discs__tracks ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__discs__tracks__composers {
    view_label: "Magellan Product Copy: Discs Tracks Composers"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__discs__tracks.composers}) as magellan_product_copy__discs__tracks__composers ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__discs__tracks__composers__images {
    view_label: "Magellan Product Copy: Discs Tracks Composers Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__discs__tracks__composers.images}) as magellan_product_copy__discs__tracks__composers__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__discs__tracks__artists {
    view_label: "Magellan Product Copy: Discs Tracks Artists"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__discs__tracks.artists}) as magellan_product_copy__discs__tracks__artists ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__discs__tracks__artists__images {
    view_label: "Magellan Product Copy: Discs Tracks Artists Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__discs__tracks__artists.images}) as magellan_product_copy__discs__tracks__artists__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__manufacturer {
    view_label: "Magellan Product Copy: Manufacturer"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.manufacturer}]) as magellan_product_copy__manufacturer ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__video_details {
    view_label: "Magellan Product Copy: Video Details"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.video_details}) as magellan_product_copy__video_details ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__related_titles {
    view_label: "Magellan Product Copy: Video Details Related Titles"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__video_details.related_titles}) as magellan_product_copy__video_details__related_titles ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__editorial_reviews {
    view_label: "Magellan Product Copy: Video Details Editorial Reviews"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__video_details.editorial_reviews}) as magellan_product_copy__video_details__editorial_reviews ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__crew {
    view_label: "Magellan Product Copy: Video Details Crew"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__video_details.crew}) as magellan_product_copy__video_details__crew ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__crew__images {
    view_label: "Magellan Product Copy: Video Details Crew Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__video_details__crew.images}) as magellan_product_copy__video_details__crew__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__cast {
    view_label: "Magellan Product Copy: Video Details Cast"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__video_details.cast}) as magellan_product_copy__video_details__cast ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__cast__images {
    view_label: "Magellan Product Copy: Video Details Cast Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__video_details__cast.images}) as magellan_product_copy__video_details__cast__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__amg_rating {
    view_label: "Magellan Product Copy: Video Details Amg Rating"
    sql: LEFT JOIN UNNEST([${magellan_product_copy__video_details.amg_rating}]) as magellan_product_copy__video_details__amg_rating ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__video_details__awards {
    view_label: "Magellan Product Copy: Video Details Awards"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__video_details.awards}) as magellan_product_copy__video_details__awards ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__video_details__mpaa_rating {
    view_label: "Magellan Product Copy: Video Details Mpaa Rating"
    sql: LEFT JOIN UNNEST([${magellan_product_copy__video_details.mpaa_rating}]) as magellan_product_copy__video_details__mpaa_rating ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__product_manuals {
    view_label: "Magellan Product Copy: Product Manuals"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.product_manuals}) as magellan_product_copy__product_manuals ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__season_details__cast {
    view_label: "Magellan Product Copy: Season Details Cast"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__season_details.cast}) as magellan_product_copy__season_details__cast ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__season_details__cast__images {
    view_label: "Magellan Product Copy: Season Details Cast Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__season_details__cast.images}) as magellan_product_copy__season_details__cast__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__season_details {
    view_label: "Magellan Product Copy: Season Details"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.season_details}) as magellan_product_copy__season_details ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__season_details__episode_details {
    view_label: "Magellan Product Copy: Season Details Episode Details"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__season_details.episode_details}) as magellan_product_copy__season_details__episode_details ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__season_details__season_info {
    view_label: "Magellan Product Copy: Season Details Season Info"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__season_details.season_info}) as magellan_product_copy__season_details__season_info ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__season_details__crew {
    view_label: "Magellan Product Copy: Season Details Crew"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__season_details.crew}) as magellan_product_copy__season_details__crew ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__season_details__crew__images {
    view_label: "Magellan Product Copy: Season Details Crew Images"
    sql: LEFT JOIN UNNEST(${magellan_product_copy__season_details__crew.images}) as magellan_product_copy__season_details__crew__images ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__type_info {
    view_label: "Magellan Product Copy: Type Info"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.type_info}]) as magellan_product_copy__type_info ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__type_info__item_type {
    view_label: "Magellan Product Copy: Type Info Item Type"
    sql: LEFT JOIN UNNEST([${magellan_product_copy__type_info.item_type}]) as magellan_product_copy__type_info__item_type ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__names {
    view_label: "Magellan Product Copy: Names"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.names}]) as magellan_product_copy__names ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__esrb_rating {
    view_label: "Magellan Product Copy: Esrb Rating"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.esrb_rating}]) as magellan_product_copy__esrb_rating ;;
    relationship: one_to_one
  }

  join: magellan_product_copy__awards {
    view_label: "Magellan Product Copy: Awards"
    sql: LEFT JOIN UNNEST(${magellan_product_copy.awards}) as magellan_product_copy__awards ;;
    relationship: one_to_many
  }

  join: magellan_product_copy__links {
    view_label: "Magellan Product Copy: Links"
    sql: LEFT JOIN UNNEST([${magellan_product_copy.links}]) as magellan_product_copy__links ;;
    relationship: one_to_one
  }
}

explore: product_specifications {}

explore: productsv2_flattened {}

explore: productv2_test_copy {
  join: productv2_test_copy__esrb_rating {
    view_label: "Productv2 Test Copy: Esrb Rating"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.esrb_rating}]) as productv2_test_copy__esrb_rating ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__metadata {
    view_label: "Productv2 Test Copy: Metadata"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.metadata}]) as productv2_test_copy__metadata ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__color {
    view_label: "Productv2 Test Copy: Color"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.color}]) as productv2_test_copy__color ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__season_details__cast {
    view_label: "Productv2 Test Copy: Season Details Cast"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__season_details.cast}) as productv2_test_copy__season_details__cast ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__season_details {
    view_label: "Productv2 Test Copy: Season Details"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.season_details}) as productv2_test_copy__season_details ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__season_details__season_info {
    view_label: "Productv2 Test Copy: Season Details Season Info"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__season_details.season_info}) as productv2_test_copy__season_details__season_info ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__season_details__episode_details {
    view_label: "Productv2 Test Copy: Season Details Episode Details"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__season_details.episode_details}) as productv2_test_copy__season_details__episode_details ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__season_details__crew {
    view_label: "Productv2 Test Copy: Season Details Crew"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__season_details.crew}) as productv2_test_copy__season_details__crew ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__discs {
    view_label: "Productv2 Test Copy: Discs"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.discs}) as productv2_test_copy__discs ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__discs__tracks {
    view_label: "Productv2 Test Copy: Discs Tracks"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__discs.tracks}) as productv2_test_copy__discs__tracks ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__discs__tracks__composers {
    view_label: "Productv2 Test Copy: Discs Tracks Composers"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__discs__tracks.composers}) as productv2_test_copy__discs__tracks__composers ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__discs__tracks__artists {
    view_label: "Productv2 Test Copy: Discs Tracks Artists"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__discs__tracks.artists}) as productv2_test_copy__discs__tracks__artists ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__operational_attributes {
    view_label: "Productv2 Test Copy: Operational Attributes"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.operational_attributes}) as productv2_test_copy__operational_attributes ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__specifications {
    view_label: "Productv2 Test Copy: Specifications"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.specifications}) as productv2_test_copy__specifications ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__descriptions {
    view_label: "Productv2 Test Copy: Descriptions"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.descriptions}]) as productv2_test_copy__descriptions ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__manufacturer {
    view_label: "Productv2 Test Copy: Manufacturer"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.manufacturer}]) as productv2_test_copy__manufacturer ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__features {
    view_label: "Productv2 Test Copy: Features"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.features}) as productv2_test_copy__features ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details {
    view_label: "Productv2 Test Copy: Video Details"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.video_details}) as productv2_test_copy__video_details ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details__crew {
    view_label: "Productv2 Test Copy: Video Details Crew"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__video_details.crew}) as productv2_test_copy__video_details__crew ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details__crew__images {
    view_label: "Productv2 Test Copy: Video Details Crew Images"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__video_details__crew.images}) as productv2_test_copy__video_details__crew__images ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details__cast {
    view_label: "Productv2 Test Copy: Video Details Cast"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__video_details.cast}) as productv2_test_copy__video_details__cast ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details__cast__images {
    view_label: "Productv2 Test Copy: Video Details Cast Images"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__video_details__cast.images}) as productv2_test_copy__video_details__cast__images ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details__amg_rating {
    view_label: "Productv2 Test Copy: Video Details Amg Rating"
    sql: LEFT JOIN UNNEST([${productv2_test_copy__video_details.amg_rating}]) as productv2_test_copy__video_details__amg_rating ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__video_details__awards {
    view_label: "Productv2 Test Copy: Video Details Awards"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__video_details.awards}) as productv2_test_copy__video_details__awards ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details__related_titles {
    view_label: "Productv2 Test Copy: Video Details Related Titles"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__video_details.related_titles}) as productv2_test_copy__video_details__related_titles ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__video_details__mpaa_rating {
    view_label: "Productv2 Test Copy: Video Details Mpaa Rating"
    sql: LEFT JOIN UNNEST([${productv2_test_copy__video_details.mpaa_rating}]) as productv2_test_copy__video_details__mpaa_rating ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__video_details__editorial_reviews {
    view_label: "Productv2 Test Copy: Video Details Editorial Reviews"
    sql: LEFT JOIN UNNEST(${productv2_test_copy__video_details.editorial_reviews}) as productv2_test_copy__video_details__editorial_reviews ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__links__self {
    view_label: "Productv2 Test Copy: Links Self"
    sql: LEFT JOIN UNNEST([${productv2_test_copy__links.self}]) as productv2_test_copy__links__self ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__links__master {
    view_label: "Productv2 Test Copy: Links Master"
    sql: LEFT JOIN UNNEST([${productv2_test_copy__links.master}]) as productv2_test_copy__links__master ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__editorial_reviews {
    view_label: "Productv2 Test Copy: Editorial Reviews"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.editorial_reviews}) as productv2_test_copy__editorial_reviews ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__images {
    view_label: "Productv2 Test Copy: Images"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.images}) as productv2_test_copy__images ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__type_info {
    view_label: "Productv2 Test Copy: Type Info"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.type_info}]) as productv2_test_copy__type_info ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__product_manuals {
    view_label: "Productv2 Test Copy: Product Manuals"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.product_manuals}) as productv2_test_copy__product_manuals ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__condition {
    view_label: "Productv2 Test Copy: Condition"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.condition}]) as productv2_test_copy__condition ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__warranties {
    view_label: "Productv2 Test Copy: Warranties"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.warranties}]) as productv2_test_copy__warranties ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__names {
    view_label: "Productv2 Test Copy: Names"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.names}]) as productv2_test_copy__names ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__awards {
    view_label: "Productv2 Test Copy: Awards"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.awards}) as productv2_test_copy__awards ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__meta {
    view_label: "Productv2 Test Copy: Meta"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.meta}]) as productv2_test_copy__meta ;;
    relationship: one_to_one
  }

  join: productv2_test_copy__parties {
    view_label: "Productv2 Test Copy: Parties"
    sql: LEFT JOIN UNNEST(${productv2_test_copy.parties}) as productv2_test_copy__parties ;;
    relationship: one_to_many
  }

  join: productv2_test_copy__links {
    view_label: "Productv2 Test Copy: Links"
    sql: LEFT JOIN UNNEST([${productv2_test_copy.links}]) as productv2_test_copy__links ;;
    relationship: one_to_one
  }
}

explore: results_20180302_124218 {
  join: results_20180302_124218__esrb_rating {
    view_label: "Results 20180302 124218: Esrb Rating"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.esrb_rating}]) as results_20180302_124218__esrb_rating ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__metadata {
    view_label: "Results 20180302 124218: Metadata"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.metadata}]) as results_20180302_124218__metadata ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__color {
    view_label: "Results 20180302 124218: Color"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.color}]) as results_20180302_124218__color ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__season_details__cast {
    view_label: "Results 20180302 124218: Season Details Cast"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__season_details.cast}) as results_20180302_124218__season_details__cast ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__season_details {
    view_label: "Results 20180302 124218: Season Details"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.season_details}) as results_20180302_124218__season_details ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__season_details__season_info {
    view_label: "Results 20180302 124218: Season Details Season Info"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__season_details.season_info}) as results_20180302_124218__season_details__season_info ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__season_details__episode_details {
    view_label: "Results 20180302 124218: Season Details Episode Details"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__season_details.episode_details}) as results_20180302_124218__season_details__episode_details ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__season_details__crew {
    view_label: "Results 20180302 124218: Season Details Crew"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__season_details.crew}) as results_20180302_124218__season_details__crew ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__discs {
    view_label: "Results 20180302 124218: Discs"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.discs}) as results_20180302_124218__discs ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__discs__tracks {
    view_label: "Results 20180302 124218: Discs Tracks"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__discs.tracks}) as results_20180302_124218__discs__tracks ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__discs__tracks__composers {
    view_label: "Results 20180302 124218: Discs Tracks Composers"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__discs__tracks.composers}) as results_20180302_124218__discs__tracks__composers ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__discs__tracks__artists {
    view_label: "Results 20180302 124218: Discs Tracks Artists"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__discs__tracks.artists}) as results_20180302_124218__discs__tracks__artists ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__operational_attributes {
    view_label: "Results 20180302 124218: Operational Attributes"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.operational_attributes}) as results_20180302_124218__operational_attributes ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__specifications {
    view_label: "Results 20180302 124218: Specifications"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.specifications}) as results_20180302_124218__specifications ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__descriptions {
    view_label: "Results 20180302 124218: Descriptions"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.descriptions}]) as results_20180302_124218__descriptions ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__manufacturer {
    view_label: "Results 20180302 124218: Manufacturer"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.manufacturer}]) as results_20180302_124218__manufacturer ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__features {
    view_label: "Results 20180302 124218: Features"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.features}) as results_20180302_124218__features ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details {
    view_label: "Results 20180302 124218: Video Details"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.video_details}) as results_20180302_124218__video_details ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details__crew {
    view_label: "Results 20180302 124218: Video Details Crew"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__video_details.crew}) as results_20180302_124218__video_details__crew ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details__crew__images {
    view_label: "Results 20180302 124218: Video Details Crew Images"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__video_details__crew.images}) as results_20180302_124218__video_details__crew__images ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details__cast {
    view_label: "Results 20180302 124218: Video Details Cast"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__video_details.cast}) as results_20180302_124218__video_details__cast ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details__cast__images {
    view_label: "Results 20180302 124218: Video Details Cast Images"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__video_details__cast.images}) as results_20180302_124218__video_details__cast__images ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details__amg_rating {
    view_label: "Results 20180302 124218: Video Details Amg Rating"
    sql: LEFT JOIN UNNEST([${results_20180302_124218__video_details.amg_rating}]) as results_20180302_124218__video_details__amg_rating ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__video_details__awards {
    view_label: "Results 20180302 124218: Video Details Awards"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__video_details.awards}) as results_20180302_124218__video_details__awards ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details__related_titles {
    view_label: "Results 20180302 124218: Video Details Related Titles"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__video_details.related_titles}) as results_20180302_124218__video_details__related_titles ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__video_details__mpaa_rating {
    view_label: "Results 20180302 124218: Video Details Mpaa Rating"
    sql: LEFT JOIN UNNEST([${results_20180302_124218__video_details.mpaa_rating}]) as results_20180302_124218__video_details__mpaa_rating ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__video_details__editorial_reviews {
    view_label: "Results 20180302 124218: Video Details Editorial Reviews"
    sql: LEFT JOIN UNNEST(${results_20180302_124218__video_details.editorial_reviews}) as results_20180302_124218__video_details__editorial_reviews ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__links__self {
    view_label: "Results 20180302 124218: Links Self"
    sql: LEFT JOIN UNNEST([${results_20180302_124218__links.self}]) as results_20180302_124218__links__self ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__links__master {
    view_label: "Results 20180302 124218: Links Master"
    sql: LEFT JOIN UNNEST([${results_20180302_124218__links.master}]) as results_20180302_124218__links__master ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__editorial_reviews {
    view_label: "Results 20180302 124218: Editorial Reviews"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.editorial_reviews}) as results_20180302_124218__editorial_reviews ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__images {
    view_label: "Results 20180302 124218: Images"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.images}) as results_20180302_124218__images ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__type_info {
    view_label: "Results 20180302 124218: Type Info"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.type_info}]) as results_20180302_124218__type_info ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__product_manuals {
    view_label: "Results 20180302 124218: Product Manuals"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.product_manuals}) as results_20180302_124218__product_manuals ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__condition {
    view_label: "Results 20180302 124218: Condition"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.condition}]) as results_20180302_124218__condition ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__warranties {
    view_label: "Results 20180302 124218: Warranties"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.warranties}]) as results_20180302_124218__warranties ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__names {
    view_label: "Results 20180302 124218: Names"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.names}]) as results_20180302_124218__names ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__awards {
    view_label: "Results 20180302 124218: Awards"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.awards}) as results_20180302_124218__awards ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__meta {
    view_label: "Results 20180302 124218: Meta"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.meta}]) as results_20180302_124218__meta ;;
    relationship: one_to_one
  }

  join: results_20180302_124218__parties {
    view_label: "Results 20180302 124218: Parties"
    sql: LEFT JOIN UNNEST(${results_20180302_124218.parties}) as results_20180302_124218__parties ;;
    relationship: one_to_many
  }

  join: results_20180302_124218__links {
    view_label: "Results 20180302 124218: Links"
    sql: LEFT JOIN UNNEST([${results_20180302_124218.links}]) as results_20180302_124218__links ;;
    relationship: one_to_one
  }
}

explore: sku_frequency {}

explore: top_sellers {}

explore: v_flattened_products {}

explore: v_magellan_product {
  join: v_magellan_product__operational_attributes {
    view_label: "V Magellan Product: Operational Attributes"
    sql: LEFT JOIN UNNEST(${v_magellan_product.operational_attributes}) as v_magellan_product__operational_attributes ;;
    relationship: one_to_many
  }

  join: v_magellan_product__color {
    view_label: "V Magellan Product: Color"
    sql: LEFT JOIN UNNEST([${v_magellan_product.color}]) as v_magellan_product__color ;;
    relationship: one_to_one
  }

  join: v_magellan_product__descriptions {
    view_label: "V Magellan Product: Descriptions"
    sql: LEFT JOIN UNNEST([${v_magellan_product.descriptions}]) as v_magellan_product__descriptions ;;
    relationship: one_to_one
  }

  join: v_magellan_product__descriptions__bullets {
    view_label: "V Magellan Product: Descriptions Bullets"
    sql: LEFT JOIN UNNEST(${v_magellan_product__descriptions.bullets}) as v_magellan_product__descriptions__bullets ;;
    relationship: one_to_many
  }

  join: v_magellan_product__specifications {
    view_label: "V Magellan Product: Specifications"
    sql: LEFT JOIN UNNEST(${v_magellan_product.specifications}) as v_magellan_product__specifications ;;
    relationship: one_to_many
  }

  join: v_magellan_product__manufacturer {
    view_label: "V Magellan Product: Manufacturer"
    sql: LEFT JOIN UNNEST([${v_magellan_product.manufacturer}]) as v_magellan_product__manufacturer ;;
    relationship: one_to_one
  }

  join: v_magellan_product__features {
    view_label: "V Magellan Product: Features"
    sql: LEFT JOIN UNNEST(${v_magellan_product.features}) as v_magellan_product__features ;;
    relationship: one_to_many
  }

  join: v_magellan_product__condition {
    view_label: "V Magellan Product: Condition"
    sql: LEFT JOIN UNNEST([${v_magellan_product.condition}]) as v_magellan_product__condition ;;
    relationship: one_to_one
  }

  join: v_magellan_product__warranties {
    view_label: "V Magellan Product: Warranties"
    sql: LEFT JOIN UNNEST([${v_magellan_product.warranties}]) as v_magellan_product__warranties ;;
    relationship: one_to_one
  }

  join: v_magellan_product__names {
    view_label: "V Magellan Product: Names"
    sql: LEFT JOIN UNNEST([${v_magellan_product.names}]) as v_magellan_product__names ;;
    relationship: one_to_one
  }
}

explore: v_magellan_product_v2 {
  join: vMagellanProductV2__operational_attributes {
    view_label: "Vmagellanproductv2: Operational Attributes"
    sql: LEFT JOIN UNNEST(${v_magellan_product_v2.operational_attributes}) as vMagellanProductV2__operational_attributes ;;
    relationship: one_to_many
  }

  join: vMagellanProductV2__color {
    view_label: "Vmagellanproductv2: Color"
    sql: LEFT JOIN UNNEST([${v_magellan_product_v2.color}]) as vMagellanProductV2__color ;;
    relationship: one_to_one
  }

  join: vMagellanProductV2__descriptions {
    view_label: "Vmagellanproductv2: Descriptions"
    sql: LEFT JOIN UNNEST([${v_magellan_product_v2.descriptions}]) as vMagellanProductV2__descriptions ;;
    relationship: one_to_one
  }

  join: vMagellanProductV2__descriptions__bullets {
    view_label: "Vmagellanproductv2: Descriptions Bullets"
    sql: LEFT JOIN UNNEST(${vMagellanProductV2__descriptions.bullets}) as vMagellanProductV2__descriptions__bullets ;;
    relationship: one_to_many
  }

  join: vMagellanProductV2__specifications {
    view_label: "Vmagellanproductv2: Specifications"
    sql: LEFT JOIN UNNEST(${v_magellan_product_v2.specifications}) as vMagellanProductV2__specifications ;;
    relationship: one_to_many
  }

  join: vMagellanProductV2__manufacturer {
    view_label: "Vmagellanproductv2: Manufacturer"
    sql: LEFT JOIN UNNEST([${v_magellan_product_v2.manufacturer}]) as vMagellanProductV2__manufacturer ;;
    relationship: one_to_one
  }

  join: vMagellanProductV2__features {
    view_label: "Vmagellanproductv2: Features"
    sql: LEFT JOIN UNNEST(${v_magellan_product_v2.features}) as v_magellan_product_v2__features ;;
    relationship: one_to_many
  }

  join: vMagellanProductV2__condition {
    view_label: "Vmagellanproductv2: Condition"
    sql: LEFT JOIN UNNEST([${v_magellan_product_v2.condition}]) as vMagellanProductV2__condition ;;
    relationship: one_to_one
  }

  join: vMagellanProductV2__warranties {
    view_label: "Vmagellanproductv2: Warranties"
    sql: LEFT JOIN UNNEST([${v_magellan_product_v2.warranties}]) as vMagellanProductV2__warranties ;;
    relationship: one_to_one
  }

  join: vMagellanProductV2__names {
    view_label: "Vmagellanproductv2: Names"
    sql: LEFT JOIN UNNEST([${v_magellan_product_v2.names}]) as vMagellanProductV2__names ;;
    relationship: one_to_one
  }
}

explore: v_products_v2 {
  join: vProductsV2__names {
    view_label: "Vproductsv2: Names"
    sql: LEFT JOIN UNNEST([${v_products_v2.names}]) as vProductsV2__names ;;
    relationship: one_to_one
  }

  join: vProductsV2__specifications {
    view_label: "Vproductsv2: Specifications"
    sql: LEFT JOIN UNNEST(${v_products_v2.specifications}) as vProductsV2__specifications ;;
    relationship: one_to_many
  }
}

explore: v_top_sellers {}
