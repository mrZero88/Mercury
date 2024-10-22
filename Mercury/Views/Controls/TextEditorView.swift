//
//  TextEditorView.swift
//  Venus
//
//  Created by Daniel Correia on 06.08.22.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding?
    
    var body: some View {
        VStack(alignment: .leading) {
            if(isFocused != nil) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .lineLimit(3)
                    .focused(isFocused!)
            } else {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .lineLimit(3)
            }
        }
        .padding()
        .background(PanelColor)
        .cornerRadius(CornerRadius)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(text: .constant(""))
    }
}
