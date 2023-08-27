//
//  ViewExtension.swift
//  Saturn
//
//  Created by Daniel Correia on 01.07.23.
//

import SwiftUI
import Foundation

extension View {
    func bgPanelStyle() -> some View {
        modifier(ViewModifierBackground())
    }
}
