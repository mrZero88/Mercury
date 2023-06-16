//
//  NSSetExtension.swift
//  Neptune
//
//  Created by Daniel Correia on 13.06.22.
//

import Foundation

extension NSSet {
    func toArray<T>() -> [T] {
        let array = Array(self.allObjects as! [T])
        return array
    }
    
    func toArray<S>(_ of: S.Type) -> [S] {
        let array = self.map({$0 as! S})
        return array
    }
}
