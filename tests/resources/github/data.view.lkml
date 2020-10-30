view: data {
  sql_table_name: sr_fujifilm.data ;;


  dimension: classification {
    view_label: "Taxonomies"

    label: " Classification"
    type: string
    sql:case
        when ${TABLE}."category_level_3" is not null then ${TABLE}."category_level_3"
        when ${TABLE}."category_level_3" is null and ${TABLE}."category_level_2" is not null then ${TABLE}."category_level_2"
        when ${TABLE}."category_level_3" is null and ${TABLE}."category_level_2" is null and ${TABLE}."category_level_1" is not null then ${TABLE}."category_level_1"

        else null
        end;;


  }

measure:lead_time
{

  type: average
  sql: ${delivery_date_date}-${po_date_date} ;;
}
  dimension: account_asset_category {
    type: string
    sql: ${TABLE}.account_asset_category ;;
  }

  dimension: address_line_1 {
    type: string
    sql: ${TABLE}.address_line_1 ;;
  }

  dimension: address_line_2 {
    type: string
    sql: ${TABLE}.address_line_2 ;;
  }

  dimension: buyer_name {
    type: string
    sql: ${TABLE}.buyer_name ;;
  }

  dimension: category_code {
    type: string
    sql: ${TABLE}.category_code ;;
  }

  dimension: category_level_1 {
    view_label: "Taxonomies"
    type: string
    sql: ${TABLE}.category_level_1 ;;
    drill_fields: [category_level_2]

  }


  dimension: category_level_2 {
    view_label: "Taxonomies"
    type: string
    sql: ${TABLE}.category_level_2 ;;
    drill_fields: [category_level_3]
  }

  dimension: category_level_3 {
    view_label: "Taxonomies"
    type: string
    sql: ${TABLE}.category_level_3 ;;
    drill_fields: [category_level_4]
  }

  dimension: category_level_4 {
    view_label: "Taxonomies"
    hidden: yes
    type: string
    sql: ${TABLE}.category_level_4 ;;
  }

  dimension: category_level_5 {
    view_label: "Taxonomies"
    hidden: yes
    type: string
    sql: ${TABLE}.category_level_5 ;;
  }

  dimension: category_level_6 {
    view_label: "Taxonomies"
    hidden: yes
    type: string
    sql: ${TABLE}.category_level_6 ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: common_supplier_id {
    type: string
    sql: ${TABLE}.common_supplier_id ;;
  }

  dimension: cost_center_number {
    type: string
    sql: ${corrected_cost_center_number} ;;

  }

dimension: corrected_cost_center_number {
 type: string
label: "Cost Center"
    sql:case
        when ${TABLE}."cost_center_number" is not  null AND ${TABLE}."project_number" LIKE 'P%' then 'Capital Project'
       when ${TABLE}."cost_center_number" is not  null AND ${TABLE}."project_number" LIKE'E%' then 'Client Project'
       when ${TABLE}."cost_center_number" is not null then ${TABLE}."cost_center_number"
      else   null
       end;;

  }


# dimension:new_cost_center_spend{
#   type: number
#   sql: ${total_spend}-${total_spend} where ${corrected_cost_center_number}='-EMPTY' ;;
# }

# dimension: corrected_cost_center_number_spend {
#   type:
#   sql: ${total_spend}-${new_cost_center_spend} ;;
# }

  # measure: percent_spend
  # { view_label: "Percent"
  #   type: percent_of_total
  #   sql: ${total_spend};;
  #   value_format: "#0.0\%"
  # }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: credit_debit {
    type: string
    sql: ${TABLE}.credit_debit ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.currency_code ;;
  }

  dimension: data_source {
    type: string
    sql: ${TABLE}.data_source ;;
  }

  measure: spend_AP {

    type: sum
    sql: CASE
                      WHEN ${TABLE}.data_source = 'AP'  THEN ${TABLE}.spend_amount
                      ELSE null
                     END ;;
    value_format_name: usd_0
    }
  measure: spend_PO {

    type: sum
    sql: CASE
                      WHEN ${TABLE}.data_source = 'PO'  THEN ${TABLE}.spend_amount
                      ELSE null
                     END ;;
     value_format_name: usd_0
    }

  dimension_group: delivery_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.delivery_date ;;
  }

  dimension: doc_type {
    type: string
    sql: ${TABLE}.doc_type ;;
  }

  dimension: fiscal_year {
    type: string
    sql: ${TABLE}.fiscal_year ;;
  }

  dimension: gl_account {
    type: string
    sql: ${TABLE}.gl_account ;;
  }

  dimension: invoice_amount {
    type: number
    sql: ${TABLE}.invoice_amount ;;
  }

  dimension_group: invoice_date {
    type: time
    view_label: "Dates"
      label: "Invoice"
      datatype: date
      timeframes: [date,
       month,
       month_num,
       quarter,
       quarter_of_year,
       year
      ]

      sql: ${TABLE}.invoice_date ;;

    }


  dimension: invoice_line_number {
    type: string
    sql: ${TABLE}.invoice_line_number ;;
  }

  dimension: invoice_qty {
    type: string
    sql: ${TABLE}.invoice_qty ;;
  }

  dimension: invoice_uom {
    type: string
    sql: ${TABLE}.invoice_uom ;;
  }

  dimension: item_amount {
    type: string
    sql: ${TABLE}.item_amount ;;
  }

  dimension: item_description {
    type: string
    sql: ${TABLE}.item_description ;;
  }

  dimension: manufacture_ref {
    type: string
    sql: ${TABLE}.manufacture_ref ;;
  }

  dimension: material_description {
    type: string
    sql: ${TABLE}.material_description ;;
  }

  dimension: material_group {
    type: string
    sql: ${TABLE}.material_group ;;
  }

  dimension: material_group_cleansed {
    type: string
    sql: ${TABLE}.material_group_cleansed ;;
  }

  dimension: material_group_name {
    type: string
    sql: ${TABLE}.material_group_name ;;
  }

  dimension: material_group_name_cleansed {
    type: string
    sql: ${TABLE}.material_group_name_cleansed ;;
  }

  dimension: material_name {
    type: string
    sql: ${TABLE}.material_name ;;
  }

  dimension: month_filter {
    type: string
    sql: ${TABLE}.month_filter ;;
  }

  dimension: new_supplier {
    type: string
    sql: ${TABLE}.new_supplier ;;
  }

  dimension: non_spend {
    type: string
    sql: ${TABLE}.non_spend ;;
  }

  dimension: order_quantity {
    type: string
    sql: ${TABLE}.order_quantity ;;
  }

  measure: original_spend_amount {
    type: sum
    sql: ${TABLE}.original_spend_amount ;;
    value_format_name: usd_0
  }



  dimension: part_number {
    type: string
    sql: ${TABLE}.part_number ;;
  }

  dimension: payment_date {
    type: string
    view_label: "Dates"
    label: "Payment"
    sql: ${TABLE}.payment_date ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: plant {
    type: string
    sql: ${TABLE}.plant ;;
  }

  measure: po_amount {
    type: sum
    sql: ${TABLE}.po_amount ;;
  }

  dimension_group: po_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      month_num,
      quarter_of_year
      ]
    convert_tz: no
    sql: ${TABLE}.po_date ;;
  }

  dimension: po_line {
    type: string
    sql: ${TABLE}.po_line ;;
  }

  dimension: po_number {
    type: string
    sql: ${TABLE}.po_number ;;
  }

  dimension: project_number {
    type: string
    sql: ${TABLE}.project_number ;;
  }

  dimension: purchasing_group {
    type: string
    sql: ${TABLE}.purchasing_group ;;
  }

  dimension: purchasing_organization {
    type: string
    sql: ${TABLE}.purchasing_organization ;;
  }

  dimension: quarter_filter {
    type: string
    sql: ${TABLE}.quarter_filter ;;
  }

  dimension: rule_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.rule_id ;;
  }

  dimension: sap_invoice_no {
    type: string
    sql: ${TABLE}.sap_invoice_no ;;
  }

  measure: sap_invoice_count {
    view_label: "Invoice"
    type: count_distinct
    # sql: ${invoice_line_number} ;;
    sql: ${sap_invoice_no} ;;
    value_format_name: decimal_0
  }

  dimension: sourcing_group_1 {
    type: string
    sql: ${TABLE}.sourcing_group_1 ;;
  }

  dimension: sourcing_group_2 {
    type: string
    sql: ${TABLE}.sourcing_group_2 ;;
  }

  dimension: sourcing_group_3 {
    type: string
    sql: ${TABLE}.sourcing_group_3 ;;
  }

  dimension: sourcing_group_4 {
    type: string
    sql: ${TABLE}.sourcing_group_4 ;;
  }

  dimension: sourcing_group_5 {
    type: string
    sql: ${TABLE}.sourcing_group_5 ;;
  }

  dimension: sourcing_group_6 {
    type: string
    sql: ${TABLE}.sourcing_group_6 ;;
  }

  dimension: spend_amount {
    type: number
    sql: ${TABLE}.spend_amount ;;
  }

  dimension: spend_file_name {
    type: string
    sql: ${TABLE}.spend_file_name ;;
  }

  dimension: spend_id {
    type: string
    sql: ${TABLE}.spend_id ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: still_to_deliver {
    type: string
    sql: ${TABLE}.still_to_deliver ;;
  }

  dimension: supplier_name {
    type: string
    sql: ${TABLE}.supplier_name ;;
  }

  dimension: supplier_name_cleansed {
    type: string
    sql: ${TABLE}.supplier_name_cleansed ;;
  }

  dimension: supplier_parent_name {
    type: string
    sql: ${TABLE}.supplier_parent_name ;;
    drill_fields: [supplier_name]
    link: {
        label: "Link to Supplier Name  Explore"
        url: "/looks/3057?&f[data.supplier_parent_name]={{ value }}"
     }
  }

  dimension_group: transaction_date {
    datatype: date
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      month_num,
      fiscal_month_num,
      fiscal_quarter,
      quarter_of_year,
      fiscal_quarter_of_year,
      fiscal_year
    ]
    convert_tz: no
    sql: ${TABLE}.transaction_date ;;
    drill_fields: [transaction_date_month,transaction_date_quarter]
  }




  measure: Timeframe {
    type: string
    sql:  CONCAT((CONCAT(TO_CHAR(min(${transaction_date_date}), 'Mon-YY'),' to ')),TO_CHAR(max(${transaction_date_date}), 'Mon-YY')) ;;

  }
  dimension: vendor_catalog_ref {
    type: string
    sql: ${TABLE}.vendor_catalog_ref ;;
  }

  dimension: vendor_invoice_ref {
    type: string
    sql: ${TABLE}.vendor_invoice_ref ;;
  }

  dimension: vendor_ref {
    type: string
    sql: ${TABLE}.vendor_ref ;;
  }

  dimension: wbs_element {
    type: string
    sql: ${TABLE}.wbs_element ;;
  }

  dimension: year_filter {
    type: string
    sql: ${TABLE}.year_filter ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      buyer_name,
      supplier_parent_name,
      supplier_name,
      material_group_name,
      material_name,
      spend_file_name,
      rules.rule_id
    ]
  }



    dimension: account_description {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."account_description" ;;
    }

    dimension: account_description_long {
      view_label: "Account"
      hidden: yes
      type: string
      view_label: "Account"
      sql: ${TABLE}."account_description_long" ;;
    }

    dimension: account_group_description {
      view_label: "Account"
      hidden: yes
      type: string
      view_label: "Account"
      sql: ${TABLE}."account_group_description" ;;
    }

    dimension: account_id {
      view_label: "Account"
      hidden: yes
      type: string
      view_label: "Account"
      sql: ${TABLE}."account_id" ;;
    }

    dimension: account_type_description {
      view_label: "Account"
      hidden: yes
      type: string
      view_label: "Account"
      sql: ${TABLE}."account_type_description" ;;
    }

      dimension_group: accounting_date {
      view_label: "Dates"
      hidden: yes
      label: "Accounting"
      type: time
      datatype: date
      timeframes: [date,
       month,
       month_num,
       quarter,
       quarter_of_year,
       year
      ]
      sql: ${TABLE}.accounting_date ;;
      type: time
    }

    dimension: activity {
      type: string
      hidden: yes
      sql: ${TABLE}.activity ;;
      drill_fields: [supplier_name_cleansed, category]
    }

    dimension: address_1 {
      view_label: "Address"
      hidden: yes
      type: string
      sql: ${TABLE}."address_1" ;;
    }

    dimension: afe_dtn_num {
      hidden: yes
      type: string
      sql: ${TABLE}."afe_dtn_num" ;;
    }

    dimension: afe_dtn_num_description {
      hidden: yes
      type: string
      sql: ${TABLE}."afe_dtn_num_description" ;;
    }

    dimension: amount {
      type: string
      hidden: yes
      sql: ${TABLE}.amount ;;
    }

    dimension: ap_terms {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."ap_terms" ;;
    }


    dimension: approver_name {
      type: string
      hidden: yes
      sql: ${TABLE}."approver_name" ;;
    }

    dimension: business_purpose_description {
      type: string
      hidden: yes
      sql: ${TABLE}."business_purpose_description" ;;
    }

    dimension: business_unit {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."business_unit" ;;
    }

    dimension: buyer {
      type: string
      hidden: yes
      sql: ${TABLE}.buyer ;;
    }


    dimension: category_description {
      view_label: "Taxonomies"
      hidden: yes
      type: string
      sql: ${TABLE}."category_description" ;;
    }

    dimension: category {
      view_label: "Taxonomies"
      type: string
      sql:  CASE
            WHEN {% condition category_level_1 %} '' {% endcondition %} THEN
              ${category_level_1}
            WHEN {% condition category_level_1 %} ${category_level_1} {% endcondition %} THEN
              CASE
                WHEN {% condition category_level_2 %} '' {% endcondition %} THEN
                  ${category_level_2}
                WHEN {% condition category_level_2 %} ${category_level_2} {% endcondition %} THEN
                  CASE
                    WHEN {% condition category_level_3 %} '' {% endcondition %} THEN
                      ${category_level_3}
                    WHEN {% condition category_level_3 %} ${category_level_3} {% endcondition %} THEN
                      CASE
                        WHEN {% condition category_level_4 %} '' {% endcondition %} THEN
                          ${category_level_4}
                        WHEN {% condition category_level_4 %} ${category_level_4} {% endcondition %} THEN
                          CASE
                            WHEN {% condition category_level_5 %} '' {% endcondition %} THEN
                              ${category_level_5}
                            WHEN {% condition category_level_5 %} ${category_level_5} {% endcondition %} THEN
                              ${category_level_6}
                            ELSE NULL
                          END
                      END
                  END
              END
          END;;
    }

    dimension: commodity_code {
      view_label: "Taxonomies"
      hidden: yes
      type: string
      sql: ${TABLE}."commodity_code" ;;
    }

    dimension: company {
      type: string
      hidden: yes
      sql: ${TABLE}.company ;;
    }

    dimension: company_code {
      type: string
      hidden: yes
      sql: ${TABLE}."company_code" ;;
    }

    dimension: contract {
      type: string
      hidden: yes
      sql: ${TABLE}.contract ;;
    }

    dimension: cost_center {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."cost_center" ;;
    }
    dimension: cost_center_description {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."cost_center_description" ;;
    }

    dimension: country_cleansed {
      view_label: "Address"
      hidden: yes
      type: string
      sql: ${TABLE}."country_cleansed" ;;
    }

    dimension: department_code {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."department_code" ;;
    }

    dimension: department_description {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."department_description" ;;
    }

    dimension: department_group_campus {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."department_group_campus" ;;
    }

    dimension: department_group_description {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."department_group_description" ;;
    }

    dimension: department_group_vp_area {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."department_group_vp_area" ;;
    }

    dimension: department_name {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."department_name" ;;
    }

    dimension: deptid {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}.deptid ;;
    }

    dimension: descr254_mixed {
      type: string
      hidden: yes
      sql: ${TABLE}.descr254_mixed ;;
    }

    dimension: description {
      type: string
      hidden: yes
      sql: ${TABLE}.description ;;
    }

    dimension: distrib_line_number {
      type: string
      hidden: yes
      sql: ${TABLE}."distrib_line_number" ;;
    }

    dimension: distribution_line_qty {
      type: string
      hidden: yes
      sql: ${TABLE}."distribution_line_qty" ;;
    }

    dimension: district {
      type: string
      hidden: yes
      sql: ${TABLE}.district ;;
    }

    dimension_group: due_date {
      view_label: "Dates"
      hidden: yes
      label: "Due"
      type: time
      datatype: date
      timeframes: [date,
        month,
        month_num,
        quarter,
        quarter_of_year,
        year
        ]
      #sql: ${TABLE}.due_dt ;;
      sql: ${TABLE}.due_date ;;
    }

    dimension: emplid {
      type: string
      hidden: yes
      sql: ${TABLE}.emplid ;;
    }

    dimension: expense_subaccount {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."expense_subaccount" ;;
    }

    dimension: expense_type {
      type: string
      hidden: yes
      sql: ${TABLE}."expense_type" ;;
    }

    dimension: freight_amount {
      type: string
      hidden: yes
      sql: ${TABLE}."freight_amount" ;;
    }

    dimension: fund {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}.fund ;;
    }

    dimension: fund_description {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."fund_description" ;;
    }

    dimension: fund_group_description {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."fund_group_description" ;;
    }

    dimension: gl_account_description {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."gl_account_description" ;;
    }

    dimension: invoice_description {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."invoice_description" ;;
    }

    dimension: invoice_id {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."invoice_id" ;;
    }



    dimension: item_number {
      type: string
      hidden: yes
      sql: ${TABLE}."item_number" ;;
    }

    dimension: itm_id_vndr {
      type: string
      hidden: yes
      sql: ${TABLE}.itm_id_vndr ;;
    }

    dimension: justification_code {
      type: string
      hidden: yes
      sql: ${TABLE}."justification_code" ;;
    }


    dimension: location_latlong {
      type: location
      hidden: yes
      sql_latitude:${TABLE}.latitude;;
      sql_longitude:${TABLE}.longitude;;
      drill_fields: [supplier_name_cleansed, category_level_1,category_level_2,category_level_3,category_level_4,category_level_5]
    }

    dimension: supplier_state {
      view_label: "Supplier"
      label: "State"
      type: string
      map_layer_name: us_states
      sql: ${TABLE}.state ;;
      map_layer_name: us_states
      drill_fields: [supplier_name_cleansed, category_level_1,category_level_2,category_level_3,category_level_4,category_level_5]
    }

    dimension: location {
      type: string
      hidden: yes
      sql: ${TABLE}.location ;;
    }

    dimension: location_description {
      type: string
      hidden: yes
      sql: ${TABLE}."location_description" ;;
    }

    dimension: mcc_code {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."mcc_code" ;;
    }

    dimension: mcc_description {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}."mcc_description" ;;
    }

    dimension: merchandise_amount {
      type: string
      hidden: yes
      sql: ${TABLE}."merchandise_amount" ;;
    }

    dimension: merchant {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}.merchant ;;
    }

    dimension: mfg_id {
      type: string
      hidden: yes
      sql: ${TABLE}."mfg_id" ;;
    }

    dimension: mfg_itm_id {
      type: string
      hidden: yes
      sql: ${TABLE}."mfg_itm_id" ;;
    }

    dimension: misc_amount {
      type: string
      hidden: yes
      sql: ${TABLE}."misc_amount" ;;
    }

    dimension: monetary_amount {
      type: number
      hidden: yes
      sql: ${TABLE}."monetary_amount" ;;
    }

    dimension: name {
      type: string
      hidden: yes
      sql: ${TABLE}.name ;;
    }


    dimension: origin {
      type: string
      hidden: yes
      sql: ${TABLE}.origin ;;
    }

    dimension: payment_description {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."payment_description" ;;
    }

    dimension: payment_id_ref {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."payment_id_ref" ;;
    }
    dimension: pc_bus_unit {
      view_label: "BU/Dept"
      hidden: yes
      type: string
      sql: ${TABLE}."pc_bus_unit" ;;
    }

    dimension: po_account_description {
      view_label: "Account"
      hidden: yes
      label: "PO Account Description"
      type: string
      sql: ${TABLE}."po_account_description" ;;
    }

    dimension: po_description {
      view_label: "PO"
      hidden: yes
      label: "PO Description"
      type: string
      sql: ${TABLE}."po_description" ;;
    }

    dimension: po_item_description {
      view_label: "PO"
      hidden: yes
      label: "PO Item Description"
      type: string
      sql: ${TABLE}."po_item_description" ;;
    }


    dimension: po_line_description {
      view_label: "PO"
      hidden: yes
      label: "PO Line Description"
      type: string
      sql: ${TABLE}."po_line_description" ;;
    }


    dimension: po_status {
      view_label: "PO"
      hidden: yes
      label: "PO Status"
      type: string
      sql: ${TABLE}."po_status" ;;
    }

    dimension: post_date {
      #dimension_group: post_date {
      view_label: "Dates"
      hidden: yes
      label: "Post"
      #type: time
      #datatype: date
      #timeframes: [date,
      #  month,
      #  month_num,
      #  quarter, ,
      #  quarter_of_year,
      #  year]
      #sql: ${TABLE}.post_date ;;
      type: string
      sql: ${TABLE}.post_date_str ;;
    }

    dimension: postal_code {
      view_label: "Address"
      hidden: yes
      type: zipcode
      sql: ${TABLE}."postal_code" ;;
    }

    dimension: price_po {
      view_label: "PO"
      hidden: yes
      label: "PO Price"
      type: string
      sql: ${TABLE}."price_po" ;;
    }

    dimension: project {
      view_label: "Account"
      hidden: yes
      type: string
      sql: ${TABLE}.project ;;
    }

    dimension: qty_vchr {
      type: string
      hidden: yes
      sql: ${TABLE}.qty_vchr ;;
    }

    dimension: quantity {
      type: string
      hidden: yes
      sql: ${TABLE}.quantity ;;
    }

    dimension: quantity_invoiced {
      type: string
      hidden: yes
      sql: ${TABLE}."quantity_invoiced" ;;
    }

    dimension: reg_test {
      type: string
      hidden: yes
      sql: ${TABLE}.reg_test ;;
    }

    dimension: roll_stat_r {
      type: string
      hidden: yes
      sql: ${TABLE}."roll_stat_r" ;;
      }

    dimension: spend_type {
      type: string
      hidden: yes
      sql: ${TABLE}."spend_type" ;;
    }


    dimension: supplier_class {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}."supplier_class" ;;
    }

    dimension: supplier {
      view_label: "Supplier"
      type: string
      sql:  CASE
            WHEN {% condition supplier_parent_name %} '' {% endcondition %}
              THEN ${supplier_parent_name}
            WHEN {% condition supplier_parent_name %} ${supplier_parent_name} {% endcondition %}
              THEN ${supplier_name}
          END;;
    }
