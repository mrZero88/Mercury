//
//  Period.swift
//  Alien
//
//  Created by Daniel Correia on 27.02.23.
//

import Foundation

public class Period: Identifiable, ObservableObject {
    
    public var id: Int
    var description: String
    var date: Date
    
    init(id: Int, description: String, date: Date) {
        self.id = id
        self.description = description
        self.date = date
    }
    
}
