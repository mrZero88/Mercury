//
//  TopicDao.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import CoreData

public class TopicDao {
    
    public static func fetchAllTopics() -> [Topic] {
        let fetchRequest: NSFetchRequest<Topic>
        fetchRequest = Topic.fetchRequest()
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func fetchTopics() -> [Topic] {
        let fetchRequest: NSFetchRequest<Topic>
        fetchRequest = Topic.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Topic.order), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = NSPredicate(format: "isActive == true")
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func createTopic(title: String, text: String, subtitle: String, iconName: String, order: Int16 = 1, theme: Theme) -> Topic {
        let newTopic = Topic(context: PersistenceController.shared.container.viewContext)
        let date = Date()
        newTopic.id = UUID()
        newTopic.title = title
        newTopic.text = text
        newTopic.createdAt = date
        newTopic.updatedAt = date
        newTopic.isActive = false
        newTopic.order = order
        newTopic.theme = theme
        newTopic.subtitle = subtitle
        newTopic.iconName = iconName
        return newTopic
    }
}
