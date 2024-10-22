//
//  SheetButtonView.swift
//  Saturn
//
//  Created by Daniel Correia on 07.03.23.
//

import SwiftUI
import Utils

struct SheetButtonView: View {
    var title: String
    var clickFunction: (() -> ())?
    var longClickFunction: (() -> ())?
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                Label(String(localized: String.LocalizationValue(title)), systemImage: "").labelStyle(.titleOnly)
                Toggle("", isOn: .constant(false)).opacity(0)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(PanelColor)
            .cornerRadius(CornerRadius)
        }
        .simultaneousGesture(
            LongPressGesture()
                .onEnded { _ in
                    longClickFunction?()
                }
        )
        .simultaneousGesture(
            TapGesture()
                .onEnded({
                    clickFunction?()
                })
        )
    }
}

struct SheetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SheetButtonView(title: "")
    }
}
