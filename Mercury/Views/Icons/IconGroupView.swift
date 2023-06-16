//
//  IconGroupView.swift
//  Saturn
//
//  Created by Daniel Correia on 22.03.23.
//

import SwiftUI

struct IconGroupView: View {
    var title: String
    @Binding var selectedIconsPanel: String
    
    var body: some View {
        ZStack {
            Button {
                withAnimation {
                    selectedIconsPanel = title
                }
            } label: {
                if(selectedIconsPanel == title) {
                    Label(title, systemImage: "checkmark.circle.fill").foregroundColor(Color("White"))
                } else {
                    Label(title, systemImage: "checkmark.circle.fill").foregroundColor(Color("White")).labelStyle(.titleOnly)
                }
            }
            .font(.footnote)
            Toggle("", isOn: .constant(false)).opacity(0)
        }
        .padding()
        .background(PanelColor)
        .cornerRadius(CornerRadius)
    }
}

struct IconGroupView_Previews: PreviewProvider {
    static var previews: some View {
        IconGroupView(title: "", selectedIconsPanel: .constant(""))
    }
}
