//
//  SettingGroupIphoneView.swift
//  Alien
//
//  Created by Daniel Correia on 08.07.23.
//

import SwiftUI
import Utils

struct SettingGroupIphoneView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @ObservedObject var settingGroup: SettingsGroup
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var settings: [Setting] {
        get {
            return SettingsUtils.settings(set: settingGroup.settings).sorted(by: {first,second in
                return first.order < second.order
            })
        }
    }
    
    var body: some View {
        ForEach(settings) { setting in
            SettingView(setting: setting)
        }
        .listRowBackground(
            TertiaryColor
                .opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity)
                .clipped()
                .cornerRadius(CornerRadius)
        )
        .listRowSeparator(.hidden)
    }
}

struct SettingGroupIphoneView_Previews: PreviewProvider {
    static var previews: some View {
        SettingGroupIphoneView(settingGroup: SettingsGroup())
    }
}
