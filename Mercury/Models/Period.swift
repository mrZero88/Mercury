//
//  Period.swift
//  Alien
//
//  Created by Daniel Correia on 27.02.23.
//

import Foundation
import Utils

public class Period: Identifiable, ObservableObject {
    
    @Published public var id: Int
    @Published public var description: String!
    @Published var period: EPeriod?
    @Published var startDate: Date?
    @Published var endDate: Date?
    
    init(id: Int) {
        self.id = id
        setDescription(date: Date())
    }
    
    init(id: Int, description: String, period: EPeriod) {
        self.id = id
        self.period = period
        self.description = description
    }
    
    func setDescription(date: Date) {
        switch(self.id){
        case 0:
            self.description = "Today"
            break
        case 1:
            self.description = DateUtils.formatDate(from: date, dateStyle: .short, timeStyle: .none)
            break
        case 2:
            self.description = date.weekYearDescription
            break
        case 3:
            self.description = date.monthYearDescription
            break
        default:
            break
        }
    }
}
