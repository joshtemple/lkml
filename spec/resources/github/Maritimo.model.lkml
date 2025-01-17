connection: "db"

include: "/views/aereo_dados_no_tempo.view.lkml"
include: "/views/health_data.view.lkml"
include: "/views/antaqxmaritimo.view.lkml"
include: "/views/cs_dash_imp.view.lkml"
include: "/views/view_infografico.view.lkml"
include: "/views/view_infografico_exp.view.lkml"
include: "/views/db_siscori_cod_ncm.view.lkml"
include: "/views/db_siscori_incoterm.view.lkml"
include: "/views/client_documents_by_method.view.lkml"
include: "/views/health_imp_house_direto.view.lkml"
include: "/views/health_data_exp.view.lkml"
include: "/views/antaqxmaritimo_exp.view.lkml"
include: "/views/db_cad_armador.view.lkml"
include: "/views/db_maritimo.view.lkml"
include: "/views/antaqxmaritimo_cab.view.lkml"
include: "/views/antaqxmaritimo_cab_emb.view.lkml"

explore: client_documents_by_method {
  label: "Client Documents By Method"
}

explore: health_data {}
explore: health_data_exp {}
explore: cs_dash_imp {}
explore: health_imp_house_direto {}
explore: antaqxmaritimo_exp {
  label: "Exp AntaqMaritimo"
}
explore: antaqxmaritimo {
  label: " Imp AntaqMaritimo"
}

explore: antaqxmaritimo_cab {
  label: "Cab AntaqMaritimo Desembarcados"
}

explore: antaqxmaritimo_cab_emb {
  label: "Cab AntaqMaritimo Embarcados"
}

explore: view_infografico {
  join: db_siscori_cod_ncm {
    relationship: one_to_one
    sql_on: ${db_siscori_cod_ncm.id} = ${view_infografico.id_cdncm} ;;
  }
  join: db_siscori_incoterm {
    relationship: one_to_one
    sql_on: ${db_siscori_incoterm.id} = ${view_infografico.id_incoterm} ;;
  }
  label: "Infográfico Importação"
}
explore: view_infografico_exp {
  join: db_siscori_cod_ncm {
    relationship: one_to_one
    sql_on: ${db_siscori_cod_ncm.id} = ${view_infografico_exp.id_cdncm} ;;
  }
  join: db_siscori_incoterm {
    relationship: one_to_one
    sql_on: ${db_siscori_incoterm.id} = ${view_infografico_exp.id_incoterm} ;;
  }
  label: "Infográfico Exportação"
}
explore: db_maritimo {
  join: db_cad_armador {
    relationship: many_to_one
    sql_on: ${db_cad_armador.id} = ${db_maritimo.id_armador} ;;
  }
}
