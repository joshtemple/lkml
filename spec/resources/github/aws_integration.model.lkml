connection: "athena_db_j"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: cpu_usage {
  label: "EC2 Instances"
  view_label: "instances"
  join: instances {
    view_label: "instances"
    sql_on: ${cpu_usage.instance_id} = ${instances.id} ;;
    relationship: many_to_one
  }

  join: bytes_read_in {
    view_label: "instances"
    type: left_outer
    sql_on: ${instances.id} = ${bytes_read_in.instance_id} ;;
    relationship: one_to_many
  }

  join: incoming_bytes {
    view_label: "instances"
    type: left_outer
    sql_on: ${instances.id} = ${incoming_bytes.instance_id} ;;
    relationship: one_to_many
  }

  join: outgoing_bytes {
    view_label: "instances"
    type: left_outer
    sql_on: ${instances.id} = ${outgoing_bytes.instance_id} ;;
    relationship: one_to_many
  }

  join: packets_in {
    view_label: "instances"
    type: left_outer
    sql_on: ${instances.id} = ${packets_in.instance_id} ;;
    relationship: one_to_many
  }

  join: packets_out {
    view_label: "instances"
    type: left_outer
    sql_on: ${instances.id} = ${packets_out.instance_id} ;;
    relationship: one_to_many
  }

  join: remaining_cpu_credit {
    view_label: "instances"
    type: left_outer
    sql_on: ${instances.id} = ${remaining_cpu_credit.instance_id} ;;
    relationship: one_to_many
  }
}
