view: content_ranking_new {
  derived_table: {
    sql: SELECT
        c.id, c.title, c.content_type, cv.group_id
        , overall.fav_count as overall_fav_count
        , overall.view_count as overall_view_count
        , overall.weighted_count as overall_weighted_count
        , sum(cv.view_count) as view_count
        , round(
              sum(cv.view_count * exp(-datediff(now(), CASE WHEN cv.start_of_week_date is null THEN '2017-01-01' ELSE cv.start_of_week_date END)
              / {% parameter time_decay %} )
              ),3)
              as weighted_count
      FROM metanewutf8.content_view cv
      JOIN
        ((SELECT d.id, cm.title as title, "dashboard" as content_type
          FROM metanewutf8.dashboard d
          JOIN metanewutf8.content_metadata cm
          ON d.id = cm.content_id AND cm.content_type = "dashboard")
          UNION ALL
        (SELECT l.id, cm.title as title, "look" as content_type
          FROM metanewutf8.look l
          JOIN metanewutf8.content_metadata cm
          ON l.id = cm.content_id AND cm.content_type = "look")) c
        ON c.id = cv.content_id
        AND c.content_type = cv.content_type
      JOIN
              (SELECT
                c.id, c.title, c.content_type
                , max(cv.favorite_count) as fav_count
                , sum(cv.view_count) as view_count
                , round(
                      sum(cv.view_count * exp(-datediff(now(), CASE WHEN cv.start_of_week_date is null THEN '2017-01-01' ELSE cv.start_of_week_date END)
                      / {% parameter time_decay %} )
                      ),3)
                      as weighted_count
              FROM metanewutf8.content_view cv
              JOIN
                ((SELECT d.id, cm.title as title, "dashboard" as content_type
                  FROM metanewutf8.dashboard d
                  JOIN metanewutf8.content_metadata cm
                  ON d.id = cm.content_id AND cm.content_type = "dashboard")
                  UNION ALL
                (SELECT l.id, cm.title as title, "look" as content_type
                  FROM metanewutf8.look l
                  JOIN metanewutf8.content_metadata cm
                  ON l.id = cm.content_id AND cm.content_type = "look")) c
                ON c.id = cv.content_id
                AND c.content_type = cv.content_type
              WHERE group_id = 1
              GROUP BY 1,2,3
              ORDER BY 2,1 asc) overall
          ON overall.id = cv.content_id
          AND overall.content_type = cv.content_type
      WHERE user_id IS NULL
      GROUP BY 1,2,3,4,5,6,7
      ORDER BY 2,1,4 asc
       ;;
  }

  filter: time_decay {
    type: string
  }

  #     - filter: weight_to_raw_percent
  #       type: string
  #
  #     - dimension: weight_to_raw_dim
  #       type: number
  #       sql: |
  #         CAST({% parameter weight_to_raw_percent %} / 100 * 1.00 as NUMERIC)

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: content_type {
    type: string
    sql: ${TABLE}.content_type ;;
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.group_id ;;
  }

  dimension: overall_fav_count {
    type: number
    sql: ${TABLE}.overall_fav_count ;;
  }

  dimension: overall_view_count {
    type: number
    sql: ${TABLE}.overall_view_count ;;
  }

  dimension: overall_weighted_count {
    type: number
    sql: ${TABLE}.overall_weighted_count ;;
  }

  dimension: view_count {
    type: number
    sql: ${TABLE}.view_count ;;
  }

  dimension: weighted_count {
    type: number
    sql: ${TABLE}.weighted_count ;;
  }
}
