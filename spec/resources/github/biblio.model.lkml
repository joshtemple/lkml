connection: "fivetran-bigquery"

# include all views from all folders
include: "/*/*.view"

datagroup: biblio_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

# Should probably name this either semantically (cache_policy_hourly)
# or by name of data group (ot, or trs).
 datagroup: caching_policy {
#  Outputs current day of year (001-366) - current hour (00-24).
   sql_trigger: select FORMAT_DATETIME("%j-%H", CURRENT_DATETIME());;
   max_cache_age: "1 hour"
 }

persist_with: biblio_default_datagroup

#--SALESFORCE JOINS--
# salesforce account explore as primary table
explore: sf_accounts {
  label: "Salesforce Accounts"
  group_label: "Project Biblio"
  view_label: "Salesforce Accounts"
  fields: [ALL_FIELDS*]
  sql_always_where: ${sf_accounts.is_deleted}= FALSE;;

  join: sf_opportunity {
    view_label: "Salesforce Opportunitiy"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_opportunity.account_id} AND  ${sf_opportunity.is_deleted}= FALSE;;
  }

  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }

  join: sf_case {
    view_label: "Salesforce Support Cases"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_case.account_id} AND ${sf_case.is_deleted} = FALSE;;
  }

  join: sf_settlement_split {
    view_label: "Salesforce Settlement Split"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_case.id}=${sf_settlement_split.id} AND ${sf_case.is_deleted} = FALSE;;
  }


  join: sf_contact {
    view_label: "Salesforce Contact"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_contact.id}=${sf_case.contact_id} ;;
  }

  join: sf_task {
    view_label: "Salesforce Tasks"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_task.account_id};;
  }

  join: sf_user {
    view_label: "Salesforce Users"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_user.id}=${sf_accounts.owner_id};;
  }
}

# salesforce opportunity explore as primary table
explore: sf_opportunity {
  label: "Salesforce Opportunity"
  group_label: "Project Biblio"
  view_label: "Salesforce Opportunity"
  fields: [ALL_FIELDS*]
  sql_always_where: ${sf_opportunity.is_deleted}= FALSE;;
}

# salesforce campaign explore as primary table
explore: sf_campaign_member {
  label: "Salesforce Campaign Member"
  group_label: "Project Biblio"
  view_label: "Salesforce Campaign Member"
  fields: [ALL_FIELDS*]
  sql_always_where: ${sf_campaign_member.is_deleted}= FALSE;;

  join: sf_lead {
    view_label: "SalesFoce Lead"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_lead.id} = ${sf_campaign_member.lead_id} AND ${sf_lead.is_deleted} = FALSE ;;
  }

  join: sf_campaign {
    view_label: "SalesFoce Campaigns"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_campaign.id} = ${sf_campaign_member.campaign_id} AND ${sf_campaign.is_deleted} = FALSE ;;
  }

  join: sf_user {
    view_label: "Salesforce Users"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_user.id}=${sf_lead.owner_id};;
  }
  }

explore: pro_venue_facts {
  label: "AV Pro Venue Facts"
  group_label: "Project Biblio"
  view_label: "AV Pro Orders"
  fields: [ALL_FIELDS*]
#  sql_on: ${pro_venue_facts.performance_id}=${ot_order_detail.performance_id} ;;

}

#Order overages
explore: pro_overage_orders {
  label: "AV Pro Overages"
  group_label: "Project Biblio"
  view_label: "AV Pro Overages"
  fields: [ALL_FIELDS*]

  join: pro_min_orders {
    view_label: "AV Pro Min Order"
    type:inner
    relationship: many_to_one
    sql_on: ${pro_overage_orders.client_id}=${pro_min_orders.first_order_client_id}
    and ${pro_min_orders.first_order_date_month_name} = ${pro_overage_orders.current_time_month_name}

    ;;

  }

  join: sf_accounts {
    view_label: "SF Account"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id} = ${pro_overage_orders.sf_account_id} AND ${sf_accounts.is_deleted}= FALSE;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }

 }

