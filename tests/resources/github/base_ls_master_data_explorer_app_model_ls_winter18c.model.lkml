include: "base_ls_explores_ls_winter18c.model.lkml"

label: "Master Data"

explore: customer {
  from: mn_customer_dim_reuse
  view_name: mn_customer_dim_reuse_md
  label: "Customers"
  view_label: "General Information"
  fields:[mn_customer_dim_reuse_md.md_customer_set*, mn_plan_dim_md.md_pbm_plan_set*,mn_plan_formulary_map_md.md_plan_formulary_set*,mn_formulary_dim_md.md_formulary_set*,
    mn_cust_atr_er_lns_fact_bd_md.md_benefit_design_set*,mn_cust_atr_er_lns_fact_nl_md.md_num_lives_set*,mn_customer_ids_dim_md.customer_ids_set*,
    mn_user_contact_fact_md.md_cust_contact_set*, mn_custaddr_fact_md.cust_addr_set*,mn_customer_cot_dim_md.md_customer_cot_set*,mn_cot_dim_md.md_cot_set*,
    mn_customer_dim_reuse_md.md_customer_status_set*,mn_customer_attr_fact_md.cust_attr_set*,mn_customer_map_md.md_customer_map_set*,mn_cust_dim_resue_mem_md.md_members_set*,
    mn_cot_dim_mem_md.md_cot_set*]

  hidden: no

  join: mn_plan_dim_md {
    from: mn_customer_dim_reuse
    type: left_outer
    relationship: one_to_one
    view_label: "Plan Formulary"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_plan_dim_md.customer_wid} and upper(${mn_plan_dim_md.member_info_type}) = 'PLAN'  ;;
#     fields: [mn_plan_dim_md.md_pbm_plan_set*]
  }

  join: mn_plan_formulary_map_md {
    from: mn_plan_formulary_map_ext
    type: left_outer
    relationship: one_to_many
    view_label: "Plan Formulary"
    sql_on: ${mn_plan_dim_md.customer_wid} = ${mn_plan_formulary_map_md.plan_wid}  ;;
#     fields: [mn_plan_formulary_map.md_plan_formulary_set*]
  }

  join: mn_formulary_dim_md {
    from: mn_formulary_dim
    type: left_outer
    relationship: many_to_one
    view_label: "Plan Formulary"
    sql_on: ${mn_formulary_dim_md.formulary_wid} = ${mn_plan_formulary_map_md.formulary_wid};;
#     fields: [mn_formulary_dim.md_formulary_set*]
  }

#   join: mn_cust_attr_fact_ben_des {
#     from: mn_customer_attr_fact
#     type: left_outer
#     relationship: one_to_many
#     view_label: "Benefit Design"
#     sql_on: ${mn_customer_dim_md.customer_wid} = ${mn_cust_attr_fact_ben_des.customer_wid} and upper(${mn_cust_attr_fact_ben_des.attr_name} = 'BENEFITDESIGN' ;;
#   }

  join:  mn_cust_atr_er_lns_fact_bd_md {
    from: mn_cust_attr_err_lines_fact
    type: left_outer
    relationship: one_to_many
    view_label: "Benefit Design Error Lines"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_cust_atr_er_lns_fact_bd_md.pbm_wid} and upper(${mn_cust_atr_er_lns_fact_bd_md.attribute_type}) = 'BENEFITDESIGN' ;;
#     fields: [mn_cust_attr_err_lines_fact_bd.md_benefit_design_set*]
  }

#   join: mn_cust_attr_fact_num_lives {
#     from: mn_customer_attr_fact
#     type: left_outer
#     relationship: one_to_many
#     view_label: "Plan Lives"
#     sql_on: ${mn_customer_dim_md.customer_wid} = ${mn_cust_attr_fact_num_lives.customer_wid} and upper(${mn_cust_attr_fact_num_lives.attr_name} = 'NUMBEROFLIVES' ;;
#   }

  join:  mn_cust_atr_er_lns_fact_nl_md {
    from: mn_cust_attr_err_lines_fact
    type: left_outer
    relationship: one_to_many
    view_label: "Plan Lives Error Lines"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_cust_atr_er_lns_fact_nl_md.pbm_wid} and upper(${mn_cust_atr_er_lns_fact_nl_md.attribute_type}) = 'NUMBEROFLIVES' ;;
#     fields: [mn_cust_attr_err_lines_fact_nl.md_num_lives_set*]
  }

  join: mn_customer_ids_dim_md {
    from: mn_customer_ids_dim_ext
    type: left_outer
    relationship: one_to_many
    view_label: "Identification"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_customer_ids_dim_md.customer_wid} ;;
  }

  join: mn_user_contact_fact_md {
    from: mn_user_contact_fact
    type: left_outer
    relationship: one_to_many
    view_label: "Contacts"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_user_contact_fact_md.user_wid} and ${mn_user_contact_fact_md.src_sys_mgr_id} = '50108';;
