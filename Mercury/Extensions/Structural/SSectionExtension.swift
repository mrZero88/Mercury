//
//  SSectionExtension.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import Foundation

extension Section {
    func delete() {
        PersistenceController.delete(object: self)
        PersistenceController.save()
    }
    
    static func createEmptySection(topic: Topic) -> Section {
        let lastOrder = (topic.activeSections.last?.order ?? 0) + 1
        let section = SectionDao.createSection(title: "", text: "", iconName: DefaultTopicIconName, order: Int16(lastOrder), topic: topic)
        return section
    }
}
