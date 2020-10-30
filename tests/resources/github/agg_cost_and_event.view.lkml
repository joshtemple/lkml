view: agg_cost_and_event {
  derived_table: {
    sql: select lineitem_usagestartdate,lineitem_blendedcost,event_cost,identity_cost,infrastructure_cost,other_cost,recommendation_cost,resource_cost,uncategorized_cost,events_date,messages_sent,messages_delivered,messages_opened,all_events_count,bt_person_sets,bt_recs_served,bt_rec_views,bt_rec_clicks,bt_recset_requests,messages_clicked,messages_converted,messages_skipped,messages_bounced,messages_complained,unsubscribed
      from
      (SELECT
        DATE(aggr_siteid_event_types_daily.events_date ) AS "events_date",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'nudgespot::message_sent') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_sent",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'system::message_delivered') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_delivered",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'nudgespot::message_opened') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_opened",
        COALESCE(SUM(aggr_siteid_event_types_daily.events_count ), 0) AS "all_events_count",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'bt_person_set') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "bt_person_sets",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'bt_rec_served') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "bt_recs_served",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'bt_rec_view') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "bt_rec_views",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'bt_rec_click') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "bt_rec_clicks",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'bt_recset_request') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "bt_recset_requests",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'nudgespot::message_clicked') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_clicked",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'system::message_converted') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_converted",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'nudgespot::message_skipped') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_skipped",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'system::message_bounced') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_bounced",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type LIKE 'system::message_complained') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "messages_complained",
        COALESCE(SUM(CASE WHEN (aggr_siteid_event_types_daily.event_type = 'system::unsubscribed') THEN aggr_siteid_event_types_daily.events_count  ELSE NULL END), 0) AS "unsubscribed"
      FROM site_event_aggregates.aggr_siteid_event_types_daily  AS aggr_siteid_event_types_daily
      GROUP BY 1 ) ec
      left join
      (
      SELECT
        DATE(agg_aws_cost.lineitem_usagestartdate ) AS "lineitem_usagestartdate",
        COALESCE(SUM(agg_aws_cost.lineitem_blendedcost ), 0) AS "lineitem_blendedcost",
        COALESCE(SUM(CASE WHEN (agg_aws_cost.user_feature  IN ('events', 'event','message')) THEN agg_aws_cost.lineitem_blendedcost  ELSE 0 END), 0) AS "event_cost",
        COALESCE(SUM(CASE WHEN (agg_aws_cost.user_feature = 'identity') THEN agg_aws_cost.lineitem_blendedcost  ELSE 0 END), 0) AS "identity_cost",
        COALESCE(SUM(CASE WHEN (agg_aws_cost.user_feature = 'infrastructure') THEN agg_aws_cost.lineitem_blendedcost  ELSE 0 END), 0) AS "infrastructure_cost",
        COALESCE(SUM(CASE WHEN (agg_aws_cost.user_feature
        NOT IN ('untagged','events', 'event','message','identity','infrastructure','recommendations','resources') and agg_aws_cost.user_feature is not null) THEN agg_aws_cost.lineitem_blendedcost  ELSE 0 END), 0) AS "other_cost",
        COALESCE(SUM(CASE WHEN (agg_aws_cost.user_feature = 'recommendations') THEN agg_aws_cost.lineitem_blendedcost  ELSE 0 END), 0) AS "recommendation_cost",
        COALESCE(SUM(CASE WHEN (agg_aws_cost.user_feature = 'resources') THEN agg_aws_cost.lineitem_blendedcost  ELSE 0 END), 0) AS "resource_cost",
        COALESCE(SUM(CASE WHEN (agg_aws_cost.user_feature='untagged' or agg_aws_cost.user_feature is null) THEN agg_aws_cost.lineitem_blendedcost  ELSE 0 END), 0) AS "uncategorized_cost"
      FROM aws_cost.agg_aws_cost agg_aws_cost
      WHERE lineitem_usageaccountid in ('066377602118','766806801073')
      GROUP BY 1) ac
      on ac.lineitem_usagestartdate=ec.events_date
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: lineitem_usagestartdate {
    type: date
    sql: ${TABLE}.lineitem_usagestartdate ;;
  }

  dimension: events_date {
    type: date
    sql: ${TABLE}.events_date ;;
  }

  measure: lineitem_blendedcost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.lineitem_blendedcost ;;
    value_format_name: usd_0
  }

  measure: event_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.event_cost ;;
    value_format_name: usd_0
  }

  measure: identity_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.identity_cost ;;
    value_format_name: usd_0
  }

  measure: infrastructure_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.infrastructure_cost ;;
    value_format_name: usd_0
  }

  measure: other_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.other_cost ;;
    value_format_name: usd_0
  }

  measure: recommendation_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.recommendation_cost ;;
    value_format_name: usd_0
  }
  measure: resource_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.resource_cost ;;
    value_format_name: usd_0
  }

  measure: uncategorized_cost {
    view_label: "Cost Metrics"
    type: sum
    sql: ${TABLE}.uncategorized_cost ;;
    value_format_name: usd_0
  }

  measure: messages_sent {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_sent ;;

  }

  measure: messages_delivered {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_delivered ;;

  }

  measure: messages_opened {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_opened ;;

  }

  measure: all_events_count {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.all_events_count ;;

  }
  measure: bt_person_sets {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_person_sets ;;

  }

  measure: bt_recs_served {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_recs_served ;;

  }

  measure: bt_rec_views {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_rec_views ;;

  }


  measure: bt_rec_clicks {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_rec_clicks ;;

  }

  measure: bt_recset_requests {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.bt_recset_requests ;;

  }

  measure: messages_clicked {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_clicked ;;

  }

  measure: messages_converted {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_converted ;;

  }

  measure: messages_skipped {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_skipped ;;

  }
  measure: messages_bounced {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_bounced ;;

  }
  measure: messages_complained {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.messages_complained ;;

  }
  measure: unsubscribed {
    view_label: "Event Metrics"
    type: sum
    sql: ${TABLE}.unsubscribed ;;

  }

  set: detail {
    fields: [
      lineitem_usagestartdate,
      lineitem_blendedcost,
      event_cost,
      identity_cost,
      infrastructure_cost,
      other_cost,
      recommendation_cost,
      resource_cost,
      uncategorized_cost,
      events_date,
      messages_sent,
      messages_delivered,
      messages_opened,
      all_events_count,
      bt_person_sets,
      bt_recs_served,
      bt_rec_views,
      bt_rec_clicks,
      bt_recset_requests,
      messages_clicked,
      messages_converted,
      messages_skipped,
      messages_bounced,
      messages_complained,
      unsubscribed
    ]
  }
}
