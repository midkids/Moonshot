//
//  CrewView.swift
//  Moonshot
//
//  Created by Myron Snelson on 6/4/26.
//

import SwiftUI

struct CrewView: View {
    // Use nested type MissionView.CrewMember again
    // This data will be passed to this view
    // from the MissionView and will be an array
    // of just the crew members for the mission
    // being displyed in MissionView
    let crew: [MissionView.CrewMember]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // The role is unique for a given mission
                ForEach(crew, id: \.role) { crewMember in
                    // The first trailing closure is the
                    // destination (what you navigate to).
                    // Here, you pass the tapped
                    // crewMember.astronaut into AstronautView.
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                        // The label closure defines what’s visible
                        // in the current view — your custom row UI.
                    } label: {
                        HStack {
                            // Images stored in Xcassets with
                            // a key of astronaut id (name)
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(Capsule()
                                    .strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    // Minimal preview using sample data if available
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    // Here we hard code the mission to make preview work
    let mission = missions[1]
    let crew: [MissionView.CrewMember] = mission.crew.compactMap { member in
        if let astro = astronauts[member.name] {
            return MissionView.CrewMember(role: member.role, astronaut: astro)
        } else { return nil }
    }
    // return CrewView(crew: crew)
    //    .preferredColorScheme(.dark)
    // If we return a Navigation Stack instead of
    // the CrewView, we can navigate to the Astronaut View
    // in the preview view
    // Otherwise, the CrewView would look the same
    // in the preview using the hardcoded mission[1] crew
    return NavigationStack { CrewView(crew: crew) }
        .preferredColorScheme(.dark)
}
