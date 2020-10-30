connection: "kiwi_biqquery"

# include all the views
include: "*.view"

# - start day
week_start_day: friday

# include all the dashboards
#include: "*.dashboard"

datagroup: kiwi_bigquery_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: kiwi_bigquery_default_datagroup

# explore: funnel {
# join: magento_sales_flat_order {
#   foreign_key: magento_sales_flat_order.created_date
# }
# join: pages {
#   foreign_key: pages.timestamp_date
# }
# }

explore: a01c_anonymous_ids_list_complete_unique {}

explore: magento_customer_entity {
  join: magento_sales_flat_order {
    type: left_outer
    sql_on: ${magento_customer_entity.entity_id}=${magento_sales_flat_order.customer_id} ;;
    relationship: many_to_many
  }
  join: billing_address {
    from: magento_sales_flat_order_address
    sql_on: ${magento_customer_entity.entity_id}=${billing_address.customer_id} AND ${billing_address.address_type} =  'billing' ;;
    relationship: many_to_many
  }
  join: first_name {
    from: magento_customer_entity_varchar
    sql_on: ${magento_customer_entity.entity_id}=${first_name.entity_id} AND ${first_name.attribute_id}=5 ;;
    relationship: many_to_many
  }
  join: last_name {
    from: magento_customer_entity_varchar
    sql_on: ${magento_customer_entity.entity_id}=${first_name.entity_id} AND ${first_name.attribute_id}=7 ;;
    relationship: many_to_many
  }
}

# explore: subscribed {
#   join: pages {
#     type: inner
#     sql_on: ${subscribed.email}=${pages.email} ;;
#     relationship: one_to_many
#   }
# }

