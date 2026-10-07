//
//  SectionsController.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import Foundation

class SectionsController: ObservableObject {
    
    func saveSection(section: Section) {
        if(SectionValidation.validate(title: section.title ?? "")) {
            PersistenceController.save()
        }
        PlaySound(sound: .navigation)
        PlayHaptic()
        self.objectWillChange.send()
    }
    
    func moveSection(originIndex: Int, destinationIndex: Int, topic: Topic) {
        var sections = topic.activeSections
        if(destinationIndex >= originIndex) {
            sections = Rearrange(array: sections, fromIndex: originIndex, toIndex: destinationIndex-1)
        } else {
            sections = Rearrange(array: sections, fromIndex: originIndex, toIndex: destinationIndex)
        }
        orderSections(sections: sections)
        PlaySound(sound: .navigation)
        PlayHaptic()
        PersistenceController.save()
        self.objectWillChange.send()
    }
    
    func orderSections(sections: [Section]) {
        var order: Int16 = 1
        for section in sections {
            section.order = order
            order += 1
        }
    }
    
    func deleteSection(section: Section?) {
        section?.delete()
    }
    
}
