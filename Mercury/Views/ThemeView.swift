//
//  ThemeView.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ThemeView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var theme: Theme
    @State var showCreateSheet: Bool = false
    
    var body: some View {
        VStack {
            if(!theme.activeTopics.isEmpty) {
                List {
                    ForEach(theme.activeTopics) { topic in
                        NavigationLinkTopicView(topic: topic)
                    }
                    .onMove(perform: move)
                }
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SvgBackgroundView())
        .toolbar {
            ToolbarItem {
                Button {
                    showCreateSheet = true
                } label: {
                    Label("Add Theme", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showCreateSheet) {
            TopicSheetView(topic: Topic.createEmptyTopic(theme: theme), isCreating: true)
                .accentColor(Color.getColor(colorScheme: colorScheme))
        }
        .navigationTitle(theme.title ?? "")
    }
    
    func move(from source: IndexSet, to destination: Int) {
        withAnimation {
            viewModel.topicsController.moveTopic(originIndex: source.first!, destinationIndex: destination, theme: theme)
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: Theme())
    }
}
