//
//  ExportUtils.swift
//  Alien
//
//  Created by Daniel Correia on 20.07.23.
//

import Foundation

class ExportUtils {
    
    static func exportAllData() -> Data? {
        
        let themes = ThemeDao.fetchThemes()
        
        let mercuryData = MercuryData(themes: themes)
        
        do {
            return try JSONEncoder().encode(mercuryData)
        } catch {
            print("Error encoding data to JSON", error)
            return nil
        }
    }
    
}
