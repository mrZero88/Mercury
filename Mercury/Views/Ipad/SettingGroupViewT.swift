//
//  SettingGroupViewT.swift
//  Alien
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct SettingGroupViewT: View {
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
                HStack(spacing: 0) {
                    Spacer()
                    Text(String(localized: String.LocalizationValue(settingGroup.title ?? ""))).lineLimit(1)
                    Spacer()
                }
                .padding([.leading, .top, .trailing], BorderPadding)
            }
            GridRow {
                if(!settings.isEmpty) {
                    List(settings) { setting in
                        SettingView(setting: setting)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(PanelColor)
        .cornerRadius(CornerRadius)
    }
}

struct SettingGroupViewT_Previews: PreviewProvider {
    static var previews: some View {
        SettingGroupViewT(settingGroup: SettingsGroup())
    }
}
