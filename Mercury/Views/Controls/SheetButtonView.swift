//
//  SheetButtonView.swift
//  Saturn
//
//  Created by Daniel Correia on 07.03.23.
//

import SwiftUI

struct SheetButtonView: View {
    var inSheet: Bool = false
    var title: String
    var clickFunction: (() -> ())!
    
    var background: Color {
        get {
            return inSheet && !ShowBg1 && !ShowBg2 ? Color("Black") : PanelColor
        }
    }
    
    var body: some View {
        ZStack {
            Button {
                    clickFunction()
            } label: {
                ZStack {
                    Label(String(localized: String.LocalizationValue(title)), systemImage: "").labelStyle(.titleOnly)
                    Toggle("", isOn: .constant(false)).opacity(0)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(background)
                .cornerRadius(CornerRadius)
                
            }
        }
    }
}

struct SheetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SheetButtonView(title: "")
    }
}
