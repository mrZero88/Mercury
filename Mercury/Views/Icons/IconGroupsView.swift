//
//  IconGroupsView.swift
//  SaturnX
//
//  Created by Daniel Correia on 16.10.25.
//

import SwiftUI
import Utils

struct IconGroupsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var iconNames: [String]
    @State var iconGroupName: String = AppIconGroups[0].0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(AppIconGroups), id: \.0) { group in
                    Button {
                        if(iconGroupName != group.0) {
                            self.iconGroupName = group.0
                            self.iconNames = group.1
                            PlaySound(sound: .navigation)
                            PlayHaptic()
                        }
                    } label: {
                        ZStack {
                            Text(String(localized: String.LocalizationValue(group.0)))
                                .padding()
                                .background(PanelColor)
                                .cornerRadius(CornerRadius)
                                .foregroundColor(group.0 == iconGroupName ? .accentColor : ColorUtils.getColor(colorScheme: colorScheme, colorName: "appWhite"))
                            Toggle("", isOn: .constant(false)).opacity(0)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    IconGroupsView(iconNames: .constant([]))
}

