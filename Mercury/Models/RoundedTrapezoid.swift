//
//  RoundedTrapezoid.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation
import SwiftUI

struct RoundedTrapezoid: Shape {
    let percentage: CGFloat
    let cornerSizes: [CGSize]
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let (cs1, cs2, cs3, cs4) = decodeCornerSize()
            
            // Start of path
            let start = CGPoint(x: rect.midX, y: 0)
            
            // width base and top
            let wb = rect.size.width
            let wt = wb * percentage
            
            // angles
            let angle: CGFloat = atan(Double(rect.height / ((wb - wt) / 2.0)))
            
            // Control points
            let c1 = CGPoint(x: (wb - wt) / 2.0, y: 0)
            let c2 = CGPoint(x: c1.x + wt, y: 0)
            let c3 = CGPoint(x: wb, y: rect.maxY)
            let c4 = CGPoint(x: 0, y: rect.maxY)
            
            // Points a and b
            let pa2 = CGPoint(x: c2.x - cs2.width, y: 0)
            let pb2 = CGPoint(x: c2.x + CGFloat(cs2.height * tan((.pi/2) - angle)), y: cs2.height)
            
            let pb3 = CGPoint(x: c3.x - cs3.width, y: rect.height)
            let pa3 = CGPoint(x: c3.x - (cs3.height != 0 ? CGFloat(tan(angle) / cs3.height) : 0.0), y: rect.height - cs3.height)
            
            let pa4 = CGPoint(x: c4.x + cs4.width, y: rect.height)
            let pb4 = CGPoint(x: c4.x + (cs4.height != 0 ? CGFloat(tan(angle) / cs4.height) : 0.0), y: rect.height - cs4.height)
            
            let pb1 = CGPoint(x: c1.x + cs1.width, y: 0)
            let pa1 = CGPoint(x: c1.x - CGFloat(cs1.height * tan((.pi/2) - angle)), y: cs1.height)
            
            path.move(to: start)
            
            path.addLine(to: pa2)
            path.addQuadCurve(to: pb2, control: c2)
            
            path.addLine(to: pa3)
            path.addQuadCurve(to: pb3, control: c3)
            
            path.addLine(to: pa4)
            path.addQuadCurve(to: pb4, control: c4)
            
            path.addLine(to: pa1)
            path.addQuadCurve(to: pb1, control: c1)
            
            path.closeSubpath()
        }
    }
    
    func decodeCornerSize() -> (CGSize, CGSize, CGSize, CGSize) {
        if cornerSizes.count == 1 {
            // If only one corner size is provided, use it for all corners
            return (cornerSizes[0], cornerSizes[0], cornerSizes[0], cornerSizes[0])
        } else if cornerSizes.count == 2 {
            // If only two corner sizes are provided, use one for the two top corners,
            // and the other for the two bottom corners
            return (cornerSizes[0], cornerSizes[0], cornerSizes[1], cornerSizes[1])
        } else if cornerSizes.count == 4 {
            // If four corners are provided, use one for each corner
            return (cornerSizes[0], cornerSizes[1], cornerSizes[2], cornerSizes[3])
        } else {
            // In any other case, do not round corners
            return (.zero, .zero, .zero, .zero)
        }
    }
}
