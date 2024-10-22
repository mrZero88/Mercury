//
//  OnboardingPage3View.swift
//  Venus
//
//  Created by Daniel Correia on 02.02.23.
//

import SwiftUI
import AVKit

struct OnboardingPage3View: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var tabSelection: Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Grid(alignment: .top, horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                VStack {
                    Text("Create and delete Phases").font(.title)
                        .padding()
                    Divider()
                    VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "createDeletePhase", withExtension: "mov")!))
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
                    SheetButtonView(title: "Previous", clickFunction: previous)
                    SheetButtonView(title: "Next", clickFunction: next)
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
        tabSelection = 2
    }
    
    func next() {
        tabSelection = 4
    }
}

struct OnboardingPage3View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage3View(tabSelection: .constant(4))
    }
}
