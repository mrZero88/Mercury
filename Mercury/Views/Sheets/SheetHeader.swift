//
//  SheetHeader.swift
//  SaturnX
//
//  Created by Daniel Correia on 07.12.23.
//

import SwiftUI

struct SheetHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(String(localized: String.LocalizationValue(title))).font(.footnote)
            Spacer()
        }
    }
}

#Preview {
    SheetHeader(title: "")
}
