//
//  IconFieldView.swift
//  Venus
//
//  Created by Daniel Correia on 08.08.22.
//

import SwiftUI

struct IconFieldView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var iconName: String
    @State private var showingIconstSheet = false
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "accentColor")
    ) var settings: FetchedResults<Setting>
    
    var body: some View {
        Button {
            showingIconstSheet = true
            PlaySound(sound: .openSheet)
            PlayHaptic()
        } label: {
            if(!iconName.isEmpty) {
                Image(iconName).resizable().padding(Border5).frame(width: 40, height: 40, alignment: .center).foregroundColor(Color.primary)
            }
        }
        .sheet(isPresented: $showingIconstSheet) {
            IconsSheetView(iconName: $iconName).accentColor(Color.getColor(colorScheme: colorScheme, setting: settings.first))
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity)
        .background(PanelColor)
        .cornerRadius(CornerRadius)
    }
}

struct IconFieldView_Previews: PreviewProvider {
    static var previews: some View {
        IconFieldView(iconName: .constant(""))
    }
}
