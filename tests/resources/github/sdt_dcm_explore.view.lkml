include: "/DCM/**/*.view"
include: "/Google_Analytics/**/*.view"
include: "/Publisher_Passback/**/*.view"

explore: sdt_dcm {
  view_name: sdt_dcm_ga_view
  hidden: yes
  label: "DoubleClick"
  view_label: "DoubleClick"
  group_label: "San Diego Tourism"

  join: sdt_fy21_locals_view {
    view_label: "FY21 Locals Recovery Passback"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy21_locals_view.comp_key} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_digitalvideo_dcm_view {
    view_label: "FY20 Digital Video Passback"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join} = ${sdt_fy20_digitalvideo_dcm_view.passback_join} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_family_content_taboola {
    view_label: "FY20 Family Content Passback"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_family_content_taboola.passback_join_ad} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_can_dcm_view {
    view_label: "FY20 Canada Digital Passback"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_can_dcm_view.passback_join} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_uk_dcm_view {
    view_label: "FY20 United Kingdom Digital Passback"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_uk_dcm_view.passback_join} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_balboapark_sunset {
    view_label: "FY20 Balboa Digital Passback"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join} = ${sdt_fy20_balboapark_sunset.passback_join} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_content_stackadapt {
    view_label: "FY20 Always On Content Passback - StackAdapt"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_content_stackadapt.passback_join} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_content_inpowered {
    view_label: "FY20 Always On Content Passback - inPowered"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join} = ${sdt_fy20_content_inpowered.passback_join} ;;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_uk_audext_video {
    view_label: "FY20 TripAdvisor UK Passback - AudExt Video"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_uk_audext_video.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_uk_homepage_hero {
    view_label: "FY20 TripAdvisor UK Passback - HomePage Hero"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_uk_homepage_hero.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_uk_hub_traffic_drivers {
    view_label: "FY20 TripAdvisor UK Passback - Hub Traffic Drivers"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_uk_hub_traffic_drivers.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_uk_video_banners {
    view_label: "FY20 TripAdvisor UK Passback - Video Banners"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_uk_video_banners.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_uk_outstream_video_banners {
    view_label: "FY20 TripAdvisor UK Passback - Outstream Video Banners"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_uk_outstream_video_banners.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_uk_destination_sponsorship {
    view_label: "FY20 TripAdvisor UK Passback - Dest. Sponsorship"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_uk_destination_sponsorship.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_can_audext_video {
    view_label: "FY20 TripAdvisor CAN Passback - AudExt Video"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_can_audext_video.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_can_homepage_hero {
    view_label: "FY20 TripAdvisor CAN Passback - HomePage Hero"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_can_homepage_hero.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_can_hub_traffic_drivers {
    view_label: "FY20 TripAdvisor CAN Passback - Hub Traffic Drivers"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_can_hub_traffic_drivers.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_can_video_banners {
    view_label: "FY20 TripAdvisor CAN Passback - Video Banners"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_can_video_banners.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_can_outstream_video_banners {
    view_label: "FY20 TripAdvisor CAN Passback - Outstream Video Banners"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_can_outstream_video_banners.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_can_destination_sponsorship {
    view_label: "FY20 TripAdvisor CAN Passback - Dest. Sponsorship"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_can_destination_sponsorship.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_us_audext_video {
    view_label: "FY20 TripAdvisor US Passback - AudExt Video"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_us_audext_video.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_us_homepage_hero {
    view_label: "FY20 TripAdvisor US Passback - HomePage Hero"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_us_homepage_hero.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_us_hub_traffic_drivers {
    view_label: "FY20 TripAdvisor US Passback - Hub Traffic Drivers"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_us_hub_traffic_drivers.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_us_video_banners {
    view_label: "FY20 TripAdvisor US Passback - Video Banners"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_us_video_banners.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_us_outstream_video_banners {
    view_label: "FY20 TripAdvisor US Passback - Outstream Video Banners"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_us_outstream_video_banners.passback_join};;
    relationship: many_to_one
  }

  join: sdt_fy20_ta_us_destination_sponsorship {
    view_label: "FY20 TripAdvisor US Passback - Dest. Sponsorship"
    type: inner
    sql_on: ${sdt_dcm_ga_view.passback_join_ad} = ${sdt_fy20_ta_us_destination_sponsorship.passback_join};;
    relationship: many_to_one
  }

}
