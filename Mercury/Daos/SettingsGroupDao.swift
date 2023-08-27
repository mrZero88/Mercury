//
//  AppSettingGroupDao.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import CoreData

public class SettingsGroupDao {

    public static func fetchSettingGroups() -> [SettingsGroup] {
        let fetchRequest: NSFetchRequest<SettingsGroup>
        fetchRequest = SettingsGroup.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isActive == true")
        let sort = NSSortDescriptor(key: #keyPath(SettingsGroup.order), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func fetchAllSettingGroups() -> [SettingsGroup] {
        let fetchRequest: NSFetchRequest<SettingsGroup>
        fetchRequest = SettingsGroup.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(SettingsGroup.order), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func fetchSettingGroups(by key: String) -> [SettingsGroup] {
        let fetchRequest: NSFetchRequest<SettingsGroup>
        fetchRequest = SettingsGroup.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", key)
        let sort = NSSortDescriptor(key: #keyPath(SettingsGroup.createdAt), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func fetchSettingGroup(key: String) -> SettingsGroup? {
        let fetchRequest: NSFetchRequest<SettingsGroup>
        fetchRequest = SettingsGroup.fetchRequest()
        let pActive = NSPredicate(format: "isActive == true")
        let pKey = NSPredicate(format: "key == %@", key)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [pActive, pKey])
        fetchRequest.fetchLimit = 1
        let appSettingsGroup = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest).first
        return appSettingsGroup
    }
    
    public static func fetchOrCreateSettingGroup(key: String, title: String, order: Int16, iconName: String) -> SettingsGroup {
        let settingGroup = self.fetchSettingGroup(key: key)
        return settingGroup != nil ? settingGroup! : createSettingGroup(key: key, title: title, order: order, iconName: iconName)
    }
    
    public static func createSettingGroup(key: String, title: String, order: Int16, iconName: String) -> SettingsGroup {
        let newSettingGroup = SettingsGroup(context: PersistenceController.shared.container.viewContext)
        let now = Date()
        newSettingGroup.id = UUID()
        newSettingGroup.key = key
        newSettingGroup.title = title
        newSettingGroup.createdAt = now
        newSettingGroup.updatedAt = now
        newSettingGroup.isActive = true
        newSettingGroup.order = order
        newSettingGroup.iconName = iconName
        PersistenceController.save()
        return newSettingGroup
    }
    
    public static func deleteSettingGroup(key: String, viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        let settingGroups = self.fetchSettingGroups(by: key)
        for settingGroup in settingGroups {
            settingGroup.delete()
        }
    }
}
