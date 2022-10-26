//
//  Team.swift
//  CandyShop
//
//  Created by Supodoco on 25.10.2022.
//

import Foundation

struct Teammate {
    let name: String
    let surname: String
    let position: String
    
    var fullname: String {
        name + " " + surname
    }
    var image: String {
        fullname
    }
    
    static func getTeam() -> [Teammate] {
        [
            Teammate(
                name: "Kirill",
                surname: "Kuchmar",
                position: "Senior"
            ),
            Teammate(
                name: "Buba",
                surname: "",
                position: "Senior"
            ),
            Teammate(
                name: "Somebody",
                surname: "Some",
                position: "Junior"
            )
        ]
    }
}
