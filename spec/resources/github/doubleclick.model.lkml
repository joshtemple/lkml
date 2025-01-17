connection: "doubleclick"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

persist_for: "24 hours"

explore: impression {
  label: "Impressions"
  view_label: "Impressions"

  join: match_table_ads {
    view_label: "Ads"
    sql_on: ${impression.ad_id} = ${match_table_ads.ad_id} ;;
    relationship: many_to_one
  }

  join: match_table_campaigns {
    view_label: "Campaigns"
    sql_on: ${impression.campaign_id} = ${match_table_campaigns.campaign_id} ;;
    relationship: many_to_one
  }

  join: match_table_advertisers {
    view_label: "Advertisers"
    sql_on: ${impression.advertiser_id} = ${match_table_advertisers.advertiser_id} ;;
    relationship: many_to_one
  }

  join: match_table_ad_placement_assignments {
    view_label: "Ad Placements"
    sql_on: ${impression.ad_id} = ${match_table_ad_placement_assignments.ad_id} and ${impression.placement_id} = ${match_table_ad_placement_assignments.placement_id} ;;
    relationship: many_to_one
  }

  join: match_table_browsers {
    view_label: "Browsers"
    sql_on: ${impression.browser_platform_id} = ${match_table_browsers.browser_platform_id} ;;
    relationship: many_to_one
  }
}

explore: impression_funnel {
  join: match_table_campaigns {
    view_label: "Campaigns"
    sql_on: ${impression_funnel.campaign_id} =  ${match_table_campaigns.campaign_id} ;;
    relationship: many_to_one
  }

  join: match_table_ads {
    view_label: "Ads"
    sql_on: ${impression_funnel.ad_id} = ${match_table_ads.ad_id} ;;
    relationship: many_to_one
  }

  join: match_table_advertisers {
    view_label: "Advertisers"
    sql_on: ${impression_funnel.advertiser_id} = ${match_table_advertisers.advertiser_id} ;;
    relationship: many_to_one
  }

  join: user_campaign_facts {
    view_label: "Users"
    sql_on: ${impression_funnel.campaign_id} = ${user_campaign_facts.campaign_id} AND ${impression_funnel.user_id} = ${user_campaign_facts.user_id} ;;
    relationship: many_to_one
  }
}

explore: activity {
  label: "Activities"
  view_label: "Activities"

  join: match_table_ads {
    view_label: "Ads"
    sql_on: ${activity.ad_id} = ${match_table_ads.ad_id} ;;
    relationship: many_to_one
  }

  join: match_table_campaigns {
    view_label: "Campaigns"
    sql_on: ${activity.campaign_id} = ${match_table_campaigns.campaign_id} ;;
    relationship: many_to_one
  }

  join: match_table_advertisers {
    view_label: "Advertisers"
    sql_on: ${activity.advertiser_id} = ${match_table_advertisers.advertiser_id} ;;
    relationship: many_to_one
  }

  join: match_table_ad_placement_assignments {
    view_label: "Ad Placements"
    sql_on: ${activity.ad_id} = ${match_table_ad_placement_assignments.ad_id} and ${activity.placement_id} = ${match_table_ad_placement_assignments.placement_id} ;;
    relationship: many_to_one
  }

  join: match_table_browsers {
    view_label: "Browsers"
    sql_on: ${activity.browser_platform_id} = ${match_table_browsers.browser_platform_id} ;;
    relationship: many_to_one
  }
}

explore: click {
  label: "Clicks"
  view_label: "Clicks"

  join: match_table_ads {
    view_label: "Ads"
    sql_on: ${click.ad_id} = ${match_table_ads.ad_id} ;;
    relationship: many_to_one
  }

  join: match_table_campaigns {
    view_label: "Campaigns"
    sql_on: ${click.campaign_id} = ${match_table_campaigns.campaign_id} ;;
    relationship: many_to_one
  }

  join: match_table_advertisers {
    view_label: "Advertisers"
    sql_on: ${click.advertiser_id} = ${match_table_advertisers.advertiser_id} ;;
    relationship: many_to_one
  }

  join: match_table_ad_placement_assignments {
    view_label: "Ad Placements"
    sql_on: ${click.ad_id} = ${match_table_ad_placement_assignments.ad_id} and ${click.placement_id} = ${match_table_ad_placement_assignments.placement_id} ;;
    relationship: many_to_one
  }

  join: match_table_browsers {
    view_label: "Browsers"
    sql_on: ${click.browser_platform_id} = ${match_table_browsers.browser_platform_id} ;;
    relationship: many_to_one
  }
}

# - explore: campaign_date_table
#   always_filter:
#     campaign_date_table.calendar_date: 7 days
#   joins:
#   - join: impression_campaign_date
#     view_label: "Impression"
#     sql_on: |
#       ${campaign_date_table.campaign_id} = ${impression_campaign_date.campaign_id} and
#       ${campaign_date_table.calendar_date} = ${impression_campaign_date.impression_date} and
#       ${campaign_date_table.ad_id} = ${impression_campaign_date.ad_id}
# #       and {% condition campaign_date_table.calendar_date %} TIMESTAMP(impression._DATA_DATE) {% endcondition %}
#     relationship: one_to_many
#     fields: [count_impressions, distinct_users]

#   - join: activity
#     sql_on: |
#       ${campaign_date_table.campaign_id} = ${activity.campaign_id} and
#       ${campaign_date_table.calendar_date} = ${activity.activity_date}
# #       and {% condition campaign_date_table.calendar_date %} TIMESTAMP(activity._DATA_DATE) {% endcondition %}
#     relationship: one_to_many
#     fields: [count_activities, distinct_users]


#   always_filter:
#     date_filter: '30 Days'
#   joins:
#   - join: match_table_ads
#     sql_on: ${activity.ad_id} = ${match_table_ads.ad_id}
#     relationship: many_to_one
#
#   - join: match_table_campaigns
#     sql_on: ${activity.campaign_id} = ${match_table_campaigns.campaign_id}
#     relationship: many_to_one
#
#   - join: match_table_advertisers
#     sql_on: ${activity.advertiser_id} = ${match_table_advertisers.advertiser_id}
#     relationship: many_to_one
#
#   - join: match_table_ad_placement_assignments
#     sql_on: ${activity.ad_id} = ${match_table_ad_placement_assignments.ad_id} and ${activity.placement_id} = ${match_table_ad_placement_assignments.placement_id}
#     relationship: many_to_one
#
#   - join: match_table_browsers
#     sql_on: ${activity.browser_platform_id} = ${match_table_browsers.browser_platform_id}
#     relationship: many_to_one
#
# - explore: click
#   always_filter:
#     date_filter: '30 Days'
#   joins:
#   - join: match_table_ads
#     sql_on: ${click.ad_id} = ${match_table_ads.ad_id}
#     relationship: many_to_one
#
#   - join: match_table_campaigns
#     sql_on: ${click.campaign_id} = ${match_table_campaigns.campaign_id}
#     relationship: many_to_one
#
#   - join: match_table_advertisers
#     sql_on: ${click.advertiser_id} = ${match_table_advertisers.advertiser_id}
#     relationship: many_to_one
#
#   - join: match_table_ad_placement_assignments
#     sql_on: ${click.ad_id} = ${match_table_ad_placement_assignments.ad_id} and ${click.placement_id} = ${match_table_ad_placement_assignments.placement_id}
#     relationship: many_to_one
#
#   - join: match_table_browsers
#     sql_on: ${click.browser_platform_id} = ${match_table_browsers.browser_platform_id}
#     relationship: many_to_one
