view: event {
    measure: filtered {
        label: "A Filtered Measure"
        filters: [created_date: "7 Days", user.status: "-disabled"]
        drill_fields: [created_date, user.status]
    }
}