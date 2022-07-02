//
//  DataStructuresView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI

struct DataStructuresView: View {
    var body: some View {
        List {
            Section("Search") {
                NavigationLink {
                    DataStructureView()
                } label: {
                    Label("Linked List", systemImage: "")
                }
            }
        }
        .navigationTitle("Data Structures")
    }
}

struct DataStructuresView_Previews: PreviewProvider {
    static var previews: some View {
        DataStructuresView()
    }
}
