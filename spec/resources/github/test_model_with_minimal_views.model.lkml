connection: "thelook_events_redshift"

# include: "/*.view"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

## when turning folders off. everything stays in its folder!
##note this is CASE sensitive
include: "/My_View_Folder_1/user_order_facts.view"
## pulls everything from subdirectories
include: "/test_folder_structure/**/*.view"
include: "/test_folder_structure/order_items.view"

explore: order_items {
  fields: [id]
}

explore: user_order_facts_2 {
  view_name: user_order_facts
}
