view: dim_activity_view_uri {
  label: "Learning Path"
  derived_table: {
    sql:
    with a
    as (
      select
          id
          ,case
            when view_uri like '/static/iloveapps/webvideo%'
              then parse_json(case when check_json(split_part(view_uri, '&data=', 2)) is null then split_part(view_uri, '&data=', 2) end)
            when view_uri like '/mindapp-cxp/take.html?activityPath=IMILAC://imilac:activity:%'
              then parse_url(replace(view_uri, '/mindapp-cxp/take.html?activityPath=IMILAC://imilac:activity:', 'IMILAC://'), 1)
            when view_uri like '/mindapp-cxp/take.html?activityPath=%'
                 or view_uri like 'take.html?activityPath=%'
              then parse_url(
                      replace(replace(
                        case
                        when array_size(split(view_uri, ':')) = 1
                          then 'mindtap://' || view_uri
                        else view_uri
                        end
                  ,'/mindapp-cxp/', ''), 'take.html?activityPath=', '')
               ,1)
            when view_uri like '/static%'
              then parse_url('mindtap://ng.cengage.com' || view_uri)
            when parse_url(view_uri, 1):error is not null
              then parse_url('mindtap://ng.cengage.com' || view_uri)
            else parse_url(replace(trim(view_uri), 'https', 'http'), 1)
            end as parse
            ,view_uri
            ,ref_id
      from stg_mindtap.activity
      where view_uri is not null
      or ref_id is not null
    )
    ,urls as (
      select
          id
          ,case
              --youtube
              when parse:scheme is null then parse_url(html_unescape(parse:src))
              --everything else
              else parse
              end as parsed_url
          ,case when parse:scheme is null then parse end as details
          ,html_unescape(parse:src) as path
          ,view_uri
          ,ref_id
      from a
    )
    select
        id
        ,case
            when parsed_url:scheme = 'http'
            then parsed_url:host::string
            else parsed_url:scheme::string
            end as ContentSource
        ,path
        ,ref_id
        ,view_uri
        ,case when view_uri ilike '%ilrn/integration/mindapp.do%' then 'CNOW asset'
              when view_uri ilike '%cnow.apps.ng.cengage.com%' then 'CNOW asset'
              when view_uri ilike '%/googledoc/%' then 'Google Docs (.docx, .pptx, .xlsx, .pdf, etc.)'
              when view_uri ilike '%static/iloveapps/weblink/weblink.html%' then 'WebLink (video, pdf, reading, etc.)'
              when view_uri ilike '%af/servlet/mindapp/entry%' then 'Aplia asset'
              when view_uri ilike '%aplia.apps.ng.cengage.com%' then 'Aplia asset'
              when view_uri ilike '%api.webassign.net/%' then 'WebAssign asset'
              when view_uri ilike '%/splash%' then 'WebAssign asset'
              when view_uri ilike '%/flashcard.html%' then 'MindApp - Flashcard'
              when view_uri ilike '%static/nbreader/ui/apps/nbreader/nbreader.html%' then 'MindApp - Reader'
              when view_uri ilike '%/static/nbapps/aa/%' then 'MindTap - Unknown APP (AA?)'
              when view_uri ilike '%/ui/index.html?aa.id%' then 'MindTap - Unknown APP (AA?)'
              when view_uri ilike '%/studycenter/%' then 'MindTap - Studycenter'
              when view_uri ilike '%/refId/%' then 'CONSTRUCT' -- Construct appears to be some special CXP asset, so needs to be above the CXP
              when view_uri ilike '%activityPath=CXP%' then 'CXP asset'
              when view_uri ilike '%/mindapp-cxp/take.html?%' then 'CXP asset'
              when view_uri ilike '%view.html%' then 'CAS-player'
              when view_uri ilike '%static/nbapps/media/activity.html%' then 'Media'
              when view_uri ilike '%youtube.com%' then 'YouTube'
              when view_uri ilike '%youseeu%' then 'YouSeeU'
              when view_uri ilike '%RSS%' then 'RSS Feed'
              when view_uri ilike '%DLMT/web/launch.aspx%' then 'Delmar'
              when view_uri ilike '%samapi/api/Appification/LaunchAssignment%' then 'SAM Asset'
              when view_uri ilike '%static/iloveapps/weblink/weblink.html%' then 'WebLink (video, pdf, reading, etc.)'
              when view_uri ilike '%static/iloveapps/kaltura/kaltura.html%' then 'Kaltura'
              when view_uri ilike '%lams/mindapp/learn.do%' then 'LAMS'
              when view_uri ilike '%static/iloveapps/enhancedinsite/enhancedinsite.html%' then 'InSite'
              when view_uri ilike '%insite2.cengage.com%' then 'InSite'
              when view_uri ilike '%we/mindtap/ssoauth%' then 'Vantage'
              when view_uri ilike '%Amazon%' then 'AWS file'
              when view_uri ilike '%activityPath=IMILAC%' then 'IMILAC'
              when view_uri ilike '%profileplus.cengage.com%' then 'ProfilePlus'
              when view_uri ilike '%college.cengage.com%' then 'college.cengage.com asset'
              when view_uri ilike '%questia%' then 'Questia'
              when view_uri ilike '%knewton%' then 'Knewton'
              when view_uri ilike '%/mindapp-non-mt-activity%' then 'non-MindTap activity'
              when view_uri ilike '%ng.cengage.com%' then 'ng.cengage.com'
              when view_uri ilike '%/static/iloveapps/onedrive/%' then 'ng.cengage.com'
              when view_uri ilike '%cerego%' then 'Cerego'
              else 'Uncategorized'
              end as content_source_category
        ,replace(max(details:details) over (partition by path), 'ntt', '')::string as details_inline
        ,replace(replace(max(details:details) over (partition by path), '||', '\n'), 'ntt', '')::string as details_wrapped
        ,split_part(max(details:details) over (partition by path), 'By:', 2) as details_by
    from urls;;
    sql_trigger_value: select count(*) from stg_mindtap.activity ;;
  }
set: curated_field {fields:[path,contentsource,content_source_category]}
  dimension: id {
    primary_key: yes
    hidden: yes
  }

  dimension: contentsource {
    label: "Content Source"
    type: string
    hidden: yes
  }

  dimension:content_source_category {
    label: "Content Source Category"
    description: "Primary app or asset utilized when adding activities to a learning path.  Note that a high percentage of 'uncategorized' LP additions appear to be recommended readings and could likely be considerd 'non-Mindtap activities'."
    type:  string
    hidden: yes
  }

  dimension: details_inline {
    group_label: "YouTube"
    label: "Details (YouTube)"
    sql: ${TABLE}.details_inline ;;
  }

  dimension: details_by {
    group_label: "YouTube"
    label: "Channel (YouTube)"
    sql: ${TABLE}.details_by ;;
  }

  dimension: details_wrapped {
    hidden: yes
    sql: ${TABLE}.details_wrapped ;;
  }

  dimension: path {
    group_label: "YouTube"
    label: "Link (YouTube)"
    description: "Youtube Link added by the Instructor"
    type: string
    html: <a title="{{ dim_activity_view_uri.details_wrapped._value }}" target="_blank" href="{{value}}">{{value}}</a> ;;
  }

  dimension: view_uri {
    label: "MindTap URI"
    description: "The uri stored in mindtap for this content (VIEW_URI)"
  }

  dimension: ref_id {
    label: "MindTap REF_ID"
    description: "Used to link to detailed information in other systems like Aplia"
  }

}
