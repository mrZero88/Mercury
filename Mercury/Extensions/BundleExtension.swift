//
//  BundleExtension.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> [T] {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        var loaded: [T] = []
        
        do {
            loaded = try decoder.decode([T].self, from: data)
        } catch {
            print(error)
        }
        
        return loaded
    }
}