#     fields: [mn_user_contact_fact.md_cust_contact_set*]
  }

  join: mn_custaddr_fact_md {
    from: mn_customer_addr_fact
    type: left_outer
    relationship: one_to_many
    view_label: "Addresses"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_custaddr_fact_md.customer_wid} ;;
  }

  join: mn_customer_cot_dim_md {
    from: mn_customer_cot_dim_ext
    type: left_outer
    relationship: one_to_many
    view_label: "Class of Trade"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_customer_cot_dim_md.customer_wid} ;;
#     fields: [mn_customer_cot_dim_md.md_customer_cot_set*]
  }

  join: mn_cot_dim_md {
    from: mn_cot_dim_ext
    type: left_outer
    relationship: many_to_one
    view_label: "Class of Trade"
    sql_on: ${mn_customer_cot_dim_md.cot_wid} = ${mn_cot_dim_md.cot_wid} ;;
#     fields: [mn_cot_dim_md.md_cot_set*]
  }

  join: mn_customer_attr_fact_md {
    from: mn_customer_attr_fact
    type: left_outer
    relationship: one_to_many
    view_label: "Effective Dated Attributes"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_customer_attr_fact_md.customer_wid} ;;
  }

  join: mn_customer_map_md {
    from: mn_customer_map
    type: left_outer
    relationship: one_to_many
    view_label: "Members"
    sql_on: ${mn_customer_dim_reuse_md.customer_wid} = ${mn_customer_map_md.parent_cust_wid} AND ${mn_customer_map_md.mem_level} <> 0 ;;
  }

  join: mn_cust_dim_resue_mem_md {
    from: mn_customer_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Members"
    sql_on: ${mn_customer_map_md.child_cust_wid} = ${mn_cust_dim_resue_mem_md.customer_wid} ;;
  }

  join: mn_cust_cot_dim_mem_md {
    from: mn_customer_cot_dim_ext
    type: left_outer
    relationship: one_to_many
    view_label: "Members"
    sql_on: ${mn_cust_dim_resue_mem_md.customer_wid} = ${mn_cust_cot_dim_mem_md.customer_wid} AND SYSDATE>=${mn_cust_cot_dim_mem_md.eff_start_raw} AND SYSDATE<=${mn_cust_cot_dim_mem_md.eff_end_raw} ;;
  }

  join: mn_cot_dim_mem_md {
    from: mn_cot_dim_ext
    type: left_outer
    relationship: many_to_one
    view_label: "Members"
    sql_on: ${mn_cust_cot_dim_mem_md.cot_wid} = ${mn_cot_dim_mem_md.cot_wid} ;;
#     fields: [mn_cot_dim_mem_md.md_cot_set*]
  }


}

# MEMBERSHIP EXPLORE
# MEMBERSHIP Attributes

explore: membership {
  from: mn_customer_dim_reuse
  view_name: mn_cust_dim_ms
  label: "Membership"
  view_label: "Membership"
  fields: [mn_cust_dim_ms.membership_set*,mn_cot_dim_ms.membership_set*,mn_cust_map_ms.members_set*,mn_cust_dim_members_ms.members_set*,
    mn_cot_dim_members_ms.members_set*,mn_cust_dim_members_pc_ms.members_pc_set*]

  hidden: no

  join: mn_cust_map_ms {
    from: mn_customer_map
    type: left_outer
    relationship: one_to_many
    view_label: "Member"
    sql_on: ${mn_cust_dim_ms.customer_wid} = ${mn_cust_map_ms.parent_cust_wid} and ${mn_cust_map_ms.mem_level} = 1;;
  }

  join: mn_cust_cot_dim_ms {
    from: mn_customer_cot_dim
    type: left_outer
    relationship: one_to_many
    #view_label: "Customer COT"
    sql_on: ${mn_cust_dim_ms.customer_wid} = ${mn_cust_cot_dim_ms.customer_wid} ;;
  }

  join: mn_cot_dim_ms {
    from: mn_cot_dim_ext
    type: left_outer
    relationship: many_to_one
    view_label: "Membership"
    sql_on: ${mn_cust_cot_dim_ms.cot_wid} = ${mn_cot_dim_ms.cot_wid} ;;
  }

# MEMBER Attributes

  join: mn_cust_dim_members_ms {
    from: mn_customer_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Member"
    sql_on: ${mn_cust_map_ms.child_cust_wid} = ${mn_cust_dim_members_ms.customer_wid};;
  }

  join: mn_cust_cot_dim_members_ms {
    from: mn_customer_cot_dim
    type: left_outer
    relationship: one_to_many
    view_label: "Customer COT"
    sql_on: ${mn_cust_dim_members_ms.customer_wid} = ${mn_cust_cot_dim_members_ms.customer_wid} ;;
  }

  join: mn_cot_dim_members_ms {
    from: mn_cot_dim_ext
    type: left_outer
    relationship: many_to_one
    view_label: "Member"
    sql_on: ${mn_cust_cot_dim_members_ms.cot_wid} = ${mn_cot_dim_members_ms.cot_wid} ;;
  }

  join: mn_cust_dim_members_pc_ms {
    from: mn_customer_dim_reuse
    type: left_outer
    relationship: many_to_one
    view_label: "Member"
    sql_on: ${mn_cust_map_ms.plan_cust_wid} = ${mn_cust_dim_members_pc_ms.customer_wid} ;;
  }
}
