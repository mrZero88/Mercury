//
//  Trapezoid.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation
import SwiftUI

struct Trapezoid: Shape {
  @State var percent: Double
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let edge = rect.width * CGFloat(percent/100)
    path.move(to: CGPoint(x: rect.minX + edge, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX - edge, y: rect.minY ))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY ))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.closeSubpath()
    return path
  }
}
