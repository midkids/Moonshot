//
//  Astronaut.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/22/26.
//

import Foundation

struct Astronaut:Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

// We want to make a dictionary of astronaut instances
// To do so, we must
// 1) use the bundle of our app to find the path to our file
// 2) load that into an instance of data
// 3) then pass it through decoder
// IMPORTANT: This is a much better way of doing the above
//   than doing it in method in ContentView
//  We are going to create an extension on Bundle itself
//    which will allow us to do the above steps
//    all in one centralized place


