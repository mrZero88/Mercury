//
//  STopicExtension.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import Foundation

extension Topic {
    
    var allSections: [Section] {
        get {
            return TopicUtils.sections(set: self.sections).sorted(by: {first, second in
                return first.order < second.order
            })
        }
    }

    var activeSections: [Section] {
        get {
            return self.allSections.filter({$0.isActive}).sorted(by: {first, second in
                return first.order < second.order
            })
        }
    }
    
    func delete() {
        self.isActive = false
        self.updatedAt = Date()
        self.deleteAllSections()
        PersistenceController.delete(object: self)
        PersistenceController.save()
    }
    func deleteAllSections() {
        for section in TopicUtils.sections(set: self.sections) {
            section.delete()
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
    
    static func createEmptyTopic(theme: Theme) -> Topic {
        let lastOrder = (theme.activeTopics.last?.order ?? 0) + 1
        let topic = TopicDao.createTopic(title: "", text: "", subtitle: "", iconName: DefaultTopicIconName, order: Int16(lastOrder), theme: theme)
        return topic
    }
}
