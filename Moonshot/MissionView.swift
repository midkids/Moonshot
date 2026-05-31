//
//  MissionView.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/26/26.
//
// This view must have a size set from the parent

import SwiftUI

struct MissionView: View {
    
    // CrewMember struct
    // that is nested within the
    // MissionView struct
    // and includes the Astronaut struct
    // IMPORTANT: an astronaut can be
    // included in more than one mission
    // and can play different roles
    // on different missions
    struct CrewMember {
        // What role the astronaut filled
        // on this mission
        let role: String
        // description of astronaut
        let astronaut: Astronaut
    }
    let mission: Mission
    // An array of our CrewMember objects
    // It will be fully resolved,
    // meaning all combinations of
    // role + astronaut from
    // both JSON files
    // We will loop over all the missions
    // and all its astronauts so we can
    // populate this array with all the
    // unique crews
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            // The mission image will be displayed
            // by this outer VStack
            // which is centered by default
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                // width is the with of the parent
                    .containerRelativeFrame(.horizontal) {
                        containerWidth,axis in containerWidth * 0.6
                }
                
                
                // The text Mission Highlights
                // and the mission description
                // will align to the leading edge
                VStack(alignment: .leading) {
                    
                    // Built in divider
                    // It is barely visible and not very customizeable
                    // Divider()
                    // So we will create a custom divider
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                    // will cause this text to stay away
                    // from whatever is below it
                    // in this case, the description
                        .padding(.bottom, 5)
                    Text(mission.description)
                    
                    // Here is that same as above
                    // custom divider
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    // Placing this title inside the VStack
                    // will keep it neatly aligned with the
                    // mission description text
                    Text("Crew")
                        .font(Font.title.bold())
                        .padding(.bottom, 5)
                }
                // brings text in from the edges
                // of the screen
                .padding(.horizontal)
                
                // Here will show the astronauts
                // that were on this mission
                // We will not show the horizontal scroll bar
                // This ScrollView for the astronauts
                //  was placed AFTER the mission VSTACK
                //  (not inside it) because Horizontal scroll views
                //  work best when they start ndented from the edge,
                //  but scroll fully edge to edge
                //  they don't stay indented when you scroll
                // This makes sure they don't have padding pushing the
                //  the Horizontal ScrollView inside the view
                // Doing so would clip the images as they scrolled off
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        // remember crew is the array of all crew members
                        //  (role and astronaut) for this mission
                        ForEach(crew, id: \.role) { CrewMember in
                            NavigationLink {
                                // First Navigation Link trailing closure
                                // The text in a Navigation Link is the
                                // destination link, and thus is NOT shown
                                // in this, the Mission View
                                Text("Astronaut Details")
                                // Second Navigation Link trailing closure
                                // The label is what WILL be shown
                                // in this, the Mission View
                            } label: {
                                HStack {
                                    Image(CrewMember.astronaut.id)
                                        .resizable()
                                    // the proportion of 104 and 72
                                    // keep the correct scale of the
                                    // original images
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                    // creates white border for image
                                        .overlay(Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                        )
                                    VStack(alignment: .leading) {
                                        Text(CrewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(CrewMember.role)
                                            // .foregroundStyle(.secondary)
                                            .foregroundStyle(.white.opacity(0.5))
                                        
                                    }
                                }
                                // padding for HStack
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                }
            }
            // to keep text away from the
            // bottom of the screen
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    // custom initalizer for the MissionView struct
    // It will accept the mission it represents
    // along with all the astronauts in the
    // astronaut dictionary
    // It will then stash the mission away
    // so we can show the badge and description
    // allow with an array of resolved astronauts
    // This code determines which astronaut
    //  goes with which mission
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        // determine crew which is an array of Crew Members
        // The matching takes place on the Crew Role name
        // of the mission role object
        // The map function brings in all the mission crew
        // members, one at a time
        // to find matches on name in the astronaut dictionary
        // passed to this view
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                // Since we created the JSON files,
                // we should always find a astronaut
                // that matches a mission
                // In other words, all our astronauts
                // will have been included
                // in one or more missions
                // And we will never get this fatal error
                // This type situtation (we messed up)
                // is a perfect place for a fata error
                fatalError("Missing astronaut data: \(member.name)")
            }
                
        }
    }
}

#Preview {
    // load mission and astronauts from JSON files
    // and pass them into the MissionView
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
    // Only need preferred color scheme for views other than main
    // We specified it there in the Navigation Stack
    // This preview is not inside that parent
    //  content view Navigation Stack
        .preferredColorScheme(.dark)
}
