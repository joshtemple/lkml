view: magellan_product_copy {
  sql_table_name: Product.magellan_product_copy ;;

  dimension: awards {
    hidden: yes
    sql: ${TABLE}.awards ;;
  }

  dimension: bby_sku_id {
    type: string
    sql: ${TABLE}.bby_sku_id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: carrier_name {
    type: string
    sql: ${TABLE}.carrier_name ;;
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
    type: number
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
    sql: ${TABLE}.editorial_reviews ;;
  }

  dimension_group: effective {
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
    sql: ${TABLE}.effective_time ;;
  }

  dimension: esrb_rating {
    hidden: yes
    sql: ${TABLE}.esrb_rating ;;
  }

  dimension_group: event {
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
    sql: ${TABLE}.event_time ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: event_uuid {
    type: string
    sql: ${TABLE}.event_uuid ;;
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
    type: number
    sql: ${TABLE}.height ;;
  }

  dimension: images {
    hidden: yes
    sql: ${TABLE}.images ;;
  }

  dimension: included_items {
    type: string
    sql: ${TABLE}.included_items ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.label ;;
  }

  dimension: length {
    type: number
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
    sql: ${TABLE}.number_of_songs ;;
  }

  dimension: operational_attributes {
    hidden: yes
    sql: ${TABLE}.operational_attributes ;;
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
    sql: ${TABLE}.original_release_date ;;
  }

  dimension: parental_advisory {
    type: yesno
    sql: ${TABLE}.parental_advisory ;;
  }

  dimension: parties {
    hidden: yes
    sql: ${TABLE}.parties ;;
  }

  dimension: plan_type {
    type: string
    sql: ${TABLE}.plan_type ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: primary_artists {
    type: string
    sql: ${TABLE}.primary_artists ;;
  }

  dimension: product_manuals {
    hidden: yes
    sql: ${TABLE}.product_manuals ;;
  }

  dimension: protection_type {
    type: string
    sql: ${TABLE}.protection_type ;;
  }

  dimension: publisher {
    type: string
    sql: ${TABLE}.publisher ;;
  }

  dimension: season_details {
    hidden: yes
    sql: ${TABLE}.season_details ;;
  }

  dimension: series {
    type: string
    sql: ${TABLE}.series ;;
  }

  dimension: sku_id {
    type: string
    sql: ${TABLE}.sku_id ;;
  }

  dimension: special_features {
    type: string
    sql: ${TABLE}.special_features ;;
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
    sql: ${TABLE}.sub_genres ;;
  }

  dimension: term_length {
    type: string
    sql: ${TABLE}.term_length ;;
  }

  dimension: type_info {
    hidden: yes
    sql: ${TABLE}.type_info ;;
  }

  dimension: upc {
    type: string
    sql: ${TABLE}.upc ;;
  }

  dimension: video_details {
    hidden: yes
    sql: ${TABLE}.video_details ;;
  }

  dimension: warranties {
    hidden: yes
    sql: ${TABLE}.warranties ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  dimension: width {
    type: number
    sql: ${TABLE}.width ;;
  }

  measure: count {
    type: count
    drill_fields: [carrier_name]
  }
}

view: magellan_product_copy__metadata {
  dimension: entity_id {
    type: string
    sql: ${TABLE}.entity_id ;;
  }

  dimension: pcm_source {
    type: string
    sql: ${TABLE}.pcm_source ;;
  }

  dimension: source_system {
    type: string
    sql: ${TABLE}.source_system ;;
  }
}

view: magellan_product_copy__descriptions {
  dimension: bullets {
    hidden: yes
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

  dimension: short_synopsis {
    type: string
    sql: ${TABLE}.short_synopsis ;;
  }
}

view: magellan_product_copy__descriptions__bullets {
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }
}

view: magellan_product_copy__specifications {
  dimension: definition {
    type: string
    sql: ${TABLE}.definition ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: raw_name {
    type: string
    sql: ${TABLE}.raw_name ;;
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

view: magellan_product_copy__features {
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

view: magellan_product_copy__links__self {
  dimension: href {
    type: string
    sql: ${TABLE}.href ;;
  }
}

view: magellan_product_copy__links__master {
  dimension: href {
    type: string
    sql: ${TABLE}.href ;;
  }
}

view: magellan_product_copy__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__operational_attributes {
  dimension: definition {
    type: string
    sql: ${TABLE}.definition ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: raw_name {
    type: string
    sql: ${TABLE}.raw_name ;;
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

view: magellan_product_copy__editorial_reviews {
  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }
}

view: magellan_product_copy__condition {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: sub_display {
    type: string
    sql: ${TABLE}.sub_display ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}

view: magellan_product_copy__warranties {
  dimension: labor {
    type: string
    sql: ${TABLE}.labor ;;
  }

  dimension: parts {
    type: string
    sql: ${TABLE}.parts ;;
  }
}

view: magellan_product_copy__meta {
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

view: magellan_product_copy__parties {
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

view: magellan_product_copy__parties__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__color {
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }
}

view: magellan_product_copy__discs {
  dimension: disc_number {
    type: number
    sql: ${TABLE}.disc_number ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: tracks {
    hidden: yes
    sql: ${TABLE}.tracks ;;
  }
}

view: magellan_product_copy__discs__tracks {
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

view: magellan_product_copy__discs__tracks__composers {
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

view: magellan_product_copy__discs__tracks__composers__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__discs__tracks__artists {
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

view: magellan_product_copy__discs__tracks__artists__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__manufacturer {
  dimension: model_number {
    type: string
    sql: ${TABLE}.model_number ;;
  }
}

view: magellan_product_copy__video_details {
  dimension: amg_movie_id {
    type: string
    sql: ${TABLE}.amg_movie_id ;;
  }

  dimension: amg_rating {
    hidden: yes
    sql: ${TABLE}.amg_rating ;;
  }

  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
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
    sql: ${TABLE}.countries_produced ;;
  }

  dimension: crew {
    hidden: yes
    sql: ${TABLE}.crew ;;
  }

  dimension: editorial_reviews {
    hidden: yes
    sql: ${TABLE}.editorial_reviews ;;
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
    sql: ${TABLE}.mpaa_rating ;;
  }

  dimension: related_titles {
    hidden: yes
    sql: ${TABLE}.related_titles ;;
  }

  dimension: sub_genres {
    type: string
    sql: ${TABLE}.sub_genres ;;
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
    sql: ${TABLE}.vendor_genres ;;
  }

  dimension: year_of_release {
    type: string
    sql: ${TABLE}.year_of_release ;;
  }
}

view: magellan_product_copy__video_details__related_titles {
  dimension: amg_movie_id {
    type: string
    sql: ${TABLE}.amg_movie_id ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
}

view: magellan_product_copy__video_details__editorial_reviews {
  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }
}

view: magellan_product_copy__video_details__crew {
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

view: magellan_product_copy__video_details__crew__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__video_details__cast {
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

view: magellan_product_copy__video_details__cast__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__video_details__amg_rating {
  dimension: range_maximum {
    type: number
    sql: ${TABLE}.range_maximum ;;
  }

  dimension: range_minimum {
    type: number
    sql: ${TABLE}.range_minimum ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
}

view: magellan_product_copy__video_details__awards {
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
    type: string
    sql: ${TABLE}.year ;;
  }
}

view: magellan_product_copy__video_details__mpaa_rating {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: flags {
    type: string
    sql: ${TABLE}.flags ;;
  }
}

view: magellan_product_copy__product_manuals {
  dimension: asset_description {
    type: string
    sql: ${TABLE}.asset_description ;;
  }

  dimension: asset_name {
    type: string
    sql: ${TABLE}.asset_name ;;
  }

  dimension: asset_url {
    type: string
    sql: ${TABLE}.asset_url ;;
  }

  dimension: document_type {
    type: string
    sql: ${TABLE}.document_type ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: vanity_name {
    type: string
    sql: ${TABLE}.vanity_name ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }
}

view: magellan_product_copy__season_details__cast {
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

view: magellan_product_copy__season_details__cast__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__season_details {
  dimension: amg_movie_id {
    type: string
    sql: ${TABLE}.amg_movie_id ;;
  }

  dimension: cast {
    hidden: yes
    sql: ${TABLE}.`cast` ;;
  }

  dimension: countries_produced {
    type: string
    sql: ${TABLE}.countries_produced ;;
  }

  dimension: crew {
    hidden: yes
    sql: ${TABLE}.crew ;;
  }

  dimension: episode_details {
    hidden: yes
    sql: ${TABLE}.episode_details ;;
  }

  dimension: genres {
    type: string
    sql: ${TABLE}.genres ;;
  }

  dimension: season_info {
    hidden: yes
    sql: ${TABLE}.season_info ;;
  }

  dimension: sub_genres {
    type: string
    sql: ${TABLE}.sub_genres ;;
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
    sql: ${TABLE}.tv_rating ;;
  }
}

view: magellan_product_copy__season_details__episode_details {
  dimension: episode_id {
    type: number
    sql: ${TABLE}.episode_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: year_of_release {
    type: string
    sql: ${TABLE}.year_of_release ;;
  }
}

view: magellan_product_copy__season_details__season_info {
  dimension: season_number {
    type: number
    sql: ${TABLE}.season_number ;;
  }

  dimension: season_start_year {
    type: string
    sql: ${TABLE}.season_start_year ;;
  }

  dimension: season_title {
    type: string
    sql: ${TABLE}.season_title ;;
  }
}

view: magellan_product_copy__season_details__crew {
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

view: magellan_product_copy__season_details__crew__images {
  dimension: height {
    type: string
    sql: ${TABLE}.height ;;
  }

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

  dimension: unit_of_measure {
    type: string
    sql: ${TABLE}.unit_of_measure ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }
}

view: magellan_product_copy__type_info {
  dimension: definition {
    type: string
    sql: ${TABLE}.definition ;;
  }

  dimension: item_type {
    hidden: yes
    sql: ${TABLE}.item_type ;;
  }

  dimension: meta_type {
    type: string
    sql: ${TABLE}.meta_type ;;
  }

  dimension: sub_type {
    type: string
    sql: ${TABLE}.sub_type ;;
  }
}

view: magellan_product_copy__type_info__item_type {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
}

view: magellan_product_copy__names {
  dimension: display {
    type: string
    sql: ${TABLE}.display ;;
  }

  dimension: raw_short {
    type: string
    sql: ${TABLE}.raw_short ;;
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

view: magellan_product_copy__esrb_rating {
  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: descriptors {
    type: string
    sql: ${TABLE}.descriptors ;;
  }
}

view: magellan_product_copy__awards {
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
    type: string
    sql: ${TABLE}.year ;;
  }
}

view: magellan_product_copy__links {
  dimension: master {
    hidden: yes
    sql: ${TABLE}.master ;;
  }

  dimension: self {
    hidden: yes
    sql: ${TABLE}.self ;;
  }
}
