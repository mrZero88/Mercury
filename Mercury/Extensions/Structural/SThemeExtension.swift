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
            return self.allTopics.sorted(by: {first, second in
                return first.order < second.order
            })
        }
    }
    
    func delete() {
        self.deleteAllTopics()
        PersistenceController.delete(object: self)
        PersistenceController.save()
    }
    
    func deleteAllTopics() {
        for topic in ThemeUtils.topics(set: self.topics) {
            topic.delete()
        }
    }
    
    static func createEmptyTheme() -> Theme {
        let lastOrder = ThemeDao.fetchThemes().count + 1
        let theme = ThemeDao.createTheme(title: "", text: "", iconName: DefaultThemeIconName, order: Int16(lastOrder))
        return theme
    }
}