#--OVATIONTIX JOINS--
# OvationTix Orders as primary table
explore: ot_orders {
  label: "AV Pro Orders"
  group_label: "Project Biblio"
  view_label: "AV Pro Orders"
  fields: [ALL_FIELDS*]
  sql_always_where: ${ot_client.demo}=0 and ${ot_client.testing_mode}=0 and ${ot_client.client_id} NOT IN (35200,34918) and  ${ot_client.active} = 1 and ${imported}=0 and ${is_test_mode}=0 and ${status_id} != 11;;

  join: ot_client {
    view_label: "AV Pro Client"
    type:left_outer
    relationship: many_to_one
    sql_on: ${ot_orders.client_id}=${ot_client.client_id} ;;
  }

  join: pro_client_facts {
    view_label: "AV Pro Client Facts"
    type:left_outer
    relationship: many_to_one
    sql_on: ${ot_orders.client_id}=${pro_client_facts.client_id} ;;
  }

  join: pro_client_user {
    view_label: "AV Pro Client/User Join"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_client.client_id}=${pro_client_user.client_id} ;;
  }

  join: pro_user {
    view_label: "AV Pro User"
    type:left_outer
    relationship: one_to_one
    sql_on: ${pro_client_user.user_id}=${pro_user.user_id} ;;
  }

  join: pro_max_login {
    view_label: "AV Pro Last Login"
    type:left_outer
    relationship: one_to_one
    sql_on: ${pro_max_login.client_id}=${ot_orders.client_id} ;;
  }

  join: ot_client_fee_structure {
    view_label: "AV Pro Client Fee Structure"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_client_fee_structure.client_id}=${ot_client.client_id} ;;
  }
  join: ot_client_enabled_feature {
    view_label: "AV Pro Client Features"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_client_enabled_feature.client_id}=${ot_client.client_id} ;;
  }
  join: ot_order_detail {
    view_label: "AV Pro Orders Detail"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ot_orders.order_id}=${ot_order_detail.order_id} ;;
  }

  join: pro_ticket_type {
    view_label: "AV Pro Ticket Type"
    type: left_outer
    relationship: one_to_one
    sql_on: ${pro_ticket_type.ticket_type_id}=${ot_order_detail.ticket_type_id} ;;
  }

  join: pro_consumer_package {
    view_label: "AV Pro Consumer Package"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_order_detail.consumer_pac_id}=${pro_consumer_package.id} ;;
  }

  join: pro_package_price_point {
    view_label: "AV Pro Package Price Point"
    type: left_outer
    relationship: one_to_many
    sql_on: ${pro_package_price_point.package_id}=${pro_consumer_package.package_id} ;;
  }


  join: pro_ticket {
    view_label: "AV Pro Tickets"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_order_detail.ticket_id} = ${pro_ticket.ticket_id} ;;
  }

  join: pro_ticket_barcode {
    view_label: "AV Pro Tickets Barcode"
    type: left_outer
    relationship: one_to_one
    sql_on: ${pro_ticket.ticket_id} = ${pro_ticket_barcode.ticket_id} ;;
  }


  join: ot_order_detail_ticket {
    view_label: "AV Pro Orders Detail Tickets"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_order_detail_ticket.orderdetail_id}=${ot_order_detail.orderdetail_id} ;;
  }
  join: ot_client_account {
    view_label: "AV Pro Client Account"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_client.client_id}=${ot_client_account.client_id};;
  }

  join: ot_client_statement {
    view_label: "AV Pro Client Statement"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_client.client_id}=${ot_client_statement.client_id};;
    }

  join: ot_client_account_sale_refund {
    view_label: "AV Pro Client Sale & Refund"
    type: inner
    relationship: many_to_many
    sql_on: ${ot_order_detail.orderdetail_id}=${ot_client_account_sale_refund.orderdetail_id} ;;
  }
  join: ot_accounting_client_daily_sales {
    view_label: "AV Pro Client Accounting Daily Sales"
    type: inner
    relationship: many_to_many
    sql_on: ${ot_accounting_client_daily_sales.orderdetail_id}=${ot_client_account_sale_refund.orderdetail_id} ;;
  }

  join: ot_performance {
    view_label: "AV Pro Performance"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ot_performance.id}=${ot_order_detail.performance_id} ;;
  }

  join: pro_performance_settlement {
    view_label: "AV Pro Performance Settlement"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_performance.id}=${pro_performance_settlement.performance_id} ;;
  }

  join: ot_production {
    view_label: "AV Pro Production"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ot_production.production_id}=${ot_performance.production_id} ;;
  }
  join: ot_performance_stats_total {
    view_label: "AV Pro Performance Seat Manifest"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_performance.id}=${ot_performance_stats_total.performance_id} AND ${ot_performance_stats_total._fivetran_deleted} = false ;;
  }
  join: ot_performance_stats_consumed {
    view_label: "AV Pro Performance Sold Seat Manifest"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_performance.id}=${ot_performance_stats_consumed.performance_id} AND ${ot_performance_stats_consumed._fivetran_deleted} = false ;;
  }

  join: ot_price_level {
    view_label: "AV Pro Performance Price Levels"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ot_order_detail.price_level_id}=${ot_price_level.price_level_id} and ${ot_price_level._fivetran_deleted} = false;;
  }

  join: ot_payment_segment {
    view_label: "AV Pro Payment"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ot_payment_segment.order_id}=${ot_orders.order_id};;
  }

  join: pro_paymenttype {
    view_label: "AV Pro Payment Type"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_payment_segment.payment_type_id}=${pro_paymenttype.paymenttype_id};;
  }
  join: ot_report_crm {
    view_label: "AV Pro Report CRM"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_report_crm.id}= ${ot_client.report_crm_id};;
  }
  join: pro_client_type {
    view_label: "AV Pro Client Type"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_report_crm.client_type_id}= ${pro_client_type.client_type_id};;
  }
  join: pro_production_genre {
    view_label: "AV Pro Production Genre"
    type:  left_outer
    relationship: one_to_one
    sql_on: ${pro_production_genre.production_id}=${ot_production.production_id} ;;
  }
  join: pro_genres {
    view_label: "AV Pro Genre"
    type:  left_outer
    relationship: one_to_one
    sql_on: ${pro_production_genre.genre_id}=${pro_genres.genre_id} ;;
  }
  join: pro_performance_sections {
    view_label: "AV Pro Performance Sections"
    type:left_outer
    relationship: one_to_one
    sql_on: ${pro_performance_sections.performance_id}=${ot_performance.id} ;;
  }
  join: ot_section {
    view_label: "AV Pro Section"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_section.section_id}=${pro_performance_sections.section_id} ;;
  }
  join: pro_seat {
    view_label: "AV Pro Seat"
    type:left_outer
    relationship: one_to_one
    sql_on: ${pro_ticket.ticket_seat_id}=${pro_seat.seat_id} ;;
  }
  join: sf_accounts {
    view_label: "SF Account"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.salesforce_account_id_c} = ${ot_report_crm.crm_id} AND ${sf_accounts.is_deleted}= FALSE;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }
  join: sf_contact {
    view_label: "SF Contact"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_accounts.id} = ${sf_contact.account_id} ;;
  }
  join: sf_case {
    view_label: "SF Case"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_contact.id} = ${sf_case.contact_id} ;;
  }
  join: sf_settlement_split {
    view_label: "Salesforce Settlement Split"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_case.id}=${sf_settlement_split.id} AND ${sf_case.is_deleted} = FALSE;;
  }
  join: ganalytics_ot {
    view_label: "GA Orders"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ganalytics_ot.ot_transaction_id}=${ot_orders.order_id};;
  }
  join: ot_credit_card_transactions {
    view_label: "AV Pro Credit Card Transactions"
    type:  left_outer
    relationship: one_to_many
    sql_on: ${ot_orders.order_id}=${ot_credit_card_transactions.order_id} ;;
  }
}

