connection: "dwh"

# include all the views
include: "*.view"

# include all the dashboards
#include: "*.dashboard"

label: "lbl_mdl_agfa_enterprise_imaging"


explore: dwh_f_requested_procedure {
  extension: required
  from: xtd_dwh_f_requested_procedure
  view_name: dwh_f_requested_procedure
  label: "lbl_xpl_referring_community"
  view_label: "lbl_vw_referral_details"


  join:dwh_d_patient_class {
    from:  xtd_dwh_d_patient_class
    view_label: "lbl_vw_patient_class"
    type: inner
    sql_on: ${dwh_f_requested_procedure.acq_trsf_patient_class_sk} = ${dwh_d_patient_class.patient_class_sk} ;;
    relationship: many_to_one
  }

  join:dwh_d_patient_type {
    from:  xtd_dwh_d_patient_type
    view_label: "lbl_vw_patient_type"
    type: inner
    sql_on: ${dwh_f_requested_procedure.patient_type_sk} = ${dwh_d_patient_type.patient_type_sk} ;;
    relationship: many_to_one
  }

  join:department_performing {
    from: xtd_dwh_d_department
    #sql_where: ${department_performing.occurs_as_performing} = 1 ;;
    view_label: "lbl_vw_department_performing"
    type: inner
    sql_on: ${dwh_f_requested_procedure.performing_department_sk} = ${department_performing.department_sk} ;;
    relationship: many_to_one
  }

  join:department_performing_labels {
    from: xtd_dwh_d_labels_department
    view_label: "lbl_vw_department_performing"
    type: inner
    sql_on: ${dwh_f_requested_procedure.performing_department_sk} = ${department_performing_labels.department_sk} ;;
    relationship: many_to_many
  }

  join:department_performing_facility {
    from: xtd_dwh_d_facility
    view_label: "lbl_vw_department_performing"
    #fields: []
    type: left_outer
    sql_on: ${department_performing.facility_sk} = ${department_performing_facility.facility_sk};;
    relationship: many_to_one
  }

  join:department_perf_fac_labels {
    from: xtd_dwh_d_labels_facility
    view_label: "lbl_vw_department_performing"
    type: inner
    sql_on: ${department_performing.facility_sk} = ${department_perf_fac_labels.facility_sk} ;;
    relationship: many_to_many
  }


  join:department_ordering {
    from: xtd_dwh_d_department
    view_label: "lbl_vw_department_ordering"
    type: inner
    sql_on: ${dwh_f_requested_procedure.requesting_department_sk} = ${department_ordering.department_sk} ;;
    relationship: many_to_one
  }

  join:department_ordering_labels {
    from: xtd_dwh_d_labels_department
    view_label: "lbl_vw_department_ordering"
    type: inner
    sql_on: ${dwh_f_requested_procedure.requesting_department_sk} = ${department_ordering_labels.department_sk} ;;
    relationship: many_to_many
  }

  join:department_ordering_facility {
    from: xtd_dwh_d_facility
    view_label: "lbl_vw_department_ordering"
    #fields: []
    type: left_outer
    sql_on: ${department_ordering.facility_sk} = ${department_ordering_facility.facility_sk};;
    relationship: many_to_one
  }

  join:department_ord_fac_labels {
    from: xtd_dwh_d_labels_facility
    view_label: "lbl_vw_department_ordering"
    type: inner
    sql_on: ${department_ordering.facility_sk} = ${department_ord_fac_labels.facility_sk} ;;
    relationship: many_to_many
  }

  join:physician_ordering {
    from: xtd_dwh_d_professional
    view_label: "lbl_vw_physician_ordering"
    type: inner
    sql_on: ${dwh_f_requested_procedure.requesting_physician_sk} = ${physician_ordering.professional_sk} ;;
    relationship: many_to_one
  }

  join:dwh_d_procedure_definition {
    from:  xtd_dwh_d_procedure_definition
    view_label: "lbl_vw_procedure_definition"
    type: inner
    sql_on: ${dwh_f_requested_procedure.procedure_definition_sk} = ${dwh_d_procedure_definition.procedure_definition_sk} ;;
    relationship: many_to_one
  }

  join:dwh_d_modality_type {
    from: xtd_dwh_d_modality_type
    view_label: "lbl_vw_modality_type"
    type: inner
    sql_on: ${dwh_f_requested_procedure.modality_type_sk} = ${dwh_d_modality_type.modality_type_sk} ;;
    relationship: many_to_one
  }

  join:dwh_d_modality {
    from:  xtd_dwh_d_modality
    view_label: "lbl_vw_modality"
    type: inner
    sql_on: ${dwh_f_requested_procedure.modality_sk} = ${dwh_d_modality.modality_sk} ;;
    relationship: many_to_one
  }

  join:dwh_d_patient {
    from: xtd_dwh_d_patient
    view_label: "lbl_vw_patient"
    type: inner
    sql_on: ${dwh_f_requested_procedure.patient_sk} = ${dwh_d_patient.patient_sk} ;;
    relationship: many_to_one
  }

}
