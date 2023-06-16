//
//  SettingGroupViewP.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI

struct SettingGroupViewP: View {
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
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                if(!settings.isEmpty) {
                    VStack {
                        ForEach(settings) { setting in
                            SettingView(setting: setting)
                        }
                    }
                }
            }
        }
        .listRowSeparatorTint(Color.accentColor)
        .listRowBackground(
            PanelColor
        )
    }
}

struct SettingGroupViewP_Previews: PreviewProvider {
    static var previews: some View {
        SettingGroupViewP(settingGroup: SettingsGroup())
    }
}
