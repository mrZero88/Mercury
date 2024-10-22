//
//  SectionView.swift
//  Mercury
//
//  Created by Daniel Correia on 02.06.23.
//

import SwiftUI
import Utils

struct SectionView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var section: Section
    @State var showEditSheet: Bool = false
    @State var alertInfo: AlertInfo?
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "accentColor")
    ) var settings: FetchedResults<Setting>
    
    var body: some View {
        SwiftUI.Section(section.title ?? "") {
            Text(section.text ?? "")
        }
        .listRowBackground(
            PanelColor
        )
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                alertInfo = ShowDeleteSectionAlert()
            } label: {
                Label("Delete", systemImage: "minus.circle").labelStyle(.iconOnly)
            }
            .tint(ColorUtils.getColor(colorScheme: colorScheme, colorName: "Red").opacity(0.5))
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                showEditSheet = true
                PlaySound(sound: .openSheet)
            } label: {
                Label("Edit", systemImage: "pencil.circle").labelStyle(.iconOnly)
            }
            .tint((colorScheme == .dark) ? Color("Yellow").opacity(0.5) : Color("yellow4").opacity(0.5))
        }
        .onTapGesture(count: 2) {
            showEditSheet = true
        }
        .sheet(isPresented: $showEditSheet) {
            SectionSheetView(section: section, isCreating: false)
                .accentColor(Color.getColor(colorScheme: colorScheme, setting: self.settings.first))
        }
        .alert(item: $alertInfo, content: { info in
            showAlert(info: info, viewModel: viewModel, section: section)
        })
        .navigationTitle(section.topic?.title ?? "")
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: Section())
    }
}
