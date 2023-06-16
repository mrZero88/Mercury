//
//  IntSettingView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct IntSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Binding var value: Int64
    
    var body: some View {
        Text(String(value)).lineLimit(1)
    }
}

struct IntSettingView_Previews: PreviewProvider {
    static var previews: some View {
        IntSettingView(value: .constant(0))
    }
}
