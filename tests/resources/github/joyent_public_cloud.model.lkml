connection: "joyent"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
# include: "//zendesk/users.view.lkml"
# include: "//zendesk/tickets.view.lkml"


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore: latency {
  description: "SPC Manta latency"
  view_label: "latency by minute"
  group_label: "SPC Manta"
}

explore: latency_days {
  description: "% good latency by day"
  view_label: "latency day"
  group_label: "SPC Manta"
}

explore: latency_hours {
  description: "% good latency by hour"
  view_label: "latency hour"
  group_label: "SPC Manta"
}

explore: latency_months {
  description: "% good latency by month"
  view_label: "latency month"
  group_label: "SPC Manta"
}

explore: status {
  description: "http status codes"
  view_label: "status"
  group_label: "SPC Manta"

}
explore: status_days {
  description: "uptime days average of the hours"
  view_label: "uptime days"
  group_label: "SPC Manta"
}
explore: status_hours {
  description: "uptime hours average of the minutes"
  view_label: "uptime hours"
  group_label: "SPC Manta"
}

explore: status_months {
  description: "uptime months average of the days"
  view_label: "uptime months"
  group_label: "SPC Manta"
}
explore: updataloaded {
  description: "uptime datasource status"
  view_label: "datasource status"
  group_label: "SPC Manta"
}
explore: jcbw {
  description: "Joyent Cloud commercial bandwidth"
  view_label: "Commercial Bandwidth"
  group_label: "Joyent Cloud"

  join: jccontracts {
    view_label: "Contract"
    sql_on: ${jcbw.report_name} = ${jccontracts.report_name} ;;
    relationship: one_to_many
  }
  join: ufds {
    view_label: "Customers"
    sql_on: ${jccontracts.uuid} = ${ufds.uuid} ;;
    type: left_outer
    relationship: one_to_one
  }
}
explore: ram_values {
  hidden: yes
}
explore: status_cnapi {

}
explore: customer_facts {
}

explore: incdata {
  description: "SPC Incidents and Reports"
  view_label: "Incidents"
  group_label: "Joyent Cloud"
}

