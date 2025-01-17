view: ad_impressions_base {
  extension: required
  extends: [date_base, period_base, google_ad_metrics_base]
}

explore: ad_impressions_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_adapter]
  from: ad_impressions
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions"
  view_label: "Impressions"
}

view: ad_impressions_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_adapter]
}

explore: ad_impressions_daily_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_daily_adapter]
  from: ad_impressions_daily
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Day"
  view_label: "Impressions by Day"
}

view: ad_impressions_daily_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_daily_adapter]
}

explore: ad_impressions_campaign_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_campaign_adapter]
  from: ad_impressions_campaign
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

view: ad_impressions_campaign_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_campaign_adapter]
}

explore: ad_impressions_campaign_daily_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_campaign_daily_adapter]
  from: ad_impressions_campaign_daily
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

view: ad_impressions_campaign_daily_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_campaign_daily_adapter]
}

explore: ad_impressions_ad_group_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_ad_group
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

view: ad_impressions_ad_group_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_ad_group_adapter]
}

explore: ad_impressions_ad_group_hour_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_hour_adapter]
  from: ad_impressions_ad_group_hour
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Ad Group & Hour"
  view_label: "Impressions by Ad Group & Hour"
}

view: ad_impressions_ad_group_hour_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_ad_group_hour_adapter]
}

explore: ad_impressions_keyword_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_keyword_adapter]
  from: ad_impressions_keyword
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Keyword"
  view_label: "Impressions by Keyword"
}

view: ad_impressions_keyword_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_keyword_adapter]
}

explore: ad_impressions_ad_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_adapter]
  from: ad_impressions_ad
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Ad"
  view_label: "Impressions by Ad"
}

view: ad_impressions_ad_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_ad_adapter]
}

explore: ad_impressions_geo_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_geo_adapter]
  from: ad_impressions_geo
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Geo"
  view_label: "Impressions by Geo"
}

view: ad_impressions_geo_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_geo_adapter]

  measure: average_click_rate {
    link: {
      label: "By Keyword"
      url: "/explore/marketing_analytics/ad_impressions?fields=keyword.criteria,fact.average_click_rate&f[fact.date_date]=this quarter"
    }
    html:  {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_click_rate,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{geo_us_state.state._value | url_encode}}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %};;
  }
  measure: average_conversion_rate {
    html: {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_conversion_rate,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{ geo_us_state.state._value | url_encode }}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %} ;;
  }
  measure: average_cost_per_click {
    html:  {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_cost_per_click,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{geo_us_state.state._value | url_encode}}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %};;
  }
  measure: average_cost_per_conversion {
    drill_fields: [fact.date_date, campaign.name, fact.total_conversions]
    html:  {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_cost_per_conversion,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{geo_us_state.state._value | url_encode}}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %};;
  }
}

explore: ad_impressions_age_range_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_age_range_adapter]
  from: ad_impressions_age_range
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Age Range"
  view_label: "Impressions by Age Range"
}

view: ad_impressions_age_range_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_age_range_adapter]
}

explore: ad_impressions_gender_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_gender_adapter]
  from: ad_impressions_gender
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Gender"
  view_label: "Impressions by Gender"
}

view: ad_impressions_gender_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_gender_adapter]
}

explore: ad_impressions_audience_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_audience_adapter]
  from: ad_impressions_audience
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Audience"
  view_label: "Impressions by Audience"
}

view: ad_impressions_audience_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_audience_adapter]
}

explore: ad_impressions_parental_status_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_parental_status_adapter]
  from: ad_impressions_parental_status
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Parental Status"
  view_label: "Impressions by Parental Status"
}

view: ad_impressions_parental_status_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_parental_status_adapter]
}

explore: ad_impressions_video_template {
  persist_with: adwords_etl_datagroup
  extension: required
  extends: [ad_impressions_video_adapter]
  from: ad_impressions_video
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Video"
  view_label: "Impressions by Video"
}

view: ad_impressions_video_template {
  extension: required
  extends: [ad_impressions_base, ad_impressions_video_adapter]
}
