//
//  UUIDSettingView.swift
//  Venus
//
//  Created by Daniel Correia on 25.01.23.
//

import SwiftUI

struct UUIDSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    var value: String
    
    var body: some View {
        Text(value).lineLimit(1)
    }
}

struct UUIDSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UUIDSettingView(value: "")
    }
}
