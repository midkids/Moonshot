//
//  MissionView.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/26/26.
//
// This view must have a size set from the parent

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
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
                        width,axis in width * 0.6
                }
                // The text Mission Highlights
                // and the mission description
                // will align to the leading edge
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                    // will cause this text to stay away
                    // from whatever is below it
                    // in this case, the description
                        .padding(.bottom, 5)
                    Text(mission.description)
                }
                // brings text in from the edges
                // of the screen
                .padding(.horizontal)
            }
            // to keep text away from the
            // bottom of the screen
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    return MissionView(mission: missions[0])
    // Only need preferred color scheme for views other than main
    // We specified it there in the Navigation Stack
    // This preview is not inside that parent
    //  content view Navigation Stack
        .preferredColorScheme(.dark)
}
