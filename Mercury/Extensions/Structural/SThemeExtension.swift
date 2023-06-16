//
//  SThemeExtension.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import Foundation

extension Theme {
    
    var allTopics: [Topic] {
        get {
            return ThemeUtils.topics(set: self.topics).sorted(by: {first, second in
                return first.order < second.order
            })
        }
    }
    
    var activeTopics: [Topic] {
        get {
            return self.allTopics.filter({$0.isActive}).sorted(by: {first, second in
                return first.order < second.order
            })
        }
    }
    
    func delete() {
        self.isActive = false
        self.updatedAt = Date()
        self.deleteAllTopics()
        PersistenceController.delete(object: self)
        PersistenceController.save()
    }
    func deleteAllTopics() {
        for topic in ThemeUtils.topics(set: self.topics) {
            topic.delete()
        }
    }
    func activate() {
        self.updatedAt = Date()
        self.isActive = true
        PersistenceController.save()
    }
    func deactivate() {
        self.updatedAt = Date()
        self.isActive = false
        PersistenceController.save()
    }
    
    static func createEmptyTheme() -> Theme {
        let lastOrder = ThemeDao.fetchThemes().count + 1
        let theme = ThemeDao.createTheme(title: "", text: "", iconName: DefaultThemeIconName, order: Int16(lastOrder))
        return theme
    }
}
