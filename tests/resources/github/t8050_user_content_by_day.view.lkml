view: t8050_user_content_by_day {
  sql_table_name: public.t8050_user_content_by_day ;;

  dimension: ads {
    # view_label: "User"
    type: string
    sql: ${TABLE}.c8050_ads ;;
  }

  dimension: view_type {
    description: "PAGEVIEW or VIDEOVIEW"
    alias: [action]
    type: string
    sql: ${TABLE}.c8050_action ;;
  }

#  dimension: content_type {
#    type: string
  #   hidden: yes
#    sql: ${TABLE}.c80505_action ;;

#    case: {
#      when: {
#        sql: (${TABLE}.c8050_cid is null) or (${TABLE}.c8050_cid = 0)  ;;
#        label: "HOME-INDEX"
#      }

#      when: {
#        sql: (${TABLE}.c8050_action = 'PAGEVIEW') and (${TABLE}.c8050_cid is not null)  ;;
#        label: "ARTICLE"
#      }

#      when: {
#        sql: (${TABLE}.c8050_action = 'VIDEOVIEW') and (${TABLE}.c8050_cid is not null) ;;
#        label: "VIDEO"
#      }

#      when: {
#        sql: true ;;
#        label: "unknown"
#      }
#    }
#  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.c8050_app_version ;;
  }

  dimension: auto {
    type: string
    sql: ${TABLE}.c8050_auto ;;
  }

dimension: category {
  type: string
  sql: ${TABLE}.c8050_category ;;
}

dimension: channel {
  type: string
  sql: ${TABLE}.c8050_channel ;;
}

dimension: content_id {
  type: string
  sql: ${TABLE}.c8050_cid ;;
}

dimension: content_type {
  type: string
  sql: ${TABLE}.C8050_CONTENT ;;
}

dimension_group: view {
  group_label: "View Date"
  type: time
  timeframes: [
    raw,
    date,
    day_of_week,
    day_of_week_index,
    week,
    month,
    quarter,
    year
  ]
  convert_tz: no
  sql: ${TABLE}.c8050_datetime ;;
}

dimension: view_date_d {
  group_label: "View Date"
  sql: TO_DATE(${TABLE}.c8050_datetime) ;;
}


dimension: view_weekday {
  sql:
  CASE
     when ${view_day_of_week_index} = 6 then 'Weekend'
     when ${view_day_of_week_index} = 0 then 'Weekday'
     when ${view_day_of_week_index} = 1 then 'Weekday'
     when ${view_day_of_week_index} = 2 then 'Weekday'
     when ${view_day_of_week_index} = 3 then 'Weekday'
     when ${view_day_of_week_index} = 4 then 'Weekday'
     when ${view_day_of_week_index} = 5 then 'Weekend'
  END ;;
}

filter: filter_view_date {
  label: "View Date"
  type:date
}

dimension: news {
  type: string
  sql: ${TABLE}.c8050_news ;;
}

dimension: nxtuid {
  type: string
  sql: ${TABLE}.c8050_nxtu_or_did ;;
}

dimension: platform {
  type: string
  sql: ${TABLE}.c8050_platform ;;
}

dimension: product {
  type: string
  sql: ${TABLE}.c8050_product ;;
}

dimension: region {
  type: string
  sql: ${TABLE}.c8050_region ;;
}

dimension: section {
  type: string
  sql: ${TABLE}.c8050_section ;;
}

dimension: source {
  type: string
  sql: ${TABLE}.c8050_source ;;
}

dimension: subsection {
  type: string
  sql: ${TABLE}.c8050_subsection ;;
}



########## measures #############

measure: count {
  type: count
#    approximate: yes
  drill_fields: []
}


  dimension: c8050_total_video_views {
    hidden: yes
    type: number
    sql: ${TABLE}.c8050_total_video_views ;;
  }

  dimension: c8050_average_video_duration {
    alias: [c8050_average_duration]
    hidden: yes
    type: number
    sql: ${TABLE}.c8050_average_video_duration ;;
  }

  measure: total_video_views {
    alias: [sum_video_views]
#  hidden: yes
    type: sum
    value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${c8050_total_video_views} ;;
  }

  measure: sum_video_duration {
    hidden: yes
    type: sum
    sql: ${c8050_average_video_duration} * ${c8050_total_video_views} ;;
    filters: {
      field: view_type
      value: "VIDEOVIEW"
    }
  }

  measure: average_video_duration {
    alias: [average_duration,weighted_avg_video_duration]
    type: number
    value_format: "#,##0.00"
    sql: ${sum_video_duration} / nullif(${total_video_views},0) ;;
  }

  dimension: c8050_total_page_views {
    hidden: yes
    type: number
    sql: ${TABLE}.c8050_total_page_views ;;
  }

  dimension: c8050_average_page_duration {
    hidden: yes
    type: number
    sql: ${TABLE}.c8050_average_page_duration ;;
  }

  measure: total_page_views {
    alias: [suml_page_views]
#  hidden: yes
    type: sum
    value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
    sql: ${c8050_total_page_views} ;;

  }
  measure: sum_page_duration {
    hidden: yes
    type: sum
    sql: ${c8050_average_page_duration} * ${c8050_total_page_views} ;;
    filters: {
      field: view_type
      value: "PAGEVIEW"
    }
  }

  measure: average_page_duration {
    alias: [weighted_avg_page_duration]
    type: number
    value_format: "#,##0.00"
    sql: ${sum_page_duration} / nullif(${total_page_views},0) ;;
  }

  measure: distinct_users {
    #    view_label: User
    type: count_distinct
    sql: ${nxtuid} ;;
#    approximate: yes
  }

  measure: distinct_content {
    #    view_label: Content
    type: count_distinct
    sql: ${content_id} ;;
#    approximate: yes
  }

}
