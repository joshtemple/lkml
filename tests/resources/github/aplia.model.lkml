connection: "snowflake_prod"
# label:"Source Data on Snowflake"
# include: "//core/common.lkml"
#
# include: "*.view.lkml"         # include all views in this project
# # include: "*.dashboard.lookml"  # include all dashboards in this project
# include: "dims.lkml"
# include: "//project_source/*.view.lkml"
# # # Select the views that should be a part of this model,
# # # and define the joins that connect them together.
# #
# # APLIA
# explore: aplia_course_map {
#   extends: [dim_course]
#   label: "Aplia - Course"
#
#   join: apliacontext {
#     sql_on: ${apliacontext.guid}=${aplia_course_map.guid} ;;
#     relationship: one_to_one
#   }
#
#   join: apliacontent{
#     sql_on: ${apliacontent.context_guid} = ${aplia_course_map.guid} ;;
#     relationship: one_to_many
#   }
#
#   join: course {
#     sql_on: ${course.course_id} = ${aplia_course_map.course_id} ;;
#     relationship: one_to_many
#   }
#
#   join: problem {
#     sql_on: ${apliacontent.guid} = ${problem.problem_set_guid};;
#     relationship: one_to_many
#   }
#
#   join: answer{
#     sql_on: ${problem.guid} = ${answer.problem_guid};;
#     relationship: one_to_many
#   }
#
#   join: assignment{
#     sql_on: ${assignment.guid} = ${apliacontent.assignment_guid} ;;
#     relationship: one_to_many
#   }
#
#   join: instructor {
#     from: membership
#     view_label: "Instructors"
#     sql_on: ${course.guid} = ${instructor.context_guid} and ${instructor.role_guid} = 'ROLE041651A500E908EF3A1E80000000' ;;
#     relationship: one_to_many
#   }
#   join:  instructor_apliauser {
#     from: apliauser
#     view_label: "Instructors"
#     sql_on: ${instructor.user_guid} = ${instructor_apliauser.guid};;
#     relationship: one_to_one
#   }
#
#   join: student {
#     from: membership
#     view_label: "Students"
#     sql_on: ${course.guid} = ${student.context_guid} and ${student.role_guid} = 'ROLE041651A500E908EE3FFE80000000' ;;
#     relationship: one_to_many
#   }
#
#   join:  student_apliauser {
#     from: apliauser
#     view_label: "Students"
#     sql_on: ${student.user_guid} = ${student_apliauser.guid};;
#     relationship: one_to_one
#   }
#
#   join: dim_course {
#     view_label: " Cube - Course/Section"
#     #use reg_key = coursekey
#     #sql_on: case when ${aplia_course_map.mindtap_course_yn} > 0 then ${apliacontext.reg_key} else ${apliacontext.context_id} end = ${dim_course.coursekey};;
#     sql_on: ${apliacontext.reg_key} = ${dim_course.olr_course_key} ;;
#     relationship: many_to_one
#   }
#
#   join: dim_filter {
#     view_label: " Cube - Course/Section"
#   }
#
#   join: dim_product {
#     view_label: " Cube - Product"
#   }
#
#   join: dim_productplatform {
#     view_label: " Cube - Product"
#   }
#
#   join: products {
#     view_label: " Cube - Product"
#   }
#
#   join: dim_institution {
#     view_label: " Cube - Institution"
#   }
#
#   join: dim_location {
#     view_label: " Cube - Institution"
#   }
#
#   join: dim_start_date {
#     view_label: " Cube - Course Start Date"
#   }
#
#   join: course_section_facts {
#     view_label: " Cube - Activations"
#   }
#
#   join: product_facts {
#     view_label: " Cube - Activations"
#   }
#
# }
#
# explore: problem {
#   extends: [dim_course]
#   label: "Aplia - Problem"
#
#   join: apliacontent{
#     sql_on: ${problem.problem_set_guid} = ${apliacontent.guid} ;;
#     relationship: many_to_one
#   }
#   join: aplia_course_map {
#     #sql: right join ${aplia_course_map.SQL_TABLE_NAME} on ${aplia_course_map.guid} = ${apliacontent.context_guid} ;;
#     sql_on: ${aplia_course_map.guid} = ${apliacontent.context_guid} ;;
#     relationship: many_to_one
#   }
#   join: course {
#     sql_on: ${course.course_id} = ${aplia_course_map.course_id} ;;
#     relationship: one_to_one
#   }
#
#   join: answer{
#     sql_on: ${answer.problem_guid} = ${problem.guid} ;;
#     relationship: one_to_many
#   }
#   join: assignment{
#     sql_on: ${assignment.guid} = ${apliacontent.assignment_guid} ;;
#     relationship: one_to_many
#   }
#
#   join: apliacontext {
#     sql_on: ${apliacontext.guid}=${aplia_course_map.guid} ;;
#     relationship: one_to_many
#   }
#
#    join:  membership {
#      sql_on: ${course.guid} = ${membership.context_guid} ;;
#      relationship: one_to_many
#    }
#    join: instructor {
#      from: membership
#      view_label: "Instructors"
#      sql_on: course.guid = instructor.context_guid and instructor.role_guid = 'ROLE041651A500E908EF3A1E80000000' ;;
#     relationship: one_to_many
#    }
#    join:  apliauser {
#      sql_on: ${membership.user_guid} = ${apliauser.guid}
#      AND user_id not like '%aplia.com'
#      AND user_id not like  '%cengage.com';;
#      relationship: many_to_one
#    }
#
#    join: student {
#      from: membership
#      view_label: "Students"
#      sql_on: course.guid = student.context_guid and student.role_guid = 'ROLE041651A500E908EE3FFE80000000' ;;
#      # count(student) > 2 - filter internal data
#      relationship: one_to_many
#    }
#
#   join: dim_course {
#     view_label: " Cube - Course/Section"
#     #use reg_key = coursekey
#     #sql_on: case when ${aplia_course_map.mindtap_course_yn} > 0 then ${apliacontext.reg_key} else ${apliacontext.context_id} end = ${dim_course.coursekey};;
#     sql_on: ${apliacontext.reg_key} = ${dim_course.olr_course_key} ;;
#     relationship: many_to_one
#   }
#
#   join: dim_filter {
#     view_label: " Cube - Course/Section"
#   }
#
#   join: dim_product {
#     view_label: " Cube - Product"
#   }
#
#   join: dim_productplatform {
#     view_label: " Cube - Product"
#   }
#
#   join: products {
#     view_label: " Cube - Product"
#   }
#
#   join: dim_institution {
#     view_label: " Cube - Institution"
#   }
#
#   join: dim_location {
#     view_label: " Cube - Institution"
#   }
#
#   join: dim_start_date {
#     view_label: " Cube - Course Start Date"
#   }
#
#   join: course_section_facts {
#     view_label: " Cube - Activations"
#   }
#
#   join: product_facts {
#     view_label: " Cube - Activations"
#   }
#
# }
