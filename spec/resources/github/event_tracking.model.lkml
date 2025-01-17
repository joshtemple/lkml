connection: "datawarehouse_db"

# include all views in this project
# - include: "*.dashboard.lookml"  # include all dashboards in this project
include: "/Views/**/*.view.lkml"
# - explore: pages

datagroup: orders_datagroup {
  sql_trigger: SELECT count(*) FROM data_data_api_db.affiliate_order_item ;;
  max_cache_age: "5 minutes"
}

explore: event_facts {
  view_label: "0_Events"
  label: "Events"
  fields: [
    ALL_FIELDS*,
    -order_items.catch_product_id
  ]
  join: pages {
    view_label: "1_Page Events"
    type: left_outer
    sql_on: event_facts.event_id = pages.id;;
    relationship: one_to_one
  }

  join: page_facts {
    view_label: "1_Page Events"
    type: left_outer
    sql_on: ${page_facts.event_id} = ${event_facts.event_id} ;;
    relationship: one_to_one
  }

  join: tracks {
    view_label: "1_Track Events"
    type: left_outer
    sql_on: event_facts.event_id = tracks.id;;
    relationship: one_to_one
    fields: []
  }

  join: sessions {
    view_label: "0_Sessions"
    type: left_outer
    sql_on: ${event_facts.session_id} = ${sessions.session_id} ;;
    relationship: many_to_one
  }

  join: session_facts {
    view_label: "0_Sessions"
    type: left_outer
    sql_on: ${event_facts.session_id} = ${session_facts.session_id} ;;
    relationship: many_to_one
  }

  join: campaigns {
    type: left_outer
    sql_on: upper(${campaigns.utm})=upper(${sessions.last_utm}) ;;
    relationship: one_to_many
  }

  join: mapped_campaigns {
    type: inner
    sql_on: upper(${mapped_campaigns.mapped_utm})=upper(${campaigns.mapped_utm}) ;;
    relationship: one_to_one
  }

  join: experiment_sessions {
    view_label: "0_Sessions"
    type: left_outer
    sql_on: ${sessions.session_id} = ${experiment_sessions.session_id} ;;
    relationship: one_to_many
  }

  join: experiment_facts {
    view_label: "0_Sessions"
    type: left_outer
    sql_on: ${experiment_sessions.experiment_id} =  ${experiment_facts.experiment_id};;
#     sql_where: ${event_facts.timestamp_raw} between ${experiment_facts.start_raw} and ${experiment_facts.end_raw} ;;
    sql_where: (${event_facts.timestamp_raw} between ${experiment_facts.start_raw} and ${experiment_facts.end_raw}) and (${sessions.start_raw} between ${experiment_facts.start_raw} and ${experiment_facts.end_raw}) ;;
    relationship: many_to_one
  }

  join: page_path {
    type: left_outer
    sql_on: ${page_path.page_path_id}=${event_facts.page_path_id} ;;
    relationship: one_to_one
  }

  join: journeys {
    view_label: "0_Journeys"
    type: left_outer
    sql_on: ${event_facts.journey_id} = ${journeys.journey_id} ;;
    relationship: many_to_one
  }

  join: journey_facts {
    view_label: "0_Journeys"
    type: left_outer
    sql_on: ${journeys.journey_id} = ${journey_facts.journey_id} ;;
    relationship: one_to_one
  }

  join: journey_groups {
    view_label: "0_Journey_Groups"
    type: left_outer
    sql_on: ${event_facts.journey_group_id} = ${journey_groups.journey_group_id} ;;
    relationship: many_to_one
  }

  join: journey_group_facts {
    view_label: "0_Journey_Groups"
    type: left_outer
    sql_on: ${journey_groups.journey_group_id} = ${journey_group_facts.journey_group_id} ;;
    relationship: one_to_one
  }

  join: brands {
    view_label: "Brands"
    type: left_outer
    sql_on: ${journeys.journey_prop} = ${brands.id} ;;
    relationship: one_to_one
  }

  join: categories {
    view_label: "Categories"
    type: left_outer
    sql_on: ${journeys.journey_prop} = ${categories.id} ;;
    relationship: one_to_one
  }

  join: page_aliases_mapping {
    view_label: "3_Users"
    type: left_outer
    sql_on: ${event_facts.looker_visitor_id}=${page_aliases_mapping.looker_visitor_id} ;;
    relationship: many_to_one
  }

  join: catch_users {
    view_label: "3_Users"
    type: left_outer
    sql_on: ${event_facts.looker_visitor_id}=${catch_users.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    view_label: "3_Users"
    type: left_outer
    sql_on: ${event_facts.looker_visitor_id}=${user_facts.looker_visitor_id} ;;
    relationship: many_to_one
  }

  join: event_flow {
    sql_on: ${event_facts.event_id} = ${event_flow.event_id} ;;
    relationship: one_to_one
  }

  join: concierge_clicked_view {
    view_label: "T_Concierge Clicked"
    type: left_outer
    sql_on: event_facts.event_id = concierge_clicked_view.id
       ;;
    relationship: one_to_one
  }

  join: outlink_sent {
    view_label: "T_Outlinked"
    type: left_outer
    sql_on: event_facts.event_id = outlink_sent.id
       ;;
    relationship: one_to_one
  }

  join: product_list_viewed {
    view_label: "T_Product List Viewed"
    type: left_outer
    sql_on: event_facts.event_id = product_list_viewed.id
       ;;
    relationship: one_to_one
  }

  join: products_viewed_in_list {
    view_label: "T_Product List Viewed"
    type: left_outer
    sql_on: ${product_list_viewed.id} = ${products_viewed_in_list.list_viewed_id} ;;
    relationship: one_to_many
  }

  join: product_list_filtered {
    view_label: "T_Product List Filtered"
    type: left_outer
    sql_on: event_facts.event_id = product_list_filtered.id
      ;;
    relationship: one_to_one
  }

  join: product_list_filtered_in_list {
    view_label: "T_Product List Filtered"
    type: left_outer
    sql_on: ${product_list_filtered.id} = ${product_list_filtered_in_list.id} ;;
    relationship: one_to_many
  }

  join: product_viewed {
    view_label: "T_Product Viewed"
    type: left_outer
    sql_on: event_facts.event_id = product_viewed.id
       ;;
    relationship: one_to_one
  }

  join: search_suggestions {
    view_label: "T_Search Suggestions"
    type: left_outer
    sql_on: event_facts.event_id = search_suggestions.id;;
    relationship: one_to_one
  }


  join: product_searched {
    view_label: "T_Product Searched"
    type: left_outer
    sql_on: event_facts.event_id = product_searched.id;;
    relationship: one_to_one
  }

  join: product_clicked {
    view_label: "T_Product Clicked"
    type: left_outer
    sql_on: event_facts.event_id = product_clicked.id
       ;;
    relationship: one_to_one
  }

  join: section_clicked {
    view_label: "T_Section Clicked"
    type: left_outer
    sql_on: ${event_facts.event_id} = ${section_clicked.id} ;;
    relationship: one_to_one
  }

  join: orders {
    view_label: "Orders"
    type: left_outer
    sql_on: ${event_facts.event_id} = ${orders.order_id};;
    relationship: one_to_one
  }

  join: order_items {
    view_label: "Order_Products"
    type: left_outer
    sql_on: ${orders.order_id} = ${order_items.order_id};;
    relationship: one_to_many
  }

  join: product_maps {
    view_label: "Product_on_Order"
    type: left_outer
    sql_on: ${order_items.vendor_product_id} = ${product_maps.affiliate_product_id} and ${order_items.vendor_slug} = ${product_maps.vendor};;
    relationship: many_to_one
  }

  join: product_facts {
    view_label: "Product_on_Order"
    type: left_outer
    sql_on: ${product_maps.product_id} = ${product_facts.id} ;;
    relationship: many_to_one
    fields: [active, brand_name, gender, product_image, image_url, created_at_time]
  }

  join: list_facts {
    from: categories
    type: left_outer
    sql_on: ${product_viewed.prev_path_id} = ${list_facts.id} ;;
    relationship: many_to_one
    fields: []
  }

  join: dynamic_cohort_users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${user_facts.looker_visitor_id} = ${dynamic_cohort_users.user_id} ;;
  }

}



