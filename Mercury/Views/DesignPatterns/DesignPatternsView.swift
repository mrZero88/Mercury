//
//  DesignPatternsView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI
import Algorithms

struct DesignPatternsView: View {
    @EnvironmentObject var mvm: MainViewModel
    
    var designPatternTypes: [TypePatterns] {
        get {
            var designPatternTypes: [TypePatterns] = []
            for (dType, dPatterns) in mvm.designPatterns.sorted(by: { $0.type.description < $1.type.description }).chunked(on: \.type) {
                var patterns: [DesignPattern] = []
                for pattern in dPatterns {
                    patterns.append(pattern)
                }
                designPatternTypes.append(TypePatterns(type: dType, patterns: patterns))
            }
            return designPatternTypes
        }
    }
    
    var body: some View {
        List {
            ForEach(designPatternTypes) { patternType in
                Section(patternType.type.description) {
                    ForEach(patternType.patterns) { pattern in
                        NavigationLink {
                            DesignPatternView(dp: pattern)
                        } label: {
                            Label(pattern.name, systemImage: "ant")
                        }
                    }
                }
            }
        }
        .navigationTitle("Design Patterns")
    }
}

struct DesignPatternsView_Previews: PreviewProvider {
    static var previews: some View {
        DesignPatternsView()
    }
}
