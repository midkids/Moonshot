//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/22/26.
//

import Foundation

// We use an extension of Bundle rather than a method
// which allows us to move code out of ContentView
// This will help our ContentView remain small and focused
//
// We added some extra code to so that we can use in
//  in the future in other programs
// We will add extra code to help use diagnose problems
//  in case our SwiftUI code and our JSON file do not match up
//
// We will turn Bundle-Decoable from Astronaut specific
//  to a generic bundle decoder, able to decode both
//  a dictionary of Astronauts and arrays of Missions
// and potentially lots of other objects

extension Bundle {
    // func decode(_ file: String) -> [String: Astronaut] {
    // The angle brackets make it generic
    // "T" cold have been anything
    // "T" is used by convention to stand for type of something
    // Now we replace [String" Astronaut] with T
    // We add the constraint of Codeable to assure Swift whatever
    //  type T turns out to be will meet the Codeable protocol
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        // The y indicates the year is in its natual four digit format
        // The MM indicates the month is always two digits (e.g. 01)
        // IMPORTANT: Do not use mm for month, mm stands for minutes
        // The dd indicates the day is always two digits (e.g. 07)
        // These two statements tell our decoder how to decode
        //   any date it finds
        // Usually it is a good idea to specify timezone
        // But since were are displaying U.S. dates in the U.S
        //   there is no need to do so here
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        //guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
        //    fatalError("Failed to decode \(file) from bundle.")
        // }
        // return loaded
        do {
            // return try decoder.decode([String: Astronaut].self, from: data)
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to a missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to a type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
