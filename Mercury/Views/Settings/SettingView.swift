//
//  SettingView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var setting: Setting
    @State var alertInfo: AlertInfo?
    @State private var isExporting: Bool = false
    @State private var isImporting: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            if(setting.type! == "") {
                ZStack(alignment: .leading) {
                    Toggle("", isOn: .constant(false)).opacity(0)
                    Text(String(localized: String.LocalizationValue(setting.title ?? ""))).lineLimit(1)
                }
                Spacer()
            }
            if(setting.type! == "Button") {
                Button {
                    doFunction(function: setting.function)
                } label: {
                    Label(setting.title ?? "", systemImage: "").labelStyle(.titleOnly)
                        .foregroundColor(setting.function == "reset" ? .red : .primary)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if(setting.type! == "Color") {
                ColorSettingView(value: Binding<String> (
                    get: {
                        return setting.stringValue!
                    },
                    set: {
                        setting.stringValue = $0
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                    }
                ))
            } else if (setting.type! == "Slider") {
                SliderSettingView(title: setting.title ?? "", value: Binding<Double> (
                    get: {
                        return setting.doubleValue
                    },
                    set: {
                        setting.doubleValue = $0
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                    }
                ), min: setting.minDouble, max: setting.maxDouble, enabled: setting.enabled)
            } else if (setting.type! == "Dropdown") {
                DropdownSettingView(title: setting.title ?? "", value: Binding<String> (
                    get: {
                        return setting.stringValue ?? "1"
                    },
                    set: {
                        setting.stringValue = $0
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                    }
                ), enabled: setting.enabled)
            } else if(setting.dataType! == "Bool") {
                BoolSettingView(value: Binding<Bool> (
                    get: {
                        return setting.boolValue
                    },
                    set: {
                        setting.boolValue = $0
                        if($0 == false) {
                            for depSetting in SettingsUtils.settings(set: setting.dependents) {
                                depSetting.enabled = false
                                if(setting.dataType == "Bool") {
                                    depSetting.boolValue = false
                                }
                            }
                        } else {
                            for depSetting in SettingsUtils.settings(set: setting.dependents) {
                                depSetting.enabled = true
                            }
                            setting.boolValue = $0
                        }
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                        PlaySound(sound: .confirm)
                    }
                ), enabled: Binding<Bool> (
                    get: {
                        return setting.enabled
                    },
                    set: {
                        setting.enabled = $0
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                    }
                ))
            } else if (setting.dataType! == "String") {
                StringSettingView(value: Binding<String> (
                    get: {
                        return setting.stringValue!
                    },
                    set: {
                        setting.stringValue = $0
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                    }
                ))
            } else if (setting.dataType! == "Date") {
                DateSettingView(value: Binding<Date?> (
                    get: {
                        return setting.dateValue
                    },
                    set: {
                        setting.dateValue = $0
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                    }
                ))
            } else if (setting.dataType! == "Int") {
                IntSettingView(value: Binding<Int64> (
                    get: {
                        return setting.intValue
                    },
                    set: {
                        setting.intValue = $0
                        settingsChangedTrigger.objectWillChange.send()
                        PersistenceController.save()
                    }
                ))
            } else if (setting.dataType! == "UUID") {
                UUIDSettingView(value: "\(setting.uuidValue?.description.prefix(8) ?? "")")
            }
        }
        .alert(item: $alertInfo, content: { info in
            showAlert(info: info, viewModel: viewModel, dismiss: dismiss)
        })
        .padding(BorderPadding)
        .cornerRadius(CornerRadius)
    }
    
    func doFunction(function: String?) {
        print("Hello")
        switch(function) {
        case "reset":
            alertInfo = ShowResetAlert()
            break
        case "export":
            isExporting = true
            break
        case "import":
            isImporting = true
            break
        default:
            break
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(setting: Setting())
    }
}
