//
//  IconModel.swift
//  SaturnX
//
//  Created by Daniel Correia on 05.05.24.
//

import Foundation

public struct IconModelTranslation {
    var languageCode: String = ""
    var translation: String = ""
}

public class IconModel: Equatable, Identifiable, Hashable {
    
    public static func == (lhs: IconModel, rhs: IconModel) -> Bool {
        lhs.fileName == rhs.fileName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(fileName)
    }
    
    public var id = UUID()
    @Published var fileName: String = ""
    @Published var translations: [IconModelTranslation] = []
    
    /**
        Translations are added by language code alphabetically. Excluding the default en language.
     */
    init(fileName: String, translations: String...) {
        self.fileName = fileName
        var languageCodes = Bundle.main.localizations
        languageCodes = languageCodes.sorted { $0.lowercased() < $1.lowercased() }
        if(languageCodes.count == translations.count) {
            var i = 0
            for translation in translations {
                self.translations.append(IconModelTranslation(languageCode: languageCodes[i], translation: translation))
                i += 1
            }
        }
    }
}
