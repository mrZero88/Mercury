//
//  IconSearchPanelView.swift
//  Saturn
//
//  Created by Daniel Correia on 23.03.23.
//

import SwiftUI

struct IconSearchPanelView: View {
    @Environment(\.dismiss) var dismiss
    var searchText: String
    @Binding var iconName: String
    
    var icons: [String] {
        get {
            return getAllIcons().filter({$0.contains(searchText.lowercased())})
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

struct IconSearchPanelView_Previews: PreviewProvider {
    static var previews: some View {
        IconSearchPanelView(searchText: "", iconName: .constant(""))
    }
}
