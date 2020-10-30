include: "__zcm_lifetime_view.view.lkml"
include: "_redesign_multiview_fields.view.lkml"
include: "zcm_redesign_personas.model.lkml"
include: "dim_textbook_zcm.view.lkml"
include: "//webassign/dim_textbook.view.lkml"
include: "//webassign/fact_registration.view.lkml"

##################################################################################################################################################################
############### THIS VIEW IS AT THE SCHOOL-AY-TOPIC LEVEL. IT IS THE BROADEST VIEW OF LIFETIME USAGE AT THE SCHOOL, ACADEMIC YEAR, & TOPIC     ###################
############### LEVELS AND IS INTENDED AS A BASE TABLE FOR THE MODEL. THE VALUES FROM THIS TABLE ALLOW US TO LOOK AT LIFETIME USAGE, ONE SMALL ###################
############### PART IN ASSESSING PERSONAS. SUBSEQUENT TABLES JOINED TO THIS ONE WILL BE USED FOR THE PRIMARY FOR ANALYSIS. 'LIFETIME USAGE'   ###################
############### IS DEFINED BY DEFAULT TO ALL ACADEMIC YEARS WITH DATA. THERE IS AN OPTIONAL PARAMETER ALLOWING THE USER TO REDEFINE THIS TIME  ###################
############### FRAME INDEPENDENTLY OF THE "FOCUSED" RANGE WHICH IS USED FOR THE MAJORITY OF THE METRICS FOR FLAGGING PERSONAL. ALL DIMENSIONS ###################
############### (EXCEPT ANY NEW ONES DERIVED HERE) WILL BE HIDDEN FROM VIEW AS THEY ARE INTENDED SOLEY FOR.                                    ###################
##################################################################################################################################################################



