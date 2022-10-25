//
//  MainViewModel.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import Foundation

class MainViewModel: ObservableObject {
    
    var designPatterns: [DesignPattern] {
        get {
            return Bundle.main.decode("designPatterns.json")
        }
    }
    
    init() {
        
    }
    
}
