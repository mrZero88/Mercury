//
//  IconSearchPanelView.swift
//  SaturnX
//
//  Created by Daniel Correia on 23.03.23.
//

import SwiftUI
import Utils

struct IconSearchPanelView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Binding var iconName: String
    @State var iconModels: [IconModel] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: BorderPadding) {
                ForEach(getAllIcons().chunked(into: IconsPerRow), id: \.self) { iconsChunk in
                    ForEach(iconsChunk, id: \.self) { icon in
                        Image(icon).resizable().scaledToFit().frame(maxWidth: .infinity).padding().foregroundColor(ColorUtils.getColor(colorScheme: colorScheme, colorName: "appWhite")).drawingGroup()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(PanelColor)
        .cornerRadius(CornerRadius)
    }
    
    func setIcon(fileName: String) {
        self.iconName = fileName
        PlaySound(sound: .navigation)
        PlayHaptic()
        dismiss()
    }
    
    func filterByTranslationStartsWith(iconModel: IconModel, text: String) -> Bool {
        let lowerCasedText = text.lowercased()
        for translation in iconModel.translations {
            if(translation.languageCode.contains(Locale.current.language.languageCode?.identifier ?? "")) {
                for key in translation.translation.split(separator: "_") {
                    if(key.starts(with: lowerCasedText)) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func filterByTranslationEqual(iconModel: IconModel, text: String) -> Bool {
        let lowerCasedText = text.lowercased()
        for translation in iconModel.translations {
            if(translation.languageCode.contains(Locale.current.language.languageCode?.identifier ?? "")) {
                for key in translation.translation.split(separator: "_") {
                    if(key.lowercased() == lowerCasedText) {
                        return true
                    }
                }
            }
        }
        return false
    }
}

struct IconSearchPanelView_Previews: PreviewProvider {
    static var previews: some View {
        IconSearchPanelView(iconName: .constant(""))
    }
}
