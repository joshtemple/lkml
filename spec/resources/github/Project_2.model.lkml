connection: "snowflake_poc_staging"

# include all the views
#include: "/views/**/*.view"
include: "*.view.lkml"
#include: "*.view.lkml"
case_sensitive: no


explore: abc {
  label: "Excercise2"
  group_label: "Training"
  join: Excercise3 {

    # Define the join conditions between the "lesson_5_cohorts" view and the "lesson_5_names" view
    sql_on:
      ${abc.category}= ${Excercise3.category} ;;

    # Define the join relationship between the "lesson_5_names" view and the
    #   "lesson_5_cohorts" view
      relationship: one_to_many
    }
  }
