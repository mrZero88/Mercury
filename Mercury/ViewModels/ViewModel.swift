//
//  MainViewModel.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import Combine
import Foundation

class ViewModel: ObservableObject {
    
    static var cancellables = Set<AnyCancellable>()
    @Published var settingsViewModel: SettingsViewModel = SettingsViewModel()
    @Published var themesController: ThemesController = ThemesController()
    @Published var topicsController: TopicsController = TopicsController()
    @Published var sectionsController: SectionsController = SectionsController()
    @Published var usersController: UsersController = UsersController()
    
    init() {        
        themesController.objectWillChange.sink(receiveValue: {self.objectWillChange.send()}).store(in: &ViewModel.cancellables)
        topicsController.objectWillChange.sink(receiveValue: {self.objectWillChange.send()}).store(in: &ViewModel.cancellables)
        sectionsController.objectWillChange.sink(receiveValue: {self.objectWillChange.send()}).store(in: &ViewModel.cancellables)
        usersController.objectWillChange.sink(receiveValue: {self.objectWillChange.send()}).store(in: &ViewModel.cancellables)
    }
    
    func reset() {
        themesController.deleteAllThemes()
    }
}
