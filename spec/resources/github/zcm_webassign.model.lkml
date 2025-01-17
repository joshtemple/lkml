
#connection: "snowflake_webassign"

# include the model and all the views from webassign project, all the views from the zcm_webassign project, & dashboards
 include: "//webassign/*.model.lkml"
include: "//webassign/webassign.dims.model.lkml"
include: "/zcm_webassign/fact_registration_zcm.view.lkml"
include: "/zcm_webassign/dim_time_zcm.view.lkml"
include: "/zcm_webassign/responses_zcm.view.lkml"
include: "/zcm_webassign/dim_assignment_zcm.view.lkml"
include: "/zcm_webassign/dim_question_zcm.view.lkml"
include: "/zcm_webassign/dim_deployment_zcm.view.lkml"
include: "/zcm_webassign/dim_section_zcm.view.lkml"
include: "/zcm_webassign/dim_school_zcm.view.lkml"
include: "/zcm_webassign/zcm_question_is_used.view.lkml"
include: "/zcm_webassign/zcm_topquestions.view.lkml"
include: "/zcm_webassign/zcm_cross_view_fields.view.lkml"
include: "/zcm_webassign/questions_zcm.view.lkml"
include: "/zcm_webassign/questions_used_notused.view.lkml"
##include: "/core/common.lkml"
include: "//webassign/*.view.lkml"
# include: "/zcm_webassign/*.view.lkml"
include: "//webassign/dim_deployment.view.lkml"
##include: "*.dashboard"



# datagroup: zcm_webassign_default_datagroup {
#    sql_trigger: select count(*) from wa_app_activity.RESPONSES;;
#   #max_cache_age: "1 hour"
# }
persist_with: responses_datagroup




#####################################################################################
################################### ACTIVATIONS #####################################
#####################################################################################

explore: fact_registration_zcm {
  extends: [fact_registration]
  from: fact_registration_zcm
  label: "Activations - ZCM"

# DOES NOT WORK TO HAVE MULTIPLE DISCIPLINE CONNECTIONS WITH ZCM_GATEWAY_COURSES VIEW
  join: dim_discipline {
    from: dim_discipline
    view_label: "Discipline - Textbook"
#     type: left_outer
#     relationship: one_to_one
    sql_on: ${dim_textbook.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
  }

  join: dim_discipline_section {
    from: dim_discipline
    view_label: "Discipline - Section"
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_section.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
  }

  join: dim_time {
    from: dim_time_zcm
    sql_on: ${fact_registration.dim_time_id} = ${dim_time.dim_time_id} ;;
    relationship: many_to_one
    type: inner
  }

#   join: zcm_gateway_courses {
#     relationship: many_to_one
#     sql_on: ${dim_section.course_id} = ${zcm_gateway_courses.course_id}
#         AND ${dim_discipline.dim_discipline_id} = ${zcm_gateway_courses.dim_discipline_id}
#         AND ${dim_textbook.dim_textbook_id} = ${zcm_gateway_courses.dim_textbook_id}
#         AND ${dim_school.dim_school_id} = ${zcm_gateway_courses.dim_school_id}
#         ;;
#}

}



#####################################################################################
################## RESPONSES (ONLY INCLUDES QUESTIONS USED) #########################
#####################################################################################




explore: responses_zcm {
  extends: [responses]  #, dim_question, dim_deployment]
  from: responses_zcm
  view_name: responses
  label: "Student Take Analysis - ZCM"
  sql_always_where: ${dim_school.type} IN ('Community College', 'University')  ;;


  join: dim_assignment {
    from: dim_assignment_zcm
    view_label: "Assignments"
  }

  join: dim_question {
    from: dim_question_zcm
    view_label: "Question"
  }

  join: dim_deployment {
    from: dim_deployment_zcm
    view_label: "Deployment"
  }

  join: dim_section {
    from: dim_section_zcm
    view_label: "Section"
  }

  join: dim_school {
    from: dim_school_zcm
    view_label: "School"
  }

  join: dim_discipline {
    from: dim_discipline
    view_label: "Discipline - Textbook"
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_textbook.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
  }

  join: dim_discipline_section {
    from: dim_discipline
    view_label: "Discipline - Section"
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_section.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
  }


join: zcm_question_is_used {
  sql_on: ${dim_question.dim_question_id}=${zcm_question_is_used.dim_question_id} ;;
  relationship: one_to_one
  }

# join: zcm_question_help_features {
#     sql_on: ${dim_question.dim_question_id} = ${zcm_question_help_features.dim_question_id} ;;
#     relationship: one_to_many
#     type: left_outer
#   }

  join: zcm_topquestions {
    sql_on: ${dim_question.dim_question_id} = ${zcm_topquestions.dim_question_id} ;;
    relationship: one_to_one
  }

  join: zcm_cross_view_fields {
    relationship: one_to_one
    sql:  ;;
  }

  }


#####################################################################################
################## ALL QUESTIONS + RESPONSES ON USED QUESTIONS ######################
#####################################################################################


explore: responses_all_questions {
  extends: [responses_zcm]
  label: "Responses All Questions"
  join: questions_zcm {
    view_label: "Questions - All"
    type: full_outer
    relationship: many_to_one
    sql_on: ${responses.questionid} = ${questions_zcm.id} ;;
  }
}


#####################################################################################
############################### QUESTIONS - ZCM #####################################
#####################################################################################


explore: questions_zcm {
  persist_for: "100 hours"
  from: questions
  extends: [questions]
  view_name: questions
  label: "Questions - ZCM"

join: questions_used_notused {
  type: left_outer
  relationship: one_to_one
  sql_on: ${questions.id}=${questions_used_notused.id} ;;
}

  join: dim_discipline {
    from: dim_discipline
    view_label: "Discipline - Textbook"
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_textbook.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
  }

  join: dim_discipline_section {
    from: dim_discipline
    view_label: "Discipline - Section"
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_section.dim_discipline_id} = ${dim_discipline.dim_discipline_id} ;;
  }


# join: dim_question {
#   from: dim_question_zcm
#   sql_on: ${questions.id}=${dim_question.question_id} ;;
#   relationship: one_to_one
#   view_label: "Questions Used"
# }

#   join: questions_not_used {
#     from: questions_not_used_zcm
#     view_label: "Questions Not Used"
#   }

#  join: questions_not_used {
#   from: questions_not_used_zcm
#    sql_on: ${questions.id}=${questions_not_used.question_id};;
#    relationship: one_to_one
#    view_label: "Questions Not Used"
#  }
}




