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
    @Environment(\.dismiss) var dismiss
    @State var alertInfo: AlertInfo?
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    func getSettings(settingGroup: SettingsGroup) -> [ Setting] {
        return SettingsUtils.settings(set: settingGroup.settings).sorted(by: {first,second in
            return first.order < second.order
        })
    }
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                HStack {
                    Button {
                        withAnimation {
                            PlaySound(sound: .navigation)
                            PlayHaptic()
                            dismiss()
                        }
                    } label: {
                        ZStack {
                            Label("Settings", systemImage: "sidebar.left").labelStyle(.iconOnly).frame(maxHeight: .infinity).foregroundColor(Color.accentColor)
                            Label("", systemImage: "star").labelStyle(.iconOnly).opacity(0)
                        }
                    }
                    .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                    .buttonStyle(.borderedProminent)
                    .fixedSize(horizontal: false, vertical: true)
                    Text("Settings").font(.footnote).fontWeight(.bold).foregroundColor(Color.accentColor)
                    Spacer()
                    Button {
                        alertInfo = ShowResyncSettingsAlert()
                    } label: {
                        ZStack {
                            Label("Re-Sync Settings", systemImage: "arrow.triangle.2.circlepath").labelStyle(.iconOnly).frame(maxHeight: .infinity).foregroundColor(Color.accentColor)
                            Label("", systemImage: "star").labelStyle(.iconOnly).opacity(0)
                        }
                    }
                    .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                    .buttonStyle(.borderedProminent)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity)
                .padding(BorderPadding)
                .bgPanelStyle()
            }
            GridRow {
                List(viewModel.settingsViewModel.settingGroups) { settingGroup in
                    ForEach(self.getSettings(settingGroup: settingGroup)) { setting in
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
                .padding(BorderPadding)
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .bgPanelStyle()
                .listStyle(.plain)
                .listRowSpacing(BorderPadding)
            }
        }
        .padding(.horizontal, BorderPadding)
        .background(SvgBackgroundView())
#if os(iOS)
        .navigationBarHidden(true)
#endif
        .alert(item: $alertInfo, content: { info in
            showAlert(info: info, viewModel: viewModel, settingsChangedTrigger: settingsChangedTrigger)
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIphoneView()
    }
}
