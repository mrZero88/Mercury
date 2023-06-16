//
//  TextEditorView.swift
//  Venus
//
//  Created by Daniel Correia on 06.08.22.
//

import SwiftUI

struct TextEditorView: View {
    var inSheet: Bool = false
    @Binding var text: String
    
    var background: Color {
        get {
            return inSheet && !ShowBg1 && !ShowBg2 ? Color("Black") : PanelColor
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .lineLimit(3)
        }
        .padding()
        .background(background)
        .cornerRadius(CornerRadius)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(text: .constant(""))
    }
}