view: __zcm_lifetime_view {
  extends: [fact_registration]
  derived_table: {
    sql:
WITH  base as (
SELECT
              r.FACT_REGISTRATION_ID
            , r.DIM_TIME_ID
            , r.DIM_SECTION_ID
            , r.SSO_GUID
            , r.SCHOOL_ID
            , r.SECTION_ID
            , r.DIM_TEXTBOOK_ID
            , r.COURSE_ID
            , r.REGISTRATIONS
            , r.COUNT
            , r.COURSE_INSTRUCTOR_ID
            , r.DIM_SCHOOL_ID
            , r.USER_ID
            , r.SECTION_INSTRUCTOR_ID
            , r.USERNAME
            , time.special_ay_year as special_ay_year
            , time.ay_value as ay_value
            , d.dim_discipline_id as dim_discipline_id
            , d.sub_discipline_name as sub_discipline_name
            , topic.topic
FROM WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.FACT_REGISTRATION  AS r
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SCHOOL  AS s ON r.DIM_SCHOOL_ID = s.DIM_SCHOOL_ID
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SECTION AS sec on r.DIM_SECTION_ID = sec.DIM_SECTION_ID
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_TEXTBOOK  AS t ON r.DIM_TEXTBOOK_ID = t.DIM_TEXTBOOK_ID
    LEFT JOIN WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_DISCIPLINE  AS d ON t.DIM_DISCIPLINE_ID = d.DIM_DISCIPLINE_ID
    INNER JOIN ${dim_time_zcm.SQL_TABLE_NAME} AS time ON r.DIM_TIME_ID = time.DIM_TIME_ID
    INNER JOIN ${_zcm_topic_filter.SQL_TABLE_NAME} AS topic ON r.fact_registration_id = topic.fact_registration_id
      WHERE (time.ay_value >= -{% parameter fact_registration.lifetime_ay %})
          AND s.TYPE IN ('University', 'Community College')
          AND s.COUNTRY_NAME = 'United States'
          AND topic.topic IN ('Liberal Arts Mathematics', 'College Algebra', 'Introductory Statistics', 'Precalculus', 'Finite Math and Applied Calculus','Algebra/Trig')
          AND {% condition fact_registration.publisher_group_filter %} topic.publisher_group {% endcondition %}
)
, sec_reg_filter as (
        SELECT
                 DISTINCT dim_section_id
               , COALESCE(SUM(REGISTRATIONS),0) as section_regs
        FROM base
        GROUP BY 1
          HAVING section_regs >= {% parameter fact_registration.section_registration_threshold %}
)
, instructor_reg_filter as (
        SELECT
                DISTINCT course_instructor_id
              , ay_value
              , COALESCE(SUM(REGISTRATIONS),0) AS inst_ay_regs
        FROM base
          WHERE ay_value >= -{% parameter fact_registration.core_gateway_threshold_range %}
        GROUP BY 1,2
          HAVING inst_ay_regs >= {% parameter fact_registration.annual_instructor_registration_threshold %}
)
, cg_school_filter as (
        SELECT
                DISTINCT dim_school_id
              , ay_value
              , COALESCE(SUM(REGISTRATIONS),0) AS school_cg_regs
        FROM base
          WHERE ay_value >= -{% parameter fact_registration.core_gateway_threshold_range %}
            AND topic IN ('Liberal Arts Mathematics', 'College Algebra', 'Introductory Statistics')
          GROUP BY 1,2
            HAVING school_cg_regs >= {% parameter fact_registration.accgr_threshold %}
)
, instructor_name as (
        SELECT
              DISTINCT course_instructor_id
            , max(course_instructor_name) as crs_instructor_name
        FROM WEBASSIGN.FT_OLAP_REGISTRATION_REPORTS.DIM_SECTION
        GROUP BY 1
)
, selection as (
        SELECT
              DISTINCT b.FACT_REGISTRATION_ID
            , b.DIM_TIME_ID
            , srf.DIM_SECTION_ID
            , b.SSO_GUID
            , b.SCHOOL_ID
            , b.SECTION_ID
            , b.DIM_TEXTBOOK_ID
            , b.COURSE_ID
            , b.REGISTRATIONS
            , b.COUNT
            , irf.COURSE_INSTRUCTOR_ID
            , cgsf.DIM_SCHOOL_ID
            , b.USER_ID
            , b.SECTION_INSTRUCTOR_ID
            , b.USERNAME
            , b.special_ay_year as special_ay_year
            , b.ay_value as ay_value
            , b.dim_discipline_id as dim_discipline_id
            , b.sub_discipline_name as sub_discipline_name
            , b.topic
            , instn.crs_instructor_name as crs_instructor_name
            , srf.section_regs
            , irf.inst_ay_regs
            , cgsf.school_cg_regs
        FROM base as b
        INNER JOIN sec_reg_filter as srf ON         b.dim_section_id = srf.dim_section_id
        INNER JOIN instructor_reg_filter as irf ON  b.course_instructor_id = irf.course_instructor_id
        INNER JOIN cg_school_filter as cgsf ON   b.dim_school_id = cgsf.dim_school_id
        INNER JOIN instructor_name as instn ON         b.course_instructor_id = instn.course_instructor_id
)
SELECT
              *
            , COALESCE(sum(REGISTRATIONS) OVER (PARTITION BY dim_school_id),0) as school_registrations
            , COALESCE(SUM(REGISTRATIONS) OVER (PARTITION BY dim_section_id),0) as section_registrations
            , COUNT(DISTINCT course_id) OVER (PARTITION BY dim_school_id) as school_courses
            , COUNT(DISTINCT dim_section_id) OVER (PARTITION BY dim_school_id) as school_sections
            , COUNT(DISTINCT topic) OVER (PARTITION BY dim_school_id) as school_topics
            , COUNT(DISTINCT special_ay_year) OVER (PARTITION BY dim_school_id) as school_ays
            , COUNT(DISTINCT course_id) OVER (PARTITION BY course_instructor_id) as lifetime_crs_instructor_courses
            , COUNT(DISTINCT dim_section_id) OVER (PARTITION BY course_instructor_id) as lifetime_crs_instructor_sections
            , COUNT(DISTINCT special_ay_year) OVER (PARTITION BY course_instructor_id) as lifetime_crs_instructor_ays
            , COUNT(DISTINCT topic) OVER (PARTITION BY course_instructor_id) as lifetime_crs_instructor_topics
            , COUNT(DISTINCT section_instructor_id) OVER (PARTITION BY course_instructor_id) as lifetime_crs_instructor_sect_instructors
            , COALESCE(sum(REGISTRATIONS) OVER (PARTITION BY course_instructor_id),0) as lifetime_crs_instructor_registrations
FROM selection
;;
  }

###############################################
############# LIFETIME DIMENSIONS #############
###############################################

 dimension: dim_school_id {
     label: "              Dim School ID"
     hidden: no
#     group_label: "           Lifetime Dimensions"
     view_label: "     Lifetime View"
   }

  dimension: special_ay_year  {
    label: "            Academic Year"
    hidden: no
#    group_label: "           Lifetime Dimensions"
    view_label: "     Lifetime View"
  }


  dimension: topic {
    label: "         Course Topic"
    description: "Similar to Sub-Discipline, but extracts and groups courses using Algebra and Trig products out of Dev Math and into their own topic category"
#    group_label: "           Lifetime Dimensions"
    view_label: "     Lifetime View"
  }

  dimension: course_instructor_id {
    label: "     Course Instructor ID"
 #   group_label: "           Lifetime Dimensions"
    view_label: "     Lifetime View"
    drill_fields: [_zcm_topic_filter.topic, course_id, _zcm_topic_filter.topic_group, dim_section.course_instructor_name, dim_section.course_instructor_email
      ,  section_id, dim_section.section_instructor_name, dim_section.section_instructor_email, dim_time.special_ay_year]
  }


  dimension: crs_instructor_name {
    label: "     Course Instructor Name"
#    group_label: "           Lifetime Dimensions"
    view_label: "     Lifetime View"
    drill_fields: [_zcm_topic_filter.topic, course_id, _zcm_topic_filter.topic_group, dim_section.course_instructor_name, dim_section.course_instructor_email
      ,  section_id, dim_section.section_instructor_name, dim_section.section_instructor_email, dim_time.special_ay_year]
  }


  dimension: fact_registration_id   {hidden: yes sql: ${TABLE}.FACT_REGISTRATION_ID;; primary_key: no}
  dimension: dim_time_id            {hidden: yes sql: ${TABLE}.DIM_TIME_ID;;}
  dimension: dim_section_id         {hidden: yes sql: ${TABLE}.DIM_SECTION_ID;;}
  dimension: sso_guid               {hidden: yes sql: ${TABLE}.SSO_GUID;;}
  dimension: school_id              {hidden: yes sql: ${TABLE}.SCHOOL_ID            ;; view_label: "     Lifetime View"}
  dimension: section_id             {hidden: yes sql: ${TABLE}.SECTION_ID           ;;}
  dimension: dim_textbook_id        {hidden: yes sql: ${TABLE}.DIM_TEXTBOOK_ID      ;;}
  dimension: course_id              {hidden: yes sql: ${TABLE}.COURSE_ID            ;;}
  dimension: registrations          {hidden: yes sql: ${TABLE}.REGISTRATIONS        ;;}
  dimension: count                  {hidden: yes sql: ${TABLE}.COUNT                ;;}
  dimension: user_id                {hidden: yes sql: ${TABLE}.USER_ID              ;;}
  dimension: section_instructor_id  {hidden: yes sql: ${TABLE}.SECTION_INSTRUCTOR_ID;;}
  dimension: username               {hidden: yes sql: ${TABLE}.USERNAME             ;;}

   dimension: section_regs    {type: number hidden: yes view_label: "     Lifetime View"}
   dimension: inst_ay_regs    {type: number hidden: yes view_label: "     Lifetime View"}
   dimension: school_cg_regs  {type: number hidden: yes view_label: "     Lifetime View"}


##################################################
############### PARAMETERS #######################
##################################################

  parameter: lifetime_ay {
    default_value: "25"
    label: "   Lifetime Academic Years Included"
    description: "For Lifetime metrics, select how many Academic Years back you want included in the query (Not including the current academic year).
    Ex: selecting '3' would include the current ongoing academic year plus the prior 3"
    view_label: "           Parameters & Filters"
  }

  parameter: section_registration_threshold {
    type: number
    label: "Section Registration Threshold"
    description: "select the minimum number of registrations required in a section to include in query. Default >=  5"
    default_value: "5"
    view_label: "           Parameters & Filters"
  }

  parameter: core_gateway_threshold_range {
    type: number
    label: "AYs Included for ACCGR Threshold"
    description: "Select the number of Academic Years back (not including the current in-progress year) to be included in assessing if a school meets the
    Core Gateway Combined Annual Enrollments Threshold. Schools that do not meet this threshold will be excluded completely from any analysis."
    view_label: "           Parameters & Filters"
    default_value: "1"
  }

  parameter: annual_instructor_registration_threshold {
    type: number
    label: "Instructor Annual Registration Threshold"
    description: "select the minimum number of registrations an instructor must have in an academic year to be included in the query. Default >=  10"
    default_value: "10"
    view_label: "           Parameters & Filters"
  }

  parameter: accgr_threshold {
    label: "Set the ACCGR Threshold"
    description: "Set the Annual Combined Core Gateway Course Registration Threshold. This is the enrollments threshold to include institutions and is the sum of Registrations for Core Gateway Courses (Liberal Arts Math, College Algebra, and Intro Stats) for an academic year. The default is >= 1,000 registrations in an academic year"
    default_value: "1000"
    type: number
    view_label: "           Parameters & Filters"
  }

        dimension: meets_accgr_threshold {
          label: "> ACCGR Threshold?"
          description: "Indicates whether or not a school met the Annual Combined Core Gateway Registration (AC-CGR) threshold for a given academic year."
          type: yesno
          view_label: "           Parameters & Filters"
          sql:
                                 zeroifnull(${TABLE}.annual_cg_reg) >= {% parameter accgr_threshold %};;
          hidden: yes
        }

  filter: publisher_group_filter {
    label: "Publisher Group Filter"
    type: string
    view_label: "           Parameters & Filters"
    default_value: "Internal, OER"
    suggest_dimension: _zcm_topic_filter.publisher_group
  }
###############################################
########  TO BE REMOVED FROM MODEL  ###########
###############################################


  dimension: section_registrations {
    hidden: no
    view_label: "Section"
    type: number
  }


###############################################
######## KEYS AND IDENTIFIERS (HIDDEN) ########
###############################################

dimension: pk1_fact_registration_id {
  primary_key: yes
  hidden: yes
  sql: ${TABLE}.fact_registration_id ;;
}

dimension: fk2_ay_key {
  description: "Key for school/academic year level"
  hidden: yes
  primary_key: no
  sql: nullif(hash(${dim_school_id},'|',${special_ay_year}),0) ;;
}

dimension: fk3_topic_key {
  description: "Key for school/academic year/sub_discipline level"
  hidden: yes
  primary_key: no
  sql: nullif(hash(${dim_school_id},'|',${special_ay_year},'|',${topic}),0) ;;
}

  dimension: fk3_course_section_ay_key {
    hidden: yes
    sql: nullif(hash(${dim_section_id},'|',${course_instructor_id},'|',${special_ay_year}),0) ;;
  }



  dimension: dim_discipline_id  {
    hidden: yes
    group_label: "Discipline"
    }



  dimension: ay_value {
    hidden: yes
  }


###############################################
########### ENTITY COUNTS #####################
###############################################
  measure: school_count {
    label: "                # Schools"
    view_label: "     Lifetime View"
    type: count_distinct
    sql: ${dim_school_id} ;;
  }
  measure: course_id_count {
    label: "          # Courses"
    view_label: "     Lifetime View"
    type: count_distinct
    sql: ${course_id} ;;
  }

  measure: dim_section_id_count {
    label: "         # Sections"
    view_label: "     Lifetime View"
    type: count_distinct
    sql: ${dim_section_id} ;;
  }
  measure: ay_count {
    label: "      # Academic Years"
    view_label: "     Lifetime View"
    type: count_distinct
    sql: ${ay_value} ;;
  }
  measure: topic_count {
    label: "       # Course Topics"
    view_label: "     Lifetime View"
    type: count_distinct
    sql: ${topic} ;;
  }
  measure: course_instructor_count {
    label: "    # Course Instructors"
    view_label: "     Lifetime View"
    type: count_distinct
    sql: ${course_instructor_id} ;;
  }
  measure: section_instructor_count {
    label: " # Section Instructors"
    view_label: "     Lifetime View"
    type: count_distinct
    sql: ${section_instructor_id} ;;
  }
  measure: registration_sum {
    label: "# Registrations"
    view_label: "     Lifetime View"
    type: number
    sql: COALESCE(SUM(${registrations}),0) ;;
}


###############################################
######### PRE-AGGREGATED DIMENSIONS ###########
###############################################


#################################### SCHOOL LEVEL AGGREGATES ##########################################

  dimension: school_courses {
    type: number
    label: "                                  # School Courses"  #34
    description: "Rolled up measures aggregated at the institution level across all available years and for all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "     Lifetime View"
    drill_fields: [school_id, course_id]
  }

  dimension: school_sections {
    type: number
    label: "                                 # School Sections" #31
    description: "Rolled up measures aggregated at the institution level across all available years and for all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "     Lifetime View"
    drill_fields: [dim_school_id, dim_school.name, dim_section_id, section_registrations, dim_time_id, dim_time.timedate ]
  }

  dimension: school_topics {
    type: number
    label: "                            # School Course Topics"  #28
    description: "Rolled up measures aggregated at the institution level across all available years and for all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "     Lifetime View"
  }

  dimension: school_registrations  {
    type: number
    label: "                          # School Registrations"  #26
    description: "Rolled up measures aggregated at the institution level across all available years and for all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "     Lifetime View"
  }

  dimension: school_ays             {
    type: number
    label: "                          # School Academic Years"  #26
    description: "Rolled up measures aggregated at the institution level across all available years and for all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "     Lifetime View"
  }




#################################### COURSE INSTRUCTOR LEVEL AGGREGATES ##########################################

  dimension: lifetime_crs_instructor_courses         {
    type: number
    label: "          # Instructor Courses"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "     Lifetime View"
  }

  dimension: lifetime_crs_instructor_sections         {
    type: number
    label: "       # Instructor Sections"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "     Lifetime View"
    }

  dimension: lifetime_crs_instructor_ays              {
    type: number
    label: "     # Instructor Academic Yrs"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "     Lifetime View"
    }

  dimension: lifetime_crs_instructor_topics           {
    type: number
    label: "      # Instructor Course Topics"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "     Lifetime View"
    }

  dimension: lifetime_crs_instructor_registrations {
    type: number
    label: "     # Instructor Registrations"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "     Lifetime View"
  }

  dimension: lifetime_crs_instructor_sect_instructors {
    type: number
    label: "# Section Instructors Managed"
    description: "The number of distinct section instructors teaching in a course instructor's courses"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "     Lifetime View"
    }


############################# END PRE-AGGREGATED DIMENSIONS
#
#
#
#
#
#
#
#   measure: avg_school_courses {
#     type: average
#     label: "    Average Lifetime Courses"
#     group_label: "    Lifetime Averages"
#     sql: ${school_courses} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_school_sections {
#     type: average
#     label: "   Average Lifetime Sections"
#     group_label: "    Lifetime Averages"
#     sql: ${school_sections} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_school_topics {
#     type: average
#     label: "  Average Lifetime Topics Taught"
#     group_label: "    Lifetime Averages"
#     sql: ${school_topics} ;;
#     value_format_name: decimal_1
#     hidden: yes
#  }
#
#   measure: avg_school_registrations {
#     type: average
#     label: " Average Lifetime Registrations"
#     group_label: "    Lifetime Averages"
#     sql: ${school_registrations} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }

############## ANNUAL AGGREGATES ####################

#   dimension: annual_school_courses {
#     type: number
#     label: "                                 Lifetime An Courses" #33
#     description: "Measures aggregated at the institution level and broken out by academic year. Includes all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
#     group_label: "    Course Aggregations"
#   }
#
#   dimension: annual_school_sections {
#     type: number
#     label: "                              Lifetime An Sections"  #30
#     description: "Measures aggregated at the institution level and broken out by academic year. Includes all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
#     group_label: "    Course Aggregations"
#   }
#
#   dimension: annual_school_topics {
#     type: number
#     label: "                           Lifetime An Topics"  #27
#     description: "Measures aggregated at the institution level and broken out by academic year. Includes all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
#     group_label: "   Topic Aggregations"
#     drill_fields: [topic_drill*]
#   }
#
#   dimension: annual_redesign_reg  {
#     type: number
#     label: "                         Lifetime An Registrations" #25
#     description: "Measures aggregated at the institution level and broken out by academic year. Includes all potential redesign sections (identified as teaching with texts that cover the defined redesign course topics)"
#     group_label: "  Registration Aggregations"
#   }
#
#
#   measure: avg_annual_school_courses {
#     type: average
#     label: "    Average An Courses"
#     group_label: "   Annual Averages"
#     sql: ${annual_school_courses} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_school_sections {
#     type: average
#     label: "   Average An Sections"
#     group_label: "   Annual Averages"
#     sql: ${annual_school_sections} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_school_topics {
#     type: average
#     label: "  Average An Topics Taught"
#     group_label: "   Annual Averages"
#     sql: ${annual_school_topics} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_redesign_reg {
#     type: average
#     label: " Average An Registrations"
#     group_label: "   Annual Averages"
#     sql: ${annual_redesign_reg} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }




# ############# ANNUAL TOPIC AGGREGATES ##############
#
#   dimension: annual_school_topic_courses {
#     type: number
#     description: "Measures aggregated at the institution level and broken out by course topic and academic year."
#     label: "                                 Lifetime An Tp Courses" #32
#     group_label: "    Course Aggregations"
#   }
#
#   dimension: annual_school_topic_sections {
#     type: number
#     description: "Measures aggregated at the institution level and broken out by course topic and academic year."
#     label: "                             Lifetime An Tp Sections" #29
#     group_label: "    Course Aggregations"
#   }
#
#   dimension: annual_school_topic_registrations  {
#     type: number
#     label: "                        Lifetime An Tp Registrations"  #24
#     description: "Measures aggregated at the institution level and broken out by course topic and academic year."
#     group_label: "  Registration Aggregations"
#   }
#
#
#   measure: avg_annual_school_topic_courses {
#     type: average_distinct
#     label: "   Average An Courses by Topic"
#     group_label: " Annual Topic Averages"
#     sql: ${annual_school_topic_courses} ;;
#     sql_distinct_key: ${fk3_topic_key} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_school_topic_sections {
#     type: average_distinct
#     label: "  Average An Topic Sections"
#     group_label: " Annual Topic Averages"
#     sql: ${annual_school_topic_sections} ;;
#     sql_distinct_key: ${fk3_topic_key} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_school_topic_registrations {
#     type: average_distinct
#     label: " Average An Topic Registrations"
#     group_label: " Annual Topic Averages"
#     sql: ${annual_school_topic_registrations} ;;
#     sql_distinct_key: ${fk3_topic_key} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#
#
# measure: count {
#   label: "# Distinct Schools"
#     type: count_distinct
#     sql: ${dim_school_id} ;;
#   }
#
#   measure: number_topics {
#     type: count_distinct
#     sql: ${topic} ;;
#   }
#
#   measure: number_academic_years{
#     type: count_distinct
#     sql: ${special_ay_year} ;;
#   }
#
#   measure: lifetime_registrations {
#     type: sum
#     label: "# Lifetime Registrations"
#     sql: ${TABLE}.registrations ;;
#   }

#   measure: average_lifetime_registrations {
#     type:
#     label: "Average Registrations"
#     sql: ${TABLE}.annual_school_topic_registrations ;;
# #    sql_distinct_key: ${fk3_topic_key} ;;
#     value_format_name: decimal_1
#  }


############################################################################
########################### HIDDEN FIELDS ##################################
############################################################################

  dimension: ay_start_year {
    hidden: yes
    type: number
    sql: left(${special_ay_year},4) ;;
  }

  dimension: ay_end_year {
    hidden: yes
    type: number
    sql: right(${special_ay_year},4) ;;
  }


measure: lifetime_pk_count {
  type: count
  filters:{
    field: pk1_fact_registration_id
    value: "NOT NULL"
    }
  hidden: yes
}

  set: topic_drill {
    fields: [dim_school.name, fact_registration.sub_discipline_name,  special_ay_year, dim_section_zcm.course_count, dim_section.section_count, fact_registration.user_registrations]
  }

dimension: _fivetran_synced {
  hidden: yes
  label: "Fivetran Synced"
}

dimension: _fivetran_date {
  label: "Fivetran Sync Date"
  type: date
  hidden: yes
  sql: ${_fivetran_synced} ;;
}
dimension: dim_axscode_id  {hidden: yes}
dimension: dim_payment_method_id  {hidden: yes}
dimension: event_type  {hidden: yes}
dimension: purchase_type {hidden: yes}
dimension: redemption_model  {hidden: yes}
dimension: registration_count  {hidden: yes}
dimension: token_id {hidden: yes}
dimension: upgrades  {hidden: yes}
measure: num_course_instructors {hidden: yes}
measure: distinct_sections {hidden: yes}
measure: num_section_instructors {hidden: yes}
measure: distinct_user_registrations {hidden: yes}
measure: user_registrations {hidden: yes}
}
