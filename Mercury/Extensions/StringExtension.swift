//
//  StringExtension.swift
//  Moon
//
//  Created by Daniel Correia on 27.02.22.
//

import Foundation

extension String {    
    var hasLettersOrNumbers: Bool {
        get {
            for char in self {
                if(char.isLetter || char.isNumber) {
                    return true
                }
            }
            return false
        }
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
