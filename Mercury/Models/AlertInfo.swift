//
//  AlertInfo.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation
import SwiftUI

struct AlertInfo: Identifiable {
    enum AlertType {
        case deleteTheme
        case alert
        case deleteTopic
        case deleteSection
        case reset
        case resyncSettings
    }
    
    let id: AlertType
    let title: String
    let message: String
}

func showAlert(info: AlertInfo, viewModel: ViewModel, theme: Theme? = nil, topic: Topic? = nil, section: Section? = nil, dismiss: DismissAction? = nil, settingsChangedTrigger: SettingsChangedTrigger? = nil, function: (() -> Void)? = nil) -> Alert {
    
    switch(info.id) {
    case .alert:
        return Alert(title: Text(info.message), message: Text(info.message), dismissButton: .default(Text("Got it!")))
    case .deleteTheme:
        return Alert(title: Text(String(localized: String.LocalizationValue(info.title))),
                     message: Text(String(localized: String.LocalizationValue(info.message))),
                     primaryButton: .destructive(Text("Delete")) {
            withAnimation {
                viewModel.themesController.deleteTheme(theme: theme)
            }
            PlaySound(sound: .delete)
            PlayHaptic()
            if(dismiss != nil) {
                dismiss?.callAsFunction()
            }
        },
                     secondaryButton: .cancel())
        
    case .deleteTopic:
        return Alert(title: Text(String(localized: String.LocalizationValue(info.title))),
                     message: Text(String(localized: String.LocalizationValue(info.message))),
                     primaryButton: .destructive(Text("Delete")) {
            withAnimation {
                viewModel.topicsController.deleteTopic(topic: topic)
            }
            PlaySound(sound: .delete)
            PlayHaptic()
            if(dismiss != nil) {
                dismiss?.callAsFunction()
            }
        },
                     secondaryButton: .cancel())
    case .deleteSection:
        return Alert(title: Text(String(localized: String.LocalizationValue(info.title))),
                     message: Text(String(localized: String.LocalizationValue(info.message))),
                     primaryButton: .destructive(Text("Delete")) {
            withAnimation {
                viewModel.sectionsController.deleteSection(section: section)
            }
            PlaySound(sound: .delete)
            PlayHaptic()
            if(dismiss != nil) {
                dismiss?.callAsFunction()
            }
        },
                     secondaryButton: .cancel())
    case .resyncSettings:
        return Alert(title: Text(String(localized: String.LocalizationValue(info.title))),
                     message: Text(String(localized: String.LocalizationValue(info.message))),
                     primaryButton: .destructive(Text("Re-Sync")) {
            withAnimation {
                PlaySound(sound: .navigation)
                PlayHaptic()
                let uuid = UserUuid
                let startDate = FirstOnDate
                viewModel.settingsViewModel.settingsController.addSettings()
                viewModel.settingsViewModel.fetchSettingGroups()
                SetFirstOnDate(date: startDate)
                SetUserUuid(uuid: uuid)
                SetOnboard(onboard: true)
                settingsChangedTrigger?.objectWillChange.send()
            }
            PlaySound(sound: .delete)
            PlayHaptic()
            if(dismiss != nil) {
                dismiss?.callAsFunction()
            }
        },
                     secondaryButton: .cancel())
    case .reset:
        return Alert(title: Text(String(localized: String.LocalizationValue(info.title))),
                     message: Text(String(localized: String.LocalizationValue(info.message))),
                     primaryButton: .destructive(Text("Reset")) {
            withAnimation {
                viewModel.reset()
            }
            PlaySound(sound: .delete)
            PlayHaptic()
            if(dismiss != nil) {
                dismiss?.callAsFunction()
            }
        },
                     secondaryButton: .cancel())
    }
}

func ShowResyncSettingsAlert() -> AlertInfo {
    let message = "Are you sure you want to re-sync the settings? The settings will be reseted and syncronized across all devices."
    PlaySound(sound: .alert)
    PlayHaptic()
    return AlertInfo(id: .resyncSettings, title: "Re-Sync Settings", message: message)
}

func ShowDeleteThemeAlert() -> AlertInfo {
    let message = "Are you sure you want to delete this theme? All It's topics and sections will be deleted."
    PlaySound(sound: .alert)
    PlayHaptic()
    return AlertInfo(id: .deleteTheme, title: "Delete Theme", message: message)
}

func ShowDeleteTopicAlert() -> AlertInfo {
    let message = "Are you sure you want to delete this Topic? All It's sections will be deleted."
    PlaySound(sound: .alert)
    PlayHaptic()
    return AlertInfo(id: .deleteTopic, title: "Delete Topic", message: message)
}

func ShowDeleteSectionAlert() -> AlertInfo {
    let message = "Are you sure you want to delete this section?"
    PlaySound(sound: .alert)
    PlayHaptic()
    return AlertInfo(id: .deleteSection, title: "Delete Section", message: message)
}

func ShowResetAlert() -> AlertInfo {
    let message = "Are you sure you want to delete all the themes, topics and sections?"
    PlaySound(sound: .alert)
    PlayHaptic()
    return AlertInfo(id: .reset, title: "Reset", message: message)
}
