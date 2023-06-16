//
//  TextFieldIconView.swift
//  Venus
//
//  Created by Daniel Correia on 08.08.22.
//

import SwiftUI

struct TextFieldIconView: View {
    var inSheet: Bool = false
    @Binding var textValue: String
    @Binding var iconValue: String
    var help: String? = ""
    var visible: Bool = true
    var textLimit: Int = 0
    
    var background: Color {
        get {
            return inSheet && !ShowBg1 && !ShowBg2 ? Color("Black") : PanelColor
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    ZStack {
                        TextField(help ?? "", text: $textValue).opacity(visible ? 1 : 0)
                            .onReceive(textValue.publisher) { _ in
                                limitText(textLimit)
                            }
                        Toggle("", isOn: .constant(false)).opacity(0)
                    }
                    .padding()
                    .background(background)
                    .cornerRadius(CornerRadius)
                    IconFieldView(inSheet: inSheet, iconName: $iconValue)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    func limitText(_ upper: Int) {
        if(upper != 0) {
            if textValue.count > upper {
                textValue = String(textValue.prefix(upper))
            }
        }
    }
}

struct TextFieldIconView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldIconView(textValue: .constant(""), iconValue: .constant(""))
    }
}
