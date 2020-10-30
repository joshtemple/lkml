connection: "snowflake_production"

# Only reference Snowflake views
include: "snowflake_github*.z.view.lkml"
include: "snowflake_sfdc_github*.z.view.lkml"
# View includes a Snowflake version, which leverages the connection specified above.
include: "sf__accounts.view.lkml"         # include all views in this project"
include: "sf__contacts.view.lkml"         # include all views in this project"
include: "sf__users.view.lkml"         # include all views in this project"

label: "Github GraphQL Normalized"
fiscal_month_offset: -11 # Map to fiscal quarters starting in Feb plus +1 year


explore: snowflake_sfdc_github_tracked_issues {
  label: "SFDC-GH Tracker"
  view_label: "Github Issues"
  join: snowflake_sfdc_github_tracked_comments {
    view_label: "Github Comments"
    sql_on: ${snowflake_sfdc_github_tracked_issues.github_issue_url} =  ${snowflake_sfdc_github_tracked_comments.issue_url};;
    relationship: one_to_many
  }
}

explore: snowflake_github_normalized_trends{}

explore: snowflake_github_graphql_normalized_issues {
  label: "Github Issues"
  view_label: "Github Issues"
    join: snowflake_github_graphql_normalized_assignees {
      view_label: "Github Assignees"
      relationship: one_to_many
      sql_on: ${snowflake_github_graphql_normalized_assignees.github_object_url} = ${snowflake_github_graphql_normalized_issues.url}  ;;

    }
  join: snowflake_github_graphql_normalized_labels  {
      view_label: "Labels"
      relationship: one_to_many
      sql_on: ${snowflake_github_graphql_normalized_labels.github_object_url} = ${snowflake_github_graphql_normalized_issues.url}  ;;
    }

  join: snowflake_github_graphql_normalized_projectcards {
    view_label: "Github Project Cards"
    relationship: one_to_many
    sql_on:${snowflake_github_graphql_normalized_projectcards.issue_url} = ${snowflake_github_graphql_normalized_issues.url}   ;;
  }

  join: snowflake_github_graphql_normalized_projects {
    view_label: "Github Projects"
    relationship: one_to_one
    sql_on: ${snowflake_github_graphql_normalized_projectcards.project_url} = ${snowflake_github_graphql_normalized_projects.url}   ;;
  }
  join: referenced_by {
    view_label: "Referenced By"
    from: snowflake_github_graphql_normalized_crossreferences
    relationship: one_to_many
    sql_on: ${snowflake_github_graphql_normalized_issues.url} = ${referenced_by.target_url} ;;
  }
  join: references {
    view_label: "References"
    from: snowflake_github_graphql_normalized_crossreferences
    relationship: one_to_many
    sql_on: ${snowflake_github_graphql_normalized_issues.url} = ${referenced_by.source_url} ;;
  }

  join: snowflake_github_graphql_normalized_milestones  {
    sql_on: ${snowflake_github_graphql_normalized_milestones.url} = ${snowflake_github_graphql_normalized_issues.milestone_url}  ;;
    relationship: many_to_one
  }

}



explore: snowflake_github_graphql_normalized_pullrequests {
  label: "Github Pull Requests"
  view_label: "Pull Requests"
  join: snowflake_github_graphql_normalized_assignees {
    relationship: one_to_many
    sql_on: ${snowflake_github_graphql_normalized_assignees.github_object_url} = ${snowflake_github_graphql_normalized_pullrequests.url}  ;;

  }
  join: snowflake_github_graphql_normalized_labels  {
    relationship: one_to_many
    sql_on: ${snowflake_github_graphql_normalized_labels.github_object_url} = ${snowflake_github_graphql_normalized_pullrequests.url}  ;;
  }

  join: referenced_by {
    from: snowflake_github_graphql_normalized_crossreferences
    relationship: one_to_many
    sql_on: ${snowflake_github_graphql_normalized_pullrequests.url} = ${referenced_by.target_url} ;;
  }
  join: references {
    from: snowflake_github_graphql_normalized_crossreferences
    relationship: one_to_many
    sql_on: ${snowflake_github_graphql_normalized_pullrequests.url} = ${referenced_by.source_url} ;;
  }

  # TO DO: Add projects and project cards to ETL + this explore
}

explore: snowflake_github_graphql_normalized_milestones{
  label: "Github Milestones"
  view_label: "Github Milestones"
}

explore: snowflake_github_graphql_normalized_releases{
  label: "Github Releases"
  view_label: "Github Releases"
}

## Feature Requests (VoC)
explore: crossreferences {
from: snowflake_github_graphql_normalized_crossreferences
  label:  "Feature Requests"
  #fields: [github_graphql_crossrefs*,customer_issues*, referenced_in_issue*, feature_popularity*, sfdc_account*]
  join: customer_issues {
    from: snowflake_github_graphql_normalized_issues
    view_label: "Customer"
    relationship: many_to_one
    sql_on: ${customer_issues.url} = ${crossreferences.target_url} ;;
  }

  join: referenced_in_issue {
    view_label: "Feature Issue"
    from: snowflake_github_graphql_normalized_issues
    relationship: one_to_many
    sql_on: ${referenced_in_issue.url} = ${crossreferences.source_url} ;;

  }

  join: feature_popularity{
    view_label: "Popularity"
    from: feature_popularity
    relationship: one_to_one
    sql_on: ${referenced_in_issue.url} =  ${feature_popularity.source_url};;
    fields: [feature_popularity.popularity, feature_popularity.request_count]
  }

  join: labels {
    from: snowflake_github_graphql_normalized_labels
    fields: [labels.raw_label, labels.sfdc_account_id]
    sql_on: ${labels.github_object_url} = ${customer_issues.url};;
    relationship: one_to_many
  }

  join: filer {
    from: snowflake_github_logins_lookup
    sql_on: ${crossreferences.referenced_by_login} = ${filer.github_login} ;;
    type: full_outer
    relationship: many_to_one

  }

  join: sf__accounts{
    from: sf__accounts
    sql_on: ${sf__accounts.id} = ${labels.sfdc_account_id} ;;
    sql_table_name: SEGMENT.SALESFORCE.ACCOUNTS;;
    relationship: one_to_one
  }

  join: owner {
    view_label: "SFDC Account Owner"
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__accounts.owner_id} = ${owner.id} ;;
    relationship: many_to_one
  }

  join: tam {
    view_label: "TAM"
    from: sf__users
    sql_table_name: SEGMENT.SALESFORCE.USERS ;;
    sql_on: ${sf__accounts.tam} = ${tam.id} ;;
    relationship: many_to_one
  }
}

explore: snowflake_github_logins_lookup {
  join: snowflake_github_graphql_normalized_crossreferences {
    type: left_outer
    relationship: one_to_many
    sql_on: ${snowflake_github_graphql_normalized_crossreferences.referenced_by_login} = ${snowflake_github_logins_lookup.github_login}  ;;
  }
}

view: feature_popularity {
  derived_table: {
    sql: SELECT source_url, count(*) as count, ROW_NUMBER() OVER (ORDER by count(*) DESC) as popularity
          FROM github_graphql_normalized_crossreferences
            GROUP BY source_url ORDER BY count(*) desc ;;
  }
  dimension: source_url {
    type: string
    primary_key: yes
  }
  dimension: request_count {
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension: popularity {
    type: number
  }
}
