//
//  ContentView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @EnvironmentObject var viewModel: ViewModel
    @State var showCreateSheet: Bool = false
    @State private var presentedStack: [String] = []
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "accentColor")
    ) var settings: FetchedResults<Setting>
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: .forward)
        ],
        predicate: NSPredicate(format: "isActive == true")
    ) var themes: FetchedResults<Theme>
    
    var body: some View {
        NavigationStack(path: $presentedStack) {
            VStack(spacing: BorderPadding) {
                HStack {
                    Button {
                        PlaySound(sound: .navigation)
                        PlayHaptic()
                        presentedStack = []
                        presentedStack.append("settings//settings")
                    } label: {
                        ZStack {
                            Label("Settings", systemImage: "gear").labelStyle(.iconOnly).frame(maxHeight: .infinity).foregroundColor(Color.accentColor)
                            Label("", systemImage: "star").labelStyle(.iconOnly).opacity(0)
                        }
                    }
                    .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                    Spacer()
                    Button {
                        PlaySound(sound: .navigation)
                        PlayHaptic()
                        presentedStack = []
                        presentedStack.append("home//home")
                    } label: {
                        ZStack {
                            Label("Mercury", systemImage: "house").frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(Color.accentColor)
                            Label("", systemImage: "star").labelStyle(.iconOnly).opacity(0)
                        }
                    }
                    .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                    Spacer()
                    Button {
                        PlaySound(sound: .openSheet)
                        PlayHaptic()
                        showCreateSheet = true
                    } label: {
                        ZStack {
                            Label("Add Board", systemImage: "plus").labelStyle(.iconOnly).frame(maxHeight: .infinity).foregroundColor(Color.accentColor)
                            Label("", systemImage: "star").labelStyle(.iconOnly).opacity(0)
                        }
                    }
                    .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .padding(BorderPadding)
                .bgPanelStyle()
                .fixedSize(horizontal: false, vertical: true)
                
                
                List {
                    ForEach(themes) { theme in
                        NavigationLinkThemeView(theme: theme)
                    }
                }
                .padding(BorderPadding)
                .bgPanelStyle()
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                .listRowSpacing(BorderPadding)
            }
            .padding(.horizontal, BorderPadding)
            .navigationDestination(for: String.self) { link in
                let items = link.split(separator: "//")
                let type = String(items[0])
                let id = String(items[1])
                if(type == "theme") {
                    ThemeView(theme: viewModel.themesController.getThemeById(themes: themes, id: id)!)
                } else if(type == "topic") {
                    TopicView(topic: viewModel.topicsController.getTopicById(id: id))
                } else if (type == "settings") {
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(SvgBackgroundView())
            .scrollContentBackground(.hidden)
#if os(iOS)
            .listStyle(.insetGrouped)
            .navigationBarHidden(true)
#endif
            .sheet(isPresented: $showCreateSheet) {
                ThemeSheetView(theme: Theme.createEmptyTheme(), isCreating: true)
                    .accentColor(Color.getColor(colorScheme: colorScheme, setting: self.settings.first))
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(Color.getColor(colorScheme: colorScheme, setting: self.settings.first))
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