#AV Professional Client Facts
explore: ot_client {
  label: "AV Pro Client Fact"
  group_label: "Project Biblio"
  view_label: "AV Pro Client"
  fields: [ALL_FIELDS*]
  sql_always_where: ${ot_client.demo}=0 and ${ot_client.testing_mode}=0 and ${ot_client.active} = 1 and ${ot_client.client_id} NOT IN (35200,34918)  ;;


  join: pro_client_user {
    view_label: "AV Pro Client/User Join"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_client.client_id}=${pro_client_user.client_id} ;;
  }

  join: pro_user {
    view_label: "AV Pro User"
    type:left_outer
    relationship: one_to_one
    sql_on: ${pro_client_user.user_id}=${pro_user.user_id} ;;
  }

  join: pro_persona_user {
    view_label: "AV Pro Persona/User Join"
    type:left_outer
    relationship: one_to_one
    sql_on: ${pro_user.user_id}=${pro_persona_user.user_id} ;;
  }

  join: pro_persona {
    view_label: "AV Pro User Persona"
    type:left_outer
    relationship: one_to_one
    sql_on: ${pro_persona.name}=${pro_persona_user.persona_name} ;;
  }



  join: ot_seating_chart_client {
    view_label: "AV Pro Seatting Chart Client"
    type:left_outer
    relationship: many_to_one
    sql_on: ${ot_seating_chart_client.client_id}=${ot_client.client_id} ;;
    }

  join: ot_seating_chart {
    view_label: "AV Pro Seatting Chart Client"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_seating_chart_client.seating_chart_id}=${ot_seating_chart.seating_chart_id} and ${ot_seating_chart.deleted} = 'F' ;;
  }

  join: ot_section {
    view_label: "AV Pro Section"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_section.seating_chart_id}=${ot_seating_chart.seating_chart_id} ;;
  }

  join: ot_report_crm {
    view_label: "AV Pro Report CRM"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_report_crm.id}= ${ot_client.report_crm_id};;
  }
  join: pro_client_type {
    view_label: "AV Pro Client Type"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_report_crm.client_type_id}= ${pro_client_type.client_type_id};;
  }
  join: pro_department {
    view_label: "AV Pro Department"
    type: left_outer
    relationship: one_to_one
    sql_on: ${pro_department.client_id}= ${ot_client.client_id};;
  }

  join: ot_production {
    view_label: "AV Pro Production"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ot_production.client_id}=${ot_client.client_id} ;;
  }

  join: pro_production_experience_type {
    view_label: "AV Pro Production/Experience Join"
    type: left_outer
    relationship: one_to_many
    sql_on: ${ot_production.production_id}=${pro_production_experience_type.production_id} ;;
  }

  join: pro_experience_types {
    view_label: "AV Pro Experience"
    type: left_outer
    relationship: one_to_one
    sql_on: ${pro_experience_types.experience_type_id}=${pro_production_experience_type.experience_type_id} ;;
  }

  join: ot_performance {
    view_label: "AV Pro Performance"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ot_performance.production_id}=${ot_production.production_id} ;;
  }

  join: ot_performance_stats_consumed {
    view_label: "AV Pro Performance Sold Seat Manifest"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_performance.id}=${ot_performance_stats_consumed.performance_id} AND ${ot_performance_stats_consumed._fivetran_deleted} = false ;;
  }

  join: ot_performance_stats_total {
    view_label: "AV Pro Performance Seat Manifest"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_performance.id}=${ot_performance_stats_total.performance_id} AND ${ot_performance_stats_total._fivetran_deleted} = false ;;
  }

  join: pro_production_genre {
    view_label: "AV Pro Production Genre"
    type:  left_outer
    relationship: one_to_one
    sql_on: ${pro_production_genre.production_id}=${ot_production.production_id} ;;
  }
  join: pro_genres {
    view_label: "AV Pro Genre"
    type:  left_outer
    relationship: one_to_one
    sql_on: ${pro_production_genre.genre_id}=${pro_genres.genre_id} ;;
  }

  join: ot_client_enabled_feature {
    view_label: "AV Pro Client Features"
    type:left_outer
    relationship: one_to_one
    sql_on: ${ot_client_enabled_feature.client_id}=${ot_client.client_id} ;;
  }

  join: ot_accounting_client_daily_sales {
    view_label: "AV Pro Client Accounting Daily Sales"
    type: inner
    relationship: many_to_many
    sql_on: ${ot_accounting_client_daily_sales.client_id}=${ot_client.client_id} ;;
  }

  join: ot_client_account {
    view_label: "AV Pro Client Account"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_client.client_id}=${ot_client_account.client_id};;
  }

  join: ot_client_statement {
    view_label: "AV Pro Client Statement"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ot_client.client_id}=${ot_client_statement.client_id};;
  }

  join: sf_accounts {
    view_label: "SF Account"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.salesforce_account_id_c} = ${ot_report_crm.crm_id} AND ${sf_accounts.is_deleted}= FALSE;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }
  }

#------------------------

