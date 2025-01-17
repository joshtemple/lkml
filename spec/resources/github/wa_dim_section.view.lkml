include: "/webassign/dim_section.view.lkml"
include: "/webassign/webassig*.model.lkml"
include: "wa_fact_registration.view.lkml"

view: wa_dim_section {
  extends: [dim_section]
  derived_table: {
    sql:
, usect AS (
    SELECT
      DISTINCT f.SECTION_INSTRUCTOR_KEY
    , s.DIM_SECTION_ID
    , s.COURSE_ID
    , s.COURSE_INSTRUCTOR_EMAIL AS instructor_email
    , s.COURSE_INSTRUCTOR_ID  AS instructor_id
    , s.COURSE_INSTRUCTOR_NAME AS instructor_name
    , s.COURSE_INSTRUCTOR_SF_ID AS instructor_sf_id
    , s.COURSE_INSTRUCTOR_USERNAME AS instructor_username
    , CASE WHEN s.COURSE_INSTRUCTOR_ID=s.SECTION_INSTRUCTOR_ID THEN 'Course & Section Instructor' ELSE 'Course Instructor' END AS instructor_lvl_for_section
    , s.COURSE_NAME
    , s.CREATED_EASTERN
    , s.DATE_FROM
    , s.DATE_TO
    , s.DEPLOYMENTS
    , s.DIM_DISCIPLINE_ID
    , s.DIM_TEXTBOOK_ID
    , s.DIM_TIME_ID_CREATED
    , s.DIM_TIME_ID_ENDS
    , s.DIM_TIME_ID_LEEWAY
    , s.DIM_TIME_ID_STARTS
    , s.ENDS_EASTERN
    , s.GB_CONFIGURED
    , s.GB_HAS_DATA
    , s.GRANTED_EBOOK
    , s.HAS_INVOICE
    , s.LEEWAY_EASTERN
    , s.MEETS
    , s.PSP_ENABLED
    , s.PSP_MODE
    , s.PSP_STUDENTS_ATTEMPTING_QUIZ
    , s.PSP_STUDENTS_ATTEMPTING_TEST
    , s.REGISTRATIONS
    , s.ROSTER
    , s.SCHOOL_ID
    , s.SECTION_ID
    , s.SECTION_NAME
    , s.STARTS_EASTERN
    , s.TERM
    , s.TERM_DESCRIPTION
    , s.TRASHED
    , s.USING_OPEN_RESOURCES
    , s.VERSION
    , s.YEAR
    , s._FIVETRAN_DELETED
    , s._FIVETRAN_SYNCED
    , instructor_id||'-'||DENSE_RANK() OVER (PARTITION BY instructor_id ORDER BY instructor_name asc) AS dist_instructor_name_id
  FROM ${wa_fact_registration.SQL_TABLE_NAME} as f
  INNER JOIN webassign.ft_olap_registration_reports.dim_section AS s ON f.SECTION_INSTRUCTOR_KEY = s.dim_section_id||s.course_instructor_id
UNION
  SELECT
      DISTINCT f.SECTION_INSTRUCTOR_KEY
    , s.DIM_SECTION_ID
    , s.COURSE_ID
    , s.SECTION_INSTRUCTOR_EMAIL AS instructor_email
    , s.SECTION_INSTRUCTOR_ID  AS instructor_id
    , s.SECTION_INSTRUCTOR_NAME AS instructor_name
    , s.SECTION_INSTRUCTOR_SF_ID AS instructor_sf_id
    , s.SECTION_INSTRUCTOR_USERNAME AS instructor_username
    , CASE WHEN s.SECTION_INSTRUCTOR_ID=s.COURSE_INSTRUCTOR_ID THEN 'Course & Section Instructor' ELSE 'Section Instructor' END AS instructor_lvl_for_section
    , s.COURSE_NAME
    , s.CREATED_EASTERN
    , s.DATE_FROM
    , s.DATE_TO
    , s.DEPLOYMENTS
    , s.DIM_DISCIPLINE_ID
    , s.DIM_TEXTBOOK_ID
    , s.DIM_TIME_ID_CREATED
    , s.DIM_TIME_ID_ENDS
    , s.DIM_TIME_ID_LEEWAY
    , s.DIM_TIME_ID_STARTS
    , s.ENDS_EASTERN
    , s.GB_CONFIGURED
    , s.GB_HAS_DATA
    , s.GRANTED_EBOOK
    , s.HAS_INVOICE
    , s.LEEWAY_EASTERN
    , s.MEETS
    , s.PSP_ENABLED
    , s.PSP_MODE
    , s.PSP_STUDENTS_ATTEMPTING_QUIZ
    , s.PSP_STUDENTS_ATTEMPTING_TEST
    , s.REGISTRATIONS
    , s.ROSTER
    , s.SCHOOL_ID
    , s.SECTION_ID
    , s.SECTION_NAME
    , s.STARTS_EASTERN
    , s.TERM
    , s.TERM_DESCRIPTION
    , s.TRASHED
    , s.USING_OPEN_RESOURCES
    , s.VERSION
    , s.YEAR
    , s._FIVETRAN_DELETED
    , s._FIVETRAN_SYNCED
    , instructor_id||'-'||DENSE_RANK() OVER (PARTITION BY instructor_id ORDER BY instructor_name asc) AS dist_instructor_name_id
FROM ${wa_fact_registration.SQL_TABLE_NAME} as f
INNER JOIN webassign.ft_olap_registration_reports.dim_section AS s ON f.SECTION_INSTRUCTOR_KEY = s.dim_section_id||s.section_instructor_id
)
SELECT
    usect.*
    , np.INSTRUCTOR_FNAME
    , np.INSTRUCTOR_MIDDLENAME
    , np.INSTRUCTOR_LNAME
FROM usect
LEFT JOIN DEV.ZCM.AM_WA_CONTACT_NAMESPARSED as np ON usect.dim_section_id||usect.dist_instructor_name_id = np.dim_section_id||np.dist_instructor_name_id
    ;;
  }

   dimension: dim_section_id                {label: "     Dim Section ID" primary_key: no  hidden: no}
   dimension: section_instructor_key        {view_label: "Instructor" primary_key: yes }
   dimension: dist_instructor_name_id       {view_label: "Instructor" description: "Unique identifier for instructor ids with more than one record for instructor name"}
   dimension: instructor_lvl_for_section    {view_label: "Instructor" description: "is the Course Instructor, Section Instructor, or Both Course & Section Instructor from dim_section_id"}




#########################################################################################################################################
################################################# INSTRUCTOR FIELDS #####################################################################
#########################################################################################################################################


    dimension: instructor_id         {label: "     Instructor ID"         view_label: "Instructor" }
    dimension: instructor_name       {label: "    Instructor Full Name"    view_label: "Instructor"}
    dimension: instructor_email      {label: " Instructor Email"        view_label: "Instructor"}
    dimension: instructor_sf_id      {label: "Instructor SF ID"        view_label: "Instructor" hidden: yes}
    dimension: instructor_username   {label: "User Name"               view_label: "Instructor"}
    dimension: instructor_fname      {label: "   Instructor First Name"   view_label: "Instructor"}
    dimension: instructor_middlename {label: "   Instructor Middle Name"  view_label: "Instructor"}
    dimension: instructor_lname      {label: "  Instructor Last Name"    view_label: "Instructor"}

    measure: instructor_count        {view_label: "Instructor"}


#------------------------------------------------ Course Instructor (Hidden b/c of Union PDT) --------------------------------------------------------------------#

  dimension: course_instructor_id          {hidden: yes view_label:"Instructor" }
  dimension: course_instructor_name        {hidden: yes view_label: "Instructor"}
  dimension: course_instructor_email       {hidden: yes view_label: "Instructor"  }
  dimension: course_instructor_sf_id       {hidden: yes view_label: "Instructor"  }
  dimension: course_instructor_username    {hidden: yes view_label: "Instructor"  }


  measure: course_instructor_count        {hidden: yes view_label: "Instructor" group_label:"Course Instructor Details"}




#------------------------------------------------- Section Instructor (Hidden b/c of Union PDT) -------------------------------------------------------------------#

  dimension: section_instructor_id         {hidden: yes view_label: "Instructor" }
  dimension: section_instructor_name       {hidden: yes view_label: "Instructor" }
  dimension: section_instructor_username   {hidden: yes view_label: "Instructor" }
  dimension: section_instructor_sf_id      {hidden: yes view_label: "Instructor"     }
  dimension: section_instructor_email      {hidden: yes view_label: "Instructor"  }

  measure: sect_instructor_count           {hidden: yes view_label: "Instructor" group_label:"Section Instructor Details"}




################################################## SECTION FIELDS ######################################################################


#---------------------------------------------------- Course --------------------------------------------------------------------------#


  dimension: course_id          { group_label: " Course Level"  }
  dimension: course_name        { group_label: " Course Level" }
  dimension: course_description { group_label: " Course Level" }


#---------------------------------------------------- Section -------------------------------------------------------------------------#

  dimension: section_id         { group_label: " Section Level" primary_key: no  }
  dimension: class_key          { group_label: " Section Level" }
  dimension: section_name       { group_label: " Section Level" }
  dimension: meets              {  }
  dimension: trashed            {  }

  dimension: registrations      { group_label: " Section Totals" }
  dimension: deployments        { group_label: " Section Totals" }
  dimension: roster             { group_label: " Section Totals"   }

  measure: roster_sum           { group_label: " Section Level" }
  measure: count                { group_label: " Section Level" }


#--------------------------------------------------- Gradebook ------------------------------------------------------------------------#

  dimension: gb_configured      {  }
  dimension: gb_has_data        {  }


#----------------------------------------------- Enabled Features ---------------------------------------------------------------------#


  dimension: psp_enabled                  { hidden: yes }
  dimension: psp_mode                     { hidden: yes }
  dimension: psp_students_attempting_test { hidden: yes }
  dimension: granted_ebook                { hidden: yes }




  dimension: recency_date                 {  }







#------------------------------------------------- DATE FIELDS  ------------------------------------------------------------------------#

#-------------- Semester ----------------------#

  dimension: term             { hidden: yes  }  ### Useless
  dimension: term_description { hidden: yes }  #### Useless

  dimension: cdate                { group_label: "Date - Start, End, Created" }
  dimension: year                 { group_label: "Date - Start, End, Created"  }
  dimension: created_eastern      { group_label: "Date - Start, End, Created"   }
  dimension: dim_time_id_created  { hidden: yes  }
  dimension: dim_time_id_leeway   { hidden: yes  }
  dimension: leeway_eastern       { hidden: yes  }
  dimension: date_from            { hidden: yes  }
  dimension: dim_time_id_ends     { hidden: yes  }
  dimension: date_to              { hidden: yes  }
  dimension: ends_eastern_raw     { group_label: "Date - Start, End, Created"   }
  dimension: ends_eastern         { group_label: "Date - Start, End, Created"  }
  dimension: dim_time_id_starts   { hidden: yes  }
  dimension: starts_eastern       { group_label: "Date - Start, End, Created"   }
  dimension: start_date_raw       { group_label: "Date - Start, End, Created"   }






################################################# TEXTBOOK FIELDS ########################################################################

  dimension: dim_textbook_id      { hidden: yes }
  dimension: using_open_resources {  }

################################################## SCHOOL FIELDS #########################################################################

  dimension: school_id      { hidden: yes  }

  measure: school_count     { hidden: yes }


################################################# DISCIPLINE FIELDS ######################################################################

  dimension: dim_discipline_id { hidden:yes }




################################################# ADDED BY ME #############################################################################

  dimension: cdate_year {
    type: number
    label: "Created Year"
    group_label: "Date - Start, End, Created"
    sql: left(${TABLE}.cdate,4) ;;
  }

  measure: max_cdate {
    label: "Last Section Created Date"
    group_label: "First/Last Created Dates"
    sql: MAX(${TABLE}.cdate) ;;
  }

  measure: max_cdate_year {
    label: "Last Section Created Year"
    group_label: "First/Last Created Dates"
    sql: LEFT(MAX(${TABLE}.cdate),4) ;;
  }

  measure: min_cdate {
    label: "First Section Created Date"
    group_label: "First/Last Created Dates"
    sql: MIN(${TABLE}.cdate) ;;
  }

  measure: min_cdate_year {
    label: "First Section Created Year"
    group_label: "First/Last Created Dates"
    sql: LEFT(MIN(${TABLE}.cdate),4) ;;
  }

  measure: num_years_wsections {
    label: "# Years w/ Sections"
    description: "Difference between first section created year and last sections created year"
    group_label: "First/Last Created Dates"
    sql:
          round(
                LEFT(MAX(${TABLE}.cdate),4)-LEFT(MIN(${TABLE}.cdate),4)+1
                ) ;;
    value_format: "0"
  }

############################################### UNUSED FIELDS #############################################################################

  dimension: bill_institution_option              {hidden: yes  }
  dimension: bill_institution_po_num              {hidden: yes  }
  dimension: bill_institution_contact_phone       {hidden: yes  }
  dimension: bill_institution_invoice_number      {hidden: yes  }
  dimension: bill_institution_contact_email       {hidden: yes  }
  dimension: bill_institution_invoice_amount      {hidden: yes  }
  dimension: bill_institution_invoice_date        {hidden: yes  }
  dimension: billing                              {hidden: yes  }
  dimension: bill_institution_method              {hidden: yes  }
  dimension: bill_institution_comments            {hidden: yes  }
  dimension: bill_institution_contact_name        {hidden: yes  }
  dimension: bill_institution_isbn                {hidden: yes  }
  dimension: has_invoice                          {hidden: yes  }
  dimension: _fivetran_deleted                    {hidden: yes  }
  dimension: bb_version                           {hidden: yes  }
  dimension: _fivetran_synced                     {hidden: yes  }
  dimension: psp_students_attempting_quiz         {hidden: yes  }
  dimension: version                              {hidden: yes  }

set: dim_section_crs_sect_instructor {
  fields: [
            course_instructor_id
            , course_instructor_name
            , course_instructor_email
            , course_instructor_sf_id
            , course_instructor_username
            , section_instructor_id
            , section_instructor_name
            , section_instructor_username
            , section_instructor_sf_id
            , section_instructor_email
            , course_instructor_count
            , sect_instructor_count
          ]
        }

    }
