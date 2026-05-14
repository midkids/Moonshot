//
//  ContentView.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/13/26.
//
// Project 8

import SwiftUI

// Resizing images to fit the available space
// How ScrollView lets us work with scrolling data

/*
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
 */

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(text: String) {
        // This will show where in our code
        // when SwiftUI makes this custom view
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        // ScrollViews and scroll
        // horizontally and vertically
        // or in both directions at the same time
        // Can show scroll indicator
        // When we place views inside ScrollView,
        // it automatically determines
        // the size of its content
        // It respects the safe area automatically
        //   just like lists and forms
        // In this case,
        // it starts directly below the dynamic island
        // When we add a view inside a ScrollView,
        //   they are added immediately upon start up
        //   if we use VStack
        // To avoid that, we will change our VStack to
        //   a lazy VStack which will only make the
        //   views on the screen
        ScrollView {
            // VStack(spacing: 10) {
            // A LazyVStack will always take up as much
            //  space as available in our layouts
            // Compared to a regular VStack only takes up
            //   the space it actually needed
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText(text: "Item \($0)")
                        .font(.title)
                }
            }
            // allows us to touch anywhere
            // across the entire screen to scroll
            // rather than just in the list area
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
