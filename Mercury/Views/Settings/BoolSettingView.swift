//
//  BoolSettingView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct BoolSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Binding var value: Bool
    @Binding var enabled: Bool
    
    var body: some View {
        Toggle("", isOn: $value)
            .disabled(!enabled)
            .tint(Color.accentColor)
    }
}

struct BoolSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BoolSettingView(value: .constant(false), enabled: .constant(false))
    }
}
