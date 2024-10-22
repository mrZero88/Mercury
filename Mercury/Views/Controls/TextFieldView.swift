//
//  TextFieldView.swift
//  Alien
//
//  Created by Daniel Correia on 18.02.23.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var textValue: String
    var help: String? = ""
    var visible: Bool = true
    var textLimit: Int = 0
    var isFocused: FocusState<Bool>.Binding?
    var background = PanelColor
    
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    if(isFocused != nil) {
                        TextField(String(localized: String.LocalizationValue(help ?? "")), text: $textValue).opacity(visible ? 1 : 0)
                            .onReceive(textValue.publisher) { _ in
                                limitText(textLimit)
                            }
                            .focused(isFocused!)
                    } else {
                        TextField(String(localized: String.LocalizationValue(help ?? "")), text: $textValue).opacity(visible ? 1 : 0)
                            .onReceive(textValue.publisher) { _ in
                                limitText(textLimit)
                            }
                    }
                    Toggle("", isOn: .constant(false)).opacity(0)
                }
                .padding()
                .background(background)
                .cornerRadius(CornerRadius)
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

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(textValue: .constant(""))
    }
}
