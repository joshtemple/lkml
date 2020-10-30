label: "Kaboodle BPO"
connection: "bpo"

include: "*.view"
#include: "*.dashboard"

fiscal_month_offset: 0
persist_for: "30 minutes"

week_start_day: sunday

explore: print_and_distribution {
  description: "BPO's print and distribution operations, to gauge turnaround in print and mailing of batches in comparison to customer's SLA"
  label: "Actual vs SLA"
  group_label: "BPO: Print & Distribution"
  view_label: "Service Level Agreement"
  hidden: no
  sql_always_where: ${service_type.servicetype_id}=1 ;;    #servicetype_id = 1 is for "Print & Distribution as in the table"
  persist_for: "4 hours"
  from: print_and_distribution
  view_name: print_and_distribution
  sql_table_name: rpt.sla ;;

  #fields: []
  #always_filter: {}
  #always_join: []

  access_filter: {
    field:customer.customer_name
    user_attribute:company_name
  }

  join: customer {
    type: inner
    relationship: many_to_one
    from: "customer"
    sql_table_name: dbo.Customer ;;
    view_label: "Company"
    #required_joins: []
    #foreign_key:
    sql_on: ${print_and_distribution.customer_id} = ${customer.customer_id} ;;
  }

  join: service_type {
    type: inner
    relationship: many_to_one
    from: service_type
    sql_table_name: dbo.ServiceType ;;
    view_label: "Service Types"
    #required_joins: []
    #foreign_key:
    sql_on: ${print_and_distribution.service_type_id} = ${service_type.servicetype_id} ;;
  }

  join: service_job_type {
    type: inner
    relationship: many_to_one
    from: service_job_type
    sql_table_name: dbo.ServiceJobType ;;
    view_label: "Service Job Types"
    #required_joins: []
    #foreign_key:
    sql_on: ${print_and_distribution.service_job_type_id} = ${service_job_type.servicejobtype_id} ;;
  }

  join: sla_group_type {
    type: inner
    relationship: many_to_one
    from: sla_group_type
    sql_table_name: dbo.SLAGroupType ;;
    view_label: "Service Groups"
    #required_joins: []
    #foreign_key:
    sql_on: ${service_job_type.slagrouptype_id} = ${sla_group_type.slagrouptype_id};;
  }

  join: total_print_counts {
    type: inner
    relationship: many_to_one
    view_label: "Cohort"
    sql_on: ${print_and_distribution.service_job_type_id} = ${total_print_counts.servicejobtype_id} and
            ${print_and_distribution.sla_month_month} = ${total_print_counts.sla_month_month} and
            ${print_and_distribution.sla_month_year} = ${total_print_counts.sla_month_year};;
  }
}


explore: postage_data {
  description: "BPO's postage usage measure"
  label: "Postage Meter"
  group_label: "BPO: Print & Distribution"
  view_label: "Postage Usage"
  persist_for: "4 hours"
  from: postage_data
  view_name: postage_data
  sql_table_name: dbo.MeterData ;;

  access_filter: {
    field:customer.customer_name
    user_attribute:company_name
  }

  join: meter_account {
    type: inner
    relationship: many_to_one
    from: "meter_account"
    sql_table_name: dbo.MeterAccount ;;
    view_label: "Postage Meter Account"
    #required_joins: []
    #foreign_key:
    sql_on: ${postage_data.meteraccount_id} = ${meter_account.meteraccount_id} ;;
  }

  join: customer {
    type: inner
    relationship: many_to_one
    from: "customer"
    sql_table_name: dbo.Customer ;;
    view_label: "Company"
    #required_joins: []
    #foreign_key:
    sql_on: ${meter_account.customer_id} = ${customer.customer_id} ;;
  }

  join: mail_class_type {
    type: inner
    relationship: many_to_one
    from: mail_class_type
    sql_table_name: dbo.MailClassType ;;
    view_label: "Mailing Classes"
    #required_joins: []
    #foreign_key:
    sql_on: ${postage_data.mailclasstype_id} = ${mail_class_type.mailclasstype_id} ;;
  }

  join: sla_group_type {
    type: inner
    relationship: many_to_one
    from: sla_group_type
    sql_table_name: dbo.SLAGroupType ;;
    view_label: "Service Groups"
    #required_joins: []
    #foreign_key:
    sql_on: ${meter_account.slagrouptype_id} = ${sla_group_type.slagrouptype_id} ;;
  }

  join: unused_postage {
    type: inner
    relationship: many_to_many
    from: unused_postage
    sql_table_name: dbo.UnusedPostage ;;
    view_label: "Unused Postage"
    #required_joins: []
    #foreign_key:
    sql_on: ${postage_data.meteraccount_id} = ${unused_postage.meteraccount_id} and ${meter_account.slagrouptype_id} = ${sla_group_type.slagrouptype_id} ;;
    sql_where: ${unused_postage.unusedpostagetype_id} <> 11 ;;
  }

  #join: unused_postage_type {
  #  type: inner
  #  relationship: many_to_one
  #  from: unused_postage_type
  #  sql_table_name: dbo.UnusedPostageType ;;
  #  view_label: "Unused Postage Type"
  #  #required_joins: []
  #  #foreign_key:
  #  sql_on: ${unused_postage.unusedpostagetype_id} = ${unused_postage_type.unusedpostagetype_id} ;;
  #}
}


