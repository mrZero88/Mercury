//
//  SettingView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI
import Utils

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var setting: Setting
    @State var alertInfo: AlertInfo?
    @State private var isExporting: Bool = false
    @State private var isImporting: Bool = false
    @State private var document = JsonDocument(Data())
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        ZStack {
            Image("6960589_gear_settings_mechanics_process").resizable().scaledToFit().foregroundColor(Color.accentColor).frame(width: 40, height: 40, alignment: .center).padding(.vertical).opacity(0)
            HStack(spacing: 0) {
                if(setting.type == "") {
                    ZStack(alignment: .leading) {
                        Toggle("", isOn: .constant(false)).opacity(0)
                        Text(String(localized: String.LocalizationValue(setting.title ?? ""))).lineLimit(1)
                    }
                    Spacer()
                }
                if(setting.type == "Button") {
                    Button {
                        doFunction(function: setting.function)
                    } label: {
                        Label(setting.title ?? "", systemImage: "").labelStyle(.titleOnly).foregroundColor(setting.function == "reset" ? .red : .primary).frame(maxWidth: .infinity)
                    }
                    .tint(.accentColor.opacity(0.5))
                    .buttonStyle(.borderedProminent)
                    .fileExporter(isPresented: $isExporting,
                                  document: document,
                                  contentType: .json,
                                  defaultFilename: "Mercury_" + Date().localDateTimeZoneDateDescription) { result in
                        switch result {
                        case .success(_):
                            break
                        case .failure(let error):
                            print(error)
                        }
                    }
                                  .fileImporter(isPresented: $isImporting,
                                                allowedContentTypes: [.json]) { result in
                                      switch(result){
                                      case .success(let url):
                                          importData(from: url)
                                      case .failure(let error):
                                          print(error.localizedDescription)
                                      }
                                  }
                } else if(setting.type == "Color") {
                    ColorSettingView(value: Binding<String> (
                        get: {
                            return setting.stringValue ?? "Orange"
                        },
                        set: {
                            setting.stringValue = $0
                            settingsChangedTrigger.objectWillChange.send()
                            PersistenceController.save()
                        }
                    ))
                } else if (setting.type == "Slider") {
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
                } else if (setting.type == "Background") {
                    BackgroundSettingView(title: setting.title ?? "", value: Binding<String> (
                        get: {
                            return setting.stringValue ?? "1"
                        },
                        set: {
                            setting.stringValue = $0
                            settingsChangedTrigger.objectWillChange.send()
                            PersistenceController.save()
                        }
                    ), enabled: setting.enabled)
                } else if (setting.type == "Period") {
                    PeriodSettingView(title: setting.title ?? "", selectedPeriod: Binding<Period> (
                        get: {
                            return Config.periods.first(where: {$0.id == setting.intValue}) ?? Config.periods.first(where: {$0.id == 3})!
                        },
                        set: {
                            setting.intValue = Int64($0.id)
                            settingsChangedTrigger.objectWillChange.send()
                            PersistenceController.save()
                        }
                    ), enabled: setting.enabled)
                } else if(setting.dataType == "Bool") {
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
                            PlaySound(sound: .navigation)
                            PlayHaptic()
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
                } else if (setting.dataType == "String") {
                    StringSettingView(value: Binding<String> (
                        get: {
                            return setting.stringValue ?? ""
                        },
                        set: {
                            setting.stringValue = $0
                            settingsChangedTrigger.objectWillChange.send()
                            PersistenceController.save()
                        }
                    ))
                } else if (setting.dataType == "Date") {
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
                } else if (setting.dataType == "Int") {
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
                } else if (setting.dataType == "UUID") {
                    UUIDSettingView(value: "\(setting.uuidValue?.description.prefix(8) ?? "")")
                }
            }
        }
        .alert(item: $alertInfo, content: { info in
            showAlert(info: info, viewModel: viewModel, dismiss: dismiss)
        })
        .listRowSeparator(.hidden)
        .listRowBackground(
            TertiaryColor
                .opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity)
                .clipped()
                .cornerRadius(CornerRadius)
        )
    }
    
    func doFunction(function: String?) {
        switch(function) {
        case "reset":
            alertInfo = ShowResetAlert()
            break
        case "export":
            document = JsonDocument(ExportUtils.exportAllData()!)
            isExporting = true
            break
        case "import":
            isImporting = true
            break
        default:
            break
        }
    }
    
    private func importData(from url: URL) {
        let accessing = url.startAccessingSecurityScopedResource()
        defer {
            if accessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        
        do {
            
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let _ = try decoder.decode(MercuryData.self, from: data)
            withAnimation {
                viewModel.objectWillChange.send()
            }
            PersistenceController.save()
        } catch {
            print("Error on Import!", error.localizedDescription)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(setting: Setting())
    }
}
