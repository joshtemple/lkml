connection: "db"

include: "/views/db_export_pre_acd.view.lkml"
include: "/views/db_export_pre_acd_details.view.lkml"
include: "/views/db_export_pre_acd_fcl.view.lkml"

include: "/views/db_export_pos_acd.view.lkml"
include: "/views/db_export_pos_acd_details.view.lkml"
include: "/views/db_export_pos_acd_carga.view.lkml"
include: "/views/db_export_pos_acd_doc.view.lkml"
include: "/views/db_export_pos_acd_event.view.lkml"
include: "/views/db_export_pos_acd_fcl.view.lkml"
include: "/views/db_export_pos_acd_shipper.view.lkml"
include: "/views/db_export_pos_acd_volume.view.lkml"

explore: db_export_pre_acd {
  label: "Novo Exportacao - PRE"

  join: db_export_pre_acd_details {
    relationship: one_to_one
    sql_on: ${db_export_pre_acd_details.pu_export_urf_pre_data_id} = ${db_export_pre_acd.pu_export_urf_pre_data_id}
        AND ${db_export_pre_acd_details.seq_deposito} = ${db_export_pre_acd.seq_deposito};;
  }

  join: db_export_pre_acd_fcl {
    relationship: one_to_many
    sql_on: ${db_export_pre_acd_details.id} = ${db_export_pre_acd_fcl.export_pre_acd_details_id} ;;
  }

}

explore: db_export_pos_acd {
  label: "Novo Exportacao - POS"

  join: db_export_pos_acd_details {
    relationship: one_to_one
    sql_on: ${db_export_pos_acd_details.pu_export_urf_pos_data_id} = ${db_export_pos_acd.pu_export_urf_pos_data_id}
        AND ${db_export_pos_acd_details.seq_deposito} = ${db_export_pos_acd.seq_deposito}
        AND ${db_export_pos_acd_details.seq_carga} = ${db_export_pos_acd.seq_carga};;
  }

  join: db_export_pos_acd_carga {
    relationship: many_to_one
    sql_on: ${db_export_pos_acd_carga.export_pos_acd_details_id} = ${db_export_pos_acd_details.id} ;;
  }

  join: db_export_pos_acd_doc {
    relationship: many_to_one
    sql_on: ${db_export_pos_acd_doc.export_pos_acd_details_id} = ${db_export_pos_acd_details.id} ;;
  }

  join: db_export_pos_acd_event {
    relationship: many_to_one
    sql_on: ${db_export_pos_acd_event.export_pos_acd_details_id} = ${db_export_pos_acd_details.id} ;;
  }

  join: db_export_pos_acd_fcl {
    relationship: many_to_one
    sql_on: ${db_export_pos_acd_fcl.export_pos_acd_details_id} = ${db_export_pos_acd_details.id} ;;
  }

  join: db_export_pos_acd_shipper {
    relationship: many_to_one
    sql_on: ${db_export_pos_acd_shipper.export_pos_acd_details_id} = ${db_export_pos_acd_details.id} ;;
  }

  join: db_export_pos_acd_volume {
    relationship: many_to_one
    sql_on: ${db_export_pos_acd_volume.export_pos_acd_details_id} = ${db_export_pos_acd_details.id} ;;
  }

}
