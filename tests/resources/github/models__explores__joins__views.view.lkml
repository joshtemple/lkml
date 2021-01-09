view: models__explores__joins__views {
  view_label: "Joins"
  derived_table: {
    sql: SELECT
      A.GIT_OWNER::varchar AS GIT_OWNER,
      A.GIT_REPOSITORY::varchar AS GIT_REPOSITORY,
      A.MODEL_PATH::varchar AS MODEL_PATH,
      A.MODEL_NAME::varchar AS MODEL_NAME,
      A.MODEL_KEY::varchar AS MODEL_KEY,
      A.EXPLORE_NAME::varchar AS EXPLORE_NAME,
      A.EXPLORE_KEY::varchar AS EXPLORE_KEY,
      A.VIEW_NAME::varchar AS VIEW_NAME,
      A.VIEW_FROM::varchar AS VIEW_FROM,
      A.VIEW_LABEL::varchar AS VIEW_LABEL,
      A.JOIN_NAME::varchar AS JOIN_NAME,
      A.JOIN_JSON::variant AS JOIN_JSON,
      A.JOIN_INDEX::int AS JOIN_INDEX,
      A.JOIN_VIEW_TYPE::varchar AS JOIN_VIEW_TYPE,
      COALESCE(B.REQUIRED, 'no')::varchar AS JOIN_REQUIRED
      FROM
      (
      SELECT
        models.GIT_OWNER::varchar AS GIT_OWNER,
        models.GIT_REPOSITORY::varchar AS GIT_REPOSITORY,
        models.PATH::varchar  AS MODEL_PATH,
        SPLIT_PART(SPLIT_PART(models.path, '.', -3), '/', -1)::varchar as MODEL_NAME,
        COALESCE(ex.value:name, '')::varchar AS EXPLORE_NAME,
        COALESCE((j.value:"from"::varchar), (j.value:name::varchar), '')::varchar  AS VIEW_NAME,
        COALESCE(j.value:"from", '')::varchar AS VIEW_FROM,
        COALESCE(j.value:view_label, '')::varchar AS VIEW_LABEL,
        COALESCE(j.value:name, '')::varchar AS JOIN_NAME,
        j.value::variant AS JOIN_JSON,
        'JOINED VIEW' AS JOIN_VIEW_TYPE,
        j.index::int as JOIN_INDEX,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)::varchar AS MODEL_KEY,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH  || '-' || ex.value:name::varchar)::varchar AS EXPLORE_KEY
      FROM LOOKML.MODEL_FILES  AS model_files
      LEFT JOIN LOOKML.MODELS  AS models ON (model_files.GIT_OWNER || '-' || model_files.GIT_REPOSITORY || '-' || model_files.PATH) = (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)
      , lateral flatten(input => models.EXPLORES) ex
      , lateral flatten(input => ex.value:joins) j
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13, 14

      UNION

      -- BASE VIEWS
      SELECT
        models.GIT_OWNER::varchar AS GIT_OWNER,
        models.GIT_REPOSITORY::varchar AS GIT_REPOSITORY,
        models.PATH::varchar AS MODEL_PATH,
        SPLIT_PART(SPLIT_PART(models.path, '.', -3), '/', -1)::varchar as MODEL_NAME,
        COALESCE(ex.value:name, '')::varchar  AS EXPLORE_NAME,
        COALESCE ((ex.value:"from"::varchar), (ex.value:view_name::varchar), (ex.value:name::varchar), '')::varchar  AS VIEW_NAME,
        COALESCE(ex.value:"from", '')::varchar AS VIEW_FROM,
        COALESCE(ex.value:view_label, '')::varchar  AS VIEW_LABEL,
        ''::varchar AS JOIN_NAME,
        ''::variant AS JOIN_JSON,
        'BASE VIEW' AS JOIN_VIEW_TYPE,
        -1::int AS JOIN_INDEX,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)::varchar AS MODEL_KEY,
        (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH  || '-' || ex.value:name::varchar)::varchar AS EXPLORE_KEY
      FROM LOOKML.MODEL_FILES AS model_files
      LEFT JOIN LOOKML.MODELS AS models ON (model_files.GIT_OWNER || '-' || model_files.GIT_REPOSITORY || '-' || model_files.PATH) = (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)
      , lateral flatten(input => models.EXPLORES) ex
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13, 14
      ) A
      LEFT JOIN
      (
      SELECT
        models.GIT_OWNER::varchar AS GIT_OWNER,
        models.GIT_REPOSITORY::varchar AS GIT_REPOSITORY,
        models.PATH::varchar AS MODEL_PATH,
        COALESCE(ex.value:name, '')::varchar AS EXPLORE_NAME,
        COALESCE(jrj.value, '')::varchar AS VIEW_NAME,
        'yes' AS REQUIRED
      FROM LOOKML.MODEL_FILES AS model_files
      LEFT JOIN LOOKML.MODELS AS models
      ON (model_files.GIT_OWNER || '-' || model_files.GIT_REPOSITORY || '-' || model_files.PATH) = (models.GIT_OWNER || '-' || models.GIT_REPOSITORY || '-' || models.PATH)
      , lateral flatten(input => models.EXPLORES) ex
      , lateral flatten(input => ex.value:joins) j
      , lateral flatten(input => j.value:required_joins) jrj
      GROUP BY 1,2,3,4,5,6
      ) B
      ON A.GIT_OWNER = B.GIT_OWNER
      AND A.GIT_REPOSITORY = B.GIT_REPOSITORY
      AND A.MODEL_PATH = B.MODEL_PATH
      AND A.EXPLORE_NAME = B.EXPLORE_NAME
      AND A.VIEW_NAME = B.VIEW_NAME
       ;;
  }

  dimension: explore_join_view_pk {
    group_label: "Keys/IDs"
    label: "Explore Join View PK"
    type: string
    primary_key: yes
    hidden: yes
    sql: ${join_key} || '-' || ${view_name} ;;
  }

  dimension: git_owner {
    group_label: "Keys/IDs"
    label: "Git Owner"
    type: string
    sql: ${TABLE}.GIT_OWNER ;;
  }

  dimension: git_repository {
    group_label: "Keys/IDs"
    type: string
    sql: ${TABLE}.GIT_REPOSITORY ;;
  }

  dimension: model_key {
    group_label: "Keys/IDs"
    label: "Model Key"
    type: string
    sql: ${TABLE}.MODEL_KEY ;;
  }

  dimension: model_name {
    group_label: "Keys/IDs"
    label: "Model Name"
    type: string
    sql: ${TABLE}.MODEL_NAME ;;
  }

  dimension: model_path {
    group_label: "Keys/IDs"
    label: "Model Path"
    type: string
    sql: ${TABLE}.MODEL_PATH ;;
  }

  dimension: explore_id {
    group_label: "Keys/IDs"
    label: "Explore ID"
    type: string
    sql: ${model_name} || '::' || ${explore_name}  ;;
  }

  dimension: explore_key {
    group_label: "Keys/IDs"
    label: "Explore Key"
    type: string
    sql: ${TABLE}.EXPLORE_KEY  ;;
  }

  dimension: explore_name {
    group_label: "Keys/IDs"
    label: "Explore Name"
    type: string
    sql: ${TABLE}.EXPLORE_NAME ;;
  }

  dimension: join_key {
    group_label: "Keys/IDs"
    label: "Join Key"
    type: string
    sql: CASE WHEN ${join_name} IS NOT NULL THEN ${explore_key} || '-' || ${join_name}
          ELSE NULL END ;;
  }

  dimension: view_key {
    group_label: "Keys/IDs"
    label: "View Key"
    type: string
    sql: ${git_owner} || '-' || ${git_repository} || '-' || ${view_name} ;;
  }

  dimension: join_index {
    label: "Join Index"
    type: number
    value_format_name: id
    sql: ${TABLE}.JOIN_INDEX + 1 ;;
  }

  dimension: join_json {
    label: "Join JSON"
    type: string
    sql: ${TABLE}.JOIN_JSON ;;
    hidden: yes
  }

  dimension: join_name {
    label: "Join Name"
    type: string
    sql: ${TABLE}.JOIN_NAME ;;
  }

  dimension: join_required {
    label: "Join Required"
    type: string
    sql: ${TABLE}.JOIN_REQUIRED ;;
  }

  dimension: is_join_required {
    label: "Is Join Required"
    type: string
    sql: ${TABLE}.JOIN_REQUIRED = 'yes' ;;
  }

  dimension: join_view_type {
    label: "Join View Type"
    type: string
    sql: ${TABLE}.JOIN_VIEW_TYPE ;;
  }

  dimension: fields {
    group_label: "Fields"
    label: "Fields JSON"
    type: string
    sql: ${join_json}:fields::variant ;;
    hidden: yes
  }

  dimension: fields_list {
    group_label: "Fields"
    label: "Fields List"
    type: string
    sql:array_to_string(parse_json(${fields}), ', ') ;;
  }

  dimension: foreign_key {
    label: "Foreign Key"
    type: string
    sql: ${join_json}:foreign_key::varchar ;;
  }

  dimension: from {
    label: "From"
    type: string
    sql: ${join_json}:"from"::varchar ;;
  }

  dimension: join_view_name {
    label: "Join View Name"
    type: string
    sql: COALESCE(${from}, ${name}) ;;
  }

  dimension: name {
    label: "Join Name"
    type: string
    sql: ${join_json}:name::varchar ;;
    hidden: yes
  }

  dimension: outer_only {
    label: "Outer Only"
    type: string
    sql: ${join_json}:outer_only::varchar ;;
  }

  dimension: outer_only_yn {
    group_label: "YesNo"
    label: "Outer Only"
    type: string
    sql: ${outer_only} = 'yes' ;;
  }

  dimension: relationship {
    label: "Relationship"
    type: string
    sql: ${join_json}:relationship::varchar ;;
  }

  dimension: required_access_grants {
    group_label: "Required Access Grants"
    label: "Required Access Grants JSON"
    type: string
    sql: ${join_json}:required_access_grants::variant ;;
    hidden: yes
  }

  dimension: required_access_grants_list {
    group_label: "Required Access Grants"
    label: "Required Access Grants List"
    type: string
    sql:array_to_string(parse_json(${required_access_grants}), ', ') ;;
  }

  dimension: required_joins {
    group_label: "Required Joins"
    label: "Required Joins"
    type: string
    sql: ${join_json}:required_joins::variant ;;
    hidden: yes
  }

  dimension: required_joins_list {
    group_label: "Required Joins"
    label: "Required Joins List"
    type: string
    sql:array_to_string(parse_json(${required_joins}), ', ') ;;
  }

  dimension: sql {
    group_label: "SQL"
    label: "SQL"
    type: string
    sql: ${join_json}:"sql"::varchar ;;
  }

  dimension: sql_foreign_key {
    group_label: "SQL"
    label: "SQL Foreign Key"
    type: string
    sql: ${join_json}:sql_foreign_key::varchar ;;
  }

  dimension: sql_on {
    group_label: "SQL"
    label: "SQL On"
    type: string
    sql: ${join_json}:sql_on::varchar ;;
  }

  dimension: sql_table_name {
    group_label: "SQL"
    label: "SQL Table Name"
    type: string
    sql: ${join_json}:sql_table_name::varchar ;;
  }

  dimension: sql_where {
    group_label: "SQL"
    label: "SQL Where"
    type: string
    sql: ${join_json}:sql_where::varchar ;;
  }

  # Currently only works for the first join relation
  dimension: sql_combined {
    group_label: "SQL"
    label: "SQL Combined"
    type: string
    sql: COALESCE(${sql_on}, ${sql_where}, ${sql}) ;;
    hidden: yes
  }

  dimension: sql_on_source_view {
    group_label: "SQL"
    label: "SQL On Source View"
    type: string
    sql: REGEXP_SUBSTR(${sql_combined}, '\\$\{([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)\}', 1, 1, 'e', 1) ;;
  }

  dimension: sql_on_source_field {
    group_label: "SQL"
    label: "SQL On Source Field"
    type: string
    sql: REGEXP_SUBSTR(${sql_combined}, '\\$\{([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)\}', 1, 1, 'e', 2) ;;
  }

  dimension: sql_on_target_view {
    group_label: "SQL"
    label: "SQL On Target View"
    type: string
    sql: REGEXP_SUBSTR(${sql_combined}, '\\$\{([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)\}', 1, 2, 'e', 1) ;;
  }

  dimension: sql_on_target_field {
    group_label: "SQL"
    label: "SQL On Target Field"
    type: string
    sql: REGEXP_SUBSTR(${sql_combined}, '\\$\{([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)\}', 1, 2, 'e', 2) ;;
  }

  dimension: type {
    label: "Type"
    type: string
    sql: ${join_json}:type::varchar ;;
  }

  dimension: view_alias_name {
    label: "View Alias Name"
    type: string
    sql: CASE WHEN ${view_from} IS NOT NULL THEN COALESCE(${join_name}, ${explore_name}, ${view_name})::varchar
          ELSE ${view_name}::varchar END;;
  }

  dimension: view_from {
    label: "View From"
    type: string
    sql: ${TABLE}.VIEW_FROM ;;
  }

  dimension: view_label {
    label: "View Label"
    type: string
    sql: ${TABLE}.VIEW_LABEL ;;
  }

  dimension: view_name {
    label: "View Name"
    type: string
    sql: ${TABLE}.VIEW_NAME ;;
  }

  measure: count {
    label: "Number of Joins"
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      git_owner,
      git_repository,
      model_path,
      model_files.model_name,
      explore_name,
      join_name,
      view_name,
      join_view_type,
      join_required,
      type,
      from,
      relationship,
      view_label,
      foreign_key,
      sql_table_name,
      sql_on,
      sql_foreign_key,
      sql_where
    ]
  }

}
