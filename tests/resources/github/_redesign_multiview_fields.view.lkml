include: "*.view.lkml"
include: "zcm_redesign_personas.model.lkml"
include: "//webassign/*.model.lkml"
include: "__zcm_lifetime_view.view.lkml"
include: "__zcm_targeted_view.view.lkml"
include: "__zcm_coregateway_view.view.lkml"
include: "dim_textbook_zcm.view.lkml"
include: "__zcm_lifetime_view.view.lkml"
include: "zcm_redesign_personas.model.lkml"
include: "//webassign/dim_textbook.view.lkml"
include: "//webassign/fact_registration.view.lkml"

view: _redesign_multiview_fields {


#   parameter: date_range_ay {
#     label: "Select Targeted Academic Years"
#     description: "Select how many Academic Years back you want included in the query (Not including the current academic year). Ex: selecting '3' would include the current ongoing academic year plus the prior 3"
#     default_value: "3"
#     view_label: "           Parameters & Filters"
#   }
#
#   parameter: accgr_threshold {
#     label: "Set the ACCGR Threshold"
#     description: "Set the Annual Combined Core Gateway Course Registration Threshold. This is the enrollments threshold to include institutions and is the sum of Registrations for Core Gateway Courses (Liberal Arts Math, College Algebra, and Intro Stats) for an academic year. The default is >= 1,000 registrations in an academic year"
#     default_value: "1000"
#     type: number
#     view_label: "           Parameters & Filters"
#   }


#   measure: ay_included_db_title {
#     type: string
#     view_label: "           Parameters & Filters"
#     hidden:  no
#     description: "For use in dashboards as a dynamic title tile. Useless in explore. Please hide"
#     sql: min(${zcm_school_redesign_registration.ay_start_year}) ;;
#     html: <h2> Academic Years Included: {{ value }}-Present </h2>;;
#   }

  measure: lifetime_ay_included_db_title {
    label: "Lifetime AY Range"
    type: string
    view_label: "           Parameters & Filters"
    hidden:  no
    description: "For use in dashboards as a dynamic title tile. Useless in explore. Please hide"
    sql: min(${fact_registration.ay_start_year}) ;;
    html: <h2> {{ value }}-Present </h2>;;
  }

  measure: targeted_ay_included_db_title {
    label: "Targeted AY Range"
    type: string
    view_label: "           Parameters & Filters"
    hidden:  no
    description: "For use in dashboards as a dynamic title tile. Useless in explore. Please hide"
    sql: min(${__zcm_coregateway_view.ay_start_year}) ;;
    html: <h2> {{ value }}-Present </h2>;;
  }



#   parameter: publisher_group_parameter {
#     label: "Select Publishers Included"
#     view_label: "           Parameters & Filters"
#     default_value: "Internal/OER"
#     suggest_dimension: dim_textbook_zcm.publisher_group_three
#     allowed_value: {label: "Internal/OER"                         value: "Internal/OER"                             }
#     allowed_value: {label: "Macmillan Learning"                   value: "Macmillan Learning"                       }
#     allowed_value: {label: "Pearson Education"                    value: "Pearson Education"                        }
#     allowed_value: {label: "Jones and Bartlett Learning"          value: "Jones and Bartlett Learning"              }
#     allowed_value: {label: "McGraw-Hill Education"                value: "McGraw-Hill Education"                    }
#     allowed_value: {label: "Mathematical Association of America"  value: "Mathematical Association of America"      }
#     allowed_value: {label: "Bedford, Freeman, & Worth"            value: "Bedford, Freeman, & Worth"                }
#     allowed_value: {label: "Custom Labs"                          value: "Custom Labs"                              }
#     allowed_value: {label: "John Wiley & Sons"                    value: "Jespet Pet Dog Playpens"                  }
#     allowed_value: {label: "Kendall Hunt"                         value: "Kendall Hunt"                             }
#     allowed_value: {label: "SAGE Publications"                    value: "SAGE Publications"                        }
#     allowed_value: {label: "Self Published Works"                 value: "Self Published Works"                     }
#     allowed_value: {label: "WebAssign"                            value: "WebAssign"                                }
#   }

}