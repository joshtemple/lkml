view: inntopia_event_property_f {
  sql_table_name: pedw.dev.inntopia_event_property_f ;;

  dimension:  property_key {
    sql: ${TABLE}.property_key ;;
    hidden:  yes
  }
  dimension:  ty_bt {
    sql: ${TABLE}.ty_bt ;;
    hidden:  yes
  }
  dimension:  ly_bt {
    sql: ${TABLE}.ly_bt ;;
    hidden:  yes
  }
  dimension:  EVENTID {
    sql: ${TABLE}.EVENTID ;;
    hidden:  yes
  }
  dimension: SOURCESYSTEMCODE  {
    sql: ${TABLE}.SOURCESYSTEMCODE ;;
    hidden: yes
  }
  dimension:  EVENTKEY {
    sql: ${TABLE}.EVENTKEY ;;
    hidden: yes
  }
  dimension:  CUSTOMERKEY {
    sql: ${TABLE}.CUSTOMERKEY ;;
    hidden:  yes
  }
  dimension:  FAMILYKEY {
    sql: ${TABLE}.FAMILYKEY ;;
    hidden: yes
  }
  dimension:  PURCHASEDATE_SID {
    sql: utl..udf_date_to_julian(${TABLE}.PURCHASEDATE) ;;
    hidden:  yes
  }
  dimension:  PURCHASELOCATIONDESCRIPTION {
    view_label: "Purchase"
    label: "Purchase Description"
    description: "Purchase Location Description"
    type: string
    sql: ${TABLE}.PURCHASELOCATIONDESCRIPTION ;;
  }
  dimension:  PURCHASELOCATIONTYPE {
    view_label: "Purchase"
    label: "Purchase Location Type"
    description: "Purchase Location Type"
    type: string
    sql: ${TABLE}.PURCHASELOCATIONTYPE ;;
  }
  dimension:  EVENTDATE_SID {
    sql: utl..udf_date_to_julian(${TABLE}.EVENTDATE) ;;
    hidden:  yes
  }
  dimension:  EVENTLOCATIONDESCRIPTION {
    view_label: "Event"
    label: "Event Location Description"
    description: "Event Location Description"
    type:  string
    sql: ${TABLE}.EVENTLOCATIONDESCRIPTION ;;
  }
  dimension:  EVENTLOCATIONTYPE {
    view_label: "Event"
    label: "Event Location Type"
    description: "Event Location Type"
    type:  string
    sql: ${TABLE}.EVENTLOCATIONTYPE ;;
  }
  dimension:  PRODUCTKEY {
    view_label: "Product"
    label: "Product Key"
    description: "Source System Product Key"
    type:  string
    sql: ${TABLE}.PRODUCTSOURCESYSTEMKEY ;;
  }
  dimension:  PRODUCTDESCRIPTION {
    view_label: "Product"
    label: "Product Description"
    description: "Product Description"
    type:  string
    sql: ${TABLE}.PRODUCTDESCRIPTION ;;
  }

  #----------------------------------------------------------------------
  #---measures---
  #----------------------------------------------------------------------

  dimension:  event_count {
    sql: ${EVENTID} ;;
    hidden:  yes
  }
  dimension:  EVENTAMOUNT {
    value_format_name: usd_0
    sql: ${TABLE}.EVENTAMOUNT ;;
    hidden:  yes
  }
  dimension:  QUANTITY {
    sql: ${TABLE}.QUANTITY ;;
    hidden: yes
  }
  dimension: customer_cnt  {
    hidden: yes
    sql: ${TABLE}.CUSTOMERKEY ;;
  }
  dimension:  customer_spend{
    value_format_name: usd_0
    sql: ${EVENTAMOUNT}/${customer_cnt} ;;
    hidden: yes
  }
  dimension:  customer_room_night{
    value_format_name: decimal_1
    sql: ${QUANTITY}/${customer_cnt} ;;
    hidden:  yes
  }
}
