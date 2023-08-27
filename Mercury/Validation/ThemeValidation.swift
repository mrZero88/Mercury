//
//  BoardValidation.swift
//  Alien
//
//  Created by Daniel Correia on 19.02.23.
//

import Foundation

public class ThemeValidation {
    
    static var titleMaxChars = 100
    static var textMaxChars = 20000
    
    public static func validate(title: String, text: String) -> Bool {
        return !title.isEmpty && title.count <= titleMaxChars && title.hasLettersOrNumbers && text.count <= textMaxChars
    }
    
    private static func themeExists(title: String) -> Bool {
        let title = title.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return ThemeDao.fetchThemes().filter({$0.isActive}).contains(where: {$0.isActive && $0.title!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == title})
    }
}
