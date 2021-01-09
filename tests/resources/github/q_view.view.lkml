view: q_view {

  # Qubit LookML | Retail | V2
  sql_table_name:  `qubit-client-{{q_view_v01.project._parameter_value}}.{{q_view_v01.site._parameter_value}}__v2.livetap_view` ;;

  dimension: view_id {
    type: string
    sql: ${TABLE}.view_id ;;
    hidden: yes
    primary_key: yes
  }

  dimension: context_session_number {
    type: number
    sql: ${TABLE}.context_sessionNumber ;;
    label: "Session Number"
    group_label: "View Meta Data"
    description: "Session number of the visitor, in a lifetime. QP fields: context_sessionNumber"
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    hidden: yes
  }

  dimension: entrance_id {
    type: string
    sql: ${TABLE}.entrance_id ;;
    hidden:  yes
  }

  dimension: record_received_date {
    sql: CAST(${TABLE}.meta_recordDate as TIMESTAMP) ;;
    group_label: "View Meta Data"
    type: date
    description: "Date of view (in the timezone configured for the tracking ID, format yyyy-MM-dd). QP fields: meta_recordDate"
  }

  dimension: context_entrance_number {
    type: number
    sql: ${TABLE}.context_entranceNumber ;;
    label: "Entrance Number"
    group_label: "View Meta Data"
    description: "Entrance number of the visitor, in a lifetime. QP fields: context_entranceNumber"
  }

  dimension: context_view_number {
    type: number
    sql: ${TABLE}.context_viewNumber ;;
    label: "View Number"
    group_label: "View Meta Data"
    description: "View number of the visitor, in a lifetime. QP fields: context_viewNumber"
  }

  dimension: context_entrance_view_number {
    type: number
    sql: ${TABLE}.context_entranceViewNumber ;;
    label: "Entrance View Number"
    group_label: "View Meta Data"
    description: "View number of the visitor, in an entrance. QP fields: context_entranceViewNumber"
  }

  dimension: context_session_view_number {
    type: number
    sql: ${TABLE}.context_sessionViewNumber ;;
    label: "Session View Number"
    group_label: "View Meta Data"
    description: "Sequential view number of the visitor, in a session. QP fields: context_sessionViewNumber"
  }

  dimension: context_id {
    type: string
    sql: ${TABLE}.context_id ;;
    label: "Visitor ID"
    group_label: "Visitor"
    description: "ID unique to the visitor, created in browser. QP fields: context_id"
  }

  dimension: context_lifetime_value_base_value {
    type: number
    sql: ${TABLE}.context_lifetimeValue_baseValue ;;
    label: "Visitor Lifetime Value"
    group_label: "Visitor"
    description: "Total spend of a visitor up to the current view. QP fields: context_lifetimeValue_baseValue"
  }

  dimension_group: time_data_points {
    label: ""
    type: time
    timeframes:  [time, hour_of_day, date, day_of_week, week, week_of_year, month, month_name, quarter_of_year, year]
    sql:  ${TABLE}.property_event_ts ;;
    group_label: "⏰ Date & Time"
    description: "Timestamp of the page view. QP fields:  meta_serverTs (with applied UTC offset for your timezone)"
  }

  dimension: meta_url {
    type: string
    sql: ${TABLE}.meta_url ;;
    label: "URL"
    group_label: "Page"
    description: "page URL. QP fields: meta_url"
  }

  dimension: new_vs_returning {
    type: string
    sql: ${TABLE}.new_vs_returning ;;
    label: "New Vs Returning Status"
    group_label: "Visitor"
    description: "New or returning visitor status (on a particular page view). QP fields: context_sessionNumber"
  }

  dimension: page_subtype {
    type: string
    sql: ${TABLE}.page_subtype ;;
    label: "Subtype"
    group_label: "Page"
    description: "Page subtype. QP fields: subtypes"
  }

  dimension: page_type {
    type: string
    sql: ${TABLE}.page_type ;;
    label: "Type"
    group_label: "Page"
    description: "Can be either home, category, product, checkout, transaction, help, contact or other. QP fields: type"
  }

  dimension: total_visitor_views {
    type: number
    sql: ${TABLE}.total_visitor_views ;;
    group_label: "Visitor"
    description: "Number of unique views by visitor, in a lifetime. QP fields: context_viewNumber, context_id"
  }

  dimension: context_conversion_number {
    type: number
    sql: ${TABLE}.context_conversionNumber ;;
    label: "Visitor Conversion Number"
    group_label: "Visitor"
    description: "Number of conversions by the visitor up to the current view. QP fields: context_conversionNumber"
  }

  dimension: returning_purchaser_yesno {
    type: string
    sql: IF(${TABLE}.context_conversionNumber IS NOT NULL, IF(${TABLE}.context_conversionNumber > 0, "yes", "no" ), NULL);;
    label: "Returning Purchaser Yes No"
    group_label: "Visitor"
    description: "Returns 'new' if this is the first session of the visitor, otherwise 'returning'. QP fields: context_conversionNumber"
  }

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
    group_label: "Visitor"
    description: "Email address of a visitor. QP fields: user_email"
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    group_label: "Visitor"
    description: "User ID linked to user's account. Helpful with cross-device tracking. QP fields: user_id"
  }

  dimension: user_loyalty_tier {
    type: string
    sql: ${TABLE}.user_loyalty_tier ;;
    group_label: "Visitor"
    description: "Loyality tier (if any). QP fields: user_loyalty_tier"
  }

  dimension: user_title {
    type: string
    sql: ${TABLE}.user_title ;;
    group_label: "Visitor"
    description: "Title of user provided in a registration form. QP fields: user_title"
  }

  dimension: user_username {
    type: string
    sql: ${TABLE}.user_username ;;
    group_label: "Visitor"
    description: "Website username. QP fields: user_username"
  }

  dimension: user_gender {
    type: string
    sql: ${TABLE}.user_gender ;;
    group_label: "Visitor"
    description: "Gender of user provided in a registration form. QP fields: user_gender"
  }

  dimension: user_age {
    type: string
    sql: ${TABLE}.user_age ;;
    group_label: "Visitor"
    description: "Age of user provided in a registration form. QP fields: user_age"
   }

   dimension: user_isGuest {
     type: string
     sql: ${TABLE}.user_isGuest ;;
     group_label: "Visitor"
     description: "True if user is navigating the website in guest mode / has not signed in. QP fields: user_isGuest"
   }

  dimension: user_firstName {
    type: string
    sql: ${TABLE}.user_firstName ;;
    group_label: "Visitor"
    description:  "First name - as provided by user in a registration form. QP fields: user_firstName"
  }

  dimension: user_lastName {
    type: string
    sql: ${TABLE}.user_lastName ;;
    group_label: "Visitor"
    description:  "Last name - as provided by user in a registration form. QP fields: user_firstName"
  }

 dimension: is_user_sign_up_view {
   type: string
   sql: ${TABLE}.is_user_sign_up_view ;;
   group_label: "Visitor"
   description:  "True if user signed up in this view. QP fields: meta_type"
 }


  dimension: views_in_entrance {
    type: number
    sql: ${TABLE}.views_in_entrance ;;
    group_label: "View Meta Data"
    label: "Total Views in Entrance"
    description: "Number of views in an entrance. QP fields: context_entranceViewNumber, context_id, context_entranceNumber"
  }

  dimension: views_in_session {
    type: number
    sql: ${TABLE}.views_in_session ;;
    group_label: "View Meta Data"
    label: "Total Views in Session"
    description: "Number of views in a session. QP fields: context_sessionViewNumber, context_id, context_sessionNumber"
  }

  dimension: bounced_session {
    type: yesno
    sql: if(${TABLE}.views_in_session=1,true,false) ;;
    group_label: "View Meta Data"
    description: "Did visitor leave on their first view in session?. QP fields: context_sessionViewNumber, context_sessionNumber, context_id"
  }

  dimension: bounced_entrance {
    type: yesno
    sql: if(${TABLE}.views_in_entrance=1,true,false) ;;
    group_label: "View Meta Data"
    description: "Did visitor leave on their first view in entrance?. QP fields: context_entranceViewNumber, context_entranceNumber, context_id"
  }

  dimension: last_view_in_entrance {
    type: yesno
    sql: ${TABLE}.last_view_in_entrance ;;
    group_label: "View Meta Data"
    description: "Is view last in entrance?. QP fields: context_entranceViewNumber, context_id"
  }

  dimension: last_view_in_session {
    type: yesno
    sql: ${TABLE}.last_view_in_session ;;
    group_label: "View Meta Data"
    description: "Is view last in session?. QP fields: context_sessionViewNumber, context_id"
  }

 dimension: visitor_first_entry_date {
    type: date
    sql: ${TABLE}.visitor_first_entry_date ;;
    group_label: "Visitor"
    description: "Date at which a visitor had their first page view. QP fields: meta_recordDate, context_id"
  }

  dimension: visitor_first_entry_week {
    label: "Visitor First Entry Week"
    type: date_week
    sql: ${TABLE}.visitor_first_entry_date ;;
    group_label: "Visitor"
    description: "Week of year at which a visitor had their first page view. QP fields: meta_recordDate, context_id"
  }

  dimension: weeks_since_first_entry {
    type: number
    sql: DATE_DIFF(CAST(${TABLE}.meta_serverTs AS DATE), CAST(TIMESTAMP(${q_view_v01.visitor_first_entry_date}) AS DATE),WEEK) ;;
    group_label: "View Meta Data"
    value_format_name: decimal_0
    description: "Number of weeks between the first view of a visitor and the current view. QP fields: meta_ts, meta_recordDate, context_id"
  }

  measure: view_visitors {
    label: "Unique Visitors"
    type: number
    sql: COUNT(DISTINCT ${TABLE}.context_id) ;;
    description: "Count of unique visitor_ids. QP fields: context_id"
  }

  measure: view_visitors_daily {
    label: "Daily Visitors"
    type: number
    sql: COUNT(DISTINCT CONCAT(${TABLE}.context_id, cast(${TABLE}.meta_recordDate as STRING))) ;;
    description: "Count of unique combinations of a visitor_id and page view date. QP fields: context_id, meta_recordDate"
  }

  measure: views {
    type: number
    sql: COUNT(DISTINCT ${TABLE}.view_id) ;;
    label: "Views"
    description: "Count of unique combinations of a visitor_id and a view_number. QP fields: context_id, context_viewNumber"
  }

  measure: session_bounce_rate {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.views_in_session = 1, ${session_id},  NULL)) / COUNT(DISTINCT ${session_id}) ;;
    value_format_name: percent_2
    description: "Share of sessions that consisted of one view in all sessions. QP fields: context_sessionViewNumber, context_sessionNumber, context_id"
  }

  measure: entrance_bounce_rate {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.views_in_entrance = 1, ${entrance_id}, NULL )) / COUNT(DISTINCT ${entrance_id}) ;;
    value_format_name: percent_2
    description: "Share of entrances that consisted of one view in all entrances. QP fields: context_entranceViewNumber, context_entranceNumber, context_id"
  }

  measure: visitor_bounce_rate {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.total_visitor_views = 1, ${context_id}, NULL )) / COUNT(DISTINCT ${context_id}) ;;
    value_format_name: percent_2
    description: "Share of visitors that saw only a single page view in all visitors.QP fields: context_viewNumber, context_id"
  }

  measure: exit_rate {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.last_view_in_session IS TRUE, ${context_id}, NULL )) / COUNT(DISTINCT ${context_id}) ;;
    value_format_name: percent_2
    description: "Share of visitors that had a last page view in all visitors. QP fields: context_sessionViewNumber, context_id, context_sessionNumber"
  }

  measure: entrance_exit_rate {
    type: number
    sql: COUNT(DISTINCT IF(${TABLE}.last_view_in_entrance IS TRUE, ${context_id}, NULL )) / COUNT(DISTINCT ${context_id}) ;;
    value_format_name: percent_2
    description: "Share of visitors that had a last page view in entrance in all visitors. QP fields: context_sessionViewNumber, context_id, context_sessionNumber"
  }

  measure: visitor_return_rate {
    type: number
    sql:  COUNT(DISTINCT IF(${TABLE}.new_vs_returning = "returning", ${TABLE}.context_id , NULL)) / COUNT(DISTINCT ${context_id}) ;;
    group_label: "Return Rate"
    value_format_name: percent_2
    description: "Share of visitors considered as returning visitors in all visitors.  QP fields: context_sessionNymber, context_id"
  }

}
