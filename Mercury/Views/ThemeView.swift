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
    @Environment(\.dismiss) var dismiss
    @State var showCreateSheet: Bool = false
    
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
    
    var body: some View {
        VStack(spacing: BorderPadding) {
            HStack {
                Button {
                    PlaySound(sound: .navigation)
                    PlayHaptic()
                    dismiss()
                } label: {
                    ZStack {
                        Label("Back", systemImage: "sidebar.left").labelStyle(.iconOnly).frame(maxHeight: .infinity).foregroundColor(Color.accentColor)
                        Label("", systemImage: "star").labelStyle(.iconOnly).opacity(0)
                    }
                }
                .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                Spacer()
                Button {
                    PlaySound(sound: .navigation)
                    PlayHaptic()
                    /*presentedStack = []
                    presentedStack.append("home//home")*/
                } label: {
                    ZStack {
                        Label("Topics", systemImage: "house").frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(Color.accentColor)
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
                        Label("Add Theme", systemImage: "plus").labelStyle(.iconOnly).frame(maxHeight: .infinity).foregroundColor(Color.accentColor)
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
                ForEach(theme.activeTopics) { topic in
                    NavigationLinkTopicView(topic: topic)
                }
                .onMove(perform: move)
            }
            .padding(BorderPadding)
            .bgPanelStyle()
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .listRowSpacing(BorderPadding)
            
            
        }
        .padding(.horizontal, BorderPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SvgBackgroundView())
        .scrollContentBackground(.hidden)
#if os(iOS)
        .listStyle(.insetGrouped)
        .navigationBarHidden(true)
#endif
        .sheet(isPresented: $showCreateSheet) {
            TopicSheetView(topic: Topic.createEmptyTopic(theme: theme), isCreating: true)
                .accentColor(Color.getColor(colorScheme: colorScheme, setting: self.settings.first))
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
