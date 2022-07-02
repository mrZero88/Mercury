//
//  AlgorithmsView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI

struct AlgorithmsView: View {
    var body: some View {
        List {
            Section("Search") {
                NavigationLink {
                    AlgorithmView()
                } label: {
                    Label("Binary Search", systemImage: "")
                }
                NavigationLink {
                    AlgorithmView()
                } label: {
                    Label("Binary Search (Recursive)", systemImage: "")
                }
                NavigationLink {
                    AlgorithmView()
                } label: {
                    Label("Linear Search", systemImage: "")
                }
            }
        }
        .navigationTitle("Algorithms")
    }
}

struct AlgorithmsView_Previews: PreviewProvider {
    static var previews: some View {
        AlgorithmsView()
    }
}
