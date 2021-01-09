view: inntopia_dimlodging {
  sql_table_name: PRAW_inntopia.dbo.dimlodging ;;

    dimension:  EVENTID {
      sql: ${TABLE}.EVENTID ;;
      hidden:  yes
    }

    dimension:  SOURCESYSTEMCODE  {
      sql: ${TABLE}.SOURCESYSTEMCODE ;;
    }

    dimension:  CUSTOMERKEY  {
      sql: ${TABLE}.CUSTOMERKEY ;;
      hidden:  yes
    }

    dimension:  FAMILYKEY  {
      sql: ${TABLE}.FAMILYKEY ;;
      hidden:  yes
    }

    dimension:  BOOKINGDATE_SID  {
      sql: utl..udf_date_to_julian(${TABLE}.BOOKINGDATE) ;;
      hidden: yes
    }

    dimension: CANCELLATIONDATE_SID {
      sql: utl..udf_date_to_julian(${TABLE}.CANCELLATIONDATE) ;;
      hidden: yes
    }

    dimension: ARRIVALDATE_SID {
      sql:utl..udf_date_to_julian(${TABLE}.ARRIVALDATE) ;;
      hidden:  yes
    }

    dimension: DEPARTUREDATE_SID {
      sql:utl..udf_date_to_julian(${TABLE}.DEPARTUREDATE) ;;
      hidden:  yes
    }


    dimension: SOURCEOFBUSINESSDESCRIPTION {
      sql: ${TABLE}.SOURCEOFBUSINESSDESCRIPTION;;
      label: "Source Channel Detail"
      view_label: "Reservation"
    }

    dimension: SOURCEOFBUSINESSGROUP {
      sql: ${TABLE}.SOURCEOFBUSINESSGROUP ;;
      label: "Source Channel Group"
      view_label: "Reservation"
    }

    dimension: RATEPLANDESCRIPTION {
      sql: ${TABLE}.RATEPLANDESCRIPTION ;;
      label: "Rate Code Description"
      view_label: "Reservation"
    }

    dimension: RATEPLANSOURCESYSTEMKEY {
      sql: ${TABLE}.RATEPLANSOURCESYSTEMKEY ;;
      label: "Rate Code"
      view_label: "Reservation"
    }

    dimension: CENREZID {
      sql: ${TABLE}.CENREZID ;;
      label: "Reservation ID"
      view_label: "Reservation"
    }

    dimension: MARKETSEGMENTDESCRIPTION {
      sql: ${TABLE}.MARKETSEGMENTDESCRIPTION ;;
      label: "Market Segment Detail"
      view_label: "Reservation"
    }

    dimension: AGENCYCONTACT {
      sql: ${TABLE}.AGENCYCONTACT ;;
      view_label: "Reservation"
      label: "Agency Contact"
    }

    dimension: AGENCYLOCATION {
      sql: ${TABLE}.AGENCYLOCATION ;;
      view_label: "Reservation"
      label: "Agency Location"
    }

    dimension: AGENCYNAME {
      sql: ${TABLE}.AGENCYNAME ;;
      view_label: "Reservation"
      label: "Agency Name"
    }

    dimension: GROUPCODE {
      sql: ${TABLE}.GROUPCODE ;;
      view_label: "Reservation"
      label: "Group Code"
    }

    dimension: GROUPLOCATION {
      sql: ${TABLE}.GROUPLOCATION ;;
      view_label: "Reservation"
      label: "Group Location"
    }

    dimension: GROUPNAME {
      sql: ${TABLE}.GROUPNAME ;;
      view_label: "Reservation"
      label: "Group Name"
    }

    dimension: LEVEL {
      sql: ${TABLE}.LEVEL ;;
      view_label: "Reservation"
      label: "Reservation Status"
    }

    dimension: ROOMNUMBER {
      sql: ${TABLE}.ROOMNUMBER ;;
      view_label: "Reservation"
    }

    dimension: UNITTYPE {
      sql: ${TABLE}.UNITTYPE ;;
      view_label: "Reservation"
      label: "Room Type"
    }

    dimension: UNITTYPEDESCRIPTION {
      sql: ${TABLE}.UNITTYPEDESCRIPTION ;;
      view_label: "Reservation"
      label: "Room Type Description"
    }

    dimension: HOTELID {
      sql: ${TABLE}.HOTELID ;;
      hidden:  yes
    }

    dimension: PRICEBASISDESCRIPTION {
      sql: ${TABLE}.PRICEBASISDESCRIPTION ;;
      view_label: "Reservation"
      label: "Rate Code Charged Descripton"
    }

  dimension: PRICEBASIS {
    sql: ${TABLE}.PRICEBASIS ;;
    view_label: "Reservation"
    label: "Rate Code Charged"
  }


    dimension: REPORTMARKETSEGMENT {
      sql: ${TABLE}.REPORTMARKETSEGMENT ;;
      label: "Market Segment Group"
      view_label: "Reservation"
    }

    dimension: lead_time_tier{
      type: tier
      tiers: [0, 5, 10, 40, 50, 70, 100]
      sql: ${TABLE}.LEADTIME ;;
      label: "Lead Time Tier"
      view_label: "Reservation"
    }

#-----------------------------------------------------------------------------
#-- measures
#-----------------------------------------------------------------------------


    measure: DISCOUNT {
      label: "Discount"
      description: "Discount"
      view_label: "  Measures"
      type: sum
      sql: ${TABLE}.DISCOUNT ;;
    }

    measure: FEES {
      label: "Fees"
      description: "Lodging Fees"
      view_label: "  Measures"
      type: sum
      sql: ${TABLE}.FEES ;;
    }

    measure:  ADULTINPARTY  {
      label: "Num of Adults"
      description: "Number of Adults in party"
      view_label: "  Measures"
      type: sum
      sql: ${TABLE}.ADULTINPARTY ;;
    }

    measure:  CHILDRENINPARTY  {
      label: "Num of Children"
      description: "Number of Children in party"
      view_label: "  Measures"
      type: sum
      sql: ${TABLE}.CHILDRENINPARTY ;;
    }

    measure:  ADR {
      label: "ADR"
      description: "Average Daily Rate"
      view_label: "  Measures"
      type: average
      sql: ${TABLE}.AVGDAILYRATE;;
      value_format_name: usd_0
    }

    measure:  LODGINGNIGHTS  {
      label: "Rms Bkd"
      description: "Room Nights Actual + OTB"
      type: sum
      sql: ${TABLE}.LODGINGNIGHTS ;;
    }

    measure:  LODGINGREV{
      label: "Rev/Rm Rev"
      description: "Total Room Revenue"
      value_format_name: usd_0
      type: sum
      sql: ${TABLE}.LODGINGNIGHTS*${TABLE}.AVGDAILYRATE ;;
    }

    measure:  LODGINGAMOUNT{
      label: "Rev/TRev"
      description: "Total Portfolio Revenue"
      value_format_name: usd_0
      type: sum
      sql: ${TABLE}.LODGINGAMOUNT ;;
    }

    measure: customer_cnt  {
      hidden: yes
      type: count_distinct
      sql: ${TABLE}.CUSTOMERKEY ;;
      }

    measure:  customer_spend{
      label: "Rev/Customer"
      description: "Total Revenue Spent/Customer"
      value_format_name: usd_0
      sql: ${LODGINGAMOUNT}/${customer_cnt} ;;
    }

    measure:  customer_room_spend{
      label: "RmRev/Customer"
      description: "Room Revenue Spent/Customer"
      value_format_name: usd_0
      sql: ${LODGINGREV}/${customer_cnt} ;;
    }

    measure:  customer_room_night{
      label: "Rm Bkd/Customer"
      description: "Room Booked/Customer"
      value_format_name: decimal_1
      sql: ${LODGINGNIGHTS}/${customer_cnt} ;;
    }

  }
