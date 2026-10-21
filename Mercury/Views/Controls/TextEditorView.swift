//
//  TextEditorView.swift
//  Venus
//
//  Created by Daniel Correia on 06.08.22.
//

import SwiftUI
import CoreData

struct TextEditorView: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding?
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "showBorder")
    ) var showBorder: FetchedResults<Setting>
    
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
        .overlay((showBorder.first?.boolValue ?? false) ? RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.accentColor, lineWidth: 1): RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.clear, lineWidth: 0))
        .cornerRadius(CornerRadius)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(text: .constant(""))
    }
}
