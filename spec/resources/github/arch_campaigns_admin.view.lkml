view: arch_campaigns_admin {

  derived_table: {
    datagroup_trigger: dg_bc360_campaigns

    sql:  SELECT
            program,
            service_line_code,
            service_line,
            service_offering,
            service_detail,
            # campaign_group_id,
            campaign_group,
            # campaign_label,
            campaign_region,
            campaign_location,
            campaign_tier,
            campaign_matchtype,
            organization_id,
            mode,
            test_variation,
            agency,
            CAST(account_id AS INT64) account_id,
            account,
            medium,
            CAST(campaign_id AS INT64) campaign_id,
            campaign,
            CAST(adgroup_id AS INT64) adgroup_id,
            adgroup
         FROM arch_campaigns.arch_campaigns_base ap;;
  }


  ##########  DIMENSIONS  { ##########

  dimension: rel_program_main {
    view_label: "2. Services"
    group_label: "Relative Dimensions"
    label: "{% if campaign._is_filtered %}
    [Ad Group]
    {% elsif campaign_group._is_filtered %}
    [Campaign]
    {% elsif service_line._is_filtered %}
    [Campaign Group]
    {% elsif program._is_filtered %}
    [Service]
    {% else %}
    [Program]
    {% endif %}"

    hidden: yes
    type: string

    sql:  {% if campaign._is_filtered %}
                ${adgroup}
              {% elsif campaign_group._is_filtered %}
                ${campaign}
              {% elsif service_line._is_filtered %}
                ${campaign_group}
              {% elsif program._is_filtered %}
                ${service_line}
              {% else %}
                ${program}
              {% endif %} ;;
  }

  dimension: rel_service_offering {
    view_label: "2. Services"
    group_label: "Relative Dimensions"
    label: "{% if service_line._is_filtered %}
    [Offering]
    {% else %}
    [Service]
    {% endif %}"

    hidden: yes
    type: string

    sql:  {% if service_line._is_filtered %}
                ${service_offering}
              {% else %}
                ${service_line}
              {% endif %} ;;
  }

  dimension: rel_program_detail {
    view_label: "2. Services"
    group_label: "Relative Dimensions"
    label: "{% if service_line._is_filtered %}
    [[Campaign]]
    {% elsif program._is_filtered %}
    [[Campaign Group]]
    {% else %}
    [[Agency]]
    {% endif %}"

    hidden: yes
    type: string

    sql:  {% if service_line._is_filtered %}
                    ${campaign}
                  {% elsif program._is_filtered %}
                    ${campaign_group}
                  {% else %}
                    ${agency}
                  {% endif %} ;;
  }



  dimension: medium {
    view_label: "3. Channel"
    label: "Medium"
    description: "Digital Channel Used"

    type: string
    sql: ${TABLE}.medium ;;
  }

  dimension: account {
    view_label: "1. Client/Account"
    label: "Channel Account"
    description: "Account name within given Channel (Ads, Display, etc.)"

    hidden: yes
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: campaign {
    view_label: "3. Channel"
    group_label: "Campaign Architecture"
    label: "Campaign"
    description: "Campaign Within Digital Channel"

    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: campaign_group {
    view_label: "3. Channel"
    group_label: "Campaign Architecture"
    label: "Campaign Group"
    description: "Campaign Group Within Digital Channel"

    type: string
    sql: ${TABLE}.campaign_group ;;
  }

  # dimension: campaign_label {
  #   view_label: "3. Channel"
  #   group_label: "Campaign Architecture"
  #   label: "Campaign Label"
  #   description: "Campaign Label Within Digital Channel"
  #
  #   type: string
  #   sql: ${TABLE}.campaign_label ;;
  # }



  dimension: campaign_region {
    view_label: "3. Channel"
    group_label: "Campaign Geography"
    label: "Region"

    type: string
    sql: ${TABLE}.campaign_region ;;
  }

  dimension: campaign_tier_base {
    view_label: "Z - Metadata"
    group_label: "Metrics - Base Values"
    label: "Campaign Tier*"

    hidden: yes
    type: string
    sql: ${TABLE}.campaign_tier ;;
  }

  dimension: campaign_tier {
    view_label: "3. Channel"
    label: "Campaign Tier"

    type: string

    case: {
      when: {
        sql: ${campaign_tier_base} = 'S&C' ;;
        label: "S&C"
      }
      when: {
        sql: ${campaign_tier_base} = 'T&P' ;;
        label: "T&P"
      }
      when: {
        sql: ${campaign_tier_base} = 'P&F' ;;
        label: "P&F"
      }
      when: {
        sql: ${campaign_tier_base} = 'Brand' ;;
        label: "Brand"
      }
      when: {
        sql: ${campaign_tier_base} = 'Competitor' ;;
        label: "Competitor"
      }
      when: {
        sql: ${campaign_tier_base} IN ('General', 'Varied') ;;
        label: "General"
      }
      when: {
        sql: ${campaign_tier_base} IS null ;;
        label: "NA"
      }
      else: "Other"
    }

  }

  dimension: campaign_location {
    view_label: "3. Channel"
    group_label: "Campaign Geography"
    label: "Campaign Location"

    type: string

    sql: ${TABLE}.campaign_location ;;
  }

  dimension: adgroup {
    view_label: "3. Channel"
    group_label: "Campaign Architecture"
    label: "Ad Group"
    description: "Adgroup Within Digital Channel"

    type: string
    sql: ${TABLE}.adgroup ;;
  }

  dimension: mode {
    view_label: "3. Channel"
    label: "Mode"
    description: "'Call Only', 'CRM Targeting', 'Beaumont.org Retargeting', etc."

    type: string
    sql: ${TABLE}.mode ;;
    }

  dimension: test_variation {
    view_label: "3. Channel"
    label: "Test Variation"
    description: "'A', 'B', etc."

    type: string
    sql: IFNULL(${TABLE}.test_variation, "(No Test)") ;;
  }

  dimension: service_line {
    view_label: "2. Services"
    label: "Service Line"
    description: "Service Line"

    type: string

    order_by_field: combo_program_service
    sql: IF((${TABLE}.program = ${TABLE}.service_line), ${TABLE}.service_line, FORMAT("%s (%s)", ${TABLE}.service_line, ${TABLE}.program)) ;;
    }

  dimension: combo_program_service {
    view_label: "2. Services"
    group_label: "Z - Combined Labels"
    label: "Program | Service"
    description: "Useful as a hidden field for sorting"

    hidden: no
    type: string

    sql: FORMAT("%s | %s", ${TABLE}.program, ${TABLE}.service_line) ;;
  }

  dimension: program {
    view_label: "2. Services"
    label: "Program"
    description: "Service Line Program"

    # drill_fields: [
    # drill_program*
    # ]

    # link: {
    #   label: "Performance - Visibility"
    #   label:  "/dashboards/38?Program={{ _filters['arch_program.program'] | url_encode }}"
    #   url:  "/dashboards/38?Program={{ _filters['arch_program.program'] | url_encode }}"
    # }

    # link: {
    #   label: "Performance - Engagement"
    #   url:  "/dashboards/39?&f[arch_program.program]={{ value }}&f[arch_program.service_line]={{ _filters['arch_program.service_line'] | url_encode }}&f[arch_program.medium]={{ _filters['arch_program.medium'] | url_encode }}&f[arch_program.client]={{ _filters['arch_program.client'] | url_encode }}&f[arch_program.organization]={{ _filters['arch_program.organization'] | url_encode }}"
    # }

    # link: {
    #   label: "Performance - Acquisition"
    #   url:  "/dashboards/40?&f[arch_program.program]={{ value }}&f[arch_program.service_line]={{ _filters['arch_program.service_line'] | url_encode }}&f[arch_program.medium]={{ _filters['arch_program.medium'] | url_encode }}&f[arch_program.client]={{ _filters['arch_program.client'] | url_encode }}&f[arch_program.organization]={{ _filters['arch_program.organization'] | url_encode }}"
    # }

    type: string
    sql: ${TABLE}.program ;;
  }

  dimension: service_line_code {
    view_label: "2. Services"
    group_label: "Service Architecture"
    label: "Service Line Code"
    description: "Service Line Code"

    hidden: no
    type: string
    sql: ${TABLE}.service_line_code ;;
  }

  dimension: service_offering {
    view_label: "2. Services"
    group_label: "Service Architecture"
    label: "Service Offering"
    description: "Service Line Offering"

    type: string
    sql: ${TABLE}.service_offering ;;
  }

  dimension: service_detail {
    view_label: "2. Services"
    group_label: "Service Architecture"
    label: "Service Detail"
    description: "Service Detail"

    type: string
    sql: ${TABLE}.service_detail ;;
  }

  dimension: agency {
    view_label: "1. Client/Account"
    label: "Agency"
    description: "Agency Managing Any Given Campaign"

    hidden: yes
    type: string
    sql: ${TABLE}.agency ;;
  }

  ##########  DIMENSIONS  }  ##########



  ##########  MEASURES  { ##########

  measure: num_programs {
    view_label: "2. Services"
    group_label: "Z - Category Counts"
    label: "# Programs"
    description: "Number of Service Programs"

    hidden: yes
    type: count_distinct
    value_format_name: decimal_0

    sql: ${program} ;;
  }

  measure: num_services {
    view_label: "2. Services"
    group_label: "Z - Category Counts"
    label: "# Service Lines"
    description: "Number of Service Lines"

    hidden: yes
    type: count_distinct
    value_format_name: decimal_0

    sql: ${service_line} ;;
  }

  measure: num_campaign_groups {
    view_label: "3. Channel"
    group_label: "Z - Category Counts"
    label: "# Campaign Groups"
    description: "Number of Digital Channel Campaign Groups"

    hidden: yes
    type: count_distinct
    value_format_name: decimal_0

    sql: ${campaign_id} ;;
  }

  measure: num_campaigns {
    view_label: "3. Channel"
    group_label: "Z - Category Counts"
    label: "# Campaigns"
    description: "Number of Digital Channel Campaigns"

    hidden: yes
    type: count_distinct
    value_format_name: decimal_0

    sql: ${campaign_id} ;;
  }

  measure: num_adgroups {
    view_label: "3. Channel"
    group_label: "Z - Category Counts"
    label: "# Ad Groups"
    description: "Number of Digital Channel Ad Groups"

    hidden: yes
    type: count_distinct
    value_format_name: decimal_0

    sql: ${adgroup_id} ;;
  }

  ##########  MEASURES } ##########


  ##########  METADATA  {

  dimension: organization_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Organization ID [Arch_Program]"
    description: "Organization ID [Arch_Program]"

    hidden: yes

    type: string

    sql: ${TABLE}.organization_id ;;
  }

  dimension: account_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Account ID [Arch_Program]"
    description: "Account ID within given Channel [Arch_Program]"

    hidden: yes

    type: string

    sql: ${TABLE}.account_id ;;
  }

  dimension: campaign_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Campaign ID [Arch_Program]"
    description: "Campaign ID"

    hidden: yes

    type: string

    sql: ${TABLE}.campaign_id ;;
  }

  dimension: adgroup_id {
    view_label: "Z - Metadata"
    group_label: "Database IDs"
    label: "Adgroup ID [Arch_Program]"
    description: "Ad Group ID"

    hidden: yes
    primary_key: yes

    type: string

    sql: ${TABLE}.adgroup_id ;;
  }


  ##########  METADATA  }  ##########




}