explore: spcmantastorage {
  description: "SPC Manta metering"
  view_label: "SPC Manta metering"
  group_label: "Joyent Cloud"
  join: ufds {
    view_label: "Customers"
    sql_on: ${spcmantastorage.uuid} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: mantagoal {
    type: full_outer
    sql_on: ${mantagoal.date_date} = ${spcmantastorage.date_date} and ${mantagoal.region} = ${spcmantastorage.region} ;;
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${spcmantastorage.uuid} ;;
    type: left_outer
    relationship: one_to_one
  }
}
explore: bandwidth {
  description: "JPC Instance bandwidth"
  view_label: "Bandwidth"
  group_label: "Joyent Public Cloud"
  join: ufds {
    view_label: "Customers"
    sql_on: ${bandwidth.owner_uuid} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${bandwidth.owner_uuid} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: zuora_customers {
    view_label: "ZCustomers"
    sql_on: ${zuora_customers.accountnumber} = ${bandwidth.owner_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: vmapi {
    view_label: "vmapi"
    sql_on: ${vmapi.owner_uuid} = ${bandwidth.owner_uuid} ;;
    type: left_outer
    relationship: many_to_many
  }
}

explore: vmapi_jpc_facts {
  join: ufds {
    view_label: "Customers"
    sql_on: ${vmapi_jpc_facts.ufds_uuid} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${vmapi_jpc_facts.ufds_uuid} ;;
    type: left_outer
    relationship: one_to_one
  }
}

explore: manta_usage {
  description: "SPC manta usage"
  group_label: "SPC Manta"
  label: "SCloud usage"
  join: ufds {
    type: full_outer
    sql_on: ${ufds.login} = ${manta_usage.login}  ;;
    relationship: many_to_one
  }

}

explore: manta_zfs {
  description: "ZFS capacity"
  group_label: "Joyent Cloud"
  label: "manta capacity"
  join: mantagoal {
    type: full_outer
    sql_on: ${mantagoal.date_date} = ${manta_zfs.date_date} and ${mantagoal.region} = ${manta_zfs.region} ;;
    relationship: many_to_one
  }
  join: muskiedelete {
    type: full_outer
    sql_on: ${muskiedelete.timestamp_date} = ${manta_zfs.date_date} and ${muskiedelete.region} = ${manta_zfs.region} ;;
    relationship: many_to_many
  }
}
explore: storageforecast {
  description: "SDC Storage forecasting"
  group_label: "Joyent Cloud"
  label: "Storage Forecast"
  #join: step_storageforecast {
  #  from: storageforecast
  #  type: left_outer
  #  sql_on: ${storageforecast.fcst} = ${step_storageforecast.fcst} and
  #          ${storageforecast.region} = ${step_storageforecast.region} and
  #          ${storageforecast.half_year} =  ${step_storageforecast.delivery_month}

#    ;;
 #   relationship: many_to_one

  #}
  #join: storage_forecast_build {
  #  type: inner
  #  sql_on: ${storageforecast.delivery_raw} = ${storage_forecast_build.build_start_raw}
  #  and ${step_storageforecast.region} = ${storage_forecast_build.region};;
  #  relationship: many_to_one
  #}
  join: manta_zfs {
    type: full_outer
    sql_on: ${manta_zfs.region} = ${storageforecast.region} and ${manta_zfs.date_date} = ${storageforecast.delivery_date};;
    relationship: one_to_many
  }
  join: mantagoal {
    type: full_outer
    sql_on: ${mantagoal.date_date} = ${storageforecast.delivery_date} and ${mantagoal.region} = ${storageforecast.region} ;;
    relationship: many_to_one
  }
  join: muskiedelete{
    type: full_outer
    sql_on: ${muskiedelete.region} = ${storageforecast.region} and ${muskiedelete.timestamp_date} = ${storageforecast.delivery_date} ;;
    relationship: many_to_many
  }
}

explore: storagebuild {
  description: "SDC Storage Build"
  group_label: "Joyent Cloud"
  label: "Storage Build"
}

explore: inventory {
  description: "Node Inventory"
  group_label: "Joyent Cloud"
  label: "Inventory"
  join: server_sku {
    from: inventory
    sql_on: ${inventory.sku} = ${server_sku.sku} ;;
    relationship: many_to_one
  }
}


explore: bpr {
  description: "Billing Preview"
  group_label: "Joyent Cloud"
  label: "bpr"
  join: zuora_customers {
    view_label: "ZCustomers"
    sql_on: ${zuora_customers.accountnumber} = ${bpr.account_number} ;;
    type: left_outer
    relationship: many_to_one

  }
  join: papi {
    view_label: "Packages"
    sql_on: ${bpr.uom} = ${papi.billing_tag} ;;
    type:  full_outer
    relationship: many_to_one
  }
}
explore: ufds {
    description: "UFDS"
    group_label: "Joyent Cloud"
    label: "ufds"

  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${ufds.uuid} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: zuora_customers {
    view_label: "ZCustomers"
    sql_on: ${zuora_customers.accountnumber} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
# join: users {
#   sql_on: ${users.email} = ${ufds.email} ;;
#   type: left_outer
#   relationship: one_to_one
# }
 #join: tickets  {
#   sql_on: ${users.id} =  ${tickets.requester_id} ;;
##   type: left_outer
#   relationship: one_to_many
# }
}

explore: mantastorage {
  description: "Manta Storage"
  group_label: "Joyent Cloud"
  label: "Manta Storage"

  join: ufds {
    view_label: "Customers"
    sql_on: ${mantastorage.owner} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${mantastorage.owner} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: zuora_customers {
    view_label: "ZCustomers"
    sql_on: ${zuora_customers.accountnumber} = ${mantastorage.owner} ;;
    type: left_outer
    relationship: many_to_one
  }
}



#explore: zinvoiceitems {
#  description: "Invoice Items"
#  group_label: "Joyent Cloud"
#  label: "Invoice Items"
##   always_filter: {
##     filters: {
##       field: zuora_customers.isFree
##       value: "No"
##     }
##   }
#  join: ufds {
#    view_label: "Customers"
#    sql_on: ${zinvoiceitems.account_number} = ${ufds.uuid} ;;
#    type: left_outer
#    relationship: many_to_one
#  }
#  join: ufdsgroupname{
#    view_label: "Customer group"
#    sql_on: ${ufdsgroupname.uuid} = ${zinvoiceitems.account_number} ;;
#    type: left_outer
#    relationship: one_to_one
#  }
#  join: zuora_customers {
#    view_label: "ZCustomers"
#    sql_on: ${zuora_customers.accountnumber} = ${zinvoiceitems.account_number} ;;
#    type: left_outer
#    relationship: many_to_one
#  }
#  join: users {
#    view_label: "Zendesk Users"
#    sql_on: ${users.email} = ${ufds.email} ;;
#    type: left_outer
#    relationship: one_to_one
#  }
#  join: tickets  {
#    view_label: "Zendesk Tickets"
#    sql_on: ${users.id} =  ${tickets.requester_id} ;;
#    type: left_outer
#    relationship: one_to_many
#  }
#}

explore: datacenters {
  description: "DC"
  group_label: "Joyent Cloud"
  label: "dc"
}

explore: cnapi {
  description: "CNApi"
  group_label: "Joyent Cloud"
  label: "cnapi"
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${cnapi.dc} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: papi {
    view_label: "Packages"
    sql_on: ${cnapi.setup} = ${papi.active} ;;
    type:  full_outer
    relationship: many_to_one
  }

}

explore: storage_zfs {
  description: "storage instances zfs"
  group_label: "Joyent Cloud"
  label: "Storage zfs"
  join: vmapi {
    view_label: "vmapi"
    sql_on:  ${storage_zfs.instance} = ${vmapi.alias} and ${storage_zfs.date_date} = ${vmapi.date_date};;
    type: left_outer
    relationship: one_to_one
  }
  join: shrimp_facts{
    view_label: "Shrimp Facts"
    sql_on: ${shrimp_facts.uuid} = ${vmapi.server_uuid} and ${storage_zfs.date_date} = ${shrimp_facts.date_date} ;;
    type: left_outer
    relationship: one_to_one
  }

}
explore: vmapi {
  description: "VMApi"
  group_label: "Joyent Cloud"
  label: "vmapi"
  join: ufds {
    view_label: "ufds"
    sql_on: ${ufds.uuid}=${vmapi.owner_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on:  ${vmapi.owner_uuid} = ${ufdsgroupname.uuid};;
    type: left_outer
    relationship: one_to_one
  }
  join: zuora_customers{
    view_label: "zcustomer"
    sql_on:  ${vmapi.owner_uuid} = ${zuora_customers.accountnumber};;
    type: left_outer
    relationship: one_to_one
  }
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${vmapi.datacenter} ;;
    type: full_outer
    relationship: many_to_one
  }
  join: papi {
    view_label: "Packages"
    sql_on: ${vmapi.billing_id} = ${papi.uuid} ;;
    type:  left_outer
    relationship: many_to_one
  }

  join: images {
    view_label: "images"
    sql_on: ${images.uuid} = ${vmapi.image_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: cnapi {
    view_label: "cnapi"
    sql_on: ${cnapi.uuid} = ${vmapi.server_uuid} and ${cnapi.date_date} = ${vmapi.date_date} ;;
    type: full_outer
    relationship: many_to_one
  }
}

explore: vmapi_hourly {
  description: "VMApi"
  group_label: "Joyent Cloud"
  label: "vmapi Hourly"
  join: ufds {
    view_label: "ufds"
    sql_on: ${ufds.uuid}=${vmapi_hourly.owner_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on:  ${vmapi_hourly.owner_uuid} = ${ufdsgroupname.uuid};;
    type: left_outer
    relationship: one_to_one
  }
  join: zuora_customers{
    view_label: "zcustomer"
    sql_on:  ${vmapi_hourly.owner_uuid} = ${zuora_customers.accountnumber};;
    type: left_outer
    relationship: one_to_one
  }
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${vmapi_hourly.datacenter} ;;
    type: full_outer
    relationship: many_to_one
  }
  join: papi {
    view_label: "Packages"
    sql_on: ${vmapi_hourly.billing_id} = ${papi.uuid} ;;
    type:  left_outer
    relationship: many_to_one
  }

  join: images {
    view_label: "images"
    sql_on: ${images.uuid} = ${vmapi_hourly.image_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: cnapi {
    view_label: "cnapi"
    sql_on: ${cnapi.uuid} = ${vmapi_hourly.server_uuid} and ${cnapi.date_date} = ${vmapi_hourly.date_date} ;;
    type: full_outer
    relationship: many_to_one
  }
}



explore: cnapimonthly {
  description: "CNApi monthly"
  group_label: "Joyent Cloud"
  label: "cnapi monthly"
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${cnapimonthly.dc} ;;
    type: left_outer
    relationship: many_to_one
  }

}

explore: jpcdaily_spend {
  description: "Billing Preview spend"
  group_label: "Joyent Cloud"
  label: "jpc daily spend"

    join: zuora_customers {
      view_label: "ZCustomers"
      sql_on: ${jpcdaily_spend.accountnumber} = ${zuora_customers.accountnumber} ;;
      type: left_outer
      relationship: many_to_one
    }
    join: jpc_account_facts {
      view_label: "Customers"
      sql_on: ${jpcdaily_spend.accountnumber} = ${jpc_account_facts.account_number} ;;
      type: left_outer
      relationship: many_to_one
    }
    join: ufds {
      view_label: "Customers"
      sql_on: ${jpcdaily_spend.accountnumber} =  ${ufds.uuid}  ;;
      type: left_outer
      relationship: many_to_one
    }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on:  ${jpcdaily_spend.accountnumber} = ${ufdsgroupname.uuid}  ;;
    type: left_outer
    relationship: one_to_one
  }
}
explore: images {
  description: "Images"
  group_label: "Joyent Cloud"
  label: "Images"
}
explore: papi {
  description: "Package"
  group_label: "Joyent Cloud"
  label: "Packages"
}
explore: ufdsgroupname {
  description: "UFDS Groupname"
  group_label: "Joyent Cloud"
  label: "UFDS groups"
}
explore: makotomb {
  description: "SmartDC mako tombstone"
  group_label: "Joyent Cloud"
  label: "mako tombstone"
}
explore: mako {
  description: "SmartDC mako stats"
  group_label: "Joyent Cloud"
  label: "Mako"
  join: ufds {
    view_label: "Customers"
    sql_on: ${mako.account} =  ${ufds.uuid}  ;;
    type: left_outer
    relationship: one_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on:  ${mako.account} = ${ufdsgroupname.uuid}  ;;
    type: left_outer
    relationship: one_to_one
  }
}

explore: makoregion {
  description: "SmartDC mako regions stats"
  group_label: "Joyent Cloud"
  label: "Mako Region"
  join: makoregiontomb {
    view_label: "region tombstone"
    sql_on: ${makoregion.storage_id} = ${makoregiontomb.storage_id}
    type: full_outer;;
    relationship: one_to_many
  }
}

explore: makoregiontomb {
  description: "SmartDC mako regions stats"
  group_label: "Joyent Cloud"
  label: "Mako Region tombstone"
}

explore: netbox {
  description: "SPC servers"
  group_label: "Joyent Cloud"
  label: "servers"
  join: cnapi {
    type: full_outer
    sql_on: ${cnapi.serial_number} = ${netbox.serial} and ${cnapi.date_date} = ${netbox.date_date} ;;
    relationship: one_to_one
  }
  join: papi {
    view_label: "Packages"
    sql_on: ${cnapi.setup} = ${papi.active} ;;
    type:  full_outer
    relationship: many_to_one
  }
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${netbox.site} ;;
    type: left_outer
    relationship: many_to_one
  }
}
explore: sdcdataloaded {
  description: "SmartDC Data loaded"
  group_label: "Dataloaded"
  label: "SmartDC stats"
}

explore: capdataloaded {
  description: "Capacity Data loaded"
  group_label: "Dataloaded"
  label: "Capacity stats"
}

explore: muskiedelete {
  description: "Deleted from manta"
  group_label: "Joyent Cloud"
  label: "Manta Deleted"
  join: ufds {
    view_label: "Customers"
    sql_on: ${muskiedelete.owner_uuid} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${muskiedelete.owner_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: zuora_customers {
    view_label: "ZCustomers"
    sql_on: ${zuora_customers.accountnumber} = ${muskiedelete.owner_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
}
explore: dictionary {
  group_label: "Meta Data"
  description: "Data Dictionary"
  label: "Dictionary"
}
