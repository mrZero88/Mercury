//
//  TopicValidation.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import Foundation

public class TopicValidation {
    
    static var titleMaxChars = 23
    static var textMaxChars = 20000
    
    public static func validate(title: String, text: String) -> Bool {
        return !title.isEmpty && title.count <= titleMaxChars && title.hasLettersOrNumbers && text.count <= textMaxChars
    }
    
    private static func topicExists(title: String) -> Bool {
        let title = title.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return TopicDao.fetchTopics().filter({$0.isActive}).contains(where: {$0.isActive && $0.title!.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == title})
    }
}
