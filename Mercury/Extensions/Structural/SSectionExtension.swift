//
//  SSectionExtension.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import Foundation

extension Section {
    func delete() {
        self.isActive = false
        self.updatedAt = Date()
        PersistenceController.delete(object: self)
        PersistenceController.save()
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
    
    static func createEmptySection(topic: Topic) -> Section {
        let lastOrder = (topic.activeSections.last?.order ?? 0) + 1
        let section = SectionDao.createSection(title: "", text: "", order: Int16(lastOrder), topic: topic)
        return section
    }
}
