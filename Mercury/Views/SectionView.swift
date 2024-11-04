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
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "accentColor")
    ) var settings: FetchedResults<Setting>
    
    var colorTheme: Color {
        get {
            return colorScheme == .dark ? Color("White") : Color("Black")
        }
    }
    
    var body: some View {
        HStack {
            if(!(section.iconName?.isEmpty ?? true)) {
                VStack {
                    Image(section.iconName ?? "").resizable().scaledToFit().foregroundColor(Color.accentColor).frame(width: 40, height: 40, alignment: .center).padding(.vertical)
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                Text(section.title ?? "").padding(.leading, BorderPadding).foregroundColor(colorTheme)
                if(!(section.text?.isEmpty ?? true)) {
                    Text(section.text ?? "").padding(.leading, BorderPadding).foregroundColor(.secondary).font(.footnote)
                }
            }
            Spacer()
        }
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
                PlayHaptic()
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
        .listRowSeparator(.hidden)
        .listRowBackground(
            TertiaryColor
                .opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity)
                .clipped()
                .cornerRadius(CornerRadius)
        )
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: Section())
    }
}
