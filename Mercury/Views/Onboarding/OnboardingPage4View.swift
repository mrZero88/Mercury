//
//  OnboardingPage4View.swift
//  Alien
//
//  Created by Daniel Correia on 29.04.23.
//

import SwiftUI
import AVKit

struct OnboardingPage4View: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var tabSelection: Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Grid(alignment: .top, horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                VStack {
                    Text("Create, move and delete Tasks").font(.title)
                        .padding()
                    Divider()
                    VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "createMoveDeleteTask", withExtension: "mov")!))
                        .cornerRadius(CornerRadius)
                        .frame(height: 400)
                        .padding()
                    Spacer()
                }
                .background(PanelColor)
                .cornerRadius(CornerRadius)
            }
            GridRow {
                HStack {
                    SheetButtonView(inSheet: false, title: "Previous", clickFunction: previous)
                    SheetButtonView(inSheet: false, title: "Finish", clickFunction: finish)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.bottom)
            .padding(.bottom)
            .padding(.bottom)
        }
        .padding()
    }
    
    func previous() {
        tabSelection = 3
    }
    
    func finish() {
        viewModel.usersController.boardUserIn()
        dismiss()
    }
}

struct OnboardingPage4View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage4View(tabSelection: .constant(5))
    }
}
