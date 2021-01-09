view: connect__1__mention {
  sql_table_name: wwi_raw_data.connect__1__Mention ;;

  dimension: headers {
    hidden: yes
    sql: ${TABLE}.headers ;;
  }

  dimension: partitions {
    hidden: yes
    sql: ${TABLE}.partitions ;;
  }

  dimension: payload {
    hidden: yes
    sql: ${TABLE}.payload ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: connect__1__Mention__partitions {
  dimension: day {
    type: string
    sql: ${TABLE}.day ;;
  }

  dimension: hour {
    type: string
    sql: ${TABLE}.hour ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }
}

view: connect__1__Mention__headers {
  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: message_id {
    type: string
    sql: ${TABLE}.messageId ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }
}

view: connect__1__Mention__payload__mention__mentionable__post {
  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }

  dimension: media {
    type: string
    sql: ${TABLE}.media ;;
  }

  dimension: subclass {
    type: string
    sql: ${TABLE}.subclass ;;
  }

  dimension: user {
    hidden: yes
    sql: ${TABLE}.user ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }
}

view: connect__1__Mention__payload__mention__mentionable__post__user {
  dimension: locale {
    type: string
    sql: ${TABLE}.locale ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }
}

view: connect__1__Mention__payload__mention__mentionable {
  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: content {
    type: string
    sql: ${TABLE}.content ;;
  }

  dimension: media {
    type: string
    sql: ${TABLE}.media ;;
  }

  dimension: post {
    hidden: yes
    sql: ${TABLE}.post ;;
  }

  dimension: subclass {
    type: string
    sql: ${TABLE}.subclass ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: user {
    hidden: yes
    sql: ${TABLE}.user ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }
}

view: connect__1__Mention__payload__mention__mentionable__user {
  dimension: locale {
    type: string
    sql: ${TABLE}.locale ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }
}

view: connect__1__Mention__payload__mention__user {
  dimension: locale {
    type: string
    sql: ${TABLE}.locale ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }
}

view: connect__1__Mention__payload__mention {
  dimension: mentionable {
    hidden: yes
    sql: ${TABLE}.mentionable ;;
  }

  dimension: user {
    hidden: yes
    sql: ${TABLE}.user ;;
  }
}

view: connect__1__Mention__payload {
  dimension: mention {
    hidden: yes
    sql: ${TABLE}.mention ;;
  }
}
