//
//  OnboardingPage1View.swift
//  Venus
//
//  Created by Daniel Correia on 02.02.23.
//

import SwiftUI
import AVKit

struct OnboardingPage1View: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var tabSelection: Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Grid(alignment: .top, horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                VStack {
                    Text("Welcome").font(.title)
                        .padding()
                    Divider()
                    Text("Welcome to Alien, your simple kanban board.").font(.title2).frame(maxWidth: .infinity, alignment: .topLeading).multilineTextAlignment(.leading)
                        .padding()
                    Text("Here you can plan your tasks and move them around the phases you customize. By default there are 4 phases (Planned, In Work, In Review and Finished), but you can rename them and add/remove phases as you want to a minimum of 2 and a maximum of 8.").frame(maxWidth: .infinity, alignment: .topLeading).multilineTextAlignment(.leading)
                        .padding()
                    Text("In the below textfield please enter your name so that we can refer to you when needed (You can always change it in the settings later). In the next slides you will see a simple tutorial around the possible actions you can do here in Alien.").frame(maxWidth: .infinity, alignment: .topLeading).multilineTextAlignment(.leading)
                        .padding()
                    Text("In the settings you can give a different look to the app like changing the color or enabling sounds, as well as changing the wallpapers.").frame(maxWidth: .infinity, alignment: .topLeading).multilineTextAlignment(.leading)
                        .padding()
                    Spacer()
                }
                .background(PanelColor)
                .cornerRadius(CornerRadius)
            }
            Divider()
            GridRow {
                TextFieldView(inSheet: false, textValue: Binding<String> (
                    get: {
                        return UserName
                    },
                    set: {
                        viewModel.settingsViewModel.settingsController.setUserName(userName: $0)
                    }
                ), help: "Enter your name...", textLimit: UserValidation.nameMaxChars)
            }
            Divider()
            GridRow {
                HStack {
                    SheetButtonView(inSheet: false, title: "Skip", clickFunction: skip)
                    SheetButtonView(inSheet: false, title: "Next", clickFunction: next)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.bottom)
            .padding(.bottom)
            .padding(.bottom)
        }
        .padding()
    }
    
    func skip() {
        viewModel.usersController.boardUserIn()
        dismiss()
    }
    
    func next() {
        tabSelection = 2
    }
}

struct OnboardingPage1View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage1View(tabSelection: .constant(2))
    }
}
