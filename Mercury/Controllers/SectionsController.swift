//
//  SectionsController.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import Foundation

class SectionsController: ObservableObject {
    
    func saveSection(section: Section, isCreating: Bool) {
        section.isActive = true
        section.updatedAt = Date()
        if(isCreating) {
            if(!SectionValidation.validate(title: section.title ?? "", text: section.text ?? "")) {
                self.deleteSection(section: section)
            }
        }
        PlaySound(sound: .navigation)
        PersistenceController.save()
        self.objectWillChange.send()
    }
    
    func cancelSaveSection(section: Section) {
        PlaySound(sound: .navigation)
        section.objectWillChange.send()
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
