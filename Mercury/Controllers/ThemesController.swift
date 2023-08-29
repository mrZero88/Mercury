//
//  ThemesController.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI
import Foundation

class ThemesController: ObservableObject {
    
    func getThemeById(themes: FetchedResults<Theme>, id: String) -> Theme? {
        return themes.first(where: {$0.id!.description == id})
    }
    
    func saveTheme(theme: Theme, isCreating: Bool) {
        theme.isActive = true
        theme.updatedAt = Date()
        if(isCreating) {
            if(!ThemeValidation.validate(title: theme.title ?? "", text: theme.text ?? "")) {
                self.deleteTheme(theme: theme)
            }
        }
        PlaySound(sound: .confirm)
        PersistenceController.save()
        self.objectWillChange.send()
    }
    
    func cancelSaveTheme(theme: Theme) {
        PlaySound(sound: .cancel)
        theme.objectWillChange.send()
    }
    
    func moveTheme(originIndex: Int, destinationIndex: Int) {
        var themes = ThemeDao.fetchThemes()
        if(destinationIndex >= originIndex) {
            themes = Rearrange(array: themes, fromIndex: originIndex, toIndex: destinationIndex-1)
        } else {
            themes = Rearrange(array: themes, fromIndex: originIndex, toIndex: destinationIndex)
        }
        orderThemes(themes: themes)
        PlaySound(sound: .confirm)
        PersistenceController.save()
        self.objectWillChange.send()
    }
    
    func orderThemes(themes: [Theme]) {
        var order: Int16 = 1
        for theme in themes {
            theme.order = order
            order += 1
        }
    }
    
    func deleteAllThemes() {
        for theme in ThemeDao.fetchThemes() {
            self.deleteTheme(theme: theme)
        }
    }
    
    func deleteTheme(theme: Theme?) {
        theme?.delete()
        theme?.objectWillChange.send()
    }
}
