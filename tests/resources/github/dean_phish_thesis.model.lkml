connection: "dean_phish_data"

include: "/**/**/*.view"       # include all the views

datagroup: weekly {
  max_cache_age: "168 hours"
  sql_trigger: SELECT max(showid) FROM dean_looker_phish_thesis.phishnet_shows ;;
}

explore: phishin_tracks {
  label: "Live Tracks"
  view_label: "Live Tracks"
  join: phishin_tracks_tags {
    view_label: "Live Tracks"
    sql: LEFT JOIN UNNEST(${phishin_tracks.tags}) as phishin_tracks_tags ;;
    relationship: one_to_many
  }
  join: track_songids {
    view_label: "Live Tracks"
    sql_on: ${track_songids.track_id} = ${phishin_tracks.id} ;;
    relationship:  one_to_many
  }
  join: phishnet_songs {
    view_label: "Songs"
    sql_on: ${phishnet_songs.song_id} = ${track_songids.song_id} ;;
    relationship: one_to_many
  }
  join: shows_combined {
    view_label: "Live Shows"
    sql_on: ${phishin_tracks.show_date} = ${shows_combined.date_date} ;;
    relationship: many_to_one
  }

}



  explore: phishin_venues {
  label: "Phish Venues"
  join: shows_combined {
    type: left_outer
    sql_on: ${phishin_venues.id} = ${shows_combined.venueid} ;;
    relationship: one_to_many
  }
}

explore: shows_combined {
  label: "Shows"
  join: phishnet_ratings {
    sql_on: ${shows_combined.showdate} = ${phishnet_ratings.showdate_date} ;;
    relationship: one_to_one
  }
  join: phishin_venues {
    sql_on: ${shows_combined.venue_name} = ${phishin_venues.venue_name} ;;
    relationship: many_to_one

  }
}

explore: phishnet_songs {
  label: "Songs"
  join: phishin_tracks {
    view_label: "Tracks"
    sql_on: ${phishnet_songs.title} = ${phishin_tracks.title} ;;
    relationship: one_to_many
  }
#   join: phishin_tracks_tags {
#     view_label: "Tracks: Tags"
#     sql_on: ${phishin_tracks.id} = ${phishin_tracks_tags.track_id} ;;
#     relationship: one_to_many
#   }
  join: shows_combined {
    view_label: "Shows"
    sql_on: ${phishin_tracks.show_date}=${shows_combined.show_date};;
    relationship: many_to_one
  }
}

explore: track_songids {
  label: "Track Songs"
  join: phishin_tracks {
    sql_on: ${track_songids.track_id}=${phishin_tracks.id} ;;
    relationship: many_to_one
  }
  join: phishin_tracks_tags {
    view_label: "Live Tracks"
    sql: LEFT JOIN UNNEST(${phishin_tracks.tags}) as phishin_tracks_tags ;;
    relationship: one_to_many
  }
  join: phishnet_songs {
    sql_on: ${track_songids.song_id}=${phishnet_songs.song_id} ;;
    relationship: many_to_one
  }
}

# explore: phishin_tracks_tags {}
