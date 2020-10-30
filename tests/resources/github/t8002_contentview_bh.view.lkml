view: contentview_bh {
  sql_table_name: public.t8002_contentview_beehive ;;

  dimension: view_type {
    description: "PAGEVIEW or VIDEOVIEW"
    alias: [action]
    type: string
    sql: ${TABLE}.c8002_action ;;
  }

  dimension: adid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_adid ;;
  }

  dimension: app_version {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_app_version ;;
  }

  dimension: artid {
    type: string
    sql: ${TABLE}.c8002_artid ;;
  }

  dimension: author {
    type: string
    sql: ${TABLE}.c8002_auth ;;
  }

  dimension: auto_play {
    type: string
    sql: ${TABLE}.c8002_auto ;;
  }

  dimension: battery {
    view_label: "2. User"
    type: number
    sql: ${TABLE}.c8002_battery ;;
  }

  dimension: beacon_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_beacon_id ;;
  }

  dimension: beacon_loc {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_beacon_loc ;;
  }

  dimension: bluetooth {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_bluetooth ;;
  }

  dimension: user_browser {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_br ;;
  }

  #   - dimension: bv
  #     type: string
  #     sql: ${TABLE}.c8002_bv

  dimension: category {
    type: string
    sql: ${TABLE}.c8002_category ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.c8002_channel ;;
  }

  dimension: cid {
    #    hidden: true
    type: string
    sql: ${TABLE}.c8002_cid ;;
  }

  dimension: city {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_city ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.c8002_content ;;
  }

  dimension: country {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_country ;;
  }

  dimension: county {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_county ;;
  }

  dimension_group: view {
    group_label: "view date"
    type: time
    timeframes: [
      time,
      date,
      day_of_week,
      day_of_week_index,
      week,
      month,
      year,
      hour_of_day
    ]
    convert_tz: no
    sql: ${TABLE}.c8002_datetime ;;
  }

  dimension: view_date_d {
    group_label: "view date"
    sql: TO_DATE(${TABLE}.c8002_datetime) ;;
  }

  dimension: view_weekday {
    sql:
      CASE
         when ${view_day_of_week_index} = 6 then 'Weekend'
         when ${view_day_of_week_index} = 0 then 'Weekday'
         when ${view_day_of_week_index} = 1 then 'Weekday'
         when ${view_day_of_week_index} = 2 then 'Weekday'
         when ${view_day_of_week_index} = 3 then 'Weekday'
         when ${view_day_of_week_index} = 4 then 'Weekday'
         when ${view_day_of_week_index} = 5 then 'Weekend'
      END ;;
  }



  dimension: dcc_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_dcc_id ;;
  }

  dimension: depth {
    type: number
    sql: ${TABLE}.c8002_depth ;;
  }

  dimension: user_device {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_device ;;
  }

  dimension: device_id {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_did ;;
  }

  dimension: district_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_district_id ;;
  }

  dimension: dma {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_dma ;;
  }

  dimension: edm {
    type: string
    sql: ${TABLE}.c8002_edm ;;
  }

  #   - dimension: gaid
  #     view_label: User
  #     type: string
  #     sql: ${TABLE}.c8002_gaid

  #   - dimension: gigyaid
  #     view_label: User
  #     type: string
  #     sql: ${TABLE}.c8002_gigyaid

  dimension: ip {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_ip ;;
  }

  dimension: issueid {
    type: string
    sql: ${TABLE}.c8002_issueid ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.c8002_keyword ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.c8002_language ;;
  }

  dimension: lat {
    hidden: yes
    view_label: "3. Location"
    type: number
    sql: ${TABLE}.c8002_lat ;;
  }

  dimension: lon {
    hidden: yes
    view_label: "3. Location"
    type: number
    sql: ${TABLE}.c8002_lon ;;
  }

  dimension: limit_ad_track {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_limit_ad_track ;;
  }

  dimension: menu {
    type: string
    sql: ${TABLE}.c8002_menu ;;
  }

  dimension: news {
    type: string
    sql: ${TABLE}.c8002_news ;;
  }

  #   - dimension: ngsid
  #     type: string
  #     sql: ${TABLE}.c8002_ngsid
  #
  #   - dimension: nudid
  #     type: string
  #     sql: ${TABLE}.c8002_nudid

  dimension: nxtu {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_nxtu ;;
  }

  dimension: user_id {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_nxtu_or_did ;;
  }

  dimension: platform {
    #    view_label: User
    type: string
    sql: ${TABLE}.c8002_platform ;;
  }

  dimension: postcode {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_postcode ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.c8002_product ;;
  }

  dimension: referring_url {
    #    view_label: User
    alias: [ref_url]
    type: string
    sql: ${TABLE}.c8002_ref_url ;;
  }

  dimension: region {
    #    view_label: Location
    type: string
    sql: ${TABLE}.c8002_region ;;
  }

  dimension: section {
    type: string
    sql: ${TABLE}.c8002_section ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.c8002_source ;;
  }

  dimension: site {
    type: string
    sql: ${TABLE}.c8002_site ;;
  }

  dimension: state {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_state ;;
  }

  dimension: street_id {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_street_id ;;
  }

  dimension: subsection {
    type: string
    sql: ${TABLE}.c8002_subsection ;;
  }

  #  - dimension: subsubsection
  #    type: string
  #    sql: ${TABLE}.c8002_subsubsection

  #   - dimension: sz
  #     type: string
  #     sql: ${TABLE}.c8002_sz

  dimension: title {
    type: string
    sql: ${TABLE}.c8002_title ;;
  }

  dimension: user_agent {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_ua ;;
  }

  dimension: view_duration {
    alias: [video_duration]
    type: number
    sql: ${TABLE}.c8002_view_duration ;;
  }

  dimension: wifi {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_wifi ;;
  }

  dimension: abt {
    type: string
    sql: ${TABLE}.c8002_abt ;;
  }

  dimension: omo_accid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_omo_accid ;;
  }

  dimension: omo_pid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_omo_pid ;;
  }

  dimension: OS {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_os ;;
  }

  dimension: fbid {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_fbid ;;
  }

  dimension: ads {
    view_label: "2. User"
    type: string
    sql: ${TABLE}.c8002_ads ;;
  }

  dimension: village {
    view_label: "3. Location"
    type: string
    sql: ${TABLE}.c8002_village ;;
  }

  dimension: content_preference {
    type: string
    sql: content_preference (${category},${keyword}) ;;
  }

  dimension: referral_type {
    type:  string
    sql:
    case
when upper(${TABLE}.c8002_ref_url) like '%GOOGLE%' THEN 'GOOGLE'
when upper(${TABLE}.c8002_ref_url) like '%FACEBOOK%' THEN 'FACEBOOK'
when upper(${TABLE}.c8002_ref_url) like '%APPLEDAILY.COM%' or
upper(${TABLE}.c8002_ref_url) like '%NEXTMEDIA%' or
upper(${TABLE}.c8002_ref_url) like '%SHARPDAILY%' or
upper(${TABLE}.c8002_ref_url) like '%APPLELIVE.COM.TW%' or
upper(${TABLE}.c8002_ref_url) like '%NEXTDIGITAL.COM%'
THEN 'INTERNAL'
when upper(${TABLE}.c8002_ref_url) like '%YAHOO%' THEN 'YAHOO'
ELSE 'Others'
END
;;
  }

