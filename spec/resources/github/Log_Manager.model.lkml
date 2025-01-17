connection: "log_manager"

include: "/**/account.view.lkml"
include: "/**/processos.view.lkml"
include: "/**/empresa_pessoa.view.lkml"
include: "/**/organizations.view.lkml"
include: "/**/paises.view.lkml"
include: "/**/plans.view.lkml"
include: "/**/workflow.view.lkml"
include: "/**/workflow_step.view.lkml"

explore: log_manager {

  #sql_always_where: ${customer.fake_customer}=false and ${customer.deleted_raw} is null;;
  #persist_with: my_datagroup
  view_name: account

  join: processos {
    #view_label: "Customer"
    sql_on: ${processos.account_id}=${account.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: plans {
    sql_on: ${account.plan_id}=${plans.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: organizations {
    #view_label: "Customer"
    sql_on: ${processos.org_id}=${organizations.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: empresa_pessoa {
    #view_label: "Customer"
    from: empresa_pessoa
    sql_on: ${empresa_pessoa.account_id}=${account.id} ;;
    type: left_outer
    relationship: many_to_one
    sql_where: ${empresa_pessoa.deleted_raw} is null ;;
  }

  join: cliente {
    #view_label: "Customer"
    from: empresa_pessoa
    sql_on: ${processos.cliente_id}=${cliente.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: importador {
    #view_label: "Customer"
    from: empresa_pessoa
    sql_on: ${processos.importador_id}=${importador.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: exportador {
    #view_label: "Customer"
    from: empresa_pessoa
    sql_on: ${processos.exportador_id}=${exportador.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: workflow {
    #view_label: "Customer"
    sql_on: ${processos.workflow_id}=${workflow.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: pais_origem {
    from: paises
    sql_on: ${processos.pais_origem_id}=${pais_origem.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: paise_destino {
    from: paises
    sql_on: ${processos.pais_origem_id}=${paise_destino.id} ;;
    type: left_outer
    relationship: many_to_one
  }
}
