//
//  MercuryApp.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI

@main
struct MercuryApp: App {
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(viewModel.settingsViewModel)
                .environmentObject(SettingsChangedTrigger())
        }
    }
}
