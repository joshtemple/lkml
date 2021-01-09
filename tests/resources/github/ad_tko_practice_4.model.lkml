connection: "video_store"

include: "*.view.lkml"         # include all views in this project
# include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: caching_policy {
  max_cache_age: "24 hours"
  sql_trigger: select max(rental_id) from sakil.rental ;;
}

persist_with: caching_policy

datagroup: explore_caching_policy {
  max_cache_age: "1 hour"
  sql_trigger: select max(rental_id) from sakil.rental ;;
}

# aggregate customer information

explore: customer {
  persist_with: explore_caching_policy
  hidden: yes
  label: "Customer Information"
  from: customer
  view_label: "Customer Info"

  join: customer_rental_facts {
    type: left_outer
    sql_on: ${customer.customer_id} = ${customer_rental_facts.customer_id} ;;
    relationship: one_to_one
  }

  join: customer_address {
    from: address
    view_label: "Customer Info"
    fields:[customer_address.address, customer_address.district, customer_address.postal_code, customer_address.phone ]
    type: left_outer
    sql_on: ${customer.address_id} = ${customer_address.address_id} ;;
    relationship: many_to_one
  }

  join: customer_city {
    from: city
    view_label: "Customer Info"
    fields:[customer_city.city]
    type: left_outer
    sql_on: ${customer_address.city_id} = ${customer_city.city_id} ;;
    relationship: many_to_one
  }

  join: customer_country {
    from: country
    view_label: "Customer Info"
    fields:[customer_country.country]
    type: left_outer
    sql_on: ${customer_city.country_id} = ${customer_country.country_id} ;;
    relationship: many_to_one
  }
}


explore: rental {
  label: "Rental Information"
  from: rental
  persist_with: explore_caching_policy

  # added to ensure we evaluate complete only months with representative data
  always_filter: {
    filters: {
      field: rental_date
      value: "2005/05/01 to 2005/09/01"
    }
  }

  join: rental_history_facts {
    type: left_outer
    sql_on: ${rental.rental_id} = ${rental_history_facts.rental_id} ;;
    relationship: one_to_one
  }

  join: payment {
    view_label: "Rental"
    type: left_outer
    sql_on: ${rental.rental_id} = ${payment.rental_id} ;;
    relationship: one_to_one
  }

  join: inventory {
    type: left_outer
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
    relationship: many_to_one #because one inventory item can be shared across multiple rental ids
  }

  # aggregate customer information

  join: customer {
    view_label: "Customer Details"
    type: left_outer
    sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }

  join: customer_rental_facts {
    view_label: "Customer Details"
    type: left_outer
    sql_on: ${customer.customer_id} = ${customer_rental_facts.customer_id} ;;
    relationship: one_to_one
  }
  join: customer_address {
    from: address
    view_label: "Customer Details"
    fields:[customer_address.address, customer_address.district, customer_address.postal_code, customer_address.phone ]
    type: left_outer
    sql_on: ${customer.address_id} = ${customer_address.address_id} ;;
    relationship: many_to_one
  }

  join: customer_city {
    from: city
    view_label: "Customer Details"
    fields:[customer_city.city]
    type: left_outer
    sql_on: ${customer_address.city_id} = ${customer_city.city_id} ;;
    relationship: many_to_one
  }

  join: customer_country {
    from: country
    view_label: "Customer Details"
    fields:[customer_country.country]
    type: left_outer
    sql_on: ${customer_city.country_id} = ${customer_country.country_id} ;;
    relationship: many_to_one
  }

  # aggregate store information

  join: store {
    view_label: "Store Details"
    type:  left_outer
    sql_on: ${inventory.store_id} = ${store.store_id}  ;;
    relationship: many_to_one
  }

  join: store_address {
    from: address
    view_label: "Store Details"
    fields:[store_address.address, store_address.district, store_address.postal_code, store_address.phone]
    type: left_outer
    sql_on: ${store.address_id} = ${store_address.address_id} ;;
    relationship: one_to_one
  }

  join: store_city {
    from: city
    view_label: "Store Details"
    fields: [store_city.city]
    type: left_outer
    sql_on: ${store_address.city_id} = ${store_city.city_id} ;;
    relationship: many_to_one
  }

  join: store_country {
    from: country
    view_label: "Store Details"
    fields: [store_country.country]
    type: left_outer
    sql_on: ${store_city.country_id} = ${store_country.country_id} ;;
    relationship: many_to_one
  }

  # aggregate film information

  join: film {
    view_label: "Film Details"
    type:  left_outer
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    relationship: many_to_one
  }

  join: language {
    view_label: "Film Details"
    type: left_outer
    sql_on: ${film.language_id} = ${language.language_id};;
    relationship: many_to_one
  }

  join: film_category {
    view_label: "Film Details"
    type: left_outer
    sql_on: ${inventory.film_id} = ${film_category.film_id};;
    relationship: many_to_one
  }

  join: category {
    view_label: "Film Details"
    type: left_outer
    sql_on: ${film_category.category_id} = ${category.category_id} ;;
    relationship: many_to_one
  }

}
