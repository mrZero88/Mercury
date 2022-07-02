//
//  MercuryApp.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI

@main
struct MercuryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MainViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
