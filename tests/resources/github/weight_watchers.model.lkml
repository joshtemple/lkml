connection: "sandbox-bq-standard-sql"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

#example datagroup... datagroups set the policy for reuse of cached queries and rebuild of persistent derive tables https://docs.looker.com/data-modeling/learning-lookml/caching
datagroup: weight_watchers_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}


explore: core_profile_service__1__ProfileEvent_v020_km {
  hidden: yes
#   join: core_profile_service__1__ProfileEvent_v020__payload {
#     sql: ,UNNEST([${core_profile_service__1__ProfileEvent_v020.payload}]) as core_profile_service__1__ProfileEvent_v020__payload ;;
#     relationship: one_to_one
#   }
  join: core_journaling_service__1__JournalEvent_v010_km {
#     sql: LEFT JOIN UNNEST([wwi_processed_data.core_journaling_service__1__JournalEvent_v010.payload]) as core_journaling_service__1__JournalEvent_v010__payload on ${core_journaling_service__1__JournalEvent_v010__payload.user_id}=${core_profile_service__1__ProfileEvent_v020__payload.user_id} ;;
    sql_on: ${core_profile_service__1__ProfileEvent_v020_km.user_id}= ${core_journaling_service__1__JournalEvent_v010_km.user_id};;
    relationship: one_to_many
  }

}



explore: core_journaling_service__1__JournalEvent_v010 {
  hidden: yes
  label: "Journal Event"
  join: core_journaling_service__1__JournalEvent_v010__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V010: Partitions"
    view_label: "Journal Event"
    sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v010.partitions}]) as core_journaling_service__1__JournalEvent_v010__partitions ;;
    relationship: one_to_one
  }

  join: core_journaling_service__1__JournalEvent_v010__headers {
#     view_label: "Core Journaling Service 1 Journalevent V010: Headers"
    view_label: "Journal Event"
    sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v010.headers}]) as core_journaling_service__1__JournalEvent_v010__headers ;;
    relationship: one_to_one
  }

  join: core_journaling_service__1__JournalEvent_v010__payload {
#     view_label: "Core Journaling Service 1 Journalevent V010: Payload"
    view_label: "Journal Event"
    sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v010.payload}]) as core_journaling_service__1__JournalEvent_v010__payload ;;
    relationship: one_to_one
  }

  join: core_profile_service__1__ProfileEvent_v001 {
    view_label: "Profile Event"
#     sql_on: ${cde_profile_service__1__ProfileEvent_v001.user_id}=${core_journaling_service__1__JournalEvent_v010__payload.user_id} ;;
    sql_on: ${core_profile_service__1__ProfileEvent_v001__payload.user_id}=${core_journaling_service__1__JournalEvent_v010__payload.user_id} ;;
    relationship: many_to_one
  }
# #
# #   join: cde_profile_service__1__ProfileEvent_v001__partitions {
# # #     view_label: "Cde Profile Service 1 Profileevent V001: Partitions"
# #     view_label: "Profile Event"
# #     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001.partitions}]) as cde_profile_service__1__ProfileEvent_v001__partitions ;;
# #     relationship: one_to_one
# #   }
# #
# #   join: cde_profile_service__1__ProfileEvent_v001__headers {
# # #     view_label: "Cde Profile Service 1 Profileevent V001: Headers"
# #     view_label: "Profile Event"
# #     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001.headers}]) as cde_profile_service__1__ProfileEvent_v001__headers ;;
# #     relationship: one_to_one
# #   }
# #
  join: core_profile_service__1__ProfileEvent_v001__payload {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload"
    view_label: "Profile Event"
    sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001.payload}]) as cde_profile_service__1__ProfileEvent_v001__payload ;;
    relationship: one_to_one
  }

}


# explore: cde_profile_service__1__profile_event_v001 {
#   join: cde_profile_service__1__ProfileEvent_v001__partitions {
#     view_label: "Cde Profile Service 1 Profileevent V001: Partitions"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001.partitions}]) as cde_profile_service__1__ProfileEvent_v001__partitions ;;
#     relationship: one_to_one
#   }

#   join: cde_profile_service__1__ProfileEvent_v001__headers {
#     view_label: "Cde Profile Service 1 Profileevent V001: Headers"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001.headers}]) as cde_profile_service__1__ProfileEvent_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001.payload}]) as cde_profile_service__1__ProfileEvent_v001__payload ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload__identity {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload Identity"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001__payload.identity}]) as cde_profile_service__1__ProfileEvent_v001__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload__additional_settings {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001__payload.additional_settings}]) as cde_profile_service__1__ProfileEvent_v001__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload__email {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload Email"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001__payload.email}]) as cde_profile_service__1__ProfileEvent_v001__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload__address__shipping {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001__payload__address.shipping}]) as cde_profile_service__1__ProfileEvent_v001__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload__address__home {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001__payload__address.home}]) as cde_profile_service__1__ProfileEvent_v001__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload__phone {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload Phone"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001__payload.phone}]) as cde_profile_service__1__ProfileEvent_v001__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileEvent_v001__payload__address {
#     view_label: "Cde Profile Service 1 Profileevent V001: Payload Address"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileEvent_v001__payload.address}]) as cde_profile_service__1__ProfileEvent_v001__payload__address ;;
#     relationship: one_to_one
#   }
# }











