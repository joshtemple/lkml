connection: "thelook_events_redshift"

view: team_base_extended {
  extends: [team_base,team_feature_usage]
  dimension:view_label_placeholder  {sql:test label;;}
}

explore: team {
  # from:  team_base
  from: team_base_extended
  view_name: team
  group_label: "Users & Teams"
  label: "Teams (Current)"
  view_label: "(1) Team"
  sql_always_where: "DAY" = '2019-03-23' ;;

}


view: team_base {
  sql_table_name: USER360.TEAM_ATTRIBUTE_CSV ;;

## CORE TEAM ATTRIBUTES

  dimension: team_id {
    view_label: "{{_view._name}}"
    description: "ID of the Dropbox Team"
    type: string
    sql: ${TABLE}."TEAM_ID" ;;
  }
}

# include: "team_base.view
view: team_feature_usage {
  # dimension: view_label_placeholder {
  #   hidden:yes
  #   sql:placeholder;;
  # }
  # view_label: "(2) Team - Feature Usage"

  dimension: showcase_enabled_policy {
    view_label: "{{view_label_placeholder._sql}}"
    type: yesno
    sql: ${TABLE}."SHOWCASE_ENABLED_POLICY" = "1" ;;
  }

  dimension: showcase_external_sharing_policy {
    view_label: "{{view_label_placeholder._sql}}"
    type: yesno
    sql: ${TABLE}."SHOWCASE_EXTERNAL_SHARING_POLICY" = "1" ;;
  }

  dimension: smart_sync_enabled {
    type: yesno
    sql: ${TABLE}."SMART_SYNC_ENABLED" = "1" ;;
  }

  dimension: sso_policy {
    label: "SSO Policy"
    description: "0, 1, 2"
    type: string
    sql: ${TABLE}."SSO_POLICY" ;;
  }

}
