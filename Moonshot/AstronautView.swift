//
//  AstronautView.swift
//  Moonshot
//
//  Created by Myron Snelson on 6/1/26.
//
// We will reach this detailed Astronaut View
// from the Mission View
// This detailed view will slide in when invoked
// SwiftUI generates back buttons for us
// This view must have a size set from the parent

import SwiftUI

struct AstronautView: View {
    // A single astronaut property
    // is required by this view
    // so it will know what to show on the screen
    let astronaut: Astronaut
    
    // The layout will be similar to
    // Mission View
    var body: some View {
        ScrollView() {
            VStack {
                // id is included in the Astronaut struct
                //  and is the astronaut's name
                // The images are stored in Assets.xcassets
                // under the name of each astronaut
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .padding()
                // Description is included in the Astronaut struct
                Text(astronaut.description)
                    .padding()
            }
        }
        // These modifiers are for ScrollView
        // For ScrollView, they apply edge to edge
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        // The inline parameter causes the title
        // to be displayed in a smaller, compact style
        // IMPORTANT: use the inline parameter for
        //  detailed views
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // must supply data to the preview
    // load astronauts from JSON files
    // and pass them into the AstronautView
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    /* The hard-coded astronaut "aldrin"
        is only used for the preview
        The #Preview block is compiled and run only by Xcode’s preview
        system to render a live preview in the canvas.
     • Our app at runtime will create AstronautView instances using real data passed from the parent view (e.g., when navigating from a mission list), not from this preview code.
    • Therefore, the hard-coded "aldrin" key affects only what you see in the preview canvas and does not impact the app’s behavior when it runs on a device or simulator.
     */
    return AstronautView(astronaut: astronauts["aldrin"]!)
    // Only need preferred color scheme for views other than main
    // We specified it there in the Navigation Stack
    // This preview is not inside that parent
    //  content view Navigation Stack
        .preferredColorScheme(.dark)
}
