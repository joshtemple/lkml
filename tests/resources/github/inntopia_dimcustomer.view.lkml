view: inntopia_dimcustomer {
  sql_table_name: PRAW_inntopia.dbo.dimcustomer ;;
    dimension:  CUSTOMERKEY {
    sql: ${TABLE}.CUSTOMERKEY ;;
    hidden:  yes
    }
    dimension:  FAMILYKEY {
    sql: ${TABLE}.FAMILYKEY ;;
    hidden:  yes
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
      sql: ${TABLE}.AGE ;;
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

#---------------------------------------------------------------------
#----MEASURES---------
#---------------------------------------------------------------------
    measure: record_cnt {
      label: "Customer Count"
      description: "Count of distinct customers"
      type: number
    sql: count(distinct ${CUSTOMERKEY}) ;;
    }
    measure: avg_customer_age{
      label: "Avg Age"
      description: "Average Customer Age"
      type: average
    }
    measure: family_cnt {
      label: "Family Count"
    description: "Count of distinct family's"
    type: number
    sql: count(distinct ${FAMILYKEY}) ;;
  }
}
