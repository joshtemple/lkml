#############################################################################################################
# Purpose: Defines the fields within the device struct in google analytics. Is extending into ga_sessions.view.lkml
#          and should not be joined into GA sessions explore as an independent view file.
#############################################################################################################
include: "//@{CONFIG_PROJECT_NAME}/Google_Analytics/device.view.lkml"

view: device {
  extends: [device_config]
}



view: device_core {
  extension: required

  ########## DIMENSIONS ############
  dimension: browser {
    view_label: "Audience"
    group_label: "Technology"
    description: "The name of users' browsers, for example, Internet Explorer or Firefox."
    type: string
    sql: ${TABLE}.device.browser ;;

    drill_fields: [browser_size, browser_version]
  }

  dimension: browser_size {
    view_label: "Audience"
    group_label: "Technology"
    description: "The viewport size of users' browsers. A session-scoped dimension, browser size captures the initial dimensions of the viewport in pixels and is formatted as width x height, for example, 1920x960."
    type: string
    sql: ${TABLE}.device.browserSize ;;

    drill_fields: [browser, browser_version]
  }

  dimension: browser_version {
    view_label: "Audience"
    group_label: "Technology"
    description: "The version of users' browsers, for example, 2.0.0.14."
    type: string
    sql: ${TABLE}.device.browserVersion ;;

    drill_fields: [browser, browser_size]
  }

  dimension: device_category {
    view_label: "Audience"
    group_label: "Mobile"
    description: "The type of device: desktop, tablet, or mobile."
    type: string
    sql: ${TABLE}.device.deviceCategory ;;
  }

  dimension: flash_version {
    view_label: "Audience"
    group_label: "System"
    description: "The version of Flash, including minor versions, supported by users' browsers."
    type: string
    sql: ${TABLE}.device.flashVersion ;;
  }

  dimension: is_mobile {
    view_label: "Audience"
    group_label: "Technology"
    description: "Is the user viewing on mobile?"
    type: yesno
    sql: ${TABLE}.device.ismobile ;;
  }

  dimension: java_enabled {
    view_label: "Audience"
    group_label: "System"
    label: "Java Support"
    description: "A boolean, either Yes or No, indicating whether Java is enabled in users' browsers."
    type: yesno
    sql: ${TABLE}.device.javaenabled ;;
  }

  dimension: language {
    view_label: "Audience"
    group_label: "System"
    description: "The language, in ISO-639 code format (e.g., en-gb for British English), provided by the HTTP Request for the browser."
    type: string
    sql: ${TABLE}.device.language ;;
  }

  dimension: mobile_device_branding {
    view_label: "Audience"
    group_label: "Mobile"
    description: "Mobile manufacturer or branded name."
    type: string
    sql: ${TABLE}.device.mobileDeviceBranding ;;
  }

  dimension: mobile_device_info {
    view_label: "Audience"
    group_label: "Mobile"
    description: "The branding, model, and marketing name used to identify the mobile device."
    type: string
    sql: ${TABLE}.device.mobileDeviceInfo ;;
  }

  dimension: mobile_device_input_selector {
    view_label: "Audience"
    group_label: "Mobile"
    description: "Selector (e.g., touchscreen, joystick, clickwheel, stylus) used on the mobile device."
    type: string
    sql: ${TABLE}.device.mobileInputSelector ;;
  }

  dimension: mobile_device_marketing_name {
    view_label: "Audience"
    group_label: "Mobile"
    description: "The marketing name used for the mobile device."
    type: string
    sql: ${TABLE}.device.mobileDeviceMarketingName ;;
  }

  dimension: mobile_device_model {
    view_label: "Audience"
    group_label: "Mobile"
    description: "Mobile device model."
    type: string
    sql: ${TABLE}.device.mobileDeviceModel ;;
  }

  dimension: operating_system {
    view_label: "Audience"
    group_label: "Technology"
    description: "Users' operating system, for example, Windows, Linux, Macintosh, or iOS."
    type: string
    sql: ${TABLE}.device.operatingSystem ;;

    drill_fields: [operating_system_version]
  }

  dimension: operating_system_version {
    view_label: "Audience"
    group_label: "Technology"
    description: "The version of users' operating system, i.e., XP for Windows, PPC for Macintosh."
    type: string
    sql: ${TABLE}.device.operatingSystemVersion ;;
  }

  dimension: screen_colors {
    view_label: "Audience"
    group_label: "System"
    description: "The color depth of users' monitors, retrieved from the DOM of users' browsers. For example, 4-bit, 8-bit, 24-bit, or undefined-bit."
    type: string
    sql: ${TABLE}.device.screenColors ;;
  }

  dimension: screen_resolution {
    view_label: "Audience"
    group_label: "System"
    description: "Resolution of users' screens, for example, 1024x738."
    type: string
    sql: ${TABLE}.device.screenResolution ;;
  }
}