# explore: cde_profile_service__1__profile_snapshot_v001 {
#   join: cde_profile_service__1__ProfileSnapshot_v001__partitions {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Partitions"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001.partitions}]) as cde_profile_service__1__ProfileSnapshot_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__headers {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Headers"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001.headers}]) as cde_profile_service__1__ProfileSnapshot_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001.payload}]) as cde_profile_service__1__ProfileSnapshot_v001__payload ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload__identity {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload Identity"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001__payload.identity}]) as cde_profile_service__1__ProfileSnapshot_v001__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload__additional_settings {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001__payload.additional_settings}]) as cde_profile_service__1__ProfileSnapshot_v001__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload__email {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload Email"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001__payload.email}]) as cde_profile_service__1__ProfileSnapshot_v001__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload__address__shipping {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001__payload__address.shipping}]) as cde_profile_service__1__ProfileSnapshot_v001__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload__address__home {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001__payload__address.home}]) as cde_profile_service__1__ProfileSnapshot_v001__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload__phone {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload Phone"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001__payload.phone}]) as cde_profile_service__1__ProfileSnapshot_v001__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: cde_profile_service__1__ProfileSnapshot_v001__payload__address {
#     view_label: "Cde Profile Service 1 Profilesnapshot V001: Payload Address"
#     sql: LEFT JOIN UNNEST([${cde_profile_service__1__ProfileSnapshot_v001__payload.address}]) as cde_profile_service__1__ProfileSnapshot_v001__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__1__meeting_v001 {
#   join: champ__1__MEETING_v001__partitions {
#     view_label: "Champ 1 Meeting V001: Partitions"
#     sql: LEFT JOIN UNNEST([${champ__1__MEETING_v001.partitions}]) as champ__1__MEETING_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: champ__1__MEETING_v001__headers {
#     view_label: "Champ 1 Meeting V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__1__MEETING_v001.headers}]) as champ__1__MEETING_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__1__MEETING_v001__payload {
#     view_label: "Champ 1 Meeting V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__1__MEETING_v001.payload}]) as champ__1__MEETING_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__location__1_v001 {
#   join: champ__LOCATION__1_v001__headers {
#     view_label: "Champ Location 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__LOCATION__1_v001.headers}]) as champ__LOCATION__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__LOCATION__1_v001__payload {
#     view_label: "Champ Location 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__LOCATION__1_v001.payload}]) as champ__LOCATION__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__location_version_history__1_v001 {
#   join: champ__LOCATION_VERSION_HISTORY__1_v001__headers {
#     view_label: "Champ Location Version History 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__LOCATION_VERSION_HISTORY__1_v001.headers}]) as champ__LOCATION_VERSION_HISTORY__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__LOCATION_VERSION_HISTORY__1_v001__payload {
#     view_label: "Champ Location Version History 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__LOCATION_VERSION_HISTORY__1_v001.payload}]) as champ__LOCATION_VERSION_HISTORY__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting__1_v001 {
#   join: champ__MEETING__1_v001__headers {
#     view_label: "Champ Meeting 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING__1_v001.headers}]) as champ__MEETING__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING__1_v001__payload {
#     view_label: "Champ Meeting 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING__1_v001.payload}]) as champ__MEETING__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting__1_v002 {
#   join: champ__MEETING__1_v002__headers {
#     view_label: "Champ Meeting 1 V002: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING__1_v002.headers}]) as champ__MEETING__1_v002__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING__1_v002__payload {
#     view_label: "Champ Meeting 1 V002: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING__1_v002.payload}]) as champ__MEETING__1_v002__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting__1_v003 {
#   join: champ__MEETING__1_v003__headers {
#     view_label: "Champ Meeting 1 V003: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING__1_v003.headers}]) as champ__MEETING__1_v003__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING__1_v003__payload {
#     view_label: "Champ Meeting 1 V003: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING__1_v003.payload}]) as champ__MEETING__1_v003__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting_occurrence__1_v001 {
#   join: champ__MEETING_OCCURRENCE__1_v001__headers {
#     view_label: "Champ Meeting Occurrence 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v001.headers}]) as champ__MEETING_OCCURRENCE__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING_OCCURRENCE__1_v001__payload {
#     view_label: "Champ Meeting Occurrence 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v001.payload}]) as champ__MEETING_OCCURRENCE__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting_occurrence__1_v002 {
#   join: champ__MEETING_OCCURRENCE__1_v002__headers {
#     view_label: "Champ Meeting Occurrence 1 V002: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v002.headers}]) as champ__MEETING_OCCURRENCE__1_v002__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING_OCCURRENCE__1_v002__payload {
#     view_label: "Champ Meeting Occurrence 1 V002: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v002.payload}]) as champ__MEETING_OCCURRENCE__1_v002__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting_occurrence__1_v003 {
#   join: champ__MEETING_OCCURRENCE__1_v003__headers {
#     view_label: "Champ Meeting Occurrence 1 V003: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v003.headers}]) as champ__MEETING_OCCURRENCE__1_v003__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING_OCCURRENCE__1_v003__payload {
#     view_label: "Champ Meeting Occurrence 1 V003: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v003.payload}]) as champ__MEETING_OCCURRENCE__1_v003__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting_occurrence__1_v004 {
#   join: champ__MEETING_OCCURRENCE__1_v004__headers {
#     view_label: "Champ Meeting Occurrence 1 V004: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v004.headers}]) as champ__MEETING_OCCURRENCE__1_v004__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING_OCCURRENCE__1_v004__payload {
#     view_label: "Champ Meeting Occurrence 1 V004: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_OCCURRENCE__1_v004.payload}]) as champ__MEETING_OCCURRENCE__1_v004__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__meeting_user_map__1_v001 {
#   join: champ__MEETING_USER_MAP__1_v001__headers {
#     view_label: "Champ Meeting User Map 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_USER_MAP__1_v001.headers}]) as champ__MEETING_USER_MAP__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEETING_USER_MAP__1_v001__payload {
#     view_label: "Champ Meeting User Map 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEETING_USER_MAP__1_v001.payload}]) as champ__MEETING_USER_MAP__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__member_contact_preference__1_v001 {
#   join: champ__MEMBER_CONTACT_PREFERENCE__1_v001__headers {
#     view_label: "Champ Member Contact Preference 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_CONTACT_PREFERENCE__1_v001.headers}]) as champ__MEMBER_CONTACT_PREFERENCE__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEMBER_CONTACT_PREFERENCE__1_v001__payload {
#     view_label: "Champ Member Contact Preference 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_CONTACT_PREFERENCE__1_v001.payload}]) as champ__MEMBER_CONTACT_PREFERENCE__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__member_milestone__1_v001 {
#   join: champ__MEMBER_MILESTONE__1_v001__headers {
#     view_label: "Champ Member Milestone 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_MILESTONE__1_v001.headers}]) as champ__MEMBER_MILESTONE__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEMBER_MILESTONE__1_v001__payload {
#     view_label: "Champ Member Milestone 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_MILESTONE__1_v001.payload}]) as champ__MEMBER_MILESTONE__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__member_profile__1_v001 {
#   join: champ__MEMBER_PROFILE__1_v001__headers {
#     view_label: "Champ Member Profile 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_PROFILE__1_v001.headers}]) as champ__MEMBER_PROFILE__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEMBER_PROFILE__1_v001__payload {
#     view_label: "Champ Member Profile 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_PROFILE__1_v001.payload}]) as champ__MEMBER_PROFILE__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__member_profile__1_v002 {
#   join: champ__MEMBER_PROFILE__1_v002__headers {
#     view_label: "Champ Member Profile 1 V002: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_PROFILE__1_v002.headers}]) as champ__MEMBER_PROFILE__1_v002__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEMBER_PROFILE__1_v002__payload {
#     view_label: "Champ Member Profile 1 V002: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_PROFILE__1_v002.payload}]) as champ__MEMBER_PROFILE__1_v002__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__member_profile__1_v003 {
#   join: champ__MEMBER_PROFILE__1_v003__headers {
#     view_label: "Champ Member Profile 1 V003: Headers"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_PROFILE__1_v003.headers}]) as champ__MEMBER_PROFILE__1_v003__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__MEMBER_PROFILE__1_v003__payload {
#     view_label: "Champ Member Profile 1 V003: Payload"
#     sql: LEFT JOIN UNNEST([${champ__MEMBER_PROFILE__1_v003.payload}]) as champ__MEMBER_PROFILE__1_v003__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: champ__user_enrollment__1_v001 {
#   join: champ__USER_ENROLLMENT__1_v001__headers {
#     view_label: "Champ User Enrollment 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${champ__USER_ENROLLMENT__1_v001.headers}]) as champ__USER_ENROLLMENT__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: champ__USER_ENROLLMENT__1_v001__payload {
#     view_label: "Champ User Enrollment 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${champ__USER_ENROLLMENT__1_v001.payload}]) as champ__USER_ENROLLMENT__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: connect__1__comment_v001 {
#   join: connect__1__Comment_v001__partitions {
#     view_label: "Connect 1 Comment V001: Partitions"
#     sql: LEFT JOIN UNNEST([${connect__1__Comment_v001.partitions}]) as connect__1__Comment_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Comment_v001__headers {
#     view_label: "Connect 1 Comment V001: Headers"
#     sql: LEFT JOIN UNNEST([${connect__1__Comment_v001.headers}]) as connect__1__Comment_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Comment_v001__payload__comment {
#     view_label: "Connect 1 Comment V001: Payload Comment"
#     sql: LEFT JOIN UNNEST([${connect__1__Comment_v001__payload.comment}]) as connect__1__Comment_v001__payload__comment ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Comment_v001__payload__comment__post {
#     view_label: "Connect 1 Comment V001: Payload Comment Post"
#     sql: LEFT JOIN UNNEST([${connect__1__Comment_v001__payload__comment.post}]) as connect__1__Comment_v001__payload__comment__post ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Comment_v001__payload__comment__post__user {
#     view_label: "Connect 1 Comment V001: Payload Comment Post User"
#     sql: LEFT JOIN UNNEST([${connect__1__Comment_v001__payload__comment__post.user}]) as connect__1__Comment_v001__payload__comment__post__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Comment_v001__payload__comment__user {
#     view_label: "Connect 1 Comment V001: Payload Comment User"
#     sql: LEFT JOIN UNNEST([${connect__1__Comment_v001__payload__comment.user}]) as connect__1__Comment_v001__payload__comment__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Comment_v001__payload {
#     view_label: "Connect 1 Comment V001: Payload"
#     sql: LEFT JOIN UNNEST([${connect__1__Comment_v001.payload}]) as connect__1__Comment_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: connect__1__like_v001 {
#   join: connect__1__Like_v001__partitions {
#     view_label: "Connect 1 Like V001: Partitions"
#     sql: LEFT JOIN UNNEST([${connect__1__Like_v001.partitions}]) as connect__1__Like_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Like_v001__headers {
#     view_label: "Connect 1 Like V001: Headers"
#     sql: LEFT JOIN UNNEST([${connect__1__Like_v001.headers}]) as connect__1__Like_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Like_v001__payload__like__likeable {
#     view_label: "Connect 1 Like V001: Payload Like Likeable"
#     sql: LEFT JOIN UNNEST([${connect__1__Like_v001__payload__like.likeable}]) as connect__1__Like_v001__payload__like__likeable ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Like_v001__payload__like__likeable__user {
#     view_label: "Connect 1 Like V001: Payload Like Likeable User"
#     sql: LEFT JOIN UNNEST([${connect__1__Like_v001__payload__like__likeable.user}]) as connect__1__Like_v001__payload__like__likeable__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Like_v001__payload__like {
#     view_label: "Connect 1 Like V001: Payload Like"
#     sql: LEFT JOIN UNNEST([${connect__1__Like_v001__payload.like}]) as connect__1__Like_v001__payload__like ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Like_v001__payload__like__user {
#     view_label: "Connect 1 Like V001: Payload Like User"
#     sql: LEFT JOIN UNNEST([${connect__1__Like_v001__payload__like.user}]) as connect__1__Like_v001__payload__like__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Like_v001__payload {
#     view_label: "Connect 1 Like V001: Payload"
#     sql: LEFT JOIN UNNEST([${connect__1__Like_v001.payload}]) as connect__1__Like_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: connect__1__mention_v001 {
#   join: connect__1__Mention_v001__partitions {
#     view_label: "Connect 1 Mention V001: Partitions"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001.partitions}]) as connect__1__Mention_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__headers {
#     view_label: "Connect 1 Mention V001: Headers"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001.headers}]) as connect__1__Mention_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__payload__mention__mentionable__post {
#     view_label: "Connect 1 Mention V001: Payload Mention Mentionable Post"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001__payload__mention__mentionable.post}]) as connect__1__Mention_v001__payload__mention__mentionable__post ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__payload__mention__mentionable__post__user {
#     view_label: "Connect 1 Mention V001: Payload Mention Mentionable Post User"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001__payload__mention__mentionable__post.user}]) as connect__1__Mention_v001__payload__mention__mentionable__post__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__payload__mention__mentionable {
#     view_label: "Connect 1 Mention V001: Payload Mention Mentionable"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001__payload__mention.mentionable}]) as connect__1__Mention_v001__payload__mention__mentionable ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__payload__mention__mentionable__user {
#     view_label: "Connect 1 Mention V001: Payload Mention Mentionable User"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001__payload__mention__mentionable.user}]) as connect__1__Mention_v001__payload__mention__mentionable__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__payload__mention__user {
#     view_label: "Connect 1 Mention V001: Payload Mention User"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001__payload__mention.user}]) as connect__1__Mention_v001__payload__mention__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__payload__mention {
#     view_label: "Connect 1 Mention V001: Payload Mention"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001__payload.mention}]) as connect__1__Mention_v001__payload__mention ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Mention_v001__payload {
#     view_label: "Connect 1 Mention V001: Payload"
#     sql: LEFT JOIN UNNEST([${connect__1__Mention_v001.payload}]) as connect__1__Mention_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: connect__1__post_v001 {
#   join: connect__1__Post_v001__partitions {
#     view_label: "Connect 1 Post V001: Partitions"
#     sql: LEFT JOIN UNNEST([${connect__1__Post_v001.partitions}]) as connect__1__Post_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Post_v001__headers {
#     view_label: "Connect 1 Post V001: Headers"
#     sql: LEFT JOIN UNNEST([${connect__1__Post_v001.headers}]) as connect__1__Post_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Post_v001__payload__post {
#     view_label: "Connect 1 Post V001: Payload Post"
#     sql: LEFT JOIN UNNEST([${connect__1__Post_v001__payload.post}]) as connect__1__Post_v001__payload__post ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Post_v001__payload__post__user {
#     view_label: "Connect 1 Post V001: Payload Post User"
#     sql: LEFT JOIN UNNEST([${connect__1__Post_v001__payload__post.user}]) as connect__1__Post_v001__payload__post__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Post_v001__payload {
#     view_label: "Connect 1 Post V001: Payload"
#     sql: LEFT JOIN UNNEST([${connect__1__Post_v001.payload}]) as connect__1__Post_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: connect__1__relationship_v001 {
#   join: connect__1__Relationship_v001__partitions {
#     view_label: "Connect 1 Relationship V001: Partitions"
#     sql: LEFT JOIN UNNEST([${connect__1__Relationship_v001.partitions}]) as connect__1__Relationship_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Relationship_v001__headers {
#     view_label: "Connect 1 Relationship V001: Headers"
#     sql: LEFT JOIN UNNEST([${connect__1__Relationship_v001.headers}]) as connect__1__Relationship_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Relationship_v001__payload__relationship__follower {
#     view_label: "Connect 1 Relationship V001: Payload Relationship Follower"
#     sql: LEFT JOIN UNNEST([${connect__1__Relationship_v001__payload__relationship.follower}]) as connect__1__Relationship_v001__payload__relationship__follower ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Relationship_v001__payload__relationship {
#     view_label: "Connect 1 Relationship V001: Payload Relationship"
#     sql: LEFT JOIN UNNEST([${connect__1__Relationship_v001__payload.relationship}]) as connect__1__Relationship_v001__payload__relationship ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Relationship_v001__payload__relationship__followed {
#     view_label: "Connect 1 Relationship V001: Payload Relationship Followed"
#     sql: LEFT JOIN UNNEST([${connect__1__Relationship_v001__payload__relationship.followed}]) as connect__1__Relationship_v001__payload__relationship__followed ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Relationship_v001__payload {
#     view_label: "Connect 1 Relationship V001: Payload"
#     sql: LEFT JOIN UNNEST([${connect__1__Relationship_v001.payload}]) as connect__1__Relationship_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: connect__1__tag_v001 {
#   join: connect__1__Tag_v001__partitions {
#     view_label: "Connect 1 Tag V001: Partitions"
#     sql: LEFT JOIN UNNEST([${connect__1__Tag_v001.partitions}]) as connect__1__Tag_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Tag_v001__headers {
#     view_label: "Connect 1 Tag V001: Headers"
#     sql: LEFT JOIN UNNEST([${connect__1__Tag_v001.headers}]) as connect__1__Tag_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Tag_v001__payload__tag {
#     view_label: "Connect 1 Tag V001: Payload Tag"
#     sql: LEFT JOIN UNNEST([${connect__1__Tag_v001__payload.tag}]) as connect__1__Tag_v001__payload__tag ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__Tag_v001__payload {
#     view_label: "Connect 1 Tag V001: Payload"
#     sql: LEFT JOIN UNNEST([${connect__1__Tag_v001.payload}]) as connect__1__Tag_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: connect__1__user_v001 {
#   join: connect__1__User_v001__partitions {
#     view_label: "Connect 1 User V001: Partitions"
#     sql: LEFT JOIN UNNEST([${connect__1__User_v001.partitions}]) as connect__1__User_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__User_v001__headers {
#     view_label: "Connect 1 User V001: Headers"
#     sql: LEFT JOIN UNNEST([${connect__1__User_v001.headers}]) as connect__1__User_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__User_v001__payload__user {
#     view_label: "Connect 1 User V001: Payload User"
#     sql: LEFT JOIN UNNEST([${connect__1__User_v001__payload.user}]) as connect__1__User_v001__payload__user ;;
#     relationship: one_to_one
#   }
#
#   join: connect__1__User_v001__payload {
#     view_label: "Connect 1 User V001: Payload"
#     sql: LEFT JOIN UNNEST([${connect__1__User_v001.payload}]) as connect__1__User_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_assessment_service__1__assessment_result_event_v001 {
#   join: core_assessment_service__1__AssessmentResultEvent_v001__partitions {
#     view_label: "Core Assessment Service 1 Assessmentresultevent V001: Partitions"
#     sql: LEFT JOIN UNNEST([${core_assessment_service__1__AssessmentResultEvent_v001.partitions}]) as core_assessment_service__1__AssessmentResultEvent_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_assessment_service__1__AssessmentResultEvent_v001__headers {
#     view_label: "Core Assessment Service 1 Assessmentresultevent V001: Headers"
#     sql: LEFT JOIN UNNEST([${core_assessment_service__1__AssessmentResultEvent_v001.headers}]) as core_assessment_service__1__AssessmentResultEvent_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result {
#     view_label: "Core Assessment Service 1 Assessmentresultevent V001: Payload Assessment Result"
#     sql: LEFT JOIN UNNEST([${core_assessment_service__1__AssessmentResultEvent_v001__payload.assessment_result}]) as core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result ;;
#     relationship: one_to_one
#   }
#
#   join: core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions {
#     view_label: "Core Assessment Service 1 Assessmentresultevent V001: Payload Assessment Result Questions"
#     sql: LEFT JOIN UNNEST(${core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result.questions}) as core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions ;;
#     relationship: one_to_many
#   }
#
#   join: core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions__parts {
#     view_label: "Core Assessment Service 1 Assessmentresultevent V001: Payload Assessment Result Questions Parts"
#     sql: LEFT JOIN UNNEST(${core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions.parts}) as core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions__parts ;;
#     relationship: one_to_many
#   }
#
#   join: core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions__parts__options {
#     view_label: "Core Assessment Service 1 Assessmentresultevent V001: Payload Assessment Result Questions Parts Options"
#     sql: LEFT JOIN UNNEST(${core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions__parts.options}) as core_assessment_service__1__AssessmentResultEvent_v001__payload__assessment_result__questions__parts__options ;;
#     relationship: one_to_many
#   }
#
#   join: core_assessment_service__1__AssessmentResultEvent_v001__payload {
#     view_label: "Core Assessment Service 1 Assessmentresultevent V001: Payload"
#     sql: LEFT JOIN UNNEST([${core_assessment_service__1__AssessmentResultEvent_v001.payload}]) as core_assessment_service__1__AssessmentResultEvent_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v001 {
#   join: core_journaling_service__1__JournalEvent_v001__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V001: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v001.partitions}]) as core_journaling_service__1__JournalEvent_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v001__headers {
#     view_label: "Core Journaling Service 1 Journalevent V001: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v001.headers}]) as core_journaling_service__1__JournalEvent_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v001__payload {
#     view_label: "Core Journaling Service 1 Journalevent V001: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v001.payload}]) as core_journaling_service__1__JournalEvent_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v002 {
#   join: core_journaling_service__1__JournalEvent_v002__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V002: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v002.partitions}]) as core_journaling_service__1__JournalEvent_v002__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v002__headers {
#     view_label: "Core Journaling Service 1 Journalevent V002: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v002.headers}]) as core_journaling_service__1__JournalEvent_v002__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v002__payload {
#     view_label: "Core Journaling Service 1 Journalevent V002: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v002.payload}]) as core_journaling_service__1__JournalEvent_v002__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v003 {
#   join: core_journaling_service__1__JournalEvent_v003__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V003: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v003.partitions}]) as core_journaling_service__1__JournalEvent_v003__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v003__headers {
#     view_label: "Core Journaling Service 1 Journalevent V003: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v003.headers}]) as core_journaling_service__1__JournalEvent_v003__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v003__payload {
#     view_label: "Core Journaling Service 1 Journalevent V003: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v003.payload}]) as core_journaling_service__1__JournalEvent_v003__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v004 {
#   join: core_journaling_service__1__JournalEvent_v004__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V004: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v004.partitions}]) as core_journaling_service__1__JournalEvent_v004__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v004__headers {
#     view_label: "Core Journaling Service 1 Journalevent V004: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v004.headers}]) as core_journaling_service__1__JournalEvent_v004__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v004__payload {
#     view_label: "Core Journaling Service 1 Journalevent V004: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v004.payload}]) as core_journaling_service__1__JournalEvent_v004__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v005 {
#   join: core_journaling_service__1__JournalEvent_v005__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V005: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v005.partitions}]) as core_journaling_service__1__JournalEvent_v005__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v005__headers {
#     view_label: "Core Journaling Service 1 Journalevent V005: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v005.headers}]) as core_journaling_service__1__JournalEvent_v005__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v005__payload {
#     view_label: "Core Journaling Service 1 Journalevent V005: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v005.payload}]) as core_journaling_service__1__JournalEvent_v005__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v006 {
#   join: core_journaling_service__1__JournalEvent_v006__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V006: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v006.partitions}]) as core_journaling_service__1__JournalEvent_v006__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v006__headers {
#     view_label: "Core Journaling Service 1 Journalevent V006: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v006.headers}]) as core_journaling_service__1__JournalEvent_v006__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v006__payload {
#     view_label: "Core Journaling Service 1 Journalevent V006: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v006.payload}]) as core_journaling_service__1__JournalEvent_v006__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v007 {
#   join: core_journaling_service__1__JournalEvent_v007__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V007: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v007.partitions}]) as core_journaling_service__1__JournalEvent_v007__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v007__headers {
#     view_label: "Core Journaling Service 1 Journalevent V007: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v007.headers}]) as core_journaling_service__1__JournalEvent_v007__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v007__payload {
#     view_label: "Core Journaling Service 1 Journalevent V007: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v007.payload}]) as core_journaling_service__1__JournalEvent_v007__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v008 {
#   join: core_journaling_service__1__JournalEvent_v008__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V008: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v008.partitions}]) as core_journaling_service__1__JournalEvent_v008__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v008__headers {
#     view_label: "Core Journaling Service 1 Journalevent V008: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v008.headers}]) as core_journaling_service__1__JournalEvent_v008__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v008__payload {
#     view_label: "Core Journaling Service 1 Journalevent V008: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v008.payload}]) as core_journaling_service__1__JournalEvent_v008__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_journaling_service__1__journal_event_v009 {
#   join: core_journaling_service__1__JournalEvent_v009__partitions {
#     view_label: "Core Journaling Service 1 Journalevent V009: Partitions"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v009.partitions}]) as core_journaling_service__1__JournalEvent_v009__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v009__headers {
#     view_label: "Core Journaling Service 1 Journalevent V009: Headers"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v009.headers}]) as core_journaling_service__1__JournalEvent_v009__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_journaling_service__1__JournalEvent_v009__payload {
#     view_label: "Core Journaling Service 1 Journalevent V009: Payload"
#     sql: LEFT JOIN UNNEST([${core_journaling_service__1__JournalEvent_v009.payload}]) as core_journaling_service__1__JournalEvent_v009__payload ;;
#     relationship: one_to_one
#   }
# }
#

