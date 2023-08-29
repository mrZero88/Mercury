//
//  JsonDocument.swift
//  Alien
//
//  Created by Daniel Correia on 21.07.23.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers

struct JsonDocument: FileDocument {
    
    static public var readableContentTypes: [UTType] = [.json]
    
    var data: Data
    
    init(_ data: Data) {
        self.data = data
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            self.data = data
        }
        self.data = Data()
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        //let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
    
}
