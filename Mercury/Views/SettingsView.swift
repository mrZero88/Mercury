//
//  SettingsView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            ForEach(viewModel.settingsViewModel.settingGroups.chunked(into: 3), id: \.self) { chunk in
                GridRow {
                    ForEach(chunk, id: \.self) { settingGroup in
                        if(!(settingGroup.title?.isEmpty ?? false)) {
                            SettingGroupView(settingGroup: settingGroup)
                        } else {
                            SettingGroupView(settingGroup: settingGroup).opacity(0.0)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding([.leading, .bottom, .trailing])
        .background(SvgBackgroundView())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
