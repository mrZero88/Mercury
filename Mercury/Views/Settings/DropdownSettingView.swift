//
//  DropdownSettingView.swift
//  Alien
//
//  Created by Daniel Correia on 07.04.23.
//

import SwiftUI

struct DropdownSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    var title: String
    @Binding var value: String
    var enabled: Bool
    
    var body: some View {
        HStack {
            Menu {
                ForEach(getAllBackgrounds(), id: \.self) { bg in
                    Button {
                        value = bg.lowercased()
                        PlaySound(sound: .confirm)
                    } label: {
                        Label(bg, systemImage: "").labelStyle(.titleOnly)
                    }
                }
            } label: {
                Label(value, systemImage: "").labelStyle(.titleOnly).frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.bordered)
        .disabled(!enabled)
    }
}

struct DropdownSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownSettingView(title: "", value: .constant(""), enabled: true)
    }
}
