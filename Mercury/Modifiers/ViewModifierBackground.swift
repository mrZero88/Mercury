//
//  ViewModifierBackground.swift
//  Saturn
//
//  Created by Daniel Correia on 01.07.23.
//

import SwiftUI
import Foundation

struct ViewModifierBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(PanelColor)
            .cornerRadius(CornerRadius)
    }
}
