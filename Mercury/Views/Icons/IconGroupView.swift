//
//  IconGroupView.swift
//  Saturn
//
//  Created by Daniel Correia on 22.03.23.
//

import SwiftUI
import Utils

struct IconGroupView: View {
    @Environment(\.colorScheme) var colorScheme
    var title: String
    @Binding var selectedIconsGroup: String
    @Binding var searchText: String
    @Binding var iconNames: [String]
    @Binding var pageNumber: Int
    @Binding var pagesNumber: Int
    
    var body: some View {
        ZStack {
            Button {
                selectedIconsGroup = title
                self.iconNames = AppIconGroups.first(where: {$0.0 == selectedIconsGroup})?.1 ?? []
                self.pagesNumber = Int(round(Double(self.iconNames.count) / Double(IconsPerPage)))
                self.pageNumber = 0
                PlaySound(sound: .navigation)
                PlayHaptic()
            } label: {
                if(selectedIconsGroup == title) {
                    Label(title, systemImage: "checkmark.circle.fill").foregroundColor(ColorUtils.getColor(colorScheme: colorScheme, colorName: "White"))
                } else {
                    Label(title, systemImage: "checkmark.circle.fill").foregroundColor(ColorUtils.getColor(colorScheme: colorScheme, colorName: "White")).labelStyle(.titleOnly)
                }
            }
            .font(.footnote)
            Toggle("", isOn: .constant(false)).opacity(0)
        }
        .padding()
        .background(PanelColor)
        .cornerRadius(CornerRadius)
    }
}

struct IconGroupView_Previews: PreviewProvider {
    static var previews: some View {
        IconGroupView(title: "", selectedIconsGroup: .constant(""), searchText: .constant(""), iconNames: .constant([]), pageNumber: .constant(0), pagesNumber: .constant(0))
    }
}