# AudienceView QBR-------
explore: av_qbr {
  label: "AV Unlimited"
  group_label: "Project Biblio"
  view_label: "AV Unlimited"

  join: sf_accounts {
    view_label: "SF Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${av_qbr.sf_client_id}=${sf_accounts.id} AND ${sf_accounts.is_deleted}= FALSE ;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }
  }
  #--------------------------

  # AudienceView Select-------
explore: sel_members {
  label: "AV Select Client"
  group_label: "Project Biblio"
  view_label: "AV Select Client"
  sql_always_where: ${testmode}="N" and ${active}="Y" and ${memberid} NOT IN ("4619e330fb68df17f017b1e89057d833", "211753f41b97e0700b33a570bde6c596", "6af4c79db09e0fb21d5f1b00095eaff8","4d8371bfae939dd32c7e10ff635b70bc","9e56c4935eea00caf287798718dfc94e","0d3536aad4341dcc256094c4c0bb0d6d","0fa0bb4fafbdb4cf5809433d80ab51e6","2a9dbca455e8b90c6b948bcb13939091","1df0aa9f217bb395fca282649811ec1e","af1ddb0b66213b3fa5ca8fa2f1f4d6ba", "45b4785ab727fd298943870f04dfcb8e","baae585e07764146b3692d35e7d2168d","e5d9bd60769bbf7b081349d50aa6b9c3","067da8bb66a30bdb73e10bde13bce8fb","8deca3b0ee8e883b6f89168e406cab12","dc7e2f44ca288588308940db1b45d4be","fe70ab1c75ffc4925639c07e0891a482","0806de427b3d1058a38169a25fce337f","f7d254de2d3506db04ef6eb89704fc28","c42dd251cd9381a73c5a0757fb77f5e9","0323d533228fc21ef9bdc14ba294e710","3ffe0a5e424b75967aa5d3fd326e4443","00d44100179c9b77eb6a06f46c85fa1e","ac43989129cab86b2f66eafbe84e639d","4ae6e9ab6d914b85eee46299348e163a","e7d0920b0ce8b6f293ff9c7d687466a9","a832a73fa655d6916d9d19f04aa47eb7","f5a0c859439061492b2f5d4d8c5552d2","2f6f48ca11bf79cb041f29517b3984bb","382d8d9d16f86d68c7b9ce9ae33933a8","1ac4cf3b7d79c3fd4593de81abd9e998","649d4c4f1bec4ce34dc9b1e03105d07b","75de64085f3d6cc501f5d3de02f16372","b5cc0907683f20463f2f084c6a3cd682","02217573d59983f801339bccb8b6869c","245515b655d69a0085b1f0096a0c6056","485902522b820b1d2315146956fd5325","b4bc3d66c4cb9051547a0ad897c9690d", "1410de8f55455590cca95acd53a8b97d","fb7ade9ed08721d8d1dd9b3a5eaf1482","85fbf43f381373e4f59033acb72c8b3a","4a2e13fb185fdaf7fad8ffdb9211f307") ;;

  join: sel_members_merchantaccounts {
    view_label: "AV Select Merchant Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_members_merchantaccounts.memberid} and ${sel_members_merchantaccounts.deleted} is NULL and ${sel_members_merchantaccounts.verified} = "Y"  ;;
  }

  join: sel_patrons {
    view_label: "AV Select Patron"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid} = ${sel_patrons.memberid} and ${sel_patrons.deleted} is NULL;;
  }

  join: sel_patrons_groups {
    view_label: "AV Select Patron Groups Join"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_patrons_groups.patronid} = ${sel_patrons.patronid} and ${sel_patrons_groups.deleted} is NULL;;
  }

  join: sel_patrongroups {
    view_label: "AV Select Patron Groups"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_patrons_groups.patrongroupid} = ${sel_patrongroups.patrongroupid} ;;
  }


  join: sel_arr {
    view_label: "AV Select ARR"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid} = ${sel_arr.memberid} ;;
  }

  join: sel_custom_forms {
    view_label: "AV Select Custom Forms"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid} = ${sel_custom_forms.memberid} and ${sel_custom_forms.deleted} IS NULL ;;
  }

  join: sel_etickettemplates {
    view_label: "AV Select E-Ticket Templates"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid} = ${sel_etickettemplates.memberid} and ${sel_etickettemplates.deleted} IS NULL ;;
  }

  join: sel_custom_windows {
    view_label: "AV Select Custom Windows"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid} = ${sel_custom_windows.memberid} and ${sel_custom_windows.deleted} IS NULL ;;
  }

  join: sel_agent_to_members {
    view_label: "AV Select Agents to Members"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_agent_to_members.memberid}  ;;
  }

  join: sel_emailcampaigns {
    view_label: "AV Select Email Campaigns"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_emailcampaigns.memberid} and ${sel_emailcampaigns.deleted} IS NULL  ;;
  }

  join: sel_email_campaigns_stats {
    view_label: "AV Select Email Stats"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_email_campaigns_stats.campaignid}=${sel_emailcampaigns.campaignid}   ;;
  }

  join: sel_members_scanners {
    view_label: "AV Select Members to Scanners"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_members_scanners.memberid}  ;;
  }

  join: sel_ticket_scans {
    view_label: "AV Select Scans"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members_scanners.scannerid}=${sel_ticket_scans.scannerid}  ;;
  }

  join: sel_feature_control_members {
    view_label: "AV Select Feature to Members"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_feature_control_members.memberid}  ;;
  }

  join: sel_feature_control {
    view_label: "AV Select Feature"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_feature_control.featurecontrolid}=${sel_feature_control_members.featurecontrolid}  ;;
  }

  join: sel_members_ticket_templates {
    view_label: "AV Select Ticket Templates to Members"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_members.memberid}=${sel_members_ticket_templates.memberid} and ${sel_members_ticket_templates.isdefault} = "Y"  ;;
  }

  join: sel_ticket_templates {
    view_label: "AV Select Ticket Templates"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_ticket_templates.templateid}=${sel_members_ticket_templates.templateid} and ${sel_ticket_templates.deleted} is NULL  ;;
  }

  join: sel_thermalprinters_members {
    view_label: "AV Select Thermal Printers to Members"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_members.memberid}=${sel_thermalprinters_members.memberid}  ;;
  }

  join: sel_thermalprinters {
    view_label: "AV Select Thermal Printers"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_thermalprinters.id}=${sel_thermalprinters_members.thermalprinterid} AND ${sel_thermalprinters.deleted} IS NULL  ;;
  }

  join: sel_agents {
    view_label: "AV Select Agents"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_agent_to_members.agentid}=${sel_agents.agentid} AND ${sel_agents.deleted_date} is NULL ;;
  }

  join: sel_max_login {
    view_label: "AV Select Login"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_max_login.sel_members_memberid} ;;
  }

  join: sel_payments_donations {
    view_label: "AV Select Payment Donations"
    type: inner
    relationship: one_to_many
    sql_on: ${sel_members.memberid}=${sel_payments_donations.memberid} AND round(safe_cast(${sel_payments_donations.amountheld} as FLOAT64),2) != 0 AND ${sel_payments_donations.settled} IS NULL ;;
  }

  join: sel_donations {
    view_label: "AV Select Donations"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sel_donations.memberid}=${sel_members.memberid} AND ${sel_donations.testmode} = "N" ;;
  }

  join: sel_donationcampaigns {
    view_label: "AV Select Donations Campaigns"
    type: inner
    relationship: one_to_one
    sql_on: ${sel_donationcampaigns.donationcampaignid}= ${sel_donations.donationcampaignid}  ;;
  }

  join: sel_transactions {
    view_label: "AV Select Transactions"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_transactions.orderid} ;;
  }

  join: sel_refunds {
    view_label: "AV Select Refunds"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_refunds.orderid}  ;;
  }

  join: sel_orders {
    view_label: "AV Select Orders"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.memberid}=${sel_members.memberid} and ${sel_orders.testmode} = "N" ;;
  }

  join: sel_memberships_sales {
    view_label: "AV Select Membership Sales"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_memberships_sales.orderid} ;;
  }

  join: sel_giftcardissued {
    view_label: "AV Select GiftCard Sales"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_giftcardissued.orderid} ;;
  }

  join: sel_orders_misclineitems {
    view_label: "AV Select Order Misc Items"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders_misclineitems.orderid}=${sel_orders.id} ;;
  }

  join: sel_social_campaign_purchases {
    view_label: "AV Select Social Platform Sales"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_social_campaign_purchases.memberid} ;;
  }

  join: sf_accounts {
    view_label: "SF Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sf_accounts.vam_member_id_c} AND ${sf_accounts.is_deleted}= FALSE ;;
  }

  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }

  join: sel_select_audit {
    view_label: "Select Audit"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_accounts.vam_member_id_c}=${sel_select_audit.vam_member_id} ;;
  }

  join: sel_finance_arr {
    view_label: "Select ARR"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_finance_arr.vam_member_id} ;;
  }

  join: sel_2019_ytd_arr {
    view_label: "Select ARR"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_2019_ytd_arr.member_id} ;;
  }

  join: sel_total_sales {
    view_label: "Select Orders 2020"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_total_sales.member_id} ;;
  }

  join: sel_nps_scores {
    view_label: "Select NPS Scores"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.organizationname}=${sel_nps_scores.sel_nps_scores_client_name} ;;
  }

  join: sel_events {
    view_label: "AV Select Series"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_members.memberid}=${sel_events.memberid} AND  ${sel_events.deleted} IS NULL ;;
  }

  join: sel_tickettypes {
    view_label: "AV Select Price Types"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_tickettypes.eventid}=${sel_events.eventid} ;;
  }

  join: sel_tags_to_events {
    view_label: "AV Select Event Tag Join"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_tags_to_events.eventid}=${sel_events.eventid} ;;
  }

  join: sel_tags {
    view_label: "AV Select Event Tags"
    type: left_outer
    relationship: many_to_many
    sql_on: ${sel_tags_to_events.tagid}=${sel_tags.tagid} AND ${sel_tags.deleted} IS NULL ;;
  }

  join: sel_tickettiers {
    view_label: "AV Select Ticket Tiers"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid} = ${sel_tickettiers.memberid} and ${sel_tickettiers.deleted} is NULL;;
  }

  join: sel_performances {
    view_label: "AV Select Performances"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_events.eventid}=${sel_performances.eventid} AND  ${sel_performances.deleted} IS NULL  ;;
  }

  join: sel_performances_tickettypes_tieredprices {
    view_label: "AV Select Performance Tiered Pricing"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_performances.performanceid}=${sel_performances_tickettypes_tieredprices.performanceid}   ;;
  }

  join: sel_performances_tickettypes_prices {
    view_label: "AV Select Performance Prices"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_performances.performanceid}=${sel_performances_tickettypes_prices.performanceid}   ;;
  }


  join: sel_performance_inventory {
    view_label: "AV Select Performance Inventory"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_performances.performanceid}=${sel_performance_inventory.ID} AND  ${sel_performances.deleted} IS NULL  ;;
  }

  join: sel_venues {
    view_label: "AV Select Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_events.venueid}=${sel_venues.venueid} AND  ${sel_venues.deleted} IS NULL ;;
  }

  join: sel_venue_maps {
    view_label: "AV Select Venue Maps"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_venue_maps.venueid}=${sel_venues.venueid} AND  ${sel_venue_maps.deleted} IS NULL ;;
  }

  join: sel_venue_map_seat_views {
    view_label: "AV Select Venue Map Seat Views"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_venue_maps.venuemapid}=${sel_venue_map_seat_views.venuemapid}  ;;
  }
  }

  #Select Transactions
