connection: "video_store"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

############ Model Configuration #############

datagroup: video_store_max_date {
  label: "Model Refresh On Latest Rental"
  sql_trigger: SELECT MAX(rental_date) FROM sakila.rental ;;
  max_cache_age: "24 hours"}
persist_with: video_store_max_date

########### Explore Configurations ###########

############# Marketing Dashboard/Explore #################

explore: rental {
  label: "Marketing Explore"
  sql_always_where: ${rental_month} >= '2005-05' AND ${rental_month} <= '2005-08';;

  join: payment {
    type: left_outer
    relationship: one_to_one
    sql_on: ${rental.rental_id} = ${payment.rental_id} ;;
  }

  join: customer {
    type: left_outer
    relationship: many_to_one
    sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
  }

  join: address {
    view_label: "Customer"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customer.address_id} = ${address.address_id} ;;
  }

  join: city {
    view_label: "Customer"
    type: left_outer
    relationship: many_to_one
    sql_on: ${address.city_id} = ${city.city_id} ;;
  }

  join: country {
    view_label: "Customer"
    type: left_outer
    relationship: many_to_one
    sql_on: ${city.country_id} = ${country.country_id} ;;
  }

  join: customer_facts {
    view_label: "Customer"
    type: left_outer
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${customer_facts.customer_id} ;;
  }

  join: inventory {
    type: left_outer
    relationship: many_to_one
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
  }

  join: film_category {
    view_label: "Film Info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film_category.film_id} ;;
  }

  join: category {
    view_label: "Film Info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${film_category.category_id} = ${category.category_id} ;;
  }

  join: film {
    view_label: "Film Info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
  }
}

############# Executive Dashboard/Explore #################

explore: rental_2 {
  from: rental
  view_label: "Rental Info"
  label: "Executive Explore"
  sql_always_where: ${rental_month} >= '2005-05' AND ${rental_month} <= '2005-08';;

  join: payment {
    view_label: "Payment Info"
    type: left_outer
    relationship: one_to_one
    sql_on: ${rental_2.rental_id} = ${payment.rental_id} ;;
  }

  join: customer {
    type: left_outer
    relationship: many_to_one
    sql_on: ${rental_2.customer_id} = ${customer.customer_id} ;;
  }

  join: address {
    view_label: "Customer"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customer.address_id} = ${address.address_id} ;;
  }

  join: city {
    view_label: "Customer"
    type: left_outer
    relationship: many_to_one
    sql_on: ${address.city_id} = ${city.city_id} ;;
  }

  join: country {
    view_label: "Customer"
    type: left_outer
    relationship: many_to_one
    sql_on: ${city.country_id} = ${country.country_id} ;;
  }

  join: customer_facts {
    view_label: "Customer"
    type: left_outer
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${customer_facts.customer_id} ;;
  }

  join: inventory {
    type: left_outer
    relationship: many_to_one
    sql_on: ${rental_2.inventory_id} = ${inventory.inventory_id} ;;
  }

  join: store {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
  }

  join: film_category {
    view_label: "Film Info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film_category.film_id} ;;
  }

  join: category {
    view_label: "Film Info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${film_category.category_id} = ${category.category_id} ;;
  }

  join: film {
    view_label: "Film Info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
  }
}
