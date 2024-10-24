//
//  SectionDao.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import CoreData

public class SectionDao {
    
    public static func fetchAllSections() -> [Section] {
        let fetchRequest: NSFetchRequest<Section>
        fetchRequest = Section.fetchRequest()
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func fetchSections() -> [Section] {
        let fetchRequest: NSFetchRequest<Section>
        fetchRequest = Section.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Section.order), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = NSPredicate(format: "isActive == true")
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func createSection(title: String, text: String, iconName: String, order: Int16 = 1, topic: Topic) -> Section {
        let newSection = Section(context: PersistenceController.shared.container.viewContext)
        let date = Date()
        newSection.id = UUID()
        newSection.title = title
        newSection.text = text
        newSection.createdAt = date
        newSection.updatedAt = date
        newSection.isActive = false
        newSection.order = order
        newSection.topic = topic
        newSection.iconName = iconName
        return newSection
    }
}
