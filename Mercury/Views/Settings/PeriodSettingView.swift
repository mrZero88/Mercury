//
//  PeriodSettingView.swift
//  Saturn
//
//  Created by Daniel Correia on 21.06.23.
//

import SwiftUI

struct PeriodSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    var title: String
    @Binding var selectedPeriod: Period
    var enabled: Bool
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        HStack {
            Menu {
                ForEach(Config.periods) { period in
                    Button {
                        selectedPeriod = period
                        PlaySound(sound: .navigation)
                        PlayHaptic()
                    } label: {
                        Label(period.description, systemImage: "").labelStyle(.titleOnly)
                    }
                }
            } label: {
                Label(selectedPeriod.description, systemImage: "").labelStyle(.titleOnly).frame(maxWidth: .infinity)
            }
            .tint(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
        }
        .buttonStyle(.borderedProminent)
        .disabled(!enabled)
    }
}

struct PeriodSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodSettingView(title: "", selectedPeriod: .constant(Period(id: 1, description: "", period: .day)), enabled: true)
    }
}
