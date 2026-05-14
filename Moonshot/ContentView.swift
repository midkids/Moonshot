//
//  ContentView.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/13/26.
//
// Project 8

import SwiftUI

// Resizing images to fit the available space

struct ContentView: View {
    var body: some View {
    // When we create an image view in SwiftUI
    // it will automatically size itself
    // according to the dimensions of its content
    // Most of the time you will want the image
    // to appear smaller than its dimensions
    // Image("largeDog")
    // Better choice:
    // same result as the above statement
        Image(.largeDog)
            .resizable()
        
            // Both of these next two are for
            // when you want a fixed size image
            // Keeps orginal image aspect ratios
            // can leave some of frame emtpy
            .scaledToFit()
            // Keeps orginal image aspect ratios
            // will fill frame and go beyond it
            // .scaledToFill()
            // .frame(width: 300, height: 300)
        
            // Here our image will be sized in
            // reference to its immediate parent frame
            // In this case, the container is the entire screen
            // This modifier will make the image 0.8
            // (or 80%) of its width
            // The trailning closure is called by SwiftUI
            //   giving it size and axis
            // The value of size will be the actual
            //  of the parent view (in this case,
            //  the full screen width) and
            //  the value of axis, in this case horizontal
            // IMPORTANT: the closure returns the target size
            //   along the specified axis
            // - it adapts to the container
            .containerRelativeFrame(.horizontal) {
                size, axis in size * 0.8
            }
    }
}

#Preview {
    ContentView()
}
