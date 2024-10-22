//
//  BackgroundSettingView.swift
//  Alien
//
//  Created by Daniel Correia on 07.04.23.
//

import SwiftUI

struct BackgroundSettingView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    var title: String
    @Binding var value: String
    var enabled: Bool
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { svr in
                LazyHStack {
                    ForEach(getAllBackgrounds(), id: \.self) { bg in
                        Button {
                            value = bg.lowercased()
                            PlaySound(sound: .navigation)
                            PlayHaptic()
                        } label: {
                            Image(bg).resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(colorScheme == .dark ? Color("White") : Color("Black"))
                                .border(value == bg.lowercased() ? Color.accentColor : Color.clear)
                        }
                        .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                        .id(bg.lowercased())
                    }
                }
                .onAppear {
                    svr.scrollTo(value, anchor: .center)
                }
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(!enabled)
    }
}

struct BackgroundSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSettingView(title: "", value: .constant(""), enabled: true)
    }
}
