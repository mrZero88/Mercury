//
//  SettingsViewP.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI

struct SettingsViewP: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            ForEach(viewModel.settingsViewModel.settingGroups.chunked(into: 3), id: \.self) { chunk in
                List(chunk, id: \.self) { settingGroup in
                    SwiftUI.Section(String(localized: String.LocalizationValue(settingGroup.title ?? ""))) {
                        SettingGroupViewP(settingGroup: settingGroup)
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .background(SvgBackgroundView())
    }
}

struct SettingsViewP_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewP()
    }
}
