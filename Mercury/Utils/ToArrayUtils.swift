//
//  ToArrayUtils.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import Foundation

class ThemeUtils {
    static func topics(set: NSSet?) -> [Topic] {
        return (set?.allObjects ?? []) as! [Topic]
    }
}

class TopicUtils {
    static func sections(set: NSSet?) -> [Section] {
        return (set?.allObjects ?? []) as! [Section]
    }
}

class SettingsUtils {
    static func settings(set: NSSet?) -> [Setting] {
        return (set?.allObjects ?? []) as! [Setting]
    }
}
