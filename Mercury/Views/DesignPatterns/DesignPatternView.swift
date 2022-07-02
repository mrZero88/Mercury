//
//  DesignPatternView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI

struct DesignPatternView: View {
    var dp: DesignPattern
    
    var body: some View {
        ScrollView {
            VStack {
                InfoItemView(description: dp.definition)
                ClassDiagramView(imageName: dp.classDiagramImageName)
                Group {
                    if(!dp.concept.title.isEmpty) {
                        InfoItemView(title: dp.concept.title, description: dp.concept.description)
                    }
                    if(!dp.realWorldExample.title.isEmpty) {
                        InfoItemView(title: dp.realWorldExample.title, description: dp.realWorldExample.description)
                    }
                    if(!dp.computerWorldExample.title.isEmpty) {
                        InfoItemView(title: dp.computerWorldExample.title, description: dp.computerWorldExample.description)
                    }
                    if(!dp.illustration.title.isEmpty) {
                        InfoItemView(title: dp.illustration.title, description: dp.illustration.description)
                    }
                    if(!dp.discussion.description.isEmpty) {
                        InfoItemView(title: dp.discussion.title, description: dp.discussion.description)
                    }
                }
            }
        }
        .navigationTitle(dp.name)
    }
}

struct DesignPatternView_Previews: PreviewProvider {
    static var previews: some View {
        let mvm = MainViewModel()
        return DesignPatternView(dp: mvm.designPatterns.first!)
    }
}
