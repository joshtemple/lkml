view: shows_combined {
  sql_table_name: dean_looker_phish_thesis.shows_combined ;;

  dimension: show_number {
    view_label: "Phish.net Shows"
    type: number
    sql: ${TABLE}.show_number ;;
    value_format_name: id
  }

# from phish.net #

  dimension: phishnet_link {
    view_label: "Phish.net Shows"
    label: "Phish.net Link"
    description: "Link to the official show page on Phish.net"
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: location {
    view_label: "Phish.net Shows"
    description: "City, State, [Country] where the show was played"
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: setlistnotes {
    view_label: "Phish.net Shows"
    label: "Setlist Notes"
    description: "Full setlist notes from Phish.net"
    type: string
    sql: ${TABLE}.setlistnotes ;;
  }

  dimension_group: show {
    view_label: "Phish.net Shows"
    type: time
    timeframes: [
      date,
      day_of_month,
      day_of_week,
      day_of_week_index,
      day_of_year,
      month,
      month_name,
      month_num,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${showdate} ;;
  }

  dimension: showdate {
    view_label: "Phish.net Shows"
    type: date
    datatype: date
    sql: ${TABLE}.showdate ;;
    link: {
      label: "🎧 Listen to this show"
      url: "http://phish.in/{{value}}"
    }
    link: {
      label: "🎫 Show Dashboard"
      url: "/dashboards/465?Show%20Date={{value}}"
    }
  }

  dimension: showid {
    view_label: "Phish.net Shows"
    type: number
    # hidden: yes
    sql: ${TABLE}.showid ;;
  }

  dimension: tour_when {
    view_label: "Phish.net Shows"
    type: string
    sql: ${TABLE}.tour_when ;;
  }

  dimension: tourid {
    view_label: "Phish.net Shows"
    type: number
    value_format_name: id
    sql: ${TABLE}.tourid ;;
  }

  dimension: tourname {
    view_label: "Phish.net Shows"
    type: string
    sql: ${TABLE}.tourname ;;
    link: {
      label: "🚌 Tour Dashboard"
      url: "/dashboards/465?Show%20Date={{value}}"
    }
  }

  dimension: venue {
    view_label: "Phish.net Shows"
    type: string
    sql: ${TABLE}.venue ;;
  }

  dimension: venueid {
    view_label: "Phish.net Shows"
    type: number
    value_format_name: id
    sql: ${TABLE}.venueid ;;
  }



  measure: count {
    view_label: "Phish.net Shows"
    type: count
    drill_fields: [tourname, showdate, show_month, show_year, location, venue]
  }

  # dimension: artistid {
  #   view_label: "Phish.net Shows"
  #   hidden: yes
  #   type: number
  #   value_format_name: id
  #   sql: ${TABLE}.artistid ;;
  # }

  # dimension: artistlink {
  #   view_label: "Phish.net Shows"
  #   hidden:  yes
  #   type: string
  #   sql: ${TABLE}.artistlink ;;
  # }

  # dimension: billed_as {
  #   view_label: "Phish.net Shows"
  #   hidden:  yes
  #   type: string
  #   sql: ${TABLE}.billed_as ;;
  # }




  # from phish.in #

  dimension: id {
    view_label: "Phish.in Shows"
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: date {
    hidden: yes
    view_label: "Phish.in Shows"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: duration_seconds {
    view_label: "Phish.in Shows"
    hidden: yes
    type: number
    label: "Duration Seconds"
    sql: cast((${TABLE}.duration/1000)AS INT64) ;;
  }



  measure: show_duration_max {
    label: "Show Duration Measure"
    description: "Duration of show"
    type: max
    sql: ${duration_seconds}/86400 ;;
    value_format: "h:mm:ss"
  }

  dimension: is_incomplete {
    view_label: "Phish.in Shows"
    label: "Incomplete"
    description: "Shows whether or not the audio for the show is incomplete"
    type: yesno
    sql: ${TABLE}.incomplete ;;
  }

  dimension: is_sbd {
    view_label: "Phish.in Shows"
    label: "SBD"
    description: "Shows whether or not the audio for the show is a soundboard recording"
    type: yesno
    sql: ${TABLE}.sbd ;;
  }

  dimension: is_rmstr {
    view_label: "Phish.in Shows"
    label: "Remastered"
    description: "Shows whether or not the audio for the show has been remastered"
    type: yesno
    sql: ${TABLE}.remastered ;;
  }


  dimension: tour_id {
    hidden:  yes
    view_label: "Phish.in Shows"
    type: number
    sql: ${TABLE}.tour_id ;;
  }

  dimension: venue_name {
    hidden:  yes
    view_label: "Phish.in Shows"
    type: string
    sql: ${TABLE}.venue_name ;;
  }

  dimension: taper_notes {
    hidden: yes
    view_label: "Phish.in Shows"
    type: string
    sql: ${TABLE}.taper_notes ;;
  }

  # dimension: likes_count {
  #   view_label: "Phish.in Shows"
  #   type: number
  #   sql: ${TABLE}.likes_count ;;
  # }

  # dimension_group: updated_at {
  #   view_label: "Phish.in Shows"
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   convert_tz: no
  #   datatype: timestamp
  #   sql: ${TABLE}.updated_at ;;
  # }

}
