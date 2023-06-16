//
//  DesignPatternsWidgetViewModel.swift
//  Mercury
//
//  Created by Daniel Correia on 14.02.23.
//

import Foundation

class WidgetViewModel: ObservableObject {
    var themes: [Theme] {
        get {
            ThemeDao.fetchThemes()
        }
    }
    
    var randomTopics: [Topic] {
        get {
            var topics: [Topic] = []
            for theme in self.themes {
                for topic in theme.activeTopics {
                    topics.append(topic)
                }
            }
            topics.shuffle()
            return topics
        }
    }
    
}
