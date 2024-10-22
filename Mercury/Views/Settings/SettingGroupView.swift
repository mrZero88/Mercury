//
//  SettingGroupView.swift
//  Alien
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct SettingGroupView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @ObservedObject var settingGroup: SettingsGroup
    
    var settings: [Setting] {
        get {
            return SettingsUtils.settings(set: settingGroup.settings).sorted(by: {first,second in
                return first.order < second.order
            })
        }
    }
    
    var body: some View {
        List {
            ForEach(settings) { setting in
                SettingView(setting: setting)
            }
        }
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .listStyle(.plain)
        .listRowSpacing(BorderPadding)
    }
}

struct SettingGroupView_Previews: PreviewProvider {
    static var previews: some View {
        SettingGroupView(settingGroup: SettingsGroup())
    }
}
