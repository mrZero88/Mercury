//
//  SettingDao.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import CoreData

public class SettingDao {
    
    public static func fetchSettings() -> [Setting] {
        let fetchRequest: NSFetchRequest<Setting>
        fetchRequest = Setting.fetchRequest()
        let pActive = NSPredicate(format: "isActive == true")
        let sort = NSSortDescriptor(key: #keyPath(Setting.createdAt), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = pActive
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }

    public static func fetchAllSettings() -> [Setting] {
        let fetchRequest: NSFetchRequest<Setting>
        fetchRequest = Setting.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Setting.createdAt), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects!
    }
    
    public static func fetchSetting(key: String) -> Setting? {
        let fetchRequest: NSFetchRequest<Setting>
        fetchRequest = Setting.fetchRequest()
        let pActive = NSPredicate(format: "isActive == true")
        let pKey = NSPredicate(format: "key == %@", key)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [pActive, pKey])
        fetchRequest.fetchLimit = 1
        let appSetting = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest).first
        return appSetting
    }
    
    public static func fetchSettings(key: String) -> [Setting] {
        let fetchRequest: NSFetchRequest<Setting>
        fetchRequest = Setting.fetchRequest()
        let pActive = NSPredicate(format: "isActive == true")
        let pKey = NSPredicate(format: "key == %@", key)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [pActive, pKey])
        let objects = try? PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return objects ?? []
    }
    
    public static func fetchOrCreateSetting(title: String, key: String, dataType: String, group: SettingsGroup, boolValue: Bool = false, intValue: Int = 0, dateValue: Date? = Date(), stringValue: String = "", uuidValue: UUID = UUID(), doubleValue: Double = 0.0, minDouble: Double = 0.0, maxDouble: Double = 0.0, type: String = "", order: Int16, dependentOn: Setting? = nil, isVisible: Bool = true, enabled: Bool = true, function: String = "") -> Setting {
        let setting = self.fetchSetting(key: key)
        return setting != nil ? setting! : createSetting(title: title, key: key, dataType: dataType, group: group, boolValue: boolValue, intValue: intValue, dateValue: dateValue, stringValue: stringValue, uuidValue: uuidValue, doubleValue: doubleValue, minDouble: minDouble, maxDouble: maxDouble, type: type, order: order, isVisible: isVisible, enabled: enabled, function: function)
    }
    
    public static func createSetting(title: String, key: String, dataType: String, group: SettingsGroup, boolValue: Bool = false, intValue: Int = 0, dateValue: Date? = Date(), stringValue: String = "", uuidValue: UUID = UUID(), doubleValue: Double = 0.0, minDouble: Double = 0.0, maxDouble: Double = 0.0, type: String = "", order: Int16, isVisible: Bool = true, enabled: Bool = true, function: String = "") -> Setting {
        let newSetting = Setting(context: PersistenceController.shared.container.viewContext)
        let now = Date()
        newSetting.id = UUID()
        newSetting.key = key
        newSetting.title = title
        newSetting.dataType = dataType
        newSetting.boolValue = boolValue
        newSetting.intValue = Int64(intValue)
        newSetting.dateValue = dateValue
        newSetting.stringValue = stringValue
        newSetting.uuidValue = uuidValue
        newSetting.createdAt = now
        newSetting.updatedAt = now
        newSetting.isActive = true
        newSetting.group = group
        newSetting.order = order
        newSetting.type = type
        newSetting.enabled = enabled
        newSetting.isVisible = isVisible
        newSetting.doubleValue = doubleValue
        newSetting.minDouble = minDouble
        newSetting.maxDouble = maxDouble
        newSetting.function = function
        PersistenceController.save()
        return newSetting
    }
    
    public static func deleteSetting(key: String, viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        let settings = self.fetchSettings(key: key)
        for setting in settings {
            setting.delete()
        }
    }
}
