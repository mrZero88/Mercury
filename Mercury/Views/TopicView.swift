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
                Label("Sections", systemImage: "house").frame(maxWidth: .infinity, maxHeight: .infinity).labelStyle(.titleOnly).foregroundColor(Color.accentColor)
                    .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                Spacer()
                Button {
                    PlaySound(sound: .openSheet)
                    PlayHaptic()
                    showCreateSheet = true
                } label: {
                    ZStack {
                        Label("Add Topic", systemImage: "plus").labelStyle(.iconOnly).frame(maxHeight: .infinity).foregroundColor(Color.accentColor)
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
                ForEach(topic.activeSections) { section in
                    SectionView(section: section)
                }
                .onMove(perform: move)
            }
            .padding(BorderPadding)
            .bgPanelStyle()
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .listRowSpacing(BorderPadding)
        }
        .sheet(isPresented: $showCreateSheet) {
            SectionSheetView(section: Section.createEmptySection(topic: topic), isCreating: true)
                .accentColor(Color.getColor(colorScheme: colorScheme, setting: settings.first))
        }
        .padding(.horizontal, BorderPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SvgBackgroundView())
        .scrollContentBackground(.hidden)
#if os(iOS)
        .listStyle(.insetGrouped)
        .navigationBarHidden(true)
#endif
        .onAppear {
            PlaySound(sound: .navigation)
            PlayHaptic()
        }
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
