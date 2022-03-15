view: lots_of_sets {
    set: a {
        fields: [
            , a
            , b
            , c
        ]
    }

    set: b { fields: [] }

    set: c { fields: [a, b, c] }

    set: d { fields: [ a , b , c ] }

    set: e { fields: [a, b, c,] }

    set: f {fields: [a, b, c  , ] }

    set: g {
        fields: [
            a, b, c,
        ]
    }

    set: g2 {
        fields: [a
        ,   b
        ,   c
        ]
    }

    set: h { 
        fields: [
            , a, b, c
        ]
    }

    set: i {
        fields: [
            , a, b, c , 
        ]
    }

    measure: j {
        filters: [a: "b", c: "d"]
    }

    measure: k {
        filters: [
            a: "b",
            c: "d"
        ]
    }

    measure: k {
        filters: [a: "b" ,
            c: "d",
        ]
    }

    measure: l {
        filters: [a: "b"
            , c: "d"
            , e: "f"
        ]
    }
}