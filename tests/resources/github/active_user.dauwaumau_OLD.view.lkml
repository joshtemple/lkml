# this view used to create the DAU/WAU/MAU views using liquid variables and one base AU view, however looker stopped supporting liquid variable usage in PDTs
# that use data_group trigger (april 2020), so the current version of active_user.dauwaumau builds each view explicitly without liquid variables
#
# view: active_users_platforms {
#
#   view_label: "User Counts"
#
#   parameter: offset {
#     description: "Offset (days/weeks/months depending on metric) to use when comparing vs prior year, can be positive to move prior year values forwards or negative to shift prior year backwards"
#     type: number
#     default_value: "0"
#   }
#
#   derived_table: {
#     sql:  SELECT DISTINCT COALESCE(productplatform, 'UNKNOWN') as product_platform
#       FROM ${guid_platform_date_active.SQL_TABLE_NAME} ;;
#   }
#
#   dimension: product_platform {
#     label: "Product Platform"
#     hidden: yes
#   }
#
#   dimension: product_platform_clean {
#     sql: CASE
#           WHEN ${product_platform} ILIKE 'cnow' THEN 'CNOW'
#           WHEN ${product_platform} ILIKE 'aplia' THEN 'Aplia'
#           WHEN ${product_platform} = 'imilac'  THEN 'IMILAC'
#           WHEN ${product_platform} = 'q4'  THEN 'Q4'
#           WHEN ${product_platform} ILIKE '%dashboard%' THEN 'CU Dashboard'
#           WHEN ${product_platform} ILIKE 'mobile-app' THEN 'Mobile'
#           WHEN ${product_platform} ILIKE '%gradebook%' THEN 'MindTap - Gradebook'
#           WHEN ${product_platform} ILIKE 'mindtap' OR ${product_platform} ILIKE 'mt%' THEN 'MindTap'
#           WHEN ${product_platform} ILIKE '%side-bar%'  OR ${product_platform} ILIKE '%sidebar%' THEN 'CU Sidebar'
#           WHEN ${product_platform} ILIKE 'WA' OR ${product_platform} ILIKE 'webassign' THEN 'WebAssign'
#           WHEN ${product_platform} ILIKE 'natgeo%' THEN 'National Geographic'
#           WHEN ${product_platform} ILIKE 'ecomm%'  THEN 'Ecommerce'
#           WHEN ${product_platform} ='LO' OR ${product_platform} = 'LO-OPENNOW' THEN 'Learning Objects'
#
#         ELSE ${product_platform} END
#
#     ;;
#     label: "Product Platform"
#     group_label: "Active Users"
#   }
#
# }
#
#
#
# view: dau {
#   extends: [au]
#
#   parameter: days {default_value: "1"}
#   parameter: view_name {default_value: "dau"}
#
#
#   measure: dau {
#     group_label: "Active Users"
#     label: "DAU"
#     description: "Users with an event in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: dau_instructor {
#     group_label: "Active Users"
#     label: "DAU Instructor"
#     description: "Instructors with an event in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: dau_students {
#     group_label: "Active Users"
#     label: "DAU Students"
#     description: "Students with an event in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_students}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: dau_paid_active_users {
#     group_label: "Active Users"
#     label: "DAU Paid"
#     description: "Paid users with an event in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_paid_active_users}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: dau_active_course_instructors {
#     group_label: "Active Users"
#     label: "DAU Instructor (Active Course)"
#     description: "Instructors (with an active course) with an event in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_active_course_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
# }
#
# view: wau {
#   extends: [au]
#
#   parameter: days {default_value: "7"}
#   parameter: view_name {default_value: "wau"}
#
#
#   measure: wau {
#     group_label: "Active Users"
#     label: "WAU"
#     description: "Users with an event in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: wau_instructors {
#     group_label: "Active Users"
#     label: "WAU Instructors"
#     description: "Instructors with an event in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: wau_students {
#     group_label: "Active Users"
#     label: "WAU Students"
#     description: "Students with an event in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_students}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: wau_paid_active_users {
#     group_label: "Active Users"
#     label: "WAU Paid"
#     description: "Paid Users with an event in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_paid_active_users}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: wau_active_course_instructors {
#     group_label: "Active Users"
#     label: "WAU Instructor (Active Course)"
#     description: "Instructors (with an active course) with an event in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_active_course_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
# }
#
# view: mau {
#   extends: [au]
#
#   parameter: days {default_value: "30"}
#   parameter: view_name {default_value: "mau"}
#
#   measure: mau {
#     group_label: "Active Users"
#     label: "MAU"
#     description: "Users with an event in the last 30 days, relative to the filtered date  (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: mau_instructors {
#     group_label: "Active Users"
#     label: "MAU Instructors"
#     description: "Instructors with an event in the last 30 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: mau_students {
#     group_label: "Active Users"
#     label: "MAU Students"
#     description: "Students with an event in the last 30 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_students}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: mau_paid_active_users {
#     group_label: "Active Users"
#     label: "MAU Paid"
#     description: "Paid Users with an event in the last 30 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_paid_active_users}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: mau_active_course_instructors {
#     group_label: "Active Users"
#     label: "MAU Instructor (Active Course)"
#     description: "Instructors (with an active course) with an event in the last 30 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${au_active_course_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
# }
#
# view: dru {
#   extends: [ru]
#
#   parameter: days {default_value: "1"}
#   parameter: view_name {default_value: "dru"}
#
#   measure: dru {
#     group_label: "Registered Users"
#     label: "DRU"
#     description: "Users with an event or change to their user profile in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: dru_instructors {
#     group_label: "Registered Users"
#     label: "DRU Instructors"
#     description: "Instructors with an event or change to their user profile in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: dru_students {
#     group_label: "Registered Users"
#     label: "DRU Students"
#     description: "Students with an event or change to their user profile in the last 1 day, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_students}) ;;
#     value_format_name: decimal_0
#   }
#
# }
#
#
# view: wru {
#   extends: [ru]
#
#   parameter: days {default_value: "7"}
#   parameter: view_name {default_value: "wru"}
#
#   measure: wru {
#     group_label: "Registered Users"
#     label: "WRU"
#     description: "Users with an event or change to their user profile in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: wru_instructors {
#     group_label: "Registered Users"
#     label: "WRU Instructors"
#     description: "Instructors with an event or change to their user profile in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: wru_students {
#     group_label: "Registered Users"
#     label: "WRU Students"
#     description: "Students with an event or change to their user profile in the last 7 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_students}) ;;
#     value_format_name: decimal_0
#   }
#
# }
#
# view: mru {
#   extends: [ru]
#
#   parameter: days {default_value: "30"}
#   parameter: view_name {default_value: "mru"}
#
#   measure: mru {
#     group_label: "Registered Users"
#     label: "MRU"
#     description: "Users with an event or change to their user profile in the last 30 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: mru_instructors {
#     group_label: "Registered Users"
#     label: "MRU Instructors"
#     description: "Instructors with an event or change to their user profile in the last 30 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: mru_students {
#     group_label: "Registered Users"
#     label: "MRU Students"
#     description: "Students with an event or change to their user profile in the last 30 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_students}) ;;
#     value_format_name: decimal_0
#   }
#
# }
#
#
# view: yru {
#   extends: [ru]
#
#   parameter: days {default_value: "365"}
#   parameter: view_name {default_value: "yru"}
#
#   measure: yru {
#     group_label: "Registered Users"
#     label: "YRU"
#     description: "Users with an event or change to their user profile in the last 365 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: yru_instructors {
#     group_label: "Registered Users"
#     label: "YRU Instructors"
#     description: "Instructors with an event or change to their user profile in the last 365 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_instructors}) ;;
#     value_format_name: decimal_0
#   }
#
#   measure: yru_students {
#     group_label: "Registered Users"
#     label: "YRU Students"
#     description: "Students with an event or change to their user profile in the last 365 days, relative to the filtered date (average if not reported on a single day)"
#     type: number
#     sql: AVG(${ru_students}) ;;
#     value_format_name: decimal_0
#   }
# }
#
#
# view: au {
#   extension: required
#
#   view_label: "User Activity Counts"
#
#   parameter: days {
#     type: unquoted
#     default_value: "0"
#     hidden: yes
#     # how many days to include in the calculation (weekly users would be 7)
#   }
#
#   parameter: view_name {
#     type: unquoted
#     default_value: ""
#     hidden: yes
#     # name of view, as using _view_name raises an error
#   }
#
#   derived_table: {
#     create_process: {
#       sql_step:
#         CREATE TABLE IF NOT EXISTS LOOKER_SCRATCH.{{ view_name._parameter_value }}
#         (
#           date DATE
#           ,product_platform STRING
#           ,users INT
#           ,instructors INT
#           ,students INT
#           ,active_course_instructors INT
#           ,paid_active_users INT
#           ,paid_inactive_users INT
#           ,total_users INT
#           ,total_instructors INT
#           ,total_students INT
#           ,total_active_course_instructors INT
#           ,total_paid_active_users INT
#           ,total_paid_inactive_users INT
#         )
#       ;;
#       sql_step:
#         CREATE OR REPLACE TEMPORARY TABLE looker_scratch.{{ view_name._parameter_value }}_incremental
#         AS
#         WITH dates AS (
#           SELECT d.datevalue
#           FROM ${dim_date.SQL_TABLE_NAME} d
#           WHERE d.datevalue > (SELECT COALESCE(MAX(date), '2018-08-01') FROM LOOKER_SCRATCH.{{ view_name._parameter_value }})
#           AND d.datevalue > (SELECT MIN(date) FROM ${guid_platform_date_active.SQL_TABLE_NAME})
#           AND d.datevalue < CURRENT_DATE()
#         )
#         ,paid AS (
#         SELECT p.*
#         FROM dates d
#         INNER JOIN ${guid_date_paid.SQL_TABLE_NAME} p ON d.datevalue = p.date
#         )
#         ,active_course_instructors AS (
#         SELECT c.date, c.user_sso_guid
#         FROM dates d
#         INNER JOIN ${guid_date_course.SQL_TABLE_NAME} c ON d.datevalue = c.date AND c.user_type = 'Instructor'
#         )
#         ,active AS (
#         SELECT *
#         FROM ${guid_platform_date_active.SQL_TABLE_NAME} g
#         WHERE g.date BETWEEN DATEADD(DAY, -{{ days._parameter_value }}, (SELECT MIN(datevalue) FROM dates)) AND (SELECT MAX(datevalue) FROM dates)
#         )
#         ,users AS (
#         SELECT user_sso_guid
#         FROM paid
#         UNION
#         SELECT user_sso_guid
#         FROM active
#         )
#         SELECT
#             d.datevalue AS date
#             ,COALESCE(au.productplatform, 'UNKNOWN') as product_platform
#             ,COUNT(DISTINCT CASE WHEN instructor THEN au.user_sso_guid END) AS instructors
#             ,COUNT(DISTINCT CASE WHEN NOT instructor OR instructor IS NULL THEN au.user_sso_guid END) AS students
#             ,COUNT(DISTINCT au.user_sso_guid) AS users
#             ,COUNT(DISTINCT CASE WHEN instructor AND c.user_sso_guid IS NOT NULL THEN au.user_sso_guid END) AS active_course_instructors
#             ,COUNT(DISTINCT CASE WHEN paid_flag THEN au.user_sso_guid END) AS paid_active_users
#             ,COUNT(DISTINCT CASE WHEN (paid_flag AND au.user_sso_guid IS NULL) THEN p.user_sso_guid END) AS paid_inactive_users
#         FROM dates d
#         CROSS JOIN users u
#         LEFT JOIN active AS au ON u.user_sso_guid = au.user_sso_guid
#           AND au.date <= d.datevalue
#           AND au.date > DATEADD(DAY, -{{ days._parameter_value }}, d.datevalue)
#         LEFT JOIN paid p on d.datevalue = p.date AND u.user_sso_guid = p.user_sso_guid
#         LEFT JOIN active_course_instructors c ON d.datevalue = c.date AND u.user_sso_guid = c.user_sso_guid
#         GROUP BY 1, ROLLUP(2)
#         ;;
#       sql_step:
#       INSERT INTO LOOKER_SCRATCH.{{ view_name._parameter_value }}
#       SELECT date, product_platform, users, instructors, students, active_course_instructors, paid_active_users, paid_inactive_users, NULL, NULL, NULL, NULL, NULL, NULL
#       FROM looker_scratch.{{ view_name._parameter_value }}_incremental
#       WHERE product_platform != 'UNKNOWN';;
#       sql_step:
#         MERGE INTO LOOKER_SCRATCH.{{ view_name._parameter_value }} a
#         USING looker_scratch.{{ view_name._parameter_value }}_incremental t ON a.date = t.date AND t.product_platform IS NULL --join to the result of the ROLLUP function i.e. total for all platforms
#         WHEN MATCHED THEN UPDATE
#           SET a.total_users = t.users
#             ,a.total_instructors = t.instructors
#             ,a.total_students = t.students
#             ,a.total_active_course_instructors = t.active_course_instructors
#             ,a.total_paid_active_users = t.paid_active_users
#             ,a.total_paid_inactive_users = t.paid_inactive_users
#       ;;
#       sql_step:
#       CREATE OR REPLACE TABLE ${SQL_TABLE_NAME}
#       CLONE LOOKER_SCRATCH.{{ view_name._parameter_value }};;
#
#       }
# #       datagroup_trigger: daily_refresh
#       persist_for: "2 hours"
#     }
#
#
#
#     dimension: pk {
#       primary_key: yes
#       sql: hash(date, product_platform) ;;
#       hidden: yes
#     }
#
#     dimension: date {
#       hidden: yes
#       type: date
#     }
#
#     dimension: max_date {
#       hidden: yes
#       type: date
#       sql: (SELECT MAX(date) FROM LOOKER_SCRATCH.{{ view_name._parameter_value }});;
#     }
#
#
#     dimension: product_platform {
#       hidden: yes
#       label: "Product Platform"
#     }
#
#     dimension: au {
#       hidden: yes
#       label: "Active Users"
#       type: number
#       sql:
#       {% if active_users_platforms.product_platform._in_query or active_users_platforms.product_platform_clean._in_query %}
#         {{ _view._name }}.users
#       {% else %}
#         {{ _view._name }}.total_users
#       {% endif %}
#       ;;
#     }
#
#     dimension: au_instructors {
#       hidden: yes
#       label: "Active Instructors"
#       type: number
#       sql:
#       {% if active_users_platforms.product_platform._in_query %}
#         {{ _view._name }}.instructors
#       {% else %}
#         {{ _view._name }}.total_instructors
#       {% endif %}
#       ;;
#     }
#
#     dimension: au_students {
#       hidden: yes
#       label: "Active Students"
#       type: number
#       sql:
#       {% if active_users_platforms.product_platform._in_query %}
#         {{ _view._name }}.students
#       {% else %}
#         {{ _view._name }}.total_students
#       {% endif %}
#       ;;
#     }
#
#     dimension: au_paid_active_users {
#       hidden: yes
#       label: "Paid Active Users"
#       type: number
#       sql:
#       {% if active_users_platforms.product_platform._in_query %}
#         {{ _view._name }}.paid_active_users
#       {% else %}
#         {{ _view._name }}.total_paid_active_users
#       {% endif %}
#       ;;
#     }
#
#     dimension: au_active_course_instructors {
#       hidden: yes
#       label: "Active Instructors (Current Course)"
#       type: number
#       sql:
#       {% if active_users_platforms.product_platform._in_query %}
#         {{ _view._name }}.active_course_instructors
#       {% else %}
#         {{ _view._name }}.total_active_course_instructors
#       {% endif %}
#       ;;
#     }
#   }
#
#
# view: ru {
#   extension: required
#
#   view_label: "Registered Users"
#
#   parameter: days {
#     type: unquoted
#     default_value: "0"
#     hidden: yes
#     # how many days to include in the calculation (weekly users would be 7)
#   }
#
#   parameter: view_name {
#     type: unquoted
#     default_value: ""
#     hidden: yes
#     # name of view, as using _view_name raises an error
#   }
#
#   derived_table: {
#     create_process: {
#       sql_step:
#         CREATE TABLE IF NOT EXISTS LOOKER_SCRATCH.{{ view_name._parameter_value }}
#         (
#           date DATE
#           ,users INT
#           ,instructors INT
#           ,students INT
#         )
#       ;;
#       sql_step:
#         CREATE OR REPLACE TEMPORARY TABLE looker_scratch.{{ view_name._parameter_value }}_incremental
#         AS
#         WITH dates AS (
#           SELECT d.datevalue
#           FROM ${dim_date.SQL_TABLE_NAME} d
#           WHERE d.datevalue > (SELECT COALESCE(MAX(date), '2018-08-01') FROM LOOKER_SCRATCH.{{ view_name._parameter_value }})
#           AND d.datevalue < CURRENT_DATE()
#         )
#         ,distinct_primary AS (
#           SELECT DISTINCT primary_guid FROM prod.unlimited.vw_partner_to_primary_user_guid
#         )
#         ,all_events_merged AS (
#           SELECT DISTINCT e.user_sso_guid AS merged_guid, u.instructor, e.date as event_time
#           FROM ${guid_platform_date_active.SQL_TABLE_NAME} e
#           LEFT JOIN ${merged_cu_user_info.SQL_TABLE_NAME} u ON e.user_sso_guid = u.user_sso_guid
#         )
#         ,first_mutation AS (
#           SELECT DISTINCT COALESCE(m.primary_guid, e.linked_guid) AS merged_guid, u.instructor, e.rsrc_timestamp::date AS event_time
#           FROM prod.datavault.sat_user e
#           LEFT JOIN prod.unlimited.vw_partner_to_primary_user_guid m ON e.linked_guid = m.partner_guid
#           LEFT JOIN ${merged_cu_user_info.SQL_TABLE_NAME} u ON COALESCE(m.primary_guid, e.linked_guid) = u.user_sso_guid
#           WHERE merged_guid IS NOT NULL
#           AND event_time NOT IN ('2018-08-03','2019-08-22')
#         )
#         ,users AS (
#         SELECT *
#         FROM all_events_merged
#         UNION
#         SELECT *
#         FROM first_mutation
#         )
#         SELECT
#             d.datevalue AS date
#             ,COUNT(DISTINCT CASE WHEN instructor THEN u.merged_guid END) AS instructors
#             ,COUNT(DISTINCT CASE WHEN NOT instructor OR instructor IS NULL THEN u.merged_guid END) AS students
#             ,COUNT(DISTINCT u.merged_guid) AS users
#         FROM dates d
#         INNER JOIN users u ON u.event_time <= d.datevalue
#           AND u.event_time > DATEADD(DAY, -{{ days._parameter_value }}, d.datevalue)
#         GROUP BY 1
#       ;;
#       sql_step:
#       INSERT INTO LOOKER_SCRATCH.{{ view_name._parameter_value }}
#       SELECT date, users, instructors, students
#       FROM looker_scratch.{{ view_name._parameter_value }}_incremental
#       ;;
#       sql_step:
#       CREATE OR REPLACE TABLE ${SQL_TABLE_NAME}
#       CLONE LOOKER_SCRATCH.{{ view_name._parameter_value }};;
#
#       }
# #       datagroup_trigger: daily_refresh
#       persist_for: "24 hours"
#     }
#
#
#     dimension: date {
#       hidden: yes
#       type: date
#       primary_key: yes
#     }
#
#     dimension: max_date {
#       hidden: yes
#       type: date
#       sql: (SELECT MAX(date) FROM LOOKER_SCRATCH.{{ view_name._parameter_value }});;
#     }
#
#     dimension: ru {
#       hidden: yes
#       label: "Registered Users"
#       type: number
#       sql:
#         {{ _view._name }}.users
#       ;;
#     }
#
#     dimension: ru_instructors {
#       hidden: yes
#       label: "Registered Instructors"
#       type: number
#       sql:
#         {{ _view._name }}.instructors
#       ;;
#     }
#
#     dimension: ru_students {
#       hidden: yes
#       label: "Registered Students"
#       type: number
#       sql:
#         {{ _view._name }}.students
#       ;;
#     }
#
#   }
#
