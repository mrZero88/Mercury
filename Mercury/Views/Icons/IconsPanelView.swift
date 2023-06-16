//
//  IconsPanelView.swift
//  Saturn
//
//  Created by Daniel Correia on 22.03.23.
//

import SwiftUI

struct IconsPanelView: View {
    @Environment(\.dismiss) var dismiss
    var selectedIconsPanel: String
    @Binding var iconName: String
    
    var icons: [String] {
        get {
            return AppIconGroups.first(where: {$0.0 == selectedIconsPanel})?.1 ?? []
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
                ForEach(icons.chunked(into: 5), id: \.self) { iconsChunk in
                    GridRow {
                        ForEach(iconsChunk, id: \.self) { icon in
                            Button {
                                iconName = icon
                                dismiss()
                            } label: {
                                if(!icon.isEmpty) {
                                    Image(icon).resizable().scaledToFit().frame(maxWidth: .infinity).padding().foregroundColor(Color("White"))
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

struct IconsPanelView_Previews: PreviewProvider {
    static var previews: some View {
        IconsPanelView(selectedIconsPanel: "", iconName: .constant(""))
    }
}