explore: sel_orders {
  label: "AV Select Orders"
  group_label: "Project Biblio"
  view_label: "AV Select Orders"
  sql_always_where: ${sel_orders.testmode} = "N"   ;;

  join: sel_members {
    view_label: "AV Select Members"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_orders.memberid} and  ${sel_members.testmode}="N" and ${sel_members.active}="Y" and ${sel_members.memberid} NOT IN ("4619e330fb68df17f017b1e89057d833", "211753f41b97e0700b33a570bde6c596", "6af4c79db09e0fb21d5f1b00095eaff8","4d8371bfae939dd32c7e10ff635b70bc","9e56c4935eea00caf287798718dfc94e","0d3536aad4341dcc256094c4c0bb0d6d","0fa0bb4fafbdb4cf5809433d80ab51e6","2a9dbca455e8b90c6b948bcb13939091","1df0aa9f217bb395fca282649811ec1e","af1ddb0b66213b3fa5ca8fa2f1f4d6ba", "45b4785ab727fd298943870f04dfcb8e","baae585e07764146b3692d35e7d2168d","e5d9bd60769bbf7b081349d50aa6b9c3","067da8bb66a30bdb73e10bde13bce8fb","8deca3b0ee8e883b6f89168e406cab12","dc7e2f44ca288588308940db1b45d4be","fe70ab1c75ffc4925639c07e0891a482","0806de427b3d1058a38169a25fce337f","f7d254de2d3506db04ef6eb89704fc28","c42dd251cd9381a73c5a0757fb77f5e9","0323d533228fc21ef9bdc14ba294e710","3ffe0a5e424b75967aa5d3fd326e4443","00d44100179c9b77eb6a06f46c85fa1e","ac43989129cab86b2f66eafbe84e639d","4ae6e9ab6d914b85eee46299348e163a","e7d0920b0ce8b6f293ff9c7d687466a9","a832a73fa655d6916d9d19f04aa47eb7","f5a0c859439061492b2f5d4d8c5552d2","2f6f48ca11bf79cb041f29517b3984bb","382d8d9d16f86d68c7b9ce9ae33933a8","1ac4cf3b7d79c3fd4593de81abd9e998","649d4c4f1bec4ce34dc9b1e03105d07b","75de64085f3d6cc501f5d3de02f16372","b5cc0907683f20463f2f084c6a3cd682","02217573d59983f801339bccb8b6869c","245515b655d69a0085b1f0096a0c6056","485902522b820b1d2315146956fd5325","b4bc3d66c4cb9051547a0ad897c9690d", "1410de8f55455590cca95acd53a8b97d","fb7ade9ed08721d8d1dd9b3a5eaf1482","85fbf43f381373e4f59033acb72c8b3a","4a2e13fb185fdaf7fad8ffdb9211f307") ;;
  }

  join: sel_social_campaign_purchases {
    view_label: "AV Select Social Platform Sales"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}= safe_cast(${sel_social_campaign_purchases.orderid} as INT64) ;;
  }

  join: sel_arr {
    view_label: "AV Select ARR"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid} = ${sel_arr.memberid} ;;
  }

  join: sel_ticket_scans {
    view_label: "AV Select Scans"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_transactions.lastticketscanid}=${sel_ticket_scans.ticketscanid}  ;;
  }

  join: sel_payments {
    view_label: "AV Select Payment Info"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_payments.orderid}=${sel_orders.id} ;;
  }

  join: sel_members_merchantaccounts {
    view_label: "AV Select Merchant Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_members_merchantaccounts.memberid} and ${sel_members_merchantaccounts.deleted} is NULL and ${sel_members_merchantaccounts.verified} = "Y"  ;;
  }

  join: sel_max_login {
    view_label: "AV Select Login"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_max_login.sel_members_memberid} ;;
  }

  join: sel_finance_arr {
    view_label: "Select ARR"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_finance_arr.vam_member_id} ;;
  }

  join: sel_2019_ytd_arr {
    view_label: "Select ARR"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_2019_ytd_arr.member_id} ;;
  }

  join: sel_nps_scores {
    view_label: "Select NPS Scores"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.organizationname}=${sel_nps_scores.sel_nps_scores_client_name} ;;
  }

  join: sel_select_audit {
    view_label: "Select Audit"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_accounts.vam_member_id_c}=${sel_select_audit.vam_member_id} ;;
  }

  join: sf_accounts {
    view_label: "SF Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sf_accounts.vam_member_id_c} AND ${sf_accounts.is_deleted}= FALSE ;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }

  join: sel_transactions {
    view_label: "AV Select Transactions"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_transactions.orderid} and  ${testmode} = "N";;
  }

  join: sel_refunds {
    view_label: "AV Select Refunds"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_refunds.orderid}  ;;
  }

  join: sel_exchanges {
    view_label: "AV Select Exchanges"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_exchanges.orderid}  ;;
  }

  join: sel_orders_misclineitems {
    view_label: "AV Select Order Misc Items"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders_misclineitems.orderid}=${sel_orders.id} ;;
  }

  join: sel_donations {
    view_label: "AV Select Donations"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_donations.orderid}=${sel_orders.id} AND ${sel_donations.testmode} = "N" ;;
  }
  join: sel_donationcampaigns {
    view_label: "AV Select Donations Campaigns"
    type: inner
    relationship: one_to_one
    sql_on: ${sel_donationcampaigns.donationcampaignid}= ${sel_donations.donationcampaignid}  ;;
  }

  join: sel_memberships_sales {
    view_label: "AV Select Membership Sales"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_memberships_sales.orderid} ;;
  }

  join: sel_giftcardissued {
    view_label: "AV Select GiftCard Sales"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_orders.id}=${sel_giftcardissued.orderid} ;;
  }

  join: sel_performances {
    view_label: "AV Select Performances"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_transactions.performanceid}=${sel_performances.performanceid} AND  ${sel_performances.deleted} IS NULL  ;;
  }

  join: sel_events {
    view_label: "AV Select Series"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sel_performances.eventid}=${sel_events.eventid} AND  ${sel_events.deleted} IS NULL ;;
  }

  join: sel_venues {
    view_label: "AV Select Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_events.venueid}=${sel_venues.venueid} AND  ${sel_venues.deleted} IS NULL ;;
  }
}

  #Select Donation Report
  explore: sel_payments_donations {
    label: "AV Select Payments Donations"
    group_label: "Project Biblio"
    view_label: "AV Select Payments Donations"
    sql_always_where:safe_cast(${sel_payments_donations.amountheld} as FLOAT64) > 0 AND ${sel_payments_donations.settled} IS NULL ;;

    join: sel_donations {
      view_label: "AV Select Donations"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_donations.donationid}=${sel_payments_donations.donationid} AND ${sel_donations.testmode} = "N" ;;
    }

    join: sel_donationcampaigns {
      view_label: "AV Select Donations Campaigns"
      type: inner
      relationship: one_to_one
      sql_on: ${sel_donationcampaigns.donationcampaignid}= ${sel_donations.donationcampaignid}  ;;
    }
    join: sel_members {
      view_label: "AV Select Marchant Accountss"
      type: inner
      relationship: one_to_one
      sql_on: ${sel_members.memberid}=${sel_payments_donations.memberid} AND ${sel_members.testmode}="N" AND ${sel_members.active}="Y" ;;
    }

    join: sel_performances {
      view_label: "AV Select Performances"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sel_performances.performanceid}=${sel_performances.eventid}  ;;
    }

    join: sel_events {
      view_label: "AV Select Series"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sel_members.memberid}=${sel_events.memberid} ;;
    }

    join: sel_transactions {
      view_label: "AV Select Transactions"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_members.memberid}=${sel_transactions.memberid};;
    }
    join: sel_memberships_sales {
      view_label: "AV Select Membership Sales"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_orders.id}=${sel_memberships_sales.orderid} ;;
    }

    join: sel_giftcardissued {
      view_label: "AV Select GiftCard Sales"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_orders.id}=${sel_giftcardissued.orderid} ;;
    }

    join: sel_refunds {
      view_label: "AV Select Refunds"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_orders.id}=${sel_refunds.orderid}  ;;
    }

    join: sel_orders {
      view_label: "AV Select Orders"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_orders.id}=${sel_transactions.orderid} and ${sel_orders.testmode} = "N" ;;
    }

    join: sel_orders_misclineitems {
      view_label: "AV Select Order Misc Items"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_orders_misclineitems.orderid}=${sel_orders.id} ;;
    }
    join: sf_accounts {
      view_label: "SF Accounts"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_members.memberid}=${sf_accounts.vam_member_id_c} AND ${sf_accounts.is_deleted}= FALSE ;;
    }
    join: sf_net_arr_2019 {
      view_label: "Salesforce 2019 NET ARR"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
    }

 }

  #Select performance stats explore for settlement issue
  explore: sel_performance_stats {
    label: "AV Select Peformance Stats"
    group_label: "Project Biblio"
    view_label: "AV Select Performance Stats"

    join: sel_members {
      view_label: "AV Select Members"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_members.memberid}=${sel_performance_stats.memberid} ;;
    }

    join: sf_accounts {
      view_label: "SF Accounts"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sel_members.memberid}=${sf_accounts.vam_member_id_c} AND ${sf_accounts.is_deleted}= FALSE ;;
    }
    join: sf_net_arr_2019 {
      view_label: "Salesforce 2019 NET ARR"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
    }

    join: sf_contact {
      view_label: "SF Contact"
      type: left_outer
      relationship: one_to_one
      sql_on: ${sf_accounts.id} = ${sf_contact.account_id} ;;
    }
    join: sf_case {
      view_label: "SF Case"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sf_contact.id} = ${sf_case.contact_id} ;;
    }
    join: sf_settlement_split {
      view_label: "Salesforce Settlement Split"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sf_case.id}=${sf_settlement_split.id} AND ${sf_case.is_deleted} = FALSE;;
    }

    join: sel_performances {
      view_label: "AV Select Performances"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sel_performance_stats.performanceid}=${sel_performances.performanceid}  ;;
    }

    join: sel_events {
      view_label: "AV Select Series"
      type: left_outer
      relationship: one_to_many
      sql_on: ${sel_performances.eventid}=${sel_events.eventid} ;;
    }
    }

  #GA Conversion rate
  explore: ga_pro_conversion {
    label: "GA Pro Conversion"
    group_label: "Project Biblio"
    view_label: "GA Pro Conversion"
    }


