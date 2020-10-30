view: results_20180302_124218 {
  sql_table_name: Product.results_20180302_124218 ;;

  dimension: awards {
    hidden: yes
    sql: ${TABLE}.awards ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: carrier_name {
    type: string
    sql: ${TABLE}.carrierName ;;
  }

  dimension: color {
    hidden: yes
    sql: ${TABLE}.color ;;
  }

  dimension: condition {
    hidden: yes
    sql: ${TABLE}.condition ;;
  }

  dimension: depth {
    type: string
    sql: ${TABLE}.depth ;;
  }

  dimension: descriptions {
    hidden: yes
    sql: ${TABLE}.descriptions ;;
  }

  dimension: discs {
    hidden: yes
    sql: ${TABLE}.discs ;;
  }

  dimension: editorial_reviews {
    hidden: yes
    sql: ${TABLE}.editorialReviews ;;
  }

  dimension: esrb_rating {
    hidden: yes
    sql: ${TABLE}.esrbRating ;;
  }

  dimension: features {
    hidden: yes
    sql: ${TABLE}.features ;;
  }

  dimension: formats {
    type: string
    sql: ${TABLE}.formats ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

  dimension: images {
    hidden: yes
    sql: ${TABLE}.images ;;
  }

  dimension: included_items {
    type: string
    sql: ${TABLE}.includedItems ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.label ;;
  }

  dimension: length {
    type: string
    sql: ${TABLE}.length ;;
  }

  dimension: links {
    hidden: yes
    sql: ${TABLE}.links ;;
  }

  dimension: manufacturer {
    hidden: yes
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: meta {
    hidden: yes
    sql: ${TABLE}.meta ;;
  }

  dimension: metadata {
    hidden: yes
    sql: ${TABLE}.metadata ;;
  }

  dimension: names {
    hidden: yes
    sql: ${TABLE}.names ;;
  }

  dimension: number_of_songs {
    type: number
    sql: ${TABLE}.numberOfSongs ;;
  }

  dimension: operational_attributes {
    hidden: yes
    sql: ${TABLE}.operationalAttributes ;;
  }

  dimension_group: original_release {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.originalReleaseDate ;;
  }

  dimension: parental_advisory {
    type: yesno
    sql: ${TABLE}.parentalAdvisory ;;
  }

  dimension: parties {
    hidden: yes
    sql: ${TABLE}.parties ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: primary_artists {
    type: string
    sql: ${TABLE}.primaryArtists ;;
  }

  dimension: product_manuals {
    hidden: yes
    sql: ${TABLE}.productManuals ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}.publisher ;;
  }

  dimension: season_details {
    hidden: yes
    sql: ${TABLE}.seasonDetails ;;
  }

  dimension: sku_id {
    type: number
    sql: ${TABLE}.skuId ;;
  }

  dimension: special_features {
    type: string
    sql: ${TABLE}.specialFeatures ;;
  }

  dimension: specifications {
    hidden: yes
    sql: ${TABLE}.specifications ;;
  }

  dimension: studio {
    type: string
    sql: ${TABLE}.studio ;;
  }

  dimension: sub_genres {
    type: string
    sql: ${TABLE}.subGenres ;;
  }

  dimension: type_info {
    hidden: yes
    sql: ${TABLE}.typeInfo ;;
  }

  dimension: upc {
    type: number
    sql: ${TABLE}.upc ;;
  }

  dimension: video_details {
    hidden: yes
    sql: ${TABLE}.videoDetails ;;
  }

  dimension: warranties {
    hidden: yes
    sql: ${TABLE}.warranties ;;
  }

  dimension: weight {
    type: string
    sql: ${TABLE}.weight ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }

  measure: count {
    type: count
    drill_fields: [carrier_name]
  }
}

view: results_20180302_124218__esrb_rating {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: descriptors {
    type: string
    sql: ${TABLE}.descriptors ;;
  }
}

view: results_20180302_124218__metadata {
  dimension: entity_id {
    type: string
    sql: ${TABLE}.entityId ;;
  }

  dimension: pcm_source {
    type: string
    sql: ${TABLE}.pcmSource ;;
  }

  dimension: source_system {
    type: string
    sql: ${TABLE}.sourceSystem ;;
  }
}

view: results_20180302_124218__color {
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.displayName ;;
  }
}

view: results_20180302_124218__season_details__cast {
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: roles {
    type: string
    sql: ${TABLE}.roles ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }
}

view: results_20180302_124218__season_details {
  dimension: amg_movie_id {
    type: string
    sql: ${TABLE}.amgMovieId ;;
  }

  dimension: cast {
    hidden: yes
    sql: ${TABLE}.`cast` ;;
  }

  dimension: countries_produced {
    type: string
    sql: ${TABLE}.countriesProduced ;;
  }

  dimension: crew {
    hidden: yes
    sql: ${TABLE}.crew ;;
  }

  dimension: episode_details {
    hidden: yes
    sql: ${TABLE}.episodeDetails ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: season_info {
    hidden: yes
    sql: ${TABLE}.seasonInfo ;;
  }

  dimension: sub_genres {
    type: string
    sql: ${TABLE}.subGenres ;;
  }

  dimension: synopsis {
    type: string
    sql: ${TABLE}.synopsis ;;
  }

  dimension: themes {
    type: string
    sql: ${TABLE}.themes ;;
  }

  dimension: tv_rating {
    type: string
    sql: ${TABLE}.tvRating ;;
  }
}

view: results_20180302_124218__season_details__season_info {
  dimension: season_number {
    type: number
    sql: ${TABLE}.seasonNumber ;;
  }

  dimension: season_start_year {
    type: number
    sql: ${TABLE}.seasonStartYear ;;
  }

  dimension: season_title {
    type: string
    sql: ${TABLE}.seasonTitle ;;
  }
}

view: results_20180302_124218__season_details__episode_details {
  dimension: episode_id {
    type: number
    sql: ${TABLE}.episodeId ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: year_of_release {
    type: number
    sql: ${TABLE}.yearOfRelease ;;
  }
}

view: results_20180302_124218__season_details__crew {
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: roles {
    type: string
    sql: ${TABLE}.roles ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }
}

view: results_20180302_124218__discs {
  dimension: disc_number {
    type: number
    sql: ${TABLE}.discNumber ;;
  }

  dimension: tracks {
    hidden: yes
    sql: ${TABLE}.tracks ;;
  }
}

view: results_20180302_124218__discs__tracks {
  dimension: artists {
    hidden: yes
    sql: ${TABLE}.artists ;;
  }

  dimension: composers {
    hidden: yes
    sql: ${TABLE}.composers ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }
}

view: results_20180302_124218__discs__tracks__composers {
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: results_20180302_124218__discs__tracks__artists {
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
}

view: results_20180302_124218__operational_attributes {
  dimension: display_name {
    type: string
    sql: ${TABLE}.displayName ;;
  }

  dimension: raw_name {
    type: string
    sql: ${TABLE}.rawName ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }

  dimension: values {
    type: string
    sql: ${TABLE}.values ;;
  }
}

view: results_20180302_124218__specifications {
  dimension: definition {
    type: string
    sql: ${TABLE}.definition ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.displayName ;;
  }

  dimension: raw_name {
    type: string
    sql: ${TABLE}.rawName ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }

  dimension: values {
    type: string
    sql: ${TABLE}.values ;;
  }
}

view: results_20180302_124218__descriptions {
  dimension: bullets {
    type: string
    sql: ${TABLE}.bullets ;;
  }

  dimension: long {
    type: string
    sql: ${TABLE}.long ;;
  }

  dimension: short {
    type: string
    sql: ${TABLE}.short ;;
  }
}

view: results_20180302_124218__manufacturer {
  dimension: model_number {
    type: string
    sql: ${TABLE}.modelNumber ;;
  }
}

view: results_20180302_124218__features {
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
}

view: results_20180302_124218__video_details {
  dimension: amg_movie_id {
    type: string
    sql: ${TABLE}.amgMovieId ;;
  }

  dimension: amg_rating {
    hidden: yes
    sql: ${TABLE}.amgRating ;;
  }

  dimension: awards {
    hidden: yes
    sql: ${TABLE}.awards ;;
  }

  dimension: cast {
    hidden: yes
    sql: ${TABLE}.`cast` ;;
  }

  dimension: countries_produced {
    type: string
    sql: ${TABLE}.countriesProduced ;;
  }

  dimension: crew {
    hidden: yes
    sql: ${TABLE}.crew ;;
  }

  dimension: editorial_reviews {
    hidden: yes
    sql: ${TABLE}.editorialReviews ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: moods {
    type: string
    sql: ${TABLE}.moods ;;
  }

  dimension: mpaa_rating {
    hidden: yes
    sql: ${TABLE}.mpaaRating ;;
  }

  dimension: related_titles {
    hidden: yes
    sql: ${TABLE}.relatedTitles ;;
  }

  dimension: sub_genres {
    type: string
    sql: ${TABLE}.subGenres ;;
  }

  dimension: synopsis {
    type: string
    sql: ${TABLE}.synopsis ;;
  }

  dimension: themes {
    type: string
    sql: ${TABLE}.themes ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: tones {
    type: string
    sql: ${TABLE}.tones ;;
  }

  dimension: vendor_genres {
    type: string
    sql: ${TABLE}.vendorGenres ;;
  }

  dimension: year_of_release {
    type: number
    sql: ${TABLE}.yearOfRelease ;;
  }
}

view: results_20180302_124218__video_details__crew {
  dimension: images {
    hidden: yes
    sql: ${TABLE}.images ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: roles {
    type: string
    sql: ${TABLE}.roles ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }
}

view: results_20180302_124218__video_details__crew__images {
  dimension: href {
    type: string
    sql: ${TABLE}.href ;;
  }

  dimension: rel {
    type: string
    sql: ${TABLE}.rel ;;
  }
}

view: results_20180302_124218__video_details__cast {
  dimension: images {
    hidden: yes
    sql: ${TABLE}.images ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: roles {
    type: string
    sql: ${TABLE}.roles ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }
}

view: results_20180302_124218__video_details__cast__images {
  dimension: href {
    type: string
    sql: ${TABLE}.href ;;
  }

  dimension: rel {
    type: string
    sql: ${TABLE}.rel ;;
  }
}

view: results_20180302_124218__video_details__amg_rating {
  dimension: range_max {
    type: number
    sql: ${TABLE}.rangeMax ;;
  }

  dimension: range_min {
    type: number
    sql: ${TABLE}.rangeMin ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
}

view: results_20180302_124218__video_details__awards {
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: recipients {
    type: string
    sql: ${TABLE}.recipients ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: winner {
    type: yesno
    sql: ${TABLE}.winner ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }
}

view: results_20180302_124218__video_details__related_titles {
  dimension: amg_movie_id {
    type: string
    sql: ${TABLE}.amgMovieId ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
}

view: results_20180302_124218__video_details__mpaa_rating {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: flags {
    type: string
    sql: ${TABLE}.flags ;;
  }
}

view: results_20180302_124218__video_details__editorial_reviews {
  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }
}

view: results_20180302_124218__links__self {
  dimension: href {
    type: string
    sql: ${TABLE}.href ;;
  }
}

view: results_20180302_124218__links__master {
  dimension: href {
    type: string
    sql: ${TABLE}.href ;;
  }
}

view: results_20180302_124218__editorial_reviews {
  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }
}

view: results_20180302_124218__images {
  dimension: href {
    type: string
    sql: ${TABLE}.href ;;
  }

  dimension: primary {
    type: yesno
    sql: ${TABLE}.primary ;;
  }

  dimension: rel {
    type: string
    sql: ${TABLE}.rel ;;
  }
}

view: results_20180302_124218__type_info {
  dimension: definition {
    type: string
    sql: ${TABLE}.definition ;;
  }

  dimension: metatype {
    type: string
    sql: ${TABLE}.metatype ;;
  }

  dimension: subtype {
    type: string
    sql: ${TABLE}.subtype ;;
  }
}

view: results_20180302_124218__product_manuals {
  dimension: asset_description {
    type: string
    sql: ${TABLE}.assetDescription ;;
  }

  dimension: asset_name {
    type: string
    sql: ${TABLE}.assetName ;;
  }

  dimension: asset_url {
    type: string
    sql: ${TABLE}.assetUrl ;;
  }

  dimension: document_type {
    type: string
    sql: ${TABLE}.documentType ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: vanity_name {
    type: string
    sql: ${TABLE}.vanityName ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.version ;;
  }
}

view: results_20180302_124218__condition {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: results_20180302_124218__warranties {
  dimension: labor {
    type: string
    sql: ${TABLE}.labor ;;
  }

  dimension: parts {
    type: string
    sql: ${TABLE}.parts ;;
  }
}

view: results_20180302_124218__names {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: raw_short {
    type: string
    sql: ${TABLE}.rawShort ;;
  }

  dimension: short {
    type: string
    sql: ${TABLE}.short ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
}

view: results_20180302_124218__awards {
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: recipients {
    type: string
    sql: ${TABLE}.recipients ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: winner {
    type: yesno
    sql: ${TABLE}.winner ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }
}

view: results_20180302_124218__meta {
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: keywords {
    type: string
    sql: ${TABLE}.keywords ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
}

view: results_20180302_124218__parties {
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: roles {
    type: string
    sql: ${TABLE}.roles ;;
  }
}

view: results_20180302_124218__links {
  dimension: master {
    hidden: yes
    sql: ${TABLE}.master ;;
  }

  dimension: self {
    hidden: yes
    sql: ${TABLE}.self ;;
  }
}
