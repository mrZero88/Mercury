//
//  IconFieldView.swift
//  Venus
//
//  Created by Daniel Correia on 08.08.22.
//

import SwiftUI

struct IconFieldView: View {
    @Environment(\.colorScheme) var colorScheme
    var inSheet: Bool = false
    @Binding var iconName: String
    @State private var showingIconstSheet = false
    
    var background: Color {
        get {
            return inSheet && !ShowBg1 && !ShowBg2 ? Color("Black") : PanelColor
        }
    }
    
    var body: some View {
        Button {
            showingIconstSheet = true
        } label: {
            if(!iconName.isEmpty) {
                Image(iconName).resizable().padding(5.0).frame(width: 40, height: 40, alignment: .center).foregroundColor(Color.getColor(colorScheme: colorScheme))
            }
        }
        .sheet(isPresented: $showingIconstSheet) {
            IconsSheetView(iconName: $iconName).accentColor(Color.getColor(colorScheme: colorScheme))
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity)
        .background(background)
        .cornerRadius(CornerRadius)
    }
}

struct IconFieldView_Previews: PreviewProvider {
    static var previews: some View {
        IconFieldView(iconName: .constant(""))
    }
}
