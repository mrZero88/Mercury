//
//  SettingsViewT.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct SettingsViewT: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            ForEach(viewModel.settingsViewModel.settingGroups.chunked(into: 3), id: \.self) { chunk in
                GridRow {
                    ForEach(chunk, id: \.self) { settingGroup in
                        if(!(settingGroup.title?.isEmpty ?? false)) {
                            SettingGroupViewP(settingGroup: settingGroup)
                        } else {
                            SettingGroupViewP(settingGroup: settingGroup).opacity(0.0)
                        }
                    }
                }
            }
        }
        .toolbar {
            if(UIDevice.isIPad) {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Settings")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(SvgBackgroundView())
    }
}

struct SettingsViewT_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewT()
    }
}
