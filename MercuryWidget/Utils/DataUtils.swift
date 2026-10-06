//
//  DataUtils.swift
//  Moon
//
//  Created by Daniel Correia on 22.11.21.
//

import Foundation
import Combine
import CoreData

public class DataUtils {
    
    static private func resetAllRecords(in entity : String, context: NSManagedObjectContext) // entity = Your_Entity_Name
    {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    static func wipeAllData() {
        let context = PersistenceController.shared.container.viewContext
        self.wipeBoards(context: context)
        self.wipePhases(context: context)
        self.wipeTasks(context: context)
    }
    
    static func wipeBoards(context: NSManagedObjectContext) {
        self.resetAllRecords(in: "Board", context: context)
    }
    
    static func wipePhases(context: NSManagedObjectContext) {
        self.resetAllRecords(in: "Phase", context: context)
    }
    
    static func wipeTasks(context: NSManagedObjectContext) {
        self.resetAllRecords(in: "Task", context: context)
    }
    
    static func wipeSettings(context: NSManagedObjectContext) {
        self.resetAllRecords(in: "Setting", context: context)
    }
    
    static func wipeSettingGroups(context: NSManagedObjectContext) {
        self.resetAllRecords(in: "SettingsGroup", context: context)
    }
    
}
