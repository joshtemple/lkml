connection: "mybqtets"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: git_sme_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

#change

#editing my Model file in GITHUB UI
#
#det
#est

#adding lines for a merge
#new line


#testing merge

persist_with: git_sme_project_default_datagroup



explore: github_nested_copy {
  join: github_nested_copy__actor_attributes {
    view_label: "Github Nested Copy: Actor Attributes"
    sql: LEFT JOIN UNNEST([${github_nested_copy.actor_attributes}]) as github_nested_copy__actor_attributes ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload {
    view_label: "Github Nested Copy: Payload"
    sql: LEFT JOIN UNNEST([${github_nested_copy.payload}]) as github_nested_copy__payload ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pages {
    view_label: "Github Nested Copy: Payload Pages"
    sql: LEFT JOIN UNNEST(${github_nested_copy__payload.pages}) as github_nested_copy__payload__pages ;;
    relationship: one_to_many
  }

  join: github_nested_copy__payload__member {
    view_label: "Github Nested Copy: Payload Member"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload.member}]) as github_nested_copy__payload__member ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request {
    view_label: "Github Nested Copy: Payload Pull Request"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload.pull_request}]) as github_nested_copy__payload__pull_request ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request___links__comments {
    view_label: "Github Nested Copy: Payload Pull Request Links Comments"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request___links.comments}]) as github_nested_copy__payload__pull_request___links__comments ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request___links__self {
    view_label: "Github Nested Copy: Payload Pull Request Links Self"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request___links.self}]) as github_nested_copy__payload__pull_request___links__self ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request___links__review_comments {
    view_label: "Github Nested Copy: Payload Pull Request Links Review Comments"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request___links.review_comments}]) as github_nested_copy__payload__pull_request___links__review_comments ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request___links__html {
    view_label: "Github Nested Copy: Payload Pull Request Links Html"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request___links.html}]) as github_nested_copy__payload__pull_request___links__html ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__merged_by {
    view_label: "Github Nested Copy: Payload Pull Request Merged By"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request.merged_by}]) as github_nested_copy__payload__pull_request__merged_by ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__head {
    view_label: "Github Nested Copy: Payload Pull Request Head"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request.head}]) as github_nested_copy__payload__pull_request__head ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__head__repo {
    view_label: "Github Nested Copy: Payload Pull Request Head Repo"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request__head.repo}]) as github_nested_copy__payload__pull_request__head__repo ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__head__repo__owner {
    view_label: "Github Nested Copy: Payload Pull Request Head Repo Owner"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request__head__repo.owner}]) as github_nested_copy__payload__pull_request__head__repo__owner ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__head__user {
    view_label: "Github Nested Copy: Payload Pull Request Head User"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request__head.user}]) as github_nested_copy__payload__pull_request__head__user ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__user {
    view_label: "Github Nested Copy: Payload Pull Request User"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request.user}]) as github_nested_copy__payload__pull_request__user ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__base {
    view_label: "Github Nested Copy: Payload Pull Request Base"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request.base}]) as github_nested_copy__payload__pull_request__base ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__base__repo {
    view_label: "Github Nested Copy: Payload Pull Request Base Repo"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request__base.repo}]) as github_nested_copy__payload__pull_request__base__repo ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__base__repo__owner {
    view_label: "Github Nested Copy: Payload Pull Request Base Repo Owner"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request__base__repo.owner}]) as github_nested_copy__payload__pull_request__base__repo__owner ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request__base__user {
    view_label: "Github Nested Copy: Payload Pull Request Base User"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request__base.user}]) as github_nested_copy__payload__pull_request__base__user ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__target {
    view_label: "Github Nested Copy: Payload Target"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload.target}]) as github_nested_copy__payload__target ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__shas {
    view_label: "Github Nested Copy: Payload Shas"
    sql: LEFT JOIN UNNEST(${github_nested_copy__payload.shas}) as github_nested_copy__payload__shas ;;
    relationship: one_to_many
  }

  join: github_nested_copy__payload__comment {
    view_label: "Github Nested Copy: Payload Comment"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload.comment}]) as github_nested_copy__payload__comment ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__comment__user {
    view_label: "Github Nested Copy: Payload Comment User"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__comment.user}]) as github_nested_copy__payload__comment__user ;;
    relationship: one_to_one
  }

  join: github_nested_copy__repository {
    view_label: "Github Nested Copy: Repository"
    sql: LEFT JOIN UNNEST([${github_nested_copy.repository}]) as github_nested_copy__repository ;;
    relationship: one_to_one
  }

  join: github_nested_copy__payload__pull_request___links {
    view_label: "Github Nested Copy: Payload Pull Request Links"
    sql: LEFT JOIN UNNEST([${github_nested_copy__payload__pull_request._links}]) as github_nested_copy__payload__pull_request___links ;;
    relationship: one_to_one
  }
}

explore: municipal_sf_requests {}

explore: neighborhood_pd {}

explore: neighborhood_zip {}

explore: sffd_service_calls {}

explore: sfpd_incidents {}

explore: zipcode_neighborhood_grp {}