#  dimension: content_preference {
#     type: string
#     sql: case
#     when ${category} in ('ENTERTAINMENT', 'CELEB') or contains (${keyword}, '娛樂')
#     then 'ENTERTAINMENT'
#     when ${category} = 'KOREAPOP' or contains (${keyword},'韓流')
#     then 'KOREAPOP'
#     when ${category} in ('FASHION', 'LUXURY')  or contains (${keyword},'時尚')
#     then 'FASHION'
#     when ${category} = 'WATCH' or contains (${keyword},'手錶')
#     then 'WATCH'
#     when ${category} = 'BEAUTY' or contains (${keyword},'美容') or contains (${keyword}, '美妝')
#     then 'BEAUTY'
#     when contains (${keyword},'身體美容') or contains (${keyword}, '瘦身')
#     then 'SLIMMING'
#     when ${category} = 'HEALTH' or contains (${keyword},'健康')
#     then 'HEALTH'
#     when contains (${keyword},'跑步')
#    then 'RUN'
#    when ${category} = 'FOOD' or contains (${keyword},'飲食')
#    then 'FOOD'
#    when contains (${keyword},'烹飪')
#    then 'COOKING'
#    when ${category} = 'WINE' or contains (${keyword},'品酒')
#    then 'WINE'
#    when ${category} = 'TRAVEL'  or contains (${keyword},'旅遊')
#    then 'TRAVEL'
#    when ${category} in ('TECH','GADGETS','3C') or contains (${keyword},'科技')
#    then 'TECH'
#    when contains (${keyword},'攝影')
#    then 'PHOTOGRAPHY'
#    when ${category} in ('GAMENEWS','GAMEFILE','GAMEGIRL','GAMEPROGRAM') or contains (${keyword}, '電玩')
#    then 'GAME'
#    when contains (${keyword},'健康')
#    then 'ANIMATION'
#    when ${category} = 'AUTO' or contains (${keyword},'車迷') or contains (${keyword},'汽車')
#    then 'AUTO'
#    when ${category} = 'FAMILY' or contains (${keyword},'親子')
#    then 'FAMILY'
#    when ${category} = 'NEWPARENT' or contains (${keyword}, '新手父母')
#    then 'NEWPARENT'
#    when ${category} = 'WEDDING' or contains (${keyword},'新婚')
#    then 'WEDDING'
#    when ${category} = 'HOME'  or contains (${keyword},'家居') or contains (${keyword},'家居裝潢')
#    then 'HOME'
#    when ${category} = 'PET' or contains (${keyword},'寵物') or contains (${keyword},'動物')
#    then 'PET'
#    when ${category} in ('CULTURE','ART') or contains (${keyword},'文藝')
#    then 'CULTURE'
#    when contains (${keyword},'本地活動') or contains (${keyword}, '大型活動')
#    then 'LOCALEVENT'
#    when ${category} = 'MOVIE' or contains (${keyword},'電影')
#    then 'MOVIE'
#    when ${category} = 'CHARITY' or contains (${keyword},'NGO')
#    then 'NGO'
#    when ${category} = 'GREEN' or contains (${keyword},'環保')
#    then 'GREEN'
#    when ${category} = 'CAMPUS' or contains (${keyword},'教育') or contains (${keyword},'補教')
#    then 'EDUCATION'
#    when contains (${keyword},'工作假期') or contains (${keyword},'打工渡假')
#    then 'WORKINGHOLIDAY'
#    when ${category} = 'CAREER'  or contains (${keyword},'職場')
#    then 'CAREER'
#    when ${category} = 'SPORTS'  or contains (${keyword},'運動')
#    then 'SPORTS'
#    when ${category} = 'SOCCER' or contains (${keyword},'足球') or contains (${keyword},'世足賽')
#    then 'SOCCER'
#    when contains (${keyword}, '英超')
#    then 'EPL'
#    when ${category} = 'HORSERACE' or contains (${keyword},'賽馬')
#    then 'HORSERACE'
#    when ${category} = 'BUSINESS' or contains (${keyword},'商人') or contains (${keyword},'創業家')
#    then 'BUSINESS'
#    when ${category} = 'INTERNATIONAL'
#    then 'INTERNATIONAL'
#    when ${category} = 'PRCTWNEWS'
#    then 'PRCTWNEWS'
#    when ${category} = 'FINANCE' or contains (${keyword},'投資')
#    then 'INVESTMENT'
#    when contains (${keyword},'海外投資')
#    then 'OVERSEASINVEST'
#    when ${category} = 'REALESTATE'  or contains (${keyword},'置業')  or contains (${keyword},'房產')
#    then 'REALESTATE'
#    when contains (${keyword},'貸款按揭')
#    then 'LOAN'
#    when contains (${keyword},'保險')
#    then 'INSURANCE'
#    when contains (${keyword}, '稅務')
#    then 'TAX'
#    when contains (${keyword},'移民')
#    then 'MOVINGABROAD'
#    when ${category} = 'POLITICS' or contains (${keyword},'選舉')
#    then 'POLITICS'
#    when ${category} in ('ADULT','DIVA') or contains (${keyword},'風月')
#    then 'ADULT'
#    when ${category} = 'MEN'  or contains (${keyword},'男潮')  or contains (${keyword},'潮男')
#    then 'MEN'
#    when ${category} = 'RELATIONSHIP' or contains (${keyword},'男女關係') or contains (${keyword},'兩性')
#    then 'RELATIONSHIP'
#    when ${category} in ('FUN','HUMOR','WEIRD','STRANGE','ANIMAL') or contains (${keyword},'趣聞')
#    then 'FUN'
#    when ${category} = 'HOROSCOPE' or contains (${keyword}, '玄學') or contains (${keyword}, '星座運勢')
#    then 'HOROSCOPE'
#    when contains (${keyword},'彩券') or contains (${keyword},'彩券')
#    then 'LOTTERY'
#    when contains (${keyword},'手機')
#    then 'PHONE'
#    when contains (${keyword},'大賣場') or contains (${keyword},'消費') or contains (${keyword},'行動消費')
#    then 'SHOPPING'
#    when contains (${keyword},'奧運')
#    then 'OLYMPICS'
#    else 'unknown'
#    end ;;
# }

  dimension: latitude_longitude {
    alias: [view_location]
    view_label: "3. Location"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${lon} ;;
  }

  measure: count {
    type: count
#    approximate: yes
    drill_fields: []
  }

  measure: total_page_views {
    type: count
    filters: {
      field: view_type
      value: "PAGEVIEW"
    }
  }

  measure: total_video_views {
    type: count
    filters: {
      field: view_type
      value: "VIDEOVIEW"
    }
  }

  measure: average_video_duration {
    alias: [average_duration]
    type: average
    sql: ${view_duration} ;;
    filters: {
      field: view_type
      value: "VIDEOVIEW"
    }
  }

  measure: average_page_duration {
    type: average
    sql: ${view_duration} ;;
    filters: {
      field: view_type
      value: "PAGEVIEW"
    }
  }

  measure: sum_video_duration {
    type: sum
    sql: ${view_duration} ;;
    filters: {
      field: view_type
      value: "VIDEOVIEW"
    }
  }

  measure: sum_page_duration {
    type: sum
    sql: ${view_duration} ;;
    filters: {
      field: view_type
      value: "PAGEVIEW"
    }
  }

  measure: distinct_users {
    view_label: "2. User"
    type: count_distinct
    value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${user_id} ;;
#    approximate: yes
  }

  measure: distinct_content {
    type: count_distinct
    value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${cid} ;;
#    approximate: yes
  }
}
