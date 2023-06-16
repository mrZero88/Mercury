//
//  OnboardingPage2View.swift
//  Venus
//
//  Created by Daniel Correia on 02.02.23.
//

import SwiftUI
import AVKit

struct OnboardingPage2View: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var tabSelection: Int
    
    var body: some View {
        Grid(alignment: .top, horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                VStack {
                    Text("Create and delete Boards").font(.title)
                        .padding()
                    Divider()
                    VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "createDeleteBoard", withExtension: "mov")!))
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
    
    func previous() {
        tabSelection = 1
    }
    
    func next() {
        tabSelection = 3
    }
}

struct OnboardingPage2View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage2View(tabSelection: .constant(3))
    }
}
