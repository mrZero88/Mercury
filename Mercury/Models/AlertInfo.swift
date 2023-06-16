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
    }
    
    let id: AlertType
    let title: String
    let message: String
}

func showAlert(info: AlertInfo, viewModel: ViewModel, theme: Theme? = nil, topic: Topic? = nil, section: Section? = nil, dismiss: DismissAction? = nil) -> Alert {
    if(info.id == .alert) {
        return Alert(title: Text(info.message), message: Text(info.message), dismissButton: .default(Text("Got it!")))
    } else {
        return Alert(title: Text(String(localized: String.LocalizationValue(info.title))),
                     message: Text(String(localized: String.LocalizationValue(info.message))),
                     primaryButton: .destructive(Text("Delete")) {
            switch(info.id) {
            case .alert:
                break
            case .deleteTheme:
                withAnimation {
                    viewModel.themesController.deleteTheme(theme: theme)
                }
                break
            case .deleteTopic:
                withAnimation {
                    viewModel.topicsController.deleteTopic(topic: topic)
                }
                break
            case .deleteSection:
                withAnimation {
                    viewModel.sectionsController.deleteSection(section: section)
                }
                break
            case .reset:
                withAnimation {
                    viewModel.reset()
                }
            }
            if(dismiss != nil) {
                dismiss?.callAsFunction()
            }
        },
                     secondaryButton: .cancel())
    }
}

func ShowDeleteThemeAlert() -> AlertInfo {
    let message = "Are you sure you want to delete this theme? All It's topics and sections will be deleted."
    PlaySound(sound: .delete)
    return AlertInfo(id: .deleteTheme, title: "Delete Theme", message: message)
}

func ShowDeleteTopicAlert() -> AlertInfo {
    let message = "Are you sure you want to delete this Topic? All It's sections will be deleted."
    PlaySound(sound: .delete)
    return AlertInfo(id: .deleteTopic, title: "Delete Topic", message: message)
}

func ShowDeleteSectionAlert() -> AlertInfo {
    let message = "Are you sure you want to delete this section?"
    PlaySound(sound: .delete)
    return AlertInfo(id: .deleteSection, title: "Delete Section", message: message)
}

func ShowResetAlert() -> AlertInfo {
    let message = "Are you sure you want to delete all the boards, phases and tasks?"
    PlaySound(sound: .delete)
    return AlertInfo(id: .reset, title: "Reset", message: message)
}
