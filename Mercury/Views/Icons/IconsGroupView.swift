//
//  IconsGroupView.swift
//  Saturn
//
//  Created by Daniel Correia on 22.03.23.
//

import SwiftUI

struct IconsGroupView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
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

struct IconsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        IconsGroupView(iconName: .constant(""), iconNames: .constant([]))
    }
}
