//
//  RoundedBorderModifier.swift
//  Neptune
//
//  Created by Daniel Correia on 12.06.22.
//

import SwiftUI

struct RoundedBorderModifier: ViewModifier {
    var cornerRadius: Double
    var color: Color
    var lineWidth: Double
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: lineWidth)
            )
            .padding(1.0)
    }
}
