connection: "snowflake_production"

include: "docker_www*.view.lkml"                       # include all views in this project

explore: docker_www_tracks {
  description: "Segment Track Calls (see segment.com/docs/spec/track)"
  label: "Track Calls"
  view_label: "Track"
}
explore: docker_www_pages {
  description: "Segment Page Calls (see segment.com/docs/spec/page/)"
  label: "Page View Calls"
  view_label: "Page View"
}
# NOT THERE YET
#explore: docker_www_identifies {
#  description: "Segment Identify Calls (see segment.com/docs/spec/identify/)"
#  label: "Identify Calls"
#  view_label: "Identify"
#}
explore: docker_www_roi_calculator_success {
  description: "ROI Calculator Successfully Used (see www.docker.com/roicalculator)"
  label: "ROI Calculator Successes"
  view_label: "ROI Calculator Successes"
}
explore: docker_www_roi_calculator_incomplete {
  description: "ROI Calculator Incomplete Use (see www.docker.com/roicalculator)"
  label: "ROI Calculator Incompletes"
  view_label: "ROI Calculator Incompletes"
}

test: test_there_page_views {
  explore_source: docker_www_pages {
    column: count {}
  }
  assert: page_views_exists {
    expression: ${docker_www_pages.count} > 0 ;;
  }
}
