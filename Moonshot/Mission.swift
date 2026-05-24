//
//  Mission.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/23/26.
//

import Foundation

// Since the Crewrole struct was made
// specifically to hold data about Missions,
// we can nest it inside the Mission struct
// struct CrewRole: Codable {
//    let name: String
//    let role: String
// }

// If you mark a property as optional
//  codable will automatically skip over it
//  if the value is missing from our input JSON
struct Mission: Codable, Identifiable {
    // nested struct
    // helps keep our code organized
    // To use: mission.crewrole
    // This extra context helps make the code
    //  more understandable
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
