//
//  IconsSheetView.swift
//  Venus
//
//  Created by Daniel Correia on 22.10.22.
//

import SwiftUI
import Combine

struct IconsSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Binding var iconName: String
    @State var searchText: String = ""
    @State var selectedIconsGroup: String = DefautSelectedGroup
    @State var iconNames: [String] = []
    @State var searchTextPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        Grid(alignment: .topLeading, horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                TextFieldView(textValue: $searchText, help: "Search Icons", visible: true)
            }
            GridRow {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(AppIconGroups, id: \.1) { iconGroup in
                            IconGroupView(title: iconGroup.0, selectedIconsGroup: $selectedIconsGroup, searchText: $searchText, iconNames: $iconNames)
                                .disabled(!searchText.isEmpty)
                        }
                    }
                }
            }
            GridRow {
                if(searchText.isEmpty) {
                    IconsGroupView(iconName: $iconName, iconNames: $iconNames)
                } else {
                    IconSearchPanelView(searchText: $searchText, iconName: $iconName, iconNames: $iconNames)
                }
            }
            GridRow {
                SheetButtonView(title: "Cancel", clickFunction: cancel).fixedSize(horizontal: false, vertical: true)
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText, perform: { newValue in
            searchTextPublisher.send(newValue)
        })
        .onReceive(
            searchTextPublisher
                .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
        ) { debouncedSearchText in
            if(!debouncedSearchText.isEmpty) {
                self.iconNames = getAllIcons().filter({$0.contains(debouncedSearchText.lowercased())})
            } else {
                self.iconNames = AppIconGroups.first(where: {$0.0 == selectedIconsGroup})?.1 ?? []
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.getColor(colorScheme: colorScheme).gradient.opacity(colorScheme == .dark ? 0.5 : 1.0))
        .onAppear {
            self.iconNames = AppIconGroups.first(where: {$0.0 == selectedIconsGroup})?.1 ?? []
        }
    }
    
    var icons: [String] {
        get {
            return AppIconGroups.first(where: {$0.0 == selectedIconsGroup})?.1 ?? []
        }
    }
    
    func cancel() {
        PlaySound(sound: .confirm)
        dismiss()
    }
    
    func isEmpty(text: String) async -> Bool {
        return text.isEmpty
    }
    
}

struct IconsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        IconsSheetView(iconName: .constant(""))
    }
}
