//
//  TextFieldIconView.swift
//  Venus
//
//  Created by Daniel Correia on 08.08.22.
//

import SwiftUI

struct TextFieldIconView: View {
    @Binding var textValue: String
    @Binding var iconValue: String
    var help: String? = ""
    var visible: Bool = true
    var textLimit: Int = 0
    
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
                    .background(PanelColor)
                    .cornerRadius(CornerRadius)
                    IconFieldView(iconName: $iconValue)
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