#CrowdTorch Performance Stats Settlement Issue
explore: ct_performance_stats {
  label: "CT Performance Stats"
  group_label: "Project Biblio"
  view_label: "CT Performance Stats"

  join: sf_accounts {
    view_label: "SF Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_performance_stats.client_id}=${sf_accounts.ct_client_id_c} AND ${sf_accounts.is_deleted}= FALSE ;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }

  join: sf_contact {
    view_label: "SF Contact"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_accounts.id} = ${sf_contact.account_id} ;;
  }
  join: sf_case {
    view_label: "SF Case"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_contact.id} = ${sf_case.contact_id} ;;
  }
  join: sf_settlement_split {
    view_label: "Salesforce Settlement Split"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_case.id}=${sf_settlement_split.id} AND ${sf_case.is_deleted} = FALSE;;
  }
}

explore: ct_transactions {
  label: "CT Client Transactions"
  group_label: "Project Biblio"
  view_label: "CT Client Transactions"
  sql_always_where: ${dataset} IN ('donationFund', 'donationFundRefund','ticketOrder', 'ticketRefundOrder', 'merchandiseRefundOrder', 'merchandiseOrder') and (CAST(${ct_transactions.transactiontime_date} AS TIMESTAMP)  >= TIMESTAMP('2018-01-01 00:00:00')) and ${clientid} NOT IN (15,10353725) ;;

  join: ct_clientvenues {
    view_label: "CT Client Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_transactions.clientid} = ${ct_clientvenues.clientid} and ${ct_clientvenues.venueid} = ${ct_transactions.venueid} ;;
  }

  join: ct_fx_rates {
    view_label: "CT FX Rate"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_transactions.transactiontime_raw}) = ${ct_fx_rates.periodid}
    and ${ct_transactions.transactiontime_year} = ${ct_fx_rates.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates.currency} ;;
    }

  join: ct_fx_rates_bs {
    view_label: "CT FX Rate BS"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_transactions.transactiontime_raw}) = ${ct_fx_rates_bs.periodid}
    and ${ct_transactions.transactiontime_year} = ${ct_fx_rates_bs.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates_bs.currency} ;;
  }

  join: ct_ar_transmap {
    view_label: "CT AR Transmap"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_transactions.datatransactionid} = ${ct_ar_transmap.datatransactionid}  ;;
  }

  join: ct_ar_invoices {
    view_label: "CT AR Invoices"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_ar_invoices.ar_id} = ${ct_ar_transmap.ar_id}  ;;
  }

  join: ct_ar_showdatevenues {
    view_label: "CT AR Show/Date Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_transactions.clientid} = ${ct_ar_showdatevenues.clientid} and ${ct_ar_showdatevenues.venueid} = ${ct_transactions.venueid} ;;
  }

  join: ct_master_list {
    view_label: "CT Client Facts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_transactions.clientname} = ${ct_master_list.client_name} and ${ct_clientvenues.venuename} = ${ct_master_list.venue_name} ;;
  }

  join: ct_arr {
    view_label: "CT ARR"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_transactions.clientid}=${ct_arr.client_id} and ${ct_arr.client_id} <> 10353725 ;;
  }

  join: sf_accounts {
    view_label: "SF Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_transactions.clientid} = cast(${sf_accounts.ct_client_id_c} as INT64) AND ${sf_accounts.is_deleted}= FALSE and ${sf_accounts.ct_client_id_c} is NOT NULL ;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }
}


