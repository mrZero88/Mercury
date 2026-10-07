//
//  TopicsController.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//


import Foundation

class TopicsController: ObservableObject {
    
    func getTopicById(id: String) -> Topic {
        return TopicDao.fetchTopics().first(where: {$0.id!.description == id})!
    }
    
    func saveTopic(topic: Topic) {
        if(TopicValidation.validate(title: topic.title ?? "")) {
            PersistenceController.save()
        }
        PlaySound(sound: .navigation)
        PlayHaptic()
        self.objectWillChange.send()
    }
    
    func moveTopic(originIndex: Int, destinationIndex: Int, theme: Theme) {
        var topics = theme.activeTopics
        if(destinationIndex >= originIndex) {
            topics = Rearrange(array: topics, fromIndex: originIndex, toIndex: destinationIndex-1)
        } else {
            topics = Rearrange(array: topics, fromIndex: originIndex, toIndex: destinationIndex)
        }
        orderTopics(topics: topics)
        PlaySound(sound: .navigation)
        PlayHaptic()
        PersistenceController.save()
        self.objectWillChange.send()
    }
    
    func orderTopics(topics: [Topic]) {
        var order: Int16 = 1
        for topic in topics {
            topic.order = order
            order += 1
        }
    }
    
    func deleteTopic(topic: Topic?) {
        topic?.delete()
    }
    
}
