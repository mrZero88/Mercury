//
//  ColorSettingView.swift
//  Venus
//
//  Created by Daniel Correia on 22.09.22.
//

import SwiftUI

struct ColorSettingView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Binding var value: String
    var lineWidth: CGFloat = 4
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var colorsNames: [String] {
        get {
            let blackOrWhite = colorScheme == .dark ? "White" : "Black"
            return ["Pink", "Purple", "Orange", "Yellow", "Red", "Cyan", blackOrWhite, "Green"]
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { svr in
                LazyHStack {
                    ForEach(colorsNames, id: \.self) { colorName in
                        Button {
                            value = colorName
                            PlaySound(sound: .navigation)
                            PlayHaptic()
                        } label: {
                            Circle().strokeBorder(value == colorName ? (colorScheme == .dark ? Color("Black") : Color("White")) : Color.clear, lineWidth: lineWidth).background(Circle().fill(Color(colorName))).frame(width:50, height:50)
                        }
                        .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                        .id(colorName.lowercased())
                    }
                }
                .onAppear {
                    svr.scrollTo(value, anchor: .center)
                }
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ColorSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSettingView(value: .constant(""))
    }
}
