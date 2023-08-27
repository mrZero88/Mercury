//
//  SettingsIphoneView.swift
//  Alien
//
//  Created by Daniel Correia on 08.07.23.
//

import SwiftUI

struct SettingsIphoneView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            List(viewModel.settingsViewModel.settingGroups) { settingGroup in
                SwiftUI.Section(settingGroup.title ?? "") {
                    SettingGroupIphoneView(settingGroup: settingGroup)
                }
                .listRowBackground(Color("PanelColor"))
            }
            .scrollContentBackground(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding([.bottom])
        .background(SvgBackgroundView())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Settings")
    }
}

struct SettingsIphoneView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIphoneView()
    }
}
