//
//  ColorSettingView.swift
//  Venus
//
//  Created by Daniel Correia on 22.09.22.
//

import SwiftUI

struct ColorSettingView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var settingsChangedTrigger: SettingsChangedTrigger
    @Binding var value: String
    var lineWidth: CGFloat = 4
    
    var colorBlackWhite: Color {
        get {
            if(value == "Black") {
                return Color("White")
            } else if(value == "White") {
                return Color("Black")
            } else {
                return .clear
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Circle().strokeBorder(value == "Pink" ? Color.primary : .clear, lineWidth: lineWidth).background(Circle().fill(Color("Pink"))).onTapGesture {
                    value = "Pink"
                    PlaySound(sound: .confirm)
                }
                Circle().strokeBorder(value == "Purple" ? Color.primary : .clear, lineWidth: lineWidth).background(Circle().fill(Color("Purple"))).onTapGesture {
                    value = "Purple"
                    PlaySound(sound: .confirm)
                }
                Circle().strokeBorder(value == "Orange" ? Color.primary : .clear, lineWidth: lineWidth).background(Circle().fill(Color("Orange"))).onTapGesture {
                    value = "Orange"
                    PlaySound(sound: .confirm)
                }
                Circle().strokeBorder(value == "Yellow" ? Color.primary : .clear, lineWidth: lineWidth).background(Circle().fill(Color("Yellow"))).onTapGesture {
                    value = "Yellow"
                    PlaySound(sound: .confirm)
                }
            }
            .frame(height: 50)
            HStack {
                Circle().strokeBorder(value == "Red" ? Color.primary : .clear, lineWidth: lineWidth).background(Circle().fill(Color("Red"))).onTapGesture {
                    value = "Red"
                    PlaySound(sound: .confirm)
                }
                Circle().strokeBorder(value == "Cyan" ? Color.primary : .clear, lineWidth: lineWidth).background(Circle().fill(Color("Cyan"))).onTapGesture {
                    value = "Cyan"
                    PlaySound(sound: .confirm)
                }
                Circle().strokeBorder(colorBlackWhite, lineWidth: lineWidth).background(Circle().fill(colorScheme == .dark ? Color("White") : Color("Black"))).onTapGesture {
                    value = colorScheme == .dark ? "White" : "Black"
                    PlaySound(sound: .confirm)
                }
                Circle().strokeBorder(value == "Green" ? Color.primary : .clear, lineWidth: lineWidth).background(Circle().fill(Color("Green"))).onTapGesture {
                    value = "Green"
                    PlaySound(sound: .confirm)
                }
            }
            .frame(height: 50)
        }
    }
}

struct ColorSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSettingView(value: .constant(""))
    }
}
