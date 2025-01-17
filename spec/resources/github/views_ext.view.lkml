include: "//core_project/core.explore.lkml"
include: "*.view.lkml"

view: order_items {
  extends: [order_items_core]
}
view: orders {
  extends: [orders_core]
}
view: users {
  extends: [users_core]
}
view: products {
  extends: [products_core]
}