explore: order_items {
  label: "Orders"
  persist_with: orders_datagroup
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: event_facts {
    sql_on: ${orders.order_id} = ${event_facts.event_id};;
    type: left_outer
    relationship: one_to_one
  }

  join: catch_users {
    view_label: "Users"
    sql_on: ${order_items.user_id} = ${catch_users.id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: user_facts {
    view_label: "Users"
    sql_on: ${catch_users.id} = ${user_facts.looker_visitor_id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: cashbacks {
    sql_on: ${order_items.order_id} = ${cashbacks.order_id} and ${order_items.sku_id} = ${cashbacks.product_id} ;;
    type: left_outer
    relationship: one_to_many
  }

  join: order_facts {
    sql_on: ${orders.order_id} = ${order_facts.order_id} ;;
    type: left_outer
    relationship: one_to_one
  }

  join: product_maps {
    view_label: "Product"
    type: left_outer
    sql_on: ${order_items.vendor_product_id} = ${product_maps.affiliate_product_id} and ${order_items.vendor_slug} = ${product_maps.vendor};;
    relationship: many_to_one
  }

  join: product_facts {
    view_label: "Product"
    type: left_outer
    sql_on: ${product_maps.product_id} = ${product_facts.id} ;;
    relationship: many_to_one
    fields: [active, brand_name, gender, product_image, image_url, created_at_time]
  }

  join: products_categories {
    type: left_outer
    sql_on: ${product_maps.product_id} = ${products_categories.product_id} and ${products_categories._fivetran_deleted} = false ;;
    relationship: many_to_many
    fields: []
  }

  join: category_normalized {
    type: inner
    sql_on: ${products_categories.category_id} = ${category_normalized.id} ;;
    relationship: many_to_one
  }

  join: categories {
    type: left_outer
    sql_on: ${products_categories.category_id} = ${categories.id} ;;
    relationship: one_to_one
  }
}



explore: product_events {
  join: product_facts {
    type: left_outer
    sql_on: ${product_events.product_id} = ${product_facts.id} ;;
    relationship: many_to_one
  }

  join: product_maps {
    type: left_outer
    sql_on: ${product_facts.id} = ${product_maps.product_id} ;;
    relationship: one_to_many
#     fields: []
  }

  join: products_categories {
    type: left_outer
    sql_on: ${product_maps.product_id} = ${products_categories.product_id} and ${products_categories._fivetran_deleted} = false ;;
#     sql_on: ${product_events.product_id} = ${products_categories.product_id} ;;
    relationship: many_to_many
  }

  join: categories {
    type: left_outer
    sql_on: ${products_categories.category_id} = ${categories.id} ;;
    relationship: one_to_one
  }

  join: product_viewed {
    sql_on: ${product_events.event_id} = ${product_viewed.id} ;;
    relationship: one_to_one
  }

  join: products_viewed_in_list {
    sql_on: ${product_events.event_id}= ${products_viewed_in_list.list_viewed_id}
      and ${product_events.product_id} = ${products_viewed_in_list.product_id};;
    relationship: one_to_one
  }

  join: product_clicked {
    sql_on: ${product_events.event_id} = ${product_clicked.id} ;;
    relationship: one_to_one
  }

  join: order_items {
    sql_on: ${product_events.event_id} = ${order_items.order_id}
      and ${product_maps.affiliate_product_id} = ${order_items.vendor_product_id};;
    relationship: one_to_one
  }

  join: event_facts {
    sql_on: ${product_events.event_id} = ${event_facts.event_id} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: session_facts {
    type: left_outer
    sql_on: ${event_facts.session_id} = ${session_facts.session_id} ;;
    relationship: many_to_one
  }

  join: sessions {
    type: left_outer
    sql_on: ${event_facts.session_id} = ${sessions.session_id} ;;
    relationship: many_to_one
  }

  join: journeys {
    type: left_outer
    sql_on: ${event_facts.journey_id} = ${journeys.journey_id} ;;
    relationship: many_to_one
  }

  join: journey_facts {
    type: left_outer
    sql_on: ${journeys.journey_id} = ${journey_facts.journey_id} ;;
    relationship: one_to_one
  }

  join: page_path {
    type: left_outer
    sql_on: ${page_path.page_path_id}=${event_facts.page_path_id} ;;
    relationship: one_to_one
  }

  join: list_facts {
    from: categories
    type: left_outer
    sql_on: ${product_viewed.prev_path_id} = ${list_facts.id} ;;
    relationship: many_to_one
    fields: []
  }

  join: user_facts {
    type: left_outer
    sql_on: ${event_facts.looker_visitor_id} = ${user_facts.looker_visitor_id} ;;
    relationship: many_to_one
  }
}


explore: product_facts {
  join: product_maps {
    type: left_outer
    sql_on: ${product_facts.id} = ${product_maps.product_id} ;;
    relationship: one_to_many
  }

  join: products_categories {
    type: left_outer
    sql_on: ${product_facts.id} = ${products_categories.product_id} and ${products_categories._fivetran_deleted} = false ;;
    relationship: many_to_many
  }

  join: category_normalized {
    type: left_outer
    sql_on: ${products_categories.category_id} = ${category_normalized.id} ;;
    relationship: many_to_one
  }

  join: categories {
    type: left_outer
    sql_on: ${products_categories.category_id} = ${categories.id} ;;
    relationship: one_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${product_facts.id}=${products.id} ;;
    relationship: one_to_one
  }

  join: product_variations {
    type: left_outer
    sql_on: ${product_facts.id}=${product_variations.product_id} ;;
    relationship: one_to_many
  }

}


explore: sv_cashbacks {
  label: "Cashback"
  join: catch_users {
    type: left_outer
    sql_on: ${sv_cashbacks.user_id} = ${catch_users.id} ;;
    relationship: many_to_one
  }

  join: order_items {
    type: left_outer
    sql_on: ${sv_cashbacks.order_id} = ${order_items.order_id} and ${sv_cashbacks.sku_number} = ${order_items.sku_id};;
    relationship: one_to_many
  }

  join: product_maps {
    type: left_outer
    sql_on: ${order_items.vendor_product_id} = ${product_maps.affiliate_product_id} ;;
    relationship: one_to_many
  }
}


explore: user_facts {
  join: users {
    type: left_outer
    sql_on: ${user_facts.looker_visitor_id} = ${users.id};;
    relationship: one_to_one
  }

  join: catch_users {
    type: left_outer
    sql_on: ${user_facts.looker_visitor_id} = ${catch_users.id} ;;
    relationship: one_to_one
  }

  join: first_events {
    type: left_outer
    sql_on: ${user_facts.looker_visitor_id} = ${first_events.looker_visitor_id} ;;
    relationship: one_to_one
  }

  join: users_deleted {
    type: left_outer
    sql_on: ${user_facts.looker_visitor_id} = ${users_deleted.user_id} ;;
    relationship: one_to_one
  }
}

explore: product_list_viewed {
  view_label: "Products Viewed in List"
  label: "Product List"
  hidden: yes
  join: products_viewed_in_list {
    view_label: "Products Viewed in List"
    sql_on: ${product_list_viewed.id} = ${products_viewed_in_list.list_viewed_id} ;;
    relationship: one_to_many
  }
}

explore: event_sessions {
  join: event_facts {
    sql_on: ${event_sessions.event_id}=${event_facts.event_id};;
    relationship: one_to_one
  }
}

explore: customer_service_log {
  hidden: yes
}

explore: event_list {
  hidden: yes
}

explore: utm_values {
  hidden: yes
}

explore: products {}