explore: ct_ar_invoices_dt {
  label: "CT Invoice Export"
  group_label: "Project Biblio"
  view_label: "CT Invoice Export"
}

#CT Invoice Reports
explore: ct_ap_invoices {
  label: "CT AP Invoice Statements"
  group_label: "Project Biblio"
  view_label: "CT AP Invoices"
  sql_always_where: ${ct_charges.module} = "AP" and ${ct_charges.serviceid} Not In (80, 95, 96, 98, 99);;

  join: ct_charges {
    view_label: "CT Client Charges"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_charges.ap_id} = ${ct_ap_invoices.ap_id} ;;
  }

  join: ct_clientvenues {
    view_label: "CT Client Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_ap_invoices.clientid} = ${ct_clientvenues.clientid} and ${ct_clientvenues.venueid} = ${ct_ap_invoices.venueid} ;;
  }

  join: ct_fx_rates {
    view_label: "CT FX Rate"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_ap_invoices.invoicedate_raw}) = ${ct_fx_rates.periodid}
    and ${ct_ap_invoices.invoicedate_year} = ${ct_fx_rates.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates.currency} ;;
  }

  join: ct_fx_rates_bs {
    view_label: "CT FX Rate BS"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_ap_invoices.invoicedate_raw}) = ${ct_fx_rates_bs.periodid}
    and ${ct_ap_invoices.invoicedate_year} = ${ct_fx_rates_bs.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates_bs.currency} ;;
  }


  join: ct_charges_glnumber {
    view_label: "CT Client Charges GL Number"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_charges_glnumber.serviceid} = ${ct_charges.serviceid} ;;
  }
}

