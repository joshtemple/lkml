explore: fact_common {
  join: dim_domain {view_label: "Data Attributes" sql_on:${dim_domain.id}=${fact_common.domain_id};;}
  join: dim_zone {view_label: "Data Attributes" sql_on:${dim_zone.id}=${fact_common.zone_id};;}
  join: dim_campaign {view_label: "Data Attributes" sql_on:${dim_campaign.id}=${fact_common.campaign_id};;}
  join: dim_device {view_label: "Data Attributes" sql_on:${dim_device.id}=${fact_common.device_id};;}
}

view: dim_device {
  dimension: id {hidden:yes}
  dimension: device_name {required_fields:[fact_common.device_id]}
}
view: dim_domain {
  dimension: id {hidden:yes}
  dimension: domain_name {}
}
view: dim_zone {
  dimension: id {hidden:yes}
  dimension: zone_name {}
}
view: dim_campaign {
  dimension: id {hidden:yes}
  dimension: campaign_name {}
}
view: fact_common {
  sql_table_name:
  {% if device_id._in_query and domain_id._in_query
    or device_id._in_query  and zone_id._in_query
    or device_id._in_query  and campaign_id._in_query %}

  public.fact_all

  {% elsif domain_id._in_query  and zone_id._in_query
    or domain_id._in_query  and campaign_id._in_query %}

  public.fact_all

  {% elsif zone_id._in_query    and campaign_id._in_query %}

  public.fact_all

  {% elsif device_id._in_query %}
  public.fact_device
  {% elsif domain_id._in_query %}
  public.fact_domain
  {% elsif zone_id._in_query %}
  public.fact_zone
  {% elsif campaign_id._in_query %}
  public.fact_campaign
  {% else %}
  public.fact_null
  {% endif %}
;;

# Unshared dimensions
  dimension: device_id {hidden:yes}
  dimension: zone_id {hidden:yes}
  dimension: domain_id {hidden:yes}
  dimension: campaign_id {hidden:yes}

  dimension: publisher_id {}
  measure: total_impressions {type:sum sql: ${TABLE}.impressions;;}
  }