#
    dimension: supplier_number {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}."supplier_number" ;;
    }
    dimension: supplier_site {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}."supplier_site" ;;
    }

    dimension: supplier_terms {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}."supplier_terms" ;;
    }

    dimension: transaction_reference_number {
      view_label: "PO"
      hidden: yes
      type: string
      sql: ${TABLE}."transaction_reference_number" ;;
    }

    dimension: transaction_type {
      view_label: "PO"
      hidden: yes
      type: string
      sql: ${TABLE}."transaction_type" ;;
    }

    dimension: unit_of_measure {
      type: string
      hidden: yes
      sql: ${TABLE}."unit_of_measure" ;;
    }

    dimension: unit_price {
      type: string
      hidden: yes
      sql: ${TABLE}.unit_price ;;
    }

    dimension: ut_category_code {
      type: string
      hidden: yes
      sql: ${TABLE}."ut_category_code" ;;
    }

    dimension: vendor_id {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}."vendor_id" ;;
    }

    dimension: vendor_item_id {
      type: string
      hidden: yes
      hidden: yes
      sql: ${TABLE}."vendor_item_id" ;;
    }

    dimension: vendor_name {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}.vendor_name ;;
    }

    dimension: vendor_number {
      view_label: "Supplier"
      hidden: yes
      type: string
      sql: ${TABLE}."vendor_number" ;;
    }

    dimension: voucher_id {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."voucher_id" ;;
    }

    dimension: voucher_line_description {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."voucher_line_description" ;;
    }

    dimension: voucher_line_number {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."voucher_line_number" ;;
    }

    dimension: voucher_type_description {
      view_label: "Invoice"
      hidden: yes
      type: string
      sql: ${TABLE}."voucher_type_description" ;;
    }

    measure: total_spend {
      type: sum
      sql: ${spend_amount} ;;
      value_format_name: usd_0
    }

    filter: select_one_metric {
      hidden: yes
      type: string
      suggestions: ["Supplier Count", "Invoice Line Count", "Invoice Count", "Invoice Spend","PO Line Count", "PO Count", "PO Spend", "Spend"]
      default_value: "PO Spend"
    }

    measure: selected_metric {
      hidden: yes
      type: number
      sql: CASE
          WHEN {% parameter select_one_metric %} = 'Supplier Count' THEN ${supplier_count}
          WHEN {% parameter select_one_metric %} = 'Invoice Line Count' THEN ${invoice_line_count}
          WHEN {% parameter select_one_metric %} = 'Invoice Count' THEN ${invoice_count}
          WHEN {% parameter select_one_metric %} = 'Invoice Spend' THEN ${invoice_spend}
          WHEN {% parameter select_one_metric %} = 'PO Line Count' THEN ${po_line_count}
          WHEN {% parameter select_one_metric %} = 'PO Count' THEN ${po_count}
          WHEN {% parameter select_one_metric %} = 'PO Spend' THEN ${po_spend}
          WHEN {% parameter select_one_metric %} = 'Spend' THEN ${total_spend}
          ELSE ${po_spend}
        END;;
    }


    filter: select_one_dimension {
      hidden: yes
      type: string
      suggestions: ["Year", "Quarter", "Month"
        , "Fiscal Year", "Fiscal Quarter", "Fiscal Month"

        , "AFE DTE Description"
        , "Approver"
        , "Buyer Name"
        , "Compliance"
        , "Cost Center"
        , "Data Source"
        , "Department"
        , "File Name"
        , "Location"
        , "MCC Description"]

      default_value: "Month"
    }

    dimension: selected_dimension {
      hidden: yes
      type: string
      sql: CASE
          WHEN {% parameter select_one_dimension %} = 'Year' THEN to_char(${transaction_date_date},'YYYY')
          WHEN {% parameter select_one_dimension %} = 'Quarter' THEN (to_char(${transaction_date_date},'YYYY') || CAST('-' as VARCHAR) || ${transaction_date_quarter_of_year})
          WHEN {% parameter select_one_dimension %} = 'Month' THEN to_char(${transaction_date_date},'YYYY-MM')

          WHEN {% parameter select_one_dimension %} = 'Fiscal Year' THEN (CAST('FY' AS VARCHAR) || CAST(${transaction_date_fiscal_year} AS VARCHAR))
          WHEN {% parameter select_one_dimension %} = 'Fiscal Quarter' THEN (CAST('FY' AS VARCHAR) || ${transaction_date_fiscal_year} || CAST('-' as VARCHAR) || ${transaction_date_fiscal_quarter_of_year})
          WHEN {% parameter select_one_dimension %} = 'Fiscal Month' THEN (CAST('FY' AS VARCHAR) || ${transaction_date_fiscal_year} || CAST('-' as VARCHAR) ||

            RIGHT(
              CAST('0' AS VARCHAR)
              ||
              CAST(${transaction_date_fiscal_month_num} AS VARCHAR)
              ,2
            )
          )

          WHEN {% parameter select_one_dimension %} = 'AFE DTE Description' THEN ${afe_dtn_num_description}
          WHEN {% parameter select_one_dimension %} = 'Approver' THEN ${approver_name}
          WHEN {% parameter select_one_dimension %} = 'Buyer Name' THEN ${buyer}

          WHEN {% parameter select_one_dimension %} = 'Cost Center' THEN ${cost_center_description}
          WHEN {% parameter select_one_dimension %} = 'Data Source' THEN ${data_source}
          WHEN {% parameter select_one_dimension %} = 'Department' THEN ${department_name}
          WHEN {% parameter select_one_dimension %} = 'File Name' THEN ${spend_file_name}
          WHEN {% parameter select_one_dimension %} = 'Location' THEN ${location_description}
          WHEN {% parameter select_one_dimension %} = 'MCC Description' THEN ${mcc_description}

          ELSE to_char(${transaction_date_date},'YYYY-MM')
        END;;
    }



    measure: po_count_unfiltered {
      hidden: yes
      view_label: "PO"
      type: count_distinct
      sql: ${po_number} ;;
    }

    measure: po_count {
      type: count_distinct
      view_label: "PO"
      sql: ${po_number} ;;
    }

    dimension: has_po_number {
      hidden: yes
      view_label: "PO"
      type: yesno
      sql: ${po_number} != '';;
    }


    dimension: pcard_indicator {
      type: number
      hidden: yes
      sql: CASE
                      WHEN ${TABLE}.transaction_type = 'PCARD' THEN 1
                      ELSE 0
                     END ;;
    }

    measure: nonElectonicOrderType  {
      type:  sum
      hidden: yes
      sql: CASE WHEN ${TABLE}.transaction_type  !=''
        THEN 1 ELSE 0 END;;
      drill_fields: [data_source]
    }

    measure: ElectronicOrderType {
      type:  sum
      hidden: yes
      sql: CASE WHEN ${TABLE}.transaction_type  =''
        THEN 1 ELSE 0 END;;
      drill_fields: [transaction_type]
    }

    measure:  pcard_spend {
      type:sum
      hidden: yes
      sql: ${pcard_indicator} ;;
      value_format_name: usd_0

    }

    measure: po_line_count_unfiltered {
      hidden: yes
      view_label: "PO"
      type: count
      filters: {
        field: has_po_number
        value: "yes"
      }
    }

    measure: po_line_count {
      type: count
      view_label: "PO"
      filters: {
        field: has_po_number
        value: "yes"
      }
      filters: {
        field: non_spend
        value: "-Y"
      }
    }


    measure: po_spend {
      type: sum
      view_label: "PO"
      sql: CASE
                        WHEN ${po_number} != '' THEN ${spend_amount}
                        ELSE 0
                       END ;;
      drill_fields: [category_level_2, category_level_3, po_spend]
      value_format_name: usd_0
    }


    dimension: unclassified_indicator {
      type: number
      view_label: "Taxonomies"
      sql: CASE
                        WHEN ${classification} = '' THEN 1
                        ELSE 0
                       END ;;
    }

    measure:  classified_count {
      view_label: "Taxonomies"
      type:  sum
      sql: ${classified_indicator} ;;
    }

    measure:  unclassified_count {
      view_label: "Taxonomies"
      type:  sum
      sql: ${unclassified_indicator} ;;
    }

    dimension: classified_indicator {
      view_label: "Taxonomies"
      type: number
      sql: CASE
                      WHEN ${classification} != '' THEN 1
                      ELSE 0
                     END ;;
    }


    measure: line_count {
      type: count

    }

    measure: invoice_count_unfiltered {
      hidden: yes
      view_label: "Invoice"
      type: count_distinct
      sql: ${invoice_line_number} ;;
      value_format_name: decimal_0
    }

    measure: invoice_count {
      view_label: "Invoice"
      type: count_distinct
      sql: ${invoice_line_number} ;;
      value_format_name: decimal_0
   }

    dimension: has_invoice_line_number_no_po_number {
      hidden: yes
      view_label: "Invoice"
      type: yesno
      sql: ${po_number} = '' AND ${invoice_line_number} != '';;
    }

    measure: invoice_line_count_unfiltered {
      hidden: yes
      view_label: "Invoice"
      type: count
      filters: {
        field: has_invoice_line_number_no_po_number
        value: "yes"
      }
    }

    measure: invoice_line_count {
      view_label: "Invoice"
      type: count
      filters: {
        field: has_invoice_line_number_no_po_number
        value: "yes"
      }

    }

    measure: invoice_spend {
      view_label: "Invoice"
      hidden: yes
      type: sum
      sql: CASE
                      WHEN ${po_number} = '' AND ${sap_invoice_no} != '' THEN ${spend_amount}
                      ELSE 0
                     END ;;
      value_format_name: usd_0
    }

    measure: supplier_count_unfiltered {
      view_label: "Supplier"
      hidden: yes
      type: count_distinct
      sql: ${supplier_name_cleansed} ;;
      value_format_name: decimal_0
    }

    measure: supplier_count {
      view_label: "Supplier"
      hidden: no
      type: count_distinct
      sql: ${supplier_name_cleansed} ;;
      value_format_name: decimal_0
    }

    measure: original_supplier_count_unfiltered {
      view_label: "Supplier"
      hidden: yes
      type: count_distinct
      sql: ${TABLE}."supplier_name" ;;
    }

    measure: original_supplier_count {
      view_label: "Supplier"
      hidden: no
      type: count_distinct
      sql: ${TABLE}."supplier_name" ;;
    }

    measure:  supplier_parent_count_unfiltered {
      view_label: "Supplier"
      hidden: yes
      type:  count_distinct
      sql:  ${supplier_parent_name} ;;
    }

    measure:  supplier_parent_count {
      view_label: "Supplier"
      type:  count_distinct
      sql:  ${supplier_parent_name} ;;
    }

    measure: total_spend_this_month {
      type: sum
      sql: ${spend_amount} ;;
      filters: {
        field: transaction_date_date
        value: "this month"
      }
    }

    measure: total_spend_last_month {
      type: sum
      sql: ${spend_amount} ;;
      filters: {
        field: transaction_date_date
        value: "last month"
      }
    }

    measure: percent_spend_change_vs_last_month {
      type: number
      hidden: no
      sql:  CASE
                            WHEN ${total_spend_last_month} is NULL THEN 0
                            ELSE (${total_spend_this_month} - ${total_spend_last_month})/${total_spend_last_month})
                          END ;;
      value_format_name: percent_2
    }



    measure: supplier_spend_measure  {
      view_label: "Supplier"
      type:  sum
      sql:  ${spend_amount};;
      value_format_name: usd_0
      drill_fields: [supplier_name]

    }


  measure: total_spend_unfiltered {
    label: "Total Spend - All Data"
    type: sum
    sql: ${spend_amount} ;;
    value_format_name: usd_0
  }


    measure: total_spend_running_total {
    type: running_total
      sql: ${total_spend} ;;
      value_format_name: usd
    }


    filter: select_spend_metric {
      hidden: yes
      type: string
      suggestions: ["Invoice Spend", "PO Spend", "Total Spend"]
      default_value: "Total Spend"
    }
    measure: selected_spend_metric {
      hidden: yes
      type: number
      sql: CASE
          WHEN {% parameter select_spend_metric %} = 'Invoice Spend' THEN ${invoice_spend}
          WHEN {% parameter select_spend_metric %} = 'PO Spend' THEN ${po_spend}
          WHEN {% parameter select_spend_metric %} = 'Total Spend' THEN ${total_spend}
          ELSE ${total_spend}
        END;;
      value_format_name: usd
    }

    dimension: Category_Classification_Depth {
      type: string
      sql: CASE WHEN  LEN(data."category_code") = 2  THEN 'Level 1'
             WHEN LEN(data."category_code") = 5  THEN 'Level 2'
             WHEN LEN(data."category_code") = 8  THEN 'Level 3'
             WHEN data."category_code" = ''  THEN 'Unclassified'
        ELSE  data."category_code"  END ;;

      }



}
