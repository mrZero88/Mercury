//
//  ColorExtension.swift
//  Neptune
//
//  Created by Daniel Correia on 13.06.22.
//

import SwiftUI

extension Color {
#if os(macOS)
    static let PanelColor = Color(nsColor: NSColor.underPageBackgroundColor)
#elseif os(iOS)
    static let PanelColor = Color(UIColor.secondarySystemBackground)
#elseif os(watchOS)
    static let PanelColor = Color.red
#endif
}
