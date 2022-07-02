//
//  PanelModifier.swift
//  Neptune
//
//  Created by Daniel Correia on 13.06.22.
//

import SwiftUI

struct PanelModifier: ViewModifier {
    var cornerRadius: Double = 5.0
    var shadowRadius: Double = 5.0
    
    func body(content: Content) -> some View {
        content
            .background(Color.PanelColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
    }
}
