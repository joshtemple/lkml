#######################################################################################################################################################################################################
################################ NOTE DATE RANGES FOR CORE GATEWAY AND TARGETED REDESIGN COURSES ARE THE SAME. THE PARAMETER IS LOCATED IN THE TARGETED VIEW      #####################################
################################ THIS IS DIFFERENT FROM THE CORE_GATEWAY_THRESHOLD_RANGE PARAMETER IN _ZCM_SCHOOL_FILTER VIEW WHICH NEEDS TO BE MORE RESTRICTIVE  #####################################
#######################################################################################################################################################################################################

include: "//webassign/*.model.lkml"
include: "fact_registration_zcm.view.lkml"
include: "//webassign/dim_discipline.view.lkml"
include: "_redesign_multiview_fields.view.lkml"
include: "__zcm_targeted_view.view.lkml"



view: __zcm_coregateway_view {
  derived_table: {
    sql:
    wITH cg_base as (
SELECT
              DISTINCT FACT_REGISTRATION_ID
            , DIM_TIME_ID
            , DIM_SECTION_ID
            , SSO_GUID
            , SCHOOL_ID
            , SECTION_ID
            , DIM_TEXTBOOK_ID
            , COURSE_ID
            , REGISTRATIONS
            , COUNT
            , COURSE_INSTRUCTOR_ID
            , DIM_SCHOOL_ID
            , USER_ID
            , SECTION_INSTRUCTOR_ID
            , USERNAME
            , special_ay_year as special_ay_year
            , ay_value as ay_value
            , dim_discipline_id as dim_discipline_id
            , sub_discipline_name as sub_discipline_name
            , topic
            , crs_instructor_name as crs_instructor_name
FROM ${__zcm_lifetime_view.SQL_TABLE_NAME}
WHERE (ay_value >= -{% parameter __zcm_targeted_view.date_range_ay %})
 AND topic IN ('Liberal Arts Mathematics','College Algebra','Introductory Statistics')
)
SELECT
              *
            , COALESCE(sum(REGISTRATIONS) OVER (PARTITION BY dim_school_id),0) as school_registrations
            , COALESCE(SUM(REGISTRATIONS) OVER (PARTITION BY dim_section_id),0) as section_registrations
            , COUNT(DISTINCT course_id) OVER (PARTITION BY dim_school_id) as school_courses
            , COUNT(DISTINCT dim_section_id) OVER (PARTITION BY dim_school_id) as school_sections
            , COUNT(DISTINCT topic) OVER (PARTITION BY dim_school_id) as school_topics
            , COUNT(DISTINCT special_ay_year) OVER (PARTITION BY dim_school_id) as school_ays
            , COUNT(DISTINCT course_id) OVER (PARTITION BY course_instructor_id) as crs_instructor_courses
            , COUNT(DISTINCT dim_section_id) OVER (PARTITION BY course_instructor_id) as crs_instructor_sections
            , COUNT(DISTINCT special_ay_year) OVER (PARTITION BY course_instructor_id) as crs_instructor_ays
            , COUNT(DISTINCT topic) OVER (PARTITION BY course_instructor_id) as crs_instructor_topics
            , COUNT(DISTINCT section_instructor_id) OVER (PARTITION BY course_instructor_id) as crs_instructor_sect_instructors
            , COALESCE(sum(REGISTRATIONS) OVER (PARTITION BY course_instructor_id),0) as crs_instructor_registrations
FROM cg_base
--, cg_filter as (
--SELECT
--              DISTINCT r.fact_registration_id as fact_registration_id
--            , r.dim_school_id as dim_school_id
--            , r.school_id as school_id
--            , r.special_ay_year as special_ay_year
--            , r.ay_value as ay_value
--            , r.dim_discipline_id as dim_discipline_id
--            , r.sub_discipline_name as sub_discipline_name
--            , r.topic as topic
--            , r.course_id as course_id
--            , r.course_instructor_id as course_instructor_id
--            , r.dim_section_id as dim_section_id
--            , r.section_instructor_id as section_instructor_id
--            , r.registrations as registrations
--            , x.crs_instructor_name
--   FROM ${__zcm_lifetime_view.SQL_TABLE_NAME} as r
--   LEFT JOIN x on r.dim_section_id = x.dim_section_id AND r.course_instructor_id = x.course_instructor_id
--      WHERE (r.ay_value >= -{% parameter __zcm_targeted_view.date_range_ay %} )
--      AND ((UPPER(r.SUB_DISCIPLINE_NAME ) IN ('LIBERAL ARTS MATHEMATICS', 'COLLEGE ALGEBRA', 'INTRODUCTORY STATISTICS')))
--  )
--SELECT
--              *
--            , COALESCE(SUM(REGISTRATIONS) OVER (PARTITION BY dim_school_id),0) as lifetime_cg_reg
--            , COALESCE(SUM(REGISTRATIONS) OVER (PARTITION BY dim_school_id, special_ay_year),0) as annual_cg_reg
--FROM cg_filter
----
----SELECT
----              DISTINCT r.fact_registration_id as fact_registration_id
----            , r.dim_school_id as dim_school_id
----            , r.school_id as school_id
----            , r.special_ay_year as special_ay_year
----            , r.ay_value as ay_value
----            , r.dim_discipline_id as dim_discipline_id
----            , r.sub_discipline_name as sub_discipline_name
----            , r.topic as topic
----            , r.course_id as course_id
----            , r.course_instructor_id as course_instructor_id
----            , r.dim_section_id as dim_section_id
----            , r.section_instructor_id as section_instructor_id
----            , r.registrations as registrations
----            , COALESCE(SUM(r.REGISTRATIONS) OVER (PARTITION BY r.dim_school_id),0) as lifetime_cg_reg
----            , COALESCE(SUM(r.REGISTRATIONS) OVER (PARTITION BY r.dim_school_id, r.special_ay_year),0) as annual_cg_reg
----            , COALESCE(SUM(r.REGISTRATIONS) OVER (PARTITION BY r.dim_school_id, r.special_ay_year, r.topic),0) as annual_topic_cg_reg
----            , COALESCE(COUNT(DISTINCT r.course_id) OVER (PARTITION BY r.dim_school_id),0) as school_courses
----            , COALESCE(COUNT(DISTINCT r.course_id) OVER (PARTITION BY r.dim_school_id, r.special_ay_year),0) as annual_school_courses
----            , COALESCE(COUNT(DISTINCT r.course_id) OVER (PARTITION BY r.dim_school_id, r.special_ay_year, r.topic),0) as annual_school_topic_courses
----            , COALESCE(COUNT(DISTINCT r.dim_section_id) OVER (PARTITION BY r.dim_school_id),0) as school_sections
----            , COALESCE(COUNT(DISTINCT r.dim_section_id) OVER (PARTITION BY r.dim_school_id, r.special_ay_year),0) as annual_school_sections
----            , COALESCE(COUNT(DISTINCT r.dim_section_id) OVER (PARTITION BY r.dim_school_id, r.special_ay_year, r.topic),0) as annual_school_topic_sections
----            , COALESCE(COUNT(DISTINCT r.topic) OVER (PARTITION BY r.dim_school_id),0) as school_topics
----            , COALESCE(COUNT(DISTINCT r.topic) OVER (PARTITION BY r.dim_school_id, r.special_ay_year),0) as annual_school_topics
----            , COALESCE(COUNT(DISTINCT r.course_instructor_id) OVER (PARTITION BY r.dim_school_id),0) AS course_instructors
----            , COUNT(DISTINCT r.course_id) OVER (PARTITION BY r.course_instructor_id) as cg_crs_instructor_courses
----            , COUNT(DISTINCT r.dim_section_id) OVER (PARTITION BY r.course_instructor_id) as cg_crs_instructor_sections
----            , COUNT(DISTINCT r.special_ay_year) OVER (PARTITION BY r.course_instructor_id) as cg_crs_instructor_ays
----            , COUNT(DISTINCT r.topic) OVER (PARTITION BY r.course_instructor_id) as cg_crs_instructor_topics
----            , COALESCE(SUM(r.REGISTRATIONS),0) AS cg_registrations_sum
----    FROM ${__zcm_lifetime_view.SQL_TABLE_NAME} as r
----        WHERE (r.ay_value >= -{% parameter __zcm_targeted_view.date_range_ay %} )
----        AND ((UPPER(r.SUB_DISCIPLINE_NAME ) IN ('LIBERAL ARTS MATHEMATICS', 'COLLEGE ALGEBRA', 'INTRODUCTORY STATISTICS')))
----    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
 ;;
  }

###############################################
########## FIELDS IN VIEW IN EXPLORE ##########
###############################################

  dimension: dim_school_id {
    label: "              Dim School ID"
    hidden: no
#     group_label: "           Targeted Dimensions"
    view_label: "    Core Gateway View"
  }

  dimension: special_ay_year  {
    label: "            Academic Year"
    hidden: no
#    group_label: "           Targeted Dimensions"
    view_label: "    Core Gateway View"
  }


  dimension: topic {
    label: "         Course Topic"
    description: "Similar to Sub-Discipline, but extracts and groups courses using Algebra and Trig products out of Dev Math and into their own topic category"
#    group_label: "           Targeted Dimensions"
    view_label: "    Core Gateway View"
  }

  dimension: course_instructor_id {
    label: "     Course Instructor ID"
    #   group_label: "           Targeted Dimensions"
    view_label: "    Core Gateway View"
    drill_fields: [_zcm_topic_filter.topic, course_id, _zcm_topic_filter.topic_group, dim_section.course_instructor_name, dim_section.course_instructor_email
      ,  section_id, dim_section.section_instructor_name, dim_section.section_instructor_email, dim_time.special_ay_year]
  }


  dimension: crs_instructor_name {
    label: "     Course Instructor Name"
#    group_label: "           Targeted Dimensions"
    view_label: "    Core Gateway View"
    drill_fields: [_zcm_topic_filter.topic, course_id, _zcm_topic_filter.topic_group, dim_section.course_instructor_name, dim_section.course_instructor_email
      ,  section_id, dim_section.section_instructor_name, dim_section.section_instructor_email, dim_time.special_ay_year]
  }


  dimension: fact_registration_id   {hidden: yes sql: ${TABLE}.FACT_REGISTRATION_ID;; primary_key: no}
  dimension: dim_time_id            {hidden: yes sql: ${TABLE}.DIM_TIME_ID;;}
  dimension: dim_section_id         {hidden: yes sql: ${TABLE}.DIM_SECTION_ID;;}
  dimension: sso_guid               {hidden: yes sql: ${TABLE}.SSO_GUID;;}
  dimension: school_id              {hidden: yes sql: ${TABLE}.SCHOOL_ID            ;; view_label: "    Core Gateway View"}
  dimension: section_id             {hidden: yes sql: ${TABLE}.SECTION_ID           ;;}
  dimension: dim_textbook_id        {hidden: yes sql: ${TABLE}.DIM_TEXTBOOK_ID      ;;}
  dimension: course_id              {hidden: yes sql: ${TABLE}.COURSE_ID            ;;}
  dimension: registrations          {hidden: yes sql: ${TABLE}.REGISTRATIONS        ;;}
  dimension: count                  {hidden: yes sql: ${TABLE}.COUNT                ;;}
  dimension: user_id                {hidden: yes sql: ${TABLE}.USER_ID              ;;}
  dimension: section_instructor_id  {hidden: yes sql: ${TABLE}.SECTION_INSTRUCTOR_ID;;}
  dimension: username               {hidden: yes sql: ${TABLE}.USERNAME             ;;}



###############################################
######## KEYS AND IDENTIFIERS (HIDDEN) ########
###############################################

  dimension: pk1_fact_registration_id {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.fact_registration_id ;;
  }

  dimension: fk2_ay_key {
    description: "Key for institution/academic year level"
    hidden: yes
    primary_key: no
    sql: nullif(hash(${dim_school_id},'|',${special_ay_year}),0) ;;
  }

  dimension: fk3_topic_key {
    description: "Key for Institution/academic year/course sub-discipline level"
    hidden: yes
    primary_key: no
    sql: nullif(hash(${dim_school_id},'|',${special_ay_year},'|',${topic}),0) ;;
  }

  dimension: fk2_instructor_school_key {
    description: "Key for Institution/Instructor to join with instructor ranking table"
    hidden: yes
    primary_key: no
    sql: nullif(hash(${course_instructor_id},'|',${dim_school_id}),0) ;;
  }

  dimension: fk3_course_section_ay_key {
    hidden: yes
    sql: nullif(hash(${dim_section_id},'|',${course_instructor_id},'|',${special_ay_year}),0) ;;
  }

  dimension: ay_value  {
    label: "Academic Year Relative Value"
    description: "Assigns a numeric value to the academic year with 0 as the current ongoing year, -1 as the prior (complete) year, -2 as two years ago. Used in calculations and code as a relative reference that changes as time passes "
    hidden: yes
  }
#     dimension: dim_school_id {
#       hidden: yes
#       group_label: "School"
#     }
  dimension: dim_discipline_id  {
    hidden: yes
    group_label: "Discipline"
  }


###############################################
########### ENTITY COUNTS #####################
###############################################
  measure: school_count {
    label: "                # Schools"
    view_label: "    Core Gateway View"
    type: count_distinct
    sql: ${dim_school_id} ;;
  }
  measure: course_id_count {
    label: "          # Courses"
    view_label: "    Core Gateway View"
    type: count_distinct
    sql: ${course_id} ;;
  }

  measure: dim_section_id_count {
    label: "         # Sections"
    view_label: "    Core Gateway View"
    type: count_distinct
    sql: ${dim_section_id} ;;
  }
  measure: ay_count {
    label: "      # Academic Years"
    view_label: "    Core Gateway View"
    type: count_distinct
    sql: ${ay_value} ;;
  }
  measure: topic_count {
    label: "       # Course Topics"
    view_label: "    Core Gateway View"
    type: count_distinct
    sql: ${topic} ;;
  }
  measure: course_instructor_count {
    label: "    # Course Instructors"
    view_label: "    Core Gateway View"
    type: count_distinct
    sql: ${course_instructor_id} ;;
  }
  measure: section_instructor_count {
    label: " # Section Instructors"
    view_label: "    Core Gateway View"
    type: count_distinct
    sql: ${section_instructor_id} ;;
  }




###############################################
######### PRE-AGGREGATED DIMENSIONS ###########
###############################################


#################################### SCHOOL LEVEL AGGREGATES ##########################################

  dimension: school_courses {
    type: number
    label: "                                  # School Courses"  #34
    description: "Rolled up measures aggregated at the institution level for all potential redesign course topics targeting more recent academic years (can be tweaked with the 'Select Targeted Academic Years' parameter)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "    Core Gateway View"
    drill_fields: [school_id, course_id]
  }

  dimension: school_sections {
    type: number
    label: "                                 # School Sections" #31
    description: "Rolled up measures aggregated at the institution level for all potential redesign course topics targeting more recent academic years (can be tweaked with the 'Select Targeted Academic Years' parameter)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "    Core Gateway View"
    drill_fields: [dim_school_id, dim_school.name, dim_section_id, dim_time_id, dim_time.timedate ]
  }

  dimension: school_topics {
    type: number
    label: "                            # School Course Topics"  #28
    description: "Rolled up measures aggregated at the institution level for all potential redesign course topics targeting more recent academic years (can be tweaked with the 'Select Targeted Academic Years' parameter)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "    Core Gateway View"
  }

  dimension: school_registrations  {
    type: number
    label: "                          # School Registrations"  #26
    description: "Rolled up measures aggregated at the institution level for all potential redesign course topics targeting more recent academic years (can be tweaked with the 'Select Targeted Academic Years' parameter)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "    Core Gateway View"
  }

  dimension: school_ays             {
    type: number
    label: "                          # School Academic Years"  #26
    description: "Rolled up measures aggregated at the institution level for all potential redesign course topics targeting more recent academic years (can be tweaked with the 'Select Targeted Academic Years' parameter)"
    group_label: "     Pre-Aggregated Dimensions - School"
    view_label: "    Core Gateway View"
  }




#################################### COURSE INSTRUCTOR LEVEL AGGREGATES ##########################################

  dimension: crs_instructor_courses         {
    type: number
    label: "          # Instructor Courses"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "    Core Gateway View"
  }

  dimension: crs_instructor_sections         {
    type: number
    label: "       # Instructor Sections"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "    Core Gateway View"
  }

  dimension: crs_instructor_ays              {
    type: number
    label: "     # Instructor Academic Yrs"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "    Core Gateway View"
  }

  dimension: crs_instructor_topics           {
    type: number
    label: "      # Instructor Course Topics"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "    Core Gateway View"
  }

  dimension: crs_instructor_registrations {
    type: number
    label: "     # Instructor Registrations"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "    Core Gateway View"
  }

  dimension: crs_instructor_sect_instructors {
    type: number
    label: "# Section Instructors Managed"
    description: "The number of distinct section instructors teaching in a course instructor's courses"
    group_label: "    Pre-Aggregated Dimensions - Instructor"
    view_label: "    Core Gateway View"
  }


############################# END PRE-AGGREGATED DIMENSIONS #####################################


#   dimension: cg_crs_instructor_courses      {type: number group_label: "   Instructor Aggregates" label: "Course Instructor Courses"}
#   dimension: cg_crs_instructor_sections     {type: number group_label: "   Instructor Aggregates" label: "Course Instructor Sections"}
#   dimension: cg_crs_instructor_ays          {type: number group_label: "   Instructor Aggregates" label: "Course Instructor AYs"}
#   dimension: cg_crs_instructor_topics       {type: number group_label: "   Instructor Aggregates" label: "Course Instructor Topics Taught"}


###############################################
######## KEYS AND IDENTIFIERS (HIDDEN) ########
###############################################

# dimension: pk1_fact_registration_id {
#   primary_key: yes
#   hidden: yes
#   sql: ${TABLE}.fact_registration_id ;;
# }
#
# dimension: fk2_ay_key {
#   description: "Key for institution/academic year level"
#   hidden: yes
#   primary_key: no
#   sql: nullif(hash(${dim_school_id},'|',${special_ay_year}),0) ;;
# }
#
# dimension: fk3_topic_key {
#   description: "Key for Institution/academic year/course sub-discipline level"
#   hidden: yes
#   primary_key: no
#   sql: nullif(hash(${dim_school_id},'|',${special_ay_year},'|',${topic}),0) ;;
# }
#
# dimension: fk4_section_key {
#   description: "Key for Institution/academic year/course sub-discipline level"
#   hidden: yes
#   primary_key: no
#   sql: nullif(hash(${dim_school_id},'|',${special_ay_year},'|',${topic},'|',${dim_section_id}),0) ;;
# }
#
# dimension: dim_section_id {
#   hidden: yes
# #  group_label: "        Core Gateway Dimensions"
#   }
#
#
#
# dimension: dim_school_id {
#   hidden: yes
#   }
#
# dimension: dim_discipline_id  {
#   hidden: yes
#   }
#
#   dimension: ay_start_year {
#     hidden: yes
#     type: number
#     sql: left(${special_ay_year},4) ;;
#   }
#
#   dimension: ay_end_year {
#     hidden: yes
#     type: number
#     sql: right(${special_ay_year},4) ;;
#   }
#
#
#
# ###############################################
# ########## FIELDS IN VIEW IN EXPLORE ##########
# ###############################################
#


#   parameter: accgr_threshold {
#     label: "Set the ACCGR Threshold"
#     description: "Set the Annual Combined Core Gateway Course Registration Threshold. This is the enrollments threshold to include institutions and is the sum of Registrations for Core Gateway Courses (Liberal Arts Math, College Algebra, and Intro Stats) for an academic year. The default is >= 1,000 registrations in an academic year"
#     default_value: "1000"
#     type: number
#     view_label: "           Parameters & Filters"
#   }
#
#           dimension: meets_accgr_threshold {
#             label: "> ACCGR Threshold?"
#             description: "Indicates whether or not a school met the Annual Combined Core Gateway Registration (AC-CGR) threshold for a given academic year."
#             type: yesno
#             view_label: "           Parameters & Filters"
#             sql:
#                            zeroifnull(${TABLE}.annual_cg_reg) >= {% parameter accgr_threshold %};;
#             hidden: yes
#           }
#



# dimension: school_id {
#   label: "         School ID"
# #  group_label: "        Core Gateway Dimensions"
#   }
#
# dimension: special_ay_year {
#   label: "        Academic Year"
# #  group_label: "        Core Gateway Dimensions"
#   }
#
# dimension: ay_value {
#     type: number
#     hidden: yes
# #    group_label: "        Core Gateway Dimensions"
#   }
#
# dimension: sub_discipline_name {
#   label: "       Sub-Discipline Name"
# #  group_label: "        Core Gateway Dimensions"
#   hidden: yes
#   }
#
# dimension: topic {
#   label: "       Course Topic"
#   description: "Similar to Sub-Discipline, but extracts and groups courses using Algebra and Trig products out of Dev Math and into their own topic category"
# #  group_label: "        Core Gateway Dimensions"
#   }
#
# dimension: course_id {
#   hidden: yes
# }
#
#
#   dimension: course_instructor_id {
#     hidden: no
#   }
#
#   dimension: section_instructor_id {
#     hidden: yes
#   }
#
#   dimension: crs_instructor_name {
#     hidden: no
#     label: "Course Instructor Name"
#   }


# ###############################################
# ########### ENTITY COUNTS #####################
# ###############################################
#
#   measure: course_instructor_count {
#     label: "# Course Instructors"
#     type: count_distinct
#     sql: ${course_instructor_id} ;;
#   }
#
#   measure: section_instructor_count {
#     label: "# Section Instructors"
#     type: count_distinct
#     sql: ${section_instructor_id} ;;
#   }
#
#   measure: course_id_count {
#     label: "# Courses"
#     type: count_distinct
#     sql: ${course_id} ;;
#   }
#
#   measure: dim_section_id_count {
#     label: "# Sections"
#     type: count_distinct
#     sql: ${dim_section_id} ;;
#   }
#
#   measure: school_count {
#     type: count_distinct
#     sql: ${dim_school_id} ;;
#   }

###############################################
######### PRE-AGGREGATED DIMENSIONS ###########
###############################################


############## LIFETIME AGGREGATES ##################

#   dimension: school_courses {
#     type: number
#     label: "            C. Gateway Courses" #12
#     description: "Rolled up measures aggregated at the institution level for the 3 Core Gateway (CG) Courses for TARGETED Academic Years (can be set with the 'Select Targeted Academic Years' parameter. default = 3)"
#     group_label: "    Course Aggregations"
#     hidden: no
#   }
#
#   dimension: school_sections {
#     type: number
#     label: "         C. Gateway Sections" #9
#     description: "Rolled up measures aggregated at the institution level for the 3 Core Gateway (CG) Courses for TARGETED Academic Years (can be set with the 'Select Targeted Academic Years' parameter. default = 3)"
#     group_label: "    Course Aggregations"
#     hidden: no
#     sql: zeroifnull(${TABLE}.school_sections) ;;
#   }
#
#   dimension: school_topics {
#     type: number
#     label: "      C. Gateway Topics"  #6
#     description: "Rolled up measures aggregated at the institution level for the 3 Core Gateway (CG) Courses for TARGETED Academic Years (can be set with the 'Select Targeted Academic Years' parameter. default = 3)"
#     group_label: "   Topic Aggregations"
#     hidden: no
#   }
#
#   dimension: lifetime_cg_reg {
#     type: number
#     label: "    C. Gateway Registrations" #4
#     description: "Rolled up measures aggregated at the institution level for the 3 Core Gateway (CG) Courses for TARGETED Academic Years (can be set with the 'Select Targeted Academic Years' parameter. default = 3)"
#     group_label: "  Registration Aggregations"
#     hidden: no
#   }
#
#
#   measure: avg_school_courses {
#     type: average
#     label: "    Average C. Gateway Courses"
#     group_label: "    Lifetime Averages"
#     sql: ${school_courses} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_school_sections {
#     type: average
#     label: "   Average C. Gateway Sections"
#     group_label: "    Lifetime Averages"
#     sql: ${school_sections} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_school_topics {
#     type: average
#     label: "  Average C. Gateway Topics Taught"
#     group_label: "    Lifetime Averages"
#     sql: ${school_topics} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_lifetime_cg_reg {
#     type: average
#     label: " Average C. Gateway Registrations"
#     group_label: "    Lifetime Averages"
#     sql: ${lifetime_cg_reg} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#
# ############## ANNUAL AGGREGATES ####################
#
#   dimension: annual_school_courses {
#     type: number
#     label: "           C. Gateway An Courses" #11
#     description: "Measures aggregated at the institution level and broken out by academic year for the 3 Core Gateway (CG) Courses and the Targeted Academic Years"
#     group_label: "    Course Aggregations"
#   }
#   dimension: annual_school_sections {
#     type: number
#     label: "        C. Gateway An Sections" #8
#     description: "Measures aggregated at the institution level and broken out by academic year for the 3 Core Gateway (CG) Courses and the Targeted Academic Years"
#     group_label: "    Course Aggregations"
#   }
#   dimension: annual_school_topics {
#     type: number
#     label: "     C. Gateway An Topics" #5
#     description: "Measures aggregated at the institution level and broken out by academic year for the 3 Core Gateway (CG) Courses and the Targeted Academic Years"
#     group_label: "   Topic Aggregations"
#     drill_fields: [topic_drill*]
#   }
#   dimension: annual_cg_reg  {
#     type: number
#     label: "   C. Gateway An Registrations" #3
#     description: "Measures aggregated at the institution level and broken out by academic year for the 3 Core Gateway (CG) Courses and the Targeted Academic Years"
#     group_label: "  Registration Aggregations"
#     sql: zeroifnull(${TABLE}.annual_cg_reg) ;;
#     }
#
#
#   measure: avg_annual_school_courses {
#     type: average
#     label: "    Average Annual Courses"
#     group_label: "   Annual Averages"
#     sql: ${annual_school_courses} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_school_sections {
#     type: average
#     label: "   Average Annual Sections"
#     group_label: "   Annual Averages"
#     sql: ${annual_school_sections} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_school_topics {
#     type: average
#     label: "  Average Annual Topics Taught"
#     group_label: "   Annual Averages"
#     sql: ${annual_school_topics} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_cg_reg {
#     type: average
#     label: " Average Annual Registrations"
#     group_label: "   Annual Averages"
#     sql: ${annual_cg_reg} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#
# ############# ANNUAL TOPIC AGGREGATES ##############
#
#   dimension: annual_school_topic_courses {
#     type: number
#     description: "Measures aggregated at the institution level and broken out by course topic and academic year for the 3 Core Gateway (CG) Courses and the Targeted Academic Years"
#     label: "          C. Gateway An Tp Courses" #10
#     group_label: "    Course Aggregations"
#   }
#   dimension: annual_school_topic_sections {
#     type: number
#     description: "Measures aggregated at the institution level and broken out by course topic and academic year for the 3 Core Gateway (CG) Courses and the Targeted Academic Years"
#     label: "       C. Gateway An Tp Sections" #7
#     group_label: "    Course Aggregations"
#   }
#   dimension: annual_topic_cg_reg  {
#     type: number
#     label: "  C. Gateway An Tp Registrations" #2
#     description: "Measures aggregated at the institution level and broken out by course topic and academic year for the 3 Core Gateway (CG) Courses and the Targeted Academic Years"
#     group_label: "  Registration Aggregations"
#   }
#
#
#   measure: avg_annual_school_topic_courses {
#     type: average
#     label: "   Average Annual Courses by Topic"
#     group_label: " Annual Topic Averages"
#     sql: ${annual_school_topic_courses} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_school_topic_sections {
#     type: average
#     label: "  Average Annual Topic Sections"
#     group_label: " Annual Topic Averages"
#     sql: ${annual_school_topic_sections} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#   measure: avg_annual_topic_cg_reg {
#     type: average
#     label: " Average Annual Topic Registrations"
#     group_label: " Annual Topic Averages"
#     sql: ${annual_topic_cg_reg} ;;
#     value_format_name: decimal_1
#     hidden: yes
#   }
#
#
# ############################################################################
# ########################## OTHER FIELDS ####################################
# ############################################################################
#
#
#
#   measure: num_ay_over_threshold_s       {
#     type: number
#     label: "# AYs Over CG Threshold"
#     #     view_label: " School & Academic Year Aggregations"
#     group_label: "Core Gateway Courses"
#     description: "School/AY Level. Number of AY's (2015-present) where registrations for Core Gateway Courses were greater than the Annual Combined Enrollment threshold (default = 1,000 registrations)"
#     sql: count(DISTINCT CASE WHEN ${meets_accgr_threshold} = 'Yes' THEN ${special_ay_year} ELSE NULL END) ;;
#     }
#
#   measure: most_recent_ay_over_threshold {
#     type: string
#     label: "Recent AY Over CG Threshold"
#     #     view_label: " School & Academic Year Aggregations"
#     group_label: "Core Gateway Courses"
#     description: "School/AY Level. Most recent AY where combined annual registrations for core gateway courses were greater than threshold (default = 1,000)"
#     sql: max(CASE WHEN ${meets_accgr_threshold} = 'Yes' THEN ${special_ay_year} ELSE NULL END) ;;
#     hidden: no
#     }
#
#   measure: most_recent_ay_over_threshold_value {
#     type: number
#     label: "Recent AY Over CG Threshold (Value)"
#     #     view_label: " School & Academic Year Aggregations"
#     group_label: "Core Gateway Courses"
#     description: "School/AY Level. Most recent AY where combined annual registrations for core gateway courses were greater than threshold (default = 1,000)"
#     sql: max(CASE WHEN ${meets_accgr_threshold} = 'Yes' THEN ${ay_value} ELSE NULL END) ;;
#     hidden: yes
#   }
#
#   measure: first_ay_over_threshold       {
#     type: string
#     label: "First AY Over CG Threshold"
#     #     view_label: " School & Academic Year Aggregations"
#     group_label: "Core Gateway Courses"
#     description: "School/AY Level. First AY where combined annual registrations for core gateway courses were greater than threshold (default = 1,000)"
#     sql: min(CASE WHEN ${meets_accgr_threshold} = 'Yes' THEN ${special_ay_year} ELSE NULL END)  ;;
#     hidden: no
#     }
#
#   measure: first_ay_over_threshold_value       {
#     type: number
#     label: "First AY Over CG Threshold (Value)"
#     #     view_label: " School & Academic Year Aggregations"
#     group_label: "Core Gateway Courses"
#     description: "School/AY Level. First AY where combined annual registrations for core gateway courses were greater than threshold (default = 1,000)"
#     sql: min(CASE WHEN ${meets_accgr_threshold} = 'Yes' THEN ${ay_value} ELSE NULL END)  ;;
#     hidden: yes
#   }
#
#
#   measure: total_combined_cgr {
#     type: sum_distinct
#     #     view_label: " School & Academic Year Aggregations"
#     group_label: "Core Gateway Courses"
#     sql_distinct_key: ${fk3_topic_key} ;;
#     sql: ${annual_cg_reg} ;;
#   }
#
#
#
#
# #############################################################################################################################################
# ########################                           Counts & Sums                                   ##########################################
# #############################################################################################################################################
#
#
#
#   measure: num_cg_ays  {
#     #     group_label: "Count Sums"
#     label: "# CG Academic Yrs."
#     type: count_distinct
#     sql: ${TABLE}.special_ay_year ;;
#   }
#
#   measure: num_cg_topics  {
#     #     group_label: "Count Sums"
#     label: "# CG Topics  Taught"
#     type: count_distinct
#     sql: ${TABLE}.topic ;;
#   }
#
#   measure: num_cg_courses  {
#     #     group_label: "Count Sums"
#     label: "# CG Courses"
#     type: count_distinct
#     sql: ${TABLE}.course_id ;;
#   }
#
#   measure: num_cg_crs_instructors  {
#     #     group_label: "Count Sums"
#     label: "# CG Course Instructors"
#     type: count_distinct
#     sql: ${TABLE}.course_instructor_id ;;
#   }
#
#   measure: num_cg_sections  {
#     #     group_label: "Count Sums"
#     label: "# CG Sections"
#     type: count_distinct
#     sql: ${TABLE}.dim_section_id ;;
#   }
#
#   measure: num_cg_sect_instructors  {
#     #     group_label: "Count Sums"
#     label: "# CG Section Instructors"
#     type: count_distinct
#     sql: ${TABLE}.section_instructor_id ;;
#   }
#
#   measure: num_cg_registrations {
#     type: sum
#     label: "# CG Registrations"
#     sql: ${TABLE}.registrations ;;
#   }
#


#############################################################################################################################################
########################                           OTHER AGGREGATES                                ##########################################
#############################################################################################################################################






  set: topic_drill {
    fields: [dim_school.name, topic,  special_ay_year, dim_section_zcm.course_count, dim_section.section_count, fact_registration.user_registrations]
  }
  set: section_drill {
    fields: [dim_school.name, topic, special_ay_year, dim_section.course_id, dim_section.course_name, dim_section.course_instructor_name, dim_section.dim_section_id, dim_section.section_instructor_name, dim_section.roster]
}
}
