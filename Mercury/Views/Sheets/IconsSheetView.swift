//
//  IconsSheetView.swift
//  Venus
//
//  Created by Daniel Correia on 22.10.22.
//

import SwiftUI

struct IconsSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var iconName: String
    @State var searchText: String = ""
    @State var selectedIconsPanel: String = "Appliance & Electronic"
    
    var body: some View {
        Grid(alignment: .topLeading, horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                TextFieldView(inSheet: false, textValue: $searchText, help: "Search Icons", visible: true)
            }
            GridRow {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(AppIconGroups, id: \.1) { iconGroup in
                            IconGroupView(title: iconGroup.0, selectedIconsPanel: $selectedIconsPanel)
                                .disabled(!searchText.isEmpty)
                        }
                    }
                }
            }
            GridRow {
                if(searchText.isEmpty) {
                    IconsPanelView(selectedIconsPanel: selectedIconsPanel, iconName: $iconName)
                } else {
                    IconSearchPanelView(searchText: searchText, iconName: $iconName)
                }
            }
            GridRow {
                SheetButtonView(inSheet: false, title: "Cancel", clickFunction: cancel).fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.accentColor.opacity(0.5).ignoresSafeArea())
    }
    
    func cancel() {
        PlaySound(sound: .confirm)
        dismiss()
    }
    
}

struct IconsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        IconsSheetView(iconName: .constant(""))
    }
}
