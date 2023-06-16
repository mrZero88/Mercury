//
//  StringSettingView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct StringSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Binding var value: String
    
    var body: some View {
        TextField("", text: $value)
            .lineLimit(1)
            .multilineTextAlignment(.trailing).lineLimit(1)
    }
}

struct StringSettingView_Previews: PreviewProvider {
    static var previews: some View {
        StringSettingView(value: .constant(""))
    }
}
