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
            return SettingsUtils.settings(set: settingGroup.settings).filter({$0.isActive}).sorted(by: {first,second in
                return first.order < second.order
            })
        }
    }
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                VStack {
                    HStack(spacing: 0) {
                        Text(String(localized: String.LocalizationValue(settingGroup.title ?? ""))).lineLimit(1)
                        Spacer()
                        Button {
                        } label: {
                            Label("Nothing", systemImage: "plus.circle").labelStyle(.iconOnly)
                        }
                        .buttonStyle(.bordered)
                        .opacity(0)
                    }
                    Divider()
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
        .bgPanelStyle()
    }
}

struct SettingGroupView_Previews: PreviewProvider {
    static var previews: some View {
        SettingGroupView(settingGroup: SettingsGroup())
    }
}