explore: phone_log {
  description: "BPO's Customer Service Performance"
  label: "Customer Service (Phone/Chat)"
  group_label: "BPO: Customer Service"
  view_label: "Call/Chat Characteristics"
  hidden: no

  #persist_for: "1 hours"
  from: phone_log
  view_name: phone_log
  sql_table_name: pho.PhoneLog ;;
  sql_always_where: ((CASE WHEN ((ISNULL(from_transfer,0)=0) AND (ISNULL(from_conference,0)=0)) THEN 1 ELSE 0 END) <> 0)
      --Next condition: Incoming calls only
      AND ${direction_type.directiontype_id} = 1
      --Next condition: Exclude when customer name is 'Covenir'
      AND LEFT(${customer.customer_name},7) <> 'Covenir'
      --Next condition: removed since it doesn't take in consideration answered calls outside of the 8 to 8 time frame. Replaced by the condition 2 lines down.
      --AND CAST(create_time as time) BETWEEN '08:00:00.0000000' AND '19:59:59.9999999'
      --Next condition: Exclude weekends, only counting weekdays.
      AND datepart(dw,create_time) <> 1 and datepart(dw,create_time) <> 7
      --Next condition: Answered calls always counts, but abandoned calls only counts during 8am to 8pm weekdays.
      AND ((CASE WHEN ((${accept_time} > '1900-01-01') OR (CAST(create_time as time) BETWEEN '08:00:00.0000000' AND '19:59:59.9999999')) THEN 1 ELSE 0 END) <> 0)
      ;;

  #fields: []
  #always_filter: {}
  #always_join: []

    join: channel_type {
      type: inner
      relationship: many_to_one
      from: "channel_type"
      sql_table_name: pho.ChannelType ;;
      view_label: "Call/Chat Characteristics"
      sql_on: ${phone_log.channeltype_id} = ${channel_type.channeltype_id} ;;
    }

    join: media_type {
      type: inner
      relationship: many_to_one
      from: "media_type"
      sql_table_name: pho.MediaType ;;
      view_label: "Call/Chat Characteristics"
      sql_on: ${phone_log.mediatype_id} = ${media_type.mediatype_id} ;;
    }

    join: queue_type {
      type: inner
      relationship: many_to_one
      from: "queue_type"
      sql_table_name: pho.QueueType ;;
      view_label: "Call/Chat Characteristics"
      sql_on: ${phone_log.queuetype_id} = ${queue_type.queuetype_id} ;;

      # MN 2018-09-06 Remove calls that never made it to a queue. A blank queue in the source data translates to queuetype_id 24. We can eliminate based on this ID.
      sql_where: ${queue_type.queuetype_id} <> 24 ;;

      # MN 2018-09-06 2.  Remove the criteria checking for a user type of Customer Service and instead filter on the new data point of servicetype_id on pho.queuetype.
      # We should only include queues that have a servicetype_id of 4 (customer support). Doing this will also correct item 1. We have had some folks change roles,
      # and thusly change user types. We don’t want to remove them from the call log data review due to this.
      sql_where: ${queue_type.servicetype_id} = 4 ;;

    }

    join: direction_type {
      type: inner
      relationship: many_to_one
      from: "direction_type"
      sql_table_name: pho.DirectionType ;;
      view_label: "Call/Chat Characteristics"
      sql_on: ${phone_log.directiontype_id} = ${direction_type.directiontype_id} ;;
    }

    join: call_type {
      type: inner
      relationship: many_to_one
      from: "call_type"
      sql_table_name: pho.CallType ;;
      view_label: "Call/Chat Characteristics"
      sql_on: ${phone_log.calltype_id} = ${call_type.calltype_id} ;;
    }

    join: customer {
      type: inner
      relationship: many_to_one
      from: "customer"
      sql_table_name: dbo.customer ;;
      view_label: "Customer"
      sql_on: ${channel_type.customer_id} = ${customer.customer_id} ;;
    }

    join: users {
      type: inner
      relationship: many_to_one
      from: "users"
      sql_table_name: dbo.users ;;
      view_label: "CSR"
      sql_on: ${phone_log.users_id} = ${users.users_id} ;;
      sql_where: ${phone_log.users_id} <> 0  ;;
    }

    join: user_type {
      type: left_outer
      relationship: many_to_one
      from: "user_type"
      sql_table_name: dbo.usertype ;;
      view_label: "CSR"
      sql_on: ${users.usertype_id} = ${user_type.usertype_id} ;;
    }
  }
