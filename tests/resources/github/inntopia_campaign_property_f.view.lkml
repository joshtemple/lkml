view: inntopia_campaign_property_f {
  sql_table_name: pedw.dev.inntopia_campaign_property_f ;;

  dimension:  dimcampaignid {
    sql: ${TABLE}.dimcampaignid ;;
    hidden: yes
  }
  dimension:  CUSTOMERKEY {
    sql: ${TABLE}.customerkey ;;
    hidden: yes
  }
  dimension:  FAMILYKEY {
    sql: ${TABLE}.familykey ;;
    hidden:  yes
  }
  dimension:  property_key {
    sql: ${TABLE}.property_key ;;
    hidden:  yes
  }
  #-------------------------------------------------------------------------------------------
  #-- dimensions
  #-------------------------------------------------------------------------------------------
  dimension: ty_bt {
    type: number
    sql: ${TABLE}.ty_bt ;;
    hidden: yes
  }

  dimension: ly_bt {
    type: number
    sql: ${TABLE}.ly_bt ;;
    hidden: yes
  }

  dimension:  MAILINGNAME {
    sql: ${TABLE}.mailingname ;;
    label: "Mailing Name"
    view_label: "Campaign"
  }

  dimension:  EMAILADDRESS {
    sql: ${TABLE}.EMAILADDRESS ;;
    label: "Email Address"
    view_label: "Campaign"
  }

  dimension: ISHOH {
    view_label: "Customer"
    label: "Head of Household? Y/N"
    description: "Customer Head of Household? Y/N"
    type: string
    sql: IIf(${TABLE}.ISHOH =1, "Y","N") ;;
  }
  dimension: FIRSTNAME {
    view_label: "Customer"
    label: "First Name"
    description: "Customer First Name"
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }
  dimension: LASTNAME {
    view_label: "Customer"
    label: "Last Name"
    description: "Customer Last Name"
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }
  dimension: GENDER {
    view_label: "Customer"
    label: "Gender"
    description: "Customer Gender"
    type: string
    sql: ${TABLE}.GENDER ;;
  }
  dimension: FULLADDRESS {
    view_label: "Customer"
    label: "Address"
    description: "Customer Address"
    type: string
    sql: ${TABLE}.FULLADDRESS ;;
  }
  dimension: CITY {
    view_label: "Customer"
    label: "City"
    description: "Customer City"
    type: string
    sql: ${TABLE}.CITY ;;
  }
  dimension: STATE {
    view_label: "Customer"
    label: "State Abbrev"
    description: "Customer State Abbreviation"
    type: string
    sql: ${TABLE}.STATE ;;
  }
  dimension: ZIP5 {
    view_label: "Customer"
    label: "Zip Code"
    description: "Customer Zip Code"
    type: zipcode
    sql: ${TABLE}.ZIP5 ;;
  }
  dimension: SUBREGION {
    view_label: "Customer"
    label: "Sub Region"
    description: "Customer Sub Region"
    type: string
    sql: ${TABLE}.SUBREGION ;;
  }
  dimension: REGION {
    view_label: "Customer"
    label: "Region"
    description: "Customer Region"
    type: string
    sql: ${TABLE}.REGION ;;
  }
  dimension: COUNTRY {
    view_label: "Customer"
    label: "Country"
    description: "Customer Country"
    type: string
    sql: ${TABLE}.COUNTRY ;;
  }
  dimension: ISMAILABLE {
    view_label: "Customer"
    label: "Mailable? Y/N"
    description: "Is Customer Mailable?"
    type: string
    sql: IIf(${TABLE}.ISMAILABLE =1, "Y","N") ;;
  }
  dimension: ISEMAILABLE {
    view_label: "Customer"
    label: "Emailable? Y/N"
    description: "Is Customer Emailable?"
    type: string
    sql: IIf(${TABLE}.ISEMAILABLE =1, "Y","N") ;;
  }
  dimension: ISPHONEABLE {
    view_label: "Customer"
    label: "Phoneable? Y/N"
    description: "Is Customer Phoneable?"
    type: string
    sql: IIf(${TABLE}.ISPHONEABLE =1, "Y","N") ;;
  }
  dimension: AGE {
    view_label: "Customer"
    label: "Age"
    description: "Customer Age"
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: age_tier{
    view_label: "Customer"
    label: "Age Tier"
    description: "Customer Age Tier"
    type: tier
    tiers: [0, 20, 30, 40, 50, 70, 100]
    style: relational
    sql: ${AGE} ;;
  }
  dimension: LATTITUDE {
    view_label: "Customer"
    label: "Lattitude"
    description: "Customer Lattitude"
    type: number
    sql: ${TABLE}.LATITUDE ;;
  }
  dimension: LONGITUDE {
    view_label: "Customer"
    label: "Longitude"
    description: "Customer Longitude"
    type: number
    sql: ${TABLE}.LONGITUDE ;;
    }
  #-------------------------------------------------------------------------------------------
  #-- dates
  #-------------------------------------------------------------------------------------------
  dimension:  MAILINGSENTDATE_SID {
    hidden: yes
    sql: utl..udf_date_to_julian(${TABLE}.mailingsentdate) ;;
  }
  dimension:  FIRSTOPENEDDATE_SID {
    hidden:  yes
    sql: utl..udf_date_to_julian(${TABLE}.firstopeneddate) ;;
  }
  dimension:  FIRSTCLICKEDDATE_SID {
    hidden: yes
    sql: utl..udf_date_to_julian(${TABLE}.firstclickeddate) ;;
  }
  dimension:  LASTEVENTDATE_SID {
    hidden: yes
    sql: utl..udf_date_to_julian(${TABLE}.lasteventdate) ;;
  }
  #-------------------------------------------------------------------------------------------
  #-- dimensions
  #-------------------------------------------------------------------------------------------
  dimension: sent_cnt {
    type: number
    sql:  ${TABLE}.ISRECEIVED ;;
    hidden:  yes
  }

  dimension:  isblocked {
    type: number
    sql: ${TABLE}.ISBLOCKED ;;
    hidden: yes
  }

  dimension:  isopened {
    type: number
    sql: ${TABLE}.ISOPENED ;;
    hidden: yes
  }

  dimension:  isclicked {
    type: number
    sql: ${TABLE}.ISCLICKED ;;
    hidden: yes
  }

}
