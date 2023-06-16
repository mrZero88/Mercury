//
//  ThemeDao.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import CoreData

public class ThemeDao {
    
    public static func fetchAllThemes() -> [Theme] {
        let fetchRequest: NSFetchRequest<Theme>
        fetchRequest = Theme.fetchRequest()
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func fetchThemes() -> [Theme] {
        let fetchRequest: NSFetchRequest<Theme>
        fetchRequest = Theme.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Theme.order), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = NSPredicate(format: "isActive == true")
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func createTheme(title: String, text: String, iconName: String, order: Int16 = 1) -> Theme {
        let newTheme = Theme(context: PersistenceController.shared.container.viewContext)
        let date = Date()
        newTheme.id = UUID()
        newTheme.title = title
        newTheme.text = text
        newTheme.createdAt = date
        newTheme.updatedAt = date
        newTheme.isActive = false
        newTheme.order = order
        newTheme.iconName = iconName
        return newTheme
    }
}