#####################################################################################
############################ QUESTIONS NOT USED #####################################
#####################################################################################

explore: questions_not_used_zcm {
  extends: [questions_not_used]
  view_name: questions_not_used
  label: "Questions Not Used - ZCM"

#   join: sectionslessons {
#     sql_on: ${responses.sectionslessonsid} = ${sectionslessons.id} ;;
#     relationship: many_to_one
#   }
}






#####################################################################################
########################## STUDENT SECTION ASSIGNMENTS ##############################
#####################################################################################


explore: sections_students_assignments_zcm {
  extends: [sections_students_assignments]

  # get student results - assignment level
  join: assignment_final {
    view_label: "Result Summary - Assignment"
    sql_on: ${roster.user} = ${assignment_final.userid}
      and ${dim_deployment.deployment_id} = ${assignment_final.deployment_id} ;;
    relationship: one_to_many
  }

  # get student results - question level - final attempt
  join: responses_final {
    view_label: "Result Summary - Question"
    sql_on: ${roster.user} = ${responses_final.userid}
      and ${dim_deployment.deployment_id} = ${responses_final.deployment_id}
      and ${dim_question.question_id} = ${responses_final.questionid}
      and ${assignment_questions.box_num} = ${responses_final.boxnum};;
    relationship: one_to_many
  }

  # get student results - question level - all attempts
  join: responses {
    view_label: "Result Summary - All Attempts"
    sql_on: ${responses_final.userid} = ${responses.userid}
      and ${responses_final.deployment_id} = ${responses.deployment_id}
      and ${responses_final.questionid} = ${responses.questionid}
      and ${responses_final.boxnum} = ${responses.boxnum};;
    relationship: one_to_many
  }

  join: dim_question {
    from: dim_question_zcm
  }

  join: dim_school {
    from: dim_school_zcm
    relationship: many_to_one
    sql_on: ${dim_section.school_id} = ${dim_school.school_id} ;;
  }

  join: zcm_cross_view_fields {
    relationship: one_to_one
    sql:  ;;
}

#   join: zcm_question_help_features {
#     sql_on: ${dim_question.dim_question_id} = ${zcm_question_help_features.dim_question_id} ;;
#     relationship: one_to_many
#     type: left_outer
#   }

}




#####################################################################################
######################### ONE OFF SINGLE VIEW EXPLORES ##############################
#####################################################################################



explore: dim_deployment_zcm {
  extends: [dim_deployment]
  view_name: dim_deployment
}



explore: dim_section_zcm {}
