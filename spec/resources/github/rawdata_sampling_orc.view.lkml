view: rawdata_sampling_orc {

  derived_table: {
    sql:
    SELECT *
    FROM hive.spotad.rawdata_sampling_orc
     WHERE
      day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)
    ;;
    }
  suggestions: no


  parameter: number_days_to_analyse {
    view_label: ""
    type: number
    default_value: "1"
    allowed_value: {
      label: "Yesterday"
      value: "1"
    }
    allowed_value: {
      label: "Last 7 Days"
      value: "7"
    }

    label: "Date Range"
    hidden: yes
  }




  dimension: ad_context {
    hidden: yes
    type: string
    sql: ${TABLE}.ad_context ;;
  }

  dimension: ad_type {
    view_label: "Creative"
    type: string
    sql: COALESCE(${TABLE}.ad_type,'Other') ;;
  }

  dimension: adx {
    hidden: yes
    type: string
    sql: ${TABLE}.adx ;;
  }

  dimension: adx_feedback {
    hidden: yes
    type: string
    sql: ${TABLE}.adx_feedback ;;
  }

  dimension: app {
    hidden: yes
    type: string
    sql: ${TABLE}.app ;;
  }
  dimension: app_bundle {
    view_label: "App"
    type: string
    sql: COALESCE(${TABLE}.app.bundle,'Other') ;;
  }

  dimension: app_name {
    view_label: "App"
    type: string
    sql: COALESCE(${TABLE}.app.app.name,'Other') ;;
  }

  dimension: app_id {
    view_label: "App"
    type: string
    sql: COALESCE(${TABLE}.app.app.id,'Other') ;;
  }

  dimension: app_appcategories {
    view_label: "App"
    label: "App Categories"
    type: string
    sql: ${TABLE}.app.appcategories;;
  }

  dimension: auction_type {
    hidden: yes
    type: number
    sql: ${TABLE}.auction_type ;;
  }

  dimension: auctionid {
    hidden: yes
    type: string
    sql: ${TABLE}.auctionid ;;
  }



  dimension: bid_floor {
    hidden: yes
    type: number
    sql: ${TABLE}.bid_floor ;;
  }



  dimension: bidprice {
    hidden: yes
    type: number
    sql: ${TABLE}.bidprice ;;
  }

  dimension: blocked_categories {
    view_label: "General"
    type: string
    sql:
    CASE WHEN ${TABLE}.blocked_categories is not null
    AND array_join(${TABLE}.blocked_categories,',') <> ''
    then array_join(${TABLE}.blocked_categories,',')
    else 'Other'
    end;;
  }

  dimension: browser {
    view_label: "Device"
    type: string
    sql: COALESCE(${TABLE}.browser,'Other') ;;
  }



  dimension: cookie_id {
    hidden: yes
    type: string
    sql: ${TABLE}.cookie_id ;;
  }


  dimension: currency {
    view_label: "Other"
    hidden: yes
    type: string
    sql: COALESCE(${TABLE}.currency,'Other') ;;
  }



  dimension: datacenter {
    view_label: "Other"
    type: string
    sql: COALESCE(${TABLE}.datacenter,'Other') ;;
  }

  dimension: day_ts {
    hidden: yes
    type: number
    sql: ${TABLE}.day_ts ;;
  }

  dimension: deals {
    view_label: "Other"
    label: "PMP_ID"
    type: string
    sql: if(${TABLE}.deals is not null,if(${TABLE}.deals[1].id is not null,${TABLE}.deals[1].id,'Other'),'Other') ;;
  }

  dimension: device {
    hidden: yes
    type: string
    sql: ${TABLE}.device ;;
  }
  dimension: carrier {
    view_label: "Device"
    type: string
    sql:  COALESCE(${TABLE}.device.carrier.description,'Other')
     ;;
  }

  dimension: connection_type {
    view_label: "Device"
    type: string
    case: {
      when : {
        sql: ${TABLE}.device.connectiontype.id in (3,4,5,6) ;;
        label: "Carrier"
      }
      when : {
        sql: ${TABLE}.device.connectiontype.id in (0,1,2) ;;
        label: "WiFi"
      }
      else: "Other"
      }

  }

  dimension: os {
    view_label: "Device"
    label: "Device OS"
    type: string
    sql: COALESCE(${TABLE}.device.os,'Other') ;;
  }

  dimension: osv {
    view_label: "Device"
    label: "Device OS Version"
    type: string
    sql:COALESCE(${TABLE}.device.osv,'Other') ;;
  }

  dimension: make {
    view_label: "Device"
    label: "Device Make"
    type: string
    sql: COALESCE(${TABLE}.device.make,'Other') ;;
  }

  dimension: model {
    view_label: "Device"
    label: "Device Model"
    type: string
    sql: COALESCE(${TABLE}.device.model,'Other') ;;
  }

  dimension: IP {
    view_label: "Device"
    label: "Device IP"
    type: string
    sql: COALESCE(${TABLE}.device.ip,'Other') ;;
  }


  dimension: device_type {
    view_label: "Device"
    label: "Device Type"
    type: string
    case: {
      when: {
        sql: ${TABLE}.device_type=1 ;;
        label: "Mobile"
      }
      when: {
        sql: ${TABLE}.device_type=2 ;;
        label: "Desktop"
      }
      when: {
        sql: ${TABLE}.device_type=3 ;;
        label: "CTV"
      }
      when: {
        sql: ${TABLE}.device_type=4 ;;
        label: "Mobile Phone"
      }
      when: {
        sql: ${TABLE}.device_type=5 ;;
        label: "Mobile Tablet"
      }
      when: {
        sql: ${TABLE}.device_type is null and ${TABLE}.exchange2 = 'mopub' and ${TABLE}.device.os='Android' ;;
        label: "Mobile"
      }
      else: "Other"
    }

  }

  dimension: domain_category {
    hidden: yes
    type: string
    sql: ${TABLE}.domain_category ;;
  }

  dimension: dt {
    hidden: yes
    type: string
    sql: ${TABLE}.dt ;;
  }



  dimension: exchange2 {
    view_label: "General"
    label: "Exchange"
    type: string
    case: {
      when: {
        sql: ${TABLE}.exchange2 = 'omax' ;;
        label: "Adcolony"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'adx' ;;
        label: "Google"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'applovin' ;;
        label: "Applovin"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'inmobi' ;;
        label: "InMobi"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'baidu' ;;
        label: "Baidu"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'fyber' ;;
        label: "Fyber"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'mopub' ;;
        label: "Mopub"
      }
     # when: {
       # sql: ${TABLE}.exchange2 = 'pubmatic' ;;
       # label: "Pubmatic"
      #}
      when: {
        sql: ${TABLE}.exchange2 = 'rubicon' ;;
        label: "Rubicon"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'smaato' ;;
        label: "Smaato"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'smaato_cn' ;;
        label: "Smaato_cn"
      }
      when: {
        sql: ${TABLE}.exchange2 = 'tencent' ;;
        label: "Tencent"
      }

      else: "Other"

    }

    #sql: ${TABLE}.exchange2 ;;

  }

  dimension: exchange_creative_type {
    view_label: "Other"
    label: "Allowed Serving - Baidu"
    type: string
    case: {
      when: {
        sql: ${TABLE}.exchange_creative_type=1 ;;
        label: "Baidu Srerving Only"
      }
      when: {
        sql: ${TABLE}.exchange_creative_type=2 ;;
        label: "Non-Baidu Srerving Only"
      }
      when: {
        sql: ${TABLE}.exchange_creative_type=3 ;;
        label: "All Srerving Types"
      }
      else: "Other"
    }


  }



  dimension: geo {
    hidden: yes
    type: string
    sql: ${TABLE}.geo ;;
  }

  dimension: country {
    view_label: "General"
    group_label: "Location"
    type: string
    map_layer_name: countries
    drill_fields: [state,city]
    sql:
          CASE
                WHEN ${TABLE}.geo.country LIKE ('%America%') THEN 'United States'
                WHEN ${TABLE}.geo.country LIKE ('%Korea%') THEN 'South Korea'
                WHEN ${TABLE}.geo.country LIKE ('%Bahamas%') THEN 'Bahamas'
                WHEN ${TABLE}.geo.country LIKE ('%Gambia%') THEN 'Gambia'
                WHEN ${TABLE}.geo.country LIKE ('%Virgin Islands, British%') THEN 'British Virgin Islands'
                WHEN ${TABLE}.geo.country LIKE ('%Virgin Islands, U%') THEN 'U.S. Virgin Islands'
                WHEN ${TABLE}.geo.country LIKE ('%Bolivia, Pl%') THEN 'Bolivia'

                ELSE COALESCE(${TABLE}.geo.country,'Other')
              END

                ;;
  }

  dimension: state {
    view_label: "General"
    group_label: "Location"
    type: string
    sql: COALESCE(${TABLE}.geo.state,'Other') ;;
    drill_fields: [city]
  }

  dimension: city {
    view_label: "General"
    group_label: "Location"
    type: string
    sql: COALESCE(${TABLE}.geo.city,'Other') ;;
  }

  dimension: historical_ctr {
    hidden: yes
    type: number
    sql: ${TABLE}.historical_ctr ;;
  }

  dimension: hour_ts {
    view_label: "General"
    label: "Hour"
    type: number
    sql: ${TABLE}.hour_ts ;;
  }

  dimension: ibv_allowed {
    view_label: "Creative"
    label: "IBV allowed on banner Ad Type"
    type: string
    sql:
    case
    when ${TABLE}.ibv_allowed=1 then 'IBV allowed'
    when ${TABLE}.ibv_allowed=0 then 'IBV not allowed'
    else 'Other'
    end;;
  }

  dimension: imei {
    hidden: yes
    type: string
    sql: ${TABLE}.imei ;;
  }

  dimension: imei_list {
    hidden: yes
    type: string
    sql: ${TABLE}.imei_list ;;
  }

  dimension: impression {
    hidden: yes
    type: string
    sql: ${TABLE}.impression ;;
  }

  dimension: ad_slot_size {
    view_label: "Creative"
    type: string
    sql:
    CASE WHEN ${TABLE}.impression.formats is not null
    AND array_join(${TABLE}.impression.formats,',') <> ''
    then array_join(${TABLE}.impression.formats,',')
    else 'Other'
    end;;
  }

  dimension: inventory_type {
    view_label: "General"
    type: string
    case: {
      when: {sql: ${TABLE}.device_type=2 ;;
        label: "Desktop"}
      when: {sql: ${TABLE}.device_type=3 ;;
        label: "CTV"}
      when: {sql: ${TABLE}.device_type not in (2,3) and ${TABLE}.inventory_type='app';;
        label: "In-App"}
      when: {sql: ${TABLE}.device_type not in (2,3) and ${TABLE}.inventory_type='site';;
        label: "Mweb"}
      else: "Other"
    }

  }

  dimension: media_metrics {
    hidden: yes
    type: string
    sql: ${TABLE}.media_metrics ;;
  }

  dimension: model_flavor {
    hidden: yes
    type: string
    sql: ${TABLE}.model_flavor ;;
  }

  dimension: model_predict {
    hidden: yes
    type: number
    sql: ${TABLE}.model_predict ;;
  }

  dimension: model_timestamp {
    hidden: yes
    type: string
    sql: ${TABLE}.model_timestamp ;;
  }

  dimension: opt {
    hidden: yes
    type: string
    sql: ${TABLE}.opt ;;
  }

  dimension: opt_strategies {
    hidden: yes
    type: string
    sql: ${TABLE}.opt_strategies ;;
  }



  dimension: publisher_placement_id {
    hidden: yes
    type: string
    sql: ${TABLE}.publisher_placement_id ;;
  }

  dimension: publisherid_external {
    view_label: "General"
    label: "Publisher Exchange ID"
    type: string
    sql:
    case
    when ${TABLE}.publisherid_external is not null then array_join(${TABLE}.publisherid_external,',')
    else 'Other'
    end;;
  }

  dimension: rate {
    view_label: "Other"
    label: "Currency Exchange Rate"
    hidden: yes
    type: number
    sql: ${TABLE}.rate ;;
  }

  dimension: rewarded_video {
    view_label: "Creative"
    type: string
    sql:
    case
    when ${TABLE}.rewarded_video=1 then 'Rewarded Video'
    when ${TABLE}.rewarded_video=0 then 'Non-Rewarded Video'
    else 'Other'
    end;;
  }

  dimension: sampling {
    hidden: yes
    type: number
    sql: ${TABLE}.sampling ;;
  }

  dimension: site {
    hidden: yes
    type: string
    sql: ${TABLE}.site ;;
  }
  dimension: site_domain {
    view_label: "Site"
    label: "Domain"
    type: string
    sql:
    if(${TABLE}.site.name is null,'Other',CASE
    WHEN ${TABLE}.site.name like '%http%' then regexp_extract(site.name,'(http|https)://([^/]*)',2)
    else regexp_extract(site.name,'([^/]*)',1)
    end);;

  }

  dimension: site_categories {
    view_label: "Site"
    hidden: yes
    type: string
    sql: case when ${TABLE}.site.sitecategories is not null
    and array_join(${TABLE}.site.sitecategories,',','Other')<>''
    then array_join(${TABLE}.site.sitecategories,',','Other')
    else 'Other'
    end;;
  }

  dimension: app_site_domain {
    view_label: "General"
    label: "App/Site Domain"
    type: string
    sql:
    CASE
    WHEN ${TABLE}.inventory_type='app' THEN  ${TABLE}.app.bundle
    WHEN ${TABLE}.site.name like '%http%' THEN regexp_extract(site.name,'(http|https)://([^/]*)',2)
    WHEN ${TABLE}.site.name is not null THEN regexp_extract(site.name,'([^/]*)',1)
    ELSE 'Other'
    end;;

    }

  dimension: app_site_categories {
    view_label: "General"
    hidden: yes
    label: "App/Site Categories"
    type: string
    sql:
    if( ${TABLE}.inventory_type='app', ${TABLE}.app.appcategories,
   ${TABLE}.site.sitecategories);;

    }
  dimension: spotad_id {
    hidden: yes
    type: string
    sql: ${TABLE}.spotad_id ;;
  }

  dimension: timestamp1 {
    hidden: yes
    type: string
    sql: ${TABLE}.timestamp1 ;;
  }

  dimension: timezone_offset {
    hidden: yes
    type: number
    sql: ${TABLE}.timezone_offset ;;
  }

  dimension: user_category {
    hidden: yes
    type: string
    sql: ${TABLE}.user_category ;;
  }

  dimension: user_metrics {
    hidden: yes
    type: string
    sql: ${TABLE}.user_metrics ;;
  }

  dimension: user_profile_users_lists {
    hidden: yes
    type: string
    sql: ${TABLE}.user_profile_users_lists ;;
  }

  dimension: userid {
    hidden: yes
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: site_vertical {
    view_label: "Site"
    type: string
    sql: coalesce ( ${TABLE}.vertical,'Other') ;;
  }

  dimension: site_parent_vertical {
    view_label: "Site"
    type: string
    sql: coalesce (${TABLE}.vertical_parent,'Other') ;;
  }



  dimension: virtual_bids {
    hidden: yes
    type: string
    sql: ${TABLE}.virtual_bids ;;
  }


  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
  measure: requests {
    view_label: "General"
    type: number
    sql:  ${count}*200 ;;
  }
  measure: bid_floor_avg {
  view_label: "General"
  label: "Bid Floor AVG"
    type: average
    sql: ${bid_floor} ;;
  }
  dimension: pmp_count {
   hidden: yes
    type: number
    sql: if(${TABLE}.deals is not null,if(${TABLE}.deals[1].id is not null,1,0),0) ;;
  }

  measure: pmp_deals {
    view_label: "General"
    label: "PMP"
    type: sum
    sql: ${pmp_count}*200 ;;
  }
}
