view: pmd_dim_staff {
  sql_table_name: praw_pmd.dbo.dimpropertystaff ;;

# Keys

  dimension: property_staff_key{
    type: number
    sql: ${TABLE}.propertystaffkey ;;
    hidden: yes
  }

  dimension: property_staff_title_key{
    type: number
    sql: ${TABLE}.propertystafftitlekey ;;
    hidden: yes
  }

  dimension: property_staff_dept_key{
    type: number
    sql: ${TABLE}.propertystaffdeptkey ;;
    hidden: yes
  }


  #--------------------------------------------------------------------------------
  #-- dimensions
  #--------------------------------------------------------------------------------
  dimension: first_name {
    view_label: "Employee"
    label: "First Name"
    description: "First Name"
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: last_name {
    view_label: "Employee"
    label: "Last Name"
    description: "Last Name"
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: full_name  {
    view_label: "Employee"
    label: "Full Name"
    sql: concat(concat(${TABLE}.firstname,' '),${TABLE}.lastname)  ;;
  }

  dimension: middle_name {
    view_label: "Employee"
    label: "Middle Name"
    description: "Middle Name"
    type: string
    sql: ${TABLE}.middlenameorinitial ;;
  }

  dimension: phone {
    view_label: "Employee"
    label: "Phone"
    description: "Phone"
    type: string
    sql: concat(concat(concat(concat(left(${TABLE}.phone,3),'-'),substring(${TABLE}.phone,4,3)),'-'),right(${TABLE}.phone,4)) ;;
  }

  dimension: ext {
    view_label: "Employee"
    label: "Ext"
    description: "Extension"
    type: string
    sql: ${TABLE}.ext ;;
  }

  dimension: cellphone {
    view_label: "Employee"
    label: "Cell Phone"
    description: "Cell Phone"
    type: string
    sql: concat(concat(concat(concat(left(${TABLE}.cellphone,3),'-'),substring(${TABLE}.cellphone,4,3)),'-'),right(${TABLE}.cellphone,4)) ;;
  }

  dimension: emailaddress {
    view_label: "Employee"
    label: "Email Address"
    description: "Email Addres"
    type: string
    sql: ${TABLE}.emailaddress ;;
  }

  dimension: regional_yn {
    view_label: "Employee"
    label: "Regional Y/N"
    description: "Regional Y/N"
    type: yesno
    sql: ${TABLE}.isregional = 1 ;;
  }
}
