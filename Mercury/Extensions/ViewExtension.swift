//
//  ViewExtension.swift
//  Neptune
//
//  Created by Daniel Correia on 12.06.22.
//

import Foundation
import SwiftUI

extension View {
    
    func roundedBorder(cornerRadius: Double, color: Color, lineWidth: Double) -> some View {
        modifier(RoundedBorderModifier(cornerRadius: cornerRadius, color: color, lineWidth: lineWidth))
    }
    
    func panel(cornerRadius: Double = 5.0, shadowRadius: Double = 5.0) -> some View {
        modifier(PanelModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
    
}