#CT AR Payments
explore: ct_ar_payments {
  label: "CT AR Payments"
  group_label: "Project Biblio"
  view_label: "CT AR Payments"

  join: ct_clientvenues {
    view_label: "CT Client Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_ar_payments.clientid} = ${ct_clientvenues.clientid} and ${ct_clientvenues.venueid} = ${ct_ar_payments.venueid} ;;
  }

  join: ct_fx_rates {
    view_label: "CT FX Rate"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_ar_payments.pmtdate_raw}) = ${ct_fx_rates.periodid}
    and ${ct_ar_payments.pmtdate_year} = ${ct_fx_rates.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates.currency} ;;
  }

  join: ct_fx_rates_bs {
    view_label: "CT FX Rate BS"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_ar_payments.pmtdate_raw}) = ${ct_fx_rates_bs.periodid}
    and ${ct_ar_payments.pmtdate_year} = ${ct_fx_rates_bs.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates_bs.currency} ;;
  }
}

#CT AR Invoices
explore: ct_ar_invoices_trans {
  label: "CT AR Invoice Statements"
  group_label: "Project Biblio"
  view_label: "CT AR Transmap Invoices"

  join: ct_clientvenues {
    view_label: "CT Client Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_ar_invoices_trans.clientid} = ${ct_clientvenues.clientid} and ${ct_clientvenues.venueid} = ${ct_ar_invoices_trans.venueid} ;;
  }

  join: ct_laughstub_venues {
    view_label: "CT LS Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_ar_invoices.venueid} = ${ct_laughstub_venues.venueid} ;;
  }

  join: ct_laughstub_servicesoffered {
    view_label: "CT LS Venues"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_ar_invoices_trans.saletypeid} = ${ct_laughstub_servicesoffered.serviceid} ;;
  }

  join: ct_ar_invoices {
    view_label: "CT AR Invoices"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_ar_invoices_trans.ar_id}=${ct_ar_invoices.ar_id}  ;;
  }
  join: ct_fx_rates {
    view_label: "CT FX Rate"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_ar_invoices.invoicedate_raw}) = ${ct_fx_rates.periodid}
    and ${ct_ar_invoices.invoicedate_year} = ${ct_fx_rates.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates.currency} ;;
  }

  join: ct_fx_rates_bs {
    view_label: "CT FX Rate BS"
    type: inner
    relationship: one_to_one
    sql_on:
    EXTRACT(MONTH FROM ${ct_ar_invoices.invoicedate_raw}) = ${ct_fx_rates_bs.periodid}
    and ${ct_ar_invoices.invoicedate_year} = ${ct_fx_rates_bs.yearid}
    and ${ct_clientvenues.billingcurrency} = ${ct_fx_rates_bs.currency} ;;
  }
  join: ct_charges_glnumber {
    view_label: "CT Client Charges GL Number"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_charges_glnumber.serviceid} = ${ct_ar_invoices_trans.saletypeid} ;;
  }
  }

explore: ct_unbilled_indirect_revenue {
  label: "CT Unbilled Indirect Revenue"
  group_label: "Project Biblio"
  view_label: "CT Unbillted Indirect Revenue"
  }

#Select Purchase Stats
explore: sel_purchase_stats {
  label: "AV Select Purchase Stats"
  group_label: "Project Biblio"
  view_label: "AV Select Purchase Stats"
}

explore: sel_purchase_finance_view {
  label: "AV Select Purchase Finance"
  group_label: "Project Biblio"
  view_label: "AV Select Purchase Finance"

  join: sel_members {
    view_label: "AV Select Members"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_purchase_finance_view.memberid}  ;;
}
}

explore: sel_total_sales {
  label: "AV Select Purchase Two"
  group_label: "Project Biblio"
  view_label: "AV Select Purchase Two"

  join: sel_members {
    view_label: "AV Select Members"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sel_members.memberid}=${sel_total_sales.member_id}  ;;
  }
  }


#CT Stats
explore: ct_clients {
  label: "CT Clients"
  group_label: "Project Biblio"
  view_label: "CT Clients"

  join: sf_accounts {
    view_label: "SF Accounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ct_clients.client_id}=${sf_accounts.ct_client_id_c} AND ${sf_accounts.is_deleted}= FALSE ;;
  }
  join: sf_contact {
    view_label: "SF Contact"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sf_accounts.id} = ${sf_contact.account_id} ;;
  }
  join: sf_net_arr_2019 {
    view_label: "Salesforce 2019 NET ARR"
    type: left_outer
    relationship: one_to_many
    sql_on: ${sf_accounts.id}=${sf_net_arr_2019.id} ;;
  }
  }

#Select CT Purchase  Stats
explore: ct_purchase_stats {
  label: "CT Purchase Stats"
  group_label: "Project Biblio"
  view_label: "CT Purchase Stats"
}

#Competitor Feature Stats
explore: competitor {
  label: "Competitor Matrix"
  group_label: "Project Biblio"
  view_label: "Competitor"

  join: accountmanagement_support {
    view_label: "Acocunt Management Support"
    type: left_outer
    relationship: one_to_one
    sql_on: ${accountmanagement_support.competitor_name} = ${competitor.competitor_name} ;;
  }
  join: crm_donations {
    view_label: "CRM Donations"
    type: left_outer
    relationship: one_to_one
    sql_on: ${crm_donations.competitor_name} = ${competitor.competitor_name} ;;
  }
  join: event_management {
    view_label: "Event Management"
    type: left_outer
    relationship: one_to_one
    sql_on: ${event_management.competitor_name} = ${competitor.competitor_name} ;;
  }
  join: ticketing_onlinesales {
    view_label: "Ticketing & Online Sales"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ticketing_onlinesales.competitor_name} = ${competitor.competitor_name} ;;
  }
}

#Select On Boarding
explore: client_fact_sheet {
  label: "AV Select On-Boarding"
  group_label: "Project Biblio"
  view_label: "Select Client Fact"

  join: order_fact_sheet {
    view_label: "Select Order Fact"
    type: left_outer
    relationship: one_to_one
    sql_on: ${client_fact_sheet.sf_accounts_salesforce_id} = ${order_fact_sheet.sf_accounts_salesforce_id} ;;
  }
  join: sel_website_manager {
    view_label: "Select Website Fact"
    type: left_outer
    relationship: one_to_one
    sql_on: ${client_fact_sheet.sf_accounts_salesforce_id} = ${sel_website_manager.sf_accounts_salesforce_id} ;;
  }
  join: sel_donation_campaigns_facts {
    view_label: "Select Donation Fact"
    type: left_outer
    relationship: one_to_one
    sql_on: ${client_fact_sheet.sf_accounts_salesforce_id} = ${sel_donation_campaigns_facts.sf_accounts_salesforce_id} ;;
  }

}

  #-----------------------