#
# explore: core_profile_service__1__profile_event_v001 {
#   join: core_profile_service__1__ProfileEvent_v001__partitions {
#     view_label: "Core Profile Service 1 Profileevent V001: Partitions"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001.partitions}]) as core_profile_service__1__ProfileEvent_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__headers {
#     view_label: "Core Profile Service 1 Profileevent V001: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001.headers}]) as core_profile_service__1__ProfileEvent_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001.payload}]) as core_profile_service__1__ProfileEvent_v001__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Subscriptions Current Transaction"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions.current_transaction}]) as core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__main_program {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Subscriptions Current Transaction Main Program"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction.main_program}]) as core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__main_program ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__main_program__roles_group {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Subscriptions Current Transaction Main Program Roles Group"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__main_program.roles_group}]) as core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__main_program__roles_group ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__new_program {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Subscriptions Current Transaction New Program"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction.new_program}]) as core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__new_program ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__new_program__roles_group {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Subscriptions Current Transaction New Program Roles Group"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__new_program.roles_group}]) as core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__new_program__roles_group ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__user_type {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Subscriptions Current Transaction User Type"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction.user_type}]) as core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions__current_transaction__user_type ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__email_preferences {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Email Preferences"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.email_preferences}]) as core_profile_service__1__ProfileEvent_v001__payload__email_preferences ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.phone}]) as core_profile_service__1__ProfileEvent_v001__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_status__shipping_address {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Status Shipping Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_status.shipping_address}]) as core_profile_service__1__ProfileEvent_v001__payload__account_status__shipping_address ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_status__billing_address {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Status Billing Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_status.billing_address}]) as core_profile_service__1__ProfileEvent_v001__payload__account_status__billing_address ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_status__payment_info {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Status Payment Info"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__account_status.payment_info}]) as core_profile_service__1__ProfileEvent_v001__payload__account_status__payment_info ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.identity}]) as core_profile_service__1__ProfileEvent_v001__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v001__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.email}]) as core_profile_service__1__ProfileEvent_v001__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v001__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload__address.home}]) as core_profile_service__1__ProfileEvent_v001__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Subscriptions"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.account_subscriptions}]) as core_profile_service__1__ProfileEvent_v001__payload__account_subscriptions ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__account_status {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Account Status"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.account_status}]) as core_profile_service__1__ProfileEvent_v001__payload__account_status ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v001__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V001: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v001__payload.address}]) as core_profile_service__1__ProfileEvent_v001__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v002 {
#   join: core_profile_service__1__ProfileEvent_v002__partitions {
#     view_label: "Core Profile Service 1 Profileevent V002: Partitions"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002.partitions}]) as core_profile_service__1__ProfileEvent_v002__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__headers {
#     view_label: "Core Profile Service 1 Profileevent V002: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002.headers}]) as core_profile_service__1__ProfileEvent_v002__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002.payload}]) as core_profile_service__1__ProfileEvent_v002__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002__payload.identity}]) as core_profile_service__1__ProfileEvent_v002__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v002__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002__payload.email}]) as core_profile_service__1__ProfileEvent_v002__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v002__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002__payload__address.home}]) as core_profile_service__1__ProfileEvent_v002__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002__payload.phone}]) as core_profile_service__1__ProfileEvent_v002__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v002__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V002: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v002__payload.address}]) as core_profile_service__1__ProfileEvent_v002__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v003 {
#   join: core_profile_service__1__ProfileEvent_v003__partitions {
#     view_label: "Core Profile Service 1 Profileevent V003: Partitions"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003.partitions}]) as core_profile_service__1__ProfileEvent_v003__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__headers {
#     view_label: "Core Profile Service 1 Profileevent V003: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003.headers}]) as core_profile_service__1__ProfileEvent_v003__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003.payload}]) as core_profile_service__1__ProfileEvent_v003__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003__payload.phone}]) as core_profile_service__1__ProfileEvent_v003__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003__payload.identity}]) as core_profile_service__1__ProfileEvent_v003__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v003__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003__payload.email}]) as core_profile_service__1__ProfileEvent_v003__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v003__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003__payload__address.home}]) as core_profile_service__1__ProfileEvent_v003__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v003__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V003: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v003__payload.address}]) as core_profile_service__1__ProfileEvent_v003__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v004 {
#   join: core_profile_service__1__ProfileEvent_v004__partitions {
#     view_label: "Core Profile Service 1 Profileevent V004: Partitions"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004.partitions}]) as core_profile_service__1__ProfileEvent_v004__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__headers {
#     view_label: "Core Profile Service 1 Profileevent V004: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004.headers}]) as core_profile_service__1__ProfileEvent_v004__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004.payload}]) as core_profile_service__1__ProfileEvent_v004__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004__payload.identity}]) as core_profile_service__1__ProfileEvent_v004__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v004__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004__payload.email}]) as core_profile_service__1__ProfileEvent_v004__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v004__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004__payload__address.home}]) as core_profile_service__1__ProfileEvent_v004__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004__payload.phone}]) as core_profile_service__1__ProfileEvent_v004__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v004__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V004: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v004__payload.address}]) as core_profile_service__1__ProfileEvent_v004__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v005 {
#   join: core_profile_service__1__ProfileEvent_v005__partitions {
#     view_label: "Core Profile Service 1 Profileevent V005: Partitions"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005.partitions}]) as core_profile_service__1__ProfileEvent_v005__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__headers {
#     view_label: "Core Profile Service 1 Profileevent V005: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005.headers}]) as core_profile_service__1__ProfileEvent_v005__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005.payload}]) as core_profile_service__1__ProfileEvent_v005__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005__payload.identity}]) as core_profile_service__1__ProfileEvent_v005__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v005__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005__payload.email}]) as core_profile_service__1__ProfileEvent_v005__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v005__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005__payload__address.home}]) as core_profile_service__1__ProfileEvent_v005__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005__payload.phone}]) as core_profile_service__1__ProfileEvent_v005__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v005__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V005: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v005__payload.address}]) as core_profile_service__1__ProfileEvent_v005__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v006 {
#   join: core_profile_service__1__ProfileEvent_v006__headers {
#     view_label: "Core Profile Service 1 Profileevent V006: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006.headers}]) as core_profile_service__1__ProfileEvent_v006__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006.payload}]) as core_profile_service__1__ProfileEvent_v006__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006__payload.phone}]) as core_profile_service__1__ProfileEvent_v006__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006__payload.identity}]) as core_profile_service__1__ProfileEvent_v006__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v006__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006__payload.email}]) as core_profile_service__1__ProfileEvent_v006__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v006__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006__payload__address.home}]) as core_profile_service__1__ProfileEvent_v006__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v006__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V006: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v006__payload.address}]) as core_profile_service__1__ProfileEvent_v006__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v007 {
#   join: core_profile_service__1__ProfileEvent_v007__headers {
#     view_label: "Core Profile Service 1 Profileevent V007: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007.headers}]) as core_profile_service__1__ProfileEvent_v007__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007.payload}]) as core_profile_service__1__ProfileEvent_v007__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007__payload.identity}]) as core_profile_service__1__ProfileEvent_v007__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v007__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007__payload.email}]) as core_profile_service__1__ProfileEvent_v007__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v007__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007__payload__address.home}]) as core_profile_service__1__ProfileEvent_v007__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007__payload.phone}]) as core_profile_service__1__ProfileEvent_v007__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v007__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V007: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v007__payload.address}]) as core_profile_service__1__ProfileEvent_v007__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v008 {
#   join: core_profile_service__1__ProfileEvent_v008__headers {
#     view_label: "Core Profile Service 1 Profileevent V008: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008.headers}]) as core_profile_service__1__ProfileEvent_v008__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008.payload}]) as core_profile_service__1__ProfileEvent_v008__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008__payload.identity}]) as core_profile_service__1__ProfileEvent_v008__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v008__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008__payload.email}]) as core_profile_service__1__ProfileEvent_v008__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v008__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008__payload__address.home}]) as core_profile_service__1__ProfileEvent_v008__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008__payload.phone}]) as core_profile_service__1__ProfileEvent_v008__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v008__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V008: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v008__payload.address}]) as core_profile_service__1__ProfileEvent_v008__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v009 {
#   join: core_profile_service__1__ProfileEvent_v009__headers {
#     view_label: "Core Profile Service 1 Profileevent V009: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009.headers}]) as core_profile_service__1__ProfileEvent_v009__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009.payload}]) as core_profile_service__1__ProfileEvent_v009__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009__payload.identity}]) as core_profile_service__1__ProfileEvent_v009__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v009__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009__payload.email}]) as core_profile_service__1__ProfileEvent_v009__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v009__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009__payload__address.home}]) as core_profile_service__1__ProfileEvent_v009__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009__payload.phone}]) as core_profile_service__1__ProfileEvent_v009__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v009__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V009: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v009__payload.address}]) as core_profile_service__1__ProfileEvent_v009__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v010 {
#   join: core_profile_service__1__ProfileEvent_v010__headers {
#     view_label: "Core Profile Service 1 Profileevent V010: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010.headers}]) as core_profile_service__1__ProfileEvent_v010__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010.payload}]) as core_profile_service__1__ProfileEvent_v010__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010__payload.identity}]) as core_profile_service__1__ProfileEvent_v010__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v010__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010__payload.email}]) as core_profile_service__1__ProfileEvent_v010__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v010__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010__payload__address.home}]) as core_profile_service__1__ProfileEvent_v010__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010__payload.phone}]) as core_profile_service__1__ProfileEvent_v010__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v010__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V010: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v010__payload.address}]) as core_profile_service__1__ProfileEvent_v010__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v011 {
#   join: core_profile_service__1__ProfileEvent_v011__headers {
#     view_label: "Core Profile Service 1 Profileevent V011: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011.headers}]) as core_profile_service__1__ProfileEvent_v011__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011.payload}]) as core_profile_service__1__ProfileEvent_v011__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011__payload.identity}]) as core_profile_service__1__ProfileEvent_v011__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v011__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011__payload.email}]) as core_profile_service__1__ProfileEvent_v011__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v011__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011__payload__address.home}]) as core_profile_service__1__ProfileEvent_v011__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011__payload.phone}]) as core_profile_service__1__ProfileEvent_v011__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v011__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V011: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v011__payload.address}]) as core_profile_service__1__ProfileEvent_v011__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v012 {
#   join: core_profile_service__1__ProfileEvent_v012__headers {
#     view_label: "Core Profile Service 1 Profileevent V012: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012.headers}]) as core_profile_service__1__ProfileEvent_v012__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012.payload}]) as core_profile_service__1__ProfileEvent_v012__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012__payload.identity}]) as core_profile_service__1__ProfileEvent_v012__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v012__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012__payload.email}]) as core_profile_service__1__ProfileEvent_v012__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v012__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012__payload__address.home}]) as core_profile_service__1__ProfileEvent_v012__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012__payload.phone}]) as core_profile_service__1__ProfileEvent_v012__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v012__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V012: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v012__payload.address}]) as core_profile_service__1__ProfileEvent_v012__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v013 {
#   join: core_profile_service__1__ProfileEvent_v013__headers {
#     view_label: "Core Profile Service 1 Profileevent V013: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013.headers}]) as core_profile_service__1__ProfileEvent_v013__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013.payload}]) as core_profile_service__1__ProfileEvent_v013__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013__payload.identity}]) as core_profile_service__1__ProfileEvent_v013__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v013__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013__payload.email}]) as core_profile_service__1__ProfileEvent_v013__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v013__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013__payload__address.home}]) as core_profile_service__1__ProfileEvent_v013__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013__payload.phone}]) as core_profile_service__1__ProfileEvent_v013__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v013__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V013: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v013__payload.address}]) as core_profile_service__1__ProfileEvent_v013__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v014 {
#   join: core_profile_service__1__ProfileEvent_v014__headers {
#     view_label: "Core Profile Service 1 Profileevent V014: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014.headers}]) as core_profile_service__1__ProfileEvent_v014__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014.payload}]) as core_profile_service__1__ProfileEvent_v014__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014__payload.identity}]) as core_profile_service__1__ProfileEvent_v014__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v014__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014__payload.email}]) as core_profile_service__1__ProfileEvent_v014__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v014__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014__payload__address.home}]) as core_profile_service__1__ProfileEvent_v014__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014__payload.phone}]) as core_profile_service__1__ProfileEvent_v014__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v014__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V014: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v014__payload.address}]) as core_profile_service__1__ProfileEvent_v014__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v015 {
#   join: core_profile_service__1__ProfileEvent_v015__headers {
#     view_label: "Core Profile Service 1 Profileevent V015: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015.headers}]) as core_profile_service__1__ProfileEvent_v015__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015.payload}]) as core_profile_service__1__ProfileEvent_v015__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015__payload.identity}]) as core_profile_service__1__ProfileEvent_v015__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v015__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015__payload.email}]) as core_profile_service__1__ProfileEvent_v015__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v015__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015__payload__address.home}]) as core_profile_service__1__ProfileEvent_v015__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015__payload.phone}]) as core_profile_service__1__ProfileEvent_v015__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v015__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V015: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v015__payload.address}]) as core_profile_service__1__ProfileEvent_v015__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v016 {
#   join: core_profile_service__1__ProfileEvent_v016__headers {
#     view_label: "Core Profile Service 1 Profileevent V016: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016.headers}]) as core_profile_service__1__ProfileEvent_v016__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016.payload}]) as core_profile_service__1__ProfileEvent_v016__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016__payload.identity}]) as core_profile_service__1__ProfileEvent_v016__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v016__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016__payload.email}]) as core_profile_service__1__ProfileEvent_v016__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v016__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016__payload__address.home}]) as core_profile_service__1__ProfileEvent_v016__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016__payload.phone}]) as core_profile_service__1__ProfileEvent_v016__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v016__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V016: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v016__payload.address}]) as core_profile_service__1__ProfileEvent_v016__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v017 {
#   join: core_profile_service__1__ProfileEvent_v017__headers {
#     view_label: "Core Profile Service 1 Profileevent V017: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017.headers}]) as core_profile_service__1__ProfileEvent_v017__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017.payload}]) as core_profile_service__1__ProfileEvent_v017__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017__payload.identity}]) as core_profile_service__1__ProfileEvent_v017__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v017__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017__payload.email}]) as core_profile_service__1__ProfileEvent_v017__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v017__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017__payload__address.home}]) as core_profile_service__1__ProfileEvent_v017__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017__payload.phone}]) as core_profile_service__1__ProfileEvent_v017__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v017__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V017: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v017__payload.address}]) as core_profile_service__1__ProfileEvent_v017__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v018 {
#   join: core_profile_service__1__ProfileEvent_v018__headers {
#     view_label: "Core Profile Service 1 Profileevent V018: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018.headers}]) as core_profile_service__1__ProfileEvent_v018__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018.payload}]) as core_profile_service__1__ProfileEvent_v018__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018__payload.identity}]) as core_profile_service__1__ProfileEvent_v018__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v018__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018__payload.email}]) as core_profile_service__1__ProfileEvent_v018__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v018__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018__payload__address.home}]) as core_profile_service__1__ProfileEvent_v018__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018__payload.phone}]) as core_profile_service__1__ProfileEvent_v018__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v018__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V018: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v018__payload.address}]) as core_profile_service__1__ProfileEvent_v018__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v019 {
#   join: core_profile_service__1__ProfileEvent_v019__headers {
#     view_label: "Core Profile Service 1 Profileevent V019: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019.headers}]) as core_profile_service__1__ProfileEvent_v019__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019.payload}]) as core_profile_service__1__ProfileEvent_v019__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019__payload.identity}]) as core_profile_service__1__ProfileEvent_v019__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v019__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019__payload.email}]) as core_profile_service__1__ProfileEvent_v019__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v019__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019__payload__address.home}]) as core_profile_service__1__ProfileEvent_v019__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019__payload.phone}]) as core_profile_service__1__ProfileEvent_v019__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v019__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V019: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v019__payload.address}]) as core_profile_service__1__ProfileEvent_v019__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_profile_service__1__profile_event_v020 {
#   join: core_profile_service__1__ProfileEvent_v020__partitions {
#     view_label: "Core Profile Service 1 Profileevent V020: Partitions"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020.partitions}]) as core_profile_service__1__ProfileEvent_v020__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__headers {
#     view_label: "Core Profile Service 1 Profileevent V020: Headers"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020.headers}]) as core_profile_service__1__ProfileEvent_v020__headers ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020.payload}]) as core_profile_service__1__ProfileEvent_v020__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload__identity {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload Identity"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020__payload.identity}]) as core_profile_service__1__ProfileEvent_v020__payload__identity ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload__additional_settings {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload Additional Settings"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020__payload.additional_settings}]) as core_profile_service__1__ProfileEvent_v020__payload__additional_settings ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload__email {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload Email"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020__payload.email}]) as core_profile_service__1__ProfileEvent_v020__payload__email ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload__address__shipping {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload Address Shipping"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020__payload__address.shipping}]) as core_profile_service__1__ProfileEvent_v020__payload__address__shipping ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload__address__home {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload Address Home"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020__payload__address.home}]) as core_profile_service__1__ProfileEvent_v020__payload__address__home ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload__phone {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload Phone"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020__payload.phone}]) as core_profile_service__1__ProfileEvent_v020__payload__phone ;;
#     relationship: one_to_one
#   }
#
#   join: core_profile_service__1__ProfileEvent_v020__payload__address {
#     view_label: "Core Profile Service 1 Profileevent V020: Payload Address"
#     sql: LEFT JOIN UNNEST([${core_profile_service__1__ProfileEvent_v020__payload.address}]) as core_profile_service__1__ProfileEvent_v020__payload__address ;;
#     relationship: one_to_one
#   }
# }
#
# explore: core_search_service__1__search_analytics_v001 {
#   join: core_search_service__1__searchAnalytics_v001__partitions {
#     view_label: "Core Search Service 1 Searchanalytics V001: Partitions"
#     sql: LEFT JOIN UNNEST([${core_search_service__1__searchAnalytics_v001.partitions}]) as core_search_service__1__searchAnalytics_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_search_service__1__searchAnalytics_v001__payload {
#     view_label: "Core Search Service 1 Searchanalytics V001: Payload"
#     sql: LEFT JOIN UNNEST([${core_search_service__1__searchAnalytics_v001.payload}]) as core_search_service__1__searchAnalytics_v001__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_search_service__1__searchAnalytics_v001__payload__browsed_details {
#     view_label: "Core Search Service 1 Searchanalytics V001: Payload Browsed Details"
#     sql: LEFT JOIN UNNEST(${core_search_service__1__searchAnalytics_v001__payload.browsed_details}) as core_search_service__1__searchAnalytics_v001__payload__browsed_details ;;
#     relationship: one_to_many
#   }
#
#   join: core_search_service__1__searchAnalytics_v001__payload__tracked_details {
#     view_label: "Core Search Service 1 Searchanalytics V001: Payload Tracked Details"
#     sql: LEFT JOIN UNNEST(${core_search_service__1__searchAnalytics_v001__payload.tracked_details}) as core_search_service__1__searchAnalytics_v001__payload__tracked_details ;;
#     relationship: one_to_many
#   }
# }
#
# explore: core_search_service__1__search_analytics_v002 {
#   join: core_search_service__1__searchAnalytics_v002__partitions {
#     view_label: "Core Search Service 1 Searchanalytics V002: Partitions"
#     sql: LEFT JOIN UNNEST([${core_search_service__1__searchAnalytics_v002.partitions}]) as core_search_service__1__searchAnalytics_v002__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: core_search_service__1__searchAnalytics_v002__payload {
#     view_label: "Core Search Service 1 Searchanalytics V002: Payload"
#     sql: LEFT JOIN UNNEST([${core_search_service__1__searchAnalytics_v002.payload}]) as core_search_service__1__searchAnalytics_v002__payload ;;
#     relationship: one_to_one
#   }
#
#   join: core_search_service__1__searchAnalytics_v002__payload__browsed_details {
#     view_label: "Core Search Service 1 Searchanalytics V002: Payload Browsed Details"
#     sql: LEFT JOIN UNNEST(${core_search_service__1__searchAnalytics_v002__payload.browsed_details}) as core_search_service__1__searchAnalytics_v002__payload__browsed_details ;;
#     relationship: one_to_many
#   }
#
#   join: core_search_service__1__searchAnalytics_v002__payload__tracked_details {
#     view_label: "Core Search Service 1 Searchanalytics V002: Payload Tracked Details"
#     sql: LEFT JOIN UNNEST(${core_search_service__1__searchAnalytics_v002__payload.tracked_details}) as core_search_service__1__searchAnalytics_v002__payload__tracked_details ;;
#     relationship: one_to_many
#   }
# }
#
# explore: dotcom__1__member_affiliate_tracking_v001 {
#   join: dotcom__1__MEMBER_AFFILIATE_TRACKING_v001__partitions {
#     view_label: "Dotcom 1 Member Affiliate Tracking V001: Partitions"
#     sql: LEFT JOIN UNNEST([${dotcom__1__MEMBER_AFFILIATE_TRACKING_v001.partitions}]) as dotcom__1__MEMBER_AFFILIATE_TRACKING_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__1__MEMBER_AFFILIATE_TRACKING_v001__headers {
#     view_label: "Dotcom 1 Member Affiliate Tracking V001: Headers"
#     sql: LEFT JOIN UNNEST([${dotcom__1__MEMBER_AFFILIATE_TRACKING_v001.headers}]) as dotcom__1__MEMBER_AFFILIATE_TRACKING_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__1__MEMBER_AFFILIATE_TRACKING_v001__payload {
#     view_label: "Dotcom 1 Member Affiliate Tracking V001: Payload"
#     sql: LEFT JOIN UNNEST([${dotcom__1__MEMBER_AFFILIATE_TRACKING_v001.payload}]) as dotcom__1__MEMBER_AFFILIATE_TRACKING_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: dotcom__1__member_program_v001 {
#   join: dotcom__1__MEMBER_PROGRAM_v001__partitions {
#     view_label: "Dotcom 1 Member Program V001: Partitions"
#     sql: LEFT JOIN UNNEST([${dotcom__1__MEMBER_PROGRAM_v001.partitions}]) as dotcom__1__MEMBER_PROGRAM_v001__partitions ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__1__MEMBER_PROGRAM_v001__headers {
#     view_label: "Dotcom 1 Member Program V001: Headers"
#     sql: LEFT JOIN UNNEST([${dotcom__1__MEMBER_PROGRAM_v001.headers}]) as dotcom__1__MEMBER_PROGRAM_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__1__MEMBER_PROGRAM_v001__payload {
#     view_label: "Dotcom 1 Member Program V001: Payload"
#     sql: LEFT JOIN UNNEST([${dotcom__1__MEMBER_PROGRAM_v001.payload}]) as dotcom__1__MEMBER_PROGRAM_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: dotcom__member_enrollment__1_v001 {
#   join: dotcom__MEMBER_ENROLLMENT__1_v001__headers {
#     view_label: "Dotcom Member Enrollment 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_ENROLLMENT__1_v001.headers}]) as dotcom__MEMBER_ENROLLMENT__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__MEMBER_ENROLLMENT__1_v001__payload {
#     view_label: "Dotcom Member Enrollment 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_ENROLLMENT__1_v001.payload}]) as dotcom__MEMBER_ENROLLMENT__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: dotcom__member_enrollment__1_v002 {
#   join: dotcom__MEMBER_ENROLLMENT__1_v002__headers {
#     view_label: "Dotcom Member Enrollment 1 V002: Headers"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_ENROLLMENT__1_v002.headers}]) as dotcom__MEMBER_ENROLLMENT__1_v002__headers ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__MEMBER_ENROLLMENT__1_v002__payload {
#     view_label: "Dotcom Member Enrollment 1 V002: Payload"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_ENROLLMENT__1_v002.payload}]) as dotcom__MEMBER_ENROLLMENT__1_v002__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: dotcom__member_enrollment__1_v003 {
#   join: dotcom__MEMBER_ENROLLMENT__1_v003__headers {
#     view_label: "Dotcom Member Enrollment 1 V003: Headers"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_ENROLLMENT__1_v003.headers}]) as dotcom__MEMBER_ENROLLMENT__1_v003__headers ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__MEMBER_ENROLLMENT__1_v003__payload {
#     view_label: "Dotcom Member Enrollment 1 V003: Payload"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_ENROLLMENT__1_v003.payload}]) as dotcom__MEMBER_ENROLLMENT__1_v003__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: dotcom__member_uuid_map__1_v001 {
#   join: dotcom__MEMBER_UUID_MAP__1_v001__headers {
#     view_label: "Dotcom Member Uuid Map 1 V001: Headers"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_UUID_MAP__1_v001.headers}]) as dotcom__MEMBER_UUID_MAP__1_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: dotcom__MEMBER_UUID_MAP__1_v001__payload {
#     view_label: "Dotcom Member Uuid Map 1 V001: Payload"
#     sql: LEFT JOIN UNNEST([${dotcom__MEMBER_UUID_MAP__1_v001.payload}]) as dotcom__MEMBER_UUID_MAP__1_v001__payload ;;
#     relationship: one_to_one
#   }
# }
#
# explore: lineage {
#   join: lineage__partitions {
#     view_label: "Lineage: Partitions"
#     sql: LEFT JOIN UNNEST([${lineage.partitions}]) as lineage__partitions ;;
#     relationship: one_to_one
#   }
# }
#
# explore: meeting_finder_upload__1__get_locations_v001 {
#   join: meeting_finder_upload__1__getLocations_v001__headers {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Headers"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001.headers}]) as meeting_finder_upload__1__getLocations_v001__headers ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001.payload}]) as meeting_finder_upload__1__getLocations_v001__payload ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__open_hours {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Open Hours"
#     sql: LEFT JOIN UNNEST(${meeting_finder_upload__1__getLocations_v001__payload.open_hours}) as meeting_finder_upload__1__getLocations_v001__payload__open_hours ;;
#     relationship: one_to_many
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__open_hours__meeting_day {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Open Hours Meeting Day"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001__payload__open_hours.meeting_day}]) as meeting_finder_upload__1__getLocations_v001__payload__open_hours__meeting_day ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__address {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Address"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001__payload.address}]) as meeting_finder_upload__1__getLocations_v001__payload__address ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__address___geoloc {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Address Geoloc"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001__payload__address._geoloc}]) as meeting_finder_upload__1__getLocations_v001__payload__address___geoloc ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__meetings {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Meetings"
#     sql: LEFT JOIN UNNEST(${meeting_finder_upload__1__getLocations_v001__payload.meetings}) as meeting_finder_upload__1__getLocations_v001__payload__meetings ;;
#     relationship: one_to_many
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__meetings__meeting_leader {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Meetings Meeting Leader"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001__payload__meetings.meeting_leader}]) as meeting_finder_upload__1__getLocations_v001__payload__meetings__meeting_leader ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__meetings__meeting_day {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Meetings Meeting Day"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001__payload__meetings.meeting_day}]) as meeting_finder_upload__1__getLocations_v001__payload__meetings__meeting_day ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__meetings__meeting_type {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Meetings Meeting Type"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001__payload__meetings.meeting_type}]) as meeting_finder_upload__1__getLocations_v001__payload__meetings__meeting_type ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v001__payload__price_zone {
#     view_label: "Meeting Finder Upload 1 Getlocations V001: Payload Price Zone"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v001__payload.price_zone}]) as meeting_finder_upload__1__getLocations_v001__payload__price_zone ;;
#     relationship: one_to_one
#   }
# }
#
# explore: meeting_finder_upload__1__get_locations_v002 {
#   join: meeting_finder_upload__1__getLocations_v002__headers {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Headers"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002.headers}]) as meeting_finder_upload__1__getLocations_v002__headers ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002.payload}]) as meeting_finder_upload__1__getLocations_v002__payload ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__open_hours {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Open Hours"
#     sql: LEFT JOIN UNNEST(${meeting_finder_upload__1__getLocations_v002__payload.open_hours}) as meeting_finder_upload__1__getLocations_v002__payload__open_hours ;;
#     relationship: one_to_many
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__open_hours__meeting_day {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Open Hours Meeting Day"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002__payload__open_hours.meeting_day}]) as meeting_finder_upload__1__getLocations_v002__payload__open_hours__meeting_day ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__address {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Address"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002__payload.address}]) as meeting_finder_upload__1__getLocations_v002__payload__address ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__address___geoloc {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Address Geoloc"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002__payload__address._geoloc}]) as meeting_finder_upload__1__getLocations_v002__payload__address___geoloc ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__meetings {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Meetings"
#     sql: LEFT JOIN UNNEST(${meeting_finder_upload__1__getLocations_v002__payload.meetings}) as meeting_finder_upload__1__getLocations_v002__payload__meetings ;;
#     relationship: one_to_many
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_leader {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Meetings Meeting Leader"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002__payload__meetings.meeting_leader}]) as meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_leader ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_leader__profile_items {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Meetings Meeting Leader Profile Items"
#     sql: LEFT JOIN UNNEST(${meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_leader.profile_items}) as meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_leader__profile_items ;;
#     relationship: one_to_many
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_day {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Meetings Meeting Day"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002__payload__meetings.meeting_day}]) as meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_day ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_type {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Meetings Meeting Type"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002__payload__meetings.meeting_type}]) as meeting_finder_upload__1__getLocations_v002__payload__meetings__meeting_type ;;
#     relationship: one_to_one
#   }
#
#   join: meeting_finder_upload__1__getLocations_v002__payload__price_zone {
#     view_label: "Meeting Finder Upload 1 Getlocations V002: Payload Price Zone"
#     sql: LEFT JOIN UNNEST([${meeting_finder_upload__1__getLocations_v002__payload.price_zone}]) as meeting_finder_upload__1__getLocations_v002__payload__price_zone ;;
#     relationship: one_to_one
#   }
# }
