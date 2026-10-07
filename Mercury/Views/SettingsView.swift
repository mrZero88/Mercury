//
//  SettingsView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI
import CoreData
import Utils

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
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "showBorder")
    ) var showBorder: FetchedResults<Setting>
    
    func getSettings(settingGroup: SettingsGroup) -> [ Setting] {
        return SettingsUtils.settings(set: settingGroup.settings).sorted(by: {first,second in
            return first.order < second.order
        })
    }
    
    var allSettings: [Setting] {
        var settings: [Setting] = []
        for settingGroup in viewModel.settingsViewModel.settingGroups {
            for setting in settingGroup.allSettings {
                settings.append(setting)
            }
        }
        return settings
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
                .background(PanelColor)
                .overlay((showBorder.first?.boolValue ?? false) ? RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.accentColor, lineWidth: 1): RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.clear, lineWidth: 0))
                .cornerRadius(CornerRadius)
            }
            GridRow {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(String(localized: String.LocalizationValue("Settings")) + " (" + String(allSettings.count) + ")").foregroundColor(.secondary).font(.footnote)
                        Spacer()
                        Button {
                        } label: {
                            ZStack {
                                Label("", systemImage: "star").labelStyle(.iconOnly).frame(maxHeight: .infinity).opacity(0)
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .opacity(0)
                    }
                    .buttonStyle(.bordered)
                    .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                    .padding(BorderPadding)
                    List(viewModel.settingsViewModel.settingGroups) { settingGroup in
                        ForEach(self.getSettings(settingGroup: settingGroup)) { setting in
                            SettingView(setting: setting)
                        }
                    }
                    .padding([.horizontal, .bottom], BorderPadding)
                    .scrollIndicators(.hidden)
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .listRowSpacing(BorderPadding)
                }
                .background(PanelColor)
                .overlay((showBorder.first?.boolValue ?? false) ? RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.accentColor, lineWidth: 1): RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.clear, lineWidth: 0))
                .cornerRadius(CornerRadius)
            }
        }
        .padding(.horizontal, BorderPadding6)
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
