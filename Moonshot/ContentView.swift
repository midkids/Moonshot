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
// Pushing new views onto the stack using NavigationLink
// Working with hierarchical Codable data
// How to lay out views in a scrolling grid
// Loading a specific kind of Codable data
// Using generics to load any kind of Codable data
// Formatting our mission view
// Showing mission details with ScrollView
//   and containerRelativeFrame()

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

/*
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
// ScrollViews and scroll horizontally and vertically
// or in both directions at the same time
// Can show scroll indicator
// When we place views inside ScrollView,
// it automatically determines the size of its content
// It respects the safe area automatically
//   just like lists and forms
// In this case, it starts directly below the dynamic island
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

*/

// SwiftUI's navigation stack
// - shows a navigation bar at the top of our views
// - it also lets us push views onto a VStack
// One of the most fundamental ways of navigation
// Very different from sheets - the difference
//   is in the way they show views
// A sheet is for unrelated content
// A navigation link is for related
//   (perhaps more detail) information
// We can use navigation link
//   with any kind of destination view
// If you want to link to something other
//  than an simple Text label,
//  you can provide two trailing closures
//  with your navigation link
/*
struct ContentView: View {
    var body: some View {
        NavigationStack {
            // Simple navigation link
            // NavigationLink("Tap me") {
            // Navigation link with two trailing closures
            //   with a custom label link
            NavigationLink {
                Text("Detail View")
            } label: {
                VStack {
                    // This whole thing becomes
                    // our tappable button
                    Text("This is the label")
                    Text("So is this")
                    Image(systemName: "face.smiling")
                }
                .font(.largeTitle)
            }
            .navigationTitle("SwiftUI")
        }
    }
}
 */
/*
// IMPORTANT: The most common application of navigation links
//   is inside a list
// List will include small ">" symbol with each item
//   to tell users this row can be tapped
//   to see related information
struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { row in
                NavigationLink("Row \(row)") {
                    Text("Detail \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}
*/

/*
// The Codeable protocol makes it easy to decode
// flat data (e.g. a single instance of a type, or
// an array dictionary of that type
// However, in this project we will be using
// an array inside another array using
// different data types
// If you want to decode this type of hierarchical
// data, the key is to create a separate type for
// each level you want to decode
// Here we will have two levels,
//   but there is no limit to the number of levels
struct User: Codable {
    let name: String
    let address: Address
}
struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            // Here we make some JSON as a mult-line
            // string directly in our SwiftUI code
            // This is only for testing, not real life
            // The string is in the form of a dictionary
            let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                    "street": "555 Taylor Swift Avenue",
                    "city": "Nashville"
                    }
                }
                """
            // Convert our JSON string to a data type
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}
*/

/*
// Sometimes you want columns of data with a
// grid of information that can adapt
// for larger screens
// We will use lazyHgrid and lazyVGrid for this
// IMPORTANT: lazy means SwiftUI will wait until
//   the data is being shown on the screen
//   to load the view
// This feature allows us to display a lot more data
//   without using a lot of resources unnecessarily
// There are two steps:
// 1) define the rows OR columns) not both
// 2) place our grid inside a scroll view
// Here we will have vertical scrolling grid
//   with three columns exactly 80 points wide
// Each item you assign in this grid is given a column
// In this case, column 1, column 2, column 3,
//   Next line - column 1, column 2, column 3...
struct ContentView: View {
    let layout = [
 //       GridItem(.fixed(80)),
 //       GridItem(.fixed(80)),
 //       GridItem(.fixed(80))
        // SwiftUI will fit as many columns as possible
        //   with each column being at least 80 points
        // This allows more columns for larger screens
        // Now we get four columns of 80 points each
        //  in portrait orientation and eight columns
        //  of 80 points each in landscape orientation
        // IMPORTANT: this is much better choice
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        
    }
}
*/

/*
// Horizontal Grid
struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        
    }
}
 */

// Horizontal Grid
struct ContentView: View {
    // Here we use our Bundle-Decodeable extension
    // Once we made our Bundle-Decodable generic
    //  we must assure Swift we are returning a dictionary of
    //  Astronauts for which we are using the generic "T"
    //  in our Bundle-Decoder
    // Don't forget,our Bundle-Decoder can not return any
    //  type that conforms to Codable
    // To fix this error, we will use a type annotation
    //  so that Swift will know exactly what type it will be
//    let astronauts = Bundle.main.decode("astronauts.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    // We will use the very same decode method
    // found in our Decode-Bundle extension to decode
    // missions
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // Adaptive column layout
    // It will have the right number of rows and columns
    //   for our screen size
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        // We will test to make sure our JSON astronauts file
        // was loaded correctly by displaying its count
        // Text(String(astronauts.count))
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        // Here we will point to our MissionView
                        // with the correct mission
                        // and pass in all the astronauts every time
                        // the link is activated
                        NavigationLink {
                            // Initial placeholder code
                            // Text("Detail view")
                            
                            // Actual link to MissionView
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                // keeps the correct aspect ratio
                                // no matter what size they are
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    // add padding to get badges
                                    // away from edges
                                    // must be after frame
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    // We will format date in Mission struct once
                                    // formatting the optional launchDate
                                    // to a String
                                    // Text(mission.launchDate ?? "N/A")
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.7))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                // add padding to the lazy grid
                // to get grid items away from sides
                // and the bottom
                // pushing the content in sligtly
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            // This will cause the title to be white
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

