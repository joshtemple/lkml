connection: "c53-looker"

# include all the views
include: "*.view"

fiscal_month_offset: 0
week_start_day: sunday



explore: policy {
  group_label: "Looker Demo"
  label: "Diamond Policy"
  view_label: "Policy"

  access_filter: {
    field:company_state_lob.commercial_name1
    user_attribute:company_name
  }

  #persist_for: "4 hours"

  #Always exclude Quotes (status = Pending,Archived Quote,Denied), since this explore is for POLICY
  #Exclude converted policies
  sql_always_where: ${policy_current_status.description} NOT IN ('Pending','Archived Quote','Denied')
    AND ${policy.is_converted_policy} <> 'Yes'
    AND ${policy.current_policy} IS NOT NULL
    AND ${company_state_lob.state} = 'WV' ;;

    join: policy_current_status {
      view_label: "Policy"
      type: inner
      relationship: one_to_one
      sql_on: ${policy.policycurrentstatus_id} = ${policy_current_status.policycurrentstatus_id} ;;
    }

    join: dt_policy_holder_names {
      view_label: "Policy"
      type: inner
      relationship: one_to_one
      sql_on: ${policy.policy_id} = ${dt_policy_holder_names.policy_id} ;;
    }

    join: policy_image {
      view_label: "Policy Image"
      type: inner
      relationship: one_to_many
      sql_on: ${policy.policy_id} = ${policy_image.policy_id} ;;
    }

    join: policy_image_active {
      view_label: "Policy"
      type: inner
      relationship: one_to_one
      sql_on: ${policy.policy_id} = ${policy_image_active.policy_id} and
        ${policy.activeimage_num} = ${policy_image_active.policyimage_num};;
    }

    join: dt_agency {
      view_label: "Agency"
      type: inner
      relationship: one_to_many
      sql_on: ${policy_image.agency_id} = ${dt_agency.agency_id} ;;
    }

#   join: billing_invoice {
#     view_label: "Policy"
#     type: inner
#     sql_on: ${policy.policy_id} = ${billing_invoice.policy_id} ;;
#     relationship: one_to_one
#   }

    join: policy_image_trans_reason {
      view_label: "Policy Image"
      type: inner
      sql_on: ${policy_image.transreason_id} = ${policy_image_trans_reason.transreason_id} ;;
      relationship: one_to_one
    }

    join: policy_image_trans_type {
      view_label: "Policy Image"
      type: inner
      sql_on: ${policy_image.transtype_id} = ${policy_image_trans_type.transtype_id} ;;
      relationship: one_to_one
    }

#   join: policy_status_code {
#     view_label: "Policy Image"
#     type: inner
#     sql_on: ${policy_image.policystatuscode_id} = ${policy_status_code.policystatuscode_id} ;;
#     relationship: one_to_one
#   }

#   join:  policy_level {
#     view_label: "Policy Image"
#     type:  inner
#     relationship: many_to_many
#     sql_on: ${policy_image.policy_id} = ${policy_level.policy_id}
#       and ${policy_image.policyimage_num} = ${policy_level.policyimage_num};;
#   }

#     join: policy_underwriting {
#       view_label: "Policy Image"
#       type:  inner
#       relationship: one_to_many
#       fields: [policy_underwriting.underwriting_response]
#       sql_on: ${policy_image.policy_id} = ${policy_underwriting.policy_id}
#         and ${policy_image.policyimage_num} = ${policy_underwriting.policyimage_num};;
#     }

#   join:  policy_underwriting_code {
#     view_label: "Policy Image"
#     type:  inner
#     fields: [policy_underwriting_code.underwriting_question]
#     relationship: many_to_one
#     sql_on: ${policy_underwriting.policyunderwritingcode_id} = ${policy_underwriting_code.policyunderwritingcode_id};;
#   }

    join: version {
      type: inner
      sql_on: ${policy_image.version_id} = ${version.version_id} ;;
      relationship: many_to_one
    }

    join: company_state_lob {
      view_label: "Company"
      type: inner
      relationship: one_to_one
      sql_on: ${version.companystatelob_id} = ${company_state_lob.companystatelob_id} ;;
    }

    join: policy_image_name_link {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_many
      sql_on: ${policy_image.policy_id} = ${policy_image_name_link.policy_id}
              AND ${policy_image.policyimage_num} = ${policy_image_name_link.policyimage_num}
              AND ${policy_image_name_link.nameaddresssource_id} = 3   -- 3 is for Policy Holder;;
    }

    join: policy_holder_name {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_one
      sql_on: ${policy_image_name_link.name_id} = ${policy_holder_name.name_id}
        AND ${policy_holder_name.detailstatuscode_id} = 1 ;;
    }

    join: policy_holder_marital_status {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_one
      sql_on: ${policy_holder_name.maritalstatus_id} = ${policy_holder_marital_status.maritalstatus_id} ;;
    }

    join: policy_holder_gender {
      view_label: "Policy Holder"
      type: inner
      relationship: one_to_one
      sql_on: ${policy_holder_name.sex_id} = ${policy_holder_gender.sex_id} ;;
    }

    join: policy_location {
      view_label: "Location"
      type: left_outer
      sql_on: ${policy_image.policy_id} = ${policy_location.policy_id}
        AND ${policy_image.policyimage_num} = ${policy_location.policyimage_num}
        AND ${policy_location.detailstatuscode_id} = 1 ;;
      relationship: one_to_many
    }

    #
    # L     OOO   CCCC
    # L    O   O C
    # L    O   O C
    # LLLL  OOO   CCCC
    #

    join: policy_location_address_link {
      type: inner
      sql_on: ${policy_location.policy_id} = ${policy_location_address_link.policy_id}
            AND ${policy_location.policyimage_num} = ${policy_location_address_link.policyimage_num}
            AND ${policy_location.location_num} = ${policy_location_address_link.location_num} ;;
      relationship: one_to_many
    }

    join: policy_location_address {
      view_label: "Location"
      type: inner
      sql_on: ${policy_location_address_link.address_id} = ${policy_location_address.address_id} ;;
      relationship: one_to_one
    }

    join: policy_construction_type {
      view_label: "Location"
      type: inner
      sql_on: ${policy_location.contructiontype_id} = ${policy_construction_type.constructiontype_id} ;;
      relationship: one_to_one
    }

    join: policy_roof_type {
      view_label: "Location"
      type: inner
      sql_on: ${policy_location.rooftype_id} = ${policy_roof_type.rooftype_id} ;;
      relationship: one_to_one
    }

    join: policy_number_of_stories {
      view_label: "Location"
      type: inner
      sql_on: ${policy_location.numberofstoriestype_id} = ${policy_number_of_stories.numberofstoriestype_id} ;;
      relationship: one_to_one
    }

    join: policy_chimneys_type {
      view_label: "Location"
      type: inner
      sql_on: ${policy_location.numberofchimneystype_id} = ${policy_chimneys_type.numberofchimneystype_id} ;;
      relationship: one_to_one
    }

    #
    #  CCC  OOO  V     V
    # C    O   O  V   V
    # C    O   O   V V
    #  ccc  OOO     V
    #

    join: policy_coverage {
      view_label: "Coverage"
      type: left_outer
      sql_on: ${policy_image.policy_id} = ${policy_coverage.policy_id}
              AND ${policy_image.policyimage_num} = ${policy_coverage.policyimage_num}
              AND ${policy_location.location_num} = ${policy_coverage.unit_num}
              AND ${policy_coverage.detailstatuscode_id} = 1 ;;
      relationship: one_to_many
    }

    join: dt_policy_property_exposure {
      view_label: "Coverage"
      type: left_outer
      relationship: one_to_many
      sql_on: ${policy.policy_id} = ${dt_policy_property_exposure.policy_id}
              and ${policy.activeimage_num} = ${dt_policy_property_exposure.policyimage_num}
              and ${policy_location.location_num} = ${dt_policy_property_exposure.unit_num}
              and ${policy_coverage_code.coveragecode} = ${dt_policy_property_exposure.coveragecode}
              and ${dt_policy_property_exposure.detailstatuscode_id} = 1 ;;
    }

    join: policy_coverage_code {
      view_label: "Coverage"
      type: left_outer
      sql_on: ${policy_coverage.coveragecode_id} = ${policy_coverage_code.coveragecode_id}
        --and ${policy_coverage_code.coveragecode} IN ('loca','locb','locc','locd') ;;
      relationship: one_to_many
    }

    join: policy_coverage_limit {
      view_label: "Coverage"
      type: left_outer
      sql_on: ${policy_coverage.coveragelimit_id} = ${policy_coverage_limit.coveragelimit_id} ;;
      relationship: one_to_many
    }



    #
    # CLAIMS SECTION
    #

    join:  claim_control {
      view_label: "Claim"
      fields: [claim_control.claim_number, claim_control.loss_date_date, claim_control.count, claim_control.count_with_expense_paid,
        claim_control.count_with_indemnity_paid, claim_control.reported_date_date, claim_control.dscr]
      type: left_outer
      relationship: one_to_many
      sql_on: ${policy.policy_id} = ${claim_control.policy_id}  ;;
    }

    join: v_claim_detail_claimant {
      view_label: "Claimant"
      type: left_outer
      relationship: one_to_many
      sql_on: ${claim_control.claimcontrol_id} = ${v_claim_detail_claimant.claimcontrol_id} ;;
      fields: [v_claim_detail_claimant.claimcontrol_id, v_claim_detail_claimant.claimant_num, v_claim_detail_claimant.display_name,
        v_claim_detail_claimant.in_litigation, v_claim_detail_claimant.claimanttypedscr, v_claim_detail_claimant.relationshiptypedscr,
        v_claim_detail_claimant.status_dscr, v_claim_detail_claimant.is_litigated_represented]
    }

    join: v_claim_detail_feature {
      view_label: "Claim Feature"
      type: left_outer
      relationship: one_to_many
      sql_on: ${v_claim_detail_claimant.claimcontrol_id} = ${v_claim_detail_feature.claimcontrol_id}
              AND ${v_claim_detail_claimant.claimant_num} = ${v_claim_detail_feature.claimant_num}
              ;;
      fields: [v_claim_detail_feature.exposure_dscr, v_claim_detail_feature.subexposure_dscr, v_claim_detail_feature.coverage_dscr,
        v_claim_detail_feature.subcoverage_dscr, v_claim_detail_feature.status_dscr, v_claim_detail_feature.denied,
        v_claim_detail_feature.indemnity_paid, v_claim_detail_feature.expense_paid, v_claim_detail_feature.count,
        v_claim_detail_feature.sum_indemnity_reserve, v_claim_detail_feature.sum_indemnity_paid, v_claim_detail_feature.sum_expense_reserve,
        v_claim_detail_feature.sum_expense_paid, v_claim_detail_feature.sum_alae_reserve, v_claim_detail_feature.sum_alae_paid,
        sum_total_reserve_paid]
    }

    #
    #  V       V EEEEEE H    H
    #   V     V  E      H    H
    #    V   V   EEEE   HHHHHH
    #     V V    E      H    H
    #      V     EEEEEE H    H

    join: policy_vehicle {
      view_label: "Vehicle"
      type: left_outer
      sql_on: ${policy_image.policy_id} = ${policy_vehicle.policy_id}
              AND ${policy_image.policyimage_num} = ${policy_vehicle.policyimage_num}
              AND ${policy_vehicle.detailstatuscode_id} = 1 ;;
      sql_where: ${policy_vehicle.year} IS NOT NULL ;;
      relationship: one_to_many
    }

    join: policy_vehicle_body_type {
      view_label: "Vehicle"
      type: left_outer
      relationship: one_to_many
      sql_on: ${policy_vehicle_body_type.bodytype_id} = ${policy_vehicle.bodytype_id} ;;
    }
  }


  explore: claim_control {
    group_label: "Looker Demo"
    label: "Diamond Claims"
    view_label: "Claim"

    access_filter: {
      field:company_state_lob.commercial_name1
      user_attribute:company_name
    }

    #Exclude records without claim number
    sql_always_where: ${claim_number} > ''
          AND {% condition dt_claim_transactions_as_of.as_of_date %} claim_control.reported_date {% endcondition %}
          ;;

      #   join: claim_type {
      #     type: inner
      #     relationship: one_to_many
      #     sql_on: ${claim_type.claimtype_id} = ${claim_control.claim_type_id} ;;
      #   }

      join: dt_summarized_claim_financials {
        view_label: "Claim Financials (Summarized)"
        type: left_outer
        relationship: one_to_one
        sql_on: ${claim_control.claimcontrol_id} = ${dt_summarized_claim_financials.claimcontrol_id} ;;
      }

      join: dt_is_claim_litigated_represented {
        view_label: "Claim"
        type: inner
        relationship: one_to_one
        sql_on: ${claim_control.claimcontrol_id} = ${dt_is_claim_litigated_represented.claimcontrol_id} ;;
      }

      join: dt_claim_days_open {
        view_label: "Claim"
        type: inner
        relationship: one_to_one
        sql_on: ${dt_claim_days_open.claimcontrol_id} = ${claim_control.claimcontrol_id} ;;
      }

      join: claim_control_activity {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${claim_control_activity.claimcontrol_id}
          and ${claim_control_activity.num} = 1 ;;
      }

      join: dt_claims_first_activity {
        view_label: "Claim Acitivity"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claims_first_activity.claimcontrol_id}
          and ${dt_claims_first_activity.num} = 1 ;;
      }

      join: dt_claims_reopen_activity {
        view_label: "Claim Acitivity"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claims_reopen_activity.claimcontrol_id}
          and ${dt_claims_reopen_activity.num} > 1 ;;
      }

      join: dt_reopen_count {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_reopen_count.claimcontrol_id} ;;
      }

      join: dt_claim_close_date {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_close_date.claimcontrol_id} ;;
      }

      join: dt_close_count {
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_close_count.claimcontrol_id} ;;
      }

      join: dt_loss_location {
        view_label: "Loss Address"
        type: inner
        relationship: one_to_one
        sql_on: ${claim_control.claimcontrol_id} = ${dt_loss_location.claimcontrol_id} ;;
      }

      join: dt_policy_holder {
        view_label: "Policy Holder"
        type: left_outer
        relationship: one_to_many
        sql_on: ${dt_policy_holder.policy_id} = ${claim_control.policy_id};;
      }

      join: dt_weather_related {
        view_label: "Claim"
        type: inner
        relationship: one_to_many
        sql_on: ${dt_weather_related.claimcontrol_id} = ${claim_control.claimcontrol_id};;
      }

      join: claim_severity {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_severity.claimseverity_id} = ${claim_control.claimseverity_id} ;;
      }

      join: claim_control_status {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control_status.claimcontrolstatus_id} = ${claim_control.claimcontrolstatus_id} ;;
      }

      join: claim_fault {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_fault.claimfault_id} = ${claim_control.claimfault_id} ;;
      }

      join: claim_loss_type {
        type: inner
        relationship: one_to_many
        sql_on: ${claim_loss_type.claimlosstype_id} = ${claim_control.claimlosstype_id} ;;
      }

      join: v_claim_detail_claimant {
        view_label: "Claimant"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${v_claim_detail_claimant.claimcontrol_id} ;;
      }

      join: claimant {
        view_label: "Claimant"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${claimant.claimcontrol_id} ;;
      }

      join: dt_claimant_phone_home {
        view_label: "Claimant"
        type: left_outer
        relationship: one_to_many
        sql_on: ${dt_claimant_phone_home.claimcontrol_id} = ${claimant.claimcontrol_id}
          and ${dt_claimant_phone_home.claimant_num} = 1 ;;
      }

      join: dt_claimant_phone_cellular {
        view_label: "Claimant"
        type: left_outer
        relationship: one_to_many
        sql_on: ${dt_claimant_phone_cellular.claimcontrol_id} = ${claimant.claimcontrol_id}
          and ${dt_claimant_phone_cellular.claimant_num} = 1 ;;
      }

      join: dt_coverage_financials_bi {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_bi.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_bi.claimant_num};;
      }

      join: dt_coverage_financials {
        view_label: "Feature Financials"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials.claimant_num};;
      }

      join: dt_coverage_financials_pd {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_pd.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_pd.claimant_num};;
      }

      join: dt_coverage_financials_med {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_med.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_med.claimant_num};;
      }

      join: dt_coverage_financials_umbi {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_umbi.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_umbi.claimant_num};;
      }

      join: dt_coverage_financials_umpd {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_umpd.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_umpd.claimant_num};;
      }

      join: dt_coverage_financials_pip {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_pip.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_pip.claimant_num};;
      }

      join: dt_coverage_financials_comp {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_comp.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_comp.claimant_num};;
      }

      join: dt_coverage_financials_coll {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_coll.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_coll.claimant_num};;
      }

      join: dt_coverage_financials_rr {
        view_label: "Coverage Financials"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_coverage_financials_rr.claimcontrol_id}
          and ${v_claim_detail_claimant.claimant_num} = ${dt_coverage_financials_rr.claimant_num};;
      }

      join: dt_claim_inside_adjuster {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_inside_adjuster.claimcontrol_id} ;;
      }

      join: dt_claim_outside_adjuster {
        view_label: "Claim"
        type: left_outer
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_outside_adjuster.claimcontrol_id} ;;
      }

      join: dt_all_claimants_per_claim {
        view_label: "Claim"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_all_claimants_per_claim.claimcontrol_id};;
      }

      join: dt_insured_vehicle_driver {
        view_label: "Claim"
        type: inner
        relationship: one_to_many
        sql_on: ${claim_control.claimcontrol_id} = ${dt_insured_vehicle_driver.claimcontrol_id};;
      }

      join: v_claim_detail_feature {
        type: left_outer
        relationship: one_to_many
        sql_on: ${v_claim_detail_claimant.claimcontrol_id} = ${v_claim_detail_feature.claimcontrol_id}
              AND ${v_claim_detail_claimant.claimant_num} = ${v_claim_detail_feature.claimant_num}
              ;;
      }

      join: v_claim_detail_transaction {
        view_label: "Checks & Transactions"
        type: left_outer
        relationship: one_to_many
        sql_on: ${v_claim_detail_feature.claimcontrol_id} = ${v_claim_detail_transaction.claimcontrol_id}
              AND ${v_claim_detail_feature.claimant_num} = ${v_claim_detail_transaction.claimant_num}
              AND ${v_claim_detail_feature.claimfeature_num} = ${v_claim_detail_transaction.claimfeature_num}
              ;;
      #sql_where: ${v_claim_detail_transaction.check_number} between 1 and 99999999 ;;
        }

        join: claim_transaction {
          type: inner
          view_label: "Checks & Transactions"
          relationship: one_to_one
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${claim_transaction.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${claim_transaction.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${claim_transaction.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${claim_transaction.claimtransaction_num}
              ;;
        }

        join: dt_claim_transactions_as_of {
          type: left_outer
          view_label: "Claim Financials (As of Date)"
          relationship: many_to_many
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_claim_transactions_as_of.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_claim_transactions_as_of.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_claim_transactions_as_of.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_claim_transactions_as_of.claimtransaction_num}
              and ${dt_claim_transactions_as_of.calc} = 1
              ;;
        }

        join: dt_transaction_payee_type {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_transaction_payee_type.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_transaction_payee_type.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_transaction_payee_type.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_transaction_payee_type.claimtransaction_num}
              ;;
        }

        join: dt_transaction_payee_address {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.claimcontrol_id} = ${dt_transaction_payee_address.claimcontrol_id}
              and ${v_claim_detail_transaction.claimant_num} = ${dt_transaction_payee_address.claimant_num}
              and ${v_claim_detail_transaction.claimfeature_num} = ${dt_transaction_payee_address.claimfeature_num}
              and ${v_claim_detail_transaction.claimtransaction_num} = ${dt_transaction_payee_address.claimtransaction_num}
              ;;
        }

        join: dt_claim_status_as_of {
          type: inner
          view_label: "Claim Financials (As of Date)"
          relationship: one_to_one
          sql_on: ${claim_control.claimcontrol_id} = ${dt_claim_status_as_of.claimcontrol_id} ;;
        }

        join: claim_transaction_category {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.claimtransactioncategory_id} = ${claim_transaction_category.claimtransacationcategory_id} ;;
        }

        join: claim_pay_type {
          type: left_outer
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${claim_transaction.claimpaytype_id} = ${claim_pay_type.claimpaytype_id} ;;
        }

        join: check_status {
          type: inner
          view_label: "Checks & Transactions"
          relationship: one_to_many
          sql_on: ${v_claim_detail_transaction.checkstatus_id} = ${check_status.checkstatus_id} ;;
        }

        join: claim_catastrophe {
          view_label: "Claim CAT"
          type: left_outer
          sql_on: ${claim_catastrophe.claimcatastrophe_id} = ${claim_control.claimcatastrophe_id} ;;
          #sql_where: ${claim_catastrophe.claimcatastrophe_id} > 0 ;;
          relationship: one_to_one
        }

        join:  policy_for_claims {
          view_label: "Policy"
          type: left_outer
          relationship: many_to_one
          sql_on: ${policy_for_claims.policy_id} = ${claim_control.policy_id}  ;;
        }

        join: dt_policy_agency {
          view_label: "Policy"
          type: inner
          relationship: one_to_many
          sql_on: ${policy_for_claims.policy_id} = ${dt_policy_agency.policy_id} ;;
        }

        # join: current_status {
        #   view_label: "Policy"
        #   type: inner
        #   sql_on: ${policy.policycurrentstatus_id} = ${current_status.policycurrentstatus_id} ;;
        #   relationship: one_to_one
        # }

        join: policy_image {
          view_label: "Policy Term"
          type: inner
          relationship: one_to_many
          sql_on: ${policy_for_claims.policy_id} = ${policy_image.policy_id} ;;
        }

        # join: policy_image_address_link {
        #   type:  inner
        #   sql_on: ${policy_image.policy_id} = ${policy_image_address_link.policy_id} AND ${policy_image.policyimage_num} = ${policy_image_address_link.policyimage_num} ;;
        #   relationship: one_to_many
        # }

        # join: policy_address {
        #   view_label: "Address"
        #   type:  inner
        #   sql_on:  ${policy_image_address_link.address_id} = ${policy_address.address_id};;
        #   relationship: one_to_one
        # }

        # join: name_address_source {
        #   view_label: "Address"
        #   type: inner
        #   sql_on: ${policy_address.nameaddresssource_id} = ${name_address_source.nameaddresssource_id} ;;
        #   relationship: one_to_one
        # }

        # join: state {
        #   view_label: "Address"
        #   type:  inner
        #   sql_on: ${policy_address.state_id} = ${state.state_id} ;;
        #   relationship:  one_to_one
        # }

        join: version {
          type: inner
          sql_on: ${policy_image.version_id} = ${version.version_id} ;;
          relationship: many_to_one
        }

        join: company_state_lob {
          view_label: "Company"
          type: inner
          sql_on: ${version.companystatelob_id} = ${company_state_lob.companystatelob_id} ;;
          relationship: one_to_one
        }
      }
