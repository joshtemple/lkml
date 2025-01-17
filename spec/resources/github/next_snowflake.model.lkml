connection: "nd_snowflake"

# include all the views
#include: "*.view"
include: "t8002_contentview_u.view"
include: "t8001_user_crossref.view"
include: "t4007_dashboard_yesterday.view"
include: "pdt_view_agg_with_article.view"

# include all the dashboards
include: "*.dashboard"

explore: t8002_contentview {}

explore: t8001_user_crossref {}

explore: t4007_dashboard_yesterday {}

explore: pdt_view_agg_with_article {}

# - explore: t1025_reg_prod_cid_title

# - explore: t3027_cid_day

# - explore: t3028_cid_artid_day

# - explore: t3029_cid_all_titles_day

# -explore: t8001_user_crossref

# - explore: t8001_user_crossref_test

# - explore: t8002_contentview_bad

# - explore: test_pk

# - explore: ua_connect_event

# - explore: user_crossref
