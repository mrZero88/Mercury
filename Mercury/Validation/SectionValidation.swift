//
//  SectionValidation.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import Foundation

public class SectionValidation {
    
    static var titleMaxChars = 100
    static var textMaxChars = 20000
    
    public static func validate(title: String) -> Bool {
        return !title.isEmpty && title.count <= titleMaxChars && title.hasLettersOrNumbers
    }
    
    private static func sectionExists(title: String) -> Bool {
        let title = title.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return SectionDao.fetchSections().filter({$0.isActive}).contains(where: {$0.isActive && $0.title!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == title})
    }
}
