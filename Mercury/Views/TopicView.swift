//
//  TopicView.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import SwiftUI

struct TopicView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var topic: Topic
    @State var showCreateSheet: Bool = false
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "accentColor")
    ) var settings: FetchedResults<Setting>
    
    var body: some View {
        VStack {
            if(!topic.activeSections.isEmpty) {
                List {
                    ForEach(topic.activeSections) { section in
                        SectionView(section: section)
                    }
                    .onMove(perform: move)
                }
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    showCreateSheet = true
                } label: {
                    Label("Add Section", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showCreateSheet) {
            SectionSheetView(section: Section.createEmptySection(topic: topic), isCreating: true)
                .accentColor(Color.getColor(colorScheme: colorScheme, setting: settings.first))
        }
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SvgBackgroundView())
        .navigationTitle(topic.title ?? "")
    }
    
    func move(from source: IndexSet, to destination: Int) {
        withAnimation {
            viewModel.sectionsController.moveSection(originIndex: source.first!, destinationIndex: destination, topic: topic)
        }
    }
    
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicView(topic: Topic())
    }
}
