//
//  DateSettingView.swift
//  Venus
//
//  Created by Daniel Correia on 09.08.22.
//

import SwiftUI

struct DateSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Binding var value: Date?
    
    var body: some View {
        if(value != nil) {
            Text(DateUtils.formatDate(from: value!, dateStyle: .short, timeStyle: .none)).lineLimit(1)
        }
    }
}

struct DateSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DateSettingView(value: .constant(Date()))
    }
}
