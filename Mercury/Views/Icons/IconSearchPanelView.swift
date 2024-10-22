//
//  IconSearchPanelView.swift
//  Saturn
//
//  Created by Daniel Correia on 23.03.23.
//

import SwiftUI
import Combine
import Utils

struct IconSearchPanelView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Binding var searchText: String
    @Binding var iconName: String
    @Binding var iconNames: [String]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
                ForEach(iconNames.chunked(into: 5), id: \.self) { iconsChunk in
                    GridRow {
                        ForEach(iconsChunk, id: \.self) { icon in
                            Button {
                                iconName = icon
                                dismiss()
                            } label: {
                                if(!icon.isEmpty) {
                                    Image(icon).resizable().scaledToFit().frame(maxWidth: .infinity).padding().foregroundColor(ColorUtils.getColor(colorScheme: colorScheme, colorName: "White"))
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(PanelColor)
        .cornerRadius(CornerRadius)
    }
}

struct IconSearchPanelView_Previews: PreviewProvider {
    static var previews: some View {
        IconSearchPanelView(searchText: .constant(""), iconName: .constant(""), iconNames: .constant([]))
    }
}
