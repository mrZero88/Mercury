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
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        Grid(alignment: .topLeading, horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                HStack {
                    Spacer()
                    Text("Icons").font(.footnote)
                    Spacer()
                }
            }
            GridRow {
                IconsGroupView(iconName: $iconName)
            }
            GridRow {
                HStack(spacing: BorderPadding) {
                    SheetButtonView(title: "Cancel", clickFunction: cancel)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
    }
    
    func cancel() {
        PlaySound(sound: .navigation)
        PlayHaptic()
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
