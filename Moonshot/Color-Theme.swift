//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Myron Snelson on 5/25/26.
//
// Rather than making an extension for Color
//  we will make one for ShapeStyle which is
//  a higher protocol to which Color conforms
// ShapeStyle is what background uses
// We will extend ShapeStyle, but only for
//  when it is being used as a color

// Had to change import to extend ShapeStyle
// import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
