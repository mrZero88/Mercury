//
//  ContentView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    @State var showCreateSheet: Bool = false
    @State private var presentedStack: [String] = []
    
    var body: some View {
        NavigationStack(path: $presentedStack) {
            VStack {
                if(!viewModel.themesController.themes.isEmpty) {
                    List {
                        ForEach(viewModel.themesController.activeThemes) { theme in
                            NavigationLinkThemeView(theme: theme)
                        }
                        .onMove(perform: move)
                    }
                    .navigationDestination(for: String.self) { link in
                        let items = link.split(separator: "//")
                        let type = String(items[0])
                        let id = String(items[1])
                        if(type == "theme") {
                            ThemeView(theme: viewModel.themesController.getThemeById(id: id)!)
                        } else if(type == "topic") {
                            TopicView(topic: viewModel.topicsController.getTopicById(id: id))
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(SvgBackgroundView())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showCreateSheet = true
                    } label: {
                        Label("Add Theme", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        if(UIDevice.isIPad) {
                            SettingsViewT()
                        } else if(UIDevice.isIPhone) {
                            SettingsViewP()
                        }
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .sheet(isPresented: $showCreateSheet) {
                ThemeSheetView(theme: Theme.createEmptyTheme(), isCreating: true)
                    .accentColor(Color.Color)
            }
            .navigationTitle("Mercury")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(Color.Color)
        .onOpenURL { url in
            let topicId = url.absoluteString.split(separator: "//")[1]
            let topics = TopicDao.fetchTopics()
            let selectedTopic = topics.first(where: {$0.id!.description == topicId})
            if(selectedTopic != nil) {
                presentedStack = []
                presentedStack.append("theme//" + selectedTopic!.theme!.id!.description)
                presentedStack.append("topic//" + selectedTopic!.id!.description)
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        withAnimation {
            viewModel.themesController.moveTheme(originIndex: source.first!, destinationIndex: destination)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}