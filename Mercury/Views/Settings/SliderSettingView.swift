//
//  SliderSettingView.swift
//  Saturn
//
//  Created by Daniel Correia on 07.03.23.
//

import SwiftUI

struct SliderSettingView: View {
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    var title: String
    @Binding var value: Double
    var min: Double
    var max: Double
    var enabled: Bool
    
    var numberFormatter: NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 1
            return formatter
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title + ": ")
                Text("\(value, specifier: "%.2f")")
            }
            Slider(value: $value, in: min...max, step: 0.01)
        }
        .disabled(!enabled)
    }
}

struct SliderSettingView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSettingView(title: "", value: .constant(0.0), min: 0.0, max: 1.0, enabled: true)
    }
}
