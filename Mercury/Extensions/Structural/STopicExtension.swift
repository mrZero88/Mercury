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
        PersistenceController.delete(object: self)
        PersistenceController.save()
    }
    
    static func createEmptyTopic(theme: Theme) -> Topic {
        let lastOrder = (theme.activeTopics.last?.order ?? 0) + 1
        let topic = TopicDao.createTopic(title: "", text: "", subtitle: "", iconName: DefaultTopicIconName, order: Int16(lastOrder), theme: theme)
        return topic
    }
}
