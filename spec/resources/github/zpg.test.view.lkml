view: all_categories {
  view_label: "Categories"
  derived_table: {
  sql:
    select distinct
      category
    from escal.vw_escal_categories
    union all
    select 'No Category'
  ;;
  }

  dimension: category {}
 }

view: all_priorities {
  view_label: "Categories"
  derived_table: {
    sql:
    select distinct
      priority
    from escal.vw_escal_detail
  ;;
  }

  dimension: priority {}
}

view: all_products {
  view_label: "Categories"
  derived_table: {
    sql:
    select distinct
      COMPONENT as product
    from escal.VW_ESCAL_COMPONENTS
  ;;
  }

  dimension: product {}
}