# explore: added_product {
#   join: users {
#     type: left_outer
#     sql_on: ${added_product.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: added_product_view {
#   join: users {
#     type: left_outer
#     sql_on: ${added_product_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: aliases {
#   join: users {
#     type: left_outer
#     sql_on: ${aliases.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: aliases_view {
#   join: users {
#     type: left_outer
#     sql_on: ${aliases_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: alternate_attribution {}
#
# explore: anonymous_id_user_id {
#   join: users {
#     type: left_outer
#     sql_on: ${anonymous_id_user_id.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: are_you_sure_form {
#   join: users {
#     type: left_outer
#     sql_on: ${are_you_sure_form.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: are_you_sure_form_view {
#   join: users {
#     type: left_outer
#     sql_on: ${are_you_sure_form_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: attri_data {}
#
# explore: attribution_data_2016_2017 {}
#
# explore: attribution_data_2017 {}
#
# explore: attribution_predata {}
#
# explore: attribution_revenue_data {}
#
# explore: attribution_revenue_data_2016_2017 {}
#
# explore: attribution_revenue_data_2017 {}
#
# explore: attribution_tracking_data_2017_03_28 {
#   join: users {
#     type: left_outer
#     sql_on: ${attribution_tracking_data_2017_03_28.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: attribution_tracking_per_device_2017_03_27 {
#   join: users {
#     type: left_outer
#     sql_on: ${attribution_tracking_per_device_2017_03_27.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: author_index {
#   join: users {
#     type: left_outer
#     sql_on: ${author_index.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: author_index_view {
#   join: users {
#     type: left_outer
#     sql_on: ${author_index_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_ask_for_additional_can_t_afford_info {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_ask_for_additional_can_t_afford_info.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_ask_for_additional_can_t_afford_info_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_ask_for_additional_can_t_afford_info_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_link_clicked {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_link_clicked.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_link_clicked_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_link_clicked_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_popup {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_popup.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_popup_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_popup_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_50_off_offer {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_50_off_offer.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_50_off_offer_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_50_off_offer_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_brand_switch_option_not_interested {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_brand_switch_option_not_interested.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_brand_switch_option_not_interested_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_brand_switch_option_not_interested_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_brand_switch_option_too_old {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_brand_switch_option_too_old.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_brand_switch_option_too_old_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_brand_switch_option_too_old_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_brand_switch_option_too_young {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_brand_switch_option_too_young.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_brand_switch_option_too_young_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_brand_switch_option_too_young_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_every_other_month_offer {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_every_other_month_offer.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_every_other_month_offer_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_every_other_month_offer_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_extension_offer {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_extension_offer.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_extension_offer_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_extension_offer_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_not_satisfied_modal {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_not_satisfied_modal.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_show_not_satisfied_modal_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_show_not_satisfied_modal_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_subscription {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_subscription.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cancel_subscription_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cancel_subscription_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: channel {
#   join: users {
#     type: left_outer
#     sql_on: ${channel.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: channel_view {
#   join: users {
#     type: left_outer
#     sql_on: ${channel_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_billing {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_billing.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_billing_information {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_billing_information.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_billing_information_view {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_billing_information_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_billing_view {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_billing_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_contact_information {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_contact_information.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_contact_information_view {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_contact_information_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_session_error_403 {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_session_error_403.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_session_error_403_view {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_session_error_403_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_shipping {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_shipping.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: checkout_shipping_view {
#   join: users {
#     type: left_outer
#     sql_on: ${checkout_shipping_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: click_pause {
#   join: users {
#     type: left_outer
#     sql_on: ${click_pause.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: click_pause_view {
#   join: users {
#     type: left_outer
#     sql_on: ${click_pause_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_checkout_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_checkout_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_checkout_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_checkout_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_checkout_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_checkout_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_checkout_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_checkout_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_explore_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_explore_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_explore_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_explore_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_explore_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_explore_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_explore_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_explore_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_referral_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_referral_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_referral_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_referral_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_referral_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_referral_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_referral_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_referral_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_sendcard_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_sendcard_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cloudsponge_sendcard_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cloudsponge_sendcard_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: clv_per_order_join_count {}
#
explore: completed_order {
  join: users {
    type: left_outer
    sql_on: ${completed_order.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# explore: pricing_experiment {
#   join: aliases {
#     type: left_outer
#     sql_on: ${pricing_experiment.anonymous_id} = ${aliases.anonymous_id} ;;
#     relationship: many_to_one
#   }
#   join: completed_order {
#     type: left_outer
#     sql_on: ${pricing_experiment.anonymous_id} = ${completed_order.anonymous_id} ;;
#     relationship: many_to_many
#   }
# }

explore: page_universal_id {}
explore: page_universal_id_New {}


# explore: completed_order_view {
#   join: users {
#     type: left_outer
#     sql_on: ${completed_order_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: consolidated_anonymous_ids {}
#
# explore: consolidated_utm_view {}
#
# explore: contact_us_modal {
#   join: users {
#     type: left_outer
#     sql_on: ${contact_us_modal.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: contact_us_modal_view {
#   join: users {
#     type: left_outer
#     sql_on: ${contact_us_modal_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: continue_to_cancel {
#   join: users {
#     type: left_outer
#     sql_on: ${continue_to_cancel.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: continue_to_cancel_view {
#   join: users {
#     type: left_outer
#     sql_on: ${continue_to_cancel_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: creativity_quiz {}
#
# explore: creativity_quiz_view {}
#
# explore: cs_done {
#   join: users {
#     type: left_outer
#     sql_on: ${cs_done.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cs_done_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cs_done_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cs_launch {
#   join: users {
#     type: left_outer
#     sql_on: ${cs_launch.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: cs_launch_view {
#   join: users {
#     type: left_outer
#     sql_on: ${cs_launch_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: customer_completed_cancel_from_cancel_popup {
#   join: users {
#     type: left_outer
#     sql_on: ${customer_completed_cancel_from_cancel_popup.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: customer_completed_cancel_from_cancel_popup_view {
#   join: users {
#     type: left_outer
#     sql_on: ${customer_completed_cancel_from_cancel_popup_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: customer_completed_pause_from_pause_popup {
#   join: users {
#     type: left_outer
#     sql_on: ${customer_completed_pause_from_pause_popup.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: customer_completed_pause_from_pause_popup_view {
#   join: users {
#     type: left_outer
#     sql_on: ${customer_completed_pause_from_pause_popup_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_ad_click {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_ad_click.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_ad_click_view {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_ad_click_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_share_email {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_share_email.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_share_email_js_evernote_checked {}
#
# explore: diy_share_email_js_evernote_checked_view {}
#
# explore: diy_share_email_view {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_share_email_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_share_pinterest {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_share_pinterest.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_share_pinterest_js_evernote_checked {}
#
# explore: diy_share_pinterest_js_evernote_checked_view {}
#
# explore: diy_share_pinterest_view {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_share_pinterest_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_share_print {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_share_print.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: diy_share_print_js_evernote_checked {}
#
# explore: diy_share_print_js_evernote_checked_view {}
#
# explore: diy_share_print_view {
#   join: users {
#     type: left_outer
#     sql_on: ${diy_share_print_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: duplicate_anonymous_ids {}
#
# explore: email_send_checkout_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_checkout_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_checkout_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_checkout_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_explore_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_explore_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_explore_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_explore_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_getcard_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_getcard_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_getcard_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_getcard_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_referral_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_referral_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_referral_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_referral_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_sendcard_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_sendcard_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_send_sendcard_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${email_send_sendcard_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_submitted {
#   join: users {
#     type: left_outer
#     sql_on: ${email_submitted.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: email_submitted_view {
#   join: users {
#     type: left_outer
#     sql_on: ${email_submitted_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
explore: ab_tasty_view {
  join: purchase_widget_customize {
    type:  left_outer
    sql_on: ${ab_tasty_view.anonymous_id} = ${purchase_widget_customize.anonymous_id} ;;
    relationship: many_to_many
  }
#   join: users {
#     type: left_outer
#     sql_on: ${email_submitted.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
  join: checkout_contact_information {
    type: left_outer
    sql_on: ${ab_tasty_view.anonymous_id} = ${checkout_contact_information.anonymous_id} ;;
    relationship: many_to_many
  }
  join: pages {
    type: left_outer
    sql_on: ${ab_tasty_view.anonymous_id} = ${pages.anonymous_id} ;;
    relationship: many_to_many
  }
  always_join: [a02_anonymous_id_recursive_joins]
  join: a02_anonymous_id_recursive_joins {
    sql_on: a02_anonymous_id_recursive_joins.alias =
      coalesce(ab_tasty_view.anonymous_id, ab_tasty_view.user_id) ;;
    relationship: one_to_many
  }
  join: completed_order {
    type: left_outer
    sql_on: ${ab_tasty_view.anonymous_id} = ${completed_order.anonymous_id} ;;
    relationship: many_to_many
  }
  join: email_submitted {
    type: left_outer
    sql_on: ${ab_tasty_view.anonymous_id} = ${email_submitted.anonymous_id} ;;
    relationship: many_to_many
  }
  join: geolocation_from_ip {
    type: left_outer
    sql_on: ${ab_tasty_view.anonymous_id} = ${geolocation_from_ip.anonymous_id} ;;
    relationship: many_to_many
  }
  join: purchase_widget_subscription_length {
    type: left_outer
    sql_on: ${ab_tasty_view.anonymous_id} = ${purchase_widget_subscription_length.anonymous_id} ;;
    relationship: many_to_many
  }
}

explore: customer_revenue_report{
  join: customer_first_order {
    type: inner
    sql_on: ${customer_revenue_report.customer_id}=${customer_first_order.customer_id} ;;
    relationship: many_to_one
  }
  join: magento_order_analytics {
    type: left_outer
    sql_on: ${customer_first_order.first_order}=${magento_order_analytics.order_id} and ${magento_order_analytics.type} = 'order' ;;
    relationship: one_to_one
    required_joins: [customer_first_order]
    }
  join: magento_flat_order {
    type: left_outer
    sql_on: ${customer_first_order.first_order}=${magento_flat_order.entity_id};;
    relationship: many_to_one
    required_joins: [customer_first_order]
  }
  join: magento_subscriptions {
    type: left_outer
    sql_on: ${customer_first_order.first_order}=${magento_subscriptions.primary_order_id};;
    relationship: many_to_one
    required_joins: [customer_first_order]
  }
  join: magento_customer {
    type: left_outer
    sql_on: ${customer_revenue_report.customer_id}=${magento_customer.entity_id} ;;
    relationship: many_to_one
  }
}

#
# explore: experiment_viewed_view {
#   join: users {
#     type: left_outer
#     sql_on: ${experiment_viewed_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_messenger_checkout_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_messenger_checkout_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_messenger_checkout_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_messenger_checkout_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_messenger_explore_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_messenger_explore_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_messenger_explore_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_messenger_explore_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_messenger_referral_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_messenger_referral_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_messenger_referral_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_messenger_referral_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_checkout_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_checkout_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_checkout_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_checkout_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_checkout_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_checkout_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_checkout_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_checkout_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_explore_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_explore_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_explore_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_explore_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_explore_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_explore_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_explore_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_explore_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_getcard_raf {}
#
# explore: fb_post_getcard_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_getcard_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_getcard_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_getcard_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_getcard_raf_view {}
#
# explore: fb_post_newsletter_signup {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_newsletter_signup.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_newsletter_signup_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_newsletter_signup_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_referral_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_referral_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_referral_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_referral_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_referral_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_referral_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_referral_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_referral_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_sendcard_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_sendcard_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_sendcard_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_sendcard_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_sendcard_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_sendcard_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_sendcard_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_sendcard_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_survey_raf {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_survey_raf.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_survey_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_survey_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_survey_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_survey_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fb_post_survey_raf_view {
#   join: users {
#     type: left_outer
#     sql_on: ${fb_post_survey_raf_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: fill_session_id_for_order_1 {}
#
# explore: fill_session_id_for_order_10 {}
#
# explore: fill_session_id_for_order_11 {}
#
# explore: fill_session_id_for_order_12 {}
#
# explore: fill_session_id_for_order_13 {}
#
# explore: fill_session_id_for_order_14 {}
#
# explore: fill_session_id_for_order_15 {}
#
# explore: fill_session_id_for_order_16 {}
#
# explore: fill_session_id_for_order_17 {}
#
# explore: fill_session_id_for_order_18 {}
#
# explore: fill_session_id_for_order_19 {}
#
# explore: fill_session_id_for_order_2 {}
#
# explore: fill_session_id_for_order_20 {}
#
# explore: fill_session_id_for_order_21 {}
#
# explore: fill_session_id_for_order_22 {}
#
# explore: fill_session_id_for_order_23 {}
#
# explore: fill_session_id_for_order_24 {}
#
# explore: fill_session_id_for_order_25 {}
#
# explore: fill_session_id_for_order_26 {}
#
# explore: fill_session_id_for_order_27 {}
#
# explore: fill_session_id_for_order_28 {}
#
# explore: fill_session_id_for_order_29 {}
#
# explore: fill_session_id_for_order_3 {}
#
# explore: fill_session_id_for_order_30 {}
#
# explore: fill_session_id_for_order_31 {}
#
# explore: fill_session_id_for_order_4 {}
#
# explore: fill_session_id_for_order_5 {}
#
# explore: fill_session_id_for_order_6 {}
#
# explore: fill_session_id_for_order_7 {}
#
# explore: fill_session_id_for_order_8 {}
#
# explore: fill_session_id_for_order_9 {}
#
# explore: final_cancel_link_clicked {
#   join: users {
#     type: left_outer
#     sql_on: ${final_cancel_link_clicked.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: final_cancel_link_clicked_view {
#   join: users {
#     type: left_outer
#     sql_on: ${final_cancel_link_clicked_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: header_ad_cta_click {
#   join: users {
#     type: left_outer
#     sql_on: ${header_ad_cta_click.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: header_ad_cta_click_view {
#   join: users {
#     type: left_outer
#     sql_on: ${header_ad_cta_click_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: header_ad_dismissed {
#   join: users {
#     type: left_outer
#     sql_on: ${header_ad_dismissed.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: header_ad_dismissed_view {
#   join: users {
#     type: left_outer
#     sql_on: ${header_ad_dismissed_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: header_ad_shown {
#   join: users {
#     type: left_outer
#     sql_on: ${header_ad_shown.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: header_ad_shown_view {
#   join: users {
#     type: left_outer
#     sql_on: ${header_ad_shown_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: help_us_improve_form {
#   join: users {
#     type: left_outer
#     sql_on: ${help_us_improve_form.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: help_us_improve_form_view {
#   join: users {
#     type: left_outer
#     sql_on: ${help_us_improve_form_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: identifies {
#   join: users {
#     type: left_outer
#     sql_on: ${identifies.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: identifies_view {
#   join: users {
#     type: left_outer
#     sql_on: ${identifies_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: intellimize_experiment_viewed {
#   join: users {
#     type: left_outer
#     sql_on: ${intellimize_experiment_viewed.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: intellimize_experiment_viewed_view {
#   join: users {
#     type: left_outer
#     sql_on: ${intellimize_experiment_viewed_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: kiwi_checkout_session_pageviews {
#   join: users {
#     type: left_outer
#     sql_on: ${kiwi_checkout_session_pageviews.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: kiwi_completed_orders_mar2017_view {
#   join: users {
#     type: left_outer
#     sql_on: ${kiwi_completed_orders_mar2017_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: kiwi_success_pageviews {}
#
# explore: landing_page_action {
#   join: users {
#     type: left_outer
#     sql_on: ${landing_page_action.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: landing_page_action_view {
#   join: users {
#     type: left_outer
#     sql_on: ${landing_page_action_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_diy_interstitial_close {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_diy_interstitial_close.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_diy_interstitial_close_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_diy_interstitial_close_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_join {}
#
# explore: lightbox_join_view {}
#
# explore: lightbox_newsletter_close {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_close.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_close_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_close_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_not_sha {}
#
# explore: lightbox_newsletter_not_sha_view {}
#
# explore: lightbox_newsletter_not_shared {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_not_shared.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_not_shared_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_not_shared_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_signup {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_signup.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_signup_share {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_signup_share.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_signup_share_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_signup_share_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_signup_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_signup_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_tweet {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_tweet.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_newsletter_tweet_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_newsletter_tweet_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_upsell_close {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_upsell_close.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_upsell_close_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_upsell_close_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_upsell_show {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_upsell_show.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_upsell_show_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_upsell_show_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_upsell_upgrade {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_upsell_upgrade.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: lightbox_upsell_upgrade_view {
#   join: users {
#     type: left_outer
#     sql_on: ${lightbox_upsell_upgrade_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: list_index {
#   join: users {
#     type: left_outer
#     sql_on: ${list_index.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: list_index_view {
#   join: users {
#     type: left_outer
#     sql_on: ${list_index_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

explore: magento_kiwicrate_subscription {
#   always_filter: {
#     filters: {
#       field: funnel.event_time
#       value: "30 days ago for 30 days"
#     }
#   }
    join: primary_order {
    from: magento_sales_flat_order
    type: left_outer
    sql_on: primary_order.entity_id=magento_kiwicrate_subscription.primary_order_id ;;
    relationship: many_to_many
    }
   join: order_analytics {
    from: magento_kiwicrate_order_analytics
    type:  left_outer
    sql_on: magento_kiwicrate_order_analytics.order_id=primary_order.entity_id and magento_kiwicrate_order_analytics.type = 'order' ;;
    required_joins: [primary_order]
    relationship: many_to_many
    }
    join: magento_customer_entity {
    from: magento_customer_entity
    type:  left_outer
    sql_on:  ${magento_customer_entity.entity_id}=${magento_kiwicrate_subscription.customer_id} ;;
    relationship:  many_to_many
    }
#     join: funnel {
#     from: funnel
#     sql_on: ${primary_order.created_date}=${funnel.event_date} ;;
#     relationship: one_to_one
#   }
#   join: pages {
#     from:  pages
#     sql_on: ${pages.timestamp_date}=${primary_order.created_date} ;;
#     required_joins: [magento_sales_flat_order]
#     relationship: one_to_one
#   }
  }

explore: magento_sales_flat_order_item {
  join: magento_sales_flat_order {
    from: magento_sales_flat_order
    type:  left_outer
    sql_on:  ${magento_sales_flat_order.entity_id}=${magento_sales_flat_order_item.order_id};;
    relationship: many_to_many
  }
  join: order_analytics {
    from: magento_kiwicrate_order_analytics
    type:  left_outer
    sql_on: order_analytics.order_id=primary_order.entity_id and order_analytics.type = 'order' ;;
    required_joins: [magento_sales_flat_order]
    relationship: many_to_many
  }
}
#
# explore: our_story_modal {
#   join: users {
#     type: left_outer
#     sql_on: ${our_story_modal.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: our_story_modal_view {
#   join: users {
#     type: left_outer
#     sql_on: ${our_story_modal_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: our_vision_modal {
#   join: users {
#     type: left_outer
#     sql_on: ${our_vision_modal.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: our_vision_modal_view {}
#
explore: monthly_activity {}

explore: pages {
  join: users {
    type: left_outer
    sql_on: ${pages.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: completed_order {
    type: left_outer
    sql_on: ${pages.anonymous_id} = ${completed_order.anonymous_id} ;;
    relationship: many_to_one
  }
  join: email_submitted {
    type: left_outer
    sql_on: ${pages.anonymous_id} = ${email_submitted.anonymous_id} ;;
    relationship: many_to_many
  }
  join: first_last_attribution {
    type: left_outer
    sql_on: ${pages.anonymous_id} = ${first_last_attribution.anonymous_id} ;;
    relationship: many_to_one
  }
  join: landing_page {
    type: left_outer
    sql_on: ${pages.session_id} = ${landing_page.session_id} ;;
    relationship: many_to_one
  }
  join: geolocation_from_ip {
    type: left_outer
    sql_on: ${pages.id} = ${geolocation_from_ip.id} ;;
    relationship: many_to_one
  }
  join: amp_pages {
    type: full_outer
    sql_on: ${pages.anonymous_id}=${amp_pages.anonymous_id} ;;
    relationship: many_to_many
  }
  always_join: [a02_anonymous_id_recursive_joins]
  join: a02_anonymous_id_recursive_joins {
    sql_on: a02_anonymous_id_recursive_joins.alias =
      coalesce(pages.anonymous_id, pages.user_id) ;;
    relationship: one_to_many
  }
}

explore: amp_pages {
}

# explore: pages_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pages_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pageview_utm_view {}

# explore: pause_link_clicked {
#   join: users {
#     type: left_outer
#     sql_on: ${pause_link_clicked.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pause_link_clicked_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pause_link_clicked_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_add_success {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_add_success.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_add_success_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_add_success_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_breadcrumb {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_breadcrumb.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_breadcrumb_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_breadcrumb_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_product_suggestions {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_product_suggestions.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_product_suggestions_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_product_suggestions_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_shipping_info {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_shipping_info.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_shipping_info_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_shipping_info_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_social_share {}
#
# explore: pdp_social_share_email {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_social_share_email.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_social_share_email_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_social_share_email_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_social_share_facebook {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_social_share_facebook.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_social_share_facebook_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_social_share_facebook_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_social_share_pinterest {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_social_share_pinterest.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_social_share_pinterest_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_social_share_pinterest_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_social_share_view {}
#
# explore: pdp_subscription_upsell {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_subscription_upsell.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_subscription_upsell_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_subscription_upsell_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: pdp_view_view {
#   join: users {
#     type: left_outer
#     sql_on: ${pdp_view_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: product_purchase_part1 {}
#
# explore: product_purchase_part2 {}
#
# explore: product_purchases_mar2017 {
#   join: users {
#     type: left_outer
#     sql_on: ${product_purchases_mar2017.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: punchcard_task_shown {
#   join: users {
#     type: left_outer
#     sql_on: ${punchcard_task_shown.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: punchcard_task_shown_view {
#   join: users {
#     type: left_outer
#     sql_on: ${punchcard_task_shown_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: purchase_sessions_mar2017 {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_sessions_mar2017.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: purchase_sessions_table {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_sessions_table.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: purchase_widget_choose_brand {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_widget_choose_brand.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: purchase_widget_choose_brand_view {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_widget_choose_brand_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: purchase_widget_choose_line {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_widget_choose_line.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
#   join: purchase_widget_subscription_length {
#     type: left_outer
#     sql_on: ${purchase_widget_choose_line.anonymous_id}=${purchase_widget_subscription_length.anonymous_id} ;;
#     relationship: many_to_many
#   }
#   join: purchase_widget_customize {
#     type: left_outer
#     sql_on: ${purchase_widget_choose_line.anonymous_id}=${purchase_widget_customize.anonymous_id} ;;
#     relationship: many_to_many
#   }
# }
#
# explore: purchase_widget_choose_line_view {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_widget_choose_line_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: purchase_widget_customize {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_widget_customize.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: purchase_widget_customize_view {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_widget_customize_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
explore: purchase_widget_subscription_length {
  join: users {
    type: left_outer
    sql_on: ${purchase_widget_subscription_length.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: purchase_widget_customize {
    type: left_outer
    sql_on: ${purchase_widget_subscription_length.anonymous_id}=${purchase_widget_customize.anonymous_id} ;;
    relationship: many_to_many
  }
  join: completed_order {
    type: left_outer
    sql_on: ${purchase_widget_subscription_length.anonymous_id}=${completed_order.anonymous_id} ;;
    relationship: many_to_many
  }

}
#
# explore: purchase_widget_subscription_length_view {
#   join: users {
#     type: left_outer
#     sql_on: ${purchase_widget_subscription_length_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_0_2 {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_0_2.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_0_2_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_0_2_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_3_4 {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_3_4.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_3_4_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_3_4_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_5_8 {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_5_8.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_5_8_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_5_8_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_9_16 {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_9_16.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_9_16_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_9_16_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_age_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_age_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_art {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_art.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_art_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_art_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_challenge {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_challenge.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_challenge_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_challenge_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_difficult {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_difficult.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_difficult_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_difficult_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_prefer {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_prefer.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_prefer_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_prefer_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_science {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_science.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: quiz_science_view {
#   join: users {
#     type: left_outer
#     sql_on: ${quiz_science_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: recipe {
#   join: users {
#     type: left_outer
#     sql_on: ${recipe.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: recipe_index {
#   join: users {
#     type: left_outer
#     sql_on: ${recipe_index.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: recipe_index_view {
#   join: users {
#     type: left_outer
#     sql_on: ${recipe_index_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: recipe_view {
#   join: users {
#     type: left_outer
#     sql_on: ${recipe_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: referred {}
#
# explore: referred_view {}
#
# explore: renew_sticker_choose_offer_10_off {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_choose_offer_10_off.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_choose_offer_10_off_view {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_choose_offer_10_off_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_choose_offer_1_month_free {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_choose_offer_1_month_free.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_choose_offer_1_month_free_view {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_choose_offer_1_month_free_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_choose_offer_3_months_free {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_choose_offer_3_months_free.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_choose_offer_3_months_free_view {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_choose_offer_3_months_free_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_go_to_checkout_from_purchase_widget {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_go_to_checkout_from_purchase_widget.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_go_to_checkout_from_purchase_widget_view {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_go_to_checkout_from_purchase_widget_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_go_to_renew_or_extension_checkout_page {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_go_to_renew_or_extension_checkout_page.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_go_to_renew_or_extension_checkout_page_view {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_go_to_renew_or_extension_checkout_page_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_retrieve_sub_info {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_retrieve_sub_info.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_retrieve_sub_info_view {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_retrieve_sub_info_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_view_purchase_widget {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_view_purchase_widget.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: renew_sticker_view_purchase_widget_view {
#   join: users {
#     type: left_outer
#     sql_on: ${renew_sticker_view_purchase_widget_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: results_20170328_115327 {}
#
# explore: session_revenue_2016_2017 {}
#
# explore: session_revenue_2016_2017_1 {}
#
# explore: session_revenue_2016_2017_10 {}
#
# explore: session_revenue_2016_2017_11 {}
#
# explore: session_revenue_2016_2017_12 {}
#
# explore: session_revenue_2016_2017_13 {}
#
# explore: session_revenue_2016_2017_14 {}
#
# explore: session_revenue_2016_2017_15 {}
#
# explore: session_revenue_2016_2017_16 {}
#
# explore: session_revenue_2016_2017_17 {}
#
# explore: session_revenue_2016_2017_18 {}
#
# explore: session_revenue_2016_2017_19 {}
#
# explore: session_revenue_2016_2017_2 {}
#
# explore: session_revenue_2016_2017_20 {}
#
# explore: session_revenue_2016_2017_3 {}
#
# explore: session_revenue_2016_2017_4 {}
#
# explore: session_revenue_2016_2017_5 {}
#
# explore: session_revenue_2016_2017_6 {}
#
# explore: session_revenue_2016_2017_7 {}
#
# explore: session_revenue_2016_2017_8 {}
#
# explore: session_revenue_2016_2017_9 {}
#
# explore: session_revenue_2017 {}
#
# explore: session_revenue_2017_1 {}
#
# explore: session_revenue_2017_10 {}
#
# explore: session_revenue_2017_11 {}
#
# explore: session_revenue_2017_12 {}
#
# explore: session_revenue_2017_13 {}
#
# explore: session_revenue_2017_14 {}
#
# explore: session_revenue_2017_15 {}
#
# explore: session_revenue_2017_16 {}
#
# explore: session_revenue_2017_17 {}
#
# explore: session_revenue_2017_18 {}
#
# explore: session_revenue_2017_19 {}
#
# explore: session_revenue_2017_2 {}
#
# explore: session_revenue_2017_20 {}
#
# explore: session_revenue_2017_3 {}
#
# explore: session_revenue_2017_4 {}
#
# explore: session_revenue_2017_5 {}
#
# explore: session_revenue_2017_6 {}
#
# explore: session_revenue_2017_7 {}
#
# explore: session_revenue_2017_8 {}
#
# explore: session_revenue_2017_9 {}
#
# explore: sessions_without_conversion {}
#
# explore: shop_category_diy {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_category_diy.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_category_diy_home {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_category_diy_home.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_category_diy_home_view {}
#
# explore: shop_category_diy_project {}
#
# explore: shop_category_diy_project_inspiration {}
#
# explore: shop_category_diy_project_inspiration_view {}
#
# explore: shop_category_diy_project_view {}
#
# explore: shop_category_diy_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_category_diy_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_breadcrumb {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_breadcrumb.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_breadcrumb_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_breadcrumb_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_get_subscription {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_get_subscription.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_get_subscription_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_get_subscription_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_product_thumbnail {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_product_thumbnail.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_product_thumbnail_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_product_thumbnail_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_shipping_info {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_shipping_info.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_shipping_info_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_shipping_info_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_detail_view_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_detail_view_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_editorial_action {}
#
# explore: shop_editorial_action_view {}
#
# explore: shop_quickview_action {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_quickview_action.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: shop_quickview_action_view {
#   join: users {
#     type: left_outer
#     sql_on: ${shop_quickview_action_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: show_brand_switch_option {}
#
# explore: show_credits_offer_for_not_cancelling {
#   join: users {
#     type: left_outer
#     sql_on: ${show_credits_offer_for_not_cancelling.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: show_credits_offer_for_not_cancelling_view {
#   join: users {
#     type: left_outer
#     sql_on: ${show_credits_offer_for_not_cancelling_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: show_lightbox {
#   join: users {
#     type: left_outer
#     sql_on: ${show_lightbox.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: show_lightbox_view {
#   join: users {
#     type: left_outer
#     sql_on: ${show_lightbox_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_checkout_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_checkout_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_checkout_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_checkout_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_explore_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_explore_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_explore_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_explore_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_referral_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_referral_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_referral_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_referral_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_sendcard_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_sendcard_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: sms_sendcard_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${sms_sendcard_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: success_pageview_data_view {
#   join: users {
#     type: left_outer
#     sql_on: ${success_pageview_data_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: success_session_ids {}
#
# explore: top_index {}
#
# explore: top_index_view {}
#
explore: tracks {
  always_join: [a02_anonymous_id_recursive_joins]
  join: a02_anonymous_id_recursive_joins {
    sql_on: a02_anonymous_id_recursive_joins.alias =
    coalesce(tracks.anonymous_id, tracks.user_id) ;;
    relationship: one_to_many
  }
}
#
# explore: tracks {
#   join: users {
#     type: left_outer
#     sql_on: ${tracks.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: tracks_view {
#   join: users {
#     type: left_outer
#     sql_on: ${tracks_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: tw_post_checkout_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${tw_post_checkout_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: tw_post_checkout_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${tw_post_checkout_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: tw_post_explore_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${tw_post_explore_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: tw_post_explore_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${tw_post_explore_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: tw_post_referral_raf_init {
#   join: users {
#     type: left_outer
#     sql_on: ${tw_post_referral_raf_init.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: tw_post_referral_raf_init_view {
#   join: users {
#     type: left_outer
#     sql_on: ${tw_post_referral_raf_init_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
explore: users {
  join: pages {
    type: left_outer
    sql_on: ${users.id}=${pages.user_id} ;;
    relationship: one_to_many
  }
  always_join: [a02_anonymous_id_recursive_joins]
  join: a02_anonymous_id_recursive_joins {
    sql_on: a02_anonymous_id_recursive_joins.alias =
      coalesce(users.anonymous_id, users.user_id) ;;
    relationship: one_to_many
  }
  join: email_submitted {
    type: left_outer
    sql_on: ${pages.anonymous_id} = ${email_submitted.anonymous_id} ;;
    relationship: many_to_many
  }
  join: completed_order {
    type: left_outer
    sql_on: ${users.id}=${completed_order.user_id} ;;
    relationship: one_to_many
  }
}

#
# explore: users_view {}
#
# explore: view_order_summary {
#   join: users {
#     type: left_outer
#     sql_on: ${view_order_summary.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: view_order_summary_view {
#   join: users {
#     type: left_outer
#     sql_on: ${view_order_summary_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: view_reviews_modal {
#   join: users {
#     type: left_outer
#     sql_on: ${view_reviews_modal.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: view_reviews_modal_view {
#   join: users {
#     type: left_outer
#     sql_on: ${view_reviews_modal_view.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
explore: storesearch {
}
