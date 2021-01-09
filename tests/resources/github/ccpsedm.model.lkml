connection: "edfidev"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }



explore: dim_date {
  label: "Enrollments Explore"
  hidden: yes
  view_label: "Date Table"
  join: fact_student_school_enrollment {
    view_label: "Enrollments"
    sql_on: ${dim_date.date_key} = ${fact_student_school_enrollment.exit_withdraw_type_key} ;;
    relationship: one_to_many
    type: left_outer
  }
  join: dim_school {
    view_label: "Schools"
    sql_on: ${dim_school.school_key} = ${fact_student_school_enrollment.school_key} ;;
    type: left_outer
    relationship: many_to_many
  }
  join: dim_student {
    view_label: "Students"
    sql_on: ${dim_student.student_key} = ${fact_student_school_enrollment.student_key} ;;
    type: left_outer
    relationship: many_to_many
  }
  join: dim_education_organization {
    view_label: "Organizations"
    sql_on: ${dim_education_organization.education_organization_key} = ${dim_school.education_organization_key} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: ref_sex_type {
    view_label: "Students"
    sql_on: ${ref_sex_type.sex_type_key} = ${dim_student.sex_type_key} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: rel_student_race {
    view_label: "Student Race"
    sql_on: ${rel_student_race.student_key} = ${dim_student.student_key} ;;
    relationship: one_to_many
    type: left_outer
  }
  join: ref_race_type {
    view_label: "Race Description"
    sql_on: ${ref_race_type.race_type_key} = ${rel_student_race.race_type_key} ;;
    relationship: one_to_one
    type: inner
  }
  join: ref_grade_level_type {
    view_label: "Grade Level"
    sql_on: ${ref_grade_level_type.grade_level_type_key} = ${fact_student_school_enrollment.grade_level_type_key} ;;
    relationship: many_to_many
    type: left_outer
  }
}


explore: fact_student_school_enrollment {
  label: "Enrollments"
  join: ref_academic_year {
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_student_school_enrollment.academic_year_key} = ${ref_academic_year.academic_year_key} ;;
  }
  join: dim_school {
    view_label: "Schools"
    sql_on: ${dim_school.school_key} = ${fact_student_school_enrollment.school_key} ;;
    type: left_outer
    relationship: many_to_many
  }
  join: dim_student {
    view_label: "Students"
    sql_on: ${dim_student.student_key} = ${fact_student_school_enrollment.student_key} ;;
    type: left_outer
    relationship: many_to_many
  }
  join: dim_education_organization {
    view_label: "Organizations"
    sql_on: ${dim_education_organization.education_organization_key} = ${dim_school.education_organization_key} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: ref_sex_type {
    view_label: "Students"
    sql_on: ${ref_sex_type.sex_type_key} = ${dim_student.sex_type_key} ;;
    relationship: one_to_one
    type: inner
  }
  join: rel_student_race {
    view_label: "Student Race"
    sql_on: ${rel_student_race.student_key} = ${dim_student.student_key} ;;
    relationship: one_to_many
    type: inner
  }
  join: ref_race_type {
    view_label: "Race Description"
    sql_on: ${ref_race_type.race_type_key} = ${rel_student_race.race_type_key} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: ref_grade_level_type {
    view_label: "Grade Level"
    sql_on: ${ref_grade_level_type.grade_level_type_key} = ${fact_student_school_enrollment.grade_level_type_key} ;;
    relationship: many_to_many
    type: left_outer
  }
  join: rel_student_characteristics {
    view_label: "Student Characteristics"
    sql_on: ${rel_student_characteristics.student_key} = ${fact_student_school_enrollment.student_key} ;;
    relationship: many_to_many
    type: inner
  }
  join: ref_student_characteristic {
    view_label: "Student Characteristics"
    sql_on: ${ref_student_characteristic.student_characteristic_key} = ${rel_student_characteristics.student_characteristic_key} ;;
    relationship: one_to_many
    type: left_outer
  }
#    type: left_outer
#    relationship: many_to_one
#    sql_on: ${dim_student.student_c} = ${ref_student_characteristic.student_characteristic_key} ;;
#  }
}


explore: v_student_daily_attendance  {
  label: "Attendance"
  description: "Use this explore for attendance information"
}
