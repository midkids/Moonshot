//
//  CrewView.swift
//  Moonshot
//
//  Created by Myron Snelson on 6/4/26.
//

import SwiftUI

struct CrewView: View {
    // Use nested type MissionView.CrewMember again
    let crew: [MissionView.CrewMember]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
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
    let mission = missions[1]
    let crew: [MissionView.CrewMember] = mission.crew.compactMap { member in
        if let astro = astronauts[member.name] {
            return MissionView.CrewMember(role: member.role, astronaut: astro)
        } else { return nil }
    }
    return NavigationStack { CrewView(crew: crew) }
        .preferredColorScheme(.dark)
}
