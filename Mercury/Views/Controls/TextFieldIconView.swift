//
//  TextFieldIconView.swift
//  Venus
//
//  Created by Daniel Correia on 08.08.22.
//

import SwiftUI
import CoreData

struct TextFieldIconView: View {
    @Binding var textValue: String
    @Binding var iconValue: String
    var help: String? = ""
    var visible: Bool = true
    var textLimit: Int = 0
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "showBorder")
    ) var showBorder: FetchedResults<Setting>
    
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
                    .overlay((showBorder.first?.boolValue ?? false) ? RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.accentColor, lineWidth: 1): RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.clear, lineWidth: 0))
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
