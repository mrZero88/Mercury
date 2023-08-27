//
//  SettingGroupIphoneView.swift
//  Alien
//
//  Created by Daniel Correia on 08.07.23.
//

import SwiftUI

struct SettingGroupIphoneView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @ObservedObject var settingGroup: SettingsGroup
    
    var settings: [Setting] {
        get {
            return SettingsUtils.settings(set: settingGroup.settings).filter({$0.isActive}).sorted(by: {first,second in
                return first.order < second.order
            })
        }
    }
    
    var body: some View {
        ForEach(settings) { setting in
            SettingView(setting: setting)
        }
        .listRowSeparatorTint(Color.accentColor)
        .listRowBackground(
            PanelColor
        )
    }
}

struct SettingGroupIphoneView_Previews: PreviewProvider {
    static var previews: some View {
        SettingGroupIphoneView(settingGroup: SettingsGroup())
    }
}
