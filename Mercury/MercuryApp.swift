//
//  MercuryApp.swift
//  Mercury
//
//  Created by Daniel Correia on 16.06.23.
//

import SwiftUI

@main
struct MercuryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
