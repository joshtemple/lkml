view: outreach_templates {
  sql_table_name: prod.outreach_templates ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: attributes {
    hidden: yes
    sql: ${TABLE}.Attributes ;;
  }

  dimension: links {
    hidden: yes
    sql: ${TABLE}.Links ;;
  }

  dimension: relationships {
    hidden: yes
    sql: ${TABLE}.Relationships ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  dimension: archived {
    type: yesno
    sql: ${TABLE}.Attributes.Archived ;;
  }

  dimension_group: archivedat {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Attributes.Archivedat ;;
  }

  dimension: bccrecipients {
    type: string
    sql: ${TABLE}.Attributes.Bccrecipients ;;
  }

  dimension: bodyhtml {
    type: string
    sql: ${TABLE}.Attributes.Bodyhtml ;;
  }

  dimension: bodytext {
    type: string
    sql: ${TABLE}.Attributes.Bodytext ;;
  }

  dimension: bouncecount {
    type: number
    sql: ${TABLE}.Attributes.Bouncecount ;;
  }

  dimension: ccrecipients {
    type: string
    sql: ${TABLE}.Attributes.Ccrecipients ;;
  }

  dimension: clickcount {
    type: number
    sql: ${TABLE}.Attributes.Clickcount ;;
  }

  dimension_group: createdat {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Attributes.Createdat ;;
  }

  dimension: delivercount {
    type: number
    sql: ${TABLE}.Attributes.Delivercount ;;
  }

  dimension: failurecount {
    type: number
    sql: ${TABLE}.Attributes.Failurecount ;;
  }

  dimension_group: lastusedat {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Attributes.Lastusedat ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.Attributes.Name ;;
  }

  dimension: negativereplycount {
    type: number
    sql: ${TABLE}.Attributes.Negativereplycount ;;
  }

  dimension: neutralreplycount {
    type: number
    sql: ${TABLE}.Attributes.Neutralreplycount ;;
  }

  dimension: opencount {
    type: number
    sql: ${TABLE}.Attributes.Opencount ;;
  }

  dimension: optoutcount {
    type: number
    sql: ${TABLE}.Attributes.Optoutcount ;;
  }

  dimension: positivereplycount {
    type: number
    sql: ${TABLE}.Attributes.Positivereplycount ;;
  }

  dimension: replycount {
    type: number
    sql: ${TABLE}.Attributes.Replycount ;;
  }

  dimension: schedulecount {
    type: number
    sql: ${TABLE}.Attributes.Schedulecount ;;
  }

  dimension: sharetype {
    type: string
    sql: ${TABLE}.Attributes.Sharetype ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.Attributes.Subject ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.Attributes.Tags ;;
  }

  dimension: torecipients {
    type: string
    sql: ${TABLE}.Attributes.Torecipients ;;
  }

  dimension: tracklinks {
    type: yesno
    sql: ${TABLE}.Attributes.Tracklinks ;;
  }

  dimension: trackopens {
    type: yesno
    sql: ${TABLE}.Trackopens ;;
  }

  dimension_group: updatedat {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Attributes.Updatedat ;;
  }
}


view: outreach_templates__links {
  dimension: self {
    type: string
    sql: ${TABLE}.Self ;;
  }
}

view: outreach_templates__relationships__owner {
  dimension: data {
    hidden: yes
    sql: ${TABLE}.Data ;;
  }
}

view: outreach_templates__relationships__updater {
  dimension: data {
    hidden: yes
    sql: ${TABLE}.Data ;;
  }
}

view: outreach_templates__relationships__creator {
  dimension: data {
    hidden: yes
    sql: ${TABLE}.Data ;;
  }
}

view: outreach_templates__relationships__sequencetemplates {
  dimension: data {
    hidden: yes
    sql: ${TABLE}.Data ;;
  }

  dimension: links {
    hidden: yes
    sql: ${TABLE}.Links ;;
  }

  dimension: meta {
    hidden: yes
    sql: ${TABLE}.Meta ;;
  }
}

view: outreach_templates__relationships {
  dimension: creator {
    hidden: yes
    sql: ${TABLE}.Creator ;;
  }

  dimension: owner {
    hidden: yes
    sql: ${TABLE}.Owner ;;
  }

  dimension: sequencetemplates {
    hidden: yes
    sql: ${TABLE}.Sequencetemplates ;;
  }

  dimension: updater {
    hidden: yes
    sql: ${TABLE}.Updater ;;
  }
}


view: outreach_templates__relationships__owner__data {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }
}

view: outreach_templates__relationships__updater__data {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }
}

view: outreach_templates__relationships__creator__data {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
  }
}

view: outreach_templates__relationships__sequencetemplates__meta {
  dimension: count {
    type: number
    sql: ${TABLE}.Count ;;
  }
}

view: outreach_templates__relationships__sequencetemplates__links {
  dimension: related {
    type: string
    sql: ${TABLE}.Related ;;
  }
}

view: outreach_templates__relationships__sequencetemplates__data {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
}
